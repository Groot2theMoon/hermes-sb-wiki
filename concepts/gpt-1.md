---
title: GPT-1 — Generative Pre-Training
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, model, benchmark]
sources: [raw/papers/language_understanding_paper.md]
confidence: high
---

# GPT-1: Improving Language Understanding by Generative Pre-Training

Alec Radford et al. (OpenAI, 2018)는 **비지도 사전학습(Generative Pre-Training) + 지도 미세조정** 패러다임을 제안했다^[raw/papers/language_understanding_paper.md].

- **대조군:** GPT → BERT → GPT-2/3/4 계열의 시초
- [[bert]]와 동시대에 개발된 **left-to-right (unidirectional)** Transformer decoder
- [[transformer]]의 decoder만 사용 — 12층 117M 파라미터
- 당시 12개 NLP task 중 9개에서 SOTA 달성