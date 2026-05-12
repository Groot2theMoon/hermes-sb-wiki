---
title: "Variational Robust Kalman Filter — Student's t Unified Framework"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [kalman-filter, robust-filtering, variational-bayes, student-t, adaptive-filtering]
sources:
  - raw/papers/variational-robust-kalman-li26.md
confidence: medium
---

# Variational Robust Kalman Filter (STKF/STKF-A/STKF-AR)

The Variational Robust Kalman Filter framework, developed by Li, Shi, Yu, & Shi (2026), unifies **robustness** (handling outliers) and **adaptivity** (tracking time-varying noise) into a single **Student's t-distribution induced loss** solved via computationally efficient fixed-point iteration. It recovers the standard KF, robust KF, and adaptive VBKF as special cases through hyperparameter tuning.

## 개요

Robustness and adaptivity are competing objectives in Kalman filtering: robustness inflates prior noise covariances to downweight outliers, while adaptivity updates prior beliefs using measurements. Li et al. (2026) demonstrate that **robustness is a prerequisite for adaptivity** — outliers corrupt covariance estimates before they can be adapted. Their Student's t-based framework solves both problems sequentially via a probabilistic switching rule (STKF-AR), achieving superior performance under complex noise environments with both outliers and time-varying covariances.

## Three Algorithms

| Algorithm | Capability | Key Feature | Recoverable |
|-----------|-----------|-------------|-------------|
| **STKF** | Robust only | Fixed-point iteration, Theorem 3 convergence | Recover KF as $\nu \to \infty$ |
| **STKF-A** | Robust + Adaptive | Forgetting factor $\rho$ for covariance tracking | Recover STKF as $\rho = 1$ |
| **STKF-AR** | Full Robust-Adaptive | Bernoulli switching for outlier probability | Recover STKF-A with switch off |

### STKF (Student's t Kalman Filter)

Uses Student's t-distribution as the loss function instead of Gaussian. The heavier tails automatically downweight outliers. Solved via **fixed-point iteration** (not gradient descent), with convergence guaranteed under Theorem 3's sufficient condition.

**Theorem 4**: The VB inference optimal posterior mean equals the MAP estimate, connecting variational inference directly to robust M-estimation.

### STKF-A (Adaptive)

Adds a **forgetting factor** $\rho \in [0.95, 1)$ to track time-varying noise covariance. The key trade-off (Theorem 5):
- Small $\rho$: Fast convergence (transient bias decay) $\leftrightarrow$ High steady-state variance (noisy estimates)
- Large $\rho$: Smooth steady-state $\leftrightarrow$ Slow convergence
- Convergence time constant: $\tau_c = -1/\ln(\rho)$

### STKF-AR (Adaptive Robust)

Adds **Bernoulli switching** variables that probabilistically detect outliers at each time step. When an outlier is detected, the adaptive update is suppressed — this is the first framework to handle both **rate of noise change** and **probability of outlier occurrence** as separate, tunable mechanisms.

## Hyperparameter Guidelines

- $\nu_i$ (DOF per channel): Gaussian channel $\to \infty$, outlier-prone channel $\to [0.5, 5]$
- $\rho_i$ (forgetting factor): $[0.95, 1)$, $\rho = 1$ recovers non-adaptive STKF
- Bernoulli prior: encodes prior belief about outlier frequency

## 관련 개념

- [[variational-bayes-adaptive-kalman-filter]] — VBAKF: adaptive noise via VB with conjugate priors
- [[variational-approach-filtering]] — The Mitter-Newton variational foundation
- [[kalman-filter]] — Linear KF baseline
- [[rigor-filter]] — RIGOR: differentiable SR-UKF framework for integration
- [[square-root-unscented-kalman-filter]] — SR-UKF: numerical target for robust VB integration
- [[ling-shi]] — Co-author (HKUST)
- [[shilei-li]] — First author (BIT)
