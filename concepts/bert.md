---
title: BERT (Bidirectional Encoder Representations from Transformers)
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [model, neural-network, benchmark, paper, nlp, transformer]
sources: [raw/papers/1810.04805v2.md]
confidence: high
---

# BERT — Bidirectional Encoder Representations from Transformers

## 개요

**BERT**는 Jacob Devlin, Ming-Wei Chang, Kenton Lee, Kristina Toutanova (Google AI Language, 2018)가 제안한 사전학습 언어 표현 모델이다. [[transformer]]의 **인코더(encoder)만** 사용하며, 두 가지 비지도 사전학습 목표 — **Masked Language Model (MLM)** 과 **Next Sentence Prediction (NSP)** — 를 통해 심층 양방향 문맥 표현을 학습한다. 출시 당시 11개 NLP 벤치마크에서 SOTA를 경신하며 NLP의 **사전학습-미세조정(pre-training + fine-tuning)** 패러다임을 정립했다.

## Transformer 인코더 기반 아키텍처

BERT는 [[transformer]]의 인코더 스택만 사용한다 (디코더 없음). GPT가 left-to-right 자기회귀 방식인 것과 달리, BERT는 **양방향(bidirectional)** self-attention을 통해 토큰의 좌우 전체 문맥을 동시에 활용한다.

### 모델 규격 비교

| 모델 | 레이어 수 ($L$) | Hidden 크기 ($H$) | Attention Head | 파라미터 수 |
|:---|:---|:---|:---|:---|
| **BERT-Base** | 12 | 768 | 12 | 110M |
| **BERT-Large** | 24 | 1024 | 16 | 340M |

참고로 GPT-1은 12-layer, 768-hidden, 117M 파라미터로 BERT-Base와 유사한 규모지만 단방향이다.

### 입력 표현

입력 토큰 시퀀스는 세 가지 임베딩의 합으로 구성된다:

$$\text{Input} = \text{Token Embedding} + \text{Segment Embedding} + \text{Position Embedding}$$

- **[CLS]**: 시퀀스 시작에 추가되는 특별 토큰; 분류 작업의 aggregate representation
- **[SEP]**: 문장 경계 표시; NSP 태스크에서 두 문장 구분

## 사전학습 목표 (Pre-training Objectives)

### 1. Masked Language Model (MLM)

입력 토큰의 **15%** 를 무작위로 선택하여 마스킹:

- 80%: `[MASK]` 토큰으로 대체 → "my dog is hairy" → "my dog is `[MASK]`"
- 10%: 무작위 다른 토큰으로 대체 → "my dog is apple"
- 10%: 원래 토큰 유지 (noise robustness)

양방향 문맥을 활용해 마스킹된 원래 토큰을 예측한다. 이 메커니즘이 BERT의 양방향성의 핵심이다. GPT 계열은 단방향이기 때문에 MLM을 사용할 수 없다.

### 2. Next Sentence Prediction (NSP)

두 문장 A, B가 입력될 때, B가 A의 실제 다음 문장인지(True) 아닌지(False)를 이진 분류:

- Positive 예시 (50%): 실제 연속된 두 문장
- Negative 예시 (50%): 무작위로 선택된 다른 문장

NSP는 QA(QA), Natural Language Inference(NLI) 등 문장 간 관계 이해가 중요한 downstream task를 위해 설계되었다. 단, 후속 연구([[roberta]] 등)에서 NSP의 효용성에 의문이 제기되어 제거되기도 했다.

## Fine-Tuning

사전학습된 BERT에 task-specific 출력 레이어를 추가하고, labeled 데이터로 전체 파라미터를 미세조정한다:

- **Sequence Classification** (e.g., 감성 분석): `[CLS]` 토큰의 출력 → classifier
- **Token Classification** (e.g., NER): 각 토큰의 출력 → classifier
- **Span Prediction** (e.g., QA): Start/End span 예측 레이어

### BERT 출시 당시 벤치마크 성능 (2018)

| 벤치마크 | 이전 SOTA | BERT-Base | BERT-Large |
|:---|:---|:---|:---|
| **GLUE Score** | 72.8 | 78.3 | **80.5** (+7.7) |
| **MultiNLI (Acc)** | 76.6 | 84.6 | **86.7** |
| **SQuAD v1.1 (F1)** | 88.5 | 88.5 | **93.2** |
| **SQuAD v2.0 (F1)** | 66.3 | 76.3 | **83.1** |
| **SWAG (Acc)** | 78.0 | 80.1 | **86.3** |

## BERT 변형 (Variants)

### 주요 변형 일람

| 변형 | 연도 | 핵심 기여 | 파라미터 |
|:---|:---|:---|:---|
| **RoBERTa** | 2019 | NSP 제거, dynamic masking, 더 많은 데이터(160GB), 긴 학습 | 125M–355M |
| **ALBERT** | 2019 | Factorized embedding + cross-layer parameter sharing → 파라미터 감소 | 12M–235M |
| **DistilBERT** | 2019 | Knowledge distillation으로 40% 작고 60% 빠름, 97% 성능 유지 | 66M |
| **ELECTRA** | 2020 | Generator-Discriminator 구조; MLM 대신 replaced token detection | 110M–335M |
| **DeBERTa** | 2021 | Disentangled attention + enhanced mask decoder | 100M–1.5B |
| **DeBERTaV3** | 2023 | ELECTRA-style + gradient-disentangled embedding sharing | 86M–1.5B |
| **ModernBERT** | 2024 | Flash Attention, rotary embeddings, 8192 context length | 139M–395M |

### RoBERTa (Robustly Optimized BERT)

Liu et al. (Facebook AI, 2019)이 BERT의 사전학습을 **체계적으로 재검토**:
- NSP 제거 (성능에 도움 안 됨)
- Dynamic masking (매 epoch 다른 마스크)
- 16GB → **160GB** 데이터 (BookCorpus + Wikipedia + CC-News + OpenWebText + Stories)
- Byte-level BPE tokenization
- GLUE 88.5, SQuAD 94.6 등 BERT 대비 큰 폭 개선

### ELECTRA (Efficiently Learning an Encoder)

Clark et al. (Stanford/Google, 2020):
- **Generator**: MLM처럼 일부 토큰 마스킹 후 대체 토큰 생성
- **Discriminator**: 각 토큰이 원본인지 generator가 대체했는지 판별 (replaced token detection)
- 동일 계산량에서 BERT보다 훨씬 효율적; GLUE 88.6 (BERT-Large: 80.5)

### ALBERT (A Lite BERT)

Lan et al. (Google, 2019):
- Factorized embedding parameterization: $V \times H$ 대신 $V \times E + E \times H$ (E << H)
- Cross-layer parameter sharing: 모든 Transformer layer가 동일 파라미터 공유
- Sentence-Order Prediction (SOP)으로 NSP 대체 (더 어려운 task)

### ModernBERT (2024)

Answer.AI + LightOn 팀이 최신 하드웨어와 기법으로 BERT 재구현:
- Flash Attention 2, RoPE positional encoding, SwiGLU
- 8192 토큰 context length (기존 BERT: 512)
- BERT-Base 대비 2~3배 빠른 학습/추론

## BERT-GPT 대비

| 특성 | BERT | GPT |
|:---|:---|:---|
| 방향 | 양방향 (bidirectional) | 단방향 (left-to-right) |
| 아키텍처 | Transformer **Encoder** only | Transformer **Decoder** only |
| 사전학습 | MLM + NSP | Autoregressive LM |
| 강점 | 문장/토큰 이해 (NLU) | 문장 생성 (NLG) |
| 출력 | Contextual embedding | Next token probability |
| Fine-tuning | Task-specific head 추가 | Prompting + few-shot |

## BERT의 의의와 한계

### 의의
- NLP의 **ImageNet moment** — 사전학습 + 미세조정 패러다임 정립
- 2018년부터 2020년까지 산업/학계 NLP의 실질적 표준
- [[elmo]]의 shallow bidirectional LSTM을 deep Transformer로 대체
- 이후 모든 encoder 기반 모델의 원형

### 한계
- `[MASK]` 토큰과 실제 fine-tuning 입력 간 mismatch
- 생성(generation) 태스크에 부적합 (auto-encoding, not auto-regressive)
- 512 토큰 context window 제한
- NSP의 실질적 효용성 의문

## 관련 개념

- [[transformer]] — BERT의 기반 아키텍처
- [[elmo]] — BERT 이전의 contextual embedding (biLSTM 기반)
- [[gpt-1]] — 동시대 단방향 언어 모델 (OpenAI)
- [[nn-tricks]] — Layer Normalization, GeLU 등 BERT에 사용된 학습 기법들
- [[roberta]] — RoBERTa (향후 생성 예정 페이지)
