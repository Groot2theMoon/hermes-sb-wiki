---
title: GPT-1 — Generative Pre-Training
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, model, benchmark, landmark-paper]
sources: [raw/papers/language_understanding_paper.md]
confidence: high
---

# GPT-1: Improving Language Understanding by Generative Pre-Training

## 개요

**Alec Radford, Karthik Narasimhan, Tim Salimans, Ilya Sutskever (OpenAI, 2018)** 가 제안한 GPT-1은 **비지도 사전학습 (Generative Pre-Training) + 지도 미세조정 (Supervised Fine-Tuning)** 패러다임을 NLP에 최초로 적용한 논문이다^[raw/papers/language_understanding_paper.md]. 이 단순한 아이디어가 이후 GPT-4, ChatGPT, 그리고 LLM 혁명 전체의 출발점이 되었다.

## 핵심 아이디어

### 1단계: 비지도 사전학습 (Generative Pre-Training)

대규모 텍스트 코퍼스에서 **언어 모델 목표**로 학습:

$$L_1(\mathcal{U}) = \sum_i \log P(u_i \mid u_{i-k}, \dots, u_{i-1}; \Theta)$$

- **왼쪽→오른쪽 (left-to-right, unidirectional)** Transformer decoder
- **12층, 117M 파라미터** (당시로서는 매우 큰 모델)
- BooksCorpus (7,000+ unpublished books)로 학습

### 2단계: 지도 미조정 (Supervised Fine-Tuning)

레이블이 있는 특정 태스크 데이터로 미세조정:

$$L_2(\mathcal{C}) = \sum_{(x,y)} \log P(y \mid x^1, \dots, x^m)$$

### 태스크별 입력 변환 (Traversal-style)

| 태스크 | 입력 변환 방식 | 예시 |
|-------|--------------|------|
| 텍스트 분류 | `[CLS] text [SEP]` | 감정 분석 |
| 텍스트 함의 | `[CLS] premise [SEP] hypothesis` | Entailment 판별 |
| 유사도 비교 | 양방향 각각 평가 후 평균 | Paraphrase detection |
| QA / 상식 추론 | 문맥 + 지문 N개를 각각 평가 후 softmax | Story Cloze Test |

## 성능

| 태스크 | GPT-1 | 당시 SOTA | 격차 |
|-------|-------|----------|:---:|
| **RACE (추론)** | 59.0% | 53.3% (BiDAF+) | **+5.7%** |
| **COPA (인과 추론)** | 78.1% | 75.6% | +2.5% |
| **MultiNLI (텍스트 함의)** | 82.1% | 81.3% | +0.8% |
| **ROCStories (스토리 이해)** | 86.5% | 65.1% | **+21.4%** |
| **SST-2 (감정 분석)** | 91.3% | 94.8% | -3.5% |

12개 NLP 태스크 중 **9개에서 SOTA 달성**, 특히 추론/상식 태스크에서 큰 격차.

## 역사적 의의와 한계

| 측면 | 설명 |
|------|------|
| **혁신** | 단일 사전학습 모델로 **모든 NLP 태스크**를 fine-tuning으로 해결 |
| **한계 (GPT-1)** | decoder-only로 양방향 맥락 불가 → 같은 해 **BERT**가 이를 극복 |
| **계보** | GPT-1 → GPT-2 (1.5B, zero-shot) → GPT-3 (175B, few-shot) → InstructGPT/ChatGPT |
| **Transformer 발전** | [[bert]]의 **bidirectional**과 GPT의 **unidirectional**이 LLM 설계의 두 축 형성 |

## References

- A. Radford et al., "Improving Language Understanding by Generative Pre-Training", OpenAI, 2018
- [[transformer]] — GPT-1의 기본 아키텍처
- [[bert]] — GPT-1과 동시대 양방향 모델
- [[gpt-1]] — GPT 계열의 시초
- [[muon-optimizer]] — LLM 학습 효율성을 높이는 최신 최적화기
