---
title: Locally Linear Embedding (LLE)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, dimensionality-reduction]
sources: [raw/papers/lleintro.md]
confidence: high
---

# Locally Linear Embedding

Roweis & Saul (2000)의 **LLE**는 국소 선형성을 가정한 비선형 차원 축소 기법이다^[raw/papers/lleintro.md].

- **대조군:** 고전 manifold learning — 현대 VAE/Mamba latent space 분석의 기준
- 각 점을 이웃의 선형 결합으로 재구성 → 저차원 임베딩 보존
- [[t-sne]], [[kernel-methods]]와 함께 차원 축소 3대 고전 기법