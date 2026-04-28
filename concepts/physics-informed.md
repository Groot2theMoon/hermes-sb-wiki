---
title: Physics-Informed Machine Learning
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, surrogate-model, model]
sources: [raw/papers/1-s2.0-S0021999119303559-main.md, raw/papers/1-s2.0-S0021999120306872-main.md]
confidence: high
---

# Physics-Informed Machine Learning

**Physics-Informed ML**은 물리 법칙(PDE, ODE, 보존 법칙)을 신경망 학습의 제약 조건으로 직접 통합하는 패러다임이다. 대표적 방법으로 PINN (Physics-Informed Neural Networks), Physics-Constrained Surrogate, B-PINNs 등이 있다.

- [[physics-constrained-surrogate]] — 레이블 없이 PDE 손실 함수만으로 학습
- [[bayesian-pinns]] — Bayesian 추론으로 불확실성 정량화
- [[pinn-failure-modes]] — NTK 관점에서 PINN 학습 실패 원인 분석
- [[pinn-high-speed-flows]] — 고속 유동에 PINN 적용
- [[hpinns-inverse-design]] — Hard constraints로 inverse design