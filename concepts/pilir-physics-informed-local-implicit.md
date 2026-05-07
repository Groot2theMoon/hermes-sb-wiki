---
title: "PILIR — Physics-Informed Local Implicit Representation for Spectral Bias Mitigation"
created: 2026-05-07
updated: 2026-05-07
type: concept
tags: [physics-informed, pinn, neural-network, mathematics, paper, surrogate-model]
confidence: medium
sources: [arXiv:2605.00385]
---

# PILIR — Physics-Informed Local Implicit Representation

## 개요

**Li, Wang, Tang (2026)**^[arXiv:2605.00385]이 제안한 **PILIR**은 [[physics-informed-neural-networks|PINN]]의 근본적 한계인 **spectral bias (고주파 성분 학습 불가)**를 해결하기 위한 아키텍처다. PINN의 전역적 MLP가 저주파 우선 학습(spectral bias)으로 인해 고주파 PDE 해를 제대로 학습하지 못하는 문제를 극복한다.

## 핵심 아이디어

### Local Implicit Representation

1. **이산 잠재 특징 공간(discrete latent feature space)** — 물리 영역을 learnable grid로 분할하여 공간적 지역성(locality) 유지
2. **연속 생성 디코더(continuous generative decoder)** — 지역 잠재 특징을 연속 물리장으로 합성
3. **Generative neural operator** — 각 local grid cell의 특징을 물리적 PDE 해로 매핑

### PINN 대비 장점

| 항목 | 기존 PINN | PILIR |
|------|-----------|-------|
| 파라미터 결합 | 전역(global) | 지역(local) |
| 고주파 학습 | 느림 (spectral bias) | 빠름 (지역 분해) |
| Loss 구성 | 복잡 (항목별 가중치) | 간결 |
| 수렴 속도 | 느림 | 빠름 |

## 연결점
- [[pinn-failure-modes]] — PINN spectral bias 원인 (NTK eigenvalue imbalance)에 대한 보완 접근법
- [[deeponet]] — Neural operator 접근법과의 공통점 (generative operator)
- [[fourier-feature-embedding]] — 기존 spectral bias 해결책 (고주파 인코딩)과의 차이점
- [[physics-informed-neural-networks]] — PINN의 확장

## References
- arXiv:2605.00385 — PILIR: Physics-Informed Local Implicit Representation
