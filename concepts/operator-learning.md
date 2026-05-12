---
title: "Operator Learning"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [operator-learning, neural-operator, surrogate-model, pde, deeponet, fno]
confidence: medium
---

# Operator Learning

Operator learning is a paradigm in scientific machine learning that learns mappings between infinite-dimensional function spaces — i.e., operators — directly from data. Unlike traditional neural networks that map finite-dimensional vectors, operator learning treats entire functions as inputs and outputs, enabling mesh-independent approximation of PDE solution operators.

## 개요

Operator learning addresses the fundamental problem of learning an operator $\mathcal{G}: \mathcal{U} \to \mathcal{V}$ between function spaces, where $\mathcal{U}$ and $\mathcal{V}$ are Banach spaces of functions. Given training data $\{(u_i, v_i)\}_{i=1}^N$ with $v_i = \mathcal{G}(u_i)$ (possibly noisy), the goal is to learn a parametric approximation $\mathcal{G}_\theta \approx \mathcal{G}$. This formulation naturally encompasses PDE solution operators (mapping initial/boundary conditions to solutions) and constitutive laws (mapping material parameters to response fields). The key advantage over finite-dimensional surrogates is **discretization convergence** — once trained, the learned operator can be evaluated on any input function representation without retraining.

## 주요 아키텍처

- **DeepONet**: Branch-trunk architecture that encodes the input function at sensor points (branch net) and the query location (trunk net), then combines them via dot product. Based on the universal approximation theorem for operators (Chen & Chen, 1995).

- **Fourier Neural Operator (FNO)**: Parameterizes the integral kernel in Fourier space via the Fast Fourier Transform (FFT), enabling efficient global convolution. Achieves resolution-invariant learning and strong performance on PDE benchmarks.

- **Graph Neural Operators**: Approximate the kernel integral on graph structures, useful for irregular domains and point cloud data.

- **Transformer-based Operators**: Use attention mechanisms to learn operator mappings (e.g., Transolver, Galerkin Transformer), leveraging sequence modeling for PDE learning.

## 응용

Operator learning is applied across physics and engineering domains: surrogate modeling for PDE-constrained optimization, inverse problems, climate modeling, fluid dynamics (Navier-Stokes), solid mechanics (stress-strain mappings), and materials design. Physics-informed variants (PINO, PI-DeepONet) incorporate PDE residuals to reduce data requirements.

## 관련 개념

- [[neural-operator]] — General class of neural network architectures for operator learning
- [[fourier-neural-operator]] — Fourier space kernel parameterization
- [[deeponet]] — Branch-trunk architecture for operator approximation
- [[physics-informed]] — Physics-informed machine learning paradigm
- [[surrogate-model]] — Surrogate modeling for computational simulations
- [[koopman-operator-theory]] — Related operator-theoretic framework for dynamical systems
