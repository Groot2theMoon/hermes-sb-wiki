---
title: Optimal Control — Optimal Decision-Making in Dynamical Systems
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [control-system, optimal-control, trajectory-optimization, reinforcement-learning, control-theory]
sources: []
confidence: medium
---

# Optimal Control

## 개요

**Optimal Control**은 동적 시스템에서 **비용 함수(cost function)를 최소화**하는 제어 입력(control input)을 찾는 수학적 프레임워크. Model Predictive Control (MPC), LQR, Dynamic Programming 등이 대표적인 기법이다.

## 수학적 정식화

$$
\min_{\mathbf{u}_{0:T}} \sum_{t=0}^{T} c_t(\mathbf{x}_t, \mathbf{u}_t) + c_T(\mathbf{x}_T)
\quad \text{s.t.} \quad
\mathbf{x}_{t+1} = f(\mathbf{x}_t, \mathbf{u}_t)
$$

- $\mathbf{x}_t$: 상태 (state)
- $\mathbf{u}_t$: 제어 입력 (control input)
- $c_t$: stage cost (운용 비용)
- $c_T$: terminal cost (최종 상태 목표)
- $f$: 시스템 역학 (dynamics)

## 주요 접근법

| 접근법 | 원리 | 장점 | 단점 |
|--------|------|------|------|
| **LQR** | 선형 시스템 + 2차 비용 → Riccati 방정식 | Closed-form, 실시간 | 선형 가정 |
| **MPC** | 유한 구간 최적화를 반복 | 제약 조건 처리 용이 | 계산량 큼 |
| **Dynamic Programming** | Bellman optimality principle | 전역 최적 보장 | 차원의 저주 |
| **Trajectory Optimization** | 직접 미분 기반 최적화 | 비선형 시스템 가능 | 국소 최적 |

## FEP과의 연결

[[free-energy-principle|FEP]]에서 optimal control은 **prior expectations의 실현**으로 해석된다. Active inference 프레임워크에서는 에이전트가 자유에너지를 최소화하는 행동을 선택하는 것이 곧 optimal control의 일반화된 형태로 볼 수 있다:

$$
\text{Action} = \arg\min_a \mathbb{E}_{q(\mathbf{z})} [-\ln p(\mathbf{x}, \mathbf{z} | a)]
$$

즉, FEP의 surprise 최소화는 optimal control의 cost 최소화와 수학적으로 동형이다.

## 관련 페이지

- [[free-energy-principle]] — FEP과 optimal control의 연결
- Control system — ML 기반 제어 일반
- Reinforcement learning — Optimal control의 학습 기반 접근
- Model predictive control — MPC 상세
