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

Let $f^*(x) = A^* x + \Delta^*(x)$ be the true dynamics, where $A^*$ is the optimal linearization (minimizing $\mathbb{E}\|\Delta^*(x)\|^2$ over the data distribution). Then:

$$\|f^*(x) - (A x + \Pi_{\mathcal{S}_1^\perp}(\text{NN}(x)))\|^2 = \|(A^* - A)x\|^2 + \|\Delta^*(x) - \Pi_{\mathcal{S}_1^\perp}(\text{NN}(x))\|^2$$

The cross-term vanishes because $(A^* - A)x$ lies primarily in $\mathcal{S}_1$ (by definition of SVD) while $\Pi_{\mathcal{S}_1^\perp}(\text{NN}) \in \mathcal{S}_1^\perp$.

**Implication:** A learns the optimal linearization $A^*$ via gradient descent. NN learns $\Pi_{\mathcal{S}_1^\perp}(\Delta^*)$, the nonlinear residual projected onto the orthogonal complement. **No expressivity is lost** — any $\Delta^*(x)$ can be decomposed into its $\mathcal{S}_1$ and $\mathcal{S}_1^\perp$ components, and only the $\mathcal{S}_1$ component (which A can already capture) is removed from NN's responsibility.

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

## References

- Rigor Design Philosophy — [[rigor-design-philosophy-v3]]
- Behrmann et al. (2019). Invertible Residual Networks. ICML. (i-ResNet style residual scaling)
- SVD and low-rank approximation: Golub & Van Loan (2013). Matrix Computations.

## Wikilinks
- [[rigor-design-philosophy-v3]] — A+NN partition 철학의 기원
- [[rigor-filter]] — RIGOR 구현
- [[state-dependent-a-quadratic-form]] — Quadratic A(x)로의 확장
- [[unscented-feature-interaction]] — UFI conditioning
