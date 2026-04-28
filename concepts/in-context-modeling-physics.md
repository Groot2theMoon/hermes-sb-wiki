---
title: In-Context Modeling (ICM) for Computational Science
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, surrogate-model, model, paper]
sources: [raw/papers/trending/2026-04-28-02.md]
confidence: medium
---

# In-Context Modeling (ICM) for Computational Science

## 개요

**In-Context Modeling (ICM)**은 Li, Li, Li, Zhan, Gao, Chen, Yang (2026)이 제안한 **재학습 없이(retrain-free) 물리 시스템 일반화**를 가능하게 하는 새로운 패러다임이다^[raw/papers/trending/2026-04-28-02.md]. 기존 surrogate model이 각 물리 시스템마다 재학습이 필요한 반면, ICM은 **관측장(observational fields)을 물리적 맥락(context)으로 직접 주입**하여 단일 forward pass로 추론을 수행한다.

## 핵심 아이디어

| 요소 | 설명 |
|------|------|
| **파라미터 미고정** | 시스템별 행동을 고정 파라미터에 인코딩하지 않음 |
| **물리적 맥락 주입** | 측정 데이터를 physical context로 직접 사용 |
| **단일 forward pass 추론** | 새 시스템에 대해 재학습 없이 즉시 추론 |
| **Physics-informed 학습** | 지배 방정식을 활용한 label-free 훈련 |
| **Foundation model scaling** | 데이터 다양성과 연산 예산 증가에 따른 성능 향상 |

## 기존 접근법과의 차별성

기존 [[physics-constrained-surrogate]] 및 [[fourier-neural-operator]]는 각 PDE 계열이나 물리 파라미터에 대해 학습된 가중치에 의존한다. ICM은 이를 **in-context inference**로 대체하여:

- 미지의 재료(material), 형상(geometry), 하중 조건(loading condition)에 **즉시 일반화**
- 유한요소 해석(FEM)과 통합 가능
- 실험적 전역 변위장 데이터로 검증 완료 (hyperelasticity 문제)

이는 대규모 언어 모델(LLM)의 in-context learning(In-Context Learning) 패러다임을 물리 시뮬레이션에 도입한 것으로 볼 수 있다.

## Foundation Model으로의 확장 가능성

ICM의 가장 중요한 특성은 **scaling behavior**이다:
- 데이터 다양성 증가 → 성능 향상
- 연산 예산 증가 → 정확도 향상
- → **Foundation model for computational science** 로의 발전 가능성 제시

## 융합 도메인 의미

- AI × Mechanics 융합에서 **general-purpose surrogate model**의 새 지평
- 기존 [[physics-informed]] 패러다임을 in-context 학습으로 확장
- 다양한 물리 시스템(탄성, 유체, 열전달 등)에 단일 모델로 대응 가능
- retrain-free 특성은 **digital twin** 및 **real-time 제어** 응용에 이상적

## References
- Li et al., "In-context modeling as a retrain-free paradigm for foundation models in computational science", *arXiv:2604.23098*, 2026
- [[physics-informed]] — 물리 기반 ML 패러다임
- [[fourier-neural-operator]] — Operator learning의 기존 접근법
- [[transformer]] — In-context learning의 기반 Transformer
