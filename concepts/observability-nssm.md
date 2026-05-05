---
title: "Observability Conditions for Neural State-Space Models with Eigenvalues and Roots of Unity"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [observability, state-space-model, control-theory, mamba, eigenvalues, system-identification]
sources: [raw/papers/2504.15758v2.md]
confidence: high
---

# Observability Conditions for Neural State-Space Models

**arXiv:** [2504.15758](https://arxiv.org/abs/2504.15758)  
**Author:** Andrew Gracyk (Purdue University)  
**Year:** 2025

## Abstract

This work operates through the lens of ordinary differential equations and control theory to study observability in the context of neural state-space models (NSSMs) and the Mamba architecture. The author develops strategies to enforce observability tailored to learning contexts where hidden states are learnable at initial time, over their continuum, and in high-dimensional settings. The methods emphasize eigenvalues, roots of unity, or both, and effectuate computational efficiency when enforcing observability, sometimes at great scale.

## Method Overview

The paper studies observability of the neural state-space system:

$$\begin{cases} \dot{h}(t) = Ah(t) + Bx(t) \\ y(t) = Ch(t) + Dx(t) \end{cases}$$

where $A \in \mathbb{R}^{n \times n}$, $B \in \mathbb{R}^{n \times m}$, $C \in \mathbb{R}^{m \times n}$, $n \geq m$. The system is observable if the observability matrix $\mathcal{O} = [C; CA; \dots; CA^{n-1}]$ is full column rank.

## Key Theoretical Contributions

### 1. Permutation-based Observability (Theorem 1-2)
If $A$ is a permutation matrix with distinct roots-of-unity eigenvalues and $C$ satisfies a non-constant column condition, the pair $(C, A)$ is observable. This provides an extremely efficient loss function ($O(2n^2)$) for enforcing observability, though it is restrictive over the parameter space.

### 2. Fourier-based Observability (Theorems 3-4)
Two results built on the Fourier transform of the impulse response $C e^{Ak\Delta t} B$. The key insight: ensuring distinct eigenvalues and distinct kernel conditions across Fourier frequencies yields observability with high probability. These apply to the convolutional (S4-style) formulation of state-space models.

### 3. Modified Hautus Lemma for Mamba (Theorem 5)
A computationally efficient alternative to the classical Hautus lemma that uses Vandermonde matrices and Kronecker products instead of eigenvector computations. The loss only requires:
- Distinct eigenvalues: $\text{relu}(\text{const} - \min |\lambda_{k_1} - \lambda_{k_2}|)$
- Nonzero columns of $CV$: $\text{relu}(\text{const} - |\tilde{C}_{ij}|)$

### 4. Parameter Sharing for Efficiency (Theorem 6-7)
A coupling between $A$ and $B$ via Kronecker product structures $(Q \otimes I_p)$ that reduces parameters drastically and enables efficient exponentiation. The training algorithm satisfies a Robbins-Monro condition under orthogonality constraints, while a classical training procedure fails to satisfy a contraction mapping.

## RIGOR Relevance

This paper is **highly relevant** to the [[rigor-filter|RIGOR Filter]] project, providing the theoretical foundation for addressing unobserved state learning:

- **Observability guarantee** — RIGOR's A+NN dynamics must ensure the augmented state is observable from partial measurements; this paper's conditions (especially Theorem 5's eigenvector test) can be adapted as regularization constraints.
- **Mamba/SSM connection** — RIGOR operates on state-space representations; this paper's results on NSSM observability directly inform when RIGOR's latent state can be recovered from outputs.
- **Permutation and eigenvalue methods** — The computationally efficient loss functions ($O(2n^2)$) could be integrated into RIGOR's training as cheap observability-promoting regularizers.
- **Parameter sharing** — The coupling construction (Section 4.5) provides a template for reducing the parameter count in RIGOR's dynamics model while maintaining observability.

## Computational Methods

The paper proposes several loss functions for enforcing observability during training:

| Method | Computational Cost | Restrictiveness |
|--------|-------------------|-----------------|
| Observability matrix determinant | $O(n^3 m^2 + n^3)$ | Minimal (direct) |
| Hautus lemma | $O(n^4)$ | Minimal (direct) |
| Permutation-based | $O(2n^2)$ | High (A must be near-permutation) |
| Fourier-based | $O(n^2 L)$ | Moderate |
| Vandermonde/Hautus (Theorem 5) | $O(mn^2 + mn)$ | Moderate (eigenvalue separation) |

## Key Insight: Roots of Unity and Observability Loss

When $A$'s eigenvalues are roots of unity, the observability matrix's column rank can collapse. The paper shows that matching eigenvalues to distinct roots of unity + double stochasticity conditions forces $A$ to be a permutation matrix, which guarantees observability under mild conditions on $C$. However, numerical imprecision can accidentally satisfy rank conditions, so the methods must be enforced with sufficient strictness.

See also: [[rigor-filter]], [[state-space-model]], [[state-space-model-emergence-ergodicity]], [[kalman-filter]]
