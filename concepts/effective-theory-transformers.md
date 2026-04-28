---
title: Effective Theory of Transformers at Initialization
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, training, inference, paper]
sources: [raw/papers/2304.02034v1.md]
confidence: high
---

# Effective Theory of Transformers at Initialization

## 개요

Emily Dinan, Sho Yaida, Susan Zhang (Meta AI)는 넓고 깊은 **Transformer**에서 **순방향 및 역방향 신호 전파(signal propagation)**의 **effective-theory 분석**을 수행하고, 이론적 제안을 실제 Vision 및 Language Transformer 훈련에서 검증한다^[raw/papers/2304.02034v1.md].

## 핵심 아이디어

### In-Depth Analysis Framework

Part I에서 Transformer의 각 구성 요소에 대한 이론적 분석:

1. **§I 0**: Transformer crash course (Stem, LayerNorm, MHSA, MLP, Head)
2. **§I 1**: 초기화 시 preactivation 통계 계산 → **초기화 하이퍼파라미터 스케일링** 결정
3. **§I 2**: Neural Tangent Kernel (NTK) crash course
4. **§I 3**: Squared gradient의 통계적 평균 계산 → **학습률 스케일링** 결정 (SGD 및 AdamW)

### 주요 결과

| 분석 항목 | 결정되는 하이퍼파라미터 |
|----------|----------------------|
| Preactivation 통계 | Initialization 스케일링 (수식 1.25–1.33) |
| Gradient 통계 (SGD) | Group-wise learning rate 스케일링 (수식 1.99–1.107) |
| Gradient 통계 (AdamW) | Group-wise learning rate 스케일링 (수식 1.108–1.116) |

### Part II: 실험적 검증

- **Image Classification** with Encoder-Only Transformers (ViT)
- **Span Denoising** with Encoder-Decoder Transformers
- 다양한 스케일링 전략 비교

## 관련 개념

- [[transformer]] — Transformer 아키텍처의 기본 개념
- [[i-jepa]] — Self-supervised learning with ViT
- **Neural Tangent Kernel (NTK)** — 무한 넓이 신경망의 이론적 도구
- **Signal Propagation Theory** — 초기화 및 학습 역학 분석