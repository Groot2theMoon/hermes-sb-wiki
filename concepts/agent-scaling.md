---
title: Agent Scaling Systems — Google Research
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [model, benchmark, paper, training, infrastructure]
sources: [raw/papers/2510.14057v1.md, raw/papers/2512.08296v2.md]
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

## 확장: Coordination Science (arXiv:2512.08296)

같은 Google Research 그룹의 후속 논문^[raw/papers/2512.08296v2.md]은 **정량적 스케일링 원리**를 도출하고 coordination에 관한 세 가지 지배적 효과를 규명했다:

### 1. Tool-Coordination Trade-off ($\beta=-0.267, p<0.001$)
- Tool-heavy tasks (16개 이상)는 multi-agent overhead로 성능 저하
- 제한된 토큰 예산에서 per-agent capacity 부족이 원인

### 2. Capability Saturation ($\hat{\beta}=-0.404, p<0.001$)
- Single-agent 성능이 **~45%**를 넘으면 multi-agent coordination의 추가 이득이 소멸 또는 역전
- Coordination cost가 diminishing improvement를 초과

### 3. Topology-Dependent Error Amplification
- **Independent agents:** 오류 증폭 **17.2×** (unchecked error propagation)
- **Centralized coordination:** 오류 증폭 **4.4×** (validation bottlenecks)
- **Decentralized:** Parallel exploration에 유리 (web navigation: +9.2%)
- **Multi-agent variants universally degrade on sequential planning tasks** (−39% ~ −70%)

### Cross-Validated Predictive Model ($R^2=0.524$)
- Coordination 효율, 오류 증폭, 중복도 기반 혼합 효과 모델
- Unseen task에서 87% 정확도로 최적 아키텍처 예측

## 융합 도메인 연결

- **추론 시간 스케일링** 법칙은 [[muon-optimizer]]의 학습 시간 효율성과 대비되는 개념
- Multi-agent coordination의 scaling 원리 → **Autonomous Lab / Active Learning** 설계 시 참고
- [[ai-research-automation]]의 AI Scientist 확장 방향과 연결

## References
- Kim, S. et al. (2025). Scaling Agent Systems. arXiv:2510.14057. Google Research/MIT.
- Kim, Y., Gu, K., Park, C., et al. (2025). Towards a Science of Scaling Agent Systems. arXiv:2512.08296. Google Research/DeepMind/MIT.
- [[multi-agent-investment]]
- [[ai-research-automation]]
