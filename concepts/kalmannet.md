---
title: KalmanNet — Neural Network Aided Kalman Filtering for Partially Known Dynamics
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [model, differentiable-filtering, neural-kalman, state-estimation]
sources: [raw/papers/kalmannet-revach21.md]
confidence: high
---

# KalmanNet

## 개요

KalmanNet은 **model-based + data-driven hybrid** 실시간 상태 추정기. 고전적 Kalman Filter (KF)의 연산 흐름을 유지하면서, Kalman gain 계산을 compact RNN (GRU)으로 대체하여 **부분적으로만 알려진 dynamics**에서도 동작함. ([[guy-revach|Revach]], [[nir-shlezinger|Shlezinger]] et al. 2022, IEEE TSP)

## 핵심 아이디어

- KF의 predict-update loop를 보존 → **해석 가능성 유지**
- Kalman gain GRU가 **innovation, state correction, Jacobian**을 feature로 받아서 실시간 gain 추정
- 학습은 짧은 trajectory 단위로 수행되지만, **임의 길이 시퀀스에 일반화**됨
- 부분 domain knowledge (근사 transition/emission 함수)는 prediction step에서 계속 사용

## 장점

- EKF/UKF/PF보다 model mismatch에 강함
- 순수 data-driven DNN보다 data-efficient (더 적은 파라미터)
- Sequence-length invariance — 학습보다 긴 시퀀스에도 적용 가능
- Nonlinear dynamics에서도 KF의 구조적 soundness 유지

## 한계

- Ground-truth state가 필요한 supervised training
- Noise covariance를 **고정** (EM baseline) — [[em-kalman-smoother-noise-covariance|Shumway-Stoffer]]의 EM 방식은 baseline으로만 사용
- Uncertainty quantification이 불완전 (후속: Bayesian KalmanNet, [[recursive-kalmannet|Recursive KalmanNet]])

## 관련 연구

- [[kf-ekf-ukf-srukf-differentiable]] — 다양한 필터 변형 간 비교 (differentiable filtering 관점)
- [[rtsnet]] — RTSNet: smoothing으로 확장 (동일 저자)
- [[recursive-kalmannet]] — Joseph's formula로 covariance 일관성 확보
- [[maml-kalmannet]] — MAML 기반 meta-learning으로 data efficiency 향상
- [[em-kalman-smoother-noise-covariance]] — RIGOR의 EM 기반 Q,R 추정
- [[adaptive-neural-ukf]] — ProcessNet 방식의 대안
- [[differentiable-filter-kloss]] — Differentiable Filter (Kloss 2021)

## 참고

- **arXiv:** 2107.10043
- **GitHub:** github.com/KalmanNet/KalmanNet_TSP
