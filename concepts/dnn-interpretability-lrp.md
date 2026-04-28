---
title: DNN Visualization & Interpretability (LRP)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [neural-network, training, inference, benchmark, paper]
sources: [raw/papers/1509.06321v1.md]
confidence: high
---

# DNN Visualization & Layer-wise Relevance Propagation (LRP)

## 개요

DNN은 뛰어난 성능에도 불구하고 **블랙박스(black box)**라는 한계가 있다. Samek et al. (2015)는 DNN의 의사결정을 시각화/해석하는 여러 방법을 평가하고, **Layer-wise Relevance Propagation (LRP)**이 가장 우수함을 정량적으로 입증했다^[raw/papers/1509.06321v1.md].

## 핵심 아이디어

### Heatmap 기반 시각화
- 각 pixel의 분류 결정에 대한 **중요도(importance)**를 heatmap으로 표현
- 직관적으로 "이 이미지의 어느 부분이 결정에 기여했는가?"를 시각화

### 평가 방법: Region Perturbation
- Pixel importance 순서대로 pixel을 제거(perturbation)
- 제거 시 분류 정확도 하락이 클수록 좋은 heatmap
- 정량적이고 객관적인 평가 가능

### 비교된 방법
1. **LRP (Layer-wise Relevance Propagation):** 출력에서 입력으로 relevance를 역전파
2. Sensitivity Analysis: 출력의 입력에 대한 gradient 기반
3. Simple Taylor Decomposition: Taylor expansion 기반

### LRP의 우수성
- **SUN397, ILSVRC2012, MIT Places** 데이터셋에서 LRP가 qualitative/quantitative 모두 우수
- 전파 규칙: 각 뉴런의 출력 relevance를 입력 뉴런에 분배 (conservation law)
- $R_j = \sum_k \frac{a_j w_{jk}}{\sum_j a_j w_{jk}} R_k$

## 영향
- XAI (eXplainable AI) 분야의 초기 중요한 연구
- 이후 Grad-CAM, Integrated Gradients, SHAP 등 발전의 계기
- Safety-critical applications (자율주행, 의료)에서 필수적

## References
- W. Samek, A. Binder, G. Montavon, S. Bach, K.-R. Müller. "Evaluating the visualization of what a Deep Neural Network has learned", *IEEE TNNLS 2017'
- S. Bach et al. "On Pixel-Wise Explanations for Non-Linear Classifier Decisions by Layer-wise Relevance Propagation", *PLoS ONE 2015'
- [[xai-surveys]] — XAI 참고 문헌 종합
- [[bayesian-uncertainty-vision]] — 불확실성 시각화