---
title: "Multi-fidelity Surrogate Modeling for Composite Mechanics — Comprehensive Review"
created: 2026-05-07
updated: 2026-05-17
type: concept
tags: [surrogate-model, materials, mechanics, survey, paper]
confidence: medium
sources: [arXiv:2605.02871]
---

# Multi-fidelity Surrogate Modeling for Composite Mechanics

## 개요

**Haizhou Wen, Elham Kiyani, Gang Li, Srikanth Pilla, George Em Karniadakis, Zhen Li (2026)** 의 리뷰 논문^[arXiv:2605.02871]은 **복합재료(composites) 역학**을 위한 **multi-fidelity surrogate modeling** 방법론을 체계적으로 정리한다. 복합재료의 예측 모델링은 고가의 고충실도(hf) 시뮬레이션과 저렴한 저충실도(lf) 데이터를 결합하여 해결한다.

## 핵심 내용

### 방법론 스펙트럼

| 방법 | 설명 | 적용 |
|------|------|------|
| **Co-Kriging** | 두 fidelity 간 cross-covariance 모델링 | 고전적 MFGP |
| **Coregionalization model** | Multi-output GP (LMC, ICM) | 다중 충실도 |
| **Auto-regressive (AR1)** | Kennedy-O'Hagan 계층적 GP | 순차적 충실도 |
| **NARGP** | 비선형 AR GP | 복잡한 비선형 관계 |
| **MF-DGP** | Deep GP 확장 | 대규모 데이터 |
| **MF-NN** | Multi-fidelity neural networks | 데이터 효율성 |

### Composite Mechanics 응용

| 역할 | 예시 |
|------|------|
| **Forward prediction** | 재료 설계 공간 탐색 |
| **Inverse optimization** | 파라미터 동정, 최적 설계 |
| **Workflow integration** | 이종 데이터 소스 융합 |

## 연결점
- [[deep-material-network]] — DMN은 single-fidelity surrogate; MF 접근법과의 차이/보완 관계
- [[surrogate-model]] — 일반적인 surrogate modeling 맥락
- [[bayesian-optimization]] — MFBO는 multi-fidelity Bayesian optimization의 핵심
- [[gaussian-processes]] — GP 기반 MF 방법들의 기반

## References
- arXiv:2605.02871 — Submitted to Composites Part B: Engineering
