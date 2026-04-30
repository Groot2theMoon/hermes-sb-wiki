---
title: Adaptive Neural UKF — ProcessNet for Noise Covariance Learning (Levy & Klein 2025)
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [kalman-filter, adaptive-filter, neural-network, navigation, state-estimation]
sources: [raw/papers/levy25_adaptive_neural_ukf.md, raw/papers/versano26_hybrid_neural_ukf.md]
confidence: high
---

# Adaptive Neural UKF (Levy & Klein 2025)

## 개요

**Levy & Klein** (University of Haifa, IEEE TIV 2026)가 제안한 **ProcessNet** — UKF의 **process noise covariance Q를 end-to-end regression network로 adaptive하게 추정**하는 프레임워크. 같은 그룹의 **Versano & Klein (2026)** 은 이 개념을 확장하여 **Q와 R을 동시에 raw sensor measurements에서 직접 예측**하는 Hybrid Neural-Assisted UKF를 제안.

> Levy, A. & Klein, I. (2025). Adaptive Neural Unscented Kalman Filter. *IEEE Transactions on Intelligent Vehicles*, 2026. arXiv:2503.05490.

> Versano, G. & Klein, I. (2026). A Hybrid Neural-Assisted Unscented Kalman Filter for Unmanned Ground Vehicle Navigation. arXiv:2603.11649.

## 핵심 아이디어

### ProcessNet (Levy 2025)

```
입력: innovation sequence z_t - ŷ_t, filter state
     ↓
┌──────────────────────────────────────┐
│  ProcessNet (end-to-end regression)   │
│  → Input feature extraction            │
│  → Dense layers                        │
│  → Softplus output layer               │
│  Output: Q_k (process noise covariance) │
└──────────────────────────────────────┘
     ↓
표준 UKF (고정 dynamics, adaptive Q)

출력: improved state estimate
```

### Hybrid Neural-Assisted UKF (Versano 2026)

```
입력: raw IMU + GNSS measurements
     ↓
┌──────────────────────────────────────┐
│  DNN (Deep Neural Network)            │
│  → raw sensor data → latent features  │
│  → Output: Q_k + R_k (noise cov.)     │
├──────────────────────────────────────┤
│  UKF with adaptive Q/R                │
│  → 표준 UKF update (변경 없음)         │
└──────────────────────────────────────┘
```

**Sim2real training:** simulation에서만 학습 → real-world에서 generalization

## 실험 결과 (Hybrid Neural-UKF)

| Method | Position Error | 특징 |
|--------|---------------|------|
| 표준 UKF | baseline | 고정 Q/R |
| Adaptive (model-based) | 12.7% 개선 | Sage-Husa 방식 |
| **Hybrid Neural-UKF** | **추가 12.7% 개선** | **Sim2real, OOD 일반화** |

3개 dataset (off-road, passenger car, mobile robot)에서 일관된 성능 향상 확인.

## RIGOR과의 비교

| 항목 | Adaptive Neural UKF | RIGOR |
|------|--------------------|-------|
| **학습 대상** | **Q/R covariance만** | **Dynamics (A+NN) + Q/R** |
| **Dynamics** | Fixed / known | **Learned A+NN hybrid** |
| **Filter** | Vanilla UKF | **SR-UKF** |
| **Smoother** | ❌ | ✅ |
| **응용** | **Navigation** (IMU+GNSS) | **Chaotic system identification** |

## References

- Levy, A. & Klein, I. (2025). Adaptive Neural Unscented Kalman Filter. *IEEE TIV*.
- Versano, G. & Klein, I. (2026). Hybrid Neural-Assisted UKF for UGV Navigation.
- [[ma-ukf-meta-adaptive]] — MA-UKF (similar meta-learning approach but for weights)
- [[differentiable-filter-kloss]] — Differentiable Filter (Kloss 2021)
- [[pinn-ukf]] — PINN+UKF (soft-constraint hybrid)
