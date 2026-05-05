---
title: PI-JEPA — Label-Free Surrogate Pretraining for Coupled Multiphysics Simulation
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [surrogate-model, training, physics-informed, architecture]
confidence: medium
---

# PI-JEPA — Label-Free Surrogate Pretraining

## 개요
**PI-JEPA (Physics-Informed Joint-Embedding Predictive Architecture)** (arXiv:2604.01349, 2026)는 multiphysics surrogate를 위한 최초의 **label-free(self-supervised) pretraining framework**이다. Operator-split latent prediction을 통해 labeled simulation data 없이도 복잡한 coupled PDE의 surrogate를 학습한다.

## 핵심 아이디어
- [[i-jepa|I-JEPA]]의 self-supervised learning 아이디어를 물리 시뮬레이션 도메인으로 확장
- Lie–Trotter operator-splitting decomposition과 정렬된 **물리 제약적 module bank** 구성: 각 sub-process(pressure, saturation transport, reaction) 별 dedicated latent module
- Fine-tuning에 단 100개의 labeled simulation run만 필요
- FNO/PINO 대비 Darcy flow에서 1.8×, two-phase CO₂-water flow에서 2.7× 낮은 에러

## 연결점
- [[fourier-neural-operator]] — FNO 대비 data efficiency 우위
- [[surrogate-model]] — self-supervised paradigm이 surrogate modeling에 주는 시사점
- [[physics-informed]] — JEPA-style self-supervision에 물리 제약을 통합한 방식

## References
- arXiv:2604.01349 — PI-JEPA: Label-Free Surrogate Pretraining
