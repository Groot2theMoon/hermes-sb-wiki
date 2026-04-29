---
title: Denoising Diffusion Probabilistic Models (DDPM)
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, generative-model, neural-network, landmark-paper, training]
sources: []
confidence: high
---

# Denoising Diffusion Probabilistic Models (DDPM)

## 개요

**Ho, Jain, Abbeel (2020)**이 제안한 DDPM은 Markov chain 기반의 generative model로, 노이즈를 점진적으로 제거하여 데이터를 생성한다. [[score-based-generative-modeling-sde|Score-SDE]] 프레임워크에서 VP-SDE로 통합된다.

Forward process: $$ q(x_t|x_{t-1}) = \mathcal{N}(x_t; \sqrt{1-\beta_t}x_{t-1}, \beta_t I) $$

Reverse process: $$ p_{\theta}(x_{t-1}|x_{t}) = \mathcal{N}(x_{t-1}; \mu_{\theta}(x_t, t), \Sigma_{\theta}(x_t, t)) $$

## 변형 및 발전

- **DDIM** (Song et al., 2021): Deterministic sampling으로 가속
- **DiT** (Peebles & Xie, 2023): Transformer 기반 [[diffusion-transformers-dit|Diffusion Transformer]]
- **Latent Diffusion** (Rombach et al., 2022): Latent space에서 diffusion으로 효율화
- **Score-SDE** (Song et al., 2021): SDE/ODE 통합 프레임워크 → [[score-based-generative-modeling-sde]]

## References
- [[diffusion-lattice]] — Lattice field theory 응용
- [[diffusion-transformers-dit]] — Transformer 기반 개선
- [[score-based-generative-modeling-sde]] — SDE 통합 이론
