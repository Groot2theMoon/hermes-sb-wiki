---
title: SciML for Schwarzschild Black Hole Orbits — Neural ODE, UDE & Symbolic Recovery
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [physics-informed, neural-ode, surrogate-model, optimization-method]
sources: [raw/papers/363_Scientific_Machine_Learnin.md]
confidence: medium
---

# SciML for Schwarzschild Black Hole Orbits

Scientific Machine Learning (SciML) 프레임워크로 슈바르츠실트 블랙홀 궤도 역학을 모델링하고,
상대론적 보정항(correction term)을 기호 회귀(symbolic regression)로 복원하는 연구.

## 개요

- **저자:** Pothuraju Naveen Yadav et al. (Delhi Technological University / Vizuara AI Labs)
- **NeurIPS ML4PS 2025 Workshop**
- **핵심 문제:** 블랙홀 주변 상대론적 궤도 역학을 노이즈 및 데이터 희소성 하에서도 정확히 모델링
- **방법:** Neural ODE → Universal Differential Equation (UDE) → Symbolic Regression

## 핵심 아이디어

Schwarzschild orbital equation:

$$\frac{du}{d\phi} = v, \quad \frac{dv}{d\phi} = -u + \frac{GM}{L^2} + \alpha \frac{GM}{c^2} u^3$$

- **Neural ODE:** 모든 dynamics를 MLP로 학습 (noise에 취약, sparse data에서 MAE > 0.026)
- **UDE:** 알려진 물리 + neural correction $\hat{g}_\theta(u)$ (softplus 2-layer, $u^3$로 scaling)
  - 10-20% 데이터만으로도 정확한 예측 (forecast loss ≈ $2.7 \times 10^{-4}$)
  - 35% noise까지 robust
- **Symbolic Recovery:** 학습된 neural correction에서 $\alpha \frac{GM}{c^2} u^3$ 항을 convex optimization으로 복원 (symbolic error < $10^{-7}$)

## AI×Mechanics 관점

- UDE + symbolic regression 패턴은 미지의 물리 보정항을 가진 기계 시스템 식별에 직접 적용 가능
- Neural ODE의 데이터 희소성 취약점 vs UDE의 물리 prior 활용 간 trade-off가 잘 드러난 사례
- Julia DiffEqFlux + Lux 스택 사용 (JAX 기반 구현과의 비교 가치)

## 관련 페이지

- [[neural-ode]] — Neural ODE 기본
- [[universal-differential-equations]] — UDE vs Neural ODE
- [[physics-informed]] — Physics-informed ML 개요
