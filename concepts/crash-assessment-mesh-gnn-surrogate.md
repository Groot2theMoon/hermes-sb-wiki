---
title: "Crash Assessment via Mesh-Based GNN and Physics-Aware Attention — Hybrid Surrogate for Structural Deformation"
created: 2026-05-13
updated: 2026-05-13
type: concept
tags: [surrogate-model, structural-analysis, neural-network, graph-neural-network, mechanics, paper]
confidence: medium
sources: [arXiv:2605.11784]
---

# Crash Assessment via Mesh-Based GNN and Physics-Aware Attention

## 개요

**Curtosi, Ruiz Ruiz, Cavaliere, Larráyoz Izcara (2026)** ^[arXiv:2605.11784]는 **자동차 충돌(crash) 시뮬레이션**을 위한 하이브리드 surrogate 모델을 제안한다. MeshTransolver, MeshGeoTransolver, MeshGeoFLARE 세 가지 아키텍처를 비교하며, 로컬 mesh message passing + geometry-aware global attention + sparse contact-aware correction을 결합한다.

## 핵심 아이디어

Mesh 기반 **GNN**이 국부적 구조적 상호작용을 처리하고, **geometry-aware global attention**이 장거리 변형 패턴을 포착한다. 자동회귀(autoregressive) crash rollout으로 시간에 따른 변형 필드를 예측. 산업용 lateral pole-impact benchmark에서 최고 하이브리드 모델이 temporal mean RMSE 3.20mm 달성.

## 연결점
- [[fourier-neural-operator]] — Neural operator 계열과의 방법론적 차이 (mesh-GNN vs spectral)
- [[surrogate-model]] — Crash 시뮬레이션을 위한 구조적 surrogate
- [[graph-neural-ode-structural-dynamics]] — 구조 동역학을 위한 그래프 신경망

## References
- arXiv:2605.11784 — Crash Assessment via Mesh-Based Graph Neural Networks and Physics-Aware Attention
