---
title: Continual Learning and Lifting of Koopman Dynamics for Legged Robots
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, paper, control-theory, robotics, koopman, continual-learning]
sources: [raw/papers/2411.14321v3.md]
confidence: high
---

# Koopman Dynamics for Linear Control of Legged Robots

## 개요

**Li, Abuduweili, Sun et al.** (CMU, 2024)는 **Koopman Operator** 기반의 데이터 구동 선형화를 통해 보행 로봇(quadruped, humanoid)의 비선형 동역학을 **선형 MPC로 제어**하는 프레임워크를 제안했다^[raw/papers/2411.14321v3.md]. **Continual learning**으로 domain shift 문제를 해결하고, lifting function의 지속적 개선을 통해 제어 성능을 유지한다.

## 핵심 문제

### Koopman Operator의 한계

Koopman operator는 비선형 동역학을 더 높은 차원의 lifted space에서 선형화:
$$\Psi(x_{k+1}) \approx K \Psi(x_k) + L u_k$$

그러나:
1. **Approximation error:** 유한 차원 lifting은 정확한 선형화를 보장하지 못함
2. **Domain shift:** 로봇이 학습 시 보지 못한 상태 영역에 진입하면 오차 급증
3. **Scalability:** 고차원 보행 로봇(>30 DoF)에서의 적용 어려움

### 해결책: Continual Koopman Learning

**Koopman Learner** — 로봇 운용 중 지속적으로 lifting function과 선형 dynamics를 업데이트:

1. **초기 학습:** Offline data로 baseline Koopman model 학습
2. **Online adaptation:** MPC 실행 중 새로운 데이터 수집 → 경험 재생(experience replay)으로 점진적 업데이트
3. **Lifting function 개선:** 더 정확한 선형 근사를 위해 lifting network 지속 학습

## 프레임워크 구성

### Lifting Function

$$\Psi(x) = [x; \phi_{\text{NN}}(x)]$$

- $x$: 원본 상태 (로봇의 joint angle, velocity, base pose 등)
- $\phi_{\text{NN}}(x)$: 학습된 nonlinear lifting features (neural network)
- 결과적으로 $K \in \mathbb{R}^{N_\Psi \times N_\Psi}$, $L \in \mathbb{R}^{N_\Psi \times N_u}$

### MPC Integration

Lifted linear dynamics로 표준 linear MPC formulation 사용:
$$\min_{u_{0:T-1}} \sum_{k=0}^{T-1} \|\Psi(x_k) - \Psi(x_{\text{ref}})\|_Q^2 + \|u_k\|_R^2$$
$$\text{s.t.} \quad \Psi(x_{k+1}) = K \Psi(x_k) + L u_k, \quad u_k \in \mathcal{U}$$

### Continual Learning Strategy

- **Experience replay buffer:** 과거 상태-제어-결과 transition 저장
- **Regularization:** 이전 파라미터로부터의 drift 방지 (EWC-like penalty)
- **Uncertainty-aware:** 예측 불확실성이 높은 영역 우선 학습

## 실험 결과

- **Quadruped locomotion:** 지속적 학습으로 보행 안정성 유지, domain shift 상황에서 baseline 대비 우수
- **Humanoid:** 고차원 시스템에서도 linear MPC 실현
- **Baseline 비교:** Offline-only Koopman 대비 continual learning이 domain shift 상황에서 성능 저하 방지

## 융합 도메인 연결

- Koopman operator control — Koopman operator의 제어 응용 일반
- [[lyapunov-guided-exploration]] — 고차원 미지 시스템의 데이터 기반 제어
- [[continual-learning-physical-systems]] — 물리 시스템에서의 continual learning

## References

- Li, F., Abuduweili, A., Sun, Y., et al. (2024). Continual Learning and Lifting of Koopman Dynamics for Linear Control of Legged Robots. L4DC.
