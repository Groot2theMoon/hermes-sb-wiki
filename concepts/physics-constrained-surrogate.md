---
title: Physics-Constrained Deep Learning for Surrogate Modeling
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, surrogate-model, FEM, model, paper]
sources: [raw/papers/1-s2.0-S0021999119303559-main.md]
confidence: high
---

# Physics-Constrained Surrogate Modeling

Zhu, Zabaras, Koutsourelakis, [[paris-perdikaris|Perdikaris]] (2019)가 Journal of Computational Physics에 발표한 논문으로, **레이블 데이터 없이 물리 법칙만으로 고차원 Surrogate Model을 학습**하는 방법을 제시한다^[raw/papers/1-s2.0-S0021999119303559-main.md].

- **Physics-constrained:** PDE 손실 함수를 직접 최적화 (레이블 데이터 불필요)
- **고차원 uncertainty quantification** — Stochastic PDE의 불확실성 전파
- 딥러닝 기반 surrogate model으로 기존 FEM/스펙트럼 방법 대체
- **비정상(non-stationary) stochastic 과정**에서도 적용 가능
- [[universal-approximation-theorem]] 및 PINN 계열 연구의 중요한 확장
- **사용자 융합 도메인(AI × Mechanics) 핵심 논문**
- [[pinn-failure-modes]] — PINN 실패 분석
- [[bayesian-pinns]] — Bayesian PINN
- [[fourier-neural-operator]] — FNO
