---
title: "Miao Robust Observer — Learning Robust KKL Observers via Neural ODEs"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [state-observer, neural-ode, robust-estimation, kkl-observer, luenberger-observer]
sources: [raw/papers/miao23a.md]
confidence: high
---

# Miao Robust Observer — Learning Robust KKL Observers via Neural ODEs

## 개요

**Miao & Gatsis (University of Oxford, 2023)**는 Neural ODEs를 활용하여 비선형 시스템을 위한 **상태 관측기(state observer)**를 학습하는 프레임워크를 제안했다. 기존 Luenberger observer와 KKL (Kazantzis-Kravaris-Luenberger) observer를 Neural ODE 구조로 구현하고, 특히 **KKL observer의 eigenvalues와 convergence speed / robustness 간의 trade-off**를 이론적으로 분석하고 이를 training에 활용하는 방법을 개발했다.

이 연구는 [[rigor-filter|RIGOR Filter]]와 동일한 문제 설정(학습 기반 상태 추정)에서 출발하며, [[buisson-fenet-kkl-observer]]와 함께 KKL observer의 robustness 분석을 다루는 핵심 참고 자료이다.

> Miao, K., & Gatsis, K. (2023). Learning Robust State Observers using Neural ODEs. *arXiv preprint arXiv:2212.00866*.

## 핵심 아이디어

### Neural ODE 기반 Observer 프레임워크

일반적인 비선형 시스템 $$\dot{x}(t) = f(x(t)),\; y(t) = h(x(t))$$에 대해, observer는 다음 형태를 가진다:

$$
\dot{z}(t) = \mathcal{F}(z(t), y(t), \theta), \quad \hat{x}(t) = \mathcal{G}(z(t), \eta)
$$

여기서 $\mathcal{F}$는 ODENet (Neural ODE로 표현된 dynamics), $\mathcal{G}$는 출력 신경망. 학습은 **Lagrange optimal control problem**으로 정식화되며, loss는 trajectory 전반에 걸친 estimation error의 적분:

$$
\ell := \int_{t_0}^{t_f} |x(t) - \hat{x}(t)|^2 dt
$$

Gradient는 adjoint sensitivity analysis로 계산된다.

### Luenberger-like Observer (Section 4.1)

시스템의 **선형 부분 $(A, C)$를 알고 있을 때** 적합. 알려진 선형 구조는 보존하고, 미지의 비선형 항만 신경망 $\hat{g}(\hat{x}, \theta)$로 학습:

$$
\dot{\hat{x}}(t) = A\hat{x}(t) + \hat{g}(\hat{x}(t), \theta) + G(y(t) - \hat{y}(t)), \quad \hat{y}(t) = C\hat{x}(t)
$$

$G$는 $A-GC$가 Hurwitz가 되도록 선택.

### KKL Observer (Section 4.2)

시스템의 **비선형 동역학이 완전히 미지인 경우**에 적용. KKL observer는 비선형 시스템을 고차원 선형 latent dynamics로 immersion한 후 mapping $\mathcal{T}^*$로 state estimate를 복원한다:

$$
\dot{z}(t) = D z(t) + F y(t), \quad \hat{x}(t) = \hat{\mathcal{T}}^*(z(t), \eta)
$$

Neural ODE 접근의 핵심 장점: **$D$ 행렬 (eigenvalues)과 mapping $\mathcal{T}^*$를 동시에 학습**할 수 있다. 이는 $D$를 pre-specify해야 했던 [[buisson-fenet-kkl-observer]]나 Ramos et al. (2020)의 접근과 차별화된다.

### Convergence-Robustness Trade-off (Proposition 4)

**핵심 이론적 기여**: $D$ 행렬의 eigenvalues를 scaling factor $k$로 키울수록 convergence는 빨라지지만, model uncertainty와 measurement noise에 대한 robustness는 **감소**한다.

$$
|x(t) - \tilde{x}(t)| \leq k^{n_z} \sqrt{n_x} L_{\mathcal{T}} \exp(k \lambda_{\max} t) |z(0) - \mathcal{T}_k(x(0))| + \frac{k^{n_z} \sqrt{n_x} L_{\mathcal{T}}}{|k \lambda_{\max}|} \left( \frac{L_{\mathcal{T}_k}}{k} \bar{w} + \bar{v} \right)
$$

- 첫 번째 항: convergence speed (k 증가 → faster decay)
- 두 번째 항: steady-state noise bound (k 증가 → larger bound)
- 즉, **fast poles = fast convergence but noise-sensitive**

### Robustness 향상을 위한 Training 방법 (Section 4.2.2)

Proposition 4의 분석을 바탕으로 두 가지 방법 제안:

1. **Training data에 noise 추가** — measurement noise에 대한 robustness 향상
2. **Regularization on $D$ eigenvalues** — loss에 $\gamma \int |\theta(t)|^2 dt$ 항을 추가하여 eigenvalues의 크기 제어

## 실험 결과

### Van der Pol Oscillator

| Test Scenario | Fixed $D$ (Ramos) | Learned NODE (Gaussian noise) | Learned NODE (Regularization) |
|---|---|---|---|
| No Noise | 0.0548 | 0.0603 | 0.0712 |
| Gaussian Noise $\mathcal{N}(0,0.5)$ | 0.1160 | **0.0667** | 0.0863 |
| Uniform Noise $\mathcal{U}(-3,3)$ | 0.3205 | **0.1111** | 0.1462 |

- Fixed $D$ with large eigenvalues ($\{-5,-6,-7\}$): 빠른 convergence but noise에 취약
- Fixed $D$ with small eigenvalues ($\{-0.1,-0.2,-0.3\}$): noise에 강하지만 convergence 느림
- **Neural ODE (learned $D$)**: convergence speed와 robustness 모두에서 우수

### Reverse Duffing Oscillator

Training domain의 중요성 입증: 좁은 domain ($[-1,1]^2$)에서 학습한 observer는 domain 외부에서 일반화 불가. 넓은 domain ($[-3,3]^2$)에서 학습 시 RMSE 대폭 감소.

## RIGOR Relevance

| Aspect | Miao & Gatsis (2023) | RIGOR Filter |
|---|---|---|
| Task | Neural ODE state observer | Differentiable SR-UKF |
| Dynamics | Fully learned / partially known | A+NN hybrid (physics-informed) |
| Robustness | D-eigenvalue regularization | Lur'e contractivity LMI |
| Training | Adjoint sensitivity | End-to-end differentiable |
| Noise model | Learned (via training noise) | EM-based learned Q, R |

직접적으로 관련된 competitor이자 RIGOR의 **baseline/comparison 대상**. 특히 KKL observer의 robustness-eigenvalue 관계는 RIGOR의 contractivity-based robustness와 비교될 수 있다.

## 관련 개념

- [[rigor-filter]] — Differentiable SR-UKF (learning-based observer, 직접적 competitor)
- [[neural-odes]] — Neural ODE 기본 개념
- [[buisson-fenet-kkl-observer]] — KKL observer gain tuning (가장 유사한 prior work)
- [[state-space-model]] — SSM 프레임워크
- [[universal-differential-equations]] — UDE: hybrid physics+NN dynamics modeling
- [[differentiable-filter-kloss]] — Differentiable UKF (Kloss 2021)
- [[deep-kalman-filter]] — Variational inference 기반 learning-based filter

## References

- Miao, K., & Gatsis, K. (2023). Learning Robust State Observers using Neural ODEs. arXiv:2212.00866.
- Chen et al. (2018). Neural Ordinary Differential Equations. NeurIPS 2018.
- Kazantzis & Kravaris (1998). Nonlinear observer design using Lyapunov's auxiliary theorem.
- Andrieu & Praly (2006). On the existence of a Kazantzis-Kravaris/Luenberger observer.
- Buisson-Fenet et al. (2022). Towards gain tuning for numerical KKL observers.
- Ramos et al. (2020). Numerical design of Luenberger observers for nonlinear systems.
