---
title: "Lur'e Stability Analysis — A+NN Systems"
created: 2026-05-01
updated: 2026-05-01
type: concept
tags: [lure-system, contractivity, sector-bound, aizerman, lmi, stability, nn-control]
sources:
  - raw/papers/shima-davydov-bullo-contractivity-lure-systems.md
  - raw/papers/hedesh-siami-positivity-stability-sector-bound-nn.md
  - raw/papers/hedesh-local-stability-nn-feedback-positivity.md
confidence: high
---

# Lur'e Stability Analysis for A+NN Systems

## 개요

Lur'e system은 **선형 동적 시스템 + 피드백 비선형성** 구조를 가진 제어 시스템의 한 형태이다.
RIGOR의 A+NN 구조 (x_{t+1} = A·x_t + NN(x_t))는 Lur'e system의 특수한 경우로 볼 수 있으며,
이러한 관점에서 Lur'e stability analysis를 적용할 수 있다.

## 핵심 논문

### Shima, Davydov & Bullo (2025) — Contractivity LMI
[[shima-contractivity-lure|Contractivity Analysis for Lur'e Systems]]

**Lipschitz nonlinearity에 대한 필요충분 LMI:**
```
∃ P > 0, λ ≥ 0 such that:
[ A^T P A - ρ^2 P + λ L^2 I    A^T P B    ]  ⪯ 0
[ B^T P A                     B^T P B - λ I ]
```
여기서 L은 nonlinearity의 Lipschitz 상수, ρ는 contraction rate.

- **필요충분 조건** — Polytopic relaxation보다 덜 보수적
- **Discrete/continuous-time 모두 지원**
- **Controller gain design LMI도 제공**

### Hedesh & Siami (2024) — NN Sector Bound
[[hedesh-siami-sector-bound|Sector-Bounded Nonlinearity for NN Controllers]]

FFNN (bias 없음)의 sector bound를 weight와 activation function에서 직접 계산:
- **Sector [α, β]** — NN의 input-output mapping이 sector 내에 있음
- **Positive Aizerman conjecture** — sector bound가 Hurwitz/Metzler 조건을 만족하면 global exponential stability
- **Continuous-time 시스템 지원**

### Hedesh, Wafi & Siami (2025) — Local Stability & ROA
[[hedesh-local-stability-roa|Local Stability and ROA for NN Feedback Systems]]

Localized Aizerman conjecture → ROA (Region of Attraction) 추정:
- **Lyapunov-based LMI 방법** — invariant sublevel set 구성
- **Layer-wise local sector bound** — FFNN에 대한 tight local sector bound (최초)
- 기존 IQC 방식보다 ROA 크기와 scalability 모두 우수

## RIGOR A+NN에의 적용

### Problem Formulation
RIGOR의 A+NN: x_{t+1} = A·x_t + NN_θ(x_t), 여기서 NN_θ는 feedforward network.

이는 Lur'e system: x_{t+1} = A·x_t + B·φ(C·x_t)에서 B=I, C=I, φ=NN_θ인 특수한 경우.

### Stability Verification Pipeline
1. **Sector bound 계산** — Hedesh & Siami의 방법으로 NN_θ의 sector [α, β] 계산
2. **Contractivity LMI** — Shima의 LMI에 sector bound 대입 → 필요충분 조건 확인
3. **Local ROA** — 필요시 Hedesh (2025)의 local stability 분석으로 ROA 추정

### Key Advantages over Current Heuristic
- **Heuristic total budget** (γ + α·s < 1.0) — 항상 위반, 근거 부족
- **→ Lur'e LMI 기반** — 필요충분 조건, rigorous
- → EM Q,R의 self-calibrating loop + LMI stability = **강력한 stability argument**

## Related Concepts
- [[ren-recurrent-equilibrium-networks]] — REN: contracting + IQC-bound 보장 모델
- [[youla-ren-stabilizing-controllers]] — Youla-REN: 모든 안정화 비선형 제어기 학습
- [[lbdn-lipschitz-bounded-networks]] — LBDN: SDP Lipschitz bound direct parameterization
- [[rnn-sdp-lipschitz-certification]] — RNN-SDP: RNN Lipschitz certification
- [[ukf-stochastic-stability]] — UKF Stochastic Stability with Fading Measurements
- [[ekf-stochastic-stability-fading]] — EKF Stochastic Stability over Fading Channels
- [[em-kalman-smoother-noise-covariance]] — EM Q,R noise covariance estimation
- [[kalmannet]] — Differentiable Kalman filtering
- [[esn-as-ssm]] — Echo State Networks as State Space Models

## References
- Shima, Davydov, Bullo (2025). arXiv:2503.20177
- Hedesh & Siami (2024). arXiv:2406.12744
- Hedesh, Wafi & Siami (2025). arXiv:2505.22889
- Khalil (2002). Nonlinear Systems. (Lur'e system / Circle criterion / Popov criterion)
