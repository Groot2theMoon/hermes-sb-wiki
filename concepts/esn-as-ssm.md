---
title: Echo State Networks as State-Space Models — A Systems Perspective
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [model, reservoir-computing, state-space-model, echo-state-network]
sources: [raw/papers/esn-as-ssm-singh25.md]
confidence: medium
---

# ESN as SSMs

## 개요

Echo State Network (ESN)을 **[[state-space-model|state-space model (SSM)]]** 체계로 재해석한 논문. Reservoir computing과 고전적 system identification, 현대적 structured SSM(S4/Mamba 계열)을 연결. (Singh & Raman 2025)

## 핵심 아이디어

ESN의 leaky recursion을 nonlinear discrete-time SSM으로 정식화하고, 세 가지 SSM 형태를 유도:

1. **Nonlinear SSM** — 원래 ESN 그대로 (echo state property = ISS)
2. **Local LTI linearization** — small-signal 근사로 interpretable poles / memory horizon 도출
3. **Lifted/Koopman random-feature expansion** — augmented state에서 linear SSM으로 변환 → transfer function 해석 가능

## ESN → SSM 시스템 매핑

| ESN 개념 | SSM 개념 |
|----------|----------|
| Echo State Property (ESP) | Input-to-State Stability (ISS) |
| Fading memory | Lyapunov / gain-margin certificate |
| Reservoir hyperparameters (leak, ρ) | Controllability/Observability 조건 |
| Teacher forcing | State estimation (KF/EKF) |
| Readout training | Kalman filter / EM |

## RIGOR와의 연결점

- **EM for hyperparameters** — leak, spectral radius, process/measurement noise를 EM으로 추정
- **Kalman/EKF-assisted readout learning** — teacher forcing을 state estimation으로 해석
- 논문의 comparison table에서 **ESN as SSM (2025)** 가 EM for noise cov. + neural readout의 선행 검증으로 언급됨

## 참고

- **arXiv:** 2509.04422
- Resonator: [[em-kalman-smoother-noise-covariance]] — RIGOR 논문의 comparison table에서 참조
