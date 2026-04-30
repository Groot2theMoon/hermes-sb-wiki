---
title: EM-Kalman Smoother — Analytical Noise Covariance Update (Shumway-Stoffer)
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [kalman-filter, expectation-maximization, system-identification, noise-covariance, state-space-model, foundational]
sources: [raw/papers/shumway-stoffer-1982-em-smoother.md]
confidence: high
---

# EM-Kalman Smoother — Analytical Noise Covariance Estimation

## 개요

**Shumway & Stoffer (1982)** 가 제안한, RTS (Rauch-Tung-Striebel) smoother의 출력에서 **process noise covariance Q와 measurement noise covariance R을 분석적으로(analytically) 계산**하는 Expectation-Maximization (EM) 알고리즘. Linear Gaussian State-Space Model (LG-SSM)의 MLE 추정에서 표준 방법으로 자리잡음.

> Shumway, R.H. & Stoffer, D.S. (1982). An approach to time series smoothing and forecasting using the EM algorithm. *Journal of Time Series Analysis*, 3(4), 253-264.

> Dempster, A.P., Laird, N.M. & Rubin, D.B. (1977). Maximum likelihood from incomplete data via the EM algorithm. *Journal of the Royal Statistical Society: Series B*, 39(1), 1-22.

## 수학적 유도

### Linear Gaussian SSM

$$x_{t+1} = A x_t + w_t, \quad w_t \sim \mathcal{N}(0, Q)$$
$$y_t = C x_t + v_t, \quad v_t \sim \mathcal{N}(0, R)$$

### EM Framework (Dempster 1977)

EM은 **observed data likelihood** $p(y_{1:T} | \theta)$를 직접 최대화하는 대신, **latent state의 posterior**를 활용하는 surrogate function을 최대화:

$$
\theta_{k+1} = \arg\max_\theta \mathbb{E}_{x_{1:T} | y_{1:T}, \theta_k} \left[ \log p(x_{1:T}, y_{1:T} | \theta) \right]
$$

### E-step (via RTS Smoother)

RTS smoother로 smoothed state $\hat{x}_{t|T}$와 smoothed covariance $P_{t|T}$, 그리고 cross-covariance $P_{t,t-1|T}$를 계산.

※ **선형 가우시안에서 E-step은 RTS smoother가 정확한 posterior를 제공.**

### M-step (Analytical Q, R Update)

Q의 MLE는:

$$Q = \frac{1}{T-1} \sum_{t=2}^T \mathbb{E}\left[ (x_t - A x_{t-1})(x_t - A x_{t-1})^\top \;\middle|\; y_{1:T} \right]$$

RTS smoother의 출력으로 **closed-form**:

$$
Q = \frac{1}{T-1} \sum_{t=2}^T \Big( P_{t|T} + (\hat{x}_{t|T} - A \hat{x}_{t-1|T})(\hat{x}_{t|T} - A \hat{x}_{t-1|T})^\top - A P_{t-1|T} A^\top \Big)
$$

유사하게 R도:
$$
R = \frac{1}{T} \sum_{t=1}^T \Big( C P_{t|T} C^\top + (y_t - C \hat{x}_{t|T})(y_t - C \hat{x}_{t|T})^\top \Big)
$$

## 왜 이것이 "더 엄밀한" 해법인가?

## RIGOR Novelty Gap Matrix

| Paper | Noise update | Dynamics | Filter | Smoother? | AD? | Domain | Gap? |
|-------|-------------|----------|--------|-----------|-----|--------|------|
| **Shumway-Stoffer (1982)** | EM analytical | Linear (fixed) | KF | ✅ | ❌ | Time series | ✅ |
| **[[kalmannet|KalmanNet]] (2022)** | EM (baseline) | Fixed (known) | KF | ❌ | ✅ | General | ✅ |
|| **RIGOR** | **EM analytical** | **A+NN hybrid** | **SR-UKF** | **✅ RTS** | **✅ JAX** | **Chaotic system ID** | — |

### Q의 Self-Calibrating 속성

EM에서 Q는 **"모델이 예측을 얼마나 틀렸는지"** 의 척도:

```
Q가 작다  ↔ A+NN이 dynamics를 잘 학습했다
Q가 크다  ↔ A+NN이 아직 덜 학습되었다 → 더 큰 gradient signal
```

즉 Q가 dynamics 학습의 진척도를 **self-calibrating**합니다. VFE anchor가 의도적으로 Q를 억제하는 반면, EM update는 Q를 **데이터가 말하는 대로** 놔두면서 dynamics 학습을 집중 최적화합니다.

## RIGOR에서의 확장

### Nonlinear Extension (via SR-UKF + Smoother)

Shumway-Stoffer는 **linear KF + RTS**만 지원. RIGOR는 **SR-UKF + RTS smoother**로 nonlinear 시스템으로 확장:

```
기존 (LG-SSM):     E-step = KF + RTS (exact)
                   M-step = analytical Q,R (closed-form)

RIGOR (nonlinear): E-step = SR-UKF + RTS (3차 정확도)
                   M-step = analytical Q,R (residual covariance)
                   M-step2 = gradient A+NN (learned dynamics)
```

### Momentum EM (Practical Implementation)

Q가 갑자기 변하면 filter 발산 위험 → EMA interpolation:

```python
Q_analytical = compute_from_smoother(mu_smooth, L_smooth, A)
Q = (1 - tau) * Q + tau * Q_analytical  # tau = 0.01 ~ 0.1
```

### A+NN 구조에서의 Q 계산

```python
# RIGOR의 A+NN dynamics:
# x_{t+1} = A @ x_t + NN_theta(x_t) + w_t

# Smoother 출력: mu_smooth, L_smooth
residual = mu_smooth[:, 1:] - (mu_smooth[:, :-1] @ A.T) - NN(mu_smooth[:, :-1])

# Analytical Q (covariance correction 포함)
Q_new = jnp.mean(residual.transpose(0,2,1) @ residual, axis=0)
Q_new += correction_for_smoother_uncertainty(...)  # P_{t|T} 관련 항
```

## 관련 연구

| 논문 | 연결점 |
|------|--------|
| **Shumway & Stoffer (1982)** — EM + RTS smoother | **이론적 기초. 40년 이상 검증된 표준** |
|| **[[kalmannet|KalmanNet]] ([[guy-revach|Revach]] 2022)** — Shumway-Stoffer 인용 | Neural filter도 EM 기반 Q,R을 표준으로 사용 |
|| **[[esn-as-ssm|ESN as SSM]] (2025)** — EM for noise cov. + neural readout | **Neural + EM 조합의 선행 검증** |
|| **[[adaptive-online-smoother|Adaptive Online Smoother]] (2024)** — Online EM for noise | EM을 online 확장 |
|| **[[rtsnet|RTSNet]] ([[guy-revach|Revach]] 2023)** — Neural RTS smoother | Smoother 학습의 대안적 접근 |
| **Győrök (2025)** — Orthogonal projection for A+NN | **직교화 + EM의 결합으로 identifiability 완벽 해결** |

## References

- Dempster, A.P. et al. (1977). Maximum likelihood from incomplete data via the EM algorithm. *JRSS-B*.
- Shumway, R.H. & Stoffer, D.S. (1982). An approach to time series smoothing and forecasting using the EM algorithm. *JTSA*.
- Shumway, R.H. & Stoffer, D.S. (2017). *Time Series Analysis and Its Applications: With R Examples* (4th ed.). Springer. — **교과서. EM-KF 전체 구현 포함**
- [[square-root-unscented-kalman-filter]] — SR-UKF 기반
- [[differentiable-filter-kloss]] — Differentiable Filter (Kloss 2021)
- [[pinn-ukf]] — PINN+UKF (대안)
- [[ma-ukf-meta-adaptive]] — MA-UKF (대안)
- [[orthogonal-projection-regularization]] — Identifiability 해결
