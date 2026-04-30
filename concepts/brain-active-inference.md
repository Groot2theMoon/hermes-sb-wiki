---
title: BRAIN — Bayesian Reasoning via Active Inference for Agentic Intelligence
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [neuroscience, cognitive-science, self-organization, reinforcement-learning]
sources: [raw/papers/brain-active-inference.md]
confidence: medium
---

# BRAIN — Embodied AI via Active Inference

Active inference를 **embodied AI 에이전트**로 구현한 프레임워크. 자연 지능이 학습하는 방식을 생체모방.

## 핵심 아이디어

Active inference = 자연 생물체가 환경과 상호작용하며 학습하는 방식의 수학적 정식화.

구성 요소:
1. **Generative model:** 세계의 확률적 모델
2. **Inference:** 감각 입력 → 세계 상태 추론 (Bayesian perception)
3. **Action:** 예측 오차를 최소화하는 방향으로 행동 (free energy minimization)
4. **Learning:** 경험으로부터 generative model 업데이트

## 관련 페이지
- [[free-energy-principle]] — 기반 이론
- [[active-inference-ai-science]] — 과학 발견 버전
- [[deep-kalman-filter]] — temporal generative model의 응용
