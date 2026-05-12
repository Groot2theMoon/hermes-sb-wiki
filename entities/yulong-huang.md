---
title: "Yulong Huang"
created: 2026-05-12
updated: 2026-05-12
type: entity
tags: [person, adaptive-Kalman-filter, variational-Bayes, navigation]
sources: [raw/papers/vb-adaptive-kf-huang18.md]
confidence: high
---

# Yulong Huang

Yulong Huang is a researcher at Harbin Engineering University, China, specializing in adaptive Kalman filtering, variational Bayesian methods, and integrated navigation systems. He made significant contributions to robust state estimation under inaccurate process and measurement noise covariance.

## 주요 기여

### A Novel Adaptive Kalman Filter With Inaccurate Process and Measurement Noise Covariance Matrices (2018)
- Proposed a novel **variational Bayesian adaptive Kalman filter (VBAKF)** that jointly handles inaccurate process noise covariance (PNCM) and measurement noise covariance (MNCM)
- Used **inverse Wishart priors** for both the predicted error covariance matrix (PECM) and MNCM, enabling simultaneous inference via VB fixed-point iterations
- Addressed the long-standing challenge that existing VBAKF methods assumed accurate PNCM, which limited their applicability in real-world scenarios
- Demonstrated superior robustness against covariance uncertainties in **target tracking** simulations, outperforming Sage-Husa AKF, innovation-based AKF, and multiple model AKF
- RIGOR 관련성: Directly addresses double uncertainty (process + measurement noise) in KF, a core challenge in the RIGOR filtering framework for safety-critical estimation

## 소속
- Department of Automation, Harbin Engineering University, Harbin, China

## Wikilinks
- [[rigor-filter]]
- [[variational-bayes-adaptive-kalman-filter]]
