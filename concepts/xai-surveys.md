---
title: XAI — Explaining DNN Predictions (Survey)
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [classic-ai, benchmark, survey, paper]
sources: [raw/papers/1-s2.0-S1051200417302385-main.md, raw/papers/1708.08296v1.md]
confidence: medium
---

# Explainable AI (XAI): Explaining DNN Predictions

## 개요

설명 가능한 AI (XAI)는 딥러닝 모델의 **예측을 해석 가능한 형태로 설명**하는 연구 분야이다. 다양한 XAI 방법이 제안되었으며, 이 문서는 주요 접근법을 개괄한다.

## 주요 XAI 방법 분류

### 1. Feature Attribution (특징 중요도)

| 방법 | 원리 | 특징 |
|:---|:----|:----|
| **Saliency Map** | 입력 gradient | 단순하지만 노이즈에 민감 |
| **Grad-CAM** | 마지막 Conv layer의 gradient | 공간 정보 보존 |
| **Integrated Gradients** | 기준점부터 입력까지 gradient 경로 적분 | axiomatic (sensitivity, implementation invariance) |
| **LRP (Layer-wise Relevance Propagation)** | 출력에서 입력으로 relevance 역전파 | 생물학적 타당성 |
| **SHAP** | Shapley value 기반 | 이론적 기반 강력, 계산 비용 높음 |
| **LIME** | 국소적 surrogate 모델 | 모델 비의존적 |

### 2. Concept-Based Explanation

- **TCAV (Testing with Concept Activation Vectors):** 고수준 개념(줄무늬, 둥근 모양 등)이 예측에 미치는 영향 측정
- **Network Dissection:** 각 뉴런이 인코딩하는 개념 식별

### 3. Example-Based Explanation

- **Counterfactual:** "입력 X의 어떤 특징을 바꾸면 예측이 바뀌는가?"
- **Prototype:** 학습 데이터 중 가장 유사한 예시 제시

## XAI vs Uncertainty

| 차원 | XAI | Uncertainty Quantification |
|:---|:----:|:------------------------:|
| **질문** | "왜 이 예측을 했나?" | "이 예측을 얼마나 신뢰할까?" |
| **출력** | 특징 중요도, 개념 | 분산, 신뢰구간 |
| **방법** | Saliency, LRP, SHAP | MC Dropout, Ensemble |
| **결합** | UQ + XAI → 신뢰할 수 있는 설명 | 설명 + 불확실성 |

## 융합 도메인 연결

- [[dnn-interpretability-lrp]] — LRP 방법의 상세
- **PINN/DMN의 예측 설명:** 어떤 물리 법칙/재료 특성이 예측에 가장 영향을 미치는지 분석
- [[uncertainty-quantification-deep-learning]] — UQ와 XAI의 결합

## Foundational Tutorial: Montavon et al. (2017)

Montavon, Samek & Müller (TU Berlin, 2017)의 *Methods for interpreting and understanding deep neural networks*는 DSP 저널에 게재된 **tutorial 논문**으로, DNN interpretability 분야의 대표적 입문 자료다^[raw/papers/1-s2.0-S1051200417302385-main.md]. 주요 기여:

- **Activation Maximization**: 특정 뉴런/클래스를 최대한 활성화하는 입력 패턴 생성
- **Sensitivity Analysis**: 입력 perturbation에 대한 출력 변화 분석 (gradient 기반)
- **Taylor Decomposition**: 테일러 급수를 이용한 relevance 분해 (LRP의 수학적 기반)
- **LRP (Layer-wise Relevance Propagation)**: 출력에서 입력 방향으로 relevance를 보존하며 역전파 — 당시 SOTA interpretability 방법으로 평가됨

Montavon et al.은 *post-hoc interpretability* (이미 학습된 모델을 사후 해석)에 초점을 두며, interpretability를 모델 구조에 통합하는 접근과 구별한다. 이 논문은 이후 LRP 계열 방법론의 표준 reference가 되었다.

## References
- Montavon, G., Samek, W., & Müller, K.-R. (2017). Methods for interpreting and understanding deep neural networks. *Digital Signal Processing*, 73, 1–15. ^[raw/papers/1-s2.0-S1051200417302385-main.md]
- Samek, W. et al. (2017). Explainable AI: Interpreting, Explaining and Visualizing Deep Learning. Springer.
- [[dnn-interpretability-lrp]]
- [[xai-surveys]]
