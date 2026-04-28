---
title: ELMo (Deep Contextualized Word Representations)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, benchmark, paper]
sources: [raw/papers/1802.05365v2.md]
confidence: high
---

# ELMo: Deep Contextualized Word Representations

## 개요

**ELMo (Embeddings from Language Models)**는 Peters et al. (Allen AI, 2018)이 제안한 **deep contextualized word representation**으로, 대규모 텍스트에서 사전학습된 **양방향 언어 모델(biLM)**의 내부 상태를 활용하여 단어의 문맥 의존적 표현을 생성한다^[raw/papers/1802.05365v2.md].

## 핵심 아이디어

### 양방향 언어 모델 (biLM)
- **순방향 LM:** $p(t_1,\dots,t_N) = \prod_{k=1}^N p(t_k | t_1,\dots,t_{k-1})$
- **역방향 LM:** $p(t_1,\dots,t_N) = \prod_{k=1}^N p(t_k | t_{k+1},\dots,t_N)$
- LSTM 기반의 양방향 RNN으로 학습 (당시 기준)

### Deep Representation
- ELMo는 **마지막 레이어만 사용하지 않고 모든 레이어의 hidden state를 선형 결합**
- $\text{ELMo}_k^{\text{task}} = \gamma^{\text{task}} \sum_{j=0}^L s_j^{\text{task}} \mathbf{h}_{k,j}^{LM}$
- 학습된 가중치 $s_j$: 하위 레이어(구문), 상위 레이어(의미) 특성 혼합
- $\gamma$: task별 scaling

### 특징
- **Contextual:** 같은 단어 "bank"라도 문맥에 따라 다른 representation
- **Polysemy 해결:** 기존 Word2Vec/GloVe의 한계 극복
- **Deep internal 노출:** pre-trained network의 내부 상태 노출이 핵심

## 성능
6개 NLP task에서 SOTA 달성:
- SQuAD (QA), SNLI (텍스트 함의), SRL (의미역), Coref, NER, Sentiment

## 영향
- **ELMo → BERT → GPT** 로 이어지는 pre-trained language model 혁명의 시작
- 이후 Transformer 기반 모델(BERT)이 ELMo의 LSTM 기반 접근을 대체

## References
- M. Peters et al. "Deep contextualized word representations", *NAACL 2018*
- [[transformer]] — ELMo 이후 지배적이 된 Transformer 기반 접근
- [[gated-recurrent-units]] — ELMo의 LSTM 기반 구조와의 연관성