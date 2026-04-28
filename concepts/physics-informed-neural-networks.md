---
title: Physics-Informed Neural Networks (PINN)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, model, neural-network]
sources: [raw/papers/1-s2.0-S0021999120306872-main.md]
confidence: high
---

# Physics-Informed Neural Networks (PINN)

**PINN**은 Raissi, Perdikaris, Karniadakis (2019)가 제안한 방법으로, 신경망이 PDE residual을 손실 함수에 직접 포함하여 **데이터 없이 물리 법칙만으로** 해를 근사한다.

- [[physics-informed]] — 상위 개념
- [[physics-constrained-surrogate]] — PINN을 surrogate modeling으로 확장
- [[bayesian-pinns]] — 불확실성을 고려한 Bayesian PINN
- [[pinn-failure-modes]] — NTK로 PINN 학습 실패 분석