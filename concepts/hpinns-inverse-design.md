---
title: hPINNs — Physics-Informed Neural Networks with Hard Constraints for Inverse Design
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, optimization, surrogate-model, mathematics, paper]
sources: [raw/papers/2102.04626v1.md]
confidence: high
---

# hPINNs — Physics-Informed Neural Networks with Hard Constraints for Inverse Design

## 개요

Lu Lu, Raphaël Pestourie, Wenjie Yao, Zhicheng Wang, Francesc Verdugo, Steven G. Johnson (2021)이 제안한 **hPINN**은 기존 PINN의 **soft constraint** 방식을 **hard constraint**로 대체하여 **topology optimization (위상 최적화)** 문제를 해결하는 새로운 딥러닝 방법이다^[raw/papers/2102.04626v1.md]. Inverse design(역설계) 문제는 일반적으로 PDE 제약 조건과 추가 부등식 제약이 있는 고차원 최적화 문제로, 기존 PINN은 모든 제약을 soft하게 처리하여 정확도가 떨어지는 단점이 있었다.

## 핵심 아이디어

### Hard Constraints via Penalty & Augmented Lagrangian

hPINN은 제약 조건을 **penalty method**와 **augmented Lagrangian method**로 강제한다:

- **Penalty method**: 제약 위반에 페널티 항을 추가하여 점진적으로 강화
- **Augmented Lagrangian**: Lagrange multipliers를 도입하여 정확한 제약 만족 달성

이를 통해 PINN이 PDE 제약을 엄격히 만족하면서도 topology optimization의 목적 함수를 최적화할 수 있다.

### 적용 분야

hPINN은 기존의 adjoint method + numerical PDE solver 기반 최적화와 동일한 목적 함수 값을 달성하면서도 **수치 PDE solver 없이** 동작한다:

1. **Holography (광학)**: 홀로그램 역설계 문제
2. **Stokes flow (유체)**: 점성 유체의 위상 최적화 문제

## 장점

- Numerical PDE solver 불필요 (end-to-end deep learning)
- 기존 adjoint 기반 방법과 동등한 정확도
- High-dimensional design space에서도 적용 가능
- [[physics-informed]] 접근의 hard constraint 버전

## 한계

- Penalty / Augmented Lagrangian의 하이퍼파라미터 튜닝 필요
- 복잡한 3D 문제로의 확장 검증 필요

## 관련 개념

- [[physics-informed]] — PINN의 기본 프레임워크
- [[transformer]] — 다른 domain의 neural architecture
- **Topology Optimization** — 역설계의 주요 형태