---
title: "Safety in ML and Systems"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [safety, domain-concept]
confidence: medium
---

# Safety in ML and Systems

Safety in ML/systems refers to the formal verification and assurance that learned models and control systems operate within prescribed constraints, particularly in safety-critical applications. It encompasses Lyapunov-based stability guarantees, barrier function methods, adversarial robustness, and formal verification of neural network-controlled systems.

## 개요

Safety-critical systems — autonomous vehicles, aircraft, industrial robots, and power grids — require rigorous guarantees that learned controllers and models will not produce hazardous behavior. Core approaches include Lyapunov stability theory for certifying convergence and boundedness, control barrier functions for enforcing safety constraints, Lipschitz-bounded networks for provably robust predictions, and formal verification via SMT/SDP solvers or combinatorial methods such as hyperplane partitioning. The field has grown rapidly with the deployment of neural network-based control and perception in real-world systems.

## 관련 개념

- [[hyparlyve-neural-lyapunov-verification]] — Hyperplane partitioning for neural Lyapunov verification
- [[lyapunov-neural-network]] — Neural Lyapunov function learning
- [[lyapunov-stable-nn-control]] — Lyapunov-stable neural network control
- [[discriminating-hyperplane-safety]] — Discriminating hyperplane approach to safety
- [[lure-stability]] — Lur'e system stability analysis
- [[predictive-control-barrier-functions]] — Control barrier functions for safe control
- [[hedesh-local-stability-roa]] — Local stability and region of attraction estimation
- [[hedesh-siami-sector-bound]] — Sector bound approaches to neural network safety
- [[lbdn-lipschitz-bounded-networks]] — Lipschitz-bounded deep networks
- [[1-lipschitz-layers-comparison]] — Comparison of 1-Lipschitz layer constructions
- [[youla-ren-stabilizing-controllers]] — Youla-Ren parametrization for stabilizing NN controllers
- [[pinn-lyapunov-functions]] — Learning Lyapunov functions via PINNs
