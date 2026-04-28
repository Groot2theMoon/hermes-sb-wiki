---
title: LSTM Forget Gate (Gers & Schmidhuber)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, neural-network]
sources: [raw/papers/gers2000.md]
confidence: high
---

# LSTM with Forget Gate

[[felix-gers|Felix Gers]] & [[juergen-schmidhuber|Jürgen Schmidhuber]] (2000)는 **forget gate**를 LSTM에 추가하여 "continual prediction" 문제를 해결했다^[raw/papers/gers2000.md]. (원조 LSTM은 [[sepp-hochreiter|Hochreiter]] & Schmidhuber, 1997.)

- **대조군:** 고전 RNN의 기준 — GRU, Transformer 등 최신 아키텍처의 출발점
- [[gated-recurrent-units]]에서 GRU/LSTM 비교의 이론적 토대
- forget gate: $f_t = \sigma(W_f \cdot [h_{t-1}, x_t] + b_f)$ — 기존 memory의 삭제 정도 학습
- [[gated-recurrent-units]] — GRU vs LSTM 비교
