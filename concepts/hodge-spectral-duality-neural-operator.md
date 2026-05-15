---
title: HSD-NO — Topology-Preserving Neural Operator via Hodge Spectral Duality
created: 2026-05-15
updated: 2026-05-15
type: concept
tags: [paper, neural-operator, model, mathematics, theory, pde, geometry, icml-2026]
confidence: medium
sources: []
---

# HSD-NO — Hodge Spectral Duality Neural Operator

## 개요
**Dongzhe Zheng, Tao Zhong, Christine Allen-Blanchette** (2026) — ICML 2026, arXiv:2605.13834 (cs.LG, cs.AI, cs.CG). Physical field equations의 solution operator를 기하학적 mesh에서 학습할 때, **Hodge 직교성(Hodge orthogonality)**을 활용해 학습 불가능한 위상(topological) 자유도와 학습 가능한 기하(geometric) 동역학을 분리하는 프레임워크.

## 핵심 아이디어
- **Hodge 직교성:** 미분 형식 공간에서 Hodge decomposition으로 spectral interference를 근본적으로 해결
- **Hodge Spectral Duality (HSD):** Operator splitting 기반의 원리적 operator-level 분해
- **Hybrid Eulerian-Lagrangian 아키텍처:** 이산 미분 형식(discrete differential forms)으로 위상-지배 성분 포착 + orthogonal auxiliary ambient space로 복잡한 국소 동역학 표현
- **결과:** 기하 그래프에서 우수한 정확도와 효율성, 물리적 불변량에 대한 충실도 향상. ICML 2026 게재

## 연결점
- [[fourier-neural-operator]] — 기존 FNO가 Fourier 공간에서 작동하는 반면, HSD-NO는 미분 형식 공간에서 Hodge 분해 기반으로 위상-기하 분리
- [[deeponet]] — DeepONet과 다른 operator learning 접근법 (Hodge 이론 기반의 inductive bias)
- [[operator-learning]] — Operator learning 일반론과 HSD-NO의 차별점

## References
- arXiv:2605.13834 — Topology-Preserving Neural Operator Learning via Hodge Decomposition (ICML 2026)
