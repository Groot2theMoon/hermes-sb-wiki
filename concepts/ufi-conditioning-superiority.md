---
title: "UFI Conditioning Superiority — Sigma Cloud vs Ensemble Conditioning"
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [rigor, ukf, enkf, ufi, sigma-cloud, conditioning, theory, lemma]
confidence: high
---

# UFI Conditioning Superiority — Sigma Cloud vs Ensemble Conditioning

> Lemma 6: UKF의 deterministic sigma cloud로부터 계산된 $\sigma_{\text{cond}}$ feature는 EnKF의 random ensemble로부터 계산된 것보다 **strictly superior**하다.

---

## Lemma 6: Sigma Cloud Conditioning Stability

### 6.1 Setup

Given Gaussian posterior $p(x_t | y_{1:t}) \approx \mathcal{N}(\mu_t, P_t)$ at time $t$.

Define the **conditioning feature** $\sigma_{\text{cond}} \in \mathbb{R}^{m}$ computed from the particle set:

$$\sigma_{\text{cond}} = g\left(\{z_i\}_{i=1}^{M}\right)$$

where $\{z_i\}_{i=1}^{M}$ is a set of weighted particles representing the filtered distribution and $g$ is a deterministic function (e.g., computing per-dimension std and skew of the propagated cloud).

**For UKF:** $\{z_i\} = \{\chi_i\}_{i=0}^{2n}$ — deterministic sigma points.

**For EnKF:** $\{z_i\} = \{x^{(j)}\}_{j=1}^{N}$ — random ensemble members.

### 6.2 Determinism vs. Stochasticity

**UKF:** The sigma points $\chi_i$ are a deterministic function of $(\mu_t, P_t)$ per Eq. (1). Since $(\mu_t, P_t)$ are fixed at a given training step:

$$\sigma_{\text{cond}}^{\text{UKF}} = g(\{\chi_i(\mu_t, P_t)\}) \quad \text{is deterministic}$$

$$\boxed{\text{Var}\left[\sigma_{\text{cond}}^{\text{UKF}} \mid \mu_t, P_t\right] = 0}$$

**EnKF:** The ensemble members $x^{(j)} \sim \mathcal{N}(\mu_t, P_t)$ are i.i.d. random draws:

$$\sigma_{\text{cond}}^{\text{EnKF}} = g(\{x^{(j)}\}_{j=1}^{N}) \quad \text{is a random variable}$$

The conditional distribution $p(\sigma_{\text{cond}}^{\text{EnKF}} \mid \mu_t, P_t)$ has non-zero variance for any finite $N$.

### 6.3 Variance Propagation Through NN

The NN in RIGOR receives $\sigma_{\text{cond}}$ as a conditioning input:

$$y = \text{NN}(x, \sigma_{\text{cond}}; \theta)$$

For EnKF, the conditioning feature noise propagates through NN:

$$\text{Var}[\text{NN}(x, \sigma_{\text{cond}}^{\text{EnKF}}; \theta)] \approx \left(\frac{\partial \text{NN}}{\partial \sigma}\right)^\top \cdot \text{Var}[\sigma_{\text{cond}}^{\text{EnKF}}] \cdot \frac{\partial \text{NN}}{\partial \sigma} + \mathcal{O}(1/N^2)$$

where the leading term scales as:

$$\text{Var}[\sigma_{\text{cond}}^{\text{EnKF}}] = \mathcal{O}\left(\frac{1}{N}\right)$$

**Theorem:** For any differentiable NN with non-zero sensitivity to $\sigma_{\text{cond}}$, the EnKF conditioning adds $\mathcal{O}(1/N)$ variance to the dynamics output. This is **irreducible** for finite $N$.

$$\text{Var}[\text{NN}(x, \sigma_{\text{cond}}^{\text{EnKF}})] = \Omega(1/N) > 0, \quad \forall N < \infty$$

**Corollary:** The dynamics learned with EnKF conditioning is stochastically equivalent to the UKF dynamics with **inflated process noise**:

$$Q_{\text{eff}}^{\text{EnKF}} = Q + \text{Var}[\text{NN}^{\text{EnKF}}] > Q = Q_{\text{eff}}^{\text{UKF}}$$

### 6.4 Gradient Consistency

The gradient of the loss with respect to network parameters $\theta$ involves $\frac{\partial \text{NN}}{\partial \sigma} \cdot \frac{\partial \sigma}{\partial \theta}$. For UKF:

$$\frac{\partial \sigma_{\text{cond}}^{\text{UKF}}}{\partial \theta} = \frac{\partial g}{\partial \chi} \cdot \frac{\partial \chi}{\partial \mu} \cdot \frac{\partial \mu}{\partial \theta} + \frac{\partial g}{\partial \chi} \cdot \frac{\partial \chi}{\partial P} \cdot \frac{\partial P}{\partial \theta}$$

This gradient is **deterministic** — backpropagation through the sigma point computation is well-defined and reproducible.

For EnKF, $\frac{\partial x^{(j)}}{\partial \theta}$ is undefined because $x^{(j)}$ are random draws, not differentiable functions of $(\mu, P)$. The reparameterization trick $x^{(j)} = \mu + L \epsilon^{(j)}$ where $P = LL^\top$ and $\epsilon^{(j)} \sim \mathcal{N}(0, I)$ makes this differentiable, but the gradient estimator:

$$\nabla_\theta \mathcal{L}^{\text{EnKF}} \approx \frac{1}{N} \sum_{j=1}^N \frac{\partial \mathcal{L}}{\partial \text{NN}} \cdot \frac{\partial \text{NN}}{\partial \sigma} \cdot \left(\frac{\partial \sigma}{\partial \mu} \frac{\partial \mu}{\partial \theta} + \frac{\partial \sigma}{\partial L} \frac{\partial L}{\partial \theta}\right)$$

retains $\mathcal{O}(1/\sqrt{N})$ Monte Carlo noise from the random draws $\{\epsilon^{(j)}\}$.

### 6.5 Practical Implication

| Aspect | UKF UFI | EnKF UFI (hypothetical) |
|--------|:-------:|:----------------------:|
| $\sigma_{\text{cond}}$ determinism | **Deterministic** | Random ($\mathcal{O}(1/N)$ variance) |
| NN output noise | **Zero** (from conditioning) | $\Omega(1/N)$ |
| Gradient through $\sigma$ | **Clean** (deterministic) | Noisy (Monte Carlo) |
| Effective $Q$ | $Q$ | $Q + \mathcal{O}(1/N)$ |
| Learning stability | **High** | Degraded for small $N$ |

**Conclusion:** UFI's sigma cloud conditioning is fundamentally incompatible with EnKF's stochastic ensemble. The deterministic sigma cloud is a **necessary condition** for stable conditioning feature learning. This is not an engineering detail — it is a structural requirement.

---

## References

- Kingma & Welling (2014). Auto-Encoding Variational Bayes. (reparameterization trick)
- Roeder et al. (2017). Sticking the Landing: Simple, Lower-Variance Gradient Estimators for Variational Inference.
- Lemma 1–3: [[ukf-enkf-gradient-variance-analysis]]
- [[unscented-feature-interaction]] — UFI: sigma cloud conditioning design

## Wikilinks
- [[ukf-enkf-gradient-variance-analysis]] — Lemma 1-3 (UKF vs EnKF gradient)
- [[unscented-feature-interaction]] — UFI 구현
- [[rigor-filter]] — RIGOR UKF 구현
- [[a-plus-nn-svd-projection-analysis]] — A+NN SVD Lemma 4-5
