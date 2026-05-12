---
title: "Hybrid Modeling"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [hybrid-modeling, physics-informed, surrogate-model, system-identification, neural-operator]
confidence: medium
---

# Hybrid Modeling

Hybrid modeling refers to approaches that combine physics-based (first-principles) models with data-driven (machine learning) components to leverage the complementary strengths of both paradigms. The physics component provides generalization and physical consistency, while the data-driven component captures complex, unknown, or computationally expensive sub-processes that are difficult to model from first principles.

## 개요

Hybrid models integrate physics-based equations (PDEs, ODEs, conservation laws, constitutive relations) with neural networks or other ML components in various architectural configurations. Common patterns include: (1) **serial hybridization** — ML corrects physics model outputs or predicts unknown closure terms, (2) **parallel hybridization** — ML and physics models run alongside with a gating or fusion mechanism, (3) **physics-constrained residual** — ML predicts residuals or corrections while the physics model provides the backbone, and (4) **modular composition** — as in [[hycop-hybrid-composition-operators|HyCOP]], where learned and numerical sub-solvers are composed via learnable policies. The key challenge is maintaining physical consistency (conservation, stability) while benefiting from ML's flexibility.

## 설계 패턴

- **Learned closure models**: ML predicts unresolved sub-grid terms in coarse PDE simulations (turbulence modeling, LES).
- **Physics-guided ML**: Physical losses or constraints guide neural network training ([[physics-informed]]).
- **Hybrid surrogates**: ML accelerates numerical solvers while preserving solver structure.
- **Modular operator composition**: Composition of learned and numerical PDE modules with learnable orchestration policies ([[hycop-hybrid-composition-operators|HyCOP]]).
- **Neural solver preconditioning**: ML provides initial guesses or preconditioners for classical iterative solvers.

## 응용

Hybrid modeling is widely applied in computational fluid dynamics (RANS/LES correction), structural mechanics (constitutive model discovery), materials science (process-structure-property linkages), and digital twinning where partial physics knowledge is available alongside sensor data.

## 관련 개념

- [[physics-informed]] — Physics-informed machine learning (soft-constraint approach)
- [[hycop-hybrid-composition-operators]] — Modular hybrid composition of learned and numerical operators
- [[system-identification]] — Data-driven system modeling with physics constraints
- [[nn-poly-dynamical-system-constraints]] — NN-to-polynomial transformation for physics-constrained hybrid dynamics
- [[neural-operator]] — Neural operators as components in hybrid architectures
- [[surrogate-model]] — Surrogate modeling in hybrid physics-ML workflows
