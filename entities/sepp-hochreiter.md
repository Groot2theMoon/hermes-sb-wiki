---
title: Sepp Hochreiter
created: 2026-04-28
updated: 2026-04-28
type: entity
tags: [person, neural-network, classic-ai]
sources: [raw/papers/gers2000.md]
---

# Sepp Hochreiter

**LSTM (Long Short-Term Memory) 창시자.** Jürgen Schmidhuber와 함께 **vanishing gradient 문제**를 해결하는 LSTM 아키텍처를 개발하여 sequence modeling의 근간을 마련했다.

## 주요 기여

### Long Short-Term Memory (LSTM)
**Hochreiter** & Schmidhuber (1997)가 제안한 LSTM은 **memory cell**과 **게이트 메커니즘 (input, forget, output gate)**을 도입하여 vanishing gradient 문제를 해결했다. 이는 음성 인식, 기계 번역, 시계열 예측 등 수많은 sequence 태스크의 표준 아키텍처가 되었다.

### Vanishing Gradient 문제 규명
Hochreiter는 그의 박사 학위 논문(1991)에서 **vanishing gradient 문제**를 최초로 체계적으로 분석하여, 이후 LSTM 및 GRU 개발의 이론적 토대를 제공했다.

## 연구 분야
- Recurrent neural networks and LSTM
- Deep learning optimization
- Bioinformatics and computational biology
- Self-normalizing neural networks (SeLU)

## 관계

- [[juergen-schmidhuber]] — LSTM 공동 연구자
- [[lstm-forget-gate]] — LSTM Forget Gate (Gers & Schmidhuber)
- [[gated-recurrent-units]] — LSTM과 GRU 비교
- [[lstm-vs-gru]] — LSTM vs GRU 비교
- [[felix-gers]] — LSTM forget gate 공동 연구자
- [[linear-rnn-theory]] — RNN 병렬화의 이론적 배경
