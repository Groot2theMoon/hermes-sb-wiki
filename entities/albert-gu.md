---
title: Albert Gu
created: 2026-04-28
updated: 2026-04-28
type: entity
tags: [person, neural-network, model]
sources: [raw/papers/2312.00752v2.md]
---

# Albert Gu

**Mamba (Selective State Space Model) 공동 창시자.** CMU Machine Learning Department에서 박사 학위를 받았으며, 현재 **Cartesia AI**에서 활동. Structured State Space Model (S4) 계열의 주요 연구자.

## 주요 기여

### Mamba
Gu와 Tri Dao (CMU/Princeton, 2023)가 제안한 [[mamba]]는 **selective SSM** 기반 아키텍처로, Transformer의 $O(n^2)$ 복잡도를 $O(n)$으로 줄이면서도 동등하거나 더 나은 성능을 달성했다. Mamba-3B는 같은 크기 Transformer를 능가하고, 2배 큰 Transformer와 동등한 성능을 보였다.

### Structured State Spaces (S4)
Gu는 이전에 **S4 (Structured State Space Sequence Model)**를 통해 선형 시간 복잡도를 가진 sequence 모델의 가능성을 입증했다. S4는 HiPPO 프레임워크와 결합하여 장기 의존성을 포착한다.

### 연구 분야
- Efficient sequence modeling
- State space models for deep learning
- Long-range dependencies in sequences
- Hardware-aware algorithm design

## 관계

- [[mamba]] — Gu의 대표 업적
- [[transformer]] — Mamba의 비교/대체 대상
- [[linear-rnn-theory]] — Mamba의 이론적 배경
- [[engram-sparse-memory]] — Mamba와 유사한 효율적 시퀀스 모델링