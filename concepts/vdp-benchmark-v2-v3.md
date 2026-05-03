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

## Interpretation
For VDP (oscillatory, non-chaotic), the UKF one-step NLL + state_loss provides sufficient training signal. The dynamics identifiability issue (A off-diagonal sign ambiguity) persists regardless of rollout, and can only be resolved by (a) more observation channels, (b) physical canonical form, or (c) SOLIS cyclic curriculum for chaotic systems.
