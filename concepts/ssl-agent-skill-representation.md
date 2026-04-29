---
title: "SSL — Scheduling-Structural-Logical Representation for Agent Skills"
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [tool, paper, research-skills]
sources: []
confidence: medium
---

# SSL: Scheduling-Structural-Logical Representation for Agent Skills

## 개요

Liang et al. (2026)이 arXiv:2604.24026에 발표. **SKILL.md 등 자연어 기반 AI 에이전트 스킬을 3계층 구조화 표현으로 변환**하는 프레임워크.

Schank & Abelson의 고전 이론(MOPs, Script Theory, Conceptual Dependency)에서 영감을 받아, 에이전트 스킬 아티팩트를 세 가지 계층으로 분리:

| 계층 | 표현 | 내용 |
|:-----|:-----|:------|
| **Scheduling** | `r_sch` (record) | 스킬 호출 인터페이스 — goal, intent_signature, inputs/outputs, dependencies |
| **Structural** | `G_str` (graph) | 실행 장면 그래프 — PREPARE → ACQUIRE → REASON → ACT → VERIFY → RECOVER → FINALIZE |
| **Logical** | `G_log` (graph) | 원자적 액션 — act_type, resource_scope, effects, next_step_rules |

## 정규화 파이프라인

LLM 기반 4-pass normalizer가 기존 SKILL.md를 SSL 그래프로 자동 변환:

1. **Pass 1:** Scheduling record 추출
2. **Pass 2:** 2~5개 장면(scene)으로 분해
3. **Pass 3:** 각 장면을 논리적 액션으로 확장
4. **Pass 4:** 검증 (identifier 일관성, enum 값, containment 링크, entry pointer, transition target)

## 성능

| 태스크 | 지표 | 텍스트 only | SSL | 향상 |
|:-------|:----:|:----------:|:---:|:----:|
| Skill Discovery | MRR | 0.573 | **0.707** | +23% |
| Risk Assessment | Macro F1 | 0.744 | **0.787** | +5.8% |

## 현재 Hermes Skill과의 관계

| 측면 | 현재 Hermes SKILL.md | SSL 도입 시 |
|:----|:--------------------|:-----------|
| **메타데이터** | name, description, tags, version | + scheduling record (goal, intent_signature, dependencies) |
| **실행 흐름** | 자연어 "# 본문" | + structural graph (scene types + transitions) |
| **조건/검증** | 암시적 | + logical graph (precondition, postcondition, invariant) |
| **자동 생성** | 수동 작성 | **LLM normalizer가 SKILL.md → SSL 자동 변환** |

## 한계 및 현황

- **코드:** GitHub `COOLPKU/SSL` — 현재 **빈 레포** (2026-04-29 기준)
- **데이터셋:** 6,184개 스킬 말뭉치 + 403개 쿼리 — 코드 공개 시 함께 공개 예정
- **적용 시점:** Hermes skill 전환은 코드 공개 후 재검토 필요
- **참고:** CLI-Anything의 SKILL.md, microsoft/agent-skills 등 유사 생태계와의 호환성 확인 필요

## References
- Liang, Q., Wang, H., Liang, Z., & Liu, Y. (2026). "From Skill Text to Skill Structure: The Scheduling-Structural-Logical Representation for Agent Skills." arXiv:2604.24026.
- Hermes Skill 시스템 — `context-hub` skill 참조
- CLI-Anything — SKILL.md 기반 CLI 도구 래핑
