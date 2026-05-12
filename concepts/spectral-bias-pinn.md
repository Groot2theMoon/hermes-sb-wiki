---
title: "Spectral Bias in PINNs"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [pinn, spectral-bias, physics-informed, neural-tangent-kernel, pinn-failure-modes]
confidence: medium
---

# Spectral Bias in PINNs

Spectral bias refers to the well-documented phenomenon that Physics-Informed Neural Networks (PINNs) — and neural networks in general — preferentially learn low-frequency components of the target function, converging slowly or failing to capture high-frequency details. This is a fundamental limitation for multi-scale PDEs that contain both low- and high-frequency solution features.

## 개요

Spectral bias in PINNs arises from the **Neural Tangent Kernel (NTK)** dynamics of fully-connected networks. The NTK of a standard MLP induces a frequency-dependent learning rate: lower frequency modes of the PDE residual are minimized faster than higher frequency modes during gradient descent. For problems with widely separated scales (e.g., advection-diffusion with sharp fronts, wave propagation with multiple wavelengths, or heterogeneous materials with fine microstructures), this leads to the PINN getting stuck in a trivial low-frequency solution while high-frequency features remain unresolved. Wang, Yu, and Perdikaris (2020) provided the first rigorous NTK analysis of this failure mode, and subsequent work has developed numerous mitigation strategies.

## Mitigation Strategies

- **Fourier feature embeddings**: Mapping inputs through $\gamma(x) = [\cos(2\pi Bx), \sin(2\pi Bx)]$ with learnable or fixed frequency matrix $B$ to activate high-frequency learning.
- **Multi-scale architectures**: Separate subnetworks for different frequency ranges, or multi-resolution input fusion.
- **Adaptive loss balancing**: Learning rate annealing or NTK-based gradient scaling to balance frequency contributions during training.
- **Domain decomposition**: Partitioning the domain into subdomains with separate PINNs (cPINN, XPINN) to localize frequency content.
- **Local implicit representations**: As in [[pilir-physics-informed-local-implicit|PILIR]], using discrete latent feature grids with continuous generative decoders to explicitly encode spatial locality and mitigate spectral bias.
- **Modified activation functions**: Periodic activations (SIREN) or wavelet activations to better represent high frequencies.

## 관련 개념

- [[physics-informed]] — Physics-informed machine learning paradigm
- [[pinn-failure-modes]] — Comprehensive analysis of PINN failure modes including spectral bias
- [[pilir-physics-informed-local-implicit]] — Local implicit representation for spectral bias mitigation
- [[neural-tangent-kernel]] — NTK theory underlying spectral bias analysis
- [[fourier-feature-embeddings]] — Input encoding strategy for high-frequency learning
- [[fourier-neural-operator]] — FNO's frequency-domain approach as an alternative to spectral bias-prone architectures
