---
title: "Auto-differentiable Data Assimilation — Co-learning States, Dynamics, and Filtering Algorithms"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [data-assimilation, differentiable-filtering, system-identification, kalman-filter, state-estimation]
sources: [raw/papers/2603.20891v1.md]
confidence: high
---

# Auto-differentiable Data Assimilation

**arXiv:** [2603.20891](https://arxiv.org/abs/2603.20891)  
**Authors:** Melissa Adrian, Daniel Sanz-Alonso, Rebecca Willett  
**Year:** 2026

## Abstract

Data assimilation algorithms estimate the state of a dynamical system from partial observations, where the successful performance of these algorithms hinges on costly parameter tuning and on employing an accurate model for the dynamics. This paper introduces a framework for jointly learning the state, dynamics, and parameters of filtering algorithms in data assimilation through a process referred to as **auto-differentiable filtering**. The framework leverages a theoretically motivated loss function that enables learning from partial, noisy observations via gradient-based optimization using auto-differentiation. The authors demonstrate how several well-known data assimilation methods (3DVar, EnKF, Ens3DVar) can be learned or tuned within this framework.

## Method Overview

The general filtering algorithm takes the form:

$$x_t^n = (I - \mathcal{K}_\phi(x_{t-1}^{1:N})H_t) \mathcal{M}_\theta(x_{t-1}^n) + \mathcal{K}_\phi(x_{t-1}^{1:N})\mathcal{Y}(y_t; R_t)$$

where $\mathcal{M}_\theta$ is the forecast model, $\mathcal{K}_\phi$ is the Kalman gain, and $\mathcal{Y}$ incorporates observations and noise.

**Loss function** — Gaussian log-likelihood of the observations:

$$\mathcal{L}(\theta, \phi) := -\sum_{t=1}^T \left[ -\frac{1}{2} \log \det(S_t) - \frac{1}{2} \|y_t - H_t \hat{m}_t^\theta\|_{S_t}^2 \right]$$

where $S_t = H_t C_t^{\theta,\phi} H_t^\top + R_t$.

### Three algorithm variants

| Algorithm | Description | Key Feature |
|-----------|-------------|-------------|
| **AD-3DVar-C** | Learns static background covariance $C_\phi$ | Handles time-varying $H_t$; memory-light |
| **AD-EnKF (Modified)** | Learns dynamics + covariance inflation | Ensemble-based; accurate but memory-heavy |
| **AD-Ens3DVar** | Hybrid: convex combination of static + ensemble covariances | Balances accuracy and flexibility |

## Key Contributions

1. **Unified framework** — Generalizes AD-EnKF (Chen et al., 2022) and AD-3DVar-K (Levine & Stuart, 2022) under a single co-learning formulation.
2. **Two new algorithms** — AD-3DVar-C (learns covariance matrix $C$ instead of Kalman gain $K$, enabling time-varying observation models) and AD-Ens3DVar (hybrid ensemble-3DVar with learnable mixing weight).
3. **Modified AD-EnKF** — Extends the original to additionally learn the covariance inflation factor $\phi$.
4. **Cross-domain experiments** — Clohessy-Wiltshire (aerospace), Lorenz-96 (atmospheric science), generalized Lotka-Volterra (systems biology).
5. **Practitioner guidelines** — Recommendations for algorithm selection based on accuracy needs, computational budget, and observation model characteristics.

## Key Findings

- **Ensemble-based methods** (AD-EnKF, AD-Ens3DVar) consistently outperform 3DVar-based methods across all problem settings, particularly in low-observability regimes ($d_y/d_x < 0.6$).
- **AD-Ens3DVar** provides robust performance even when ensemble size $N < d_x$, unlike AD-EnKF which degrades sharply without covariance tapering.
- **AD-3DVar-C** struggles to estimate unobserved state components when $H$ is static, but handles time-varying $H_t$ well.
- **AD-3DVar-K** is computationally lightest but cannot handle time-varying observation models and shows the most limited forecast improvement.

## RIGOR Relevance

This paper is **directly relevant** to the [[rigor-filter|RIGOR Filter]] project. Both frameworks pursue co-learning of states, dynamics, and filtering parameters via automatic differentiation. Key connections:

- **Shared paradigm** — RIGOR's end-to-end differentiable SR-UKF with A+NN dynamics is a natural extension of this paper's co-learning framework, applied to the square-root unscented formulation with contractivity constraints.
- **Loss function** — RIGOR can adopt the same forecast log-likelihood loss (Eq. 14) while adding LMI-based regularization for stability.
- **Algorithm gap** — This paper covers 3DVar, EnKF, and Ens3DVar but not UKF-type filters; RIGOR's SR-UKF fills this gap.
- **Observation model** — Both handle time-varying $H_t$, but RIGOR adds nonlinear observation models via the unscented transform.
- **Dynamics modeling** — This paper uses neural network residual corrections; RIGOR uses the structured A+NN hybrid with Lur'e contractivity.

See also: [[differentiable-filter-kloss]], [[differentiable-enkf]], [[kalman-filter]], [[state-space-model]]
