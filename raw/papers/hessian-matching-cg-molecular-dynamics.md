---
title: "Hessian Matching for Machine-Learned Coarse-Grained Molecular Dynamics"
arxiv: "2605.12823"
authors: ["Sanya Murdeshwar", "Sanjit Shashi", "Kevin Bachelor", "William Noid", "Ashwin Lokapally", "Razvan Marinescu"]
year: 2026
source: paper
ingested: 2026-05-17
conversion: web_extract
---

# Hessian Matching for Machine-Learned Coarse-Grained Molecular Dynamics

**Sanya Murdeshwar, Sanjit Shashi, Kevin Bachelor, William Noid, Ashwin Lokapally, Razvan Marinescu**

*arXiv:2605.12823 | Category: cs.LG, physics.comp-ph*

## Abstract

Coarse-grained (CG) molecular dynamics enables simulations of atomic systems such as biomolecules at timescales inaccessible to all-atom (AA) methods, but existing CG neural potentials trained via force matching capture only the gradient of the free-energy surface, leaving its curvature unconstrained. We introduce a framework that augments force matching with stochastic Hessian-vector product (HVP) matching, instilling second-order curvature information into CG potentials without constructing the full Hessian explicitly. On a benchmark of six peptide and small-protein systems (alanine dipeptide, chignolin, trp-cage, villin headpiece, BBA, and WW domain), HVP matching reduces the mean force error by up to 28% over force matching alone, improves the rank correlation of predicted relative free-energy differences, and more faithfully reproduces the dynamical properties (diffusion coefficients, reorientation times) of all-atom reference simulations. Ablation studies show that HVP matching contributes most significantly in conformational basins where the free-energy surface has non-negligible curvature, precisely where force matching alone is least informative.
