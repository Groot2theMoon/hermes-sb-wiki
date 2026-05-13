---
title: "CATO: Charted Attention for Neural PDE Operators — Geometry-Adaptive Neural Operator"
created: 2026-05-13
updated: 2026-05-13
type: concept
tags: [neural-operator, surrogate-model, mathematics, pde, transformer, paper]
confidence: medium
sources: [arXiv:2605.09016]
---

# CATO: Charted Attention for Neural PDE Operators

## 개요

**Cheng, Wang, Schönlieb, Aviles-Rivero (2026)** ^[arXiv:2605.09016]은 복잡한 **기하학(geometry)상의 PDE**를 위한 Charted Axial Transformer Operator (CATO)를 제안한다. 기존 transformer 기반 operator는 방대한 mesh point 처리가 비용이 많이 들고, raw 좌표계가 물리적 상호작용의 본질적 기하를 가린다.

## 핵심 아이디어

CATO는 **연속적인 잠재 차트(latent chart)** 를 학습하여 mesh 좌표를 학습된 차트 공간으로 매핑한다. 차트-조건화된(chart-conditioned) axial attention이 장거리 의존성을 효율적으로 포착한다. 추가로 **도함수-인지 물리 손실(derivative-aware physics loss)** 을 도입하여 steady-state PDE에서 솔루션 값, gradient, auxiliary flux 필드를 공동 감독한다. 이론적으로 차트 조건 axial attention이 저차원 axial solution operator를 표현할 수 있음을 증명.

모든 평가 데이터셋에서 최고 성능, 경쟁 baseline 대비 평균 26.76% 향상, 파라미터 81.98% 감소.

## 연결점
- [[fourier-neural-operator]] — FNO는 uniform grid에 특화; CATO는 임의 mesh geometry 처리
- [[transformer]] — Axial attention의 PDE operator 학습 적용
- [[deeponet]] — DeepONet과의 비교: branch-net 기반 vs attention 기반 접근법

## References
- arXiv:2605.09016 — CATO: Charted Attention for Neural PDE Operators
