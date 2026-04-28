---
title: t-SNE — Visualizing Data
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, dimensionality-reduction]
sources: [raw/papers/vandermaaten08a.md]
confidence: high
---

# t-SNE

Laurens van der Maaten & Geoffrey Hinton (2008)의 **t-SNE (t-distributed Stochastic Neighbor Embedding)**는 고차원 데이터의 시각화를 위한 비선형 차원 축소 기법이다^[raw/papers/vandermaaten08a.md].

- **대조군:** PINN latent space, VAE latent space 시각화의 기준 도구
- [[variational-autoencoder]]의 latent space 분석 시 대조군으로 활용 가능
17|- SNE의 symmetrization + t-distribution tail heaviness로 crowding 문제 해결
- [[lle]] — LLE
- [[kernel-pca]] — Kernel PCA
