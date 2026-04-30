---
title: RTSNet — Learning to Smooth in Partially Known State-Space Models
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [model, differentiable-filtering, neural-smoother, state-estimation]
sources: [raw/papers/rtsnet-revach21.md]
confidence: high
---

# RTSNet

## 개요

RTSNet은 [[kalmannet|KalmanNet]]의 smoothing 확장판으로, Rauch-Tung-Striebel (RTS) smoother의 **forward + backward pass**를 모두 학습 가능한 구조로 변환. ([[guy-revach|Revach]], [[nir-shlezinger|Shlezinger]] et al. 2023, IEEE TSP)

## 핵심 아이디어

- RTS smoother의 two-pass 구조 보존
  - **Forward pass:** Kalman filter (학습된 Kalman gain GRU 사용)
  - **Backward pass:** RTS correction gain도 RNN으로 대체
- **Deep unfolding** — backward pass를 여러 번 반복하여 추정 정확도 향상
- MSE loss로 supervised training

## KalmanNet과의 차이

| 차원 | KalmanNet | RTSNet |
|------|-----------|--------|
| 태스크 | Filtering (실시간) | Smoothing (offline/post-hoc) |
| Pass | Forward only | Forward + Backward |
| 학습 파라미터 | 1 GRU (Kalman gain) | 2 GRUs (forward + backward gains) |
| Deep unfolding | ❌ | ✅ (multiple backward iterations) |
| 용도 | Online 추정 | Offline refinement / data imputation |

## 관련 연구

- [[kalmannet]] — Filtering 버전 (선행 연구)
- [[em-kalman-smoother-noise-covariance]] — EM 기반 RTS smoother (RIGOR에서 사용)
- [[recursive-kalmannet]] — Uncertainty quantification 개선

## 참고

- **arXiv:** 2110.04717
- **Journal:** IEEE Transactions on Signal Processing, Vol. 71, 2023
