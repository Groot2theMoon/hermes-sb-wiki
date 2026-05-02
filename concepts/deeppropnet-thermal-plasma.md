---
title: "DeepPropNet — Operator Learning for Thermal Plasma Property Prediction"
created: 2026-05-02
updated: 2026-05-02
type: concept
tags: [model, surrogate-model, operator-learning, inference]
confidence: medium
---

# DeepPropNet — Operator Learning for Thermal Plasma Properties

## 개요
DeepPropNet (Wang & Zhong, 2026)은 열플라즈마(thermal plasma)의 열역학적 및 수송 물성(thermodynamic & transport properties)을 고속으로 예측하는 operator learning 기반 모델입니다. 온도, 압력, 기체 조성에 대한 강한 비선형 의존성을 가진 열플라즈마 물성을 실시간으로 예측합니다.

## 핵심 아이디어
- **S-DeepPropNet:** 단일 물성 예측 모델
- **MoE-DeepPropNet:** Mixture of Experts 기반 다중 물성 통합 예측 프레임워크
- SF₆-N₂ 및 C₄F₇N-CO₂-O₂ 혼합물에서 상대 L2 오차 10⁻³~10⁻² 수준의 정확도
- FVM (finite volume method) 및 PINN과의 결합 가능성 입증
- Operator learning을 열플라즈마 물성 예측에 적용한 첫 사례

## 연결점
- [[deeponet]] — Operator learning 패러다임의 응용 사례
- [[fourier-neural-operator]] — Operator learning의 또 다른 주요 아키텍처
- [[surrogate-model]] — 고비용 물리 시뮬레이션의 대체 모델
- [[physics-informed-neural-networks]] — PINN과의 결합 가능성

## References
- arXiv:2604.27298 — DeepPropNet: an operator learning-based predictor for thermal plasma properties
