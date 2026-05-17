---
title: "Peng Chen"
created: 2026-05-17
updated: 2026-05-17
type: entity
tags: [person, surrogate-model, fluid-dynamics, digital-twin, neural-ode]
sources: [raw/papers/cldnet-flood-digital-twin-swe-surrogate.md]
confidence: high
---

# Peng Chen

Peng Chen is the corresponding author of *"Toward AI-Driven Digital Twins for Metropolitan Floods: A Conditional Latent Dynamics Network Surrogate of the Shallow Water Equations"* (arXiv:2605.13761, 2026), which introduces CLDNet — a conditional latent dynamics network for real-time flood digital twin surrogates.

## 주요 기여

### CLDNet: Conditional Latent Dynamics Network (2026)
- Proposed a neural PDE surrogate that learns latent dynamics of Shallow Water Equations (SWE) via a conditional neural-ODE in a compressed latent space
- Achieved **1,435× speedup** (55 min → 2.3 sec) over GPU-accelerated SWE solvers on a ~4.2M active cell metropolitan basin
- Demonstrated **2.1% water depth error** with generalization to unseen rainfall patterns, enabling real-time flood digital twin applications

## Wikilinks

- [[cldnet-flood-digital-twin-swe-surrogate]]
- [[digital-twin]]
- [[neural-ode]]
- [[surrogate-model]]
- [[autoencoder-rom]]
