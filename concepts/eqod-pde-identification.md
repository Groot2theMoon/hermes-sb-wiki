---
title: "EqOD: Symmetry-Informed Stability Selection for PDE Identification"
created: 2026-05-13
updated: 2026-05-13
type: concept
tags: [mathematics, pde, learning-theory, surrogate-model, paper]
confidence: medium
sources: [arXiv:2605.11524]
---

# EqOD: Symmetry-Informed Stability Selection for PDE Identification

## 개요

**N'guessan & Bum Jun Kim (2026)** ^[arXiv:2605.11524]은 데이터 기반 **PDE 발견(PDE identification)** 을 위한 **EqOD (Equivariant Operator Discovery)** 를 제안한다. 후보 라이브러리 크기가 클수록 잡음 하에서 false positive가 증가하는 sparse regression의 근본적 한계를 해결한다.

## 핵심 아이디어

두 가지 라이브러리 축소 메커니즘을 결합: (1) 궤적 데이터에서 **Galilean 불변성**이 감지되면 대칭-축소 라이브러리 사용 (Galilean 제외 정리 증명), (2) 그렇지 않으면 **randomized LASSO stability selection** 적용. 8개 PDE × 4개 noise level에서 EqOD는 32개 실험 중 7개에서 승리, Heat 20% noise에서 $F_1=1.000$ (WF-LASSO 0.475, PySINDy 0.000).

## 연결점
- [[physics-informed-neural-networks]] — PINN은 PDE를 푸는 방법; EqOD는 PDE를 발견하는 방법
- [[pinn-failure-modes]] — 데이터 기반 PDE 발견의 잡음 민감성과의 관계
- [[pisml-sparse-neural]] — Sparse ML을 통한 물리 동역학 발견

## References
- arXiv:2605.11524 — EqOD: Symmetry-Informed Stability Selection for PDE Identification
