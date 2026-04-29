---
title: Uncertainty Quantification in Aeroelasticity
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [physics-informed, optimization, paper, comparison, uncertainty, engineering-design]
sources: [raw/papers/annurev-fluid-122414-034441.md]
confidence: high
---

# Uncertainty Quantification in Aeroelasticity

## 개요

Beran, Stanford, Schrock (AFRL/NASA, 2017)의 **Annual Review of Fluid Mechanics** 리뷰 논문으로, **공탄성(aeroelasticity) 문제에서 불확실성 정량화(UQ)** 방법론을 종합 정리했다^[raw/papers/annurev-fluid-122414-034441.md]. 공기력과 구조의 coupling이 불확실성에 극도로 민감한 공탄성 시스템의 안전 인증 및 설계 최적화를 다룬다.

## 공탄성 물리학

### 공탄성 현상 분류

| 현상 | 유형 | 특성 | 위험도 |
|------|------|------|--------|
| **Flutter** | dynamic instability | 발산적 진동, Hopf bifurcation | catastrophic |
| **LCO** (Limit Cycle Oscillation) | dynamic | 유한 진폭 자기흥분 진동 | 구조 피로 |
| **Divergence** | static instability | 정적 불안정 | 날개 꺾임 |
| **Whirl flutter** | dynamic | 로터/프로펠러 관련 | rotorcraft 특화 |
| **Stall flutter** | dynamic | 고攻角 비선형 | 대攻角 비행 |
| **Buffet** | forced vibration | 공기력 강제 진동 | twin-tail 구조 |

### Flutter과 LCO의 Hopf Bifurcation

Flutter과 LCO는 동적 압력(dynamic pressure)이나 마하 수의 변화에 따른 **Hopf bifurcation**에서 기원:

- **Flutter**: bifurcation 지점에서 안정성이 abrupt하게 상실 (subcritical)
- **LCO**: supercritical bifurcation에서 진폭이 유한하게 성장 후 수렴
- 일부 flutter은 Hopf 이론을 따르지 않음 (Bendiksen 2006)

## 불확실성 출처

공탄성 시스템의 불확실성은 크게 세 범주:

| 범주 | 구체적 출처 | 영향 |
|------|------------|------|
| **물리적 불확실성** | 재료 특성, 공력 하중, 경계 조건, 제조 공차 | flutter 속도 변동 |
| **모델 형태 불확실성** | transonic regime physics 누락, coupling surface 제한 | 예측 오차 |
| **수치적 불확실성** | 격자 해상도, 수치 방법 선택 | 해석 결과 변동 |

## UQ 방법론 비교

### 확률적 스펙트럼 확장 (Polynomial Chaos)

응답을 확률적 basis function으로 확장:

$$w(\mathbf{x}, \xi) = \sum_{k=0}^P \hat{w}_k(\mathbf{x}) \Psi_k(\xi)$$

- $P+1 = (n+p)!/(n!p!)$ 개의 항 (total-order expansion)
- **Hermite 다항식** → Gaussian RV에 최적 (exponential convergence)
- **Generalized PC**: 비가우시안 RV에도 적용 가능 (Xiu & Karniadakis 2002)
- **Intrusive vs Non-intrusive**: 코드 수정 필요 여부에 따라 구분

### 확률적 콜로케이션 (Stochastic Collocation)

$$w(\mathbf{x}, \xi) = \sum_{i_1=1}^{m_1}\cdots\sum_{i_n=1}^{m_n} \hat{w}_{i_1,\dots,i_n}(\mathbf{x}) \prod_j \Psi_{i_j}(\xi_j)$$

- **B-spline collocation**: 불연속(bifurcation) 근처에서 compact support로 진동 방지
- **Adaptive simplex elements**: steep gradient 영역 자동 세분화
- **Lagrange interpolation**: collocation point 기반 보간

### Monte Carlo Simulation (MCS)

- 가장 단순하지만 고비용
- 신뢰성(reliability) 분석의 baseline으로 사용

## 신뢰성 기반 설계

공탄성 설계에서 **파괴 확률(Probability of Failure, POF)** 을 최소화:

$$\text{POF} = P[\text{flutter speed} < V_{\text{design}} \times 1.15]$$

인증 기준: 비행 envelope 내 flutter-free + **15% equivalent airspeed margin**

| 설계 접근법 | 방법 | 적용 |
|------------|------|------|
| **Deterministic** | 안전 마진 적용 | 현재 인증 관행 |
| **Probabilistic** | POF 기반 최적화 | weight reduction 가능 |
| **Reliability-based** | FORM/SORM | high-dim parameter space |
| **μ-analysis** | worst-case uncertainty | robust control 연결 |

## ML 기반 확장

최근 추세: 전통적 UQ 방법을 [[uncertainty-quantification-deep-learning|ML 기반 UQ]]로 대체/보완

| 방법 | 적용 | 이점 |
|------|------|------|
| **[[physics-constrained-surrogate]]** | PDE-기반 surrogate | 레이블 불필요, UQ 내장 |
| **Gaussian Process Emulator** | 저차원 입력 | 내장 UQ |
| **Bayesian Neural Network** | 고차원 비선형 | parameter uncertainty |
| **Deep Ensemble** | 임의 구조 | 구현 간편 |

## 관련 개념

- [[uncertainty-quantification-deep-learning]] — ML 기반 UQ
- [[physics-constrained-surrogate]] — Surrogate modeling
- [[simulation-based-inference-aircraft-design]] — 항공기 설계 추론
- [[pinn-high-speed-flows]] — 고속 유동 PINN
