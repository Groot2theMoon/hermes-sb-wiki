---
title: Physics-Informed Machine Learning
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [physics-informed, surrogate-model, model, pinn, neural-operator, deeponet]
sources: [raw/papers/1-s2.0-S0021999119303559-main.md, raw/papers/1-s2.0-S0021999120306872-main.md, raw/papers/trending/2026-04-28-04.md]
confidence: high
---

# Physics-Informed Machine Learning

## 개요

**Physics-Informed Machine Learning (PIML)** 은 물리 법칙 — 편미분방정식(PDE), 상미분방정식(ODE), 보존 법칙, 대칭성, 열역학 제약 — 을 신경망의 학습 과정에 직접 통합하는 패러다임이다. 데이터만으로 학습하는 전통적인 black-box ML과 달리, PIML은 모델의 예측이 물리적으로 타당하도록 유도하여 **data efficiency**, **generalization**, **interpretability**를 동시에 확보한다. 기계공학, 유체역학, 고체역학, 열전달, 음향학 등 광범위한 물리·공학 도메인에서 시뮬레이션 가속화(surrogate modeling)와 역문제(inverse problem) 해결의 핵심 도구로 자리잡았다.

## 핵심 수학적 프레임워크

일반적인 PDE를 고려하자:

$$\mathcal{N}[u(\mathbf{x}, t); \lambda] = f(\mathbf{x}, t), \quad \mathbf{x} \in \Omega, \; t \in [0, T]$$

여기서 $\mathcal{N}$은 비선형 미분 연산자, $u$는 해, $\lambda$는 PDE 파라미터, $f$는 소스 항이다. PIML의 핵심 아이디어는 **물리 잔차(physics residual)** 를 손실 함수에 추가하는 것이다:

$$\mathcal{L}_{\text{physics}} = \frac{1}{N_r} \sum_{i=1}^{N_r} \left\| \mathcal{N}[u_\theta(\mathbf{x}_i, t_i); \lambda] - f(\mathbf{x}_i, t_i) \right\|^2$$

전체 손실 함수는 데이터 항과 물리 항의 가중합이다:

$$\mathcal{L}_{\text{total}} = \lambda_d \mathcal{L}_{\text{data}} + \lambda_p \mathcal{L}_{\text{physics}} + \lambda_b \mathcal{L}_{\text{boundary}} + \lambda_i \mathcal{L}_{\text{initial}}$$

## PIML 방법론 분류 (Taxonomy)

### 1. Soft Constraint 방법

물리 제약을 손실 항으로 **부드럽게(penalty)** 부과하는 방식.

| 방법 | 설명 | 핵심 논문 |
|:---|:----|:---|
| **Vanilla PINN** | PDE residual을 MSE 손실에 추가 | [[maziar-raissi|Raissi]] et al. (2019), *J. Comput. Phys.* |
| **Variational PINN (VPINN)** | 약형(weak form) 기반; 적분형 residual 사용 | Kharazmi et al. (2019) |
| **cPINN / XPINN** | 도메인 분할(domain decomposition) + 병렬화 | Jagtap & [[george-em-karniadakis|Karniadakis]] (2020) |
| **fPINN** | Fractional PDE 용; 분수 미분 연산자 대응 | Pang et al. (2019) |
| **nPINN** | Nonlocal PDE 용 | Pang et al. (2020) |

### 2. Hard Constraint 방법

물리 제약을 신경망 구조 자체에 **하드코딩(hard)** 하는 방식.

| 방법 | 설명 | 핵심 논문 |
|:---|:----|:---|
| **Hard-Constraint PINN (hPINN)** | 경계 조건을 distance function으로 **exactly** 만족 | [[hpinns-inverse-design]] |
| **Constrained Backpropagation** | 역전파 시 gradient projection으로 PDE 제약 부과 | — |
| **Lagrangian PINN** | Lagrange multiplier로 hard constraint 최적화 | — |

### 3. Operator Learning (함수 공간 학습)

입력 함수 → 출력 함수를 직접 매핑하는 operator regression.

| 방법 | 설명 | 핵심 논문 |
|:---|:----|:---|
| **DeepONet** | Branch + Trunk 구조, universal operator approximation | [[deeponet]] |
| **Fourier Neural Operator (FNO)** | Fourier 공간 convolution + spectral method | [[fourier-neural-operator]] |
| **Physics-Informed Neural Operator (PINO)** | FNO + PINN 결합 | Li et al. (2021) |
| **Pseudo-Differential Neural Operator (PDNO)** | Pseudo-differential operator 기반 | [[pseudo-differential-neural-operator]] |

### 4. Bayesian / Uncertainty-Aware 방법

| 방법 | 설명 | 핵심 논문 |
|:---|:----|:---|
| **Bayesian PINN (B-PINN)** | Hamiltonian Monte Carlo로 사후분포 추론 | [[bayesian-pinns]] |
| **Dropout UQ** | MC Dropout으로 예측 불확실성 추정 | [[mc-dropout]] |
| **Ensemble PINN** | 다중 PINN 앙상블로 epistemic uncertainty 정량화 | [[deep-ensembles]] |

### 5. Transfer Learning / Meta-Learning PINN

| 방법 | 설명 |
|:---|:----|
| **Transfer-Learning PINN** | 사전학습된 PINN을 유사 PDE로 미세조정 |
| **Meta-Learning PINN** | MAML 계열로 빠른 adaptation |
| **CoPINN (Cognitive PINN)** | 쉬운 샘플 → 어려운 샘플 순차 학습으로 UPP 완화 |

### 6. In-Context & Retrain-Free 패러다임

- [[in-context-modeling-physics]] — ICM: Transformer 기반 in-context learning으로 단일 forward pass에서 재학습 없이 새로운 PDE로 일반화
- 이는 전통적인 PINN의 "PDE 파라미터 변경 시 재학습 필요"라는 근본 한계를 해결하려는 2025-2026년 최신 패러다임

## 주요 논문 타임라인

| 연도 | 논문 | 기여 |
|:---|:----|:---|
| 1995 | Chen & Chen | Operator Universal Approximation Theorem (DeepONet의 이론적 기반) |
| 2017 | [[maziar-raissi|Raissi]] et al. (arXiv) | Physics-Informed Neural Networks 최초 제안 |
| 2019 | [[maziar-raissi|Raissi]], [[paris-perdikaris|Perdikaris]], [[george-em-karniadakis|Karniadakis]] | PINN 프레임워크 정립 (*J. Comput. Phys.*, 378, 686-707) |
| 2020 | Wang, Yu, [[paris-perdikaris|Perdikaris]] | **NTK 관점**에서 PINN 학습 실패 분석 ([[pinn-failure-modes]]) |
| 2020 | Jagtap & [[george-em-karniadakis|Karniadakis]] | cPINN / XPINN — domain decomposition |
| 2021 | Lu, Jin, [[george-em-karniadakis|Karniadakis]] | DeepONet 정식 발표 ([[deeponet]]) |
| 2021 | Li et al. | Fourier Neural Operator ([[fourier-neural-operator]]) |
| 2021 | Yang et al. | B-PINN (Bayesian) ([[bayesian-pinns]]) |
| 2022 | Krishnapriyan et al. | NTK nonlinear regime 분석 — PINN의 한계 확장 |
| 2023 | 다양한 그룹 | Transfer Learning PINN, Meta-Learning PINN 등장 |
| 2024 | Lu et al. | Physics-Informed Temporal U-Net ([[physics-informed-temporal-unet]]) |
| 2025 | Yang et al. | ICM: In-context modeling for physics ([[in-context-modeling-physics]]) |
| 2025 | 다수 | AI hallucination in physics 최초 보고 ([[ai-hallucination-physics]]) |

## 핵심 난제 (Challenges)

1. **Spectral Bias**: PINN은 저주파 성분을 먼저 학습하고 고주파 성분을 늦게 학습 → multi-scale PDE에서 실패 ([[pinn-failure-modes]], [[neural-tangent-kernel]])
2. **Loss Balancing**: $\mathcal{L}_{\text{data}}$, $\mathcal{L}_{\text{physics}}$, $\mathcal{L}_{\text{boundary}}$ 간 가중치 자동 조절 필요 (learning rate annealing, Neural Tangent Kernel 기반 적응)
3. **Nonlinear Regime**: 강한 비선형성에서 NTK가 상수가 아니며 Hessian이 무시 불가 → 2차 최적화 필요
4. **High-Speed Flows**: 충격파(shock), 불연속면에서 PINN 실패 ([[pinn-high-speed-flows]])
5. **Computational Cost**: 복잡한 3D 문제에서 자동 미분 비용 높음
6. **Retrain-free Generalization**: 파라미터 변경 시 매번 재학습 필요 → ICM 등 새로운 패러다임으로 해결 모색

## PIML 방법 선택 가이드

| 시나리오 | 권장 방법 |
|:---|:---|
| 소수 데이터 + PDE 알려짐 | Vanilla PINN |
| 경계 조건 엄격 준수 필요 | [[hpinns-inverse-design]] (Hard-Constraint PINN) |
| 불확실성 정량화 필요 | [[bayesian-pinns]] |
| 다양한 파라미터에 대한 빠른 추론 | [[deeponet]], [[fourier-neural-operator]] |
| Multi-scale / 고주파 해 | Spectral bias 완화 기법 (Fourier feature embedding) |
| 고속 압축성 유동 | [[pinn-high-speed-flows]] |
| Domain decomposition | cPINN, XPINN |
| 재학습 없이 새로운 PDE 대응 | [[in-context-modeling-physics]] |

## 관련 개념 네트워크

### 직계 하위 개념 (Sub-Concepts)
- [[physics-constrained-surrogate]] — 레이블 없이 PDE 손실 함수만으로 학습하는 surrogate model
- [[bayesian-pinns]] — Bayesian 추론으로 불확실성 정량화
- [[pinn-failure-modes]] — NTK 관점에서 PINN 학습 실패 원인 분석
- [[pinn-high-speed-flows]] — 고속 유동(충격파 포함)에 PINN 적용
- [[hpinns-inverse-design]] — Hard constraints로 inverse design

### 연계 개념 (Cross-References)
- [[deeponet]] — Operator learning: 함수 공간 매핑
- [[fourier-neural-operator]] — Fourier 공간 neural operator
- [[in-context-modeling-physics]] — Retrain-free 패러다임
- [[neural-tangent-kernel]] — PIML 학습 동역학의 이론적 토대
- [[universal-approximation-theorem]] — 근사 이론
- [[ai-hallucination-physics]] — 물리 AI의 환각 현상
- [[physics-informed-temporal-unet]] — Physics-Informed Temporal U-Net
- [[generative-models-physics]] — 생성 모델의 물리학 응용

## 2026년 최신 동향

- **Retrain-free 패러다임**: [[in-context-modeling-physics]] — ICM은 Transformer 기반 in-context learning을 물리 시스템에 도입, 단일 forward pass로 재학습 없이 새로운 PDE 조건에 일반화
- **Physics-Informed Temporal U-Net** (arXiv:2604.23372): U-Net 아키텍처에 VGG perceptual loss + parabolic boundary bridge 결합, 유체 interpolation에서 기존 대비 5배 이상 MAE 개선
- **LESnets** (arXiv:2604.26621): LES 방정식을 factorized FNO에 통합한 physics-informed neural operator, 벽면 난류 장기 예측에서 레이블 데이터 없이 전통 LES 수준 정확도 달성
- **AI Hallucination in Physics**: [[ai-hallucination-physics]] — 유동 AI 모델이 물리 법칙을 위반하는 가상 해를 생성하는 현상 최초 보고
- **CoPINN (Cognitive PINN)**: 쉬운 샘플에서 어려운 샘플로 순차 학습하여 unbalanced prediction 문제 해결
- **PINNeAPPle**: 60+ PIML 모델을 13개 카테고리로 정리한 통합 벤치마크 프레임워크

→ 각각의 상세 내용은 해당 개념 페이지 참조
- [[rino]]
