---
title: "PINODE (Physics-Informed Neural ODE)"
slug: "pinode-physics-informed-neural-ode"
aliases:
  - "Physics-Informed Neural ODE"
  - "PINODE"
authors:
  - "Aleksey Sholokhov"
  - "Yuying Liu"
  - "Hassan Mansour"
  - "Saleh Nabi"
year: 2023
journal: "Scientific Reports, 13, 13766"
doi: "10.1038/s41598-023-36799-6"
source: "paper"
concept: true
related_concepts:
  - "physics-informed-neural-networks"
  - "neural-odes"
  - "surrogate-model"
  - "physics-constrained-surrogate"
  - "universal-differential-equations"
  - "autoencoder-rom"
tags:
  - "reduced-order-modeling"
  - "physics-informed"
  - "collocation"
  - "neural-ode"
  - "latent-dynamics"
  - "data-scarce"
  - "scientific-machine-learning"
---

## PINODE (Physics-Informed Neural ODE)

**PINODE (Physics-Informed Neural ODE)** is a framework for building [[physics-constrained-surrogate|physics-constrained reduced-order models (ROMs)]] that combines an [[autoencoder-rom|autoencoder-based ROM]] with [[neural-odes|Neural ODE]] latent dynamics and a collocation-based [[physics-informed-neural-networks|physics-informed]] loss term. It was introduced by Sholokhov, Liu, Mansour, and Nabi in a 2023 *Scientific Reports* paper.

The key innovation is embedding known PDE/ODE governing equations into the training process via **collocation points** — cheaply sampled state‑derivative pairs $(\tilde{x}, f(\tilde{x}))$ — that enforce the chain‑rule relationship between the encoder gradient and the latent dynamics. This allows the model to learn from physics even when observational data is scarce, noisy, or incomplete.

---

## Architecture

PINODE uses three neural networks:

- **Encoder** $\phi_\theta: \mathcal{X} \to \mathcal{Z}$ — maps high-dimensional observable states $x \in \mathbb{R}^n$ to a low-dimensional latent space $z \in \mathbb{R}^m$ ($m \ll n$).
- **Decoder** $\psi_\theta: \mathcal{Z} \to \mathcal{X}$ — reconstructs observable states from latent variables.
- **Latent dynamics** $h_\theta: \mathcal{Z} \to \mathcal{Z}$ — a Neural ODE that defines the continuous-time evolution $\frac{dz}{dt} = h_\theta(z)$ in the latent space.

The autoencoder pair $(\phi_\theta, \psi_\theta)$ learns the nonlinear manifold, while $h_\theta$ captures the reduced-order dynamics.

---

## Loss Function

The training objective combines two terms:

### Data-Driven Loss $\mathcal{L}_\theta^\text{data}$

Minimizes reconstruction error (encoder–decoder consistency) and prediction error (matching forecasted trajectories to observed data):

$$
\mathcal{L}_\theta^\text{data} = \frac{1}{2\sigma^2} \sum_{i=1}^k \sum_{j=1}^p \left[ \frac{\omega_1}{p} \| x_i(t_j) - \psi_\theta(\phi_\theta(x_i(t_j))) \|^2 + \frac{\omega_2}{p} \left\| \psi_\theta\!\left( \phi_\theta(x_i(t_1)) + \int_{t_1}^{t_j} h_\theta(z) dt \right) - x_i(t_j) \right\|^2 \right]
$$

### Physics-Informed Loss $\mathcal{L}_\theta^\text{physics}$

Enforces consistency between the known governing equation $\frac{dx}{dt} = f(x)$ and the learned latent dynamics via the chain rule:

$$
\mathcal{L}_\theta^\text{physics} = \sum_{i=1}^N \left[ \frac{\omega_3}{N} \| h_\theta(\phi(\tilde{x}_i)) - \nabla \phi_\theta(\tilde{x}_i) f(\tilde{x}_i) \|^2 + \frac{\omega_4}{N} \| \tilde{x}_i - \psi_\theta(\phi_\theta(\tilde{x}_i)) \| \right]
$$

The key identity being enforced is:

$$
h(\phi(x(t))) = \nabla \phi(x)^T f(x)
$$

### Combined Objective

$$
\min_\theta \left[ \mathcal{L}_\theta^\text{physics} + \mathcal{L}_\theta^\text{data} \right]
$$

Three modes are defined:
- **Data-Driven**: $\omega_3 = \omega_4 = 0$ (data only)
- **Physics-Informed**: $\omega_1 = \omega_2 = 0$ (collocation points only)
- **Hybrid**: all $\omega_i \neq 0$ (best of both worlds)

---

## Collocation Points

Collocation points $(\tilde{x}, f(\tilde{x}))$ are samples from the state space paired with their known time-derivatives. They serve as a cheap, noise-free information source and must satisfy three conditions:

1. **Simplicity** — $f(\tilde{x}_i)$ should be computationally cheap to evaluate (especially important for PDEs with high-order derivatives).
2. **Representativeness** — $\tilde{x}_i$ should cover the space of states where improved performance or stability is desired.
3. **Feasibility** — $\tilde{x}_i$ must be an attainable state of the system (i.e., $\tilde{x}_i \in \mathcal{X}$).

These differ from classical collocation in numerical analysis (which defines optimal time-points for local interpolants like Runge‑Kutta methods). Here, collocation points are spatial state samples used to solve the *inverse* problem of approximating $\dot{x} = f(x)$.

---

## Key Results & Performance Gains

### 1. Extrapolation to Unseen Basins of Attraction
On a **lifted Duffing oscillator** (high-dimensional ODE with three basins of attraction), a purely data-driven model trained on only one basin failed to extrapolate to the others. The hybrid PINODE model, using collocation points from the unseen regions, correctly predicted dynamics across all three basins — demonstrating that collocation points can "fill gaps" in the training data.

### 2. Latent Space Compression
On advection-dominated **Burgers' equation** ($\nu = 0.01$):
- PINODE achieved **×5 lower MSE** than PIKN (linear latent dynamics) at the same latent dimension ($m=16$).
- PINODE maintained low prediction error over **×2 longer time horizons**, while PIKN suffered from eigenvalues with positive real parts causing long-term instability.
- PINODE utilized the latent space **×100 more efficiently** in extrapolation tasks.

### 3. Low-Data Regime Performance
- Adding collocation points consistently improved model accuracy in data-scarce settings.
- A collocation-aided model with fewer trajectories **outperformed** the model using all available trajectories without collocations.
- **Average ×5 improvement** in MSE for both within-distribution and out-of-distribution reconstruction.
- A **physics-only model** (trained on collocation points alone) sometimes outperformed the most data-rich purely data-driven model.

### 4. Noise Robustness
- In high-noise regimes ($\sigma > 1$, noise dominating the signal), purely data-driven models (PINODE Data-Driven, DMD) showed unbounded error growth.
- The hybrid model's error converged to that of the Physics-Informed model, which relies on noise-free collocation points.
- The physics-informed loss acts as a **safeguard**: when the data-driven loss becomes uninformative noise, optimization effectively reverts to minimizing only the physics-informed loss via noisy gradient descent.

### 5. Long-Term Forecasting Stability
- Hybrid model maintained errors **below $10^{-2}$** when forecasting **10× beyond** the training time horizon.
- Purely data-driven model errors grew quickly once forecasting past the training window.
- **×200 improvement** in far-out out-of-distribution forecasting relative to purely data-driven models.

---

## Relationship to Other Methods

| Method | Latent Dynamics | Physics Integration | Key Limitation |
|--------|----------------|-------------------|----------------|
| **DMD** | Linear (POD projection) | None (data-only) | Linear reduction insufficient for nonlinear systems |
| **PIKN** (Liu et al.) | Linear (Koopman matrix $Lz$) | Collocation-based | Linear latent dynamics cause instability; requires larger latent dim |
| **SINDy-AE** (Champion et al.) | Sparse symbolic | Chain-rule loss | Sensitive to noise in finite-difference derivatives |
| **LASDI** (Fries et al.) | Parametric latent | Chain-rule loss | Noise-sensitive derivatives |
| **PINODE** (Ours) | **Nonlinear Neural ODE** $h_\theta(z)$ | **Collocation-based** | Collocation family is a design choice |

PINODE is the first framework combining:
- Nonlinear latent dynamics (Neural ODE)
- Autoencoder-based nonlinear ROM
- Collocation-based physics-informed loss

It is closely related to [[universal-differential-equations|Universal Differential Equations]], which also combine known physics with neural components, but PINODE specifically targets the ROM setting with autoencoder dimensionality reduction.

---

## Implementation

- Built with **PyTorch** and **torchdiffeq** (Neural ODE integration and adjoint sensitivity method).
- Optimized with the **Adam** algorithm.
- Collocation points per batch are set to match the number of snapshots per batch: $N_\text{batch} = T \cdot k_\text{batch}$ for balanced loss contributions.
- All hyperparameters $\omega_i$ set to either 0 or 1 in experiments; balancing is done via batch composition rather than tuning weights.

---

## Limitations & Future Work

1. **Collocation family design** is a manual, domain-specific decision — automating this via classical numerical analysis is an open direction.
2. **Adaptive sampling** of collocation points (e.g., via modern active learning) could further improve efficiency.
3. **Rigorous theoretical analysis** of noise robustness guarantees is left for future work.

---

## References

- Sholokhov, A., Liu, Y., Mansour, H., & Nabi, S. (2023). Physics-informed neural ODE (PINODE): embedding physics into models using collocation points. *Scientific Reports*, 13, 13766. DOI: [10.1038/s41598-023-36799-6](https://doi.org/10.1038/s41598-023-36799-6)
- Chen, T. Q., Rubanova, Y., Bettencourt, J., & Duvenaud, D. K. (2018). Neural ordinary differential equations. *NeurIPS*.
- Liu, Y., Sholokhov, A., Mansour, H., & Nabi, S. (2022). Physics-informed Koopman network. arXiv:2211.09419.
- Champion, K., Lusch, B., Kutz, J. N., & Brunton, S. L. (2019). Data-driven discovery of coordinates and governing equations. *PNAS*, 116, 22445–22451.
