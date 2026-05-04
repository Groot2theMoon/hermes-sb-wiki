# VDP Benchmark: v2_pi vs v3_bullo

## Experiment Setup
- **System:** Van der Pol oscillator (μ=1.0), dt=0.05, 1000 steps
- **Observation:** y_t = x1(t) + N(0, 1.0), d_out=1
- **State dimension:** d_state=2 (latent: x1, x2)
- **Config:** modulator_arch=(16,), state_loss_weight=1.0, use_joseph=True

| Parameter | v2_pi | v3_bullo |
|-----------|-------|----------|
| A matrix | StableSystemMatrix (PI + spectral clamp to γ=0.95) | BullloSystemMatrix (Bullo exact, ρ=0.95) |
| NN residual | DeltaModulator (SpectralDense, limit_factor=1.0) | DeltaModulatorV3 (BullloContractiveStack, ρ=0.95) |
| Activation | gelu | gelu |
| residual_scale | 0.0 (A-only) | 0.3 |
| LMI penalty | beta_lmi=1.0 (Shima Thm 4) | 0.0 (contractive by construction) |

## Results (1000 training steps)

### 300-step (previous benchmark)
| Mode | NLL | RMSE | Whiteness |
|------|:---:|:----:|:---------:|
| v2_pi | — | 1.52 | 12.47 |
| v3_bullo | — | 1.39 | 6.15 |

### 1000-step (current benchmark)
| Mode | NLL | RMSE | Whiteness | Time (s) |
|------|:---:|:----:|:---------:|:--------:|
| v2_pi (rollout=0) | **0.90** | **1.21** | **1.49** | 1338 |
| v3_bullo (rollout=0) | 2.47 | 1.42 | 3.57 | 1194 |

### Effect of Rollout Loss on v3_bullo
| Rollout Type | weight | RMSE | Whiteness |
|-------------|:------:|:----:|:---------:|
| None | 0 | 1.42 | 3.56 |
| Open-loop (full, mu0 start) | 0.1 | 1.42 | 3.56 |
| Multi-segment K=8, ~50 segments | 0.1 | 1.42 | 3.57 |

## Key Findings

1. **v2_pi outperforms v3_bullo on VDP** when rollout loss is disabled (A^k rollout was actively harmful).
2. **A^k rollout loss artificially damaged v2_pi** — linear A^k can't represent VDP nonlinear dynamics, causing multi-step gradient conflict.
3. **Rollout losses have zero effect on v3_bullo** — VDP limit cycle is already well-captured by UKF one-step NLL. The nonlinear A+NN dynamics don't benefit from multi-step constraints because the UKF already corrects state estimates.
4. **Rollout ≠ identifiability** — multi-step loss doesn't resolve `d_out < d_state` ambiguity. This requires structural constraints (canonical form, physical parameterization).

## Lorenz 500-step Results

| Mode | NLL | RMSE | Whiteness | Time (s) |
|------|:---:|:----:|:---------:|:--------:|
| v2_pi | 54.53 | 15.56 | 70.9 | 614 |
| v3_bullo | **25.92** | 16.17 | 135.6 | 554 |

**Lorenz (chaotic)에서는 v3_bullo의 NLL이 2배 더 좋음.** 이유:
- v3_bullo의 hard contraction이 model mismatch를 covariance로 적절히 반영 → better calibration
- v2_pi는 overconfident → chaotic에서 잘못된 확신으로 NLL 폭발
- RMSE는 비슷 (추정 정확도 유사, calibration 차이)

## System-dependent Trade-off

| System | Type | Winner | Key Metric |
|:------|:----:|:------:|:----------:|
| Damped oscillator | linear stable | **v3_bullo** | RMSE 0.57 vs 0.79 |
| VDP | oscillatory, limit cycle | **v2_pi** | RMSE 1.21 vs 1.42 |
| Lorenz | chaotic | **v3_bullo** | NLL 25.9 vs 54.5 |

Neither model dominates universally — the choice depends on system characteristics.

## Robustness Benchmark (v3.1, damped oscillator)

True EM (frozen Q,R in gradient, EM from RTS smoother every 10 steps) + learnable σ,ρ.

### 1+2: Impulse Noise + Recovery Speed

Single spike (5x/10x/20x obs_std) at damped oscillator trajectory midpoint (250/500).

| Metric | v2_pi (gradient Q) | **v3_bullo (True EM)** |
|:-------|:------------------:|:----------------------:|
| RMSE (spike_5x) | 1.83 | **0.40** |
| RMSE (spike_10x) | 1.84 | **0.40** |
| RMSE (spike_20x) | 1.83 | **0.40** |
| Whiteness (spike_5x) | 21.7 | **1.87** |
| Recovery steps (all) | 18-20 | **0** (instant) |
| Post-spike error peak | 1.6-1.9 | **0.21** |

### 3: Non-stationary Observation Noise (R-change)

Observation noise covariance R doubles/quintuples at t=250.

| Metric | v2_pi (gradient Q) | **v3_bullo (True EM)** |
|:-------|:------------------:|:----------------------:|
| RMSE (R×2) | 1.82 | **0.40** |
| NLL (R×2) | 11.1 | **0.92** |
| RMSE_pre (R×5) | 2.54 | 0.56 |
| RMSE_post (R×5) | 0.48 | **0.07** |

### Interpretation

v3_bullo's formal contractivity guarantee shows clear empirical advantage under noise stress:
- **Always-contracting A** prevents outlier-driven state divergence — spike energy decays exponentially
- **True EM** adapts Q,R in real-time via RTS smoother — no slow gradient descent for noise covariance

This is the key result: Bullo guarantees translate to **demonstrably superior robustness** in scenarios relevant to real-world filtering (sensor dropout, changing noise conditions).
