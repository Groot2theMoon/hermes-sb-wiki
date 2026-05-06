---
title: "Robust Sigma Point Kalman Filter — Dynamic Minimax Game for Nonlinear State Estimation"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [ukf, sigma-point, robust-filtering, minimax, nonlinear-state-estimation, mcmc]
sources:
  - raw/papers/robust-sigma-point-kf-yi25.md
confidence: high
---

# Robust Sigma Point Kalman Filter

**arXiv:** [2506.04815](https://arxiv.org/abs/2506.04815)
**Authors:** [[shenglun-yi|Shenglun Yi]], [[mattia-zorzi|Mattia Zorzi]] (University of Padova)
**Year:** 2025

## 개요

Yi & Zorzi가 제안한 **robust nonlinear state estimation** 방법론. 기존 sigma point Kalman filter (UKF, CKF, GHQF)를 **dynamic minimax game** 프레임워크로 확장하여 model uncertainty 하에서도 강건한 추정을 가능하게 함. 핵심은 ambiguity set의 중심을 sigma point 근사로 특성화하고, least favorable model을 MCMC 시뮬레이터로 생성하는 것.

## 문제 정의

표준 sigma point Kalman filter (UKF, CKF 등)는 model uncertainty 존재 시 성능이 급격히 저하됨. 기존 robust sigma point 필터는 주로 outlier 처리에 초점([7],[8]). 그러나 model uncertainty는 **imprecise model parameters, non-standard noise, sensor drift** 등 다양한 원인에서 발생.

### Nominal Model

$$
x_{t+1} = f(x_t) + B v_t, \quad y_t = h(x_t) + D v_t
$$

여기서 $v_t$는 white Gaussian noise, $f, h$는 bounded nonlinear functions.

## 접근법: Dynamic Minimax Game

### Two Players
- **Player 1 (Estimator):** 상태 추정 오차의 분산 최소화
- **Player 2 (Nature):** Ambiguity set 내에서 least favorable model 선택

### Ambiguity Set

Conditional KL divergence로 정의:
$$
\mathcal{B}_t = \{\tilde{\phi}_t : D(\tilde{\phi}_t \| \phi_t) \leq c_t\}
$$

여기서 $\phi_t$는 nominal conditional density, $c_t$는 tolerance 파라미터.

### 핵심 기여 1: Sigma Point Ambiguity Set Center 근사

Sigma point Kalman filter가 유도하는 **approximate conditional density** $\bar{p}_t(z_t|Y_{t-1})$를 Proposition 1에서 특성화. 이 근사밀도를 ambiguity set의 중심으로 사용하면 **closed-form robust estimator** 유도 가능.

**Theorem 1** 결과: Robust estimator는 다음 형태를 가짐:
$$
\hat{x}_{t+1} = \sum W^i_m \hat{X}^i_{t+1|t}
$$

where $\tilde{P}_{t+1} = (P_{t+1}^{-1} - \theta_t I)^{-1}$ with risk sensitivity parameter $\theta_t > 0$.

### Prediction Resilient vs Update Resilient

| 필터 유형 | Uncertainty 범위 | Minimizer |
|-----------|-----------------|-----------|
| **Prediction Resilient (P-UKF)** | State + Measurement equations | One-step ahead predictor $x_{t+1}\|Y_t$ |
| **Update Resilient (U-UKF)** | Measurement equations only | A posteriori estimator $x_t\|Y_t$ |

### 핵심 기여 2: MCMC Simulator for Least Favorable Model

Least favorable model $\tilde{p}^0(Z_N)$은 일반적으로 **non-Gaussian, nonlinear**. 따라서:
1. Prediction resilient filter로 $\hat{x}_t, \theta_t$ 계산
2. Nominal model을 필터 추정 경로에서 Jacobian 선형화
3. 선형화된 모델의 least favorable model (Gaussian)을 **proposal density**로 사용
4. **Metropolis-Hastings algorithm**으로 target density $\tilde{p}^0(Z_N)$ 샘플링

## RIGOR 프로젝트와의 연결

이 논문의 **ambiguity set interpretation**은 [[rigor-filter|RIGOR Filter]]의 **differentiable sigma point spread**에 이론적 토대를 제공:
- Sigma point spread parameter $\alpha$를 **ambiguity set의 radius**로 해석 가능
- Robustness와 spread 간의 trade-off를 minimax game으로 정식화 가능
- Risk sensitivity parameter $\theta_t$와 spread 간의 연관성

## Wikilinks
- [[rigor-filter|RIGOR Filter]] — Differentiable SR-UKF with LMI contractivity
- [[kalmannet]] — Neural network aided Kalman filtering
- [[ukf-learning-sigma-points]] — Model-based learning of sigma points (Turner & Rasmussen)
- [[ma-ukf-meta-adaptive]] — Meta-adaptive UKF (Majewski 2026)
- [[differentiable-sigma-point-quadrature]] — Differentiable sigma point methods
- [[unscented-feature-interaction]] — Sigma point feature engineering
- [[auto-diff-data-assimilation]] — Auto-differentiable data assimilation

## References
- Yi, S. & Zorzi, M. (2025). A robust approach to sigma point Kalman filtering. arXiv:2506.04815.
- Levy, B. & Nikoukhah, R. (2013). Robust state-space filtering under incremental model perturbations subject to a relative entropy tolerance. *IEEE TAC*, 58, 682–695.
- Zorzi, M. (2016). Robust Kalman filtering under model perturbations. *IEEE TAC*, 62(6), 2902–2907.
