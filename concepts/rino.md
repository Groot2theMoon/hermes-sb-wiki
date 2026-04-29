---
title: RINO — Renormalization Group Invariance with No Labels
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, physics-informed, learning, paper, survey]
sources: [raw/papers/NeurIPS_ML4PS_2025_81.md]
confidence: medium
---

# RINO: Renormalization Group Invariance with No Labels

## 개요

**RINO (Renormalization group Invariance with NO labels)**는 Caltech, Fermilab, UCSD 연구진이 NeurIPS ML4PS 2025에 발표한 자기지도학습(SSL) 방법이다. 고에너지 물리학(HEP)의 제트(jet) 식별 문제에서 **시뮬레이션-실험 간 domain shift**를 완화하기 위해 제안되었다.

## 핵심 아이디어

- **재규격화군(Renormalization Group) 불변성**을 SSL pretext task로 활용
- 제트를 서로 다른 에너지 스케일로 clustering하여 **다양한 "view"** 생성
- DINO (self-distillation with no labels) 아키텍처를 변형 — teacher-student 구조로 서로 다른 RG 스케일의 임베딩을 정렬
- 시뮬레이션 레이블 없이 **실험 데이터 자체로 pretrain** 가능

## 방법론

1. JETCLASS 데이터셋에서 QCD 제트로 **RINO pretraining** (SSL)
2. JETNET 데이터셋(시뮬레이션)에서 **top tagging fine-tuning**
3. JETCLASS(실험 데이터)로 **domain shift 평가**

| 구성 | 설명 |
|:---|:------|
| Backbone | Transformer 기반 jet encoder |
| SSL 방식 | DINO 변형 — 서로 다른 RG 스케일이 동일한 임베딩을 갖도록 학습 |
| RG view 생성 | 제트 입자를 다양한 clustering depth로 그룹화 |
| 평가 과제 | Top quark jet tagging |

## 의의

- **SSL + 물리학 불변성**의 결합: RG invariance를 SSL objective로 사용한 최초 사례 중 하나
- **Sim-to-real domain shift** 문제에 대한 실용적 접근 — HEP 외에도 다양한 과학 분야로 확장 가능
- 제한된 레이블 데이터로도 robust한 모델 학습 가능

## 융합 도메인 연결

- [[physics-informed]] — 물리 법칙을 학습에 활용하는 일반적 프레임워크
- [[sim-to-real]] — 시뮬레이션-실험 차이 완화
- [[self-supervised-learning]] — 레이블 없이 표현 학습 (링크 필요 시 생성)

## References
- Hao, Kansal, Sun, Spiropulu et al. "RINO: Renormalization Group Invariance with No Labels." NeurIPS ML4PS 2025.
- [[physics-informed]]
