---
title: Universal Approximation Theorem
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [neural-network, model, mathematics, paper]
sources: [raw/papers/10.1.1.441.7873.md]
confidence: high
---

# Universal Approximation Theorem

## 개요

**Universal Approximation Theorem**은 **단일 은닉층(single hidden layer)을 가진 피드포워드 신경망**이 충분한 수의 뉴런을 가질 경우, 임의의 연속 함수를 원하는 정밀도로 근사할 수 있음을 증명하는 정리이다. 이는 신경망의 표현력(expressiveness)에 대한 이론적 토대를 제공한다.

## 핵심 내용 (Cybenko, 1989)

G. Cybenko의 증명은 다음과 같은 핵심 결과를 포함한다^[raw/papers/10.1.1.441.7873.md]:

- **형태:** $G(x) = \sum_{j=1}^N \alpha_j \sigma(y_j^T x + \theta_j)$ 형태의 유한 선형 결합이 $C(I_n)$ (단위 초입방체 위의 연속 함수 공간)에서 조밀(dense)함을 증명
- **조건:** 활성화 함수 $\sigma$가 연속 시그모이달(continuous sigmoidal) 함수이면 충분
  - $\sigma(t) \to 1$ as $t \to +\infty$, $\sigma(t) \to 0$ as $t \to -\infty$
- **증명 방법:** Hahn-Banach 정리 + Riesz Representation 정리 → discriminatory function 개념 도입
- **판별 함수(discriminatory function):** 적분 조건 $\int \sigma(y^T x + \theta) d\mu(x) = 0$ for all $y,\theta$ 이면 $\mu = 0$이라는 성질을 만족하는 함수

## 확장

### 다양한 활성화 함수
- **연속 시그모이달 함수:** $C(I_n)$에서 조밀 (Cybenko, Theorem 2)
- **단조 시그모이달 함수:** $C(I_n)$에서 조밀 [Funahashi; Hornik, Stinchcombe, White]
- **일반 시그모이달 함수:** $L^1(I_n)$에서 조밀 (Cybenko, Theorem 4)
- **$L^1$ 함수 (non-zero integral):** Wiener Tauberian 정리를 통해 $L^1(I_n)$에서 조밀
- **삼각함수, 지수함수:** Stone-Weierstrass 정리를 통해 조밀

### 이진 결정 영역
Theorem 3: 임의의 유한 가측 분할(finite measurable partition)에 대한 결정 함수를 원하는 정밀도로 근사 가능. 잘못 분류된 점들의 전체 측도를 임의로 작게 만들 수 있음.

## 한계 및 의의

- **존재성(existence)만 증명** — 필요한 뉴런 수(terms)나 가중치 크기에 대한 정보는 제공하지 않음
- Cybenko 본인도 "압도다수의 근사 문제는 천문학적인 수의 항(term)을 필요로 할 것"이라고 언급
- **차원의 저주(curse of dimensionality)** — 다차원 근사 이론의 근본적 한계
- 이후 연구: Baum & Haussler (일반화 능력), Jones (구성적 증명) 등

## 관련 개념

- [[variational-autoencoder]] — 함수 근사의 관점에서 신경망 표현력 의존
- [[gated-recurrent-units]] — RNN의 장기 의존성 학습에서 근사 능력 활용
- [[yolo-object-detection]] — CNN 기반 함수 근사로 회귀 문제 해결

## References
- G. Cybenko, "Approximation by Superpositions of a Sigmoidal Function", *Mathematics of Control, Signals, and Systems*, 1989
- K. Hornik, M. Stinchcombe, H. White, "Multilayer feedforward networks are universal approximators", 1989
- K. Funahashi, "On the approximate realization of continuous mappings by neural networks", *Neural Networks*