---
title: "Neural ODE (Neural Ordinary Differential Equation)"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [deep-learning, differential-equations, continuous-depth, dynamical-systems, system-identification]
confidence: high
---

# Neural ODE (Neural Ordinary Differential Equation)

Neural ODEs, introduced by Chen et al. (2018) in "Neural Ordinary Differential Equations" (NeurIPS Best Paper), parameterize the **continuous-time dynamics** of a latent state using a neural network. Instead of specifying discrete layer transitions (as in ResNets), the model learns a vector field that an ODE solver integrates.

## Formulation

The state `h(t)` evolves according to:

```
dh(t)/dt = f(h(t), t; θ)
```

where `f` is a neural network with parameters `θ`. Given an initial state `h(0)`, the output at time `T` is obtained via an ODE solver:

```
h(T) = h(0) + ∫₀ᵀ f(h(t), t; θ) dt = ODESolve(h(0), f, 0, T, θ)
```

## Adjoint Sensitivity Method

The critical enabling technique for training Neural ODEs is the **adjoint sensitivity method**, which computes gradients through ODE solutions with constant memory cost (O(1) regardless of solver steps). Instead of backpropagating through solver operations, the adjoint `a(t) = ∂L/∂h(t)` is defined as a second ODE solved backwards in time:

```
da(t)/dt = -a(t)ᵀ ∂f(h(t), t; θ)/∂h
```

This allows treating the ODE solver as a black box during training.

## Key Properties

- **Continuous depth**: Single model parameterizes dynamics at arbitrary time horizons; no discrete layer count.
- **Adaptive computation**: Numerical ODE solvers (e.g., dopri5) adapt step size based on error tolerance, trading compute for accuracy.
- **Irregularly-sampled data**: Naturally handles observations at non-uniform time points — a significant advantage over RNNs/LSTMs.

## Applications

- **Physics-informed ML**: PINNs and PINODEs for PDE-constrained problems.
- **Dynamical systems**: System identification, surrogate modeling for physical simulations.
- **Graph-structured dynamics**: GNODEs combine GNN message passing with Neural ODE integration.
- **Normalizing flows**: Continuous normalizing flows (CNF) for density estimation.

## Wikilinks
- [[graph-neural-ode-structural-dynamics]] — GNODE for structural dynamics
- [[neural-ode-dynamical-systems]] — Neural ODE for system identification
- [[neural-odes]] — Related concept page (applications in state observation)
- [[pinode-physics-informed-neural-ode]] — Physics-informed Neural ODE
- [[buisson-fenet-kkl-observer]] — KKL observer for NODE from partial observations

## References
- Chen, R. T. Q., Rubanova, Y., Bettencourt, J., & Duvenaud, D. (2018). Neural Ordinary Differential Equations. NeurIPS 2018.
