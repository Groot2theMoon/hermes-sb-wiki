---
title: PPI-NO — Pseudo Physics-Informed Neural Operator
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [physics-informed, neural-operator, surrogate-model, paper]
sources: [raw/papers/4999_Pseudo_Physics_Informed_N.md]
confidence: medium
---

# PPI-NO (Pseudo Physics-Informed Neural Operator)

## 개요

**Pseudo Physics-Informed Neural Operator (PPI-NO)**는 Neural Operator에 물리 법칙을 **soft constraint**로 인코딩하는 중간적 접근법이다. 완전한 PINN처럼 residual loss를 직접 계산하지 않고, 학습된 기초해석(physics-informed basis)을 operator 구조에 통합한다.

## Neural Operator 계열에서의 위치

| 방법 | 물리 인코딩 | 해석성 | 범용성 |
|------|:----------:|:----:|:----:|
| **FNO** | 없음 (pure data) | 낮음 | 높음 |
| **DeepONet** | 없음 (pure data) | 중간 | 높음 |
| **PPI-NO** | Soft (basis) | 높음 | 중간 |
| **PINN** | Hard (residual loss) | 높음 | 낮음 (retrain per PDE) |

PPI-NO는 **data-driven operator learning의 범용성**과 **PINN의 물리적 정합성**을 절충한다.

## 핵심 아이디어

1. **Physics-informed basis functions:** PDE의 해 공간을 나타내는 기저 함수를 사전 학습
2. **Operator mapping:** 입력 함수 → 기저 계수 매핑 학습
3. **Pseudo-constraint:** 명시적 residual loss 없이 기저의 물리적 의미로 정규화

## 장단점

| 장점 | 단점 |
|------|------|
| PINN보다 빠름 (residual loss 불필요) | 완전 PINN보다 물리 정합성 약함 |
| FNO보다 물리적 해석 가능 | 기저 선택에 의존적 |
| Few-shot 일반화 가능 | 새로운 PDE마다 기저 재학습 필요 |

## References

- [[fourier-neural-operator]] — Pure data-driven operator
- [[deeponet]] — Branch-trunk architecture
- [[physics-informed-neural-networks]] — Hard constraint 접근
- [[pseudo-differential-neural-operator]] — 관련 PDNO 접근
