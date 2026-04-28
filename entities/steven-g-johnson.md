---
title: Steven G. Johnson
created: 2026-04-28
updated: 2026-04-28
type: entity
tags: [person, mathematics, optimization, photonics]
sources: [raw/papers/2102.04626v1.md]
---

# Steven G. Johnson

**MIT 응용수학 교수, 수치 최적화 및 PDE 방법론의 거장.** Meep (FDTD) 및 NLopt 라이브러리 창시자. hPINN의 공동 연구자이며, **adjoint method 기반 위상 최적화(topology optimization)**의 세계적 권위자.

## 주요 기여

### hPINN — Hard Constraint PINN for Inverse Design
Lu Lu, Pestourie, Yao, Wang, Verdugo, **Johnson** (MIT, 2021)이 공동 제안한 [[hpinns-inverse-design]]는 [[physics-informed-neural-networks]]의 soft constraint 방식을 **hard constraint (Penalty / Augmented Lagrangian)**으로 대체하여 수치 PDE solver 없이 topology optimization 문제를 해결한다.

### 수치 최적화 및 광학 설계
Johnson은 **topology optimization (위상 최적화)**, **전자기 및 광학 역설계(inverse design)** 분야에서 수많은 기초 알고리즘을 개발했다. Meep (FDTD 시뮬레이터), NLopt (비선형 최적화 라이브러리)의 창시자로 오픈소스 과학 컴퓨팅 생태계에도 크게 기여했다.

### Adjoint Method
Johnson은 **adjoint sensitivity analysis**를 대규모 전자기/광학 최적화에 적용하여 딥러닝의 backpropagation과 유사한 원리로 설계 공간을 효율적으로 탐색하는 방법을 정립했다.

## 연구 분야
- Numerical optimization for inverse design
- Photonic crystal / metamaterial design
- Adjoint method and sensitivity analysis
- FDTD simulation (Meep)
- Machine learning for PDE-constrained optimization

## 관계

- [[hpinns-inverse-design]] — Johnson이 공동 창시한 개념
- [[physics-informed-neural-networks]] — hPINN의 기반
- [[pinn-vs-hpinn]] — Soft vs Hard constraint 비교
- [[lu-lu]] — hPINN 공동 연구자
