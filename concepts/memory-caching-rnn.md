---
title: Memory Caching RNNs
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [classic-ai, neural-network, model, sequence-modeling]
sources: [raw/papers/2602.24281v1.md]
confidence: medium
---

# Memory Caching — RNNs with Growing Memory

## 개요

**Behrouz, Li (2025)**는 기존 RNN의 **고정된 hidden state 크기**의 한계를 극복하기 위해 **Growing Memory**를 도입한 **Memory Caching RNN** 메커니즘을 제안했다^[raw/papers/2602.24281v1.md].

## 문제: RNN의 메모리 용량 한계

전통적 RNN (LSTM, GRU)은 **고정된 차원의 hidden state** $h_t \in \mathbb{R}^d$ 만을 유지한다. 이는:
- **장기 의존성 포착에 불리** — 정보를 계속 덮어씀 (overwrite)
- **Transformer의 attention/SSM의 state space 모델과 경쟁 어려움**

## Memory Caching 아이디어

| 구성 요소 | 설명 |
|:--------|:------|
| **Cache memory** | 과거 hidden state를 저장하는 **동적 메모리 뱅크** |
| **쓰기(write)** | 새로운 정보가 중요하면 cache에 추가 |
| **읽기(read)** | 현재 입력과 유사한 cache 항목을 attention으로 검색 |
| **제거(eviction)** | cache가 가득 차면 덜 중요한 항목 제거 |

메모리 크기가 고정되지 않고 **시퀀스 길이에 따라 적응적으로 성장**할 수 있다는 점이 핵심이다.

## 기존 RNN과의 비교

| 방법 | 메모리 유형 | 메모리 크기 | 장기 의존성 |
|:---|:----------:|:----------:|:----------:|
| LSTM | Hidden state + cell state | 고정 ($d$) | 보통 |
| GRU | Hidden state | 고정 ($d$) | 제한적 |
| **Memory Caching RNN** | Hidden + **cache bank** | **가변** (시퀀스 길이에 비례 가능) | ✅ 우수 |
| Mamba (SSM) | State space | 고정 ($d$) | 우수 |
| Transformer | Key-value cache | 가변 (전체 시퀀스) | 최우수 |

## 융합 도메인 연결

- **대조군:** [[lstm-forget-gate]], [[gated-recurrent-units]]의 현대적 확장
- RNN 계열 아키텍처의 메모리 용량 확장 문제에 대한 새로운 접근
- [[linear-rnn-theory]] — 선형 RNN의 병렬화 이점과의 비교
- [[engram-sparse-memory]] — [[deepseek|DeepSeek]] Engram의 조건부 메모리와 유사한 방향

## References
- Behrouz, A. & Li, M. (2025). Memory Caching RNNs. arXiv:2602.24281.
- [[lstm-forget-gate]]
- [[gated-recurrent-units]]
