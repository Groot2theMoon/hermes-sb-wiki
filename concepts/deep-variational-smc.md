---
title: Deep Variational Sequential Monte Carlo — Differentiable Particle Filtering
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, sequence-modeling, state-space-model, variational-inference, kalman-filter]
sources: [raw/papers/deep-variational-smc.md]
confidence: medium
---

# Deep Variational SMC

Particle filter (Sequential Monte Carlo) + variational inference를 결합하여 **non-Gaussian posterior**를 처리할 수 있는 미분 가능한 상태 추정.

## DKF와의 비교

| Feature | DKF | Deep Variational SMC |
|---------|-----|---------------------|
| Posterior | Gaussian (Laplace approx) | Particle-based (non-parametric) |
| Inference | RNN-based recognition net | SMC with learned proposals |
| Strength | Fast, stable | Handles multi-modal posterior |
| Weakness | Gaussian assumption 제한 | More complex training |

## 관련 페이지
- [[deep-kalman-filter]] — 가우시안 variational inference
- [[enhancing-state-estimation-robots]] — Differentiable EnKF (또 다른 particle-free 대안)
