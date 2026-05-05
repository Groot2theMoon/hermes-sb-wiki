---
title: "SKANODE — Structured Kolmogorov-Arnold Neural ODEs"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [neural-ode, kan, symbolic-discovery, interpretable-learning, system-identification]
sources: [raw/papers/2506.18339v3.md]
confidence: high
---

# SKANODE

**Structured Kolmogorov-Arnold Neural ODEs (SKANODE)** — interpretable dynamics discovery with symbolic regression, combining structured state-space modeling with Kolmogorov-Arnold Networks (KAN) within a Neural ODE architecture.

- **arXiv:** [2506.18339](https://arxiv.org/abs/2506.18339)
- **Authors:** Wei Liu, Kiran Bacsa, Loon Ching Tang, Eleni Chatzi
- **Year:** 2025

## Abstract

Understanding and modeling nonlinear dynamical systems is a fundamental challenge across science and engineering. SKANODE integrates structured state-space modeling with Kolmogorov-Arnold Networks (KANs) to achieve models that are both accurate and physically interpretable. Within a [[neural-odes|Neural ODE]] architecture, SKANODE employs a fully trainable KAN as a universal function approximator to perform virtual sensing, recovering latent states that correspond to interpretable physical quantities such as displacements and velocities. Leveraging KAN's symbolic regression capability, SKANODE extracts compact, interpretable expressions for the system's governing dynamics.

## Method

### Structured State-Space Modeling

SKANODE adopts a structured [[state-space-model|state-space representation]] where the latent state is explicitly organized as displacement $\mathbf{x}(t)$ and velocity $\mathbf{v}(t)$:

$$
\frac{d}{dt} \begin{bmatrix} \mathbf{x}(t) \\ \mathbf{v}(t) \end{bmatrix} = \begin{bmatrix} \mathbf{v}(t) \\ h_\theta(\mathbf{x}(t), \mathbf{v}(t), \mathbf{u}(t)) \end{bmatrix}, \quad \mathbf{y}(t) = h_\theta(\mathbf{x}(t), \mathbf{v}(t), \mathbf{u}(t))
$$

The same function $h_\theta$ governs both the transition dynamics and the observation process, enforcing consistency between latent state evolution and acceleration measurements. This structure provides a strong inductive bias that recovers physically meaningful latent dynamics from acceleration-only observations.

### Two-Stage KAN Learning

1. **Stage 1 — Universal Approximation:** A fully trainable KAN ($\text{KAN}_{\text{approx}}$) models the acceleration dynamics to recover coherent displacement and velocity trajectories from partial observations.

2. **Stage 2 — Symbolic Discovery:** A second KAN ($\text{KAN}_{\text{symbolic}}$) extracts explicit closed-form expressions for the governing dynamics. The symbolic form is then calibrated by further Neural ODE training to improve coefficient precision.

### Identifiability

The paper proves (Proposition 1) that under the structured state-space formulation, sufficient data richness, and model capacity, SKANODE can recover both physically meaningful latent states and the true governing dynamics directly from indirect measurements — eliminating the need for full-state measurements or numerical differentiation.

## Experiments

SKANODE was evaluated on:

- **Duffing oscillator:** Discovered $\ddot{x} + 0.100\dot{x} + 1.489x + 9.801x^3 = 1.008u$ (ground truth: $c=0.1, k=1.5, k_3=10$)
- **Van der Pol oscillator:** Discovered $\ddot{x} + 1.032x^2\dot{x} - 1.003\dot{x} + 1.053x = 0.947u$
- **F-16 aircraft ground vibration data:** Identified hysteretic dynamics at the wing-payload interface with structured latent phase portraits

SKANODE consistently outperformed black-box NODE baselines (ANODE, SONODE) and classical ARX/NARX identification across all metrics (MSE, SSIM), while producing equation-level descriptions of the learned nonlinear dynamics. A downstream feedback-linearization control study showed the discovered symbolic model achieved $7.4\times 10^3\times$ speedup over Newton-based inversion with identical regulation quality.

## RIGOR Relevance

SKANODE is directly relevant to the RIGOR dynamics module. Its structured state-space formulation with physically interpretable latent states and end-to-end symbolic discovery offers a path toward interpretable dynamics within [[rigor-filter|RIGOR's differentiable filtering framework]]. The KAN-based architecture could replace or augment black-box NN dynamics in the [[rigor-filter]] to provide both accuracy and interpretability.

## Related Concepts

- [[neural-odes]] — Base framework for continuous-depth dynamics
- [[universal-differential-equations]] — Hybrid physics-ML dynamics (UDEs)
- [[state-space-model]] — Structured SSM foundation
- [[rigor-filter]] — Differentiable SR-UKF target framework
- [[differentiable-filter-kloss]] — Differentiable filtering baselines

## References

- Liu, W., Bacsa, K., Tang, L. C., & Chatzi, E. (2025). Structured Kolmogorov-Arnold Neural ODEs for Interpretable Learning and Symbolic Discovery of Nonlinear Dynamics. arXiv:2506.18339.
- Liu, Z., Wang, Y., Vaidya, S., et al. (2024). KAN: Kolmogorov-Arnold Networks. arXiv:2404.19756.
