---
title: "CompNO — Compositional Neural Operators for Multi-Dimensional Fluid Dynamics"
created: 2026-05-17
updated: 2026-05-17
type: concept
tags: [neural-operator, cfd, surrogate-model, iclr, paper]
confidence: medium
sources: [arXiv:2605.11691]
---

# CompNO — Compositional Neural Operators (ICLR 2026)

## 개요

**Hamda Hmida, Hsiu-Wen Chang, Youssef Mesri (2026)** ^[arXiv:2605.11691]이 ICLR 2026에 발표한 **CompNO**는 복잡한 PDE를 **기본 물리 블록(Foundation Blocks)**의 라이브러리로 분해하여 조합하는 modular neural operator framework이다.

## 핵심 아이디어

- **Foundation Blocks**: 각 블록은 elementary physics에 특화된 Neural Operator (convection, diffusion, nonlinear convection, Poisson Solver)
- **Adaptation Block + Aggregator**: 블록 간 비선형 상호작용을 학습, data loss + physics residual로 훈련
- **평가**: Convection-Diffusion, Burgers', Incompressible Navier-Stokes에서 검증
- **장점**: elementary operator 학습이 적응성 향상, interpretability, pretrained block 재사용

## 의의

- Scientific Foundation Models(SFMs)의 높은 pretraining 비용과 제한된 interpretability 문제 해결
- Modular 접근법은 새로운 물리 시스템으로의 전이 학습을 용이하게 함

## 연결점
- [[fourier-neural-operator]] — FNO는 CompNO의 Foundation Block 구현 후보
- [[scno-spiking-compositional-neural-operator]] — SCNO도 composition 개념 사용, 접근 방식 차이
- [[neural-operator]] — NO의 modular composition 방향성

## References
- arXiv:2605.11691 — Published at ICLR 2026
