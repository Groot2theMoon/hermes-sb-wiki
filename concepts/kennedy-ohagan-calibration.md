---
title: Kennedy-O'Hagan Framework for Computer Model Calibration
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [surrogate-model, model, mathematics, paper, uncertainty, landmark-paper]
sources: [raw/papers/kennedy01.md, raw/papers/Kennedy-PredictingOutputComplex-2000.md]
confidence: high
---

# Kennedy-O'Hagan Bayesian Calibration Framework

## 개요

**Kennedy & O'Hagan** (University of Sheffield, *Journal of the Royal Statistical Society B*, 2001, ~6,000+ citations)는 컴퓨터 모델(computer code)의 **Bayesian 보정(calibration)** 을 위한 체계적 프레임워크를 제시했다. 이는 복잡한 전산 코드를 Gaussian Process (GP) surrogate로 대체하고, **모든 불확실성 소스** (parameter uncertainty, model inadequacy, observation error)를 체계적으로 처리하는 최초의 방법론이다.

## 핵심 방정식

KOH 프레임워크의 핵심은 관측 데이터 $y(x)$를 다음 구성요소로 분해하는 것이다:

$$y(x) = \eta(x, \theta) + \delta(x) + \varepsilon$$

| 구성요소 | 의미 | 불확실성 유형 |
|---------|------|:----------:|
| $\eta(x, \theta)$ | Calibration params $\theta$에서의 컴퓨터 코드 출력 | Parameter uncertainty |
| $\delta(x)$ | Model discrepancy (코드의 구조적 부정확성) | Model inadequacy |
| $\varepsilon$ | 관측 오차 (백색 잡음) | Observation error |
| $y(x)$ | 실제 공정 관측값 | Total uncertainty |

## 전통적 방법 vs KOH 방법

| 차원 | 전통적 calibration | KOH Bayesian calibration |
|------|:----------------:|:----------------------:|
| **불확실성** | 단일 점 추정 (plug-in) | 완전한 사후 분포 |
| **Model inadequacy** | 무시 | $\delta(x)$로 명시적 모델링 |
| **Surrogate** | 없음 (코드를 직접 실행) | GP emulator 사용 |
| **계산 비용** | 매우 높음 | 낮음 (surrogate 기반) |
| **예측 신뢰구간** | 과소 추정 | 적절한 보정 |

## 방법론 단계

### 1단계: GP Emulator 구축

비싼 컴퓨터 코드를 **Gaussian Process**로 대체:

$$\eta(\cdot) \sim \mathcal{GP}(m(\cdot), k(\cdot, \cdot))$$

코드 실행 결과가 주어지면, 임의의 입력에서 코드 출력의 조건부 분포를 **폐쇄형(closed-form)** 으로 계산 가능. 이는 **코드 실행 비용을 획기적으로 절감**하는 핵심 요소이다.

### 2단계: Model Discrepancy 모델링

Model inadequacy $\delta(x)$도 GP로 모델링:

$$\delta(\cdot) \sim \mathcal{GP}(0, k_\delta(\cdot, \cdot))$$

$\delta(x)$는 "완벽한 calibration params $\theta^*$를 찾아도 코드가 현실을 완벽히 예측하지 못하는 차이"를 포착한다. 이 요소를 **무시하면 calibration이 편향되고 예측 신뢰구간이 비현실적으로 좁아진다**.

### 3단계: Bayesian 추론

사전 분포 $p(\theta, \phi_\eta, \phi_\delta, \sigma^2)$와 관측 데이터를 결합하여 사후 분포 계산:

$$p(\theta, \dots | y) \propto p(y | \theta, \dots) \cdot p(\theta, \dots)$$

MCMC (Gibbs sampling + Metropolis-Hastings)로 사후 샘플링 수행.

## 코드 불확실성(Code Uncertainty) 개념

KOH는 "컴퓨터 코드를 실행하기 전에는 출력을 완전히 알 수 없다"는 **code uncertainty** 개념을 도입했다. 수학적으로 코드는 결정론적 함수이지만, 실행 비용 때문에 모든 입력 조합을 탐색할 수 없어 불확실성이 발생한다는 점을 체계화했다.

## 응용 사례

- **원자력 방사능 누출** (Tomsk 사고 데이터) — 실제 사례 연구 포함
- **모의 핵 사고 시뮬레이션** — 복잡한 코드의 calibration
- **약동학(pharmacokinetics)** 모델 — 약물 투여량 최적화
- **기후 모델 calibration** — 복잡한 전산 기후 모델 보정

## 융합 도메인 연결

- [[physics-constrained-surrogate]]의 **Bayesian 기반 변종**의 이론적 토대
- [[uncertainty-quantification-deep-learning]]의 **고전적 전신** — UQ 방법론의 시초
- [[kennedy-ohagan-calibration]]은 surrogate model + UQ 연구의 **가장 중요한 단일 참고문헌** 중 하나
- DMN 기반 흡음재 설계 시: 실험 데이터로 DMN calibration + model discrepancy $\delta(x)$로 구조적 오차 포착 → 신뢰할 수 있는 예측 가능
- [[deep-ensembles]] 및 [[mc-dropout]]의 "deep learning era UQ"와 비교 대상

## References
- Kennedy, M. C. & O'Hagan, A. (2001). Bayesian calibration of computer models. *JRSS B*, 63(3): 425-464.
- [[physics-constrained-surrogate]]
- [[uncertainty-quantification-deep-learning]]
- [[vvuq-framework]]
