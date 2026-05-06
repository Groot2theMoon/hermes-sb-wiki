---
title: "RIGOR Development — Differentiable SR-UKF Framework"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [rigor, kalman-filter, differentiable-filtering, development, infrastructure, sr-ukf]
confidence: high
---

# RIGOR Development — Differentiable SR-UKF Framework

RIGOR (Recursively-Informed, Graph-Optimized, Robust) is a **differentiable Square-Root Unscented Kalman Filter (SR-UKF)** framework for joint state estimation, dynamics learning, and filter parameter optimization via gradient-based methods.

## Development Setup

The RIGOR codebase is developed in Python using PyTorch for automatic differentiation. The framework implements the full SR-UKF recursion (sigma points, predict, update, square-root covariance propagation) as differentiable operations, enabling end-to-end learning of:

- **State estimates** via gradient-based refinement.
- **Dynamics models** (hybrid A+NN architectures with known physics + learned residual).
- **Noise covariance parameters** (process and measurement noise).
- **Filter hyperparameters** (sigma point scaling, initialization).

## Key Components

- **Differentiable SR-UKF step**: Cholesky factorization, sigma point generation, unscented transform, Kalman gain computation — all implemented in differentiable PyTorch.
- **Hybrid dynamics model**: `F = A_known + NN_θ` where `A` encodes known linear physics and the neural network captures unmodeled nonlinearities.
- **Rollout loss**: Multi-step prediction loss enables learning beyond single-step filtering.
- **Benchmarking suite**: Comparison against standard UKF, EKF, and baseline differentiable filters on VdP oscillator, structural dynamics, and other test problems.

## Infrastructure

RIGOR development uses cloud GPU compute for benchmarking and training (see [[cloud-gpu-compute-platforms]]). The typical workflow is:

1. Local development and debugging on CPU (PN40 or laptop).
2. Batch benchmarks on Modal or RunPod GPU instances.
3. Result aggregation and analysis (wandb, local logging).

## Wikilinks
- [[rigor-filter]] — Core RIGOR filter architecture
- [[rigor-sigma-point-research]] — Research landscape and gap analysis
- [[cloud-gpu-compute-platforms]] — Cloud GPU setup for RIGOR benchmarks
- [[infrastructure-notes]] — PN40 server environment notes
- [[square-root-unscented-kalman-filter]] — Standard SR-UKF formulation
- [[extended-kalman-filter]] — EKF baseline comparison

## References
- Haywood-Alexander, M., Duthé, G., & Chatzi, E. (2026). PiGGO. *[raw paper reference]*
- Van der Merwe, R. & Wan, E. A. (2001). The Square-Root Unscented Kalman Filter for State and Parameter-Estimation. ICASSP 2001.
