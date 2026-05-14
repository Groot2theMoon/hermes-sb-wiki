---
title: "K-step Multi-step Rollout — VFE Loss & NN Residual"
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [rigor, kalman-filter, differentiable-filtering, loss-function, rollout]
sources: []
confidence: high
---

# K-step Multi-step Rollout — VFE Loss & NN Residual

> Multi-step dynamics consistency via K-step rollout in Variational Free Energy loss.

## VFE Loss Structure

```
VFE = NLL + KL_dynamics
       └─ observation accuracy    └─ dynamics consistency
```

### KL_dynamics Decomposition (v5.11+)

```
KL_dyn = ½[tr(Q⁻¹P) - d + log|Q|-log|P|]           ← covariance consistency
       + ½∥μ_filt[t] − μ_pred[t]∥²_{Q⁻¹}            ← 1-step rollout
       + ½∥μ_filt[t+K] − f^K(μ_filt[t])∥²_{Q⁻¹}     ← K-step rollout
```

The K-step term enforces **multi-step prediction consistency**: the model's dynamics `f(x)` should predict the filter state K steps ahead.

## NN Residual in Rollout (v5.12, "Option B")

### Problem

K-step rollout requires `f^K(μ_filt[t])` — the dynamics applied K times. Using full RIGOR (UKF+observation update) per step would be circular (observations leak future info).

### Solution: Cached Mean Residual

```python
# UKF forward pass stores per-step residual
mean_resid[t] = mu_pred[t+1] - A_eff_dyn[t] @ mu_filt[t]

# Rollout: x_{k+1} = A_eff_dyn·x_k + mean_resid[t+k]
# (linear skeleton + pre-computed NN correction at reference point)
```

| Option | Rollout f(x) | Accuracy | Cost |
|--------|-------------|:--------:|:----:|
| A | Full UKF (A·x + NN + obs update) | Exact but circular | ❌ |
| **B (cached mean)** | A·x + mean_resid[t+k] | 1st-order approx | ✅ |
| C (Jacobian) | A·x + NN(μ) + J·(x-μ) | 2nd-order Taylor | ❌ Heavy |

Option B is the default — simple, cheap, works for moderate K (4–8).

## Jacobian-Corrected Rollout (v5.13)

For larger K where rollout drift matters, compute Jacobian of NN w.r.t. state:

```python
NN(x) ≈ NN(μ_filt) + J(μ_filt)·(x - μ_filt)
        └─ cached mean   └─ 1st-order correction for rollout drift
```

Jacobian improves x₃ recovery in Lorenz (+65%: 0.247→0.407) but adds significant computation and memory overhead. Only recommended for K ≥ 8 or highly nonlinear systems.

## NLL Double-Counting Fix (v5.15)

**Bug:** `rigor_loss_fn` computed `nll_loss(...)` separately then added `rollout_weight * vfe_loss(...)` where `vfe_loss` internally also included NLL → NLL weight = 1.0 + rollout_weight (e.g., 1.5× with rollout_weight=0.5).

**Fix:** `vfe_loss(include_nll=False)` returns only KL_dyn + K-step term. `total_loss = nll + inv_gamma + lmi + rollout_weight * vfe_loss(include_nll=False)`.

## Integration with A(x)

`vfe_loss` uses `A_eff_dyn` from history — the state-dependent dynamics matrix. With quadratic A(x) (v5.19), A_eff_dyn captures state-dependent coupling, making the K-step rollout more accurate for systems like Lorenz63.

## See Also

- [[state-dependent-a-quadratic-form]] — How A(x) enables state-dependent rollout
- [[rigor-filter]] — RIGOR overview
- [[rigor-development]] — Implementation history
- [[lorenz63-rigor-experiments]] — K-step rollout tested on Lorenz
