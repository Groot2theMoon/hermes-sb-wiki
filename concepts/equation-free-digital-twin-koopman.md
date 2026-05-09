---
title: "Equation-Free Digital Twin — Koopman-Based Rank-Optimized DT for Structural Dynamics"
created: 2026-05-09
updated: 2026-05-09
type: concept
tags: [digital-twin, koopman, structural-analysis, surrogate-model, dynamics, paper]
confidence: medium
sources: [arXiv:2605.00950]
---

# Equation-Free Digital Twin — Koopman-Based DT for Structural Dynamics

## 개요

**Abaei, BahooToroody, Polojärvi, Remes & Tygesen (2026)** ^[arXiv:2605.00950]이 제안하는 **Equation-Free Digital Twin** 프레임워크는 **Koopman 연산자 이론**과 **Hankel 행렬 임베딩** 및 **Dynamic Mode Decomposition (DMD)** 를 활용하여 비선형 구조 동역학의 실시간 디지털 트윈을 구축한다.

## 핵심 아이디어

- **Rank-optimized** 접근법: 고충실도 물리 시뮬레이션과 실시간 edge processing 사이의 간극을 Koopman으로 해소
- **Rolling-horizon virtual sensing:** 1Hz의 낮은 데이터 동화 주파수에서도 critical structural hotspots에서 고충실도 재구성 ($R^2 > 0.95$)
- **물리적 Lyapunov time (~1.0s)** 을 정의하여 시스템의 Information Barrier(예측 가능성 한계) 정량화
- 50Hz 고주파 condition monitoring 시스템에 적합함을 수학적으로 입증

## 연결점

- [[digital-twin]] — 일반적인 디지털 트윈 개념
- [[koopman-operator-theory]] — Koopman 이론 기반 접근법
- [[surrogate-model]] — Surrogate로서의 DT
- [[structural-analysis]] — 구조 동역학 응용

## References
- arXiv:2605.00950 — cs.CE, cs.LG, eess.SY
