---
title: Kalman Filter
created: 2026-05-04
updated: 2026-05-04
type: concept
tags: [kalman-filter, state-estimation]
confidence: medium
---

# Kalman Filter

The Kalman Filter is a recursive algorithm for state estimation of linear dynamical systems from noisy measurements. It operates in two steps: predict (propagate state and covariance through dynamics) and update (correct prediction with new measurement via Kalman gain).

For nonlinear variants, see [[square-root-unscented-kalman-filter|SR-UKF]].
For neural network-augmented variants, see [[kalmannet]].
