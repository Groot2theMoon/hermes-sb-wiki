---
title: "PILIR — Physics-Informed Local Implicit Representation for Spectral Bias Mitigation"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [paper, physics-informed, pinn, neural-operator, spectral-bias, neural-network]
confidence: medium
sources: [arXiv:2605.00385]
---

# PILIR — Physics-Informed Local Implicit Representation

## 개요
**Li, Wang, Tang (2026)** — arXiv:2605.00385 (cs.LG, May 2026)는 PINN의 spectral bias 문제를 **local implicit representation**으로 해결하는 프레임워크를 제안한다. 표준 MLP의 전역 파라미터 결합(global parameter coupling)이 저주파 학습을 우선시하는 문제를, 공간적으로 지역화된(localized) latent feature 공간을 통해 극복한다.

## 핵심 아이디어
- **이산 latent feature space + 연속 generative decoder:** 물리 도메인을 이산 학습 가능 격자(learnable grid)로 분할하여 명시적 공간 지역성(explicit spatial locality)을 인코딩
- **Generative neural operator:** 지역 latent feature를 연속 물리장(continuous physical fields)으로 합성
- **효과:** 고주파 디테일이 전역 패턴에 희석(dilution)되지 않아 spectral bias 완화 — 고주파 수렴 가속화 및 정확도 향상

## 연결점
- [[fourier-neural-operator]] — PINO 계열 vs PILIR의 local representation 접근법 비교
- [[physics-informed]] — 전통적 PINN의 spectral bias 한계와 PILIR의 해결책
- [[spectral-bias-pinn]] — PINN spectral bias 문제의 맥락

## References
- arXiv:2605.00385 — PILIR: Physics-Informed Local Implicit Representation
