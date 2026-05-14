---
title: "State-Dependent Dynamics A(x) — LPV to Quadratic Form"
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [rigor, kalman-filter, differentiable-filtering, architecture, lpv, quadratic-a]
sources: []
confidence: high
---

# State-Dependent Dynamics A(x) — LPV to Quadratic Form

> How RIGOR's dynamics matrix evolved from static A to state-dependent A(x).

## Motivation

Static A captures linear dynamics well but cannot express **state-dependent coupling** — essential for systems like Lorenz63 where the effective Jacobian changes sign between lobes (x₁ > 0 → positive coupling; x₁ < 0 → negative coupling).

The goal: `f(x) = A(x)·x + NN(x)` where A(x) carries the first-order state-dependent structure and NN handles residual.

## Architecture Invariant

```
f(x) = A(x)·x + NN⊥(x, sigma_cond)
         └─ state-dependent skeleton   └─ orthogonal residual (⟂ u₁(A))
```

NN remains orthogonal to A's dominant singular direction (SVD projection). Only A(x) changes.

## v5.8–v5.18: LPV (Linear Parameter-Varying) via MLP

```
A(x) = A_base + tanh(MLP(x))
```

- Flax MLP module called inside `nn.scan` per timestep
- **Problem:** JAX XLA compilation of Flax module inside scan body → 5+ GB RAM → OOM kill on CPU (4 consecutive failures)
- Zero-init final layer (v5.17) fixed iter-1 NaN but couldn't fix CPU compilation
- Post-compute vmap removal (v5.18) reduced graph but not enough

| Version | Change | CPU Result |
|---------|--------|:----------:|
| v5.16 | LPV + warmup removal + clamp config | OOM |
| v5.17 | zero_final=True | iter 1 NaN fix, OOM |
| v5.18 | vmap removal | iter 1 OK (83s), backward OOM |

**Root cause:** Flax module call (`self.lpv_net(mu_prev)`) inside `nn.scan` body forces JAX to trace parameter sharing across all timesteps — explosion of compilation graph on CPU.

## v5.19: Quadratic Form (Pure Einsum)

```
A(x) = A₀ + A₁⊗x + xᵀA₂x
```

**117 parameters for S=3** (A₀:9 + A₁:27 + A₂:81). Zero Flax module calls — pure `jnp.einsum`:

```python
A_eff_dyn = (A0
             + jnp.einsum('ijk,k->ij', A1, mu_prev)
             + jnp.einsum('ijkl,k,l->ij', A2, mu_prev, mu_prev))
```

- A₁, A₂ initialized to zero → `A(x)=A₀` at iter 1 (identical to static A)
- Gradient learning grows A₁, A₂ naturally
- Same compilation graph size as non-LPV RIGOR (no Flax overhead)

### Theoretical Basis

For any nonlinear system `ẋ = f(x)`:
```
x_{k+1} = (I + J(x_k)·dt)·x_k + [f(x_k) - J(x_k)·x_k]·dt
           └── A(x_k) ──┘   └────── NN(x_k) ──────┘
```

A(x) = I + J(x)·dt is the **discrete-time Jacobian**. Its Taylor expansion:
```
A(x) = A₀ + A₁⊗x + xᵀA₂x + O(x³)
```

Quadratic truncation captures **second-order state-dependent coupling** with O(N³) parameters — a structured alternative to black-box neural LPV while remaining interpretable.

## Why Not Other Approaches

| Approach | Flax Module? | CPU | Expressiveness | Theory |
|----------|:-----------:|:---:|:-------------:|:------:|
| Static A | No | ✅ | Linear only | Exact for linear systems |
| **Quadratic A(x)** | **No** | **✅** | **2nd-order coupling** | **Taylor of J** |
| LPV MLP | Yes | ❌ | High | Universal approx |
| KKL observer | Yes | 🟡 | High | Nonlinear observer theory |

## See Also

- [[rigor-filter]] — RIGOR overview
- [[rigor-development]] — Implementation history
- [[k-step-rollout-vfe-loss]] — How A_eff_dyn feeds K-step rollout
- [[lorenz63-rigor-experiments]] — Lorenz experiments motivating A(x)
- [[koopman-lifting-rigor]] — Koopman lifting alternative (RFF-based)
