---
title: Sci Taste — AI for Scientific Taste
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [classic-ai, model, benchmark, survey, paper]
sources: [raw/papers/2603.14473v1.md]
confidence: medium
---

# AI Can Learn Scientific Taste

## 개요

**Tong, Li, Yang et al.** (Fudan University / Shanghai Innovation Institute, 2025)는 AI가 과학적 연구의 **qualitative taste** (연구의 중요성, 우아함, 잠재적 영향력 등)를 학습할 수 있음을 보였다^[raw/papers/2603.14473v1.md]. 핵심 방법론은 RL from Community Feedback (RLCF)이다.

## 방법: RLCF (Reinforcement Learning from Community Feedback)

### 1단계: Preference Modeling (SCIENTIFIC JUDGE)

- **700K 쌍**의 field- 및 time-matched high-citation vs low-citation 논문 데이터셋 구축
- 인용 횟수 = 커뮤니티의 암묵적 선호 신호
- SCIENTIFIC JUDGE 모델이 **어떤 연구 아이디어가 더 영향력 있을지** 예측

| 모델 | 크기 | Accuracy |
|:---|:---:|:-------:|
| SciJudge-4B | 4B | ~78% |
| SciJudge-30B | 32B | ~80% |
| GPT-5.2 | — | ~67% |
| Gemini 3 Pro | — | ~65% |

→ SciJudge는 **모든 proprietary 모델보다 우수**하고, 미래 연도 / 미탐구 분야 / 피어 리뷰 선호도로 **일반화**됨

### 2단계: Preference Alignment (SCIENTIFIC THINKER)

- SCIENTIFIC JUDGE를 **reward model**로 사용
- Policy model (SCIENTIFIC THINKER)이 **영향력 높은 연구 아이디어 제안**하도록 RL 훈련
- SciThinker-4B: 76.5% win rate (base policy 대비)
- SciThinker-30B: 81.5% win rate

## 의의

- **과학적 직관** — 경험 많은 과학자의 "이 연구는 중요해 보인다"는 감각을 **정량화 가능**
- **리뷰 자동화** — 논문 심사/리뷰 보조 도구로 발전 가능
- **연구 생산성 향상** — 아이디어의 질적 필터링 자동화

## 융합 도메인 연결

- [[ai-research-automation]]의 **아이디어 평가 단계**에 직접 적용 가능
- 논문 리뷰/트렌드 분석 시 **영향력 예측**에 활용 가능
- [[how-to-read-a-paper]] — 논문 선별의 정량적 기준 보강

## References
- Tong, J. et al. (2025). AI Can Learn Scientific Taste. arXiv:2603.14473.
- [[ai-research-automation]]
- [[xai-surveys]]
