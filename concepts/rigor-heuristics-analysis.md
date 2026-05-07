---
title: "RIGOR Heuristic Analysis — Empirical Gaps & Theoretical Fixes"
created: 2026-05-07
updated: 2026-05-07
type: concept
tags: [rigor, heuristics, theoretical-analysis, architecture, v4.8]
confidence: high
---

# RIGOR Heuristic Analysis — Empirical Gaps & Theoretical Fixes

An audit of heuristic/atheoretical components in the RIGOR codebase (v3.3/v4.8), with literature-backed solutions and implementation priorities.

## Overview

RIGOR uses several hand-tuned constants and structural choices without theoretical justification. This page documents each, analyzes why they exist, and proposes literature-backed replacements.

**Audit date:** 2026-05-07

---

## 1. Tanh Norm Bounding — Double Gradient Saturation

**Location:** `nn.py`, `DeltaModulator.__call__`

```python
res_norm = jnp.sqrt(jnp.sum(jnp.square(res_structure), axis=-1, keepdims=True) + eps_sq)
res_bounded = res_structure * (jnp.tanh(res_norm) / (jnp.norm + eps))
```

**Problem:** Cascades two saturation mechanisms:
- Inner `tanh(norm)` saturates exponentially at `||res|| > 3` (gradient ≈ 0.0009 at ||res||=5)
- Outer `residual_scale=0.3` compresses output range to `[-0.3, 0.3]`
- Gradient flow is doubly attenuated — NN cannot learn to produce large residual spikes needed for sharp transitions (e.g., VDP relaxation oscillation)

**References:**
- Bergstra et al. (2011). "Algorithms for Hyper-Parameter Optimization" — Softsign: `x / (1+|x|)`
- LeCun et al. (1998). "Efficient BackProp" — Scaled tanh: `1.7159·tanh(2x/3)`
- Zhu et al. (2024). "Transformers without Normalization" (DyT) — Learnable `tanh(α·x)`

**Proposed solution:** Replace with **softsign norm scaling**:

```python
# Softsign: x / (1 + |x|) — vectorized
res_bounded = res_structure / (1.0 + res_norm + eps)
```

Properties:
- Bounded output in [-1, 1] (same as tanh)
- Polynomially-decaying gradient: `1/(1+||res||)²` — no saturation cliff
- Gradient at ||res||=5: 0.028 vs tanh's 0.0009 (30× better)
- No exponential operations

**Priority:** Medium. Double saturation degrades VDP velocity amplitude recovery, but residual_scale change has bigger impact.

---

## 2. Fixed residual_scale — Should Be Learnable

**Location:** `nn.py` L283, `config.py` L45

```python
return res_scale * res_bounded  # res_scale = 0.3, hardcoded
```

**Problem:** The optimal NN contribution to `A·x + NN(x)` dynamics is system-dependent:
- VDP μ=1.0: `residual_scale=0.3` was tuned empirically
- Higher μ values or different systems may need different scales
- Fixed scale interacts with `NN ⟂ u₁` projection — if u₁ direction needs more NN boost, a frozen scale blocks it

**References:**
- Behrmann et al. (2019). "Invertible Residual Networks" — Per-layer Lipschitz coefficient `c ∈ (0,1)` as learnable parameter, guarantees `Lip(NN) < c < 1`
- Salimans & Kingma (2016). "Weight Normalization" — Learnable scalar `g` decoupled from weight direction
- Miyato et al. (2018). "Spectral Normalization for GANs" — Learnable coefficient on spectrally-normalized layers
- **Levenberg-Marquardt connection:** The learnable `c` acts as adaptive damping factor `λ` — small `c` = heavy damping (trust A more), large `c` = light damping (let NN contribute more)

**Proposed solution:** Replace fixed `residual_scale` with learnable coefficient:

```python
# In DeltaModulator.__init__:
self.residual_coeff_raw = self.param('residual_coeff', ...)
# In forward:
c = jax.nn.sigmoid(self.residual_coeff_raw)  # guaranteed c ∈ (0, 1)
# Option: c = 0.99 * jax.nn.sigmoid(...)  # guaranteed c ∈ (0, 0.99)
return c * res_bounded  # ← learnable, replaces fixed 0.3
```

Combine with **spectral normalization** on NN weights to guarantee `Lip(c·NN) ≤ c < 1`.

**Priority:** High. Single most impactful change — lets optimizer decide NN vs A balance.

---

## 3. Frozen u₁ — Doesn't Track Evolving A

**Location:** `filter.py` L678-688

```python
# Power iteration at init only
u_pi = A[:, 0]
for _ in range(8):
    v_pi = A.T @ u_pi; v_pi = v_pi / (jnp.linalg.norm(v_pi) + eps)
    u_pi = A @ v_pi; u_pi = u_pi / (jnp.linalg.norm(u_pi) + eps)
u_1 = jax.lax.stop_gradient(u_pi)  # ← frozen: A changes, u₁ doesn't
```

**Problem:** `A` is learned via gradient descent. Its dominant singular vector u₁ changes during training, but the orthogonal projection `NN ⟂ u₁` uses the frozen initial u₁. This means:
- The gradient separation guarantee degrades over time
- A and NN may start competing for the same gradient components
- The projection becomes increasingly misaligned with A's actual structure

**References:**
- Miyato et al. (2018) — Power iteration per training step: 1 iteration, maintain running estimate of u
- Standard practice in spectral normalization: u vector as running average, not frozen
- Gouk et al. (2018) — Power iteration computationally negligible (O(n²), a few matmuls)
- Power iteration is fully differentiable through A — no need for stop_gradient

**Proposed solution:** **Online differentiable power iteration:**

```python
# In RigorCell.__call__ (each forward pass):
# Single power iteration step, differentiable through A
v = A.T @ u_1
v = v / (jnp.linalg.norm(v) + eps_arith)
u_new = A @ v
sigma = jnp.linalg.norm(u_new)  # spectral norm estimate
u_new = u_new / (sigma + eps_arith)
# Use u_new for projection (differentiable through A)
# Maintain running estimate via EMA for next step
```

Cost: 2 matmuls per cell call (negligible vs UKF's O(n³) Cholesky).

**Priority:** High. Fixes a structural bug at negligible cost.

---

## 4. bounded_penalty Hyperparameters — Pure Heuristic

**Location:** `tests/test_rawcloud_500_1k.py` L94

```python
bounded_penalty = jnp.mean(jax.nn.relu(rho_seq - 1.05)) * 0.1
```

**Problem:** Both constants are hand-tuned:
- **1.05:** Why not 1.0? Why not 1.1? The theoretical spectral stability boundary is `ρ < 1`. The margin exists to prevent chattering but has no principled basis.
- **0.1:** Penalty weight relative to VFE loss. This balance changes with trajectory length, noise level, and dynamics — the same 0.1 is used for all experiments.

**References:**
- Richards et al. (2018). "Lyapunov Neural Networks" — Lagrangian relaxation: learnable `λ` via dual variable update
- Coelho et al. (2023). "Self-Adaptive Penalty for Neural ODEs" — `λ ← λ + η·violation` adaptive update
- Basir & Senocak (2023). "Adaptive Augmented Lagrangian" — Lagrange multiplier updated via dual ascent, penalty increased only when primal progress stalls
- McClenny & Braga-Neto (2020). "Self-Adaptive PINNs" — Per-constraint learnable weight `λ_i` via gradient ascent on residual

**Proposed solution:** **Adaptive penalty (augmented Lagrangian):**

```python
# Learnable parameters
penalty_log_weight = self.param('penalty_log_weight', ...)  # log(λ)
threshold_log_margin = self.param('threshold_margin', ...)

def bounded_penalty(rho_seq):
    threshold = 1.0 + jax.nn.softplus(threshold_log_margin)  # > 1.0
    violation = jax.nn.relu(rho_seq - threshold)
    weight = jnp.exp(penalty_log_weight)  # λ = exp(param), always > 0
    return weight * jnp.mean(violation)
```

**Alternative (simpler):** Anneal threshold from 1.1 → 1.0 over training, with fixed weight.

**Priority:** Medium. The penalty only activates when `ρ > 1.05`, which is rare after convergence. Impact on final benchmark results is minimal.

---

## 5. UKF Parameters (α, β, κ) — Not Validated for Augmented State

**Location:** `config.py` (defaults), all test files

```python
alpha=1.0, beta=2.0, kappa=0.0
```

**Problem:** These parameters optimize sigma point placement for the original Phil Chen filter. In RIGOR:
- When KKL observer augments state (d_z > 0), the augmented dynamics have different nonlinearity structure
- `α=1.0` provides no sigma point contraction — Wan & van der Merwe recommend `α ≈ 10^{-3}` for strongly nonlinear systems
- Higher-dimensional sigma point clouds (d_state ≥ 4) may need different α

**References:**
- Wan & van der Merwe (2000) — α ∈ (0,1], smaller α for stronger nonlinearity. **α=1.0 is the least recommended value for nonlinear systems.**
- Julier & Uhlmann (2004) — α < 1 essential for higher-order moment capture in nonlinear systems
- Levy & Klein (2026, arXiv:2604.04792) — Multi-Scaled UKF: per-state α improves RMSE by 17%
- Majewski et al. (2026, arXiv:2603.04360) — Robust UKF via meta-adapted sigma weights

**Proposed solution:**

**Phase 1 (immediate):** Grid search α ∈ {0.01, 0.1, 0.5, 1.0} on VDP benchmark.
**Phase 2 (future):** Multi-scaled α per state group for KKL-augmented systems.

```python
# Multi-scaled alpha for KKL
alpha_phys = learnable  # (0, 1) for physical state
alpha_kkl = learnable   # (0, 1) for KKL augmented state
# Sigma point scaling per dimension group
```

**Priority:** Medium. No evidence this currently limits VDP performance, but critical for KKL extensions and higher-dimensional systems.

---

## 6. Statistical Gating — Redundant with Sufficient Training

**Location:** `filter.py` L280-320

```python
alpha_s = clip(1.0 + 0.5 * w_violation * log(S_emp / S_theo), 0.1, 10.0)
Q_scaled = Q * sqrt(alpha_s)
L_pred = recompute_cholesky(dev_pred, Q_scaled)
```

**Problem (established 2026-05-07 ablation):**
- 0.5, log(), 0.1/10.0 clamp thresholds — all pure heuristic
- With 1000 iters: gating OFF achieves RMSE 0.3892 vs gating ON 0.3834 (+1.5% — negligible)
- Role: early training stabilizer only (500 iter: +19% RMSE benefit)
- Adds L_pred recomputation cost and gradient noise

**Status:** Retained as config option (`use_statistical_gating: bool`), but **recommended OFF for production training with sufficient iterations** (≥1000). No theoretical fix needed — it's simply unnecessary with adequate training.

**References:** See [[gating-ablation-2026-05-07]] for full experimental results.

**Priority:** Low. Already identified as unnecessary, config flag provides clean toggle.

---

## Implementation Priority Matrix

| Item | Impact | Effort | Risk | Priority |
|------|--------|--------|------|----------|
| **Learnable residual_scale** | High | Low | Low | **1** |
| **Online u₁ update** | High | Low | Low | **2** |
| **Softsign norm bounding** | Medium | Low | Low | **3** |
| **Adaptive bounded_penalty** | Medium | Medium | Low | **4** |
| **UKF α grid search** | Medium | Medium | Low | **5** |
| **Statistical gating removal** | Low (config exists) | Done | None | — |

---

## Wikilinks
- [[rigor-development]] — Main RIGOR development concept page
- [[shima-contractivity-lure]] — Lur'e contractivity LMI
- [[1-lipschitz-layers-comparison]] — AOL/Cayley/SOC methods
- [[ren-recurrent-equilibrium-networks]] — REN: direct contracting parameterization
- [[gating-ablation-2026-05-07]] — Gating ON vs OFF experimental results

## References
- Behrmann, J. et al. (2019). Invertible Residual Networks. ICML 2019.
- LeCun, Y. et al. (1998). Efficient BackProp. In *Neural Networks: Tricks of the Trade*.
- Miyato, T. et al. (2018). Spectral Normalization for GANs. ICLR 2018.
- Wan, E. A. & van der Merwe, R. (2000). The Unscented Kalman Filter. In *Kalman Filtering and Neural Networks*.
- Richards, S. M. et al. (2018). Lyapunov Neural Networks. CoRL 2018.
- Bergstra, J. et al. (2011). Algorithms for Hyper-Parameter Optimization. NIPS 2011.
- Salimans, T. & Kingma, D. P. (2016). Weight Normalization. NeurIPS 2016.
- Levy, R. & Klein, I. (2026). Multi-Scaled Unscented Kalman Filter. arXiv:2604.04792.
- Majewski, Ł. et al. (2026). Robust UKF via Meta-Adaptation. arXiv:2603.04360.
