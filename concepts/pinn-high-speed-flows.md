---
title: Physics-Informed Neural Networks for High-Speed Flows
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, fluid-dynamics, CFD, model, paper]
sources: [raw/papers/1-s2.0-S0045782519306814-am.md]
confidence: high
---

# PINNs for High-Speed Flows

## 개요

Zhiping Mao, Ameya D. Jagtap, George Em Karniadakis (Brown University)가 제안한 **Physics-Informed Neural Networks (PINNs)을 고속 압축성 유동(Euler 방정식)에 적용**한 연구이다^[raw/papers/1-s2.0-S0045782519306814-am.md]. 충격파(shock wave)가 존재하는 고속 유동에서 PINNs의 정/역문제 해결 능력을 체계적으로 평가한다.

## 방법론

### Forward Problem

- **데이터**: 초기 조건 + 경계 조건 (IC/BCs)
- **Loss 함수**: $Loss = MSE_{IC} + MSE_{BC} + MSE_F$
- $MSE_F$: Euler 방정식의 잔차 (PDE 정보)
- 학습 포인트: **Clustered training points** — 불연속 영역 주변에 집중

### Inverse Problem (Hidden Fluid Mechanics)

- **데이터**: 밀도 구배 $\nabla \rho(x,t)$ (Schlieren photography 모방) + 단일점 압력 $p(x^*, t)$
- 추가 제약: 전역 질량/운동량 보존
- Euler 방정식의 **보존형(conservative form)** 및 **특성형(characteristic form)** 모두 사용

## 주요 결과

### Forward 문제
| 문제 유형 | 정확도 |
|-----------|--------|
| 1D Smooth solution | $O(10^{-5})$ |
| 1D Contact discontinuity | 우수 (clustered points) |
| 2D Oblique shock wave | 우수 (clustered points) |

### Inverse 문제
- **Sod 문제** 및 **Lax 문제** (Riemann problem) 해결
- 압력 프로브 위치 $x^*$ 가 중요: 충격 위치와 초기 불연속점 사이에 위치해야 함
- 특성형(characteristic form)이 보존형보다 Lax 문제에서 더 높은 정확도
- **Double precision**이 shock tube 문제에 필수
- **Equation of State (EOS)** 학습: $\gamma$ 식별에 clustered points + noisy data에서도 정확

## 핵심 발견

1. **Clustered training points**가 random/uniform 분포보다 충격파 포착에 효과적
2. 특성형 방정식이 강한 충격파에서 더 안정적
3. Euler 방정식 특성형이 Lax 문제에서 보존형보다 우수
4. 향후 방향: adaptive sampling (PDE 잔차 기반), meta-learning for architecture search

## References

- Z. Mao, A.D. Jagtap, G.E. Karniadakis, "Physics-informed neural networks for high-speed flows", *CMAME* 2020
- [[physics-informed-neural-networks]] — PINN 기본 개념
- [[pseudo-hamiltonian-neural-networks]] — 구조 보존 신경망
- [[fourier-neural-operator]] — Operator learning approach