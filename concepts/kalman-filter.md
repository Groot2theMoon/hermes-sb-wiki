---
title: Kalman Filter
created: 2026-05-04
updated: 2026-05-05
type: concept
tags: [kalman-filter, state-estimation, linear-systems, recursive-bayesian]
sources: []
confidence: medium
---

# Kalman Filter

## 개요

Kalman Filter (KF)는 **선형 가우시안 동적 시스템**의 상태를 잡음이 섞인 측정으로부터 **최소 분산(minimum variance) 추정**하는 재귀적 알고리즘. Rudolph Kalman (1960)이 제안.

## 알고리즘 (2-step)

### Predict (Time Update)
$$\hat{x}_{k|k-1} = F_k \hat{x}_{k-1|k-1}$$
$$P_{k|k-1} = F_k P_{k-1|k-1} F_k^T + Q_k$$

### Update (Measurement Update)
$$K_k = P_{k|k-1} H_k^T (H_k P_{k|k-1} H_k^T + R_k)^{-1}$$
$$\hat{x}_{k|k} = \hat{x}_{k|k-1} + K_k(z_k - H_k\hat{x}_{k|k-1})$$
$$P_{k|k} = (I - K_k H_k)P_{k|k-1}$$

## Optimality 조건

- **선형성:** Dynamics $x_k = Fx_{k-1} + w_k$, Measurement $z_k = Hx_k + v_k$
- **가우시안:** $w_k \sim N(0, Q)$, $v_k \sim N(0, R)$, $x_0 \sim N(\hat{x}_0, P_0)$
- **독립성:** $w_k$, $v_k$는 서로 및 과거와 독립
- 위 조건이 모두 만족되면 **KF는 MMSE (Minimum Mean Square Error) 추정량**

## 확장

| 필터 | 적용 | 특징 |
|:----|:-----|:-----|
| EKF (Extended KF) | 약한 비선형 | 1차 Taylor linearization, Jacobian 필요 |
| UKF (Unscented KF) | 강한 비선형 | Sigma point propagation, 3차 정확도 |
| CKF (Cubature KF) | 고차원 비선형 | Spherical-radial cubature rule |
| SR-UKF/SR-CKF | 수치 안정성 | Square-root covariance propagation |
| KalmanNet | 데이터 기반 | RNN으로 Kalman gain 학습 |
| Differentiable KF | End-to-end | Backprop을 통한 Q,R 학습 |

## Wikilinks
- [[square-root-unscented-kalman-filter]] — SR-UKF (수치 안정성)
- [[kalmannet]] — KalmanNet (RNN 기반 Kalman gain)
- [[differentiable-filter-kloss]] — Differentiable filtering
- [[ma-ukf-meta-adaptive]] — MA-UKF (meta-learned sigma-point weights)
- [[multi-scaled-ukf]] — MS-UKF (per-state scaling)
- [[ukf-learning-sigma-points]] — UKF-L (learned sigma points)
- [[ukf-scaling-adaptive-dunik]] — Adaptive scaling parameter
- [[state-space-model]] — State-space models
- [[auto-diff-data-assimilation]] — Differentiable data assimilation

## References
- Kalman, R. E. (1960). "A New Approach to Linear Filtering and Prediction Problems." *Journal of Basic Engineering*, 82(1), 35-45.
- Julier, S. J. & Uhlmann, J. K. (1997). "A new extension of the Kalman filter to nonlinear systems." *SPIE*, 3068, 182-193.
