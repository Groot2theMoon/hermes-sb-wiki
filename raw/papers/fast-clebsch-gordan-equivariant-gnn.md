---
title: "Fast contracted Clebsch-Gordan tensor products for equivariant graph neural networks"
arxiv: "2605.15073v1"
authors: ["Anton Bochkarev", "Yury Lysogorskiy", "Ralf Drautz"]
year: 2026
source: paper
ingested: 2026-05-17
conversion: web_extract
---

# Fast contracted Clebsch-Gordan tensor products for equivariant graph neural networks

**Anton Bochkarev, Yury Lysogorskiy, Ralf Drautz**

*arXiv:2605.15073v1 | Category: physics.comp-ph*

## Abstract

We present an O(L^3) algorithm for evaluating contracted Clebsch-Gordan tensor products in O(3)-equivariant machine learning potentials at fixed Canonical Polyadic (CP) rank. The antisymmetric parity-odd Clebsch-Gordan coefficients are expressed as linear combinations of symmetric Clebsch-Gordan coefficients, enabling GPU-native batched tensor operations. The algorithm achieves 19x acceleration in forward pass and 24x in backward pass over standard e3nn at L=8 cutoff.
