---
title: Physics-Informed Machine Learning
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, surrogate-model, model]
sources: [raw/papers/1-s2.0-S0021999119303559-main.md, raw/papers/1-s2.0-S0021999120306872-main.md, raw/papers/trending/2026-04-28-04.md]
confidence: high
---

# Physics-Informed Machine Learning

**Physics-Informed ML**은 물리 법칙(PDE, ODE, 보존 법칙)을 신경망 학습의 제약 조건으로 직접 통합하는 패러다임이다. 대표적 방법으로 PINN (Physics-Informed Neural Networks), Physics-Constrained Surrogate, B-PINNs 등이 있다.

- [[physics-constrained-surrogate]] — 레이블 없이 PDE 손실 함수만으로 학습
- [[bayesian-pinns]] — Bayesian 추론으로 불확실성 정량화
- [[pinn-failure-modes]] — NTK 관점에서 PINN 학습 실패 원인 분석
- [[pinn-high-speed-flows]] — 고속 유동에 PINN 적용
- [[hpinns-inverse-design]] — Hard constraints로 inverse design

## 2026년 최신 동향

- **Retrain-free 패러다임**: [[in-context-modeling-physics]] — ICM은 in-context learning을 물리 시스템에 도입, 단일 forward pass로 재학습 없이 일반화
- **Physics-Informed Temporal U-Net** (arXiv:2604.23372): U-Net에 VGG perceptual loss + parabolic boundary bridge 결합, 유체 interpolation에서 기존 대비 5배 이상 MAE 개선
- **AI hallucination**: [[ai-hallucination-physics]] — 유동 AI 모델이 물리 법칙을 위반하는 가상 해를 생성하는 현상 최초 보고

→ 각각의 상세 내용은 해당 개념 페이지 참조