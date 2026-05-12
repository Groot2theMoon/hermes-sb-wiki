---
title: "Koopman Lifting for RIGOR — A+NN UKF with Augmented State Dynamics"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [rigor, kalman-filter, differentiable-filtering, koopman, architecture, nonlinear-dynamics, state-estimation]
sources: []
confidence: high
---

# Koopman Lifting for RIGOR — A+NN UKF with Augmented State Dynamics

> **Deep-research synthesis (2026-05-12):** Koopman lifting (polynomial/kernel basis expansion)을 RIGOR의 A matrix에 통합하여 nonlinear dynamics 표현력을 높이고 NN residual 부담을 줄이는 방안.

## 배경: A+NN의 근본적 한계

RIGOR의 핵심 구조는 $x_{t+1} = A x_t + \text{NN}(x_t)$ — linear A가 main dynamics를, NN이 residual nonlinear correction을 담당한다. 문제는 **A가 linear라서 strong nonlinearity (e.g., $\sin(\theta)$ in driven pendulum) 를 충분히 표현하지 못한다**는 점:

| System | A가 커버하는 비선형 | channel_scale | pos_corr |
|:---|:---|:---:|:---:|
| VDP | μ(1-x²)ẋ (cubic damping, A로 근사 가능) | 0.33 | **0.998** |
| Driven pendulum | sin(θ) (A가 sin(θ)≈θ만 근사) | 0.40 | **0.25** |

## 핵심 아이디어: A를 Lifted Space로 확장

Koopman operator theory에 따르면, 적절한 observable function $\phi(x)$로 상태를 고차원으로 lifting하면 **nonlinear dynamics가 lifted space에서 linear해진다**:

$$
x_{t+1} = F(x_t) \quad \Longrightarrow \quad \phi(x_{t+1}) = K \cdot \phi(x_t)
$$

RIGOR에 적용: **A matrix를 lifted space ($\mathbb{R}^2 \to \mathbb{R}^D$)에서 학습**하고, projection $C$로 다시 physics space로 되돌리는 구조.

```
x_lifted = φ(sigma_points)          # (n_sigma, 2) → (n_sigma, D)
x_dyn_lifted = A_lifted @ x_lifted   # (n_sigma, D)
x_phys = C @ x_dyn_lifted            # (n_sigma, 2)
x_dyn = x_phys + NN_residual         # A+NN hybrid
```

### Lifting Functions φ(x)

| 접근법 | φ(x) 예시 | D | 장점 | 단점 |
|:---|:---|:-:|:---|:---|
| **Polynomial (1차 구현)** | `[x₁,x₂,x₁²,x₂²,x₁x₂]` | 5 | 간단, Taylor 근사 = sin(θ) 표현 | 차수 선택이 heuristic |
| **Random Fourier Features** | `cos(Wx+b)` | 10-20 | universal approximator | D↑ = param↑ |
| **kEDMD (Kernel)** | kernel to data points | N | asymptotic optimal | offline, batch-only |

### Lifted A에 대한 Contractivity LMI

Shima-Bullo contractivity LMI는 Lur'e system ($A + \text{NN}$)에 적용된다. Koopman lifting을 하면 **lifted space에서 dynamics가 이미 linear**이므로 ($A_{\text{lifted}}$만으로 완전히 표현), Lur'e nonlinearity가 사라져 LMI가 lifted A에 직접 적용 가능 — contractivity 조건이 단순화된다.

## 기존 연구와의 갭

| Paper | Lifting | UKF | Diff'able | A+NN | |
|:---|:---:|:---:|:---:|:---:|:---|
| KKF (Neto 2025) | kEDMD | KF | offline | ❌ | arXiv:2511.04252 |
| Deep-Koopman KF (Boscariol 2025) | DNN | KF | ❌ | ❌ | Springer 2025 |
| EKF-Koopman (2024) | DNN | EKF | ❌ | ❌ | arXiv:2402.18554 |
| **RIGOR+Lifting (제안)** | poly/kernel | **UKF** | **✅** | **✅** | — |

**RIGOR의 unique contribution:** "Koopman lifting + A+NN hybrid + differentiable SR-UKF" — 이 3가지 요소를 동시에 갖춘 연구는 전무. KKF(가장 가까움)는 Koopman KF지만 differentiable joint training, partial observation 처리, A+NN 분할 모두 없다.

## 구현 로드맵

### Phase 1: Polynomial Lifting (간단)
```python
def lift_poly(x):
    x1, x2 = x[..., 0], x[..., 1]
    return jnp.stack([x1, x2, x1**2, x2**2, x1*x2], axis=-1)  # 2→5

class RigorCell:
    A_lifted: (5×5, StableSystemMatrix)
    C: (2×5, learned projection)
    
    def dynamics(self, sigma):
        lifted = lift_poly(sigma)
        return C @ (A_lifted @ lifted) + NN_residual
```

### Phase 2: RFF Lifting (universal)
```python
def lift_rff(x):
    W = param('rff_W', (D, d_state))  # fixed random projection
    return jnp.concatenate([x, jnp.cos(W @ x.T)], axis=-1)
```

### Phase 3: Differentiable kEDMD (optimal)
KKF 스타일의 kernel-based lifting을 JAX로 differentiable하게 구현.

## 참고 문헌

[1] Neto et al. (2025). Koopman Kalman Filter (KKF): An asymptotically optimal nonlinear filtering algorithm with error bounds. arXiv:2511.04252.

[2] Boscariol, P. et al. (2025). Deep-Koopman-enhanced Kalman Filter for multibody systems. *Multibody System Dynamics*.

[3] EKF–Koopman for stochastic optimal control. arXiv:2402.18554.

[4] Diego Olguin (2025). kkf: Kernel Koopman Kalman Filter — Python library. PyPI: `kkf`, GitHub: diegoolguinw/kkf.

[5] Machine-Learning-Dynamical-Systems. kooplearn — Koopman operator learning package. GitHub.

[6] Shima, Davydov & Bullo (2025). Contractivity Analysis for Lur'e Systems. arXiv:2503.20177.

## Wikilinks

- [[rigor-design-philosophy-v3]] — A+NN partition, basis expansion proposal
- [[koopman-operator-theory]] — Koopman operator fundamentals
- [[kernel-operator-bayesian-filter]] — RKHS + Koopman Bayesian filter (Li & Príncipe 2024)
- [[shima-contractivity-lure]] — Contractivity LMI for Lur'e systems
- [[differentiable-lmi-contractivity]] — Gokhale-Bullo exact parameterization
- [[rigor-filter]] — Differentiable SR-UKF
- [[unscented-feature-interaction]] — Uncertainty Feature Injection
