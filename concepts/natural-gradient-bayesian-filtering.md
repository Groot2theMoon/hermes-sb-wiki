---
title: "Natural Gradient Bayesian Filtering — Geometry-Aware Gaussian Filtering"
created: 2026-05-07
updated: 2026-05-07
type: concept
tags: [kalman-filter, state-estimation, mathematics, paper, uncertainty]
confidence: medium
sources: [arXiv:2605.02306]
---

# Natural Gradient Bayesian Filtering

## 개요

**Kim, Park, Lee (2026)**^[arXiv:2605.02306]의 tutorial 논문은 **Gaussian filtering을 information geometry 관점에서 재해석**하고, 통계적 다양체(statistical manifold) 상에서의 **natural gradient descent**를 활용한 새로운 필터링 프레임워크를 제안한다.

## 핵심 아이디어

### NANO (Natural Gradient Gaussian Approximation) Filter

기존 Gaussian 필터(EKF, UKF, CKF)는 예측(predict)과 측정 갱신(update) 단계를 분리하여 처리하지만, NANO 필터는 이 두 단계를 **정보 기하학적 추론(inference over state distributions)** 으로 통합한다:

1. **통계적 다양체 관점** — Gaussian 분포 $\\mathcal{N}(\\mu, P)$를 Riemannian manifold 위의 한 점으로 해석
2. **Natural gradient descent** — Fisher information metric을 이용한 기하학적 최적화로 posterior mean/covariance 반복 갱신
3. **Positive definiteness 보존** — covariance의 positive definiteness를 자연스럽게 유지

### 기존 필터와의 차이

| 항목 | EKF/UKF | NANO (Natural Gradient) |
|------|---------|------------------------|
| Linearity 가정 | 선형화 필요 | 비선형 직접 처리 |
| Covariance 유지 | 수치적 불안정 | 기하학적 보존 |
| 수렴 속도 | 표준 GD | 빠름 (정보 기하학) |
| 이론적 기반 | 확률적 추론 | 정보 기하학 + Bayesian 추론 |

## 연결점
- [[extended-kalman-filter]] — 기존 선형화 기반 접근과의 대비
- [[unscented-kalman-filter]] — UKF vs Natural Gradient 접근법 비교
- [[ensemble-kalman-filter]] — Monte Carlo 기반 접근법과의 차이
- [[deep-kalman-filter]] — 학습 기반 필터와의 연결점

## References
- arXiv:2605.02306 — Natural Gradient Bayesian Filtering: Geometry-Aware Filter for Dynamical Systems (cs.RO/cess.SY)
