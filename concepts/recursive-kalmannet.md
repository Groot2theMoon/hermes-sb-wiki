---
title: Recursive KalmanNet — Deep Learning-Augmented Kalman Filtering with Consistent Uncertainty Quantification
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [model, differentiable-filtering, neural-kalman, uncertainty-quantification]
sources: [raw/papers/recursive-kalmannet-mortada25.md]
confidence: medium
---

# Recursive KalmanNet

## 개요

[[kalmannet|KalmanNet]] 프레임워크를 확장하여 **Kalman gain과 error covariance를 동시에 학습**하는 최초의 KalmanNet 변형. Joseph's formula로 covariance를 recursive하게 전파하여 **일관된 uncertainty quantification** 달성. (Mortada et al. 2025, EUSIPCO 2025)

## 핵심 아이디어

- **두 개의 GRU 기반 RNN:**
  - Gain RNN: Kalman gain 추정 (기존 KalmanNet과 동일)
  - Covariance RNN: Joseph's formula의 noise-dependent covariance 항 B_t의 Cholesky factor 추정
- Joseph's formula: `P_{t|t} = (I - K_t H_t) P_{t|t-1} (I - K_t H_t)^T + K_t R_t K_t^T`
  - Propagation covariance A_t는 이전 covariance + 현재 gain으로 **closed-form 계산**
- 학습: **Gaussian negative log-likelihood (NLL)** — balancing hyperparameter 불필요

## KalmanNet 대비 개선점

| 측면 | KalmanNet | Recursive KalmanNet |
|------|-----------|---------------------|
| Gain 학습 | ✅ | ✅ |
| Covariance 학습 | ❌ (고정) | ✅ (Joseph's formula) |
| MSMD (covariance 일관성) | 측정 안함 | **이론치에 근접** |
| Loss | MSE | NLL (hyperparameter-free) |
| 비가우시안 잡음 | 대응 제한적 | **bimodal Gaussian에서 우수** |

## 관련 연구

- [[kalmannet]] — 선행 연구 (Revach 2022)
- [[rtsnet]] — Smoothing 확장 (동일 저자군)
- Bayesian KalmanNet (2023) — UQ 시도 (다른 접근법)
- [[em-kalman-smoother-noise-covariance]] — RIGOR의 EM 기반 Q,R 추정 (다른 철학)

## 참고

- **arXiv:** 2506.11639
- **Conference:** EUSIPCO 2025
