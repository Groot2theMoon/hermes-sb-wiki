---
title: Neural Extended Kalman Filter for Structural Systems — Liu, Chatzi et al. (2022)
created: 2026-05-08
updated: 2026-05-08
type: concept
tags: [kalman-filter, ekf, neural-network, structural-analysis, shm, state-estimation, differentiable-filter]
sources: [raw/papers/liu22-neural-ekf.md]
confidence: high
---

# Neural Extended Kalman Filter for Structural Systems

**Wei Liu, Zhilu Lai, Kiran Bacsa, Eleni Chatzi** (ETH Zürich, 2022/2023). Structural Health Monitoring, 2023.

## 개요

EKF의 process dynamics와 observation model을 **neural network로 parameterize**하여 end-to-end로 학습하는 프레임워크. Variational inference (VI) framework 하에서 EKF가 inference 엔진을 담당하고, NN이 dynamics + observation의 learnable component를 제공한다.

## 핵심 아이디어

```
입력: partial observation y_t
     ↓
┌────────────────────────────────┐
│  Neural EKF                    │
│  ├─ NN-dynamics: x_{t+1} = f_θ(x_t) + noise
│  ├─ NN-observation: y_t = h_θ(x_t) + noise  │
│  └─ EKF inference: predict → update          │
└────────────────────────────────┘
     ↓
출력: full state estimate + covariance
```

**VI framework:** ELBO 최적화로 NN parameter θ 학습. EKF 구조가 inductive bias를 제공하여, 순수 VI (DKF 등)보다 dynamics-inference consistency가 우수함을 보임.

## RIGOR와의 차이

| Aspect | Neural EKF (Chatzi) | RIGOR |
|--------|--------------------|-------|
| Filter | EKF (linearization) | SR-UKF (sigma point) |
| NN role | Full dynamics + observation | Dynamics residual only (A+NN) |
| Filter params | None (standard EKF) | Learnable spread, UFI |
| Training | VI (ELBO) | NLL + rollout |
| Domain | Structural health monitoring | General dynamical systems |
| Autodiff | PyTorch | JAX |

## RIGOR에의 시사점

1. **동일 도메인 검증:** Bouc-Wen hysteresis가 SHM domain이므로, Chatzi의 접근 (EKF-based + NN)이 RIGOR에 대한 간접적 검증을 제공.
2. **VI 프레임워크:** RIGOR의 loss (NLL + rollout)는 VI (ELBO)의 특수한 형태로 볼 수 있음. Chatzi의 VI formulation이 RIGOR loss의 이론적 grounding을 강화.
3. **한계:** EKF는 linearization에 의존하므로 강한 비선형성 (hysteresis)에서는 SR-UKF가 유리함. RIGOR의 sigma point 접근이 본질적으로 더 적합.

## Wikilinks
- [[eleni-chatzi]] — Eleni Chatzi (ETH Zürich, SHM 그룹)
- [[differentiable-filter-kloss]] — Differentiable Filter (Kloss 2021)
- [[deep-kalman-filter]] — DKF: VI for temporal generative models
- [[rigor-filter]] — RIGOR Filter experiments
- [[kalmannet]] — KalmanNet: Neural KF gain
