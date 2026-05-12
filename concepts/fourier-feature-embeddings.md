---
title: "Fourier Feature Embeddings"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [positional-encoding, spectral-bias, pinn, neural-representation]
confidence: medium
---

# Fourier Feature Embeddings

Fourier feature embeddings are input encoding strategies that map low-dimensional coordinates through random or learnable Fourier features, enabling neural networks to learn high-frequency functions. They are a primary mitigation strategy for spectral bias in PINNs and coordinate-based MLPs.

## 개요

Standard MLPs exhibit spectral bias — they preferentially learn low-frequency functions. Fourier feature embeddings address this by projecting inputs $\gamma(x) = [\cos(2\pi B x), \sin(2\pi B x)]$ with a frequency matrix $B$, effectively shifting the NTK's frequency spectrum toward higher modes. Tancik et al. (2020) showed this significantly improves NeRF and SDF learning. The choice of $B$ distribution (uniform, Gaussian, learnable) critically affects which frequencies the network can capture.

## 관련 개념

- [[spectral-bias-pinn]] — Spectral bias phenomenon that Fourier features mitigate
- [[pilir-physics-informed-local-implicit]] — Local implicit representation using discrete feature grids as an alternative to global Fourier features
- [[neural-tangent-kernel]] — NTK theory explaining why Fourier features help
- [[fourier-neural-operator]] — FNO's learnable frequency filtering as a related frequency-domain approach
- [[physics-informed]] — PINN framework where Fourier features are commonly applied
