---
title: Pseudo Physics-Informed Neural Operator (PPI-NO)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, surrogate-model, model, paper]
sources: [raw/papers/4999_Pseudo_Physics_Informed_N.md]
confidence: high
---

# PPI-NO: Pseudo Physics-Informed Neural Operator

**PPI-NO**는 **정확한 물리 법칙 없이** rudimentary PDE 지식(기본 미분 연산자)만으로 surrogate physics system을 구축해 neural operator 학습을 향상시키는 프레임워크이다^[raw/papers/4999_Pseudo_Physics_Informed_N.md].

- **대리 물리 시스템(surrogate physics system)** — 목표 시스템을 단순 PDE로 근사
- Neural operator(FNO/DeepONet)와 **교대 업데이트**로 모델 성능 반복 향상
- **데이터 부족 상황**에서 큰 성능 향상 (Data scarce regimes)
- Darcy flow, nonlinear diffusion, Eikonal, Poisson, advection 방정식 + 피로 파괴(fatigue modeling) 검증
- [[physics-constrained-surrogate]] 및 [[fourier-neural-operator]]의 확장
- **사용자 융합 도메인(AI × Mechanics) 핵심 논문**