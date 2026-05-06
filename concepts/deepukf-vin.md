---
title: "DeepUKF-VIN — Adaptively-tuned Deep Unscented Kalman Filter for Visual-Inertial Navigation"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [ukf, deep-learning, visual-inertial-navigation, adaptive-tuning, quaternion, gps-denied]
sources:
  - raw/papers/deepukf-vin-ghanizadegan25.md
confidence: medium
---

# DeepUKF-VIN

**arXiv:** [2502.00575](https://arxiv.org/abs/2502.00575)
**Authors:** [[khashayar-ghanizadegan|Khashayar Ghanizadegan]], [[hashim-hashim|Hashim A. Hashim]] (Carleton University)
**Published in:** *Expert Systems With Applications*, vol. 271, 126656, 2025

## 개요

**DeepUKF-VIN (Deep Unscented Kalman Filter for Visual-Inertial Navigation)** 은 딥러닝 기반 적응형 메커니즘(DLAM)으로 UKF의 noise covariance matrix를 실시간 조정하는 3D 6-DoF 비주얼-관성 항법 시스템. GPS-denied 환경에서 IMU와 stereo camera 데이터를 융합하여 orientation (quaternion), position, linear velocity를 추정.

## 문제 정의

- GPS-denied 환경 (실내, 도심 협곡, 수중)에서의 정밀 항법
- IMU 단독 추정: cumulative drift 문제
- Kalman-type 필터의 noise covariance tuning: 수동 튜닝은 time-consuming
- 기존 deep learning 접근법: 주로 EKF 기반, UKF의 quaternion space 확장 미흡

## 핵심 구조

### DLAM (Deep Learning-based Adaptation Mechanism)

두 개의 신경망으로 구성:

**1. IMU-Net (GRU 기반)**
- 입력: 최근 $d_{GRU}=10$개의 IMU 측정값 $(u_{k-11:k-1})$
- 출력: 12개의 scaling parameter $(\gamma_{1:12,k})$
- 구조: 2-layer Bidirectional GRU → ReLU → Fully Connected
- GRU cell: update gate, reset gate, candidate hidden state

**2. Vision-Net (CNN 기반)**
- 입력: 좌/우 stereo 이미지
- 출력: 1개의 scaling parameter $(\gamma_{13,k})$
- 구조: Conv2D+ReLU → MaxPool → Conv2D+ReLU → MaxPool → Flatten → FC × 2

### Covariance Scaling

각 noise covariance matrix의 standard deviation 요소가 다음과 같이 조정:
$$
c_{k,i} = \bar{c}_{k,i} \cdot 10^{\upsilon \tanh(\gamma_{i,k})}
$$

여기서 $\upsilon$은 deviation 범위, $\bar{c}_{k,i}$는 수동 튜닝된 nominal value.

### Quaternion-based UKF-VIN

- **Quaternion $\in \mathbb{S}^3$** 으로 orientation 표현 → Euler angle singularity 회피
- **⊞/⊟ 연산자**로 quaternion space에서의 sigma point 생성 및 평균 계산
- **Aggregate Predict:** IMU 데이터 batch ($d_b$ steps)를 한 번에 처리
- **Quaternion Weighted Mean (QWM):** eigenvalue decomposition으로 quaternion 평균 계산

### Training

- **Loss:** orientation, position, velocity MSE의 가중합 ($w_q=1000, w_p=600, w_v=100$)
- **Dataset:** EuRoC V1 02 medium (MAV, IMU 200Hz, Stereo 20Hz)
- **EKF surrogate:** Gradient computation의 어려움으로 인해 training 시에는 EKF 사용 (UKF 대체)
- **Optimizer:** Adam with gradient clipping, L2 regularization
- **30 epochs** 학습

## 실험 결과

- Real-world EuRoC dataset 검증
- Orientation, position, velocity 오차가 빠르게 0으로 수렴
- Standard UKF 대비 모든 navigation component에서 우수한 성능

## Wikilinks
- [[rigor-filter|RIGOR Filter]] — Differentiable SR-UKF (관련: learnable noise covariance)
- [[kalmannet]] — Neural network aided Kalman filtering
- [[ma-ukf-meta-adaptive]] — MA-UKF (다른 접근법의 meta-learning adaptive UKF)
- [[auto-diff-data-assimilation]] — Auto-differentiable data assimilation
- [[ukf-learning-sigma-points]] — Model-based learning of sigma points

## References
- Ghanizadegan, K. & Hashim, H. A. (2025). DeepUKF-VIN: Adaptively-tuned Deep Unscented Kalman Filter for 3D Visual-Inertial Navigation based on IMU-Vision-Net. *Expert Systems With Applications*, 271, 126656.
- EuRoC dataset: Burri, M. et al. (2016). The EuRoC micro aerial vehicle datasets. *IJRR*.
