---
title: Transformer vs Mamba — Attention vs SSM 비교
created: 2026-04-28
updated: 2026-04-28
type: comparison
tags: [comparison, neural-network, model, benchmark]
sources: [raw/papers/1706.03762v7.md, raw/papers/2312.00752v2.md]
---

# Transformer vs Mamba — Sequence Modeling 패러다임 비교

**Transformer (Attention Is All You Need, 2017)**와 **Mamba (Selective SSM, 2023)**는 현대 sequence modeling의 두 주요 접근법을 대표한다. Transformer가 2017년 이후 지배적 paradigm이었다면, Mamba는 그 한계를 극복하기 위해 등장한 차세대 아키텍처이다.

## 비교 표

| 차원 | Transformer | Mamba |
|------|-------------|-------|
| **핵심 메커니즘** | Self-attention (Q, K, V) | Selective State Space Model |
| **시간 복잡도 (학습)** | $O(n^2)$ | $O(n)$ |
| **시간 복잡도 (추론)** | $O(n^2)$ (캐싱 미스 시) | $O(n)$ (constant memory) |
| **추론 처리량** | 기준 | Transformer 대비 **5배** |
| **장기 의존성** | $O(1)$ 경로 길이 (직접 연결) | RNN-like — 경로 길이 $O(n)$ |
| **Content-based reasoning** | ✅ (native) | ✅ (selective mechanism) |
| **병렬화 용이성** | ✅ (전체 시퀀스 동시 계산) | ⚠️ (병렬 scan, hardware-aware) |
| **Context 길이 확장** | $$O(n^2)$$ 한계 (메모리 폭발) | $O(n)$ (선형 확장) |
| **하드웨어 효율성** | CUDA core dense matmul에 최적화됨 | GPU SRAM 활용한 custom kernel 필요 |
| **모달리티 확장** | Text, image, video, audio 등 전 영역 | Text + audio + genomics (확장 중) |

## 장단점 분석

### Transformer 장점
| 장점 | 설명 |
|------|------|
| **직접적 장거리 연결** | 모든 토큰 쌍이 $O(1)$ 경로로 연결 (장기 의존성 포착에 탁월) |
| **병렬화 친화적** | 전체 시퀀스를 한 번에 행렬 연산으로 처리 |
| **생태계 성숙** | 수많은 변형(BERT, GPT, ViT, T5 등), 라이브러리, 하드웨어 최적화 |
| **multi-modal 확장** | ViT, Perceiver 등 attention 기반 확장 풍부 |

### Transformer 단점
| 단점 | 설명 |
|------|------|
| **$O(n^2)$ 계산량** | 긴 context에서 기하급수적 비용 증가 |
| **추론 시 KV cache** | 디코딩 시 모든 이전 key/value 저장 → GPU 메모리 병목 |
| **인퍼런스 처리량 제한** | autoregressive decoding이 sequential |

### Mamba 장점
| 장점 | 설명 |
|------|------|
| **$O(n)$ 효율성** | 긴 sequence에서 Transformer 대비 획기적 효율 |
| **Inference 처리량 5배** | 상수 메모리로 추론 가능 |
| **Content-based selection** | Transformer와 유사한 입력 의존적 추론 |
| **Hardware-aware 구현** | GPU SRAM 활용한 custom kernel (FlashAttention의 SSM 버전) |

### Mamba 단점/한계
| 단점 | 설명 |
|------|------|
| **생태계 미성숙** | 2023년 제안, 변형 및 최적화 진행 중 |
| **Training 불안정성** | Selective SSM의 수렴 특성 이론적 이해 부족 |
| **Long-range 포착** | $O(n)$ 경로 길이 → 매우 긴 의존성에서 attention보다 약할 수 있음 |
| **하드웨어 의존성** | custom CUDA kernel (Triton 구현 필요) |

## 정량적 비교 (언어 모델링)

| 모델 | 파라미터 | Pile ppl | 추론 처리량 |
|------|---------|----------|------------|
| Transformer (baseline) | 3B | ~10.0 | 1× |
| Mamba | 3B | ~9.9 | 5× |
| Mamba | 1B | ~10.0 (2× Transformer와 동등) | — |

## 결론

| 사용 사례 | 권장 아키텍처 |
|-----------|-------------|
| 긴 context (100K+) | Mamba (또는 Mamba-Transformer hybrid) |
| 고정 길이, 최대 성능 | Transformer (내일 당장 production) |
| 모바일/엣지 추론 | Mamba (constant memory) |
| 멀티모달 거대 모델 | Transformer (현재까지) |

## 관련 페이지

- [[transformer]] — Transformer 상세
- [[mamba]] — Mamba 상세
- [[linear-rnn-theory]] — Mamba의 이론적 배경
- [[bert]] — Transformer 기반 NLP 모델
- [[gpt-1]] — Transformer decoder 기반 생성 모델