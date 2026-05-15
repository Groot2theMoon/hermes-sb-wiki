---
title: fpBPINN — Functional-Prior Bayesian Physics-Informed Neural Networks
created: 2026-05-15
updated: 2026-05-15
type: concept
tags: [paper, pinn, physics-informed, bayesian, uncertainty, inverse-problem]
confidence: medium
sources: []
---

# fpBPINN — Functional-Prior Bayesian PINNs

## 개요
**Ryoichiro Agata, Tomohisa Okazaki** (2026) — arXiv:2605.07060 (physics.geo-ph, cs.LG, physics.comp-ph). 기존 Bayesian PINN이 weight-space에서 사전 분포(prior)를 정의하는 반면, **함수 공간(function space)**에서 물리적으로 의미 있는 functional prior를 도입하는 통합 프레임워크(fpBPINN) 제안.

## 핵심 아이디어
- **FPI-BPINN:** Prescribed functional prior와 일관된 weight prior를 학습한 후 weight-space에서 Bayesian 추론
- **fParVI-PINN:** 함수 공간에서 직접 ParVI (Particle-based Variational Inference)로 Bayesian 추정
- **RFF (Random Fourier Features):** Gaussian functional prior를 신경망으로 표현하고 후방 근사(posterior approximation) 개선에 중요 역할
- **검증:** 1D 지진 주시 토모그래피(seismic traveltime tomography), 2D Darcy-flow 투과율 역문제
- **결론:** FPI-BPINN은 유연성(flexibility), fParVI-PINN은 정확도(accuracy)에서 각각 장점

## 연결점
- [[bayesian-pinns]] — 기존 B-PINN과 fpBPINN의 차이 (weight-space vs function-space prior)
- [[spectral-bias-pinn]] — PINN의 이론적 한계와 functional prior의 관계
- [[physics-informed]] — 물리 제약 조건이 Bayesian 추론과 결합

## References
- arXiv:2605.07060 — Functional-prior-based approaches to Bayesian PDE-constrained inversion using physics-informed neural networks
