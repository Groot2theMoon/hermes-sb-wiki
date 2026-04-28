---
title: Uncertainty Quantification in Aeroelasticity
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, optimization, paper, comparison]
sources: [raw/papers/annurev-fluid-122414-034441.md]
confidence: high
---

# Uncertainty Quantification in Aeroelasticity

Beran, Stanford, Schrock (AFRL/NASA, 2017)의 **Annual Review of Fluid Mechanics** 리뷰 논문으로, **공탄성(aeroelasticity) 문제에서 불확실성 정량화(UQ)** 방법론을 종합 정리했다^[raw/papers/annurev-fluid-122414-034441.md].

- **공탄성 모델의 불확실성 출처:** 재료 특성, 공력 하중, 경계 조건, 제조 공차
- 비정상 공력(flutter, limit cycle oscillation)에서의 UQ 방법론
- Polynomial chaos expansion, Gaussian process emulator, Monte Carlo 방법 비교
- [[uncertainty-quantification-deep-learning]]과 함께 ML 기반 접근으로 확장 가능
- **사용자 융합 도메인(AI × 기계공학/유체역학) 핵심 참고 자료**
- [[uncertainty-quantification-deep-learning]] — ML 기반 UQ
- [[physics-constrained-surrogate]] — Surrogate modeling
