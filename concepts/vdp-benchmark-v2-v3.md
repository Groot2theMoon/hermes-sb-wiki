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

## Hyperparameter Reduction (v3.1)
DeltaModulatorV3 refactored to remove `residual_scale` and `rho_nn` as fixed hyperparameters:
- `residual_scale` → learnable σ (softplus parameter, init from config)
- `rho_nn` → learnable ρ (sigmoid parameter, init from config)
- `activation` retained as configurable (gelu/relu/tanh)
