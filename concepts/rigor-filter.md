---
title: RIGOR Filter — Differentiable SR-UKF
created: 2026-05-04
updated: 2026-05-14
type: concept
tags: [rigor, kalman-filter, state-estimation, system-identification, lorenz, rollout, state-dependent-dynamics]
sources: []
confidence: high
---

# RIGOR Filter

A differentiable Square-Root Unscented Kalman Filter with A+NN dynamics. Implements Lur'e contractivity LMI constraints and EM-based noise covariance learning. See [[square-root-unscented-kalman-filter|SR-UKF]] for the base algorithm.

Closely related to [[auto-diff-data-assimilation|Auto-differentiable Data Assimilation]] (co-learning states + dynamics + filtering) and [[observability-nssm|Observability for NSSM]] (theoretical conditions for unobserved state recovery).

## Related Dynamics Approaches

- [[skanode]] — Structured KAN Neural ODEs for interpretable symbolic discovery of nonlinear dynamics; relevant for interpretable dynamics in RIGOR
- [[buisson-fenet-kkl-observer]] — KKL observer-based recognition models for NODEs under partial observations; directly foundational for DeltaObserver

This filter addresses the same learning-based state estimation problem as [[miao-robust-observer|Miao & Gatsis (2023)]], which learns KKL observers via Neural ODEs. Key differences: RIGOR uses SR-UKF with contractivity LMI for robustness, while Miao uses Neural ODE latent dynamics with D-eigenvalue regularization.

## Sigma Point Innovation Research

[[rigor-sigma-point-research|RIGOR Sigma Point Innovation Research]] 문서에서 5가지 sigma point 개선 아이디어의 연구 현황과 RIGOR-specific novelty를 분석:

| Priority | Idea | Key Reference | Impact |
|----------|------|---------------|--------|
| ✅ 즉시 | ① Differentiable sigma point spread | MS-UKF (Levy 2026), Turner & Rasmussen (2010) | 가장 높음 |
| ✅ 병행 | ③ Sigma point trajectory as feature | Novel (선행연구 없음) | medium |
| ⚠️ 결합 | ④ Learnable sigma weights | MA-UKF (Majewski 2026) | ①+③과 결합 시 시너지 |
| ❌ 보류 | ② LMI-aware adaptive point count | Novel | 낮음 |
| 📌 장기 | ⑤ Per-sigma-point correction | Novel | 매우 높음 (risk 높음) |

## Comprehensive Experiment Log (2026-05-05)

All experiments: VDP μ=1.0, dt=0.1, steps=300, obs_std=0.3, SR-UKF (no KKL), 500 iter, SEED=43.

### Unsupervised Experiments (position NLL only)

| # | Approach | pos_corr | vel_corr | RMSE | Note |
|---|----------|----------|----------|------|------|
| 0 | Baseline (clean v2) | 0.9914 | 0.9054 | 0.798 | SR-UKF + A+NN only |
| 1 | Whiteness loss w=0.1 | 0.9866 | 0.9023 | 1.205 | lag-1 innovation autocorrelation |
| 2 | Whiteness + LMI (0.1+0.01) | 0.9827 | 0.8824 | 1.343 | LMI contractivity penalty (ρ=0.99) |
| 3 | Per-state spread (bad init) | 0.9349 | 0.8182 | 1.690 | softplus(logits)+0.5 → init 1.19 < gamma 1.414 |
| 4 | Per-state spread (good init) | 0.9891 | 0.8995 | 0.742 | gamma+delta, RMSE best |
| 5 | Sigma spread regularizer w=0.01 | 0.9740 | 0.9197 | 1.103 | (pos_std/vel_std)² penalty |
| 6 | **Sigma cloud conditioning** | 0.9246 | **0.9191** | 1.251 | std+skew → NN residual conditioning |

### Supervised Experiments (pos NLL + λ·vel MSE)

| # | Approach | pos_corr | vel_corr | RMSE | Note |
|---|----------|----------|----------|------|------|
| 7 | Supervised w=1.0 | 0.336 | 0.226 | 1.409 | Weight too high → pos collapse |
| 8 | Supervised w=0.1 (μ=1.0) | 0.907 | 0.914 | 1.572 | Better vel but pos sacrificed |
| 9 | OOD μ=3.0 (from #8) | 0.141 | 0.181 | 1.927 | Supervised doesn't generalize OOD |

### Key Findings

1. **Velocity 비선형성의 근본적 한계:** Position NLL만으로는 velocity의 rich dynamics를 covariance → Kalman gain 경로로만 간접 학습. True velocity의 sharp peak(±4) 대비 추정 amplitude는 ±1.5 수준.
2. **Sigma point 정보 활용 방향성은 유효:** vel_corr이 0.905→0.919로 개선된 두 접근법(spread reg, cloud cond) 모두 sigma point 정보를 활용. 다만 pos_corr/RMSE 희생.
3. **OOD generalization은 미해결:** Supervised + multi-mu로도 μ=1.0→3.0 일반화 실패. A+NN 구조의 근본적 한계.
4. **초기화 중요성:** Per-state spread의 init 값이 gamma와 다르면 성능 급락. Zero-delta init 필요.

### Open Questions
- Position-velocity trade-off 해결을 위한 loss 구조 개선 (normalized loss?)
- **✅ Parameter-conditioned A+NN** — [[state-dependent-a-quadratic-form|Quadratic A(x)]] as Taylor expansion of J(x)·dt (v5.19)
- Delay embedding (Takens)으로 관측 augment
- **VB 기반 adaptive noise covariance** — [[variational-bayes-adaptive-kalman-filter]] 참조
- 다양한 dynamics family에서의 벤치마크

## v5.x: State-Dependent Dynamics & K-step Rollout (May 2026)

### Core Innovations

| Component | Version | Description |
|-----------|:-------:|-------------|
| **State-Dependent A(x)** | v5.8→v5.19 | Static A → LPV MLP → Quadratic form A₀+A₁⊗x+xᵀA₂x |
| **K-step Rollout VFE** | v5.11 | Multi-step ELBO for dynamics consistency |
| **NN Residual in Rollout** | v5.12 | Cached mean residual (Option B) |
| **Jacobian-corrected Rollout** | v5.13 | 1st-order Taylor correction for long K |

### Lorenz63 Benchmark

RIGOR tested on [[lorenz63-rigor-experiments|Lorenz63]] — a chaotic 3D system with 2-lobe switching. Key finding: static A fails catastrophically on 2-lobe data (\|ρ\|≈0.4). State-dependent A(x) via quadratic form is the proposed solution.

### CPU Compilation Challenge

LPV MLP (Flax module in `nn.scan`) causes 5+ GB RAM OOM on CPU. [[state-dependent-a-quadratic-form|Quadratic A(x)]] (pure einsum, no Flax modules) addresses this structurally. See [[k-step-rollout-vfe-loss]] for VFE loss architecture.

## See Also

- [[rigor-development]] — Implementation history and benchmarks
- [[state-dependent-a-quadratic-form]] — A(x) architecture evolution
- [[k-step-rollout-vfe-loss]] — Multi-step ELBO design
- [[lorenz63-rigor-experiments]] — Full Lorenz experiment log
- [[rigor-research-roadmap]] — Research trajectory
- [[rigor-heuristics-analysis]] — Heuristic audit
- [[rigor-design-philosophy-v3]] — A+NN partition philosophy
- [[dvbf-karl16]] — Deep Variational Bayes Filters (closest variational competitor)
- [[bayesian-kalmannet-dahan23]] — Bayesian KalmanNet (uncertainty-aware KalmanNet)
- [[enkf-gpssm-lin23]] — EnKF-GPSSM (ensemble filtering variant)
