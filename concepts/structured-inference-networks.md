---
title: Structured Inference Networks for Nonlinear State Space Models — Deep Markov Models
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, sequence-modeling, state-space-model, variational-inference, latent-dynamics]
sources: [raw/papers/structured-inference-networks-ssm.md]
confidence: high
---

# Structured Inference Networks for Nonlinear SSMs (DMM)

[[rahul-krishnan|Krishnan]], [[uri-shalit|Shalit]], Sontag (AAAI 2017) — DKF의 직접 후속. Inference network를 bidirectional RNN → **structured posterior**로 발전시키고, Pyro의 Deep Markov Model (DMM) 구현의 기반.

## 핵심 기여

DKF 대비 개선:
- **Structured inference:** q(z_1:T | x_1:T)를 더 풍부하게 모델링 (not mean-field)
- **Backward RNN:** 과거 + 미래 정보를 모두 통합
- Pyro 프레임워크에 standard implementation으로 채택

## 관련 페이지
- [[deep-kalman-filter]] — 전신. DKF는 이 논문의 base
- [[david-sontag]] — 공동 저자
