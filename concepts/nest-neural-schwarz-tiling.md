---
title: "NEST — Neural-Schwarz Tiling for Geometry-Universal PDE Solving"
created: 2026-05-17
updated: 2026-05-17
type: concept
tags: [neural-operator, surrogate-model, pde, hybrid-modeling, mathematics, paper]
confidence: medium
sources: [arXiv:2605.12343]
---

# NEST — Neural-Schwarz Tiling for Geometry-Universal PDE Solving

## 개요

**Paolo Secchi, Daniel S. Balint, Marco Maurizi (2026)** ^[arXiv:2605.12343]가 제안하는 **NEST (Neural-Schwarz Tiling)**는 기존의 global-surrogate 패러다임에서 벗어나, **재사용 가능한 local 물리 솔버**를 학습하고 이를 **고전적 domain decomposition(Schwarz 반복법)**으로 조합하는 local-to-global framework이다.

## 핵심 아이디어

- **Local neural operator**: 최소 복셀 패치 (3×3×3)에서 다양한 local geometry와 경계 조건을 학습
- **Inference**: unseen voxelized domain을 overlapping patches로 tiling → patchwise 적용 → Schwarz coupling + partition-of-unity assembly
- **일반화 전환**: monolithic 모델 → "local physics learning + algorithmic global assembly"
- **평가**: 비선형 정적 평형 (compressible neo-Hookean solid)에서 검증, 학습 패치보다 훨씬 큰 3D 도메인에서 성능 확인

## 의의

- Global surrogate의 한계 (고정된 문제 분포, geometry 의존성)를 극복
- Domain decomposition과 neural operator의 결합이라는 새로운 방향
- 학습된 local solver가 geometry, 크기, 경계 조건 전반에서 재사용 가능

## 연결점
- [[fourier-neural-operator]] — NEST의 local solver로 사용 가능한 neural operator
- [[neural-operator]] — 기존 global-surrogate NO와의 차별점
- [[physics-informed]] — Physics-informed vs physics-encoded 접근법과의 비교

## References
- arXiv:2605.12343 — Neural-Schwarz Tiling for Geometry-Universal PDE Solving at Scale
