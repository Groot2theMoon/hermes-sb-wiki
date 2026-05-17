---
title: "Eradicating Negative Transfer in Multi-Physics Foundation Models via Sparse Mixture-of-Experts Routing"
arxiv: "2605.15179v1"
authors: ["Ellwil Sharma", "Arastu Sharma"]
year: 2026
source: paper
ingested: 2026-05-17
conversion: web_extract
---

# Eradicating Negative Transfer in Multi-Physics Foundation Models via Sparse Mixture-of-Experts Routing

**Ellwil Sharma, Arastu Sharma**

*arXiv:2605.15179v1 | Category: cs.LG*

## Abstract

Scaling Scientific Machine Learning (SciML) toward universal foundation models is bottlenecked by negative transfer: the simultaneous co-training of disparate partial differential equation (PDE) regimes can induce gradient conflict, unstable optimization, and plasticity loss in dense neural operators. In particular, broadband open-channel fluid dynamics and boundary-dominated porous media flows impose fundamentally incompatible spectral biases. We propose a sparse mixture-of-experts (MoE) neural operator architecture that disentrains PDE regimes through gated expert specialization, eliminating negative transfer without sacrificing cross-task transfer where beneficial. Our expert-routing PDE taxonomy assigns submanifold PDE classes (advection-dominated, diffusion-dominated, reaction-dominated, dispersion-dominated, and porous-media-dominated) to distinct transformer-based expert neural operators via a top-k softmax gate with auxiliary load-balancing loss. On a multi-PDE benchmark comprising the 2D advection-diffusion equation, 2D Burgers equation, 2D shallow water equations, and 3D Darcy flow, our MoE neural operator achieves an average relative L2 error of 0.037, compared to 0.114 for a dense baseline of equivalent parameter count and 0.092 for a dense baseline of equivalent FLOPs.
