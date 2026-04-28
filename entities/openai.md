---
title: OpenAI
created: 2026-04-28
updated: 2026-04-28
type: entity
tags: [company, model, training, benchmark]
sources: [raw/papers/language_understanding_paper.md]
---

# OpenAI

**인공 일반 지능(AGI)을 추구하는 AI 연구 기관.** 2015년 비영리로 설립되어 이후 캡(cap)이 있는 영리 구조로 전환. GPT 시리즈, DALL-E, Whisper, Sora 등 현대 AI를 대표하는 모델들을 개발했다.

## 주요 성과

### GPT 시리즈
- **[[gpt-1]] (2018):** Alec Radford et al., 비지도 사전학습 + 지도 미세조정 패러다임 제안. 12개 NLP task 중 9개 SOTA.
- **GPT-2 (2019):** Zero-shot task 수행 능력, 1.5B 파라미터 (당시 논란)
- **GPT-3 (2020):** 175B 파라미터, in-context learning 발견
- **GPT-4 (2023):** Multi-modal, reasoning 능력 향상
- **o1/o3 (2024):** Chain-of-thought reasoning 강화 모델

### 생성 AI
- **DALL-E:** Text-to-image 생성
- **Whisper:** 다국어 음성 인식
- **Sora:** Text-to-video 생성
- **CLIP:** Image-text representation learning

### 기타 기여
- **Muon Optimizer** ([[muon-optimizer]])
- **RLHF (Reinforcement Learning from Human Feedback):** InstructGPT에서 확립
- **Scaling Laws:** Kaplan et al., Chinchilla (DeepMind와 병행)
- **O1/O3:** 추론 전용 LLM 계열

## 관계

- [[gpt-1]] — OpenAI의 첫 GPT 모델
- [[muon-optimizer]] — OpenAI의 최신 최적화 기법
- [[agent-scaling]] — Agent 연구 (OpenAI 관련 Google 연구와 비교 대상)
- [[engram-sparse-memory]] — DeepSeek (OpenAI의 경쟁사)