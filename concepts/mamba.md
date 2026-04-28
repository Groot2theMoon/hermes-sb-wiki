---
title: Mamba — Linear-Time Sequence Models with Selective SSMs
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, paper, benchmark]
sources: [raw/papers/2312.00752v2.md]
confidence: high
---

# Mamba: Linear-Time Sequence Modeling

**Mamba**는 Albert Gu와 Tri Dao (CMU/Princeton, 2023)가 제안한 **selective state space model (SSM)** 기반 아키텍처로, Transformer의 $O(n^2)$ 복잡도를 $O(n)$으로 줄이면서도 언어 모델링에서 Transformer와 동등하거나 더 나은 성능을 달성한다^[raw/papers/2312.00752v2.md].

- **선택적 SSM:** SSM 파라미터가 입력의 함수가 되어 content-based reasoning 가능
- **Hardware-aware 병렬 알고리즘:** recurrent mode에서도 효율적 학습
- Mamba-3B: 동일 크기 Transformer보다 우수, **2배 큰 Transformer와 동등 성능**
- 추론 처리량 Transformer 대비 **5배 향상**
- 언어, 오디오, 유전체 등 다양한 modality에서 SOTA
- [[transformer]]의 대안으로 주목받는 차세대 아키텍처
- [[transformer]] — Transformer (비교 대상)
- [[linear-rnn-theory]] — 선형 RNN 이론
