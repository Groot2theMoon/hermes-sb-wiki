---
title: Uncertainty Quantification in Deep Learning — A Review
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, training, inference, benchmark, paper, comparison]
sources: [raw/papers/2011.06225v4.md]
confidence: high
---

# Uncertainty Quantification in Deep Learning

## 개요

Moloud Abdar et al.의 종설 논문으로, 딥러닝에서의 **불확실성 정량화(UQ) 방법론**을 포괄적으로 검토한다^[raw/papers/2011.06225v4.md]. Bayesian 근사, 앙상블 학습, MC Dropout 등 주요 UQ 기법을 체계적으로 분류하고, 컴퓨터 비전, 의료 영상, 자연어 처리, 강화학습 등 응용 분야에서의 적용을 분석한다.

## 불확실성의 두 유형

### Aleatory Uncertainty (데이터 불확실성)
- 데이터 내재적 노이즈/변동성
- **Irreducible**: 데이터가 많아도 줄일 수 없음
- 확률분포(PDF)로 모델링

### Epistemic Uncertainty (지식 불확실성)
- 모델/지식 부족으로 인한 불확실성
- **Reducible**: 데이터/지식 추가 시 감소
- 구간 또는 belief distribution으로 모델링

## 주요 UQ 기법

### 1. Bayesian Neural Networks (BNNs)
- 가중치에 사전 분포(prior) 부여
- 장점: 원칙적 불확실성 추정
- 단점: 계산 비용 높음, 확률론적 추론 어려움

### 2. Monte Carlo Dropout
- Dropout을 추론 시에도 유지 (test-time dropout)
- 여러 stochastic forward pass로 불확실성 추정
- 장점: 구현 간단, 기존 모델에 쉽게 적용

### 3. Deep Ensembles
- Multiple deterministic NNs with random initialization
- Adversarial training smoothness
- [[deep-ensembles]] 참조

### 4. Gaussian Mixture Models (GMMs)
- 출력 분포를 가우시안 혼합으로 모델링

### 5. Out-of-Distribution (OoD) Detection
- 학습 데이터와 다른 분포의 입력 감지

## 응용 분야

| 분야 | 적용 |
|------|------|
| 자율주행 | 객체 탐지 불확실성 |
| 의료 영상 | 분류/분할 신뢰도 |
| NLP | 텍스트 분류, recidivism risk |
| 강화학습 | 가치 함수 불확실성 |

## References

- M. Abdar et al., "A Review of Uncertainty Quantification in Deep Learning: Techniques, Applications and Challenges", *Information Fusion* 2021
- [[bayesian-uncertainty-vision]] — Aleatoric vs Epistemic (Kendall & Gal)
- [[deep-ensembles]] — Deep Ensembles 방법
- [[vvuq-framework]] — 과학 컴퓨팅 VV&UQ 프레임워크