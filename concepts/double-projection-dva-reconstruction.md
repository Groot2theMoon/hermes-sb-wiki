---
title: "Double Projection for Dynamical System Reconstruction — DVAE with State+Noise Estimation"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [dynamical-system-reconstruction, dvae, variational-autoencoder, stochastic-dynamics, state-estimation, delay-embedding]
sources:
  - raw/papers/2510.01089v2.md
confidence: high
---

# Double Projection DSR — Dynamical System Reconstruction with DVAE

**Sip, Breyton, Petkoski & Jirsa** (Aix Marseille Univ, INSERM, 2025). arXiv:2510.01089v2.

## 개요

부분 관측에서 동역학계의 stochastic 모델을 학습하는 DVAE (Dynamical VAE) 기반 방법. 핵심 아이디어: **double projection** — 관측을 state trajectories + noise time series 양쪽으로 매핑 → stochastic dynamics 학습.

**RIGOR와 다른 계열:** DVAE = generative model (VAE). Filter가 아닌 encoder-decoder 구조. "delay embedding"은 Introduction에서 배경으로 언급만 됨 — 실질적인 방법론은 아님.

## Double Projection 구조

```
관측 y_t → Encoder → [state z_t, noise ε_t]
              ↓
    Dynamics: z_{t+1} = f(z_t) + ε_t  (stochastic)
              ↓
    Decoder: ŷ_t = g(z_t)  (reconstruction)
```

## 핵심 기여
- Noise를 posterior에서 sampling → multi-step prediction 가능
- Teacher forcing interval 조절로 deterministic ↔ stochastic regime transition
- 6개 benchmark (simulated + experimental data)에서 검증

## RIGOR와의 관계

**약한 연관성:**
- DSR 문제 설정은 유사 (partial obs → dynamics 학습)
- DVAE는 seq-to-seq generative, RIGOR는 recursive filter
- DVAE는 long-term dynamics generation에 강점, RIGOR는 online filtering에 강점
- Delay embedding(Takens) 언급 있으나 방법론 core는 아님

**참고 가치:** RIGOR에서 rollout loss 도입 시 DVAE의 multi-step prediction 전략 참고 가능.

## Wikilinks
- [[dynamical-variational-autoencoder]] — DVAE 기초
- [[takens-delay-embedding]] — Takens embedding 정리
- [[rigor-filter]] — RIGOR differentiable SR-UKF
- [[neural-ode-dynamical-systems]] — NODE 기반 DSR 접근

## References
- Sip, V., Breyton, M., Petkoski, S., & Jirsa, V. (2025). Double Projection for Reconstructing Dynamical Systems. arXiv:2510.01089v2.
