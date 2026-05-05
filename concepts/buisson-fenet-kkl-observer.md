---
title: "Buisson-Fenet KKL Observer — Recognition Models for Neural ODEs from Partial Observations"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [neural-ode, kkl-observer, state-estimation, partial-observations, system-identification]
sources: [raw/papers/2205.12550v3.md]
confidence: high
---

# Buisson-Fenet KKL Observer

**Recognition Models to Learn Dynamics from Partial Observations with Neural ODEs** — using Kazantzis-Kravaris/Luenberger (KKL) observers as principled recognition models for learning [[neural-odes|Neural ODEs]] under partial observability.

- **arXiv:** [2205.12550](https://arxiv.org/abs/2205.12550)
- **Authors:** Mona Buisson-Fenet, Valery Morgenthaler, Sebastian Trimpe, Florent Di Meglio
- **Journal:** Transactions on Machine Learning Research (TMLR), 2023
- **Code:** [anonymous.4open.science/r/structured_NODEs-7C23](https://anonymous.4open.science/r/structured_NODEs-7C23)

## Abstract

Identifying dynamical systems from experimental data is a notably difficult task, especially under partial observations. Neural ODEs offer a flexible framework for system identification, but when only partial observations are available, the data points cannot directly be mapped to the latent state of the ODE. This paper proposes **recognition models** inspired by nonlinear observer theory — specifically the Kazantzis-Kravaris/Luenberger (KKL) observer — to link partial observations to the latent state in a principled manner.

## KKL Observer Theory

### Core Idea

The KKL observer builds a **linear filter of the measurement**: an auxiliary dynamical system

$$
\dot{z} = Dz + F\bar{y}
$$

is simulated, where $z \in \mathbb{R}^{d_z}$ is the observer internal state, $D$ is Hurwitz, and $(D, F)$ is controllable. The observer state \(z(t)\) converges to a value that is uniquely determined by the history of $y$, and under certain conditions (backward distinguishability), there exists an injective transformation $\mathcal{T}: x \mapsto z$ and its left inverse $\mathcal{T}^*$ such that

$$
\lim_{t \to \infty} |x(t) - \mathcal{T}^*(z(t))| = 0.
$$

### Recognition via Backward Simulation

For learning from partial observations, the KKL observer is run **backward in time** on $y_{t_c:0}$ to estimate the initial latent state $x(0)$. A neural network recognition model $\psi_\theta$ learns the mapping $x(0) = \psi_\theta(\bar{z}(t_c))$, where $\bar{z}(t_c)$ is the observer output run backward. This enables end-to-end training of both the dynamics model $f_\theta$ and the recognition model within the NODE framework.

### Recognition Methods Compared

| Method | Description |
|--------|-------------|
| **Direct** | Stack observations $y_{0:t_c}$ directly as input |
| **RNN+** | GRU run backward over observations |
| **KKL** | KKL observer filter, then NN mapping from $z(0)$ |
| **KKLu** | Functional KKL observer with augmented $(y, u)$ input |

## Experimental Results

### Benchmark on Simulated Systems

- **Earthquake model** (4D state, 1D observation): KKL method achieves lowest RMSE, with clear advantage as $t_c$ increases
- **FitzHugh-Nagumo** (2D state, 1D observation): KKL and KKLu outperform direct and RNN+ methods
- **Van der Pol oscillator** (2D state, 1D observation): KKL and KKLu show superior noise robustness

### Harmonic Oscillator with Increasing Priors

Demonstrated a spectrum of structured NODEs with KKL recognition: no structure → Hamiltonian → $\dot{x}_1 = x_2$ constraint → parametric → extended state-space. Increasing structure yields more interpretable and accurate models.

### Robotic Exoskeleton (Real-World)

Applied to a Wandercraft exoskeleton dataset with 4D state, partial observations. Structured NODEs with KKL recognition successfully identified nonlinear deformation dynamics, generalizing to unseen input frequencies. The learned model outperformed the linear prior model when used inside an Extended Kalman Filter (EKF) for state estimation.

## RIGOR Relevance

This paper is **directly foundational to RIGOR's DeltaObserver module**. The KKL observer-based recognition model is precisely what DeltaObserver does — recover full latent state from partial observations under [[neural-odes|Neural ODE]] dynamics. The principled observer-theoretic guarantees (existence of $\mathcal{T}^*$, known dimension $d_z$, convergence rate control via $D$) provide theoretical justification for similar designs in [[rigor-filter]].

The paper's systematic comparison of recognition strategies (direct, RNN+, KKL, KKLu) and its framework for structured NODEs with varying prior knowledge are directly applicable to RIGOR's design choices for the dynamics module.

## Related Concepts

- [[rigor-filter]] — Target differentiable filtering framework
- [[neural-odes]] — Continuous-depth dynamics foundation
- [[state-space-model]] — SSM theoretical backbone
- [[differentiable-filter-kloss]] — Differentiable filtering baselines (Kloss 2021)
- [[universal-differential-equations]] — Hybrid physics-ML dynamics

## References

- Buisson-Fenet, M., Morgenthaler, V., Trimpe, S., & Di Meglio, F. (2023). Recognition Models to Learn Dynamics from Partial Observations with Neural ODEs. *TMLR*. arXiv:2205.12550.
- Kazantzis, N., & Kravaris, C. (1998). Nonlinear observer design using Lyapunov's auxiliary theorem. *Systems and Control Letters*, 34:241–247.
- Andrieu, V., & Praly, L. (2006). On the existence of a Kazantzis-Kravaris/Luenberger observer. *SIAM Journal on Control and Optimization*, 45(2):422–456.
- Bernard, P., & Andrieu, V. (2019). Luenberger Observers for Nonautonomous Nonlinear Systems. *IEEE TAC*, 64(1):270–281.
