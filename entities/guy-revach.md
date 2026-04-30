---
title: Guy Revach — Differentiable Filtering & Model-Based Deep Learning
created: 2026-04-30
updated: 2026-04-30
type: entity
tags: [person, researcher, differentiable-filtering, signal-processing]
sources: [raw/papers/kalmannet-revach21.md, raw/papers/rtsnet-revach21.md]
confidence: medium
---

# Guy Revach

## 개요

Guy Revach은 Technion - Israel Institute of Technology에서 활동하는 연구자로, **model-based deep learning for signal processing** 분야, 특히 **Kalman 필터링에 neural network를 결합하는 hybrid 접근법**으로 잘 알려져 있음.

## 주요 논문

- **KalmanNet** (2022, IEEE TSP) — [[kalmannet]]: RNN으로 Kalman gain을 대체한 hybrid filter
- **RTSNet** (2023, IEEE TSP) — [[rtsnet]]: RTS smoother를 학습 가능하게 확장
- **Adaptive KalmanNet** (2023) — Fast adaptation for varying SS models
- **Bayesian KalmanNet** (2023) — UQ를 위한 Bayesian 확장
- **GSP-KalmanNet** (2023) — Graph signal processing으로 확장
- **Latent-KalmanNet** (2023) — High-dimensional latent state tracking

## 관련 개념

- [[kalmannet]]
- [[rtsnet]]
- [[recursive-kalmannet]] — 후속 연구 (다른 저자군)
- [[em-kalman-smoother-noise-covariance]] — RIGOR에서 KalmanNet을 baseline으로 비교
