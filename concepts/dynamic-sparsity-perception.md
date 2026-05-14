---
title: "Neuro-Inspired Dynamic Sparsity for Energy-Efficient Perception"
created: 2026-05-05
updated: 2026-05-05
sources: [raw/papers/s41467-025-65387-7 (1).md]
type: concept
tags: [neuromorphic, sparsity, efficient-inference, perception, event-camera, edge-ai, nature-communications]
sources:
  - raw/papers/s41467-025-65387-7 (1).md
confidence: medium
---

# Neuro-Inspired Dynamic Sparsity for Energy-Efficient Perception

**Zhou, Gao, Delbruck, Verhelst, Liu** (ETH Zurich, TU Delft, KU Leuven & imec, 2025)  
*Nature Communications — Perspective*

## 개요

생물학적 뇌의 **동적 희소성(dynamic sparsity)** 원리를 AI perception 시스템에 적용하여 에너지 효율을 극대화하는 방안을 제시하는 Perspective 논문. SNN(Spiking Neural Networks)에 국한되지 않고 ANN, Transformer 등 일반적인 아키텍처에 dynamic sparsity 개념을 확장.

## 핵심 개념

### Static Sparsity vs Dynamic Sparsity

| 구분 | Static Sparsity | Dynamic Sparsity |
|:----|:---------------|:----------------|
| 방법 | Pruning + Quantization + NAS | Data-driven, runtime selective activation |
| 작동 | 고정된 sparse 구조 | 입력 데이터 특성에 따라 동적 변화 |
| 예 | Weight pruning | Event camera, predictive coding, conditional computation |
| 효율 | 2× smaller, 1.8× faster | 입력 당 10-100× MAC 감소 가능 |

### 뇌의 동적 희소성 원리

1. **Sparse firing:** 피질 뉴런의 평균 발화율 ~1Hz → 활성 듀티 사이클 0.1%
2. **Predictive coding:** 능동적으로 예측 생성 → surprise에만 반응
3. **Statefulness:** 시냅스, 막전위, 칼슘 농도 등 분산된 상태로 필요한 업데이트만 수행
4. **Attention-based gating:** 하향 예측이 불필요한 계산 차단

### Dynamic Sparsity 유형

| 유형 | 설명 | 구현 예 |
|:----|:-----|:-------|
| Context-aware | 입력 데이터의 시공간 중복성 활용 | Event cameras, conditional computation |
| State-dependent | 현재 상태에 따라 필요한 연산만 수행 | RNN hidden state gating, KV cache |
| Surprise-driven | 예측 오차가 큰 경우만 active | Predictive coding networks |

## Algorithm-Hardware Co-Design

### 알고리즘 레벨
- Conditional computation (Mixture of Experts, Gated FFN)
- Adaptive inference depth (Early exit)
- Context-aware attention sparsity

### 하드웨어 레벨
- Neuromorphic sensors (DVS event camera → sparse events)
- In-memory computing (sparse MAC 가속)
- Event-driven ASIC (연산 필요한 경우만 power-on)

## 도전 과제

1. **Hardware-software co-design:** 현재 AI 가속기는 dense MAC에 최적화되어 dynamic sparsity 활용 어려움
2. **Sparsity ratio vs accuracy trade-off:** sparsity 증가 → accuracy 저하 (특히 복잡한 task)
3. **Load imbalance:** 동적 sparse 연산은 워크로드 예측 불가능 → 하드웨어 활용률 저하
4. **Training instability:** conditional computation은 gradient estimation 불안정

## Wikilinks
- [[mc-dropout]] — Monte Carlo Dropout (static sparsity의 한 형태)
- [[lottery-ticket-hypothesis]] — Lottery Ticket 가설 (pruning 기반 static sparsity)
- [[spectral-normalization-gan]] — Spectral normalization (regularization 기법)

## References
- DOI: [10.1038/s41467-025-65387-7](https://doi.org/10.1038/s41467-025-65387-7)
- UZH / ETH Zurich, TU Delft, KU Leuven & imec
