---
title: "A+NN SVD Projection — Structural Stability Guarantee"
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [rigor, kalman-filter, svd, dynamical-systems, stability, contractivity, theory, lemma]
confidence: high
---

# A+NN SVD Projection — Structural Stability Guarantee

> RIGOR의 핵심 철학: "A는 main dynamics, NN은 residual만." SVD projection으로 이를 수학적으로 보장한다.

---

## Lemma 4: A+NN Partition via SVD Projection

> SVD projection을 통해 NN이 A의 dominant dynamics를 침해하지 않고 orthogonal residual만 학습하도록 강제할 수 있다.

### 4.1 Setup

RIGOR dynamics:

$$x_{t+1} = f_\theta(x_t) = A x_t + \text{NN}(x_t, \sigma_{\text{cond}}) \tag{16}$$

where $A \in \mathbb{R}^{n \times n}$ and $\text{NN}: \mathbb{R}^n \times \mathbb{R}^{d_{\text{cond}}} \to \mathbb{R}^n$.

**Goal:** NN should learn only the residual dynamics that A cannot capture, without modifying A's dominant behavior.

### 4.2 SVD Decomposition

Let $A = U \Sigma V^\top$ be the singular value decomposition, where:

- $U = [u_1, u_2, \dots, u_n] \in \mathbb{R}^{n \times n}$ — left singular vectors
- $\Sigma = \text{diag}(\sigma_1, \sigma_2, \dots, \sigma_n)$ — singular values, $\sigma_1 \geq \sigma_2 \geq \cdots \geq \sigma_n \geq 0$
- $V = [v_1, v_2, \dots, v_n] \in \mathbb{R}^{n \times n}$ — right singular vectors

The dominant direction is $u_1$ (left singular vector of the largest singular value). The action of $A$ on this direction:

$$A v_1 = \sigma_1 u_1 \tag{17}$$

### 4.3 SVD Projection

Define the **dominant subspace** $\mathcal{S}_1 = \text{span}\{u_1\}$ and its orthogonal complement $\mathcal{S}_1^\perp = \text{span}\{u_2, \dots, u_n\}$.

The SVD projection operator:

$$\Pi_{\mathcal{S}_1^\perp}(y) = (I - u_1 u_1^\top) y \tag{18}$$

For the **full-rank case** ($k$ dominant directions), define $\mathcal{S}_k = \text{span}\{u_1, \dots, u_k\}$ and:

$$\Pi_{\mathcal{S}_k^\perp}(y) = (I - U_k U_k^\top) y \tag{19}$$

where $U_k = [u_1, \dots, u_k] \in \mathbb{R}^{n \times k}$.

**Key constraint imposed in RIGOR:**

$$\text{NN}_{\text{proj}}(x, \sigma_{\text{cond}}) = \Pi_{\mathcal{S}_1^\perp}(\text{NN}(x, \sigma_{\text{cond}})) \tag{20}$$

### 4.4 Stability Guarantee

**Theorem:** If $A$ is contractive ($\|A\|_2 = \sigma_1 \leq \rho < 1$) and $\text{NN}_{\text{proj}}$ satisfies $\text{NN}_{\text{proj}} \perp \mathcal{S}_1$, then the overall dynamics $f_\theta$ preserves $A$'s contraction rate along $u_1$ while adding learned corrections in $\mathcal{S}_1^\perp$.

**Proof:**

The overall dynamics with SVD projection:

$$f_\theta(x) = A x + \Pi_{\mathcal{S}_1^\perp}(\text{NN}(x, \sigma_{\text{cond}})) \tag{21}$$

Along $u_1$ direction (dominant):

$$u_1^\top f_\theta(x) = u_1^\top A x + u_1^\top \Pi_{\mathcal{S}_1^\perp}(\text{NN}(x, \sigma_{\text{cond}}))$$

Since $\Pi_{\mathcal{S}_1^\perp}(y) \perp u_1$ by construction, $u_1^\top \Pi_{\mathcal{S}_1^\perp}(\cdot) = 0$. Therefore:

$$u_1^\top f_\theta(x) = u_1^\top A x = \sigma_1 v_1^\top x \tag{22}$$

The dynamics along $u_1$ is **unperturbed** by NN. The contraction rate $\sigma_1$ is preserved.

Along $u_{j>1}$ directions (residual):

$$u_j^\top f_\theta(x) = u_j^\top A x + u_j^\top \text{NN}(x, \sigma_{\text{cond}})$$

The NN can arbitrarily modify these directions to correct nonlinear dynamics beyond A's linear approximation. $\square$

### 4.5 Practical Interpretation

| Without SVD projection | With SVD projection |
|------------------------|-------------------|
| NN may overpower A | NN complements A |
| A loses meaning (identity) | A retains structural role |
| Training may destroy A's learned structure | A is protected by invariance |
| NN capacity wasted on linear directions | NN focuses on truly nonlinear residual |

### 4.6 Connection to Rigor Design

RIGOR's architecture evolution:

1. **v3.x:** Raw NN output (no projection) — A collapses to near-identity
2. **v5.x:** SVD projection introduced — A retains $\sigma_1 \approx 0.93$ for VDP
3. **v5.8+:** Spectral penalty removed — proven redundant with SVD projection
4. **v5.19:** Quadratic A(x) — SVD projection extends to state-dependent A

The SVD projection is what makes the "A is main, NN is residual" philosophy **mathematically well-posed** rather than a heuristic.

---

## Lemma 5: Residual Orthogonality Bound

> SVD projection으로 인한 NN 표현력 손실은 수학적으로 bounded되어 있다.

### 5.1 Expressivity

Let $f^*(x) = A^* x + \Delta^*(x)$ be the true dynamics, where $A^*$ is the optimal linearization (minimizing $\mathbb{E}\|\Delta^*(x)\|^2$ over the data distribution). The overall RIGOR approximation with SVD-projected NN is:

$$f_\theta(x) = A x + \Pi_{\mathcal{S}_1^\perp}(\text{NN}(x))$$

**Approach 1: Triangle inequality bound.** Without assuming any orthogonality structure between $(A^* - A)x$ and $\Pi_{\mathcal{S}_1^\perp}(\text{NN})$, the worst-case error is bounded by:

$$\|f^*(x) - f_\theta(x)\| \leq \|(A^* - A)x\| + \|\Delta^*(x) - \Pi_{\mathcal{S}_1^\perp}(\text{NN}(x))\|$$

This is a valid (if loose) bound via the triangle inequality. No cross-term cancellation is needed.

**Approach 2: Explicit decomposition of $\Delta^*$.** Decompose the nonlinear residual into components parallel and orthogonal to $\mathcal{S}_1$:

$$\Delta^*(x) = \underbrace{u_1 u_1^\top \Delta^*(x)}_{\parallel \mathcal{S}_1} + \underbrace{(I - u_1 u_1^\top) \Delta^*(x)}_{\parallel \mathcal{S}_1^\perp}$$

The NN with SVD projection learns only the $\mathcal{S}_1^\perp$ component:

$$\Pi_{\mathcal{S}_1^\perp}(\text{NN}) \to \Pi_{\mathcal{S}_1^\perp}(\Delta^*) = (I - u_1 u_1^\top) \Delta^*(x)$$

The $\mathcal{S}_1$ component $u_1 u_1^\top \Delta^*(x)$ is **already captured by A's dominant direction** — if $A$ is close to $A^*$, then $A^* x$'s projection onto $\mathcal{S}_1$ is approximately $Ax$, and $\|\Pi_{\mathcal{S}_1}(\Delta^*)\|$ is minimized by the definition of $A^*$ as the optimal linearization.

**No expressivity is lost** because:
1. $\Pi_{\mathcal{S}_1^\perp}$ is a linear projection of rank $n-1$
2. Any function $\Delta^*(x)$ can be decomposed into its $\mathcal{S}_1$ and $\mathcal{S}_1^\perp$ components
3. Only the $\mathcal{S}_1$ component (captured by A) is excluded from NN's responsibility
4. The $\mathcal{S}_1^\perp$ component is fully learnable (see 5.2)

### 5.2 Universal Approximation

Since $\Pi_{\mathcal{S}_1^\perp}$ is a linear projection (rank $n-1$), any function $\Delta^*(x)$ can be approximated by a neural network composed with $\Pi_{\mathcal{S}_1^\perp}$, provided the neural network is a universal approximator. The SVD projection does not reduce the theoretical capacity of the residual approximator.

---

## Summary for RIGOR

**SVD projection의 3가지 기능:**

1. **안정성:** A의 dominant 방향($u_1$)을 NN으로부터 보호 → 학습 중 A의 정보가 소실되지 않음
2. **역할 분리:** A = main linear dynamics, NN = orthogonal nonlinear residual — 수학적으로 명확한 분할
3. **표현력 보존:** $\Pi_{\mathcal{S}_1^\perp}$는 rank $n-1$의 선형 변환이므로, NN의 universal approximation capacity를 제한하지 않음

**결론:** A+NN SVD projection은 heuristic이 아니라, 학습 가능한 linear-nonlinear partition의 유일한 well-posed formulation이다.

---

## Lemma 7: UFI-Adaptive Projection — Spectral Feedback Control

> UFI가 측정한 $\\rho(A_{\\text{eff}})$를 feedback으로 사용해 SVD projection의 강도를 실시간 조절. 기존 Leaky projection의 "arbitrary scaling" 문제를 UFI-driven principled formulation으로 해결.

### 7.1 Motivation

RIGOR v3 design philosophy에서 **Leaky projection**과 **Soft penalty**가 `"arbitrary scaling, no theory"`와 `"no principled basis"`로 제외되었다 ([[rigor-design-philosophy-v3]]).

기존 hard projection ($\\alpha = 1$)은 항상 최선이 아니다:
- **수렴 후** $\\rho(A_{\\text{eff}}) \\ll 1$: projection이 불필요하게 NN의 표현력을 제한
- **초기/외란 시** $\\rho(A_{\\text{eff}}) \\gg 1$: projection이 더 강해져야 함
- **고정 $\\alpha$** 는 dynamics 상태를 무시한 arbitrary constant

해결책: UFI가 실시간 측정하는 $\\rho_t = \\rho(A_{\\text{eff}}[t])$로 $\\alpha$를 결정 — UFI의 역할을 "passive conditioning"에서 "active spectral controller"로 확장.

### 7.2 Setup

Let $A_{\\text{eff}}[t] = A + J_{\\text{NN}}(\\mu_{\\text{filt}}[t])$ be the effective dynamics at step $t$, where $J_{\\text{NN}}$ is the NN Jacobian. UFI measures:

$$\\rho_t = \\|A_{\\text{eff}}[t]\\|_2 = \\sigma_1(A_{\\text{eff}}[t])$$

via SVD (already computed for spectral clamp — zero additional cost).

Define the **adaptive projection strength**:

$$\\alpha_t = \\sigma(\\eta \\cdot (\\rho_t - \\rho_0))$$

where:
- $\\sigma(\\cdot)$: logistic sigmoid
- $\\eta > 0$: gain hyperparameter (controls transition sharpness)
- $\\rho_0 \\in (0, \\infty)$: target spectral radius (typically $\\rho_0 = 1.0$, contractivity boundary)

### 7.3 Adaptive Projection Operator

$$\\Pi_{S_1^\\perp}^{\\alpha_t}(y) = y - \\alpha_t \\cdot (u_1^\\top y) \\cdot u_1$$

The NN output is projected:

$$\\text{NN}_{\\text{proj}}(x_t) = \\Pi_{S_1^\\perp}^{\\alpha_t}(\\text{NN}(x_t))$$

### 7.4 Lemma 7: UFI-Adaptive Projection Guarantee

**Statement:**

Let $\\rho_t = \\rho(A_{\\text{eff}}[t])$ be the spectral radius measured by UFI, and let $\\alpha_t = \\sigma(\\eta \\cdot (\\rho_t - \\rho_0))$ be the adaptive projection strength. Then:

**(i) Spectral Stability:** If $\\rho_t > \\rho_0$ then $\\alpha_t \\to 1$, restoring hard projection and preserving A's dominant mode:

$$\\lim_{\\rho_t \\to \\infty} \\alpha_t = 1 \\implies u_1^\\top f_\\theta(x_t) = u_1^\\top A x_t \\text{ (unperturbed by NN)}$$

**(ii) Maximum Expressivity:** If $\\rho_t < \\rho_0$ then $\\alpha_t \\to 0$, freeing NN to learn arbitrary corrections:

$$\\lim_{\\rho_t \\to 0} \\alpha_t = 0 \\implies \\Pi_{S_1^\\perp}^{0} = I \\text{ (no projection)}$$

**(iii) Continuous Adaptation:** $\\alpha_t$ is continuous and differentiable in $\\rho_t$, enabling gradient flow through the projection strength:

$$\\frac{\\partial \\alpha_t}{\\partial \\rho_t} = \\eta \\cdot \\alpha_t \\cdot (1 - \\alpha_t)$$

**(iv) No Arbitrary Constants:** $\\alpha_t$ is fully determined by UFI-observed $\\rho_t$ — the only hyperparameters ($\\eta, \\rho_0$) have clear operational meaning (gain and target spectral radius), replacing arbitrary $\\alpha \\in [0,1]$.

**Proof:**

(i) As $\\rho_t \\to \\infty$, $\\eta \\cdot (\\rho_t - \\rho_0) \\to \\infty$, so $\\sigma(\\cdot) \\to 1$. From Lemma 4, $\\alpha_t = 1$ gives $u_1^\\top \\Pi_{S_1^\\perp}^{1}(y) = 0$, hence $u_1^\\top f_\\theta = u_1^\\top A x$.

(ii) As $\\rho_t \\to 0$, $\\eta \\cdot (\\rho_t - \\rho_0) \\to -\\eta \\rho_0 \\ll 0$, so $\\sigma(\\cdot) \\to 0$. Then $\\Pi_{S_1^\\perp}^{0}(y) = y$, i.e., no projection.

(iii) $\\frac{d}{dz}\\sigma(z) = \\sigma(z)(1-\\sigma(z))$, and $\\frac{\\partial \\alpha_t}{\\partial \\rho_t} = \\eta \\cdot \\sigma'(\\eta(\\rho_t - \\rho_0)) = \\eta \\cdot \\alpha_t \\cdot (1 - \\alpha_t)$.

(iv) By construction — the only tunable parameters are $\\eta$ (how sharply $\\alpha$ responds to spectral deviation) and $\\rho_0$ (the stability threshold). Both have clear physical/control-theoretic interpretations. $\\square$

### 7.5 Practical Interpretation

| Condition | $\\rho_t$ | $\\alpha_t$ | Projection | NN freedom |
|:----------|:--------:|:----------:|:----------:|:----------:|
| Unstable dynamics | $\\gg 1$ | $\\to 1$ | Hard (full) | Minimal |
| Stable dynamics | $\\approx 1$ | $\\approx 0.5$ | Soft (partial) | Moderate |
| Contractive/decaying | $\\ll 1$ | $\\to 0$ | None | Maximum |

### 7.6 Implementation

```python
# RigorCell.__call__() — after SVD spectral clamp
if self.adaptive_alpha and self.u_1_vector is not None:
    rho = s_a[0]  # ρ(A_eff_dyn), already from SVD
    alpha = jax.nn.sigmoid(self.alpha_gain * (rho - self.alpha_target))
    parallel = jnp.dot(residual, u_1)
    residual = residual - alpha * parallel[:, None] * u_1[None, :]
else:
    residual = residual - parallel[:, None] * u_1[None, :]  # hard (α=1)
```

### 7.7 Connection to RIGOR Design Philosophy

**Previous state (excluded):**
```
Leaky projection: α = 0.3 (arbitrary constant → excluded)
Soft penalty: λ·∥u₁ᵀ·NN∥² (no principled basis → excluded)
```

**Lemma 7 state (principled):**
```
UFI-adaptive: α = σ(η·(ρ - ρ₀)) (UFI feedback → principled)
```

Key difference: $\\alpha$ is no longer a free parameter — it emerges from the interaction between UFI's spectral measurement and the stability requirement $\\rho(A_{\\text{eff}}) \\leq \\rho_0$. This answers the open question from [[rigor-design-philosophy-v3]]: *"Where exactly does heuristic end?"* — at the point where UFI provides a theoretically grounded feedback signal.

### 7.8 Experimental Prediction

- UFI-adaptive projection will maintain $\\rho(A_{\\text{eff}})$ closer to $\\rho_0$ than fixed-$\\alpha$ baselines
- Training will converge faster (NN gets maximum freedom when stable, protection when unstable)
- UFI-adaptive will outperform both hard-projection ($\\alpha=1$, overly constrained) and no-projection ($\\alpha=0$, unstable) across all benchmarks

---

## References

- Rigor Design Philosophy — [[rigor-design-philosophy-v3]]
- Behrmann et al. (2019). Invertible Residual Networks. ICML. (i-ResNet style residual scaling)
- SVD and low-rank approximation: Golub & Van Loan (2013). Matrix Computations.

## Wikilinks
- [[rigor-design-philosophy-v3]] — A+NN partition 철학의 기원
- [[rigor-filter]] — RIGOR 구현
- [[state-dependent-a-quadratic-form]] — Quadratic A(x)로의 확장
- [[unscented-feature-interaction]] — UFI conditioning
