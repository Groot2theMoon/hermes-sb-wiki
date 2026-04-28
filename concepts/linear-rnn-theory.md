---
title: Linear RNN Parallelization Theory
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, neural-network, model]
sources: [raw/papers/2603.03612v2.md]
confidence: high
---

# Why Linear RNNs Are More Parallelizable

Merrill, Jiang, Li, Lin, Sabharwal (2025)는 **선형 RNN**이 기존 비선형 RNN보다 병렬화에 유리한 이유를 이론적으로 분석했다^[raw/papers/2603.03612v2.md].

- **대조군:** [[gated-recurrent-units]] → [[mamba]] (선형 RNN/S6)의 이론적 연결고리
- 선형 RNN의 표현력 한계와 병렬화 이점 간의 trade-off 분석