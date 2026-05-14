---
title: The Platonic Universe — Do Foundation Models See the Same Sky?
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [theory, benchmark, model, computer-vision]
sources: [raw/papers/NeurIPS_ML4PS_2025_87.md]
confidence: medium
---

# Platonic Universe: Representational Convergence of Foundation Models

Platonic Representation Hypothesis (PRH)를 천문학 데이터로 검증 — 서로 다른 아키텍처와
데이터로 훈련된 foundation model들이 동일한 물리적 현실의 표현으로 수렴하는지 측정.

## 개요

- **저자:** Duraphe, Smith, Sourav, Wu et al. (UniverseTBD)
- **NeurIPS ML4PS 2025 Workshop**
- **핵심 질문:** "충분히 큰 neural network는 어떤 데이터/아키텍처로 훈련하든 동일한 Platonic representation으로 수렴하는가?"
- **측정:** Mutual $k$-Nearest Neighbour (MKNN) metric

## 실험 설계

**데이터:** JWST, HSC, Legacy Survey, DESI (이미지 + 분광)
**모델:** ViT, ConvNeXtv2, DINOv2, IJEPA, AstroPT, Specformer (6개 아키텍처)

두 가지 alignment 측정:
- **Intramodal:** 동일 modality에서 다른 크기의 동일 아키텍처 간 MKNN
- **Crossmodal:** 다른 modality 간 동일 아키텍처의 MKNN

## 결과

- 일반적으로 model capacity 증가에 따라 representational alignment 증가 (PRH 지지)
- Cross-modal alignment는 intramodal보다 낮지만, 큰 모델에서 수렴 경향
- 천문학 도메인 foundation model도 general-purpose 사전훈련 모델로 충분히 가능

## AI×Mechanics 관점

- PRH는 AI×Mechanics에서도 중요한 함의: ImageNet 사전훈련 모델의 representation이 기계공학/물리 데이터에도 전이 가능한가?
- MKNN metric은 서로 다른 물리 모델/시뮬레이터의 embedding space 비교에 적용 가능
- 다양한 물리 modality (이미지, 시계열, field data) 간 공통 표현 학습의 이론적 근거

## 관련 페이지

- [[i-jepa]] — JEPA 아키텍처
- [[bert]] — Foundation model pre-training
- [[agent-scaling]] — Model scaling 연구
