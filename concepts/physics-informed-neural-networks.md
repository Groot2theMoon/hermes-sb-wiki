---
title: "Physics-Informed Neural Networks (PINN) — Raissi, Perdikaris & Karniadakis (2019)"
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [physics-informed, model, neural-network, landmark-paper, surrogate-model]
sources: [raw/papers/1-s2.0-S0021999120306872-main.md]
confidence: high
---

# Physics-Informed Neural Networks (PINN)

## 개요

**PINN** — Raissi, Perdikaris, Karniadakis (2019), *Physics-informed neural networks: A deep learning framework for solving forward and inverse problems involving nonlinear partial differential equations*, J. Computational Physics, 378, 686–707. **~7,000회 인용.**

물리 법칙(PDE)을 신경망 학습에 **직접 통합**하여, 데이터 없이도 PDE 해를 근사할 수 있는 최초의 실용적 프레임워크. AI/ML × Mechanics 융합 분야의 **기폭제** 역할을 한 핵심 논문.

## 핵심 아이디어

### PINN의 구조

표준 fully-connected neural network $u_\theta(x, t)$가 PDE 해 $u(x, t)$를 근사:

$$u_\theta(x, t) \approx u(x, t)$$

PDE residual $f_\theta(x, t)$를 **자동 미분(automatic differentiation)**으로 정의:

$$f_\theta := \frac{\partial u_\theta}{\partial t} + \mathcal{N}[u_\theta]$$

여기서 $\mathcal{N}$은 비선형 미분 연산자 (예: Burgers: $u u_x - \nu u_{xx}$).

### 손실 함수

두 항으로 구성:

| 항 | 역할 | 데이터 |
|:---|:-----|:------|
| $\mathcal{L}_{PDE} = \frac{1}{N_f}\sum\|f_\theta(x_f^i, t_f^i)\|^2$ | PDE compliance | collocation points (레이블 불필요) |
| $\mathcal{L}_{data} = \frac{1}{N_u}\sum\|u_\theta(x_u^i, t_u^i) - u^i\|^2$ | 경계/초기 조건 | 소량의 레이블 데이터 |

$$\mathcal{L}_{total} = \mathcal{L}_{PDE} + \mathcal{L}_{data}$$

→ PDE residual은 **레이블 없이** 계산 가능하므로, 반지도(semi-supervised) 학습에 해당.
→ 경계 조건은 소량의 데이터 포인트로만 enforce됨 (soft constraint 방식).

### PINN 알고리즘

1. 신경망 $u_\theta$ 정의 (입력: $x, t$, 출력: $u$)
2. 자동 미분으로 PDE residual $f_\theta$ 계산
3. Collocation points $(x_f, t_f)$에서 $f_\theta \approx 0$ loss 계산
4. 경계/초기 조건에서 $u_\theta \approx u$ loss 계산
5. 총 loss 최소화 (Adam + L-BFGS)

## 결과 / 성능

| 문제 | PDE | $L^2$ 상대 오차 | 특징 |
|:----|:----|:--------------:|:-----|
| Burgers 방정식 | $u_t + u u_x - (0.01/\pi) u_{xx} = 0$ | $5.4 \times 10^{-3}$ | shock front 정확히 포착 |
| Schrödinger 방정식 | $i\psi_t + 0.5\psi_{xx} - \|\psi\|^2\psi = 0$ | $7.8 \times 10^{-3}$ | 복소수 soliton 해 |
| Navier-Stokes (역문제) | 2D 유체 유동 | 우수 | 속도장 → 압력장 역추론 |
| Allen-Cahn 방정식 | $u_t - 0.0001 u_{xx} + 5u^3 - 5u = 0$ | $1.7 \times 10^{-2}$ | sharp interface |

## 역사적 의의

- **이전:** PDE를 푸는 전통적 방법(FEM, FDM, spectral)은 **meshing**이 필수였으며, 역문제(inverse problem)는 별도의 최적화 루틴 필요
- **PINN의 혁신:** 하나의 신경망이 정문제(forward)와 역문제(inverse)를 **동일한 프레임워크**에서 해결 — 역문제는 단순히 관측 데이터를 loss에 추가하면 됨
- **파급 효과:** PINN 발표 후, physics-informed ML은 기계공학, 유체역학, 재료과학, 생체역학 등 **전 분야**로 확산
- **한계 인식:** 이후 연구에서 PINN의 spectral bias(F-Principle), 복잡한 경계 조건 처리, 다중 스케일 문제에서의 성능 저하가 밝혀짐 → `pinn-failure-modes` 참조

## 융합 도메인 연결

| 발전 방향 | 관련 페이지 |
|:---------|:-----------|
| Hard constraint (정확한 BC) | [[hpinns-inverse-design]] |
| Bayesian UQ 추가 | [[bayesian-pinns]] |
| Surrogate modeling 확장 | [[physics-constrained-surrogate]] |
| 고속 유동 특화 | [[pinn-high-speed-flows]] |
| Operator learning (함수→함수) | [[deeponet]] |
| PINN vs hPINN 비교 | [[pinn-vs-hpinn]] |
| 고전 PINN vs DeepONet 비교 | [[pinn-vs-deeponet]] |

## References
- Raissi, M., Perdikaris, P., & Karniadakis, G. E. (2019). "Physics-informed neural networks: A deep learning framework for solving forward and inverse problems involving nonlinear partial differential equations." *J. Comput. Phys.*, 378, 686–707.
- [[maziar-raissi]] — PINN 제1저자
- [[paris-perdikaris]] — PINN 공동 창시자
- [[george-em-karniadakis]] — PINN, DeepONet 공동 창시자 (Brown CRUNCH)
