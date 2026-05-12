---
title: "Neural Operator"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [neural-operator, operator-learning, surrogate-model, pde, deeponet, fno]
confidence: medium
---

# Neural Operator

Neural operators are a class of deep learning architectures designed to learn mappings between infinite-dimensional function spaces — specifically, operators that govern physical systems. By parameterizing integral operators with neural networks, neural operators achieve discretization-convergent learning of PDE solution operators, constitutive laws, and other function-to-function mappings.

## 개요

Neural operators formalize the learning of operators $\mathcal{G}_\theta \approx \mathcal{G}$ through an iterative architecture that updates a latent representation $v_t(x)$ via:

$$v_{t+1}(x) = \sigma(W v_t(x) + (\mathcal{K} v_t)(x))$$

where $\mathcal{K}$ is a kernel integral operator $(\mathcal{K} v_t)(x) = \int \kappa(x, y) v_t(y) dy$. The key innovation is that the kernel $\kappa$ is parameterized in a way that is independent of the discretization of the input function (mesh-invariant). Different neural operator architectures differ in how they parameterize this kernel — in physical space (standard neural operator), Fourier space (FNO), or via attention (transformer-based operators).

## 주요 변형

- **Fourier Neural Operator (FNO)**: Kernel convolution computed in Fourier space via FFT, enabling global receptive fields and efficient spectral learning.
- **DeepONet**: Branch-trunk architecture using the universal approximation theorem for operators.
- **Graph Neural Operator (GNO)**: Kernel integral on graph structures for irregular meshes.
- **Laplace Neural Operator (LNO)**: Based on Laplace transform for semi-infinite domains.
- **Physics-Informed Neural Operator (PINO)**: Combines operator learning with PDE residual loss (physics-informed training).
- **Multiwavelet-based operators**: Use wavelet transforms for multiscale kernel decomposition.

## 특징 및 장점

- **Discretization convergence**: Training on coarse grids generalizes to fine grids (zero-shot super-resolution).
- **Mesh independence**: Once trained, the operator can be evaluated on arbitrary discretizations.
- **Amortized inference**: Single forward pass replaces thousands of PDE solver calls.
- **Transferable**: Can generalize across related PDE parameters and boundary conditions.

## 관련 개념

- [[operator-learning]] — General paradigm of learning mappings between function spaces
- [[fourier-neural-operator]] — Fourier domain kernel parameterization
- [[deeponet]] — Universal operator approximation architecture
- [[physics-informed]] — Physics-informed loss constraints for operator learning
- [[surrogate-model]] — Surrogate modeling context and applications
- [[hybrid-modeling]] — Hybrid approaches combining neural operators with classical solvers
