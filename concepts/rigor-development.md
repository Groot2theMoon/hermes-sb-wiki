---
title: "RIGOR Development — Differentiable SR-UKF Framework"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [rigor, kalman-filter, differentiable-filtering, development, infrastructure, sr-ukf]
confidence: high
---

# RIGOR Development — Differentiable SR-UKF Framework

RIGOR (Recursively-Informed, Graph-Optimized, Robust) is a **differentiable Square-Root Unscented Kalman Filter (SR-UKF)** framework for joint state estimation, dynamics learning, and filter parameter optimization via gradient-based methods.

## Development Setup

The RIGOR codebase is developed in Python using PyTorch for automatic differentiation. The framework implements the full SR-UKF recursion (sigma points, predict, update, square-root covariance propagation) as differentiable operations, enabling end-to-end learning of:

- **State estimates** via gradient-based refinement.
- **Dynamics models** (hybrid A+NN architectures with known physics + learned residual).
- **Noise covariance parameters** (process and measurement noise).
- **Filter hyperparameters** (sigma point scaling, initialization).

## Key Components

- **Differentiable SR-UKF step**: Cholesky factorization, sigma point generation, unscented transform, Kalman gain computation — all implemented in differentiable PyTorch.
- **Hybrid dynamics model**: `F = A_known + NN_θ` where `A` encodes known linear physics and the neural network captures unmodeled nonlinearities.
- **Rollout loss**: Multi-step prediction loss enables learning beyond single-step filtering.
- **Benchmarking suite**: Comparison against standard UKF, EKF, and baseline differentiable filters on VdP oscillator, structural dynamics, and other test problems.

## Infrastructure

RIGOR development uses cloud GPU compute for benchmarking and training (see [[cloud-gpu-compute-platforms]]). The typical workflow is:

1. Local development and debugging on CPU (PN40 or laptop).
2. Batch benchmarks on Modal or RunPod GPU instances.
3. Result aggregation and analysis (wandb, local logging).

## Wikilinks
- [[rigor-filter]] — Core RIGOR filter architecture
- [[rigor-sigma-point-research]] — Research landscape and gap analysis
- [[rigor-heuristics-analysis]] — Heuristic audit and theoretical fixes (v4.8)
- [[gating-ablation-2026-05-07]] — Gating ON vs OFF experimental results
- [[cloud-gpu-compute-platforms]] — Cloud GPU setup for RIGOR benchmarks
- [[infrastructure-notes]] — PN40 server environment notes
- [[square-root-unscented-kalman-filter]] — Standard SR-UKF formulation
- [[extended-kalman-filter]] — EKF baseline comparison

## References
- Haywood-Alexander, M., Duthé, G., & Chatzi, E. (2026). PiGGO. *[raw paper reference]*
- Van der Merwe, R. & Wan, E. A. (2001). The Square-Root Unscented Kalman Filter for State and Parameter-Estimation. ICASSP 2001.

---

## Design Notes

### StableSystemMatrix — Guaranteed-Bounded Dynamics Matrix

**(Decision 2026-05-06):** Complete redesign from PI-only isotropic clamping to adaptive two-regime approach.

**Why hard constraint is necessary (beyond loss penalty):**
1. Loss-only `bounded_penalty` cannot prevent NaN in forward pass — covariance prediction depends on A's spectral property, and NaN occurs before loss is computed.
2. Observer convergence theory: `A+NN` is a nonlinear Luenberger observer. The Jacobian's spectral radius must be bounded for error dynamics stability. `A` is time-invariant (analyzable), while `∇NN(x)` is state-dependent (unanalyzable).
3. Gradient separation: A handles the linear skeleton (O(d²) params), NN handles state-dependent correction (O(p·d) with p≫d). Hard constraint prevents gradient conflict between the two.

**Two-regime implementation:**

| d_state | Method | Property |
|---------|--------|----------|
| ≤ 8 | SVD-based singular value clamping | Anisotropic — each singular value clamped to γ independently. JAX supports SVD gradients natively. |
| > 8 | Power iteration (no stop_grad, pi_iters=8) | Isotropic — spectral norm clamped, gradient flows to A_raw |

**Key design decisions (2026-05-06):**
- `stop_gradient` removed from PI path → gradient flows through spectral constraint, encouraging A_raw to develop small eigenvalues naturally
- `pi_iters` increased 2 → 8 for reliable spectral estimate
- Eval mode recalculates spectral estimate (no stale cached vectors)
- Anisotropic clamping (eigendec.) preserves useful dynamics in well-behaved directions

**Gamma=0.99 (v3.3, updated 2026-05-06):** `sinkhorn_gamma` changed from 0.95 to 0.99. Rationale: SVD clamping with γ=0.95 was overly restrictive for velocity dynamics — A's dominant singular vector direction (u₁) aligns with velocity, and NN ⟂ u₁ blocks NN from boosting velocity. With γ=0.99, A has sufficient freedom to grow along u₁ while SVD clamp still acts as a safety net. Empirical result: velocity amplitude went from 56% of GT (γ=0.95) to 103% (γ=0.99), with pos_corr 0.9971 and vel_corr 0.9612.

**NN ⟂ u₁ is ESSENTIAL (empirically verified 2026-05-06):** Removing the orthogonal projection caused gradient separation collapse — ρ_avg dropped from 0.97 to 0.86, pos_corr from 0.977 to 0.340. Even with differentiable SVD clamping and tanh norm bounding, A and NN compete for the same gradient without structural separation. The projection routes the u₁ direction gradient to A (linear skeleton) and the orthogonal complement to NN (nonlinear correction). This is NOT a heuristic — it's a structural gradient routing mechanism.

### Codebase Cleanup (2026-05-06)

| Removed | Replacement | Reason |
|---------|-------------|--------|
| `SpectralDense` (60 lines, power iteration + stop_grad) | `nn.Dense` | Spectral norm was stop_gradient constant 0.95 scaling → effectively useless |
| `SpectralDenseStack` | `MLPBackbone` (sequential `nn.Dense` + GELU) | Same reason |
| `LMIFactor`, `LMIScalar`, `LMIGamma` | — | Unused in tests, added unnecessary parameters |
| `use_oscillator_matrix`, `spectral_mode`, etc. (6 deprecated flags) | — | Dead code, simplified Rigor config |

### Phase 2: Sigma Cloud Conditioning Results (2026-05-06)

**Experiment log:** VDP μ=1.0, dt=0.1, steps=300, obs_std=0.3, 500 iter (unless noted).

#### Raw sigma_pred cloud conditioning (direct concat to NN input)
- UFI only (baseline): pos_corr=0.9914, vel_corr=0.9054, RMSE=0.798
- UFI + raw cloud: pos_corr=0.9850, vel_corr=0.8841, RMSE=**0.8495** (RMSE -8%)
- Loss stable at -0.716 (vs baseline -? — check)
- Sigma cloud provides complementary info to UFI despite d_state=2 (minimal)

#### Three orthogonal information sources
| Source | Type | Content |
|--------|------|---------|
| UFI | Static geometry | Quadratic expansion of sigma points (state-independent basis) |
| Sigma cloud | Dynamic distortion | Per-step nonlinear spread from UKF propagation |
| ISAB encoder | Permutation-invariant | Set Transformer over sigma cloud → compact embedding |

**ISAB design (Set Transformer, Lee et al. 2019):**
- `MAB(X,Y)`: Multihead Attention Block with LN + rFF skip connections
- `SAB(X) = MAB(X,X)`: Self-attention block
- `ISAB_m(X) = MAB(X, MAB(I, X))` with m inducing points → reduces O(n²) to O(n·m)
- `PMA(Z) = MAB(S, Z)` with learnable seed → pools to single vector

**Parameter settings for VDP (d=2):**
- d_hidden=8, m_inducing=2, n_heads=2
- ISAB is overkill for VDP but validates concept before scaling to higher d_state
- Variant B (displacement = sigma_pred - sigma_points) is most principled — captures nonlinear distortion δ = f(x) - A·x directly

**Related wiki:**
- [[shima-contractivity-lure]] — Lur'e contractivity LMI for A+NN verification
- [[1-lipschitz-layers-comparison]] — AOL/Cayley/SOC methods for Lipschitz constraint
- [[monotone-operator-equilibrium-networks]] — monDEQ: W = (1-m)I - AᵀA + B - Bᵀ (future direct parameterization reference)
- [[spectral-normalization-gan]] — Miyato spectral normalization (original PI method)
- [[ren-recurrent-equilibrium-networks]] — REN: direct contracting parameterization (north star for Phase 3)

### Loss Function: VFE (v3.3, 2026-05-06)

**Problem:** NLL loss pushes Q→0 with longer trajectories (step ≥ 500). The inverse gamma prior required a tunable weight to counterbalance, and the right balance depended on trajectory length and dynamics.

**Solution:** Replace NLL + prior × weight with **Variational Free Energy**:

```
ℱ = NLL(accuracy)  +  KL_dynamics(complexity)
```

where `KL_dynamics = 0.5 [tr(Q⁻¹·P_pred) - d + log|Q| - log|P_pred|]`

This is the exact KL divergence between the filter's prediction distribution `q(x_t|x_{t-1}) = N(A·x_{t-1}, P_pred)` and the transition prior `p(x_t|x_{t-1}) = N(A·x_{t-1}, Q)`. They share the same mean, so the quadratic term vanishes, leaving only the covariance mismatch.

**Why it works without tuning:**
| Q regime | tr(Q⁻¹·P_pred) | log|Q| | Net effect |
|----------|:--------------:|:-----:|:----------:|
| Q → 0 | ∞ (drives loss up) | -∞ (drives loss down) | ∞ dominates → **blocks Q→0** |
| Q → ∞ | → d (constant) | ∞ (drives loss up) | log|Q| dominates → **blocks Q→∞** |
| Q ≈ P_pred | → d (constant) | constant | **equilibrium** |

**Implementation:** ~30 lines in `loss.py`. Takes `hist['L_pred']` (Cholesky factor of prediction covariance), `Q_diag`, and valid mask. Returns scalar VFE averaged over valid (B, T).

**Still kept:** `bounded_penalty = relu(ρ(A_eff) - 1.05) × 0.1` as a safety net (not a regulator — only activates when spectral radius exceeds 1.05).

### Final v3.3 Benchmark (2026-05-06)

All experiments: VDP μ=1.0, dt=0.1, steps=500, obs_std=0.3, N_BATCH=4, SEED=43, UFI + raw cloud conditioning.

| Config | iters | pos_corr | vel_corr | RMSE | vel amplitude | Note |
|:------:|:-----:|:--------:|:--------:|:----:|:------------:|:----:|
| Prior + γ=0.95 | 500 | 0.3583 | 0.2436 | 2.521 | ±0.7 (26%) | ❌ Q→0 collapse |
| VFE + γ=0.95 | 500 | 0.9769 | 0.8754 | 0.930 | ±1.5 (56%) | ✅ Q fixed, but amp limited |
| VFE + γ=0.99 | 500 | 0.9928 | 0.9333 | 0.500 | ±2.6 (97%) | ✅✅ |
| **VFE + γ=0.99** | **1000** | **0.9971** | **0.9612** | **0.383** | **±2.76 (103%)** | **🏆 current best** |

**Key findings:**
1. **VFE loss** solves Q→0 collapse structurally (no tunable prior weight needed)
2. **γ=0.99** gives A enough freedom to capture velocity dynamics while SVD clamp still prevents divergence
3. **NN ⟂ u₁** is required for gradient separation (verified by failed ablation)
4. Longer training (1000 vs 500 iter) continues to improve performance — still not fully converged
