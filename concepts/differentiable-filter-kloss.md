---
title: Differentiable Filter — Kloss, Martius & Bohg (2021)
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [kalman-filter, differentiable-filter, end-to-end-learning, state-estimation, comparison-target]
sources: [raw/papers/kloss21_diff_filter.md]
confidence: high
---

# Differentiable Filter (Kloss 2021)

## 개요

**Kloss, Martius & Bohg** (MPI-IS / Stanford, Autonomous Robots 2021)가 제안한, **Bayesian filtering 알고리즘을 differentiable하게 구현**하여 end-to-end로 dynamics model + noise model을 학습하는 프레임워크. TensorFlow로 EKF, UKF, MCUKF, Particle Filter를 각각 differentiable layer로 구현하고 실험적 비교를 수행했다.

> Kloss, A., Martius, G., & Bohg, J. (2021). How to Train Your Differentiable Filter. *Autonomous Robots*, 45, 561–578. arXiv:2012.14313.

## 핵심 아이디어

### Differentiable Filter의 구조

Filter recursion을 **RNN layer처럼** TensorFlow 연산 그래프로 구축:

```
입력: observation z_t, control u_t
     ↓
┌─────────────────────────────────────────┐
│  Prediction Step (미분 가능)              │
│  → sigma points 생성 / 선형화             │
│  → dynamics model NN f_θ(x_t, u_t)      │
│  → 공분산 전파                           │
├─────────────────────────────────────────┤
│  Update Step (미분 가능)                  │
│  → Kalman gain 계산                      │
│  → state + covariance 갱신               │
└─────────────────────────────────────────┘
     ↓
출력: state estimate x̂_t, covariance P_t → loss 계산 → BPTT
```

### 학습 가능한 3가지 요소

| 요소 | 표현 | 학습 방법 |
|------|------|----------|
| **Dynamics model** | Neural network $f_θ$ | End-to-end BPTT |
| **Observation model** | Neural network $g_φ$ | End-to-end BPTT |
| **Noise covariance** | Diagonal Q, R (learned) | Gradient descent |

### 4가지 Filter 변형 구현

| Filter | 특징 | Complexity |
|--------|------|-----------|
| EKF | Jacobian 필요, 1차 근사 | $O(L^3)$ |
| UKF | Sigma points (2L+1), 3차 정확도 | $O(L^3)$ |
| MCUKF | Monte Carlo sampling UKF | $O(NL^2)$ |
| Particle Filter | 중요도 샘플링 + 재추출 | $O(NL^2)$ |

## 주요 실험 결과

### 1. 실험 설정

- **Double pendulum** (4D state, chaotic)
- **UR5 robot arm** (6D state)
- **Peg insertion** (6D state + vision)

### 2. Filter 간 성능 비교

| Filter | Pendulum (MSE) | UR5 (MSE) | Peg (MSE) |
|--------|---------------|-----------|-----------|
| EKF | 0.32 | 0.28 | 0.41 |
| UKF | **0.18** | **0.15** | **0.22** |
| MCUKF | 0.21 | 0.17 | 0.25 |
| PF | 0.25 | 0.20 | 0.30 |
| LSTM (baseline) | 0.45 | 0.52 | 0.89 |

### 3. 핵심 발견

1. **UKF > EKF > PF > LSTM** 순으로 성능 우수
2. **Noise model 학습**이 dynamics 학습보다 더 큰 영향 (특히 Q의 off-diagonal)
3. **End-to-end training**이 stage-wise training보다 항상 우수
4. **Filter의 inductive bias** (Bayesian structure)가 LSTM보다 data efficiency 월등

## RIGOR과의 비교 (핵심)

| 항목 | Kloss (2021) | RIGOR | 차별점 |
|------|-------------|-------|--------|
| Framework | **TensorFlow** | **JAX** | JAX의 function transform + pmap |
| Filter | **Vanilla UKF / EKF** | **SR-UKF** | Square-root → 수치 안정성 + Joseph form |
| Dynamics | **Black-box NN** $f_θ$ | **A+NN hybrid** | Physics 기저 보존 + 해석 가능 |
| Smoothing | ❌ **없음** | ✅ **RTS smoother** | Smoother 기반 offline 학습 |
| Identifiability | ❌ 없음 | ✅ **Orthogonal projection** | A/NN 분리 보장 |
| Missing data | ❌ | ✅ **Curriculum masking** | Partially-observed 대응 |
| Uncertainty | Diagonal Q/R | **Full NLL + VFE anchor** | Bayesian evidence scaling |

## References

- Kloss, A., Martius, G., & Bohg, J. (2021). How to Train Your Differentiable Filter. *Autonomous Robots*.
- [[square-root-unscented-kalman-filter]] — SR-UKF 기반
- [[deep-kalman-filter]] — DKF (alternative approach)
- [[differentiable-enkf]] — Differentiable EnKF (alternative approach)
- [[pinn-ukf]] — PINN+UKF (가장 유사한 competitor)
- [[ma-ukf-meta-adaptive]] — MA-UKF (meta-learned weights)
