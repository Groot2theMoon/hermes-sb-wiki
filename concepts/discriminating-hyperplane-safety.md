---
title: Safety Filters via Discriminating Hyperplanes
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, paper, safety, control-theory, reinforcement-learning, certificate-functions]
sources: [raw/papers/lavanakul24a.md]
confidence: high
---

# Safety Filters via Discriminating Hyperplanes

## 개요

**Lavanakul, Choi, Sreenath & Tomlin** (UC Berkeley, 2024)는 기존 certificate function (CBF, HJ reachability) 기반 safety filter의 의존성을 제거하고, **control input constraint에 직접 초점을 맞춘 discriminating hyperplane** 개념을 제안했다^[raw/papers/lavanakul24a.md]. 이 hyperplane은 control-affine 시스템에서의 safety constraint를 일반화하며, supervised learning과 RL 두 가지 방식으로 학습 가능하다.

## 핵심 개념: Discriminating Hyperplane

### 정의

State $x$마다 control input space에서의 **hyperplane** $a(x)^\top u = b(x)$:
- Half-space $a(x)^\top u \geq b(x)$ → **안전한 입력**
- Half-space $a(x)^\top u < b(x)$ → **잠재적 위험 입력**

### Safety Filter: Min-Norm QP

$$\pi_{\text{safe}}(x) = \arg\min_{u \in \mathcal{U}} \|u - \pi_{\text{ref}}(x)\|^2 \quad \text{s.t.} \quad a(x)^\top u \geq b(x)$$

Reference controller의 입력을 최소한으로 수정하면서 safety 보장.

### Certificate Functions과의 관계

Discriminating hyperplane은 기존 방법들을 일반화:
- **CBF:** $a(x) = \frac{\partial h}{\partial x}g(x)$, $b(x) = -\frac{\partial h}{\partial x}f(x) - \alpha(h(x))$
- **HJ Reachability:** $a(x) = \frac{\partial V}{\partial x}g(x)$, $b(x) = -\frac{\partial V}{\partial x}f(x)$

→ 특정 certificate function에 의존하지 않고, **constraint 자체에 집중**.

## 두 가지 학습 방법

### 1. Supervised Learning (SL-DH)

**필요 조건:** 미리 검증된 control invariant set $S$

1. $S$에서 $N$개 state 샘플링, 각 state에서 $M$개 제어 입력 테스트
2. Lookahead time $\Delta t$ 후 safety 여부로 레이블링
3. Hyperplane $(a_\theta, b_\theta)$를 neural network로 학습 — false positive penalty를 더 높게

### 2. Reinforcement Learning (RL-DH)

**필요 조건:** target constraint set $X$만 있으면 됨 (invariant set 불필요)

- PPO 스타일의 actor가 $(a, b)$ 분포를 출력
- Rollout 중 $\delta$ 확률로 exploration, $1-\delta$ 확률로 learned constraint 적용
- Reward: safety 만족 시 양수 + bonus term

## 실험 결과

| 환경 | 주요 발견 |
|:-----|:---------|
| Moore-Greitzer jet engine | SL-DH가 Oracle DH에 근접한 safety 달성 |
| Inverted Pendulum | CBF와 동등한 safety, dynamics model 없이 달성 |
| Kinematic Vehicle | Lookahead time $\Delta t$가 클수록 더 보수적이고 부드러운 제동 |
| **Cart-Pole (3 tasks)** | SL-DH와 RL-DH 모두 PPO-Lagrangian보다 적은 violation, task retraining 불필요 |
| **HalfCheetah (16D)** | RL-DH가 PPO-Lagrangian과 동등한 safety, PPO 수준의 성능 유지 |

### 핵심 장점

- **Performance-Safety 분리:** Safety filter는 재사용 가능 — 새로운 task 학습 시 retraining 불필요
- **Certificate-free:** CBF나 HJ value function 설계 없이 safety constraint 직접 학습

## 융합 도메인 연결

- [[predictive-control-barrier-functions]] — Layered safety control의 또 다른 접근법
- [[lyapunov-guided-exploration]] — 안전/안정성 보장을 위한 학습 기반 제어

## References

- Lavanakul, W., Choi, J.J., Sreenath, K., & Tomlin, C.J. (2024). Safety Filters for Black-Box Dynamical Systems by Learning Discriminating Hyperplanes. L4DC.
