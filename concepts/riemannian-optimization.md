---
title: "Riemannian Optimization"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [optimization, manifolds, constrained-optimization, geometry, numerical-methods]
confidence: high
---

# Riemannian Optimization

Riemannian optimization refers to **optimization on Riemannian manifolds** — minimizing a scalar objective function where the parameters are constrained to lie on a smooth manifold. This generalizes unconstrained Euclidean optimization to geometrically constrained parameter spaces.

## Core Idea

Many machine learning and physics parameters naturally live on manifolds rather than in Euclidean space: orthogonal matrices (Stiefel manifold), subspaces (Grassmann manifold), positive definite matrices (SPD manifold), and probability simplices. Riemannian optimization respects this geometry by performing updates along **geodesic curves** rather than straight lines.

## Key Components

- **Retraction**: A smooth map from the tangent space back to the manifold, approximating the exponential map. Used to project gradient descent steps onto the manifold.
- **Vector transport**: Transfers tangent vectors between tangent spaces at different points (analogous to parallel transport).
- **Riemannian gradient**: The projection of the Euclidean gradient onto the tangent space of the manifold.

The basic update step is:

```
x_{k+1} = R_{x_k}(-η grad f(x_k))
```

where `R` is a retraction and `grad f` is the Riemannian gradient.

## Common Manifolds

- **Stiefel manifold**: Set of `n × p` orthogonal matrices `St(p, n) = {X ∈ ℝ^{n×p} : XᵀX = I_p}`. Used for PCA, subspace learning.
- **Grassmann manifold**: Set of p-dimensional subspaces in ℝ^n. Used for subspace tracking, reduced-order models.
- **SPD manifold**: Symmetric positive definite matrices `S++(n)`. Used for covariance estimation, metric learning.
- **Oblique manifold**: Matrices with unit-norm columns. Used for ICA, dictionary learning.

## Applications

- **Density Functional Theory (DFT)**: Kohn-Sham DFT involves optimizing over electron wavefunctions constrained to orthonormality — a Stiefel manifold optimization problem.
- **Matrix factorization**: Low-rank matrix completion with orthogonality constraints.
- **Deep learning**: Orthogonal RNNs, Lipschitz-constrained networks, and manifold-constrained parameter spaces.

## Wikilinks
- [[density-functional-theory]] — DFT optimization on Stiefel manifold
- [[mhc-deepseek]] — Manifold-constrained hyper-connections
- [[aol-almost-orthogonal-layers]] — Almost-orthogonal layers for Lipschitz networks

## References
- Absil, P.-A., Mahony, R., & Sepulchre, R. (2008). Optimization Algorithms on Matrix Manifolds. Princeton University Press.
- Boumal, N. (2023). An Introduction to Optimization on Smooth Manifolds. Cambridge University Press.
