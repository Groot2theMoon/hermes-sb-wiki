---
title: "Unscented Kalman Filter (UKF) — Sigma-Point Nonlinear State Estimation"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [kalman-filter, state-estimation, sigma-point, nonlinear-filtering, unscented-transform]
sources: []
confidence: medium
---

# Unscented Kalman Filter (UKF)

The Unscented Kalman Filter (UKF) is a nonlinear state estimation algorithm that uses the **unscented transform (UT)** — a deterministic sigma-point sampling scheme — to propagate mean and covariance through nonlinear functions. Unlike the Extended Kalman Filter (EKF), the UKF avoids Jacobian linearization and achieves **third-order accuracy** for Gaussian inputs at computational cost comparable to the EKF.

## 개요

Julier & Uhlmann (1997) proposed the UKF as an alternative to the EKF for nonlinear systems. The core idea is simple: instead of linearizing the nonlinear function, generate $2n+1$ **sigma points** deterministically from the current state distribution, propagate each through the nonlinear function, and reweight them to estimate the transformed mean and covariance. The UKF requires no Jacobian/Hessian computation and works for any nonlinearity, making it a workhorse of modern state estimation.

## Unscented Transform (UT)

Given an $n$-dimensional Gaussian $x \sim \mathcal{N}(\bar{x}, P)$, the UT selects $2n+1$ sigma points:

$$ \mathcal{X}_0 = \bar{x}, \quad \mathcal{X}_i = \bar{x} \pm \sqrt{(n+\lambda)P}_i $$

with weights $W_0^{(m)} = \lambda/(n+\lambda)$, $W_0^{(c)} = \lambda/(n+\lambda) + (1-\alpha^2+\beta)$, and $W_i^{(m)} = W_i^{(c)} = 1/[2(n+\lambda)]$ for $i=1,\ldots,2n$. Here $\lambda = \alpha^2(n+\kappa)-n$ controls sigma-point spread.

After propagation $y = f(x)$, the transformed statistics are:

$$ \bar{y} = \sum W_i^{(m)} \mathcal{Y}_i, \quad P_y = \sum W_i^{(c)} (\mathcal{Y}_i - \bar{y})(\mathcal{Y}_i - \bar{y})^T $$

## UKF Algorithm (Predict-Update)

1. **Sigma point generation**: $2n+1$ points from $(\hat{x}_{k-1}, P_{k-1})$
2. **Predict**: Propagate sigma points through dynamics $f$, compute $\hat{x}_{k|k-1}$, $P_{k|k-1}$
3. **Update**: Generate new sigma points from predicted distribution, propagate through measurement $h$, compute innovation covariance $P_{yy}$ and cross-covariance $P_{xy}$, then apply standard Kalman gain $K = P_{xy}P_{yy}^{-1}$

The result is a **Linear Minimum Mean Square Error (LMMSE)** estimate in the measurement update, but with sigma-point-propagated covariances capturing nonlinear effects up to third order.

## Variants and Extensions

| Variant | Key Innovation | Reference |
|---------|---------------|-----------|
| **SR-UKF** | Square-root Cholesky factor propagation | van der Merwe & Wan (2001) |
| **PUKF/QUKF** | Polynomial measurement update (quadratic/cubic MMSE) | Cherian & Servadio (2026) |
| **HOC-UKF** | Higher-order correlation for uncorrelated states | Grothe (2012) |
| **AUKF** | Adaptive scaling parameter | Őzkaya & Duník |
| **UKF-L** | Learned sigma points via meta-learning | |

## 관련 개념

- [[kalman-filter]] — Linear KF foundation
- [[square-root-unscented-kalman-filter]] — SR-UKF: numerically stable Cholesky factor propagation
- [[polynomial-unscented-kalman-filter]] — PUKF/QUKF: polynomial measurement update beyond LMMSE
- [[higher-order-correlation-ukf]] — HOC-UKF: estimating states uncorrelated with observation
- [[cubature-kalman-filter]] — CKF: spherical-radial cubature rule (related sigma-point approach)
- [[extended-kalman-filter]] — EKF: the linearization-based predecessor
- [[natural-gradient-bayesian-filtering]] — NANO filter: information-geometric alternative
- [[variational-bayes-adaptive-kalman-filter]] — VBAKF: adaptive noise covariance with UKF/CKF integration
- [[rigor-filter]] — RIGOR: differentiable SR-UKF framework
