---
title: "Ensemble Kalman Filter (EnKF)"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [kalman-filter, ensemble-filter, data-assimilation, state-estimation, stochastic-filtering]
confidence: high
---

# Ensemble Kalman Filter (EnKF)

## 개요

Ensemble Kalman Filter(EnKF)는 Evensen(1994)이 제안한 **Monte Carlo 기반**의 Kalman filtering 방법으로, 고차원 비선형 시스템(state dimension ≫ 100)에서 실용적인 state estimation을 가능하게 한다. KF의 Gaussian 가정을 유지하지만, **ensemble members ({x^{(i)}}_{i=1}^N)** 로 분포를 근사하여 covariance matrix의 명시적 저장/전파 없이 Kalman update를 수행한다.

## 표준 EnKF vs UKF

| 특성 | EnKF | UKF (SR-UKF) |
|------|:----:|:------------:|
| Ensemble 유형 | Stochastic (N random samples) | Deterministic (2n+1 sigma points) |
| Ensemble 수 | N ≫ 1 (보통 20-100) | 2n+1 (고정, 작음) |
| Permutation invariance | ✅ (ensemble member 순서 무관) | ✅ (sigma point 순서 무관) |
| Nonlinear propagation | 각 member를 dynamics로 전파 | 각 sigma point를 dynamics로 전파 |
| Update | Kalman gain (sample covariance) | Kalman gain (weighted covariance) |
| 주 사용 분야 | Geophysics, weather prediction | Low-dimensional nonlinear systems |
| 계산 복잡도 | O(N·d) (ensemble 수에 선형) | O(n³) (Cholesky) |

## Mean-Field Formulation

EnKF는 **mean-field state-space model**로 해석 가능: ensemble size N → ∞의 극한에서 EnKF의 analysis step은 특정 pushforward operator로 수렴한다. 이 관점은 Bach et al.(2025)의 MNMEF에서 [[set-transformer|Set Transformer]]를 EnKF에 통합하는 이론적 기반이 되었다.

## Exact Affine Conditioning

Jorgensen & Marzouk (2025)는 EnKF의 analysis step (ensemble Kalman update, EnKU)이 exact posterior를 제공하는 분포 집합 $E_{\text{EnKU}}$가 **Gaussian보다 훨씬 넓음**을 증명했다. 또한 EnKU가 exact affine conditioning map 중 **유일함**을 보였다. [[exact-affine-conditioning-ensemble-kalman-update]] 참조.

## 관련 연구

- [[pigg-graph-kalman-filter]] — PiGGO: Graph Kalman Filter (Haywood-Alexander et al., 2026)
- [[lagrangian-koopman-network]] — LaCGKN for DA (Wang et al., 2026)
- [[robust-sigma-point-kalman-filter]] — Robust sigma point KF (Yi & Zorzi, 2025)
- [[kalmannet]] — KalmanNet: Neural Network Aided KF
- [[rigor-filter]] — RIGOR SR-UKF
- [[auto-diff-data-assimilation]] — Auto-differentiable DA

## References

1. Evensen, G. (1994). Sequential data assimilation with a nonlinear quasi-geostrophic model using Monte Carlo methods to forecast error statistics. *J. Geophysical Research*, 99(C5).
2. Evensen, G. (2003). The Ensemble Kalman Filter: theoretical formulation and practical implementation. *Ocean Dynamics*, 53.
3. Bach, E. et al. (2025). Learning Enhanced Ensemble Filters. *J. Comp. Physics*. arXiv:2504.17836.
4. Jorgensen, F.J.N. & Marzouk, Y.M. (2025). Exact affine conditioning beyond Gaussians. arXiv:2510.00158.
