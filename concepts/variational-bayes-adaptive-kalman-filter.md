---
title: "Variational Bayes Adaptive Kalman Filter — VB 기반 Noise Covariance Adaptation"
created: 2026-05-12
updated: 2026-05-12
sources: [raw/papers/adaptive-noise-kf-akhlaghi17.md]
type: concept
tags: [kalman-filter, adaptive-filtering, variational-bayes, noise-covariance-estimation]
confidence: high
sources:
  - /home/aero_groot/agent-workspace/wiki/raw/papers/vb-adaptive-kf-sarkka13.md
  - /home/aero_groot/agent-workspace/wiki/raw/papers/vb-adaptive-kf-huang18.md
  - /home/aero_groot/agent-workspace/wiki/raw/papers/variational-filtering-correlated-noise-srinivasan26.md
  - /home/aero_groot/agent-workspace/wiki/raw/papers/adaptive-noise-kf-akhlaghi17.md
  - /home/aero_groot/agent-workspace/wiki/raw/papers/variational-robust-kalman-li26.md
---

# Variational Bayes Adaptive Kalman Filter (VBAKF)

## 개요

**Variational Bayes Adaptive Kalman Filter (VBAKF)** 는 Kalman Filter가 가진 근본적인 한계 — **사전에 알고 있는 noise covariance (Q, R)에 대한 의존성** — 을 Variational Bayesian (VB) 추론을 통해 극복하는 adaptive filtering 방법론의 한 계열이다. 표준 Kalman Filter는 process noise covariance **Q**와 measurement noise covariance **R**이 정확히 알려져 있다고 가정하지만, 실제 응용에서는 이 값들이 **unknown**, **time-varying**, 또는 **outlier에 오염된** 경우가 대부분이다.

VBAKF의 핵심 아이디어는 **상태(state)와 noise covariance를 동시에 추론(joint inference)** 하는 것이다. 구체적으로, filtering posterior distribution을 **factorized form**으로 근사한다:

\[
p(x_k, \Sigma_k \mid y_{1:k}) \approx Q_x(x_k) \, Q_\Sigma(\Sigma_k)
\]

여기서 **Q_x(x_k)** 는 Gaussian, **Q_Σ(Σ_k)** 는 inverse Wishart (또는 inverse Gamma) 분포로 가정하고, Kullback-Leibler divergence를 최소화하는 fixed-point iteration을 통해 두 분포의 파라미터를 **coupled**하게 업데이트한다.

이 방법은 단순히 Q와 R을 적응적으로 추정하는 것을 넘어, **robustness** (outlier 대응)와 **adaptivity** (time-varying noise 대응)라는 두 경쟁적 목표를 하나의 통합 프레임워크에서 해결하는 방향으로 발전해왔다.

## Variational Bayes for Noise Covariance

### Inverse Wishart Prior

VB 접근법에서 noise covariance **Σ_k**에 대한 conjugate prior로 **inverse Wishart (IW) distribution**을 사용한다:

\[
\Sigma_k \sim \text{IW}(\Sigma_k \mid \nu_k, V_k)
\]

여기서 **ν_k**는 degrees of freedom 파라미터, **V_k**는 inverse scale matrix이다. IW 분포는 Gaussian 분포의 공분산 행렬에 대한 conjugate prior이므로, posterior도 IW 분포가 되어 계산이 closed-form으로 가능하다.

### VB Iteration

각 time step에서 VBAKF는 다음과 같은 **fixed-point iteration**을 수행한다:

1. **Predict step**: 이전 step의 posterior IW 분포를 forgetting factor **ρ**를 통해 propagation하여 predicted IW 파라미터 **(ν_k⁻, V_k⁻)** 를 얻는다. 일반적으로 사용되는 dynamic model:
   \[
   \nu_k^- = \rho(\nu_{k-1} - n - 1) + n + 1, \quad V_k^- = B V_{k-1} B^\top
   \]
   여기서 **ρ ∈ (0, 1]** 는 covariance의 time-fluctuation 정도를 제어한다 (ρ=1은 stationary).

2. **Update step**: VB iteration을 통해 coupled 파라미터를 수렴할 때까지 업데이트:
   - State estimate: 표준 Kalman Filter update와 동일한 형태, 단 measurement noise는 **E[Σ_k⁻¹]⁻¹ = (ν_k - n - 1)⁻¹ V_k**로 대체
   - IW 파라미터 업데이트: 현재 measurement 정보와 state estimate를 반영하여 **ν_k, V_k** 갱신

### Forgetting Factor와 Tracking Speed-분산 Trade-off

Li et al. (2026)은 **Theorem 5**에서 forgetting factor **ρ**와 covariance tracking 성능 간의 근본적 trade-off를 증명했다:
- 작은 **ρ**: 빠른 convergence (transient bias decay 속도 ↑) ↔ steady-state variance ↑ (추정이 noisy)
- 큰 **ρ**: smooth한 steady-state estimate ↔ 느린 convergence
- Convergence time constant: **τ_c = -1 / ln(ρ)**

## 논문별 핵심 접근법

| 논문 | 방법 | Noise Model | 핵심 공식 | RIGOR Relevance |
|------|------|-------------|-----------|-----------------|
| Särkkä & Hartikainen (2013) | VB-AGF (VB Adaptive Gaussian Filter) | Measurement noise Σ_k (full covariance) | VB iteration with Gaussian integration (UKF, CKF, GHKF) | Nonlinear KF + VB → SR-UKF에 직접 적용 가능 |
| Huang et al. (2018) | VBAKF with inaccurate Q,R | Process noise Q_k AND measurement noise R_k | Dual IW prior + fixed-point VB | Joint Q/R learning — RIGOR의 EM-based 학습과 동일 목표 |
| Akhlaghi et al. (2017) | Innovation/Residual-based AEKF | Q (innovation-based), R (residual-based) | Forgetting factor α로 Q,R recursive estimation | Adaptive 방법론 분류 체계 + baseline 성능 비교 |
| Srinivasan et al. (2026) | Conditional Variational Formulation (Mitter-Newton) | Correlated noise (shared Brownian motion) | P_XY ≪ P_X ⊗ λ_Y 실패 → conditional reference measure 도입 | VB의 이론적 기초 — correlated noise 환경에서의 VB 한계와 일반화 |
| Li et al. (2026) | STKF / STKF-A / STKF-AR (Student's t) | Outlier + time-varying Q,R | Student's t loss → fixed-point iteration + Bernoulli switching | **가장 포괄적**: robustness + adaptivity 통합, KF/RKF/VBKF 모두 recover |

## 각 논문 상세

### 1. Särkkä & Hartikainen (2013) — VB for Nonlinear KF

**핵심 기여**: 선형 VB-AKF (Särkkä & Nummenmaa, 2009)를 **비선형 상태공간 모델**로 확장.

- **문제 설정**: 비선형 모델 x_k = f(x_{k-1}) + w_k, y_k = h(x_k) + v_k 에서 measurement noise covariance Σ_k 가 unknown.
- **접근법**: VB approximation을 Gaussian filter (UKF, CKF, GHKF, EKF 등)와 결합 → **VB-AUKF, VB-ACKF, VB-AGHKF, VB-AEKF** 등 다양한 변형 가능.
- **핵심 기술**:
  - State prediction: Gaussian filter prediction equation 사용
  - IW prediction: 선형 케이스와 동일한 **ρ** 기반 propagation
  - Measurement update: nonlinear h(x_k)로 인해 intractable → Gaussian integration method로 근사
- **한계**: Process noise Q는 추정 불가 (measurement noise만 추정). Smoothing으로의 확장이 어려움 (transition density 미지).

### 2. Huang et al. (2018) — VBAKF with Inaccurate Q and R

**핵심 기여**: **Process noise와 measurement noise 모두 inaccurate**한 상황에서 **state + predicted error covariance (PECM) + measurement noise covariance (MNCM)** 를 동시 추정.

- **핵심 기술**: **Dual inverse Wishart prior**
  - PECM **P_{k|k-1}** 에 IW prior 할당 → nominal PNCM **Q̃_k**를 통해 prior parameter 설정
  - MNCM **R_k** 에 IW prior 할당 → forgetting factor **ρ**로 시간 변화 추적
- **파라미터**:
  - **τ**: tuning parameter (PECM prior vs. VB estimate 간 균형, 권장 τ ∈ [2, 6])
  - **ρ**: forgetting factor (MNCM의 시간 변화 추적, 권장 ρ ∈ [0.9, 1])
  - **N**: fixed-point iteration 횟수 (N ≥ 6에서 수렴)
- **수치적 안정성**: Modified PECM **P̂_{k|k-1}** 과 MNCM **R̂_k** 가 항상 positive definite이도록 보장.
- **성능**: KFTCM (true covariance)에 근접한 RMSE (KFNCM 대비 position 54.5%, velocity 22.4% 감소).

### 3. Akhlaghi et al. (2017) — Survey of Adaptive Methods

**핵심 기여**: Adaptive noise covariance estimation 방법론의 **체계적 분류**와 **innovation/residual 기반 AEKF** 제안.

- **Adaptive 방법 분류** (Mehra, 1972):
  1. **Bayesian**: Multiple Model AKF (MMAKF), VB 기반 방법
  2. **Maximum Likelihood**: Innovation-based AKF (IAKF)
  3. **Covariance Matching**: Sage-Husa AKF (SHAKF)
  4. **Correlation**: Autocorrelation 기반 방법
- **제안된 AEKF**:
  - **R estimation (residual-based)**: ε_k = z_k - h(ẑ_k⁺), R_k = α R_{k-1} + (1-α)(ε_k ε_k^T + H_k P_k⁻ H_k^T)
  - **Q estimation (innovation-based)**: ν_k = z_k - h(x̂_k⁻), Q_k = α Q_{k-1} + (1-α)(K_k ν_k ν_k^T K_k^T)
  - Forgetting factor α = 0.3 사용
- **핵심 발견**: KF 성능은 **Q와 R의 절대값이 아닌 Q/R 비율**에 의해 결정됨.
- **RIGOR 관련성**: Adaptive 방법의 분류 체계를 제공하며, innovation whiteness test 등 RIGOR의 loss function 설계에 참고 가능.

### 4. Srinivasan et al. (2026) — Theoretical VB and Correlated Noise

**핵심 기여**: Mitter-Newton (2003)의 **variational formulation of nonlinear filtering**이 **correlated noise 환경에서는 성립하지 않음**을 증명하고, 이를 일반화하는 **conditional variational principle** 제안.

- **핵심 정리**: Signal과 observation diffusion이 common noise source를 공유하면, joint path measure P_XY와 product measure P_X ⊗ λ_Y가 **mutually singular** (절대적으로 연속이 아님) → Mitter-Newton의 Assumption 2.1이 근본적으로 성립 불가.
- **Proposition 4.1**: P_XY ≪ P_X ⊗ λ_Y 이면 P_XY ≪ P_X ⊗ P_Y. 즉, reference measure λ_Y를 어떻게 선택해도 correlated noise 문제는 회피 불가.
- **해결책**: **Conditional reference measure Q** 도입 — noise correlation 구조를 보존하는 reference measure로 대체:
  - Q_Y = P_Y (observation marginal 보존)
  - P_{X|Y}(·, y) ≪ Q_{X|Y}(·, y) (conditional measure 간의 절대적 연속성)
- **Linear correlated noise case**: Driftless reference system에서 explicit free energy 유도. Girsanov 변환을 통한 Radon-Nikodym derivative 도출.
- **RIGOR 관련성**: VB filtering의 **이론적 토대**를 제공하며, SR-UKF에서 sensor noise correlation이 있는 경우 이 결과가 적용될 수 있음.

### 5. Li et al. (2026) — Variational Robust KF (Student's t)

**핵심 기여**: **Robustness와 adaptivity를 통합한 unified framework** 제안. Student's t-distribution induced loss를 fixed-point iteration으로 풀어 **계산 효율성**을 극대화.

- **핵심 통찰**: **Robust filter는 adaptive filter의 prerequisite**이다. Outlier가 covariance 추정을 망가뜨리므로, 먼저 robustness를 확보한 후 adaptivity를 적용해야 함.
- **세 가지 알고리즘**:
  - **STKF** (Student's t KF): Robust filter, fixed-point iteration으로 해, **Theorem 3**에서 convergence 조건 증명
  - **STKF-A**: Adaptive + robust (hyperparameter forgetting factor ρ로 covariance tracking)
  - **STKF-AR**: Full robust-adaptive (Bernoulli switching으로 outlier probability를 추정하여 adaptive update 조절)
- **이론적 결과**:
  - **Theorem 4**: VB inference (Problem 2)의 optimal variational posterior Q_x^*의 mean = MAP estimate (Problem 1) — VB를 robust filter로 해석 가능
  - **Theorem 5**: Covariance tracking의 convergence rate와 steady-state variance 사이의 trade-off 정량화
- **파라미터 가이드라인**:
  - **ν_i** (DOF): Gaussian channel → ∞, outlier-prone channel → [0.5, 5]
  - **ρ_i** (forgetting factor): [0.95, 1), ρ=1 → STKF (non-adaptive)
- **Recover 관계**: KF ← (ν→∞) STKF ← (ρ=1) STKF-A ← (Bernoulli off) STKF-AR
- **성능**: Quadruped localization에서 STKF-AR이 IEKF, ESKF, STKF 모두보다 우수 (ep 0.0247m).

## RIGOR 연결

[[rigor-filter]] 는 **differentiable SR-UKF** + **A+NN dynamics** + **EM-based noise covariance learning**을 결합한 프레임워크이다. VBAKF 방법론들은 RIGOR의 Q/R 학습 파이프라인에 다음과 같이 연결된다:

### 각 논문의 RIGOR Relevance

| 논문 | RIGOR 연결점 |
|------|-------------|
| **Särkkä & Hartikainen (2013)** | VB-AGF의 Gaussian integration framework는 SR-UKF와 **직접 통합 가능**. VB-AUKF/VB-ACKF는 RIGOR의 sigma point 기반 filter에 VB를 얹은 형태로, RIGOR의 differentiable SR-UKF에 **VB iteration layer**를 추가하는 방식으로 확장 가능. |
| **Huang et al. (2018)** | **가장 직접적 연결**: RIGOR의 EM-based Q/R learning과 동일한 목표 (inaccurate Q,R 동시 추정). VBAKF의 dual IW prior + fixed-point iteration은 RIGOR의 EM step을 VB iteration으로 대체한 형태. RIGOR의 A+NN dynamics 학습과 결합 시 **joint state-dynamics-covariance learning** 가능. |
| **Akhlaghi et al. (2017)** | RIGOR의 baseline 비교 대상. Innovation whiteness loss (RIGOR 실험 #1)과 직결. AEKF의 forgetting factor 기반 Q,R 추정은 RIGOR의 EM-based 학습보다 **계산 효율적**이지만, **nonlinear dynamics + differentiable framework**에서는 VB 기반 방법이 더 적합. |
| **Srinivasan et al. (2026)** | RIGOR가 correlated observation noise 환경에서 사용될 때 중요한 이론적 배경. SR-UKF의 sigma point spread가 noise correlation에 의해 왜곡되는 경우, conditional reference measure 개념이 **RIGOR의 observation model 설계**에 영감을 줄 수 있음. |
| **Li et al. (2026)** | **RIGOR에 가장 적합한 VB 방법**. 이유: ① Robustness를 먼저 확보한 후 adaptivity 적용 — RIGOR의 loss function 설계에 직접 활용 ② Fixed-point iteration이 **gradient-based optimization보다 계산 효율적** (Theorem 3) ③ STKF-AR의 Bernoulli switching은 RIGOR의 outlier detection 메커니즘으로 채택 가능 ④ KF/RKF/VBKF 모두 recover 가능 → RIGOR가 다양한 noise scenario에서 **단일 프레임워크로 대응** 가능. |

### 최적의 VB 방법: RIGOR의 Differentiable SR-UKF에 가장 적합한 접근

RIGOR의 **differentiable SR-UKF with A+NN dynamics** 프레임워크에 가장 적합한 VBAKF 방법은 **Li et al. (2026)의 STKF-AR**과 **Huang et al. (2018)의 VBAKF**를 결합한 형태로 제안된다:

1. **STKF-AR의 Bernoulli switching**으로 outlier-robust covariance tracking
2. **Huang의 dual IW prior**로 PECM과 MNCM 동시 추정
3. **SR-UKF의 sigma point propagation**으로 nonlinear dynamics 처리
4. **Differentiable VB iteration**으로 end-to-end gradient flow 확보

RIGOR의 실험 결과에서도 확인할 수 있듯이, sigma point 정보를 covariance estimation에 활용하는 접근 (실험 #4 per-state spread, #5 sigma spread regularizer)이 유효하며, 이는 VBAKF와 SR-UKF의 결합이 자연스럽고 효과적임을 시사한다.

## Wikilinks

- [[rigor-filter]]
- [[square-root-unscented-kalman-filter]]
- [[deepukf-vin]]
- [[auto-diff-data-assimilation]]
- [[mhc-deepseek]]
