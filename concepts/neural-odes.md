---
title: Neural Ordinary Differential Equations — Continuous-Depth Latent Dynamics
created: 2026-04-29
updated: 2026-05-03
type: concept
tags: [model, dynamics, neural-operator, system-identification, training, implicit-depth]
sources: [raw/papers/neural-odes.md]
confidence: high
---

# Neural Ordinary Differential Equations (Neural ODEs)

Chen, Rubanova, Bettencourt, Duvenaud (NeurIPS 2018 Best Paper) — 신경망을 ODE 솔버로 이산화하는 대신, **연속적 미분방정식**으로 모델링.

## 핵심 아이디어

기존 ResNet: h_{t+1} = h_t + f(h_t, θ) → 이산적

Neural ODE: dh/dt = f(h(t), θ) → 연속적

ODE solver (e.g., dopri5)로 궤적 적분.

## DKF와의 비교

| Dimension | DKF | Neural ODE |
|-----------|-----|-----------|
| Dynamics | Stochastic (z_t ∼ p(z_t|z_{t-1})) | Deterministic (dh/dt = f) |
| Time | Discrete | **Continuous** |
| Inference | Variational | Adjoint method |
| Physics | None | ODE structure |

## 관련 페이지
- [[hamiltonian-neural-networks]] — 물리 기반 ODE (Hamiltonian)
- [[deep-kalman-filter]] — 이산시간 variational dynamics
- [[fourier-neural-operator]] — Operator learning (연속공간)
- [[monotone-operator-equilibrium-networks]] — monDEQ: 이산시간 implicit-depth model, Neural ODE의 direct competitor (NeurIPS 2020, CIFAR-10 89%)
