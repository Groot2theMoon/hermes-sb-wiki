---
title: "Koopman Operator Theory"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [dynamical-systems, operator-theory, linearization, data-driven, koopman]
confidence: high
---

# Koopman Operator Theory

Koopman Operator Theory, originating from Koopman (1931), provides a framework for representing **nonlinear dynamical systems** as infinite-dimensional **linear operators** acting on the space of observable functions. This linear representation enables the application of linear control and estimation techniques to nonlinear systems.

## Mathematical Foundation

Consider a discrete-time dynamical system `x_{t+1} = F(x_t)` on state space `M`. The Koopman operator `K` acts on observable functions `ψ: M → ℝ` as:

```
(Kψ)(x) = ψ(F(x))
```

that is, `K` advances observables forward in time: `ψ(x_{t+1}) = (Kψ)(x_t)`. The key insight is that `K` is **linear** even though `F` is nonlinear. The nonlinearity is shifted from the state dynamics to the choice of observables.

## Spectral Decomposition

The Koopman operator has eigenfunctions `φ_j` satisfying `(Kφ_j)(x) = λ_j φ_j(x)`. Any observable can be expanded as:

```
ψ(x) = Σⱼ c_j φ_j(x)
```

and its time evolution becomes:

```
ψ(x_t) = Σⱼ c_j λ_jᵗ φ_j(x₀)
```

This provides a global linear representation of the nonlinear dynamics — akin to modal analysis but extended to nonlinear systems.

## Data-Driven Methods

- **Dynamic Mode Decomposition (DMD)**: Schmid (2010) — approximates Koopman eigenpairs from snapshot data under linear observables.
- **Extended DMD (EDMD)**: Williams et al. (2015) — uses dictionary of nonlinear observables.
- **Deep Koopman**: Neural networks learn the observable dictionary `φ(x)` and the linear Koopman operator `K` jointly via autoencoder architectures.

## Applications

- **Data assimilation**: Koopman-based Kalman filtering for nonlinear state estimation.
- **System identification**: Learning globally linearized dynamics from partial observations.
- **Control**: Koopman MP C (KMPC) for nonlinear systems using linear control synthesis.

## Wikilinks
- [[kalman-filter-koopman-federated]] — KFFedKL: Federated Koopman learning with UKF
- [[lagrangian-koopman-network]] — LaCGKN: Conditional Gaussian Koopman network
- [[information-koopman-representation]] — Information shapes Koopman representation
- [[koopman-resolvent-dynamics]] — Koopman-resolvent framework
- [[koopman-learner-continual-lifting]] — Continual learning of Koopman dynamics
- [[kernel-operator-bayesian-filter]] — RKHS + Koopman 융합 Functional Bayesian Filter (Li & Príncipe, 2024)

## References
- Koopman, B. O. (1931). Hamiltonian Systems and Transformation in Hilbert Space. *Proc. Natl. Acad. Sci.*, 17(5), 315–318.
- Brunton, S. L. et al. (2022). Modern Koopman Theory for Dynamical Systems. *SIAM Review*, 64(2), 229–340.
- Williams, M. O., Kevrekidis, I. G., & Rowley, C. W. (2015). A Data-Driven Approximation of the Koopman Operator. *J. Nonlinear Sci.*, 25, 1307–1346.
