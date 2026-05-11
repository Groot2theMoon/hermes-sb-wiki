---
title: "NN-Poly: Neural Network to Taylor Polynomial Approximation for Dynamical System Constraints"
created: 2026-05-11
updated: 2026-05-11
type: concept
tags: [system-identification, hybrid-modeling, physics-informed, state-estimation, safety, interpretable-learning]
sources:
  - raw/papers/nn-poly-zhu22.md
confidence: high
---

# NN-Poly: Neural Network → Taylor Polynomial for Dynamical System Constraints

Zhu F, Jing D, Leve F and Ferrari S (2022). Frontiers in Robotics and AI 9:968305.

## 개요

NN-Poly는 **학습된 신경망(trained NN)**을 **Taylor 다항식**으로 근사하여, 물리 법칙(physical constraints)을 동역학계의 상태 예측에 적용할 수 있게 하는 방법론이다. 핵심 통찰: 신경망은 보편 근사자로서 우수한 예측 성능을 갖지만 물리 법칙을 준수하지 않는 반면, 다항식은 물리 제약(semi-algebraic constraint)을 적용할 수 있는 분석적 추적성(analytic traceability)을 제공한다.

## 핵심 기여

### 1. NN → Polynomial 변환

학습된 NN의 파라미터(가중치, 편향, 활성함수)를 **Taylor series expansion**을 통해 동등한 차수의 다항식 계수로 변환:

- **Fully Connected (FC)**: 행렬-벡터 곱의 Taylor 전개 → 행렬 다항식
- **CNN**: convolution 연산의 다항식 전개 (tensor derivative unfolding)
- **RNN**: 순환 구조의 벡터 함수 Taylor 전개
- **다양한 활성함수**: sigmoid, tanh, ReLU 등 모든 common activation function의 Taylor 근사 지원

### 2. 다층망 확장

단일층 polynomial approximation을 임의의 깊이(depth)를 가진 다층망으로 확장. 각 층의 Taylor 근사를 composition하여 전체 네트워크의 다항식 표현을 얻음.

### 3. 물리 제약 적용

변환된 다항식을 **semi-algebraic constraint** ($p(x) \geq 0$ 또는 $p(x) = 0$) 형태로 표현하여:
- Newtonian dynamics (에너지 보존, 운동량 보존)
- Lyapunov 안정성 조건
- 입력-출력 경계 조건
- 연속성(continuity) 및 유계 민감도(bounded sensitivity) 조건

을 상태 예측에 적용 가능. 반정부호 계획법(Semi-Definite Program, SDP)와 sum-of-squares (SOS) 최적화로 전역 최적해 탐색.

## 방법론 구조

```
Trained NN (FC/CNN/RNN)
  ↓ Section 2: General Taylor series expansion (tensor form)
  ↓ Section 3: Tensor derivative unfolding → matrix/vector form
  ↓ Section 4: Rewrite as matrix equations with polynomial entries
  ↓ Section 5: Extend to multi-layer → deep polynomial
  ↓ Section 6: Apply physical constraints (semi-algebraic)
  ↓ Section 7: Solve for state prediction with constraints
```

## 장점

- **분석적 추적성**: 선형 모델(1차 다항식)부터 고차 다항식까지 familiar basis로 NN 행동 설명
- **안전성 보장**: 물리 제약 적용으로 안전하지 않은 상태 예측 방지
- **실시간 실행**: 변환된 다항식은 경량이므로 real-time inference 가능
- **과적합 방지**: 다항식 차수 제한으로 표현력 제어
- **검증 가능성(Verifiability)**: 다항식 형태는 formal verification tool (SDP, SOS) 적용 가능
- **최소 파라미터 수**: 고차 NN보다 적은 파라미터로 동등한 예측 성능

## 결과

테스트 케이스에서 제안된 방법은:
- Minimal root-mean-squared state error 유지
- 적은 파라미터로 동등한 예측 성능
- 모델 구조 기반 검증 및 안전성 분석 가능

## 한계

- **Taylor 근사의 지역성**: 학습 분포를 벗어난 영역에서 근사 정확도 저하 가능
- **다차원 시스템**: 고차원 동역학에서 polynomial explosion 가능성
- **활성함수 의존성**: ReLU 같은 piecewise-linear 함수의 Taylor 근사는 낮은 차수에서 정확도 제한
- **NN 학습 후 변환**: 학습된 NN이 우수해야 변환된 다항식도 유용 (NN 품질에 종속)

## 관련 페이지
- [[system-identification]] — 시스템 식별 일반
- [[physics-informed]] — 물리 기반 ML 패러다임
- [[hybrid-modeling]] — 물리+데이터 융합 모델링
- [[surrogate-model]] — ML 기반 계산 에뮬레이터
- [[square-root-unscented-kalman-filter]] — SR-UKF 상태 추정 (RIGOR)
- [[frances-zhu]] — Frances Zhu, 제1저자
- [[silvia-ferrari]] — Silvia Ferrari, 교신저자
