---
title: "Dynamical Variational Autoencoder (DVAE)"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [variational-autoencoder, dynamical-systems, sequential-data, generative-model, time-series]
confidence: high
---

# Dynamical Variational Autoencoder (DVAE)

Dynamical Variational Autoencoders (DVAEs) extend the standard Variational Autoencoder (VAE) framework to **sequential data** by introducing temporal dynamics in the latent space. Instead of independent latent codes per observation, DVAEs model the latent states as evolving according to a dynamical system.

## Architecture

A DVAE consists of three components:

1. **Transition model (prior)**: `p(z_t | z_{<t})` — latent dynamics defining how states evolve over time.
2. **Encoder (inference model)**: `q(z_{1:T} | x_{1:T})` — approximate posterior over latent trajectories given observations.
3. **Decoder (likelihood model)**: `p(x_t | z_t)` — maps latent states to observations.

The model is trained by maximizing the **evidence lower bound (ELBO)**:

```
log p(x_{1:T}) ≥ E_q [log p(x_{1:T} | z_{1:T})] - KL(q(z_{1:T} | x_{1:T}) || p(z_{1:T}))
```

## Variants

- **Deep Markov Model (DMM)** / Structured Inference Networks: Krishnan et al. (2017) — uses RNN-based encoders with learned transition models.
- **Kalman VAE**: Fraccaro et al. (2017) — linear Gaussian dynamics in latent space with VAE-style inference.
- **Double Projection DVAE**: Sip et al. (2025) — encodes observations into both state trajectories and noise, enabling stochastic multi-step prediction.
- **Recurrent VAE**: Simple RNN-based latent transitions with VAE encoding per timestep.

## Relationship to Other Models

- **VAE → DVAE**: Standard VAE assumes i.i.d. latents; DVAE introduces temporal structure.
- **State-space models (SSMs)**: DVAEs are deep, nonlinear generalizations of SSMs where both the transition and emission models are learned neural networks.
- **Neural ODEs**: Continuous-time DVAEs replace discrete transitions with ODE-specified latent dynamics.
- **Filtering**: Unlike Kalman filters (which are recursive and online), DVAEs typically perform batch inference over entire sequences.

## Applications

- **Dynamical system reconstruction**: Learning unknown dynamics from partial/noisy observations.
- **Time series forecasting**: Multi-step prediction with uncertainty quantification.
- **Simulation-based inference**: Generating realistic trajectories for physical systems.

## Wikilinks
- [[double-projection-dva-reconstruction]] — DVAE-based dynamical system reconstruction
- [[variational-autoencoder]] — Standard VAE foundation
- [[neural-ode-dynamical-systems]] — Neural ODE for system identification
- [[deep-kalman-filter]] — DKF, related temporal VAE
- [[structured-inference-networks]] — Deep Markov Models

## References
- Krishnan, R. G., Shalit, U., & Sontag, D. (2017). Structured Inference Networks for Nonlinear State Space Models. AAAI 2017.
- Fraccaro, M. et al. (2017). A Disentangled Recognition and Nonlinear Dynamics Model for Unsupervised Learning. NeurIPS 2017.
- Sip, V. et al. (2025). Double Projection for Reconstructing Dynamical Systems. arXiv:2510.01089v2.
