---
title: "Canonical Form of Nonlinear Discrete-Time Models"
slug: canonical-form-nonlinear-discrete-models
year: 1998
authors: ["Gérard Dreyfus", "Yizhak Idan"]
source: paper
tags: [system-identification, neural-networks, state-space-methods, graph-theory, nonlinear-dynamics]
related_papers: ["CANONIQUE"]
related_concepts: ["state-space-model", "neural-odes", "universal-differential-equations", "physics-informed", "structured-hybrid-mechanistic-models"]
---

# Canonical Form of Nonlinear Discrete-Time Models

## Overview

The **canonical form of nonlinear discrete-time models** is a methodology introduced by Gérard Dreyfus and Yizhak Idan (1998) for transforming an arbitrary set of coupled nonlinear difference equations into a standardized [[state-space-model|state-space representation]]. This transformation is essential for applying generic training algorithms (such as backpropagation through time) to recurrent neural networks derived from semi-physical (hybrid mechanistic) models.

The core insight is that any discrete-time, time-invariant system described by equations of the form

$$x_i(n+1) = \Psi_i\{x_j(n - \tau_{ijk} + 1)\}, \{u_l(n - \tau_{ilk} + 1)\}$$

can be systematically converted — in polynomial time — into the canonical form:

$$\underline{z}(n+1) = \varphi[\underline{z}(n), \underline{u}(n)]$$
$$\underline{y}(n+1) = \psi[\underline{z}(n+1)]$$

where $\underline{z}(n)$ is the minimal set of state variables.

## Motivation: Semi-Physical Modeling

The methodology is motivated by **semi-physical modeling** (also called knowledge-based neural modeling or [[structured-hybrid-mechanistic-models]]), where prior physical knowledge (in the form of differential or difference equations) is combined with black-box neural components. This approach:

- Preserves known physics (mass/energy balances, constitutive relations)
- Uses neural networks to model unknown or uncertain parts of the dynamics
- Requires a systematic way to convert the hybrid model into a trainable form

The discretized equations from physics typically produce coupled nonlinear difference equations that are **not** in state-space form, making direct application of backpropagation through time impossible.

## Graph-Based Transformation

The transformation proceeds through three stages using a **directed graph** representation:

### Graph Representation

Each variable $x_i$ corresponds to a vertex $v_i$. A directed edge $e_{ij}^\tau$ (from $v_j$ to $v_i$) with delay $\tau$ represents a dependence of $x_i(n+1)$ on $x_j(n - \tau + 1)$. The length $\tau$ encodes the time delay.

### Step 1: Compute the Order $v$

The system's order — the minimum number of state variables — is determined by simplifying the graph $G_0$ to $G_1$:

1. **Delete non-cyclic edges**: Edges not part of any cycle are irrelevant for the order
2. **Eliminate static vertices**: Vertices where all incoming edges have zero delay are removed by reconnecting their inputs to outputs
3. **Merge serial vertices**: Vertices with single input and single output are collapsed
4. **Prune parallel edges**: Only the longest-delay edge between any pair of vertices is kept

The order is then $v = \sum_i \omega_i$ where:

$$\omega_i = \begin{cases} 1 & \text{if } M_i - \min_{e_j \in \langle R_i \rangle} (M_j - \tau_j) > 0 \\ 0 & \text{otherwise} \end{cases}$$

with $M_i$ being the maximum incoming delay at vertex $v_i$, and $R_i$ the set of outgoing edges.

### Step 2: Determine the State Vector

A **graph of time constraints** $G_2$ is derived, preserving inter-cycle relationships. The state vector is found by solving a **linear integer optimization problem**:

Minimize $\sum_i w_i$ (total state variables) subject to:

$$k_j - w_i + \tau_{ji} \leq k_i \leq k_j + \tau_{ji} - 1$$

where $w_i$ is the number of delayed copies of variable $x_i$ in the state vector, and $k_i$ denotes the lag of the most recent occurrence. The simplex algorithm is proven to yield **integer solutions** since all coefficients are -1, 0, or +1 and all constant terms are integers.

### Step 3: Construct the Canonical Network

Once $\{k_i, w_i\}$ are known, the feedforward part of the canonical form (computing $\varphi$) is assembled. The state variables and external inputs feed into a feedforward network whose outputs become the state variables at the next time step. A second feedforward network $\psi$ computes the outputs.

## Key Insights

- **Backpropagation as a generic algorithm**: Any recurrent neural network, no matter how complex, can be trained by backpropagation through time *provided its canonical form has been derived*.
- **Polynomial-time transformation**: All graph operations run in polynomial time via adjacency matrix manipulations.
- **Shared weights**: The canonical form may involve replicated neurons with **shared weights**, which the training algorithm must account for.
- **Non-uniqueness**: Multiple valid state vectors may exist; the optimization finds one that minimizes the state dimension.

## Relationship to Modern Methods

The CANONIQUE methodology is a direct precursor to several modern paradigms:

| Modern Approach | Relationship |
|---|---|
| [[neural-odes]] | Neural ODEs extend the same idea to continuous time — embedding known ODE structure within a neural network |
| [[universal-differential-equations]] | Universal DEs generalize the semi-physical modeling concept to arbitrary differential equation solvers augmented with neural components |
| [[physics-informed|Physics-Informed Neural Networks (PINNs)]] | PINNs incorporate PDE residuals as loss terms rather than embedding them structurally, but share the same motivation of integrating physics with learning |
| [[structured-hybrid-mechanistic-models]] | Direct continuation of the semi-physical modeling paradigm, often using the same canonical form ideas |

## Applications

- **Industrial process modeling**: Successfully applied to distillation column modeling (Ploix et al., 1994, 1996)
- **Nonlinear adaptive filtering**: Using recurrent neural networks in canonical form (Nerrand et al., 1993)
- **System identification**: Providing a principled way to determine model order and state variables from coupled difference equations

## References

- Dreyfus, G., & Idan, Y. (1998). The Canonical Form of Nonlinear Discrete-Time Models. ESPCI, Paris.
- Nerrand, O., Roussel-Ragot, P., Personnaz, L., Dreyfus, G., & Marcos, S. (1993). Neural networks and nonlinear adaptive filtering: unifying concepts and new algorithms. *Neural Computation*, 5, 165-197.
- Ploix, J.L., Dreyfus, G., Corriou, J.P., & Pascal, D. (1994). From Knowledge-based Models to Recurrent Networks: an Application to an Industrial Distillation Process.
