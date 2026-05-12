---
title: "Simo Särkkä"
created: 2026-05-12
updated: 2026-05-12
type: entity
tags: [person, Bayesian-filtering, Gaussian-processes, SLAM, variational-Bayes]
sources: [raw/papers/vb-adaptive-kf-sarkka13.md]
confidence: high
---

# Simo Särkkä

Simo Särkkä is a professor at Aalto University, Finland, specializing in Bayesian filtering and smoothing, Gaussian processes, probabilistic machine learning, and SLAM. He is a leading authority on variational Bayesian methods for adaptive Kalman filtering and state-space inference.

## 주요 기여

### Non-linear Noise Adaptive Kalman Filtering via Variational Bayes (2013)
- Extended the VB-AKF framework from linear to **non-linear state space models**, enabling joint estimation of state and full time-varying measurement noise covariance matrices
- Formulated a variational Bayes approximation combined with **Gaussian non-linear filtering** using unscented transform, cubature integration, and Gauss-Hermite integration
- Demonstrated that the free-form VB approximation via KL divergence minimization yields tractable fixed-point iterations for sufficient statistics
- Provided a unified framework integrating VB inference with any **Gaussian integration method** (UKF, CKF, GHKF, Taylor series)
- RIGOR 관련성: Foundational work establishing VB-based adaptive filtering for non-linear systems, directly enabling later robust and adaptive KF variants in the RIGOR ecosystem

## 소속
- Aalto University, Department of Electrical Engineering and Automation, Espoo, Finland

## Wikilinks
- [[rigor-filter]]
- [[variational-bayes-adaptive-kalman-filter]]
