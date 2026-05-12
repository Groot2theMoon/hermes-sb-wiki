---
title: "Variational Approach to Nonlinear Filtering — Mitter-Newton Formulation"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [variational-methods, nonlinear-filtering, bayesian-inference, information-geometry]
sources: []
confidence: medium
---

# Variational Approach to Nonlinear Filtering

The variational approach to nonlinear filtering reformulates the filtering problem — computing the conditional distribution of the state given observations — as an **optimization over probability measures**. Originally developed by Mitter & Newton (2003), this framework casts the nonlinear filter as the minimizer of a free energy functional, opening the door to variational approximation methods.

## 개요

The Mitter-Newton variational principle establishes that the conditional path measure $P_{X|Y}$ (the filtering distribution) can be characterized as the unique minimizer of a **free energy** functional over the space of probability measures. This connects nonlinear filtering to statistical mechanics, information geometry, and variational inference. The approach provides a principled framework for deriving approximate filters when exact inference is intractable, including variational Bayes, mean-field approximations, and natural gradient methods.

## 핵심 아이디어

The core idea is to define a **reference measure** $\lambda$ (often the path measure of the signal process ignoring observations) and minimize the Kullback-Leibler divergence between an approximating measure $Q$ and the true posterior:

$$ Q^* = \arg\min_{Q \ll \lambda} \left\{ \text{KL}(Q \| \lambda) - \mathbb{E}_Q[\log \text{likelihood}] \right\} $$

This is equivalent to minimizing a variational free energy, where the optimal $Q^*$ equals the true posterior $P_{X|Y}$.

## Conditional Variational Principle (Correlated Noise)

Srinivasan, Honnappa, & Jha (2026) identified a fundamental limitation: the Mitter-Newton variational formulation **fails when signal and observation diffusions share a common noise source** (correlated noise). The joint path measure $P_{XY}$ and the product measure $P_X \otimes \lambda_Y$ become **mutually singular**, making the original free energy ill-defined.

Their **conditional variational principle** resolves this by introducing a conditional reference measure $Q$ that preserves the noise correlation structure:

- $Q_Y = P_Y$ (observation marginal preserved)
- $P_{X|Y}(\cdot, y) \ll Q_{X|Y}(\cdot, y)$ (conditional absolute continuity)
- The original Mitter-Newton formulation is recovered when noises are independent

## Connections to Practice

| Application | Method | Connection |
|-------------|--------|------------|
| **Variational Bayes Adaptive KF** | VB approximation with conjugate priors | KL minimization over factorized posteriors |
| **Natural Gradient Filtering** | NANO filter (Kim et al., 2026) | Information-geometric optimization on statistical manifold |
| **SpectralQuant** | Spectral concentration for quantization | Variational bounds on embedding compression |
| **RIGOR Filter** | Differentiable SR-UKF | Variational loss design for learned filters |

## 관련 개념

- [[variational-bayes-adaptive-kalman-filter]] — VBAKF: practical VB inference for adaptive noise covariance
- [[variational-robust-kalman-filter]] — Student's t robust KF within VB framework
- [[natural-gradient-bayesian-filtering]] — NANO filter: information-geometric Gaussian filtering
- [[harsha-honnappa]] — Co-author of conditional variational principle for correlated noise
- [[rigor-filter]] — RIGOR: differentiable filtering framework
- [[square-root-unscented-kalman-filter]] — SR-UKF: numerical implementation target for VB methods
