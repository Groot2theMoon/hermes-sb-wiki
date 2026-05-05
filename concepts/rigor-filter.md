---
title: RIGOR Filter — Differentiable SR-UKF
created: 2026-05-04
updated: 2026-05-04
type: concept
tags: [kalman-filter, state-estimation, system-identification]
sources: []
confidence: high
---

# RIGOR Filter

A differentiable Square-Root Unscented Kalman Filter with A+NN dynamics. Implements Lur'e contractivity LMI constraints and EM-based noise covariance learning. See [[square-root-unscented-kalman-filter|SR-UKF]] for the base algorithm.

Closely related to [[auto-diff-data-assimilation|Auto-differentiable Data Assimilation]] (co-learning states + dynamics + filtering) and [[observability-nssm|Observability for NSSM]] (theoretical conditions for unobserved state recovery).

## Related Dynamics Approaches

- [[skanode]] — Structured KAN Neural ODEs for interpretable symbolic discovery of nonlinear dynamics; relevant for interpretable dynamics in RIGOR
- [[buisson-fenet-kkl-observer]] — KKL observer-based recognition models for NODEs under partial observations; directly foundational for DeltaObserver

This filter addresses the same learning-based state estimation problem as [[miao-robust-observer|Miao & Gatsis (2023)]], which learns KKL observers via Neural ODEs. Key differences: RIGOR uses SR-UKF with contractivity LMI for robustness, while Miao uses Neural ODE latent dynamics with D-eigenvalue regularization.
