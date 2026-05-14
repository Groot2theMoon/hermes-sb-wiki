---
title: "Variational Inference: A Review for Statisticians — Blei, Kucukelbir & McAuliffe"
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [variational-inference, bayesian, machine-learning, review, elbo, mean-field]
sources: [raw/papers/variational-inference-review-blei17.md]
confidence: high
---

# Variational Inference: A Review for Statisticians

**Blei, Kucukelbir & McAuliffe** (Columbia & Google, JASA 2017). arXiv:1601.00670.

## 개요

Variational Inference (VI)의 comprehensive review. VI는 MCMC보다 빠르게 posterior 근사를 optimization 문제로 바꾸는 방법. RIGOR의 VFE loss는 VI의 ELBO를 filtering 맥락으로 확장한 것.

## 핵심 내용

- **ELBO:** $\log p(x) \geq \mathbb{E}_{q(z)}[\log p(x,z)] + H(q)$
- **Mean-field VI:** $q(z) = \prod q_j(z_j)$ — factorized family
- **CAVI:** Coordinate-Ascent VI (closed-form for exponential families)
- **BBVI:** Black-box VI (score gradient, Monte Carlo)
- **Reparameterization trick:** $z = \mu + \sigma \cdot \epsilon$로 gradient variance 감소

## RIGOR와의 연결

| VI concept | RIGOR counterpart |
|-----------|-------------------|
| ELBO $\leq \log p(x)$ | VFE loss (NLL + KL_dyn) |
| Mean-field $q(z)$ | Filter posterior $p(x_t\|y_{1:t})$ |
| Score gradient | Reparameterization through UKF |
| Amortized VI (DVBF) | RIGOR: full UKF (not amortized) |

## Wikilinks
- [[dvbf-karl16]] — DVBF: VI를 filtering에 적용
- [[k-step-rollout-vfe-loss]] — RIGOR의 VFE loss
- [[variational-bayes-adaptive-kalman-filter]] — VB 기반 noise adaptation
