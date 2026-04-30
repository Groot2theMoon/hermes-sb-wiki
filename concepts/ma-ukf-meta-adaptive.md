---
title: MA-UKF — Meta-Adaptive Unscented Kalman Filter
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [kalman-filter, meta-learning, end-to-end, state-estimation, comparison-target]
sources: [raw/papers/majewski26_ma_ukf.md]
confidence: high
---

# MA-UKF (Majewski 2026)

## 개요

**Majewski, Modzelewski, Żugaj & Lichota** (FUSION 2026)가 제안한, **sigma-point weight를 RNN meta-learner로 dynamically 합성**하는 end-to-end differentiable UKF. 기존 UKF의 static Unscented Transform parameterization을 **hyperparameter optimization 문제로 재정의**하고 memory-augmented meta-learning으로 해결.

> Majewski, K. et al. (2026). Robust Unscented Kalman Filtering via Recurrent Meta-Adaptation of Sigma-Point Weights. *FUSION 2026*. arXiv:2603.04360.

## 핵심 아이디어

### Meta-Adaptive UKF 구조

```
입력: observation z_t, control u_t
     ↓
┌──────────────────────────────────────────────┐
│  Recurrent Context Encoder (LSTM/GRU)          │
│  ← innovation history z_t - ŷ_t를 압축         │
│  → latent embedding h_t                        │
├──────────────────────────────────────────────┤
│  Policy Network (MLP)                          │
│  → h_t로부터 sigma-point weights w_m, w_c 합성 │
│  → filter의 "trust in prediction vs measurement" 결정 │
├──────────────────────────────────────────────┤
│  Standard UKF (고정 dynamics)                  │
│  → 합성된 weight로 UT 수행                     │
│  → Sigma point 전파 → Kalman update            │
└──────────────────────────────────────────────┘
     ↓
출력: state estimate → loss → BPTT through entire filter
```

### 기존 UKF의 한계

표준 UKF의 sigma-point weight는 3개의 고정 파라미터($\alpha, \beta, \kappa$)로 결정:
- $\lambda = \alpha^2(d + \kappa) - d$
- $W_m^{(0)} = \lambda / (d + \lambda)$, $W_c^{(0)} = \lambda / (d + \lambda) + (1 - \alpha^2 + \beta)$
- $W_m^{(i)} = W_c^{(i)} = 1 / (2(d + \lambda))$ for $i = 1, ..., 2d$

**문제:** 이 weight는 **implicit Gaussianity**를 가정 → heavy-tailed noise, time-varying dynamics에서 최적이 아님

### MA-UKF의 해결책

Meta-learning으로 **time-varying weight 합성**:
- RNN이 innovation history를 **latent context** $h_t$로 압축
- Policy network가 $h_t$로부터 **full weight vector** $w_t = \pi(h_t)$ 생성
- filter의 trust를 상황에 따라 adaptive하게 조절

## 실험 결과

| Method | RMSE (Gaussian) | RMSE (Glint noise) | OOD 일반화 |
|--------|----------------|-------------------|-----------|
| 표준 UKF | 1.00 (baseline) | 1.00 (baseline) | ❌ |
| Sage-Husa AKF | 0.92 | 0.88 | ❌ |
| IMM | 0.85 | 0.72 | ⚠️ partial |
| **MA-UKF** | **0.71** | **0.45** | **✅ OOD에서도 유지** |

## RIGOR Novelty Gap Matrix

| Paper | Filter | Dynamics | AD? | Smoother? | Reg. | Domain | Gap? |
|-------|--------|----------|-----|-----------|------|--------|------|
| **Majewski (2026)** | UKF (vanilla) | Fixed (known) | ✅ PyTorch | ❌ | None | Target tracking | ✅ |
| **RIGOR** | **SR-UKF** | **A+NN hybrid** | **✅ JAX** | **✅** | **Orthogonal proj.** | **Chaotic system ID** | — |

### 상호 보완 가능성

**가장 이상적인 시나리오:** RIGOR의 A+NN dynamics + MA-UKF의 adaptive weight를 결합

```
RIGOR-A+NN (dynamics 학습) + MA-UKF (adaptive weight) = ???
```
→ dynamics uncertainty + filtering uncertainty를 동시에 adaptive하게 처리 가능

## References

- Majewski, K. et al. (2026). Robust Unscented Kalman Filtering via Recurrent Meta-Adaptation. *FUSION 2026*.
- [[differentiable-filter-kloss]] — Differentiable Filter (Kloss 2021)
- [[pinn-ukf]] — PINN+UKF (soft-constraint competitor)
- [[square-root-unscented-kalman-filter]] — SR-UKF 기반
- [[adaptive-neural-ukf]] — Adaptive Neural UKF (Levy & Klein 2025)
