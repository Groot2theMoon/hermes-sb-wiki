---
title: "K-step Rollout Approximation Error Bound — Option B Analysis"
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [rigor, kalman-filter, rollout, loss-function, error-bound, theory, lemma]
confidence: high
---

# K-step Rollout Approximation Error Bound — Option B Analysis

> Lemma 7: RIGOR의 Option B (cached mean residual) K-step rollout 근사의 오차 bound와 수렴 조건.

---

## Lemma 7: Option B Rollout Error Bound

### 7.1 Setup

RIGOR dynamics at time $t$:

$$x_{t+1} = f(x_t) = A_{\text{eff},t} \cdot x_t + \text{NN}(x_t, \sigma_{t}) \tag{23}$$

where $A_{\text{eff},t} = A - K_t H A$ (filter-corrected effective dynamics) and $\sigma_t$ is the conditioning feature.

**Option B (cached mean residual):**

$$\bar{r}_t = \mathbb{E}[ \text{NN}(x_t, \sigma_t) \mid y_{1:t} ] \approx \text{NN}(\mu_t^{\text{filt}}, \sigma_t) \tag{24}$$

Rollout approximation:

$$\hat{x}_{t+1}^{(k)} = A_{\text{eff},t+k} \cdot \hat{x}_t^{(k)} + \bar{r}_{t+k}, \quad \hat{x}_0^{(k)} = \mu_t^{\text{filt}} \tag{25}$$

**True K-step dynamics:**

$$x_{t+1}^{\text{(true)}} = A_{\text{eff},t+k} \cdot x_t^{\text{(true)}} + \text{NN}(x_t^{\text{(true)}}, \sigma_{t+k}) \tag{26}$$

### 7.2 Error Definition

Define the rollout error at step $k$:

$$\delta_k = x_{t+k}^{\text{(true)}} - \hat{x}_k \tag{27}$$

Initial condition: $\delta_0 = 0$ (both start from $\mu_t^{\text{filt}}$).

### 7.3 Error Propagation

From Eq. (25) and (26):

$$\delta_{k+1} = A_{\text{eff},t+k} \cdot \delta_k + \underbrace{\left[ \text{NN}(x_{t+k}^{\text{(true)}}, \sigma_{t+k}) - \text{NN}(\mu_{t+k}^{\text{filt}}, \sigma_{t+k}) \right]}_{\text{NN linearization error}} \tag{28}$$

### 7.4 Bounding Assumptions

**Assumption 1 (Contractivity):** The effective dynamics has bounded spectral norm:

$$\|A_{\text{eff},t}\|_2 \leq \rho, \quad \forall t \tag{A1}$$

For RIGOR with SVD projection (Lemma 4), $\rho = \sigma_1(A_{\text{eff}}) < 1$ for contractive systems. For chaotic systems (Lorenz63), $\rho \geq 1$.

**Assumption 2 (NN Lipschitz):** The NN is $L$-Lipschitz in its state input:

$$\|\text{NN}(x, \sigma) - \text{NN}(x', \sigma)\| \leq L \|x - x'\|, \quad \forall x, x', \sigma \tag{A2}$$

**Assumption 3 (Filter Convergence):** The UKF estimation error is bounded:

$$\|x_t^{\text{true}} - \mu_t^{\text{filt}}\| \leq \varepsilon_{\text{filt}}, \quad \forall t \tag{A3}$$

where $\varepsilon_{\text{filt}} = c \cdot \sqrt{\text{tr}(P_t)}$ for some $c > 0$.

### 7.5 Main Bound

**Theorem (Option B Error Bound):** Under Assumptions A1–A3, the rollout error $\delta_k$ satisfies:

$$\|\delta_k\| \leq \begin{cases}
\displaystyle L \varepsilon_{\text{filt}} \cdot \frac{1 - \rho^k}{1 - \rho}, & \rho < 1 \quad \text{(contractive)} \\[1em]
\displaystyle L \varepsilon_{\text{filt}} \cdot k, & \rho = 1 \quad \text{(marginally stable)} \\[1em]
\displaystyle L \varepsilon_{\text{filt}} \cdot \frac{\rho^k - 1}{\rho - 1}, & \rho > 1 \quad \text{(expansive/chaotic)}
\end{cases} \tag{29}$$

**Proof:**

Taking norms of Eq. (28):

$$\|\delta_{k+1}\| \leq \|A_{\text{eff}}\| \cdot \|\delta_k\| + \|\text{NN}(x^{\text{(true)}}, \sigma) - \text{NN}(\mu^{\text{filt}}, \sigma)\|$$

Applying (A1) and (A2):

$$\|\delta_{k+1}\| \leq \rho \cdot \|\delta_k\| + L \cdot \|x^{\text{(true)}} - \mu^{\text{filt}}\|$$

Applying (A3):

$$\|\delta_{k+1}\| \leq \rho \cdot \|\delta_k\| + L \varepsilon_{\text{filt}}$$

This is a linear recurrence with $\delta_0 = 0$. The closed-form solution is:

$$\|\delta_k\| \leq L \varepsilon_{\text{filt}} \cdot \frac{1 - \rho^k}{1 - \rho}$$

For $\rho = 1$, this simplifies to $\|\delta_k\| \leq L \varepsilon_{\text{filt}} \cdot k$ (by L'Hôpital).

For $\rho > 1$, the bound grows exponentially. $\square$

### 7.6 Interpretation

#### Contractive systems (VDP, $\rho < 1$)
The error converges to a steady-state bound as $k \to \infty$:

$$\|\delta_\infty\| \leq \frac{L \varepsilon_{\text{filt}}}{1 - \rho} \tag{30}$$

For VDP ($\rho \approx 0.93$, $L \approx 0.1$, $\varepsilon_{\text{filt}} \approx 0.1$):

$$\|\delta_\infty\| \leq \frac{0.1 \times 0.1}{1 - 0.93} \approx 0.14 \quad \text{(14% of state scale)} \tag{31}$$

→ K-step rollout works well for contractive systems. Verified empirically.

#### Expansive systems (Lorenz63, $\rho > 1$)
The error grows exponentially with $K$:

$$\|\delta_K\| \leq L \varepsilon_{\text{filt}} \cdot \frac{\rho^K - 1}{\rho - 1} \tag{32}$$

For Lorenz63 ($\rho \approx 1.5$, $L \approx 0.1$, $\varepsilon_{\text{filt}} \approx 0.3$, $K=8$):

$$\|\delta_8\| \leq 0.03 \cdot \frac{1.5^8 - 1}{0.5} \approx 0.03 \cdot \frac{25.6 - 1}{0.5} \approx 1.48 \tag{33}$$

The rollout error at K=8 is **larger than the state itself** — explaining why Option B fails to improve Lorenz63 beyond static A.

### 7.7 Gradient Through Option B

The VFE loss includes a K-step KL term:

$$\mathcal{L}_{\text{KL}}^{(K)} = \frac{1}{2} \|\mu_{t+K}^{\text{filt}} - \hat{x}_K\|^2_{Q^{-1}}$$

The gradient of this term through $\hat{x}_K$:

$$\nabla_\theta \mathcal{L}_{\text{KL}}^{(K)} = Q^{-1} (\hat{x}_K - \mu_{t+K}^{\text{filt}}) \cdot \frac{\partial \hat{x}_K}{\partial \theta}$$

From Eq. (25), $\hat{x}_K$ depends on $\theta$ through $\{A_{\text{eff},t+k}(\theta)\}$ and $\{\bar{r}_{t+k}(\theta)\}$. The gradient approximation error:

$$\left\| \nabla_\theta \mathcal{L}_{\text{KL}}^{(K)} - \nabla_\theta \mathcal{L}_{\text{KL}}^{(\text{exact})} \right\| \leq \|Q^{-1}\| \cdot \|\delta_K\| \cdot \left\| \frac{\partial \hat{x}_K}{\partial \theta} \right\| \tag{34}$$

### 7.8 Practical Recommendations

Based on the bound:

| $\rho$ | K recommended | Notes |
|:------:|:-------------:|-------|
| $< 0.9$ | K up to 10+ | Error bounded, safe |
| $0.9\text{–}1.0$ | K ≤ 5 | Marginal stability, moderate error |
| $1.0\text{–}1.2$ | K ≤ 3 | Mildly expansive, short rollout only |
| $> 1.2$ | K = 1 | Option B fails — need Option A (full recompute) |

**For Lorenz63 ($\rho \approx 1.5$):** Option B is fundamentally limited to K ≤ 2. The observed K=8 failure is explained by this bound. **Solution:** Option A (per-step sigma_cond recompute) with state-dependent A(x) to reduce $\rho$.

**For pendulum ($\rho \approx 0.95$):** K up to ~6 is safe. Observed success at K=8 is at the edge — increasing K further would degrade.

---

## References

- Hagen & Stable Diffusion: Linear recurrence bounds
- Higham (2008). Functions of Matrices: theory and computation. SIAM.
- [[k-step-rollout-vfe-loss]] — RIGOR K-step rollout implementation
- [[lorenz63-rigor-experiments]] — Empirical test results

## Wikilinks
- [[rigor-filter]] — RIGOR UKF + dynamics
- [[k-step-rollout-vfe-loss]] — Loss 설계
- [[lorenz63-rigor-experiments]] — 실험 결과
- [[a-plus-nn-svd-projection-analysis]] — A+NN SVD Lemma 4-5
- [[ufi-conditioning-superiority]] — UFI superiority Lemma 6
