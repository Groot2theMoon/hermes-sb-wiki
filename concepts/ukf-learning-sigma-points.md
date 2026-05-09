---
title: "UKF-L — Model Based Learning of Sigma Points"
created: 2026-05-05
updated: 2026-05-09
type: concept
tags: [ukf, sigma-point, learning, bayesian, gaussian-process, nonlinear-filtering]
sources:
  - raw/papers/turras10.md
  - raw/papers/turner10-sigma-point-learning.md
confidence: high
---

# UKF-L — Model Based Learning of Sigma Points

**Turner & Rasmussen** (University of Cambridge, 2010)

## 개요

UKF의 sigma point placement를 **model-based learning 문제**로 정식화. Sigma point 위치와 weight를 데이터로부터 학습하여 sigma point collapse 가능성을 크게 줄이고, 기본 UKF 설정 및 GP-ADF 대비 예측 성능을 유의미하게 향상. 제안 방법: **UKF-L (UKF with Learning)**.

## 문제 정의

표준 UKF의 sigma point placement는 임의(heuristic) 파라미터($\alpha, \beta, \kappa$)에 의존:
- 잘못된 선택 → sigma point collapse (points가 mean 주변에 몰림)
- Nonlinearity가 강한 시스템에서 성능 저하
- 표준 추천값($\kappa = 3-n$)은 고차원에서 문제

## 접근법: UKF-L

### Model-Based Learning
Turner & Rasmussen은 sigma point placement를 **파라미터 최적화 문제**로 접근:

1. Sigma point 위치와 weight를 **자유 파라미터**로 취급
2. 학습 데이터에 대해 marginal likelihood 최대화
3. Gradient-based optimization으로 최적 placement 탐색

### 학습 목표
Sigma point set $\{\mathcal{X}_i, w_i\}_{i=1}^m$을 다음 조건을 만족하도록 최적화:
- Mean 보존: $\sum w_i \mathcal{X}_i = 0$
- Covariance 보존: $\sum w_i \mathcal{X}_i \mathcal{X}_i^T = P$
- **추가 비선형 함수 적분의 정확도 최대화 (data-driven)**

### GP-ADF와의 비교
GP-ADF (Gaussian Process Assumed Density Filter)는 UKF보다 정확하지만 계산량이 $O(n^3)$으로 큼. UKF-L은 UKF와 동일한 $O(n^3)$ (사실상 $O(n^2)$ for most ops) 복잡도를 유지하면서 GP-ADF에 근접하는 정확도 달성.

## 실험 결과

- **Sigma point collapse 방지:** 학습된 placement가 heuristic보다 훨씬 robust
- **비선형 시스템:** 기본 UKF 대비 예측 log-likelihood 20-40% 향상
- **계산량:** UKF와 동등 (GP-ADF보다 수배~수십배 빠름)

## Wikilinks
- [[ma-ukf-meta-adaptive]] — MA-UKF (meta-learned weights, 다른 접근법)
- [[optimized-sigma-points-n-plus-1]] — n+1 sigma point (Cheng & Liu)
- [[multi-scaled-ukf]] — Multi-scaled UKF (per-state scaling)
- [[generalized-gaussian-cubature]] — Generalized Gaussian Cubature

## References
- Turner & Rasmussen. "Model Based Learning of Sigma Points in Unscented Kalman Filtering." *Cambridge University Engineering Department*
- Authors: Ryan Turner, Carl Edward Rasmussen (Cambridge MLG)
