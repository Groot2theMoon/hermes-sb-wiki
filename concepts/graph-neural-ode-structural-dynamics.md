---
title: "Graph Neural ODE (GNODE) for Structural Dynamics"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [graph-neural-network, neural-ode, structural-dynamics, continuous-time-model, virtual-sensing]
sources: [raw/papers/pigg-graph-kalman-haywood26.md]
confidence: high
---

# Graph Neural ODE (GNODE) for Structural Dynamics

## 개요

Graph Neural ODE(GNODE)는 [[graph-neural-network|Graph Neural Network]]와 [[neural-ode|Neural ODE]]를 결합하여 **그래프 구조를 가진 동역학 시스템의 연속시간 상태 전이**를 학습하는 프레임워크이다. [[pigg-graph-kalman-filter|PiGGO]]의 핵심 구성요소로 사용된다.

## 수학적 공식화

마르코프 상태 전이 가정 하에, 연속시간 상태 전이는 다음과 같이 정의:

```
Z(t+Δt) = Z(t) + ∫_{t}^{t+Δt} F_ev(Z(τ), G(τ)) dτ
```

여기서 `F_ev`는 그래프 컨볼루션 연산자로 파라미터화된 상태 진화 함수(벡터장), `G`는 그래프 구조다.

### 구조 동역학을 위한 GNODE 설계

- **노드 특징**: 위치 p0, 외력 f, 질량 m
- **엣지 특징**: 연결 변형률 ε, 변형률 속도 ε̇, 현재 각도 θ (cos, sin), 이완 각도 ϕ, 강성 k, 감쇠 c
- **Co-rotational kinematics**: 현재 노드 상태에서 기하학적 비선형성을 연속적으로 계산하여 엣지 특징 업데이트
- **상태 공간**: 각 노드는 2D에서 `z_i = [u_d, u̇_d]` (변위, 속도)

### Physics-guided 상태 진화

```
F_ev = C_phy(G) + C_bb(G; Θ)
```

- `C_phy`: 선형 스프링-댐퍼 힘 균형 (알려진 물리)
- `C_bb`: 블랙박스 신경망 컨볼루션 (미지의 비선형성 학습)

## 관련 개념

- [[pigg-graph-kalman-filter|PiGGO]] — GNODE를 EKF와 결합한 프레임워크
- [[neural-ode|Neural ODE]] — 일반적인 신경망 미분방정식
- [[auto-diff-data-assimilation|Auto-differentiable Data Assimilation]] — 미분 가능 동역학 모델링
