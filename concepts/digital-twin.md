---
title: Digital Twin — Real-Time Physics-Based Virtual Replica
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [surrogate-model, digital-twin, physics-informed, model]
sources: []
confidence: high
---

# Digital Twin

## 정의

**Digital Twin**은 물리적 시스템(항공기, 발전소, 배터리 등)의 실시간 가상 복제본으로, 센서 데이터 + 물리 모델 + ML로 구축. 상태 모니터링, 예측 유지보수, what-if 시나리오 시뮬레이션이 가능하다.

## 핵심 구성요소

1. **Physics model:** FEM/CFD 기반 고충실도 시뮬레이션
2. **Surrogate model:** 실시간 예측을 위한 [[surrogate-model|대리 모델]]
3. **Data assimilation:** 센서 데이터와 모델 예측의 Kalman filter/Ensemble 기반 융합
4. **UQ layer:** [[deep-ensembles|Deep Ensembles]] 또는 [[bayesian-pinns|B-PINN]] 기반 불확실성 정량화

## 융합 도메인 연결

Digital Twin은 [[surrogate-model|Surrogate Model]] + [[uncertainty-quantification-deep-learning|UQ]] + [[control-system|Control]]의 통합 패러다임 — AI×Mechanics의 궁극적 응용 목표.

## References
- [[surrogate-model]]
- [[physics-informed-neural-networks]]
- [[continual-learning-physical-systems]]
