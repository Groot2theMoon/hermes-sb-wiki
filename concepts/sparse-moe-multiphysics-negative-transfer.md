---
title: "Sparse MoE Multi-Physics Negative Transfer"
created: 2026-05-17
updated: 2026-05-17
type: concept
tags: [model, neural-operator, surrogate-model, fluid-dynamics]
sources: [raw/papers/sparse-moe-multiphysics-negative-transfer.md]
confidence: high
---

# Sparse MoE Multi-Physics Negative Transfer

## 개요

Scaling Scientific Machine Learning (SciML) toward universal foundation models is bottlenecked by **negative transfer**: when disparate partial differential equation (PDE) regimes are co-trained in a single dense neural operator, gradient conflict arises — broadband open-channel fluid dynamics and boundary-dominated porous media flows impose fundamentally incompatible spectral biases. This leads to unstable optimization and plasticity loss. Sparse mixture-of-experts (MoE) routing provides a principled solution by partitioning PDE regimes into specialized expert sub-networks, allowing the model to disentrain conflicting physics while still benefiting from cross-task transfer where it is advantageous.

## 핵심 아이디어

The architecture introduces an **expert-routing PDE taxonomy** that assigns submanifold PDE classes to distinct transformer-based expert neural operators:

- **Expert classes:** advection-dominated, diffusion-dominated, reaction-dominated, dispersion-dominated, and porous-media-dominated regimes
- **Gate mechanism:** A top-k softmax gate selects which experts activate for a given input, with k=2 used in experiments
- **Load balancing:** An auxiliary load-balancing loss encourages uniform expert utilization, preventing collapse where all inputs route to the same expert
- **Base operator:** Each expert is a transformer-based neural operator sharing the same architectural backbone

This design eliminates negative transfer by ensuring that conflicting PDE regimes activate disjoint expert sets, while compatible regimes can still share representational capacity.

## 결과

Evaluated on a multi-PDE benchmark comprising the 2D advection-diffusion equation, 2D Burgers equation, 2D shallow water equations, and 3D Darcy flow:

| Configuration | Average Relative L2 Error |
|:---|---:|
| MoE neural operator (proposed) | **0.037** |
| Dense baseline (equivalent parameter count) | 0.114 |
| Dense baseline (equivalent FLOPs) | 0.092 |

The MoE model achieves a ~3x error reduction over the parameter-matched dense baseline, demonstrating that sparse gating effectively resolves negative transfer across fundamentally different physics regimes.

## 의의

This work demonstrates a practical path toward **universal SciML foundation models** that can handle arbitrary PDE classes without suffering from negative transfer. By proving that sparse MoE routing can isolate conflicting spectral biases while preserving beneficial cross-task transfer, it opens the door to training a single neural operator on the full breadth of computational physics — from fluid dynamics to solid mechanics to electromagnetics — without requiring separate models per domain. The approach is orthogonal to the choice of base neural operator (FNO, DeepONet, etc.) and can be layered on top of existing architectures.

## Wikilinks

- [[neural-operator]]
- [[fourier-neural-operator]]
- [[deeponet]]
- [[surrogate-model]]
- [[sciml-schwarzschild-orbits]]
