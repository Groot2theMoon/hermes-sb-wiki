---
title: "Gaussian Processes (GP)"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [bayesian, nonparametric, regression, kernel-methods, uncertainty-quantification]
confidence: high
---

# Gaussian Processes (GP)

Gaussian Processes are a **Bayesian nonparametric** approach to regression and classification. A GP defines a distribution over functions, where any finite set of function values follows a multivariate Gaussian distribution. This provides principled uncertainty quantification and works well with small data.

## Definition

A Gaussian Process is a collection of random variables such that any finite subset has a joint Gaussian distribution. It is fully specified by a **mean function** `m(x)` and a **covariance function** (kernel) `k(x, x')`:

```
f(x) ~ GP(m(x), k(x, x'))
```

The kernel encodes assumptions about the function's smoothness, periodicity, and other structural properties.

## GP Prior and Posterior

Given training data `(X, y)` with `y = f(X) + ε`, the GP prior over functions induces a joint Gaussian distribution over training and test outputs. The posterior predictive distribution at test point `x*` is:

```
f(x*) | X, y ~ N(μ*, σ²*)
μ* = k(x*, X) [k(X, X) + σ²I]⁻¹ y
σ²* = k(x*, x*) - k(x*, X) [k(X, X) + σ²I]⁻¹ k(X, x*)
```

This is equivalent to Bayesian linear regression in the feature space induced by the kernel.

## Common Kernels

- **RBF/SE**: `k(r) = exp(-r²/2ℓ²)` — infinitely smooth, universal approximator.
- **Matérn**: `k(r) = (2^{1-ν}/Γ(ν))(√2ν r/ℓ)^ν K_ν(√2ν r/ℓ)` — controls differentiability via `ν`.
- **Periodic**: `k(x, x') = exp(-2 sin²(π|x-x'|/p)/ℓ²)` — for periodic functions.
- **Linear**: `k(x, x') = xᵀ x'` — recovers Bayesian linear regression.

## Applications in Machine Learning

- **GP-ADF (Assumed Density Filtering)**: GP approximations for nonlinear state-space models.
- **GP state-space models (GP-SSM)**: Nonparametric system identification with uncertainty.
- **Bayesian optimization**: GP surrogate for expensive black-box functions.
- **Kernel methods**: Deep connections to RKHS theory and neural tangent kernels.

## Wikilinks
- [[carl-edward-rasmussen]] — Co-author of the standard GP textbook
- [[kennedy-ohagan-calibration]] — GP-based calibration of computer models
- [[state-space-model]] — GP-SSM connections
- [[deep-kernel-multitask-gp-vehicle-dynamics]] — Deep kernel GP for vehicle dynamics
- [[bayesian-optimization]] — GP-based optimization

## References
- Rasmussen, C. E. & Williams, C. K. I. (2006). Gaussian Processes for Machine Learning. MIT Press.
- Williams, C. K. I. & Rasmussen, C. E. (1996). Gaussian Processes for Regression. NeurIPS 1996.
