---
title: "Extended Kalman Filter (EKF)"
created: 2026-05-06
updated: 2026-05-06
sources: [raw/papers/robust-sigma-point-kf-yi25.md]
type: concept
tags: [kalman-filter, state-estimation, nonlinear-filtering, linearization]
confidence: high
---

# Extended Kalman Filter (EKF)

## 개요

Extended Kalman Filter(EKF)는 비선형 시스템에 Kalman filter를 적용하기 위한 고전적인 방법으로, **Taylor 1차 선형화(linearization)** 를 통해 비선형 dynamics와 observation을 근사한다.

## EKF vs UKF vs EnKF

EKF는 UKF의 특수한 경우로 볼 수 있다: UKF의 sigma point spread parameter λ → 0의 극한에서 EKF의 1차 선형화와 동등해진다([[robust-sigma-point-kalman-filter|Yi & Zorzi, 2025]] 참조). 실제로 UKF는 EKF보다 2차항까지 포착하므로 더 정확하다.

## References

1. Julier, S.J. & Uhlmann, J.K. (1997). A new extension of the Kalman filter to nonlinear systems. *Proc. SPIE*, 3068.
2. Yi, S. & Zorzi, M. (2025). A robust approach to sigma point Kalman filtering. arXiv:2506.04815.
