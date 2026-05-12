---
title: "Inverse Design"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [inverse-design, engineering-design, optimization, surrogate-model, generative-model]
confidence: medium
---

# Inverse Design

Inverse design is a methodology that reverses the traditional forward simulation workflow: instead of predicting the performance of a given design, it directly optimizes design parameters to achieve desired performance objectives. This is typically formulated as a PDE-constrained optimization or a conditional generative problem, targeting quantities of interest such as target field distributions, eigenfrequencies, or stress/strain profiles.

## 개요

Inverse design solves the optimization problem $\min_{p \in \mathcal{P}} \mathcal{J}(S(p), p)$ where $p$ are design parameters, $S(p)$ is the system response obtained by solving a forward PDE model $\mathcal{F}(u(p), p) = 0$, and $\mathcal{J}$ is a performance objective. The forward model can be a high-fidelity simulation or a learned surrogate. Key challenges include non-convexity (many local minima), high dimensionality, manufacturing constraints, and the computational cost of repeated forward solves. Approaches range from adjoint-based gradient methods to generative models (VAEs, GANs, diffusion models) that learn the conditional distribution of designs given target properties.

## 주요 방법론

- **Adjoint-based topology optimization**: Gradient-based optimization using adjoint PDE sensitivity analysis, widely used in structural and photonic design.
- **Data-driven inverse design**: Surrogate models (neural operators, Gaussian processes) replace expensive solvers for rapid inner-loop evaluation.
- **Generative inverse design**: Conditional generative models (cGANs, conditional diffusion, diffusion bridges) produce designs satisfying target specifications.
- **Latent space optimization**: Designs optimized in a learned latent representation space, enabling smooth interpolation and constraint satisfaction.

## 관련 개념

- [[inverse-design-materials]] — Inverse design specifically for material microstructures and properties
- [[constitutive-priors-inverse-design]] — End-to-end elastic network inverse design with constitutive priors
- [[physics-informed]] — PDE-constrained optimization with physics-informed loss
- [[surrogate-model]] — Surrogate-accelerated inverse design workflows
- [[generative-models-physics]] — Generative models for physics-based design
- [[metasymbo-multi-agent-metamaterial]] — LLM-guided multi-agent inverse design of metamaterials
