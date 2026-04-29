---
title: Predictive Control Barrier Functions — Learning for Layered Safety-Critical Control
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, paper, control-theory, safety, robotics, learning]
sources: [raw/papers/2412.04658v1.md]
confidence: high
---

# Predictive Control Barrier Functions (CBFs)

## 개요

**Compton, Cohen & Ames** (Caltech, 2024)는 **Reduced Order Model (RoM)** 과 **Full Order Model (FoM)** 간 갭을 해소하는 **Predictive CBF**를 제안했다^[raw/papers/2412.04658v1.md]. FoM의 rollout을 활용하여 predictive robustness term을 정의하고, 이를 병렬 시뮬레이션 + domain randomization으로 학습한다. 3D hopping robot에서 실험적으로 검증.

## 문제 설정: Layered Safety-Critical Control

### 전통적 접근의 한계

- **RoM:** 단순화된 동역학 모델에 CBF 설계가 용이
- **FoM:** 실제 복잡한 동역학 — RoM과의 갭으로 인해 safety violation 발생

Safety filter 구조:
```
π_ref → [Safety Filter (RoM CBF)] → FoM
                                → RoM CBF condition: ∇h(x)·(f+g·u) ≥ -α(h(x))
```

### Predictive CBF의 해결책

FoM의 simulation rollout을 통해 **predictive robustness term** $d(x)$를 학습:
$$\nabla h(x)^\top (f_{\text{RoM}}(x) + g_{\text{RoM}}(x)u) \geq -\alpha(h(x)) + d(x)$$

$d(x)$는 FoM trajectory의 safety margin을 RoM CBF condition에 보정항으로 추가.

## 핵심 방법론

### 1. Massive Parallel Simulation

- 다양한 초기 조건과 제어 입력에서 FoM rollout 실행
- Domain randomization: 모델 파라미터, 외란, 초기 상태의 분포에서 샘플링
- Safety violation 발생 여부 레이블링

### 2. Supervised Learning of $d(x)$

- 입력: RoM state $x$
- 출력: 필요한 safety margin 보정값
- 손실 함수: False negative penalty > False positive penalty (보수적 safety 우선)

### 3. Layered Implementation

```
π_ref → [min-norm QP with RoM CBF + d(x)] → FoM
```

QP (Quadratic Program):
$$\min_{u \in \mathcal{U}} \|u - \pi_{\text{ref}}(x)\|^2 \quad \text{s.t.} \quad \nabla h^\top (f_{\text{RoM}} + g_{\text{RoM}}u) \geq -\alpha(h) + d(x)$$

## 실험: 3D Hopping Robot

- **시뮬레이션:** FoM safety violation을 RoM CBF 대비 대폭 감소, 보수성 최소화
- **하드웨어 실험:** 실제 3D hopping robot에서 predictive CBF의 safety 보장 확인
- **주요 결과:** Predictive CBF가 RoM-only CBF 대비 safety violation을 유의미하게 줄이면서도 과도한 보수성 회피

## 이론적 보장

Predictive robustness term을 추가한 CBF condition이 충분히 큰 $d(x)$에 대해 **FoM의 safety를 보장**함을 증명 (layered control에서의 formal guarantee).

## 융합 도메인 연결

- [[discriminating-hyperplane-safety]] — Safety filter 설계의 대안적 접근법 (certificate function에서 constraint로 초점 이동)
- [[lyapunov-guided-exploration]] — 안전/안정성을 위한 학습 기반 제어
- [[iss-lyapunov-theory]] — Robustness margin의 이론적 기반

## References

- Compton, W.D., Cohen, M.H., & Ames, A.D. (2024). Learning for Layered Safety-Critical Control with Predictive Control Barrier Functions. L4DC.
