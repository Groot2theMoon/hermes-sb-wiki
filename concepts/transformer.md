---
title: Transformer Architecture
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, paper, benchmark]
sources: [raw/papers/1706.03762v7.md]
confidence: high
---

# Transformer ("Attention Is All You Need")

## 개요

**Transformer**는 Vaswani et al. (Google Brain, 2017)이 제안한 아키텍처로, **RNN이나 CNN을 전혀 사용하지 않고 오직 attention mechanism만으로** sequence transduction을 수행한다^[raw/papers/1706.03762v7.md]. WMT 2014 영어→독일어 번역에서 BLEU 28.4로 기존 최고 기록 갱신.

## 핵심 아이디어

### Scaled Dot-Product Attention
$$\text{Attention}(Q, K, V) = \text{softmax}\left(\frac{QK^T}{\sqrt{d_k}}\right)V$$

- $Q$ (Query), $K$ (Key), $V$ (Value) — DB 검색에 비유
- $\sqrt{d_k}$ 로 scaling: 큰 $d_k$에서 softmax gradient 소멸 방지

### Multi-Head Attention
- 8개 head가 서로 다른 representation subspace에서 병렬 attention
- 각 head: $d_k = d_v = d_{\text{model}}/h = 64$
- 단일 head보다 다양한 관계 포착 가능

### 구조
- **인코더:** 6개 레이어, 각 레이어: Multi-Head Self-Attention + FFN (Residual + LayerNorm)
- **디코더:** 6개 레이어, Masked Self-Attention + Encoder-Decoder Attention + FFN
- **Positional Encoding:** Sinusoidal 함수로 위치 정보 주입 (RNN 없이 순서 표현)

### 장점 (vs RNN/CNN)
| 특성 | RNN | CNN | Transformer |
|------|-----|-----|-------------|
| 병렬화 | $O(n)$ 순차 | $O(1)$ | $O(1)$ |
| 최대 경로 길이 | $O(n)$ | $O(\log_k n)$ | $O(1)$ |
| 복잡도/레이어 | $O(n \cdot d^2)$ | $O(k \cdot n \cdot d^2)$ | $O(n^2 \cdot d)$ |

## 성능

| Task | BLEU | 학습 시간 |
|------|------|----------|
| WMT 2014 EN-DE | **28.4** (ensemble 포함 모든 이전 기록 갱신) | 3.5일 (8×P100) |
| WMT 2014 EN-FR | **41.8** (single model SOTA) | 3.5일 |

## 영향
- **NLP의 패러다임 전환** — RNN 시대 종식, Transformer 시대 시작
- 이후 **BERT** (Devlin et al., 2018), **GPT** 시리즈, **T5** 등 모든 주요 PLM의 기반
- CV에도 적용: Vision Transformer (ViT, Dosovitskiy et al., 2020)

## References
- A. Vaswani et al. "Attention Is All You Need", *NeurIPS 2017*
- [[gated-recurrent-units]] — Transformer가 대체한 기존 RNN 아키텍처
- [[residual-networks]] — Transformer의 residual connection 영감