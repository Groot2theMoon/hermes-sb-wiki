---
title: "Multi-Scaled Unscented Kalman Filter — Per-State Scaling"
created: 2026-05-05
updated: 2026-05-05
sources: [raw/papers/2604.04792v1.md]
type: concept
tags: [ukf, multi-scale, sigma-point, scaling-parameter, nonlinear-estimation]
sources:
  - raw/papers/2604.04792v1.md
confidence: high
---

# Multi-Scaled Unscented Kalman Filter — Per-State Scaling

**Levy & Klein** (University of Haifa, Israel, 2026)

## 개요

기존 UKF는 모든 state dimension에 **동일한 scaling parameter**를 사용하지만, 다차원 시스템에서 각 state가 매우 다른 동적 특성을 보일 때 이는 심각한 제약. **Multi-Scaled UKF (MS-UKF)**는 각 state dimension별로 **독립적인 scaling parameter**를 허용하여 sigma point spread를 per-state로 제어하는 최초의 방법론.

## 핵심 문제

표준 UKF의 scaled unscented transform:
$$\mathcal{X}_i = \hat{x} \pm \sqrt{(n+\lambda)P_x}$$

- $\lambda = \alpha^2(n+\kappa) - n$: **단일 스칼라**로 모든 dimension 제어
- State가 다른 time scale, 다른 nonlinearity를 가져도 **동일 spread**
- 예: position (천천히 변함) vs acceleration (빠르게 변함) — 같은 $\alpha$로 처리

## 제안: Multi-Scaled Unscented Transform

### 수학적 기반

각 dimension $j$에 독립적인 scaling parameter $\lambda_j$ 도입:

$$\mathcal{X}_{i,j} = \hat{x}_j \pm \sqrt{(n+\lambda_j) [P_x]_{jj}}$$

- **행렬 형태:** 대각 scaling matrix $\Lambda = \text{diag}(\lambda_1, ..., \lambda_n)$
- **Sigma point:** $\mathcal{X} = \hat{x} \pm \sqrt{(nI + \Lambda) \circ P_x}$ (Hadamard product)
- 핵심 성질 유지: mean unbiased, covariance exact to 2nd order

### Multi-Scaled UKF 알고리즘

기존 UKF framework에 multi-scaled UT를 삽입:
1. 각 dimension의 scaling parameter를 **별도로 설정** (domain knowledge 또는 최적화)
2. Sigma point 생성 시 각 축 방향으로 다른 spread
3. Prediction 및 update는 표준 UKF와 동일

## 실험 검증

1. **비선형 진동 시스템:** position (slow) vs velocity (fast) — MS-UKF가 30% 더 낮은 RMSE
2. **INS/GNSS 융합:** attitude (nonlinear) vs position (near-linear) — attitude 수렴 가속
3. **표준 UKF 대비:** 동일 계산량으로 향상된 정확도

## Wikilinks
- [[ukf-scaling-adaptive-dunik]] — UKF scaling parameter adaptive setting (Duník et al.)
- [[square-root-unscented-kalman-filter]] — SR-UKF
- [[differentiable-sigma-point-quadrature]] — Differentiable sigma point quadrature (RIGOR)
- [[ukf-learning-sigma-points]] — UKF-L (Turner & Rasmussen)
- [[optimized-sigma-points-n-plus-1]] — n+1 sigma points

## References
- arXiv: 2604.04792 (2026)
- University of Haifa, Hatter Department of Marine Technologies
