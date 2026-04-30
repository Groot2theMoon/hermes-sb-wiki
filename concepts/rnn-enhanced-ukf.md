---
title: RNN-Enhanced UKF — Deep Learning + UKF for Human Motion Prediction (Liu 2024)
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [kalman-filter, rnn, uncertainty-quantification, human-robot-interaction, state-estimation]
sources: [raw/papers/liu24_rnn_ukf.md]
confidence: high
---

# RNN-Enhanced UKF (Liu 2024)

## 개요

**Liu, Tian, Hu, Liang & Zheng** (University at Buffalo, ICRA 2024)가 제안한, **Lagrangian mechanics-based physical model + RNN 예측을 UKF로 통합**하는 human arm motion prediction 프레임워크. RNN의 예측을 **surrogate measurement**로 사용하고, RNN의 uncertainty로 UKF의 noise covariance를 adaptive하게 조절.

> Liu, W. et al. (2024). A Recurrent Neural Network Enhanced Unscented Kalman Filter for Human Motion Prediction. arXiv:2402.13045.

## 핵심 아이디어

### 이중 RNN 구조

```
입력: observed arm motion (bone vectors)
     ↓
┌──────────────────────────────────────────────┐
│  RNN 1: Muscle Force Predictor                │
│  → 과거 arm motion → 미래 muscle force 예측    │
│  → Lagrangian dynamics model로 force→motion 변환 │
├──────────────────────────────────────────────┤
│  RNN 2: Surrogate Measurement Generator       │
│  → 과거 motion → 미래 motion 직접 예측         │
│  → UKF의 measurement로 사용 (z_t 대체)         │
├──────────────────────────────────────────────┤
│  UKF with Uncertainty-Adaptive Noise           │
│  → RNN uncertainty가 클수록 Q/R 증가           │
│  → data-driven model의 부정확성 자동 보정       │
└──────────────────────────────────────────────┘
     ↓
출력: 미래 arm motion 예측 + uncertainty bound
```

### Uncertainty-Aware Noise Adaptation

$$Q_k = Q_0 + \beta \cdot \text{Var}(\text{RNN}_1)$$
$$R_k = R_0 + \gamma \cdot \text{Var}(\text{RNN}_2)$$

- RNN 예측의 분산이 클수록 noise covariance 증가
- → filter가 불확실한 예측을 덜 신뢰
- → physical model + data-driven model의 균형 자동 조절

## RIGOR Novelty Gap Matrix

| Paper | Filter | Dynamics | AD? | Smoother? | Reg. | Domain | Gap? |
|-------|--------|----------|-----|-----------|------|--------|------|
| **Liu (2024)** | UKF (vanilla) | Lagrangian + RNN | ❌ | ❌ | None | Human motion | ✅ |
| **RIGOR** | **SR-UKF** | **A+NN hybrid** | **✅ JAX** | **✅** | **Orthogonal proj.** | **Chaotic system ID** | — |

## References

- Liu, W. et al. (2024). A Recurrent Neural Network Enhanced Unscented Kalman Filter for Human Motion Prediction. arXiv:2402.13045.
- [[differentiable-filter-kloss]] — Differentiable Filter (Kloss 2021)
- [[pinn-ukf]] — PINN+UKF (soft-constraint approach)
- [[adaptive-neural-ukf]] — Adaptive Neural UKF (noise learning)
