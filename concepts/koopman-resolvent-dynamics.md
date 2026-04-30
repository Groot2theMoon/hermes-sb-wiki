---
title: Koopman-Resolvent Data-Driven Dynamics — Generator Learning for Continuous Systems
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [koopman, system-identification, control-theory, state-space-model, dynamics]
sources: [raw/papers/resolvent-data-driven-generators.md, raw/papers/koopman-stability-certificates.md]
confidence: medium
---

# Koopman-Resolvent Dynamics Learning

연속시간 동역학의 Koopman generator를 데이터로부터 학습하고, **안정성 인증서(stability certificate)**를 추출하는 프레임워크.

## Resolvent-Type Generator Learning (IEEE TAC)

미지의 연속시간 시스템의 **Koopman generator**를 resolvent (pseudo-inverse) 기반으로 직접 학습.
- 발전기(미분 연산자)의 resolvent를 데이터로부터 추정
- 유한 차원 근사로 generator 표현

## Koopman Stability Certificates

Koopman 연산자의 spectrum을 학습 → Lyapunov 함수를 **명시적으로 학습하지 않고** spectrum으로 안정성 판별.
- Koopman eigenvalue가 모두 음수 → 시스템 안정
- NN이 Koopman eigenfunction을 근사

## 관련 페이지
- [[jun-liu]] — Waterloo 그룹 (Resolvent + Koopman stability, PINN Lyapunov)
- [[koopman-learner-continual-lifting]] — Koopman 기반 continual learning (기존 위키)
- [[iss-lyapunov-theory]] — Lyapunov 기초
- [[lyapunov-stable-nn-control]] — 대안적 안정성 보장 접근
- [[neural-odes]] — 연속시간 dynamics의 다른 접근
