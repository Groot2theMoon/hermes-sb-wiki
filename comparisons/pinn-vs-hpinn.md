---
title: PINN vs hPINN — Soft vs Hard Constraint 비교
created: 2026-04-28
updated: 2026-04-28
type: comparison
tags: [comparison, physics-informed, optimization, mathematics, surrogate-model]
sources: [raw/papers/2102.04626v1.md]
confidence: high
---

# PINN vs hPINN — Soft vs Hard Constraint 물리 기반 ML 비교

**PINN (Physics-Informed Neural Networks)**은 PDE 제약을 loss function에 **soft penalty**로 추가하고, **hPINN (Hard-Constraint PINN)**은 penalty method 또는 augmented Lagrangian을 통해 제약을 **hard constraint**로 강제한다. 두 방법의 차이는 **제약 조건 처리 방식**에 있으며, 이는 최적화 정확도와 수렴 안정성에 직접적 영향을 미친다.

## 비교 표

| 차원 | PINN (Soft Constraint) | hPINN (Hard Constraint) |
|------|------------------------|-------------------------|
| **제약 처리 방식** | Loss = MSE_data + λ⋅MSE_PDE (soft penalty) | Penalty method 또는 Augmented Lagrangian (점진적 강화) |
| **PDE 잔차 만족도** | 근사적 (λ 가중치에 따라 변동) | **엄격함** (제약을 아키텍처/목적함수에 내장) |
| **수렴 안정성** | λ 튜닝이 까다로움 (불균형 시 학습 실패) | 비교적 안정적 (penalty 점진적 증가) |
| **역문제 (Inverse)** | 자연스럽게 확장 가능 | 확장 가능하나 제약 설정 복잡 |
| **Topology Optimization** | 부적합 (정확도 부족) | ✅ 특화됨 (holography, Stokes flow 성공) |
| **수치 PDE solver 의존성** | ❌ 불필요 | ❌ 불필요 |
| **하이퍼파라미터** | λ (PDE loss 가중치) | Penalty 계수 μ + Aug. Lagrangian multipliers |
| **아키텍처 복잡도** | 단순 (표준 FCN + loss 항 추가) | 중간 (제약 조건별 추가 네트워크/계층 필요) |
| **이론적 근거** | Automatic differentiation + PDE residual | Constrained optimization theory (KKT, Lagrangian) |
| **대표 응용** | Forward/inverse PDE 해석, 유체 역학 | **Inverse design, topology optimization** |
| **확장성** | 다양한 PDE에 적용 용이 | 제약 구조에 따라 설계 필요 |

## 핵심 차이: Soft vs Hard Constraint

| 개념 | Soft Constraint (PINN) | Hard Constraint (hPINN) |
|------|----------------------|------------------------|
| **PDE 만족** | Loss 항으로 추가 → λ에 의해 근사적 만족 | Penalty/augmented Lagrangian으로 **강제 만족** |
| **BC/IC 처리** | Loss 항으로 추가 (근사) | 출력 층에 **명시적 마스킹** 또는 **변수 변환** |
| **최적화 관점** | Unconstrained optimization (λ 무게 균형이 핵심) | Constrained optimization (KKT 조건 만족) |
| **정확도** | 적당한 λ에서 좋지만 PDE 정밀도 제한 | 동일 목적 함수 값에서 수치 solver 수준 정확도 |
| **학습 난이도** | 쉬움 (표준 SGD로 학습 가능) | 어려움 (augmented Lagrangian 수렴 보장 필요) |

## 실제 적용 예시 (hPINN 논문 기준)

| 문제 유형 | PINN | hPINN |
|-----------|------|-------|
| **Holography 역설계** | ❌ 부정확 | ✅ 성공 (adjoint method와 동등) |
| **Stokes flow 위상 최적화** | ❌ 제약 미달 | ✅ 성공 (수치 solver 불필요) |
| **단순 1D Burgers 방정식** | ✅ 우수 | ✅ 우수 (차이 미미) |
| **고차원 inverse design** | ❌ 불안정 | ✅ 가능 (Aug. Lagrangian으로 안정화) |

## 언제 무엇을 선택할까?

| 사용 사례 | 권장 |
|-----------|------|
| **단순 forward/inverse PDE 해석** | PINN (간단하고 빠름) |
| **Topology optimization / inverse design** | hPINN (정확도 필수) |
| **PDE 잔차의 엄격한 만족이 필요한 경우** | hPINN |
| **빠른 프로토타이핑 (여러 PDE 실험)** | PINN |
| **고정밀 공학 설계 (광학, 유체 최적화)** | hPINN |
| **제약이 복잡하고 다양한 경우** | PINN (확장 용이) |

## 발전 방향

hPINN의 hard constraint 접근은 PINN 생태계에서 점진적으로 확산되고 있다:
- **HPINN (Physics-Informed NN with Hard Constraints)** — Lu Lu et al. (2021)의 원조
- **Augmented Lagrangian PINN (AL-PINN)** — Adaptive penalty 계수 조정
- **Multi-task PINN** — 여러 제약을 별도 네트워크 헤드로 분리 처리
- **Constrained Bayesian PINN** — hPINN 개 념을 베이지안 프레임워크에 통합

## 관련 페이지

- [[hpinns-inverse-design]] — hPINN 상세
- [[physics-informed-neural-networks]] — PINN 상세
- [[physics-informed]] — 통합 프레임워크
- [[pinn-failure-modes]] — PINN이 실패하는 이유 (NTK 관점)
- [[bayesian-pinns]] — Bayesian PINN (또 다른 PINN 개선 방향)
