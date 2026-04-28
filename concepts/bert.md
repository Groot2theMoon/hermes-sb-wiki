---
title: BERT (Bidirectional Encoder Representations from Transformers)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, benchmark, paper]
sources: [raw/papers/1810.04805v2.md]
confidence: high
---

# BERT

**BERT**는 Jacob Devlin et al. (Google, 2018)이 제안한 언어 표현 모델로, **Masked Language Model (MLM)**과 **Next Sentence Prediction (NSP)**라는 두 가지 비지도 사전학습 목표를 사용해 Transformer 인코더를 양방향으로 학습한다^[raw/papers/1810.04805v2.md]. 11개 NLP task에서 SOTA 달성.

- **MLM:** 입력 토큰의 15%를 mask → masked token 예측 (양방향 문맥 활용)
- **NSP:** 두 문장의 연속 여부 이진 분류 (QA, NLI 등 이해력 향상)
- **BERT-Base** (L=12, H=768, 110M params) vs **BERT-Large** (L=24, H=1024, 340M params)
- 당시 SOTA 대비 GLUE +7.7%, SQuAD v1.1 F1 93.2 등 큰 폭 개선
- [[transformer]]의 인코더를 양방향 사전학습 → 미세조정(fine-tuning) 패러다임 정립
- 이후 RoBERTa, ALBERT, DistilBERT 등 수많은 변형의 기반
- [[transformer]] — BERT의 기반 아키텍처
- [[elmo]] — ELMo (BERT 이전 contextual embedding)
