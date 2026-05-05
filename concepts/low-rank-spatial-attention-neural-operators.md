---
title: Low-Rank Spatial Attention for Neural Operators — Unifying Global Mixing Modules
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [architecture, surrogate-model, model, theory]
confidence: medium
---

# Low-Rank Spatial Attention for Neural Operators

## 개요
**LRSA (Low-Rank Spatial Attention)** (arXiv:2604.03582, 2026)는 PDE operator learning에서 사용되는 다양한 global mixing module(FNO의 Fourier layer, DeepONet의 trunk net, attention 등)을 **low-rank 관점에서 통합 해석**한다.

## 핵심 아이디어
- FNO, DeepONet, Galerkin/GNO 등 대표적 neural operator의 global mixing module이 모두 low-rank 연산의 특수한 경우임을 증명
- **LRSA block**: 표준 Transformer attention + low-rank projection으로 구성 — 추가 설계 없이 기존 operator architecture에 통합 가능
- 다양한 PDE benchmark(advection, Darcy, Navier-Stokes 등)에서 일관된 성능 향상
- 선행 연구 복잡한 설계 없이 **단순함(simplicity)이 핵심 장점**

## 연결점
- [[fourier-neural-operator]] — FNO의 spectral convolution과 LRSA의 저랭크 통합 해석
- [[surrogate-model]] — neural operator architecture 설계의 통일된 관점 제시
- [[transformer]] — attention mechanism의 operator learning 적용

## References
- arXiv:2604.03582 — Simple yet Effective: Low-Rank Spatial Attention for Neural Operators
