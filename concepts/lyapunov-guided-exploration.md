---
title: LYGE — Lyapunov-Guided Exploration for Stabilizing High-dimensional Unknown Systems
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, paper, control-theory, reinforcement-learning, lyapunov, safety]
sources: [raw/papers/zhang24a.md]
confidence: high
---

# LYGE: Lyapunov-Guided Exploration

## 개요

**Zhang & Fan** (MIT, 2024)는 **LYGE (LYapunov-Guided Exploration)** 프레임워크를 제안하여 **고차원 미지 시스템(unknown dynamics)**의 안정화 제어기를 학습한다^[raw/papers/zhang24a.md]. Lyapunov 이론으로 탐색을 유도하여, 전체 상태 공간이 아닌 **필요한 도달 가능 부분공간만** 샘플링함으로써 샘플 효율성을 획기적으로 개선한다.

## 문제 설정

- **미지 동역학:** $x(t+1) = h(x(t), u(t))$, $h$는 unknown, Lipschitz 연속
- **목표:** $x_{\text{goal}}$로의 점근적 안정화
- **주어진 것:** 불완전하고 불안정할 수 있는 시연(demonstration) 데이터 $\mathcal{D}^0$

## 알고리즘 (반복적 4단계)

### Iteration $\tau$에서:

1. **Local Dynamics 학습:** $\mathcal{D}^\tau$에서 $\hat{h}_\psi^\tau$를 MSE로 학습 → **trusted tunnel** $\mathcal{H}^\tau$ 정의
2. **CLF + Controller 동시 학습:**
   - CLF: $V_\theta^\tau(x) = x^\top S^\top S x + p_{\text{NN}}(x)^\top p_{\text{NN}}(x)$ (quadratic prior + NN residual)
   - 조건: $V_\theta^\tau(\hat{h}_\psi^\tau(x, \pi_\phi^\tau(x))) \leq \lambda V_\theta^\tau(x)$
3. **Exploration:** $\pi_\phi^\tau$로 새로운 궤적 생성 → $\mathcal{D}^{\tau+1}$에 추가
4. **Trusted tunnel 확장:** 낮은 CLF 값을 향해 확장 → $x_{\text{goal}}$에 점진적으로 접근

### 핵심 손실 함수

$$\mathcal{L}^\tau = \underbrace{V_\theta^\tau(x_{\text{goal}})^2 + [\nu - V_\theta^\tau(x)]^+ + [\epsilon + V_\theta^\tau(\hat{h}) - \lambda V_\theta^\tau(x)]^+}_{\mathcal{L}_{\text{CLF}}^\tau} + \eta_{\text{ctrl}} \underbrace{\|\pi_\phi^\tau(x) - \pi_\phi^{\tau-1}(x)\|^2}_{\mathcal{L}_{\text{ctrl}}^\tau}$$

## 실험 결과

| 환경 | 상태 차원 | 입력 차원 | LYGE vs. Baselines |
|:-----|:--------:|:--------:|:-------------------|
| Inverted Pendulum | - | - | Comparable to PPO |
| Cart II Pole | - | - | Comparable to PPO |
| Neural Lander | 6 | 3 | **Baselines fail; LYGE succeeds** |
| **F-16 GCA** | **16** | **4** | **LYGE만 성공** (PID/PPO/AIRL 실패) |
| **F-16 Tracking** | **16** | **4** | **LYGE만 성공** |

**샘플 효율성:** Baselines(PPO, AIRL, D-REX, SSRR) 대비 **68~95% 적은 샘플**로 수렴.

## 이론적 기여

- CLF 조건 만족 시 trusted tunnel 내에서의 안정성 보장 (Theorem in Appendix)
- Lyapunov-guided exploration → 전체 상태공간 샘플링의 **차원의 저주 회피**

## 확장 가능성

LYGE 프레임워크는 CLF뿐 아니라 **Control Contraction Metrics (CCM)** 등 다른 certificate 함수로도 일반화 가능 (Dubins car path tracking에서 검증).

## 융합 도메인 연결

- [[iss-lyapunov-theory]] — ISS Lyapunov 이론과의 연결
- [[predictive-control-barrier-functions]] — 안전 필터로서의 CBF 접근법
- [[koopman-learner-continual-lifting]] — 고차원 로봇 시스템의 데이터 기반 제어

## References

- Zhang, S. & Fan, C. (2024). Learning to Stabilize High-dimensional Unknown Systems Using Lyapunov-guided Exploration. L4DC.
