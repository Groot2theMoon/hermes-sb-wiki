---
title: Deep Learning (Nature 2015 Survey)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, neural-network, survey, landmark-paper]
sources: [raw/papers/Lecun2015.md]
confidence: high
---

# Deep Learning — Nature Survey

## 개요

LeCun, Bengio, Hinton (2015)이 Nature에 발표한 리뷰 논문으로, **딥러닝 전체 분야를 정의한 가장 인용된 논문 중 하나**이다 (50,000+ 인용). CNN, RNN, supervised pre-training, DBM 등 2015년까지의 딥러닝 방법론을 체계적으로 정리하고, **계층적 표현 학습(hierarchical representation learning)**의 원리를 설명한다^[raw/papers/Lecun2015.md].

## 핵심 메시지

### 딥러닝의 정의
> "Deep learning allows computational models that are composed of **multiple processing layers** to learn representations of data with **multiple levels of abstraction**."

이는 기존의 수작업 feature engineering에서 벗어나, **데이터로부터 자동으로 계층적 특징을 학습**하는 패러다임 전환을 의미한다.

### 논문이 정립한 딥러닝의 세 축

| 축 | 대표 방법 | 기여자 |
|----|----------|-------|
| **합성곱 신경망 (CNN)** | LeNet-5 → AlexNet | [[yann-lecun]] |
| **순환 신경망 (RNN)** | LSTM, GRU | [[yoshua-bengio]] |
| **비지도 사전학습** | DBN, DBM, Autoencoder | [[geoffrey-hinton]] (당시) |

### 주요 기술적 내용

1. **CNN의 핵심 원리**: local connectivity, weight sharing, pooling — translation invariance를 자연스럽게 달성
2. **RNN의 vanishing gradient**: [[sepp-hochreiter]]의 LSTM과 [[juergen-schmidhuber]]의 연구로 극복
3. **Supervised pre-training의 발견**: layer-wise pre-training이 deep network 최적화에 효과적임을 실증 (Hinton et al., 2006)

## 역사적 의의

| 측면 | 설명 |
|------|------|
| **분야 정의** |딥러닝을 단일 학문 분야로 규정하고 CNN/RNN/Autoencoder를 통합적 프레임워크로 제시 |
| **과학계 확산** | Nature 게재로 물리학/생물학/의학 등 **타 분야 연구자에게 딥러닝을 소개** |
| **융합 연구의 기폭제** | 이 리뷰 이후 PINN, FNO 등 **Physics-Informed ML** 연구 폭발적 증가 |

## 융합 도메인과의 연결

| Nature Survey 개념 | 융합 도메인 파생 |
|-------------------|----------------|
| CNN 표현 학습 | PINN의 **physics feature extraction** |
| RNN sequence 모델링 | **DeepONet의 branch net** (함수 시퀀스 인코딩) |
| Backpropagation | **PDE-constrained optimization의 adjoint method**와 동일 원리 |
| Unsupervised pre-training | **Physics-Constrained Surrogate** — 레이블 없이 물리 법칙만으로 학습 |

## References

- Y. LeCun, Y. Bengio, G. Hinton. "Deep Learning", *Nature*, 2015
- [[lenet-5]] — [[yann-lecun]]의 CNN 원형 (LeNet-5)
- [[gated-recurrent-units]] — RNN 계열의 발전
- [[residual-networks]] — Survey 이후 등장한 핵심 혁신 (2015)
- [[variational-autoencoder]] — Survey의 vae 관련 확장
- [[deep-learning-nature-survey]] — 본 문서 (상위 참조)
