---
title: PINN-UKF — Physics-Informed Neural Network + Adaptive UKF
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [state-estimation, kalman-filter, pinn, hybrid-modeling, comparison-target]
sources: [raw/papers/decurto24_pinn_ukf.md]
confidence: high
---

# PINN-UKF (de Curtò 2024)

## 개요

**de Curtò & de Zarzà** (Electronics, MDPI 2024)가 제안한, **Physics-Informed Neural Network (PINN)을 UKF의 transition model로 통합**하는 하이브리드 상태 추정 프레임워크. PINN은 hybrid loss (data MSE + physics residual)로 학습되고, UKF는 adaptive noise covariance + Monte Carlo Dropout 기반 uncertainty quantification로 강화됨.

> de Curtò, J. & de Zarzà, I. (2024). Hybrid State Estimation: Integrating Physics-Informed Neural Networks with Adaptive UKF for Dynamic Systems. *Electronics*, 13(11), 2208.

## 핵심 아이디어

### PINN + UKF 통합 구조

```
입력: noisy observation z_t
     ↓
┌──────────────────────────────────────┐
│  PINN Transition Model                │
│  → Dense(128) → BN → MC Dropout      │
│  → Dense(128) → BN → MC Dropout      │
│  → Dense(64) → Dense(64) → output    │
│  Loss: L = L_data + λ·L_physics      │
├──────────────────────────────────────┤
│  Adaptive UKF                         │
│  → Sigma point 생성 (UT)              │
│  → PINN으로 sigma point 전파           │
│  → Adaptive Q: Q_{k+1} = α P_k + Q₀  │
│  → Kalman update                      │
└──────────────────────────────────────┘
     ↓
출력: state estimate + uncertainty bound
```

### Hybrid Loss Function

$$L = L_{\text{data}} + \lambda_{\text{physics}} L_{\text{physics}}$$

- $L_{\text{data}}$: MSE between prediction and ground truth
- $L_{\text{physics}}$: Physics constraint residual (physical law violation)
- $\lambda_{\text{physics}}$: Adaptive weighting factor

### Adaptive Noise Covariance

$$Q_{k+1} = \alpha P_k + Q_0$$

- $\alpha = 0.01$ (empirically chosen)
- Augmented state vector: $\tilde{x}_k = [x_k; \theta]$ (model parameters included)

## RIGOR Novelty Gap Matrix

| Paper | Filter | Dynamics | AD? | Smoother? | Reg. | Domain | Gap? |
|-------|--------|----------|-----|-----------|------|--------|------|
| **de Curtò (2024)** | UKF (vanilla) | PINN (soft) | ✅ PyTorch | ❌ | None | General | ✅ |
|| **RIGOR** | **SR-UKF** | **A+NN (hard)** | **✅ JAX** | **✅** | **Orthogonal proj.** | **Chaotic** | — |

### 핵심 차별점 요약

PINN-UKF는 **"PINN이라는 black-box + physics loss term"** 으로 접근하는 반면, RIGOR는 **"물리 방정식(A) + neural residual(NN)"** 으로 **구조적 분해**를 수행합니다. 이 차이는:

1. **해석 가능성:** PINN-UKF는 학습 후 A 파라미터를 추출할 수 없지만, RIGOR는 A의 의미가 보존됨
2. **Identifiability:** PINN-UKF는 NN이 물리 모드를 학습할 수 있어 over-parameterization 문제 발생. RIGOR의 orthogonal projection이 이를 방지
3. **외삽:** PINN-UKF는 training distribution을 벗어나면 PINN이 물리 법칙을 위반할 수 있지만, RIGOR의 A는 물리적으로 의미있는 dynamics를 유지

## References

- de Curtò, J. & de Zarzà, I. (2024). Hybrid State Estimation: Integrating Physics-Informed Neural Networks with Adaptive UKF. *Electronics*, 13(11), 2208.
- [[differentiable-filter-kloss]] — Differentiable Filter (Kloss 2021) — 같은 패러다임의 선행 연구
- [[square-root-unscented-kalman-filter]] — SR-UKF 기반
- [[ma-ukf-meta-adaptive]] — MA-UKF (meta-learned weights, alternative)
- [[orthogonal-projection-regularization]] — Orthogonal projection for A+NN identifiability
- [[structured-hybrid-mechanistic-models]] — A+NN 패러다임의 이론적 배경
