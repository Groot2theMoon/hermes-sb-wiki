---
title: "Generative Reconstruction of Polycrystalline Microstructures using Symmetrized Hyperspherical Harmonics"
created: 2026-05-17
updated: 2026-05-17
type: concept
tags: [model, materials, mechanics, inverse-design]
sources: [raw/papers/polycrystalline-microstructure-hyperspherical-harmonics.md]
confidence: high
---

# Generative Reconstruction of Polycrystalline Microstructures using Symmetrized Hyperspherical Harmonics

**Ali R. Safi, Paul Seibert, Santiago Benito, Alexander Raßloff, Markus Kästner, Benjamin Klusemann**

*arXiv:2605.14898 (cond-mat.mtrl-sci, May 2026)*

## 개요

Establishing structure-property linkages in polycrystalline materials requires representative two-dimensional (2D) and three-dimensional (3D) microstructural inputs for full-field simulations. While 2D characterization via EBSD is widely accessible, obtaining 3D polycrystalline volumes — e.g. through serial sectioning or synchrotron tomography — remains expensive and time-consuming. This work addresses the need for a generative framework that can synthesize realistic 3D polycrystalline microstructures from limited 2D orientation data, enabling high-throughput virtual materials design.

## 핵심 아이디어

The authors introduce a **differentiable microstructure characterization and reconstruction framework** implemented in the open-source Python library **MCRpy**, built on three key innovations:

- **Symmetrized hyperspherical harmonics (SHSH):** Unit quaternions are expanded in SHSH to produce a continuous, singularity-free, rotationally-invariant representation of crystallographic orientations — overcoming the numerical discontinuities inherent to traditional Euler-angle-based methods.
- **Loss function design:** A composite objective combining (a) two-point spatial correlations for global texture, (b) a novel hybrid three-point variogram for higher-order morphology, and (c) a mean variation regularizer to capture local interfacial topology.
- **Optimization strategy:** Second-order gradient-based optimization (L-BFGS-B) efficiently navigates the complex loss landscape, generating high-fidelity 3D realizations with minimal residuals.

The framework is demonstrated on 3D reconstructions from 2D EBSD orientation data of an aluminum alloy after thermo-mechanical processing, successfully recovering both morphological features and crystallographic distribution.

## 결과

- Reconstructed 3D volumes closely match reference microstructures in terms of **two-point spatial correlations**, **grain size distributions**, and **misorientation angle distributions**.
- The SHSH representation eliminates the singularities and ambiguities of Euler-angle descriptors, enabling stable and differentiable optimization.
- The approach is fully **differentiable and open-source**, allowing integration into larger materials design workflows.
- Recovery of **both morphology and crystallographic texture** from 2D cross-sections is demonstrated quantitatively.

## 의의

This work provides a **rotationally-invariant, differentiable representation** of polycrystalline orientation fields that enables 3D microstructure generation from limited 2D data for the first time in a gradient-based optimization setting. By making the framework open-source in MCRpy, it offers a practical tool for the digital synthesis of polycrystalline representative volume elements (RVEs), accelerating microstructure-informed materials design. The SHSH representation is a significant advance over Euler-based descriptors and opens the door to end-to-end differentiable microstructure optimization for inverse design.

## 연결된 개념

- [[materials]]
- [[micromechanics-homogenization]]
- [[inverse-design]]
- [[decoding-material-networks]]
- [[deep-material-network]]
- [[ali-r-safi]]
- [[benjamin-klusemann]]
- [[markus-kaestner]]

## References

- arXiv:2605.14898 — Safi et al., "Generative reconstruction of 2D and 3D polycrystalline microstructures using symmetrized hyperspherical harmonics," May 2026.
