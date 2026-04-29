---
title: JEPA — Joint-Embedding Predictive Architecture
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [classic-ai, model, computer-vision, paper]
sources: [raw/papers/2603.19312v2.md]
confidence: medium
---

# LeWorldModel: JEPA for World Models

## 개요

**Maes, Le Lidec, Scieur, LeCun, Balestriero** (Mila / NYU / Brown, 2025)는 **Joint-Embedding Predictive Architecture (JEPA)**를 활용한 end-to-end world model인 **LeWorldModel**을 제안했다^[raw/papers/2603.19312v2.md]. JEPA의 핵심 특징은 **data augmentation이 불필요**하다는 점이다.

## JEPA의 핵심 아이디어

일반적인 generative model (예: VAE, diffusion)은 입력 $x$를 직접 재구성(reconstruct)하는 반면, **JEPA는 입력 $x$와 $y$의 joint embedding 공간에서 예측**한다:

$$ \text{JEPA: } \min \| \text{Enc}_y(y) - \text{Pred}(\text{Enc}_x(x)) \|^2 $$

| 특징 | Generative Model | JEPA |
|:---|:--------------:|:----:|
| **예측 대상** | 픽셀 $x$ 자체 | Embedding $s_y = \text{Enc}_y(y)$ |
| **Data aug 필요** | ✅ 필요 | ❌ **불필요** |
| **추상화 수준** | 낮음 (픽셀 단위) | 높음 (의미 단위) |
| **계산 효율** | 낮음 (고차원 예측) | 높음 (저차원 예측) |
| **대표 모델** | VAE, Diffusion | I-JEPA, LeWorldModel |

## LeWorldModel

- JEPA를 **물리 세계 모델링**에 적용
- 입력: 이미지/상태 시퀀스 → 출력: 미래 상태의 embedding 예측
- **Data augmentation 없이도** 좋은 world representation 학습
- 강화 학습/제어 작업에서 시뮬레이션 예측 성능 향상

## 융합 도메인 연결

- **대조군:** [[i-jepa]]와 동일 JEPA 계열
- 물리 시뮬레이션 **world model의 기준** — 추후 Sim-to-Real 연구의 baseline
- [[unsupervised-phase-transitions]] — 비지도 물리 학습과의 방법론적 연결
- [[jepa-world-models]] → [[physics-informed]] 접근과의 비교

## References
- Maes, F. et al. (2025). LeWorldModel: JEPA for World Models. arXiv:2603.19312.
- [[i-jepa]]
- [[unsupervised-phase-transitions]]
