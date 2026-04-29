---
title: Square-Root Unscented Kalman Filter — State and Parameter Estimation
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [classic-ai, state-estimation, kalman-filter, foundation]
sources: [raw/papers/The_square-root_unscented_Kalman_filter_for_state_and_parameter-estimation.md]
confidence: high
---

# Square-Root Unscented Kalman Filter (SR-UKF)

## 개요

**van der Merwe & Wan** (Oregon Graduate Institute, 2001)는 **Unscented Kalman Filter (UKF)** 의 **square-root 구현**을 제안하여, 수치적 안정성과 공분산 행렬의 양의 준정부호성(positive semi-definiteness)을 보장하는 동시에, 파라미터 추정 문제에서 $\mathcal{O}(L^2)$ 계산 복잡도를 달성했다.

## UKF 복습

### EKF의 한계

Extended Kalman Filter는 비선형 시스템을 선형화(Jacobian 계산)하여 근사 → **1차 정확도**만 보장, 발산 가능성.

### UKF의 핵심: Unscented Transform

$2L+1$개의 **sigma point**를 결정론적으로 선택 → 실제 비선형 함수로 전파 → 가중 평균/공분산 계산:
- Gaussian 입력에 대해 **3차 정확도** (Taylor 전개 기준)
- Jacobian/Hessian 계산 불필요

## SR-UKF의 혁신

### 표준 UKF의 문제

매 시간 스텝마다 $P = SS^\top$의 Cholesky 분해 필요 → $\mathcal{O}(L^3/6)$ + 수치적 불안정성.

### Square-Root 접근법

**Cholesky factor $S$를 직접 전파** (재분해 불필요):

1. **QR 분해**로 time update: $S_k^- = \text{qr}\{[\sqrt{W_1^{(c)}}(\mathcal{X}_{1:2L} - \hat{x}^-), \sqrt{R^v}]\}$
2. **Cholesky update/downdate**로 가중치 보정: $S_k^- = \text{cholupdate}\{S_k^-, \mathcal{X}_0 - \hat{x}^-, W_0^{(c)}\}$
3. **Efficient least squares**로 Kalman gain 계산 (back-substitution)

### 파라미터 추정의 $\mathcal{O}(L^2)$ 구현

파라미터 추정에서는 상태 천이 행렬이 항등행렬 → $S_{w_k}^- = \gamma^{-1/2} S_{w_{k-1}}$ (단순 스케일링)
- QR/Cholesky update 기반의 $\mathcal{O}(L^3)$ 연산 회피
- $\mathcal{O}(L^2)$ (표준 EKF와 동일한 복잡도)

## 성능

| 필터 | 상태 추정 | 파라미터 추정 |
|:-----|:--------:|:------------:|
| EKF | $\mathcal{O}(L^3)$ | $\mathcal{O}(L^2)$ |
| UKF | $\mathcal{O}(L^3)$ | $\mathcal{O}(L^3)$ |
| **SR-UKF** | $\mathcal{O}(L^3)$ | **$\mathcal{O}(L^2)$** |

- Mackey-Glass 시계열: EKF보다 우수, UKF와 동등한 정확도
- Mackay Robot-Arm (신경망 학습): $\mathcal{O}(L^2)$ 스케일링 확인
- SR-UKF는 UKF보다 약 20% 빠름, EKF보다 약 10% 빠름

## 핵심 선형대수 도구

| 기법 | 용도 | 복잡도 |
|:-----|:-----|:------|
| QR decomposition | Time update의 Cholesky factor 계산 | $\mathcal{O}(NL^2)$ |
| Cholesky update/downdate | Rank-1 수정, 가중치 보정 | $\mathcal{O}(L^2)$ |
| Least squares (back-substitution) | Kalman gain 계산 | $\mathcal{O}(LM^2)$ |

## References

- van der Merwe, R. & Wan, E.A. (2001). The Square-Root Unscented Kalman Filter for State and Parameter-Estimation. ICASSP.
- Julier, S.J. & Uhlmann, J.K. (1997). A New Extension of the Kalman Filter to Nonlinear Systems.
