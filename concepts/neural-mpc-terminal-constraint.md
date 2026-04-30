---
title: "Neural MPC Terminal Constraint via HJ Reachability for Collision Avoidance"
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [control-system, optimization, dynamics, neural-network, paper]
sources: [raw/papers/derajic25a.md]
confidence: medium
---

# Neural MPC Terminal Constraint via Hamilton-Jacobi Reachability

## 개요

Derajić et al. (TU Berlin / Continental, 2025)은 동적 환경에서 [[optimal-control|MPC]] (Model Predictive Control)의 **terminal constraint로 사용할 safe set을 학습 기반으로 실시간 근사**하는 방법을 제안한다. Hamilton-Jacobi (HJ) reachability analysis의 value function을 signed distance function (SDF) + neural residual로 분해하여, 이론적 안전성을 보장하면서도 실시간 계산이 가능하게 한다.

## 핵심 아이디어

### 문제: MPC Terminal Set의 실시간 설계

MPC의 recursive feasibility를 보장하려면 **control invariant terminal set**이 필요하지만, 동적 환경에서는 이를 실시간으로 계산하는 것이 극도로 어렵다.

### 해결책: SDF + Neural Residual

HJ value function $V(x)$는 항상 signed distance function $d(x)$보다 작거나 같다는 성질을 이용:

$$V(x) = d(x) - r(x), \quad r(x) \geq 0$$

여기서:
- **SDF $d(x)$**: 장애물까지의 signed distance — 수치적으로 빠르게 계산 가능
- **Neural residual $r(x)$**: 신경망으로 근사 (non-negative 출력 보장), hypernetwork로 parameterize

이 구조의 핵심 이점: **Design guarantee** — $V_{\text{est}}(x) = d(x) - r_\theta(x) \leq d(x)$이므로, neural approximation이 항상 SDF보다 더 안전한 safe set을 제공한다.

### Architecture

- **Hypernetwork**: 환경 관측 → residual network의 weight 생성
- **Residual network**: 현재 상태 $x$ → non-negative residual $r(x)$
- **Loss**: 실제 HJ value function과의 MSE (offline training)

## 결과

시뮬레이션 및 하드웨어 실험에서:
- 세 가지 SOTA 방법 대비 **최대 30% 높은 success rate**
- 유사한 계산 비용으로 고품질 (low travel-time) 경로 생성
- Nonholonomic mobile robot에서 검증

## AI/ML × Mechanics 관점

이 방법은 제어 이론과 학습 기반 방법을 **안전성 보장(safety guarantee)**과 함께 결합한 대표적인 사례다. 로보틱스, 자율 주행, 드론 내비게이션 등 동적 환경에서의 안전-critical 제어에 직접 응용될 수 있다.

## 관련 개념

- control system — ML 기반 제어, MPC, 강화학습
- [[iss-lyapunov-theory]] — Lyapunov 안정성 이론 (HJ reachability의 이론적 기반)
- reinforcement learning — RL for robotics, control, manipulation
- optimization — topology optimization, multi-objective optimization

## 참고

- HJ reachability는 원래 curse of dimensionality 문제가 있으나, SDF + neural residual 분해를 통해 실시간 적용 가능성을 크게 높임
- Hypernetwork 사용은 다양한 환경 configuration에 대한 generalization을 향상시킴
- 이 방법은 vehicle dynamics의 비선형성과 limited actuation을 명시적으로 고려
