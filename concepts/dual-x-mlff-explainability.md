---
title: DUAL-X — Dual-Level Explainability Framework for Machine Learning Force Fields
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, physics-informed, training, materials, paper, surrogate-model]
sources: [raw/papers/12_What_is_Your_Force_Field_Re.md]
confidence: high
---

# DUAL-X: MLFF Explainability Framework

## 개요

Cao et al. (Johns Hopkins, 2024)이 제안한 **DUAL-X**는 분자 동역학용 Machine Learning Force Fields (MLFF)의 **dual-level XAI 프레임워크**로, 두 상호보완적 설명 수준을 통합한다.

## 두 가지 설명 수준

### Level 1: Model-Centric — Spatial Attribution (Where)

**Grad-CAM/Grad-CAM++** 기반의 공간적 어텐션 맵:
- "모델이 어디를 보고 있는가?"
- Dopant 주변 원자들의 중요도를 heatmap으로 시각화
- MACE (Multi-ACE) 모델의 multi-channel message passing 레이어에서 추출

### Level 2: Human-Centric — Physical Mechanism (What)

**SHAP-on-SOAP** 기반의 물리적 메커니즘 해석:
- "모델이 어떤 물리적 상호작용을 학습했는가?"
- SOAP (Smooth Overlap of Atomic Positions) descriptor의 각 component에 대한 SHAP value
- Dopant migration barrier에 기여하는 구체적 물리 메커니즘 (크기 효과, 전자구조, 격자 변형) 식별

## DUAL-X Workflow

```
1. MLFF 모델(MACE) 학습
2. Level 1: Grad-CAM으로 공간적 attribution map 추출
3. Level 2: SOAP descriptors 계산 + SHAP 분석
4. Dual-level 통합 해석
   ├─ Spatial: dopant 주변 원자 기여도 분포
   └─ Physical: migration barrier에 기여하는 구체적 메커니즘
```

## 핵심 발견 (MACE + dopant migration)

- Level 1 (Grad-CAM): 모델이 1차 이웃뿐만 아니라 **2-3차 이웃**까지 명시적으로 attend
- Level 2 (SHAP-on-SOAP): dopant migration barrier의 주 기여자는 **격자 변형(lattice distortion)**, 이차 기여자는 **전자구조 효과(charge transfer)**
- 기존 화학적 직관: "크기 효과(size effect)가 지배적" → **DUAL-X로 반증**: 크기 효과는 미미

## 의의

- **MLFF 블랙박스 문제 해결:** Force field 예측의 물리적 근거를 설명 가능
- **과학적 발견 도구:** XAI가 모델 검증을 넘어 새로운 물리적 통찰력(insight) 제공
- **도메인 일반성:** SOAP descriptor → 다른 분자 표현으로 확장 가능

## References

- [[dnn-interpretability-lrp]] — LRP 기반 신경망 해석
- [[xai-surveys]] — XAI 방법론 개관 (동일 raw file 참조)
- [[physics-informed-neural-networks]] — Physics-informed ML과의 해석 가능성 연결
- [[generative-models-physics]] — 물리 ML 모델 해석의 broader context
