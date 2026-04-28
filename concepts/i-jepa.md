---
title: I-JEPA — Image-based Joint-Embedding Predictive Architecture
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, training, inference, benchmark, paper]
sources: [raw/papers/2301.08243v3.md]
confidence: high
---

# I-JEPA — Image-based Joint-Embedding Predictive Architecture

## 개요

Mahmoud Assran, Quentin Duval, Ishan Misra, Piotr Bojanowski, Pascal Vincent, Michael Rabbat, Yann LeCun, Nicolas Ballas (Meta AI — FAIR)가 2023년에 제안한 **I-JEPA**는 **self-supervised learning** 접근법으로, 수작업 데이터 증강(hand-crafted data augmentation) 없이 고수준 의미론적 이미지 표현을 학습한다^[raw/papers/2301.08243v3.md].

## 핵심 아이디어

### 비생성적(non-generative) 예측 아키텍처

I-JEPA의 기본 아이디어는 단순하다: **동일 이미지 내 하나의 context block에서 여러 target block의 표현(representations)을 예측**한다.

### 중요 설계 선택: 마스킹 전략

의미론적 표현 학습을 위해 두 가지 마스킹 전략이 중요:

1. **(a) 충분히 큰 스케일의 target block 샘플링** — 의미론적(semantic) 정보 포착
2. **(b) 충분히 정보량이 많은 (공간적으로 분산된) context block 사용**

### 확장성

- **Vision Transformer (ViT)** 기반 구현
- ViT-Huge/14를 ImageNet에서 **16 A100 GPU**로 **72시간 이내**에 훈련
- 강력한 downstream 성능 달성
- 생성적 방법(MAE 등)과 달리 pixel-level 복원 불필요

## 관련 개념

- [[transformer]] — I-JEPA의 백본 아키텍처 (ViT)
- **Self-Supervised Learning** — 레이블 없는 학습 패러다임
- **Vision Transformer (ViT)** — 이미지 처리용 Transformer
- **Masked Autoencoder (MAE)** — 생성적 self-supervised learning의 대표적 방법
- **Joint-Embedding Architecture** — Yann LeCun의 self-supervised learning 프레임워크
- [[jepa-world-models]] — JEPA 기반 World Model
