---
title: Agent Scaling Systems — Google Research
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [model, benchmark, paper, training, infrastructure]
sources: [raw/papers/2510.14057v1.md]
confidence: medium
---

# Scaling Agent Systems

## 개요

**Kim, Gu, Park et al.** (Google Research / MIT, 2025)는 **에이전트 시스템의 스케일링 법칙**을 180개 설정, 5개 아키텍처, 3개 LLM family에 걸쳐 체계적으로 정량화했다^[raw/papers/2510.14057v1.md].

## 주요 발견

### 스케일링 법칙 (Scaling Laws for Agents)

- **추론 시간 증가 → 성능 향상:** Test-time compute 투입이 에이전트 작업 성능을 체계적으로 향상시킴
- **모델 크기 증가 → 에이전트 성능 향상:** 더 큰 backbone LLM이 더 복잡한 에이전트 작업 해결
- **에이전트 아키텍처 선택 중요:** 아키텍처에 따라 스케일링 효율이 크게 차이

### 5개 아키텍처 비교

| 아키텍처 | 설명 | 스케일링 효율 |
|:--------|:----|:-----------:|
| React | Reasoning + Acting | 기준 |
| Plan-then-Execute | 계획 → 실행 분리 | 향상 |
| Tree-of-Thought | 여러 추론 경로 탐색 | 높음 |
| Reflexion | 피드백 기반 자기 수정 | 중간 |
| Multi-Agent | 여러 에이전트 협력 | 조건부 |

## 융합 도메인 연결

- **추론 시간 스케일링** 법칙은 [[muon-optimizer]]의 학습 시간 효율성과 대비되는 개념
- Multi-agent coordination의 scaling 원리 → **Autonomous Lab / Active Learning** 설계 시 참고
- [[ai-research-automation]]의 AI Scientist 확장 방향과 연결

## References
- Kim, S. et al. (2025). Scaling Agent Systems. arXiv:2510.14057. Google Research/MIT.
- [[multi-agent-investment]]
- [[ai-research-automation]]
