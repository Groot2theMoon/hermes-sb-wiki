---
title: Surrogate Modeling — Physics-Constrained Data-Driven Approximation
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [surrogate-model, physics-informed, model, training]
sources: []
confidence: high
---

# Surrogate Modeling

## 정의

**Surrogate model (대리 모델)**은 고비용 시뮬레이션(FEM, CFD, MD)을 저비용 근사 모델로 대체하는 기법. 물리적 정합성을 유지하면서 100-1000× 속도 향상이 목표.

## 주요 접근법

| 접근법 | 대표 모델 | 물리 제약 | 속도 |
|--------|----------|:---------:|:----:|
| Pure data-driven | GP, RF | 없음 | 빠름 |
| Physics-informed | [[physics-informed-neural-networks|PINN]] | Hard (residual) | 빠름 |
| Operator learning | [[fourier-neural-operator|FNO]], [[deeponet|DeepONet]] | 없음/Soft | 매우 빠름 |
| Hybrid | [[physics-constrained-surrogate]] | Soft | 빠름 |

## 융합 도메인 맥락

AI×Mechanics 연구의 핵심 등장배경: FEM 해석 1회에 수 시간 → surrogate model로 실시간 예측 → 최적화/제어에 활용.

## References
- [[physics-informed-neural-networks]]
- [[fourier-neural-operator]]
- [[deeponet]]
- [[deep-material-network]]
- [[deep-kernel-multitask-gp-vehicle-dynamics]]


- [[structured-hybrid-mechanistic-models]] — Structured Hybrid Mechanistic Models
