---
title: "Deep Variational Bayes Filters (DVBF) — Unsupervised State Space Learning from Raw Data"
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [kalman-filter, variational-inference, state-space-model, deep-learning, unsupervised-learning, differentiable-filtering]
sources: [raw/papers/dvbf-karl16.md]
confidence: high
---

# Deep Variational Bayes Filters (DVBF)

**Karl, Soelch, Bayer & van der Smagt** (Volkswagen Data Lab, ICLR 2017). arXiv:1605.06432.

## 개요

DVBF는 **latent Markovian state space model을 raw data에서 비지도 학습**하는 variational inference 기반 방법이다. 핵심 아이디어는 transition model에 backpropagation을 통과시켜 state space 가정을 강제하는 것 — 이를 통해 latent embedding의 정보량을 크게 향상시키고 현실적인 long-term prediction이 가능해진다.

## 핵심 방법론

- **Variational ELBO:** VAE 프레임워크를 시계열로 확장 → 인코더가 근사 사후분포 $q(z_t | x_{1:T})$, 디코더가 $p(x_t | z_t)$
- **Transition model:** $z_{t+1} = f(z_t, u_t)$ — locally linear transition (LSTM-like) 또는 non-Markovian
- **Backprop through transition:** KL divergence term이 transition을 통과하여 gradient가 흐름 → state space의 smoothness와 일관성 강제
- **Multi-step prediction loss** 포함하여 long-term consistency 보장

## RIGOR와의 차별점

| 요소 | DVBF | RIGOR |
|------|------|-------|
| **State space 구조** | Learned latent $z$ (black-box) | 물리적 state $x$ + A(x)·x 구조 |
| **Filtering** | Variational encoder (amortized) | UKF (deterministic, interpretable) |
| **Dynamics** | Learned neural transition | A(x)·x + NN residual |
| **Loss** | VAE ELBO | VFE = NLL + KL_dyn |
| **Uncertainty** | Encoder variance | UKF covariance (P_pred, P_filt) |
| **Interpretability** | 낮음 (latent z) | 높음 (A, Q, R 구조) |

**핵심 차이:** DVBF는 **모든 것을 black-box로 학습** (latent z, transition, encoder). RIGOR는 **UKF의 구조적 skeleton (A, Q, R, sigma points) 위에 NN을 residual로 추가** — interpretability와 data efficiency에서 우위.

## 한계 (RIGOR 대비)

1. Latent z가 물리적 의미를 갖지 않음 — 도메인 지식 통합 불가
2. Amortized encoder는 OOD generalization에 취약
3. Transition의 locally linear 근사가 강한 비선형성에서 breakdown 가능
4. Observation model이 data-driven이므로 partial observation에서 어려움

## 참고 문헌

- Karl et al. (2017). Deep Variational Bayes Filters. ICLR 2017. arXiv:1605.06432.
- Krishnan et al. (2015). Deep Kalman Filters. NeurIPS Workshop.
- Fraccaro et al. (2017). A Disentangled Recognition and Nonlinear Dynamics Model for Unsupervised Learning. NeurIPS.

## Wikilinks
- [[rigor-filter]] — RIGOR의 UKF + sigma cloud conditioning과 대비
- [[deep-kalman-filter]] — Krishnan의 DKF (동일 계열)
- [[k-step-rollout-vfe-loss]] — RIGOR의 multi-step rollout vs DVBF의 prediction loss
- [[variational-bayes-adaptive-kalman-filter]] — VB 기반 noise adaptation과 비교
