---
title: Jürgen Schmidhuber
created: 2026-04-28
updated: 2026-04-28
type: entity
tags: [person, neural-network, classic-ai]
sources: []
confidence: high
---

# Jürgen Schmidhuber

**LSTM (Long Short-Term Memory)과 GRU의 핵심 요소를 창시한 독일의 컴퓨터 과학자.** Swiss AI Lab IDSIA의 공동 창립자이자 과학 책임자로, 순환 신경망(RNN)과 딥러닝의 기초를 닦았다.

## 주요 기여

### Long Short-Term Memory (LSTM)
Sepp Hochreiter와 함께 **LSTM 아키텍처**를 발명했다 (1997). Forget gate, input gate, output gate로 구성된 LSTM은 vanishing gradient 문제를 해결하여 장기 의존성을 학습할 수 있는 최초의 실용적 RNN이 되었다. 이후 Gers & Schmidhuber (2000)는 **forget gate**를 추가하여 LSTM을 완성했다^[raw/papers/gers2000.md].

### Gated Recurrent Unit (GRU)에 대한 기여
[[gated-recurrent-units]]는 LSTM을 단순화한 GRU 아키텍처가 등장하는 배경이 되었다. Schmidhuber 연구실의 LSTM 연구가 GRU의 update gate, reset gate 설계에 직접적 영향을 미쳤다.

### 기타 기여
- **초기 딥러닝:** 1990년대부터 매우 깊은 네트워크 학습 연구
- **Meta-learning:** 1990년대부터 gradient-based meta-learning 연구
- **Curiosity-driven exploration:** 강화학습에서 내재적 보상 개념 개척
- **컴퓨터 이론:** Gödel machine — self-referential optimal problem solver

## 관계

- [[gated-recurrent-units]] — GRU 및 LSTM 개념 이해
- [[lstm-forget-gate]] — Forget gate 논문 상세
- [[transformer]] — LSTM 이후 sequence modeling의 지배적 패러다임
- [[mamba]] — LSTM의 효율성을 계승한 최신 SSM 기반 모델
