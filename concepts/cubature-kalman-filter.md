---
title: "Cubature Kalman Filter (CKF) — Spherical-Radial Cubature Rule"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [kalman-filter, state-estimation, sigma-point, nonlinear-filtering, cubature-rule]
sources: []
confidence: medium
---

# Cubature Kalman Filter (CKF)

The Cubature Kalman Filter (CKF) is a nonlinear Gaussian filter that uses the **spherical-radial cubature rule** — a numerical integration method — to compute the moment integrals arising in nonlinear Bayesian filtering. Arasaratnam & Haykin (2009) developed the CKF as a theoretically rigorous sigma-point filter that avoids the parameter tuning required by the Unscented Transform.

## 개요

The CKF is derived from the third-degree spherical-radial cubature rule, which requires exactly $2n$ cubature points (compared to $2n+1$ for the UKF). The cubature points are chosen symmetrically along the coordinate axes at a fixed radius $\sqrt{n}$. This eliminates the need for tuning parameters ($\alpha, \beta, \kappa$) present in the UKF, while maintaining the same **third-order accuracy** for Gaussian integrals. The CKF has become widely adopted in high-dimensional nonlinear filtering, especially for navigation and sensor fusion.

## Spherical-Radial Cubature Rule

The CKF leverages the fact that Gaussian-weighted integrals can be decomposed into spherical and radial components. For the standard Gaussian integral:

$$ I(f) = \int f(x) \mathcal{N}(x; 0, I) dx \approx \frac{1}{2n} \sum_{i=1}^{2n} f(\sqrt{n} e_i) + f(-\sqrt{n} e_i) $$

where $e_i$ are the standard basis vectors. This **cubature rule** is exact for polynomials up to degree 3 and provides a parameter-free alternative to the UT.

The cubature points for a general Gaussian $\mathcal{N}(\bar{x}, P)$ are:

$$ \mathcal{X}_i = \bar{x} + \sqrt{P} \cdot \sqrt{n} \xi_i, \quad i = 1,\ldots,2n $$

where $\xi_i$ are the $i$-th column of $[I_n \; -I_n]$, and $\sqrt{P}$ is the Cholesky factor of $P$.

## CKF Algorithm

The CKF follows the same predict-update structure as the UKF but substitutes UT sigma points with cubature points:

1. **Cubature point generation**: $2n$ points from $(\hat{x}_{k-1}, P_{k-1})$ using spherical-radial rule
2. **Predict**: Propagate cubature points through dynamics, compute $\hat{x}_{k|k-1}$, $P_{k|k-1}$
3. **Update**: Propagate cubature points through measurement function, compute $P_{yy}$ and $P_{xy}$, then Kalman gain

The key difference from UKF: no $\alpha, \beta, \kappa$ parameters to tune, making CKF more robust in automatic deployment.

## CKF vs UKF

| Aspect | CKF | UKF |
|--------|-----|-----|
| Points | $2n$ | $2n+1$ |
| Parameters | None | $\alpha, \beta, \kappa$ |
| Accuracy | 3rd order | 3rd order (default) |
| Numerical stability | Good (square-root variants) | Good (SR-UKF) |
| Tuning-free | Yes | No |
| High-dimensional | Preferred | Slightly more flexible |

## Variants and Improvements

| Variant | Key Innovation | Reference |
|---------|---------------|-----------|
| **SR-CKF** | Square-root CKF for numerical stability | Arasaratnam & Haykin |
| **ICKF** | Posterior sigma-point error transformation for GNSS/INS outage | Cui, Chen & Tang (2017) |
| **GCKF** | Generalized CKF (higher-order cubature) | Linares & Crassidis |
| **VB-ACKF** | Adaptive CKF with variational Bayes measurement noise estimation | Särkkä & Hartikainen (2013) |

## 관련 개념

- [[improved-ckf-gnss-ins]] — ICKF: posterior sigma-point error transformation for GNSS/INS
- [[unscented-kalman-filter]] — UKF: related sigma-point filter with UT instead of cubature rule
- [[square-root-unscented-kalman-filter]] — SR-UKF: square-root form (analogous to SR-CKF)
- [[generalized-gaussian-cubature]] — GGC: higher-order cubature rules
- [[kalman-filter]] — Linear KF foundation
- [[natural-gradient-bayesian-filtering]] — NANO filter: alternative geometric approach
- [[variational-bayes-adaptive-kalman-filter]] — VBAKF: adaptive noise with UKF/CKF integration
- [[bing-cui]] — First author of improved CKF for GNSS/INS
