---
title: "RIGOR Research Roadmap — UKF + NN Residual Rollout (v5.14)"
created: 2026-05-07
updated: 2026-05-14
type: concept
tags: [rigor, research, roadmap, planning, ufi, rollout, lorenz, state-dependent-dynamics]
confidence: high
---

# RIGOR Research Roadmap — UKF + NN Residual Rollout

## Core Novelty

**UKF sigma point cloud를 structured neural conditioning feature로 활용 + NN residual을 K-step rollout에 전파하는 최초의 접근.**

기존 differentiable filtering:
- UKF sigma point를 dynamics propagation에만 사용, NN conditioning에는 covariance나 innovation만 전달
- K-step rollout 시 NN residual 무시 (linear skeleton A만 rollout)
- EnKF는 random ensemble → conditioning feature가 매 iter마다 달라짐

RIGOR:
- **UFI + sigma_cond:** Sigma cloud 직접 conditioning → deterministic, zero Monte Carlo error
- **Option B rollout:** Cached mean residual `NN(μ)`을 K-step rollout에 포함
- **Lemma 1-7:** 설계 결정의 수학적 정당화 완료

---

## Recent Milestones

| Date | Milestone | Status |
|:----|:----------|:------:|
| 2026-05-07 | VDP 최적화 완료 (pos=0.997, vel=0.961) | ✅ |
| 2026-05-11 | K-step rollout NaN fix (clamp + jax.lax.scan) | ✅ |
| 2026-05-12 | NN residual in rollout (Option B) | ✅ |
| 2026-05-13 | Pendulum K=8 NN rollout: vel_corr=0.993 | ✅ |
| 2026-05-13 | Jacobian-corrected rollout (실험적) | ✅ |
| 2026-05-14 | LPV delta in A_eff_dyn, vfe_loss 통합 | ✅ |
| 2026-05-14 | Lemma 1-7 증명 완료 | ✅ |
| 2026-05-14 | Lorenz63 single-lobe: abs_avg=0.73 (K=4, γ=1.5) | ✅ |

---

## Current Status (2026-05-14)

### Completed

| 항목 | 결과 |
|:----|:-----|
| **VDP benchmark** | pos=0.997, vel=0.961 (VFE + γ=0.99, 1000 iter) |
| **Pendulum K=8 NN rollout** | vel_corr=0.993 (UFI+RFF20, Option B) |
| **Lorenz63 single-lobe** | abs_avg=0.765 (Jacobian, K=4, γ=1.5) |
| **K-step rollout (A only)** | jax.lax.scan + clamp → NaN-free |
| **K-step rollout + NN (Option B)** | Cached mean residual → A + NN(μ) rollout |
| **LPV post-compute** | LPV delta from mu_filt → CPU-friendly |
| **Lemma 1-7** | All 7 lemmas mathematically verified |
| **α=1.0 requirement** | Confirmed: α<1 → UKF degenerates to near-EKF → NaN |

### In Progress

| 항목 | 현재 상태 |
|:----|:---------|
| **Lorenz63 two-lobe** | Static A → abs_avg ~0.40 (structural limitation). LPV rollout computed every iter but no significant improvement yet |
| **K=8 vs K=4 Lorenz** | K=4 converges 8.5× faster, similar abs_avg (0.74) |
| **Quadratic A(x)** | 설계 완료 (v5.19 plan). Post-compute LPV로 대체 중 |
| **CPU compilation** | LPV post-compute로 해결. WSL sandbox에서 정상 작동 |

### Next Steps

| # | Task | Priority |
|:-:|:-----|:--------:|
| 1 | Lorenz63 LPV two-lobe: gamma sweep (1.0→2.0) | 🔴 High |
| 2 | K=4 convergence analysis (sign-flip 원인 파악) | 🔴 High |
| 3 | Pendulum K=12+ rollout stability test | 🟡 Medium |
| 4 | SHM/Duffing benchmark with K-step rollout | 🟡 Medium |
| 5 | 논문 Structure 확정 — Lemma 1-7 중심 | 🟡 Medium |
| 6 | Modal GPU for larger benchmarks | 🟢 Low |

---

## Ablation Plan

| Config | UFI | K-step NN | A type | Target |
|:-------|:---:|:---------:|:------:|:-------|
| Baseline (K=1) | ❌ | ❌ | Static | Control |
| K-step only | ❌ | ✅ (K=4-8) | Static | K-step effect |
| UFI only | ✅ | ❌ | Static | UFI effect |
| LPV + K-step | ❌ | ✅ (K=4) | LPV | LPV effect |
| Full RIGOR | ✅ | ✅ (K=4) | LPV | Combined |

---

## Timeline

```
2026-05-14 (현재): Lorenz63 LPV two-lobe 실험, 코드리뷰 fix
2026-05-17 (target): Lorenz63 two-lobe abs_avg ≥ 0.6
2026-05-20: SHM/Duffing benchmark 1차 완료
2026-05-25: 논문 골격 (Introduction + Method + Lemma)
2026-06-01: 실험 결과 수집 완료
2026-06-15: 논문 초안 완료
2026-07-01: 논문 1차 리뷰
```

---

## Related Work: Differentiable Filtering Landscape

| Method | Filtering | Dynamics | Uncertainty | Key Diff from RIGOR |
|:-------|:---------:|:--------:|:-----------:|:--------------------|
| **KalmanNet** (Revach 2021) | KF + learned K | Partially known | MC Dropout | Black-box K vs analytic UKF |
| **DVBF** (Karl 2017) | Amortized VAE | Learned latent | Encoder variance | No physical state structure |
| **EnKF-GPSSM** (Lin 2023) | EnKF ensemble | GP (nonparam) | Ensemble spread | Stochastic vs deterministic |
| **Koopman+KF** (Chen 2025) | UKF | Koopman linear | UKF cov | No NN residual |
| **ac-RKN** (Shaj 2020) | RKN | Learned latent | RKN | 1-step loss only |
| **RIGOR (ours)** | **SR-UKF** | **A(x)·x + NN** | **Built-in P** | **K-step + NN residual** |

---

## Wikilinks

- [[rigor-filter]] — Core RIGOR architecture
- [[rigor-development]] — Implementation history
- [[ukf-enkf-gradient-variance-analysis]] — Lemma 1-3
- [[a-plus-nn-svd-projection-analysis]] — Lemma 4-5
- [[ufi-conditioning-superiority]] — Lemma 6
- [[k-step-rollout-error-bound]] — Lemma 7
- [[lorenz63-rigor-experiments]] — Lorenz benchmark
- [[k-step-rollout-vfe-loss]] — Loss design
- [[state-dependent-a-quadratic-form]] — A(x) evolution
- [[square-root-unscented-kalman-filter]] — SR-UKF base
