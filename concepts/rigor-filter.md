---
title: "RIGOR Filter — Differentiable SR-UKF (v5.14)"
created: 2026-05-04
updated: 2026-05-14
type: concept
tags: [rigor, kalman-filter, state-estimation, sr-ukf, differentiable-filtering, a-plus-nn]
sources: []
confidence: high
---

# RIGOR Filter — Differentiable SR-UKF

A differentiable **Square-Root Unscented Kalman Filter** with A+NN dynamics. Implements Lur'e contractivity LMI constraints, K-step NN residual rollout, and EM-based noise covariance learning.

> **v5.14** — LPV delta in `A_eff_dyn`, `vfe_loss` integrated into `rigor_loss_fn`, Lemma 1-7 proofs.

---

## Architecture (v5.14)

### Forward Pass: Differentiable SR-UKF with A+NN Dynamics

```
sigma = [μ, μ±γ·L]  (2n+1 sigma points)        ← UKF quadrature
     ↓
x_phys = sigma · A_eff_dyn                      ← Linear skeleton (+LPV if enabled)
[RFF: x_phys += C_lift · φ(sigma)]              ← Koopman lifting (optional)
residual = DeltaModulator(sigma, x_phys, cond)  ← UFI + sigma_cond
residual = ch_scale · ortho(residual)           ← Channel scale + ⟂ u₁
     ↓
x_dyn = x_phys + residual                       ← A+NN full dynamics
μ_pred = Σ wᵢ · x_dynᵢ                         ← Weighted mean
L_pred = QR(dev_pred, √Q)                       ← Prediction Cholesky
     ↓
y_pred = C·μ_pred;  L_innov = QR(dev_obs, √R)
K = UKF gain(dev_obs, L_innov)                  ← Kalman gain
μ_filt = μ_pred + K·(y − y_pred)               ← Innovation update
L_filt = QR(dev_post)                           ← Updated Cholesky
     ↓
A_eff[t] = cross_cov · P⁻¹                     ← Empirical linearization
[Stats Gating]: Q *= α                          ← Mehra+Sage-Husa (opt)
```

### Backward Pass: RTS Smoother

| Step | Formula | Description |
|:-----|:--------|:------------|
| Gain | Jₜ = P_filt[t]·A_eff[t]ᵀ·P_pred[t+1]⁻¹ | Rauch-Tung-Striebel gain |
| State | μ_s[t] = μ_filt[t] + Jₜ·(μ_s[t+1] − μ_pred[t+1]) | Smoothed state |
| Cov | P_s[t] = P_filt[t] + Jₜ·(P_s[t+1] − P_pred[t+1])·Jₜᵀ | Smoothed covariance |

### Loss: VFE + K-step NN Residual Rollout

```
VFE = NLL(innov, L_innov) + KL_dyn(P_pred, μ, μ_pred)

K-step Rollout (v5.12-5.14):
  [Option B] Cached mean residual: NN(x) ≈ NN(μ_filt[t])
             └─ from: mu_pred[t+1] - A_eff_dyn[t] · mu_filt[t]
  [Jacobian] 1st-order Taylor: NN(x) ≈ NN(μ) + J·(x-μ)   (v5.13, 실험적)

Total = NLL + Inv-Gamma(Q) + LMI_penalty + rollout_weight · vfe_loss(K_rollout)
```

---

## Key Components

### Core Filter

| Component | Since | Description |
|:----------|:-----:|:------------|
| **RigorCell** | v2 | Single SR-UKF step: sigma points → A+NN dynamics → Kalman update → carry |
| **DeltaModulator** | v2 | Learnable NN residual: sigma point MLP → tanh-norm bounded output |
| **UFI (Unscented Feature Interaction)** | v4.4 | Per-sigma-point quadratic polynomial feature expansion |
| **Statistical Gating** | v2.3 | 0-parameter adaptive Q: Mehra (1970) + Sage-Husa (1969) |
| **StableSystemMatrix** | v4 | SVD/power-iteration spectral clamping of A (‖A‖₂ ≤ γ) |

### Dynamics Augmentation

| Component | Since | Flag | Description |
|:----------|:-----:|:----:|:------------|
| **Channel Scale** | v5 | `use_channel_scale=True` | Per-channel learnable residual gain |
| **Ortho-NN** | v2.3 | `use_ortho_nn=True` | `residual ⟂ u₁` (A's dominant singular vector) |
| **RFF Lifting** | v5.4 | `use_rff_lifting=True` | Random Fourier Features: Koopman-style lifting |
| **LPV** | v5.8 | `use_lpv=True` | Input-dependent A: `A + 0.05·tanh(MLP(μ))` — post-computed from μ_filt |

### Rollout Loss (NN Residual)

| Component | Since | Description |
|:----------|:-----:|:------------|
| **1-step Rollout** | v5 | `rollout_1step_loss()` — basic dynamics consistency |
| **K-step Rollout (A only)** | v5.11 | `A_eff^k` rollout — linear only, no NN |
| **K-step Rollout + NN (Option B)** | **v5.12** | Cached mean residual from history → `A·x + NN(μ)` |
| **K-step + Jacobian** | **v5.13** | 1st-order Taylor: `A·x + NN(μ) + J·(x-μ)` via `jax.jacfwd` (실험적) |
| **LPV in Rollout** | **v5.14** | `A_eff_dyn` post-computed with LPV delta from `mu_filt` |

---

## Benchmarks

### Driven Pendulum (T=300, dt=0.05, obs_noise=0.3, θ only → recover ω)

| Config | pos_corr | vel_corr | abs_avg | K | Iters |
|:-------|:--------:|:--------:|:-------:|:-:|:-----:|
| UFI + NN16 (Option B) | 0.979 | 0.959 | 0.969 | 8 | 2000 |
| **UFI + RFF20 (Option B)** | **0.998** | **0.993** | **0.995** | **8** | **2000** |
| UFI + RFF20 + Jacobian | 0.998 | 0.992 | 0.995 | 8 | 2000 |

> Position-only observation에서 **hidden velocity를 vel_corr=0.99로 복원.** K=8 NN residual rollout 성공. Jacobian correction은 이점 없음 (Δx drift 미미).

### Lorenz63 (chaotic, T=500, dt=0.01, x₁ observed → recover x₂, x₃)

| Config | abs_avg | K | γ | Note |
|:-------|:-------:|:-:|:-:|:-----|
| Baseline (K=4) | 0.730 | 4 | 1.5 | Single-lobe, x₁<0 only |
| +Jacobian | 0.765 | 4 | 1.5 | x₃ +65%, extreme JIT cost |
| K=8 rollout | 0.650 | 8 | 1.5 | Sign recovery but lower abs_avg |
| Two-lobe (static A) | ~0.40 | 4 | 0.95 | **Static A fails** — structural limitation |
| Two-lobe + LPV | 진행 중 | 4 | 1.5 | Post-compute LPV, CPU-friendly |

> **Lemma 7**에 의해 Lorenz63 (ρ≈1.5)는 Option B의 K-step error가 exponential. `γ=1.5` 필요 (0.95는 너무 타이트).

### VDP (historical, μ=1.0, dt=0.1, steps=300)

| Config | pos_corr | vel_corr | RMSE | Note |
|:-------|:--------:|:--------:|:----:|:-----|
| VFE + γ=0.99 (500 iter) | 0.9928 | 0.9333 | 0.500 | — |
| **VFE + γ=0.99 (1000 iter)** | **0.9971** | **0.9612** | **0.383** | **🏆 역대 최고** |

---

## Theoretical Foundation

RIGOR의 설계 결정은 다음 7개 Lemma로 수학적으로 정당화된다:

| Lemma | 제목 | 핵심 주장 |
|:-----:|:-----|:---------|
| **1** | Gradient Variance | UKF = deterministic (Var=0), EnKF = O(1/N) gradient noise |
| **2** | Information Efficiency | UKF exact moment matching vs EnKF O(1/√N) error |
| **3** | Ensemble Collapse | EnKF N<n → singular; UKF 항상 full-rank |
| **4** | A+NN SVD Projection | NN ⟂ u₁ → A의 dominant dynamics 보존 |
| **5** | Residual Orthogonality Bound | SVD projection = rank n-1 → 표현력 손실 없음 |
| **6** | UFI Conditioning Superiority | Sigma cloud feature = deterministic → 안정적 conditioning |
| **7** | Option B Rollout Error Bound | ρ<1: bounded, ρ>1: exponential divergence |

자세한 증명: [[ukf-enkf-gradient-variance-analysis]] (Lemma 1-3), [[a-plus-nn-svd-projection-analysis]] (Lemma 4-5), [[ufi-conditioning-superiority]] (Lemma 6), [[k-step-rollout-error-bound]] (Lemma 7).

---

## Key Parameters

| Parameter | Default | Recommended | Description |
|:----------|:-------:|:-----------:|:------------|
| `alpha` | 1.0 | **1.0** (필수) | Sigma point spread |
| `kappa` | 0.0 | **1.0** | Secondary scaling (VDP/Pendulum) |
| `sinkhorn_gamma` | 0.99 | 0.95–1.5 | A spectral bound (Lorenz: 1.5) |
| `residual_scale` | 0.5 | 0.15 | NN residual magnitude bound |
| `K_rollout` | 1 | 4–8 | Multi-step rollout horizon |
| `rollout_weight` | 0.0 | 0.5 | K-step rollout loss weight |

---

## Repository

- GitHub: `github.com/Groot2theMoon/rigor-filter`
- JAX/Flax, Python 3.10+
- Tests: `tests/{pendulum,lorenz,vdp,smoke}/`

---

## See Also

- [[rigor-development]] — Implementation history and benchmarks
- [[rigor-research-roadmap]] — Research timeline
- [[state-dependent-a-quadratic-form]] — A(x) architecture evolution
- [[k-step-rollout-vfe-loss]] — Multi-step ELBO design
- [[lorenz63-rigor-experiments]] — Lorenz experiment log
- [[ukf-enkf-gradient-variance-analysis]] — Lemma 1-3
- [[a-plus-nn-svd-projection-analysis]] — Lemma 4-5
- [[ufi-conditioning-superiority]] — Lemma 6
- [[k-step-rollout-error-bound]] — Lemma 7
- [[square-root-unscented-kalman-filter]] — SR-UKF base algorithm
- [[dvbf-karl16]] — DVBF (closest variational competitor)
- [[bayesian-kalmannet-dahan23]] — Bayesian KalmanNet
- [[kalmannet-revach21]] — KalmanNet
