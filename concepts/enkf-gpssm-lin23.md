---
title: "EnKF-Aided Variational Inference for GP State-Space Models — EnKF-GPSSM"
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [kalman-filter, ensemble-kalman-filter, gaussian-process, variational-inference, state-space-model, online-learning]
sources: [raw/papers/enkf-gpssm-lin23.md]
confidence: high
---

# EnKF-Aided Variational Inference for GP State-Space Models

**Lin, Sun, Yin & Thiéry** (CUHK Shenzhen, NUS, 2023). arXiv:2312.05910.

## 개요

GPSSM (Gaussian Process State-Space Model)의 non-mean-field variational inference에 **Ensemble Kalman Filter (EnKF)를 통합**한 방법. EnKF를 variational distribution의 parameterization에 사용하여:
1. 복잡한 parameterization 없이 posterior 근사
2. **해석 가능한 closed-form ELBO** 유도
3. Online learning 지원

## 핵심 방법론

- **GPSSM:** Transition $f(x_t)$를 GP로 모델링 → nonparametric flexibility
- **EnKF for posterior:** $N$개 ensemble member로 사후분포 근사 → Monte Carlo sampling 없이 deterministic ensemble propagation
- **ELBO:** EnKF의 prediction-correction 구조를 ELBO에 통합 → closed-form
- **Online:** 새로운 데이터가 들어올 때마다 EnKF update → streaming 가능

## RIGOR와의 차별점

| 요소 | EnKF-GPSSM | RIGOR |
|------|-----------|-------|
| **State space** | GP transition (nonparametric) | A(x)·x + NN (parametric) |
| **Filtering** | EnKF (stochastic ensemble) | UKF (deterministic sigma points) |
| **Ensemble vs sigma** | Monte Carlo → noise in gradient | Deterministic → clean gradient |
| **Dynamics model** | GP (data-hungry, interpretable) | A+NN (structure-aware, efficient) |
| **Closed-form ELBO** | ✅ EnKF로 가능 | VFE loss (유사 구조) |

**핵심 차이:** EnKF-GPSSM은 EnKF의 stochastic ensemble로 GP transition을 학습 — **UKF의 deterministic sigma points 대비 gradient noise** 문제. RIGOR는 UKF로 clean gradient + A(x) 구조로 data efficiency에서 우위.

## 한계 (RIGOR 대비)

1. GP가 data-hungry — 작은 데이터셋에서 overfitting
2. EnKF ensemble noise가 gradient 학습을 불안정하게 함
3. EnKF는 UKF보다 많은 ensemble member (N≥20) 필요 → 계산 비용
4. GP hyperparameter tuning이 추가 부담

## 참고 문헌

- Lin et al. (2023). EnKF Meets GP SSM. arXiv:2312.05910.
- Bach et al. (2025). Enhanced Ensemble Kalman Filter. (이미 wiki [[enhanced-ensemble-kalman-filter|참조]])

## Wikilinks
- [[rigor-filter]] — UKF vs EnKF 선택의 이론적 근거
- [[ensemble-kalman-filter]] — EnKF 기본 개념
- [[unscented-feature-interaction]] — UFI: sigma cloud conditioning의 EnKF 대비 우위
- [[gaussian-process-state-space-models]] — GPSSM 개요
