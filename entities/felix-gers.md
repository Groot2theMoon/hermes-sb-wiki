---
title: Felix Gers
created: 2026-04-28
updated: 2026-04-28
type: entity
tags: [person, neural-network, classic-ai]
sources: [raw/papers/gers2000.md]
---

# Felix Gers

**LSTM Forget Gate 공동 창시자.** Jürgen Schmidhuber와 함께 LSTM에 **forget gate**를 도입하여 장기 의존성 학습을 획기적으로 개선했다.

## 주요 기여

### LSTM Forget Gate
**Gers** & Schmidhuber (2000)가 제안한 forget gate는 LSTM memory cell에서 **어느 정보를 버릴지 학습**하는 메커니즘이다:

$$f_t = \sigma(W_f \cdot [h_{t-1}, x_t] + b_f)$$

이 간단한 추가로 LSTM은 "continual prediction" 문제를 해결하고, 가변 길이의 입력을 처리할 수 있게 되었다.

### 연구 분야
- Recurrent neural networks
- LSTM extensions and improvements
- Continual learning and long-term dependencies

## 관계

- [[juergen-schmidhuber]] — LSTM forget gate 공동 연구자
- [[sepp-hochreiter]] — LSTM 원조 창시자
- [[lstm-forget-gate]] — Gers의 대표 업적 개념 페이지
- [[gated-recurrent-units]] — LSTM 발전의 맥락
