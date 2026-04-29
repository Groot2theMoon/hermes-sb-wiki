---
title: "Causal XAI — SAM vs SLIC Segmentation Trade-Off"
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [classic-ai, model, benchmark, paper, comparison]
sources: [raw/papers/53_Causal_Quantification_of_th.md]
confidence: medium
---

# Causal Validation of Semantic XAI: SAM vs SLIC

## 개요

Bhandarkar (2025)는 semantic XAI 파이프라인에서 **SAM (object-aware)** 과 **SLIC (texture-aware)** segmentation의 sensitivity-reliability trade-off를 정량적으로 분석한다. Grad-CAM + CLIP + counterfactual blur masking으로 causal impact를 측정.

## 핵심 아이디어

### 4-Stage Semantic Attribution Pipeline
1. **Saliency:** Grad-CAM으로 ResNet-50의 예측 관련 영역 식별
2. **Segmentation:** SAM (object masks) vs SLIC (superpixels)
3. **Concept Labeling:** CLIP으로 각 region의 semantic concept 식별
4. **Causal Validation:** blur masking counterfactual → confidence drop 측정

### Sensitivity-Reliability Trade-Off

| Metric | SAM (Object-aware) | SLIC (Texture-aware) |
|:---|---:|---:|
| Mean causal impact | **81.0%** confidence drop | 37.7% |
| Reliability | 90.5% (181/200) | **100%** (200/200) |
| Variance | 높음 | 낮음 |

### 실용적 권고
- **SLIC:** high-stakes, texture-reliant tasks (의료 진단) — robustness 우선
- **SAM:** object-centric 현상 탐색적 분석 — sensitivity 우선

## 의의
- "RED XAI" (scientific discovery) 관점에서 segmentation 선택의 정량적 지침
- Correlational이 아닌 **causal** validation으로 설명의 신뢰성 확보

## 융합 도메인 연결
- [[xai-surveys]] — XAI 방법론 일반
- [[dnn-interpretability-lrp]] — LRP 기반 대안적 접근
- [[dual-x-mlff-explainability]] — MLFF explainability
