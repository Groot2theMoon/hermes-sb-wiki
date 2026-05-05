---
title: SCNO — Spiking Compositional Neural Operator for Neuromorphic PDE Solving
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [surrogate-model, architecture, pinn, model, neural-network]
confidence: medium
---

# SCNO — Spiking Compositional Neural Operator

## 개요
**SCNO (Spiking Compositional Neural Operator)** (arXiv:2604.11625, 2026)는 최초의 **compositional spiking neural operator**로, 각 elementary differential operator(convection, diffusion, reaction)에 대해 개별 spiking neural operator block을 학습하고, 이를 input-conditioned aggregator로 조합하여 unseen coupled PDE를 해결한다.

## 핵심 아이디어
- 기존 monolithic neural operator(단일 네트워크로 PDE 학습)의 한계를 극복하기 위해 **모듈식 조합(compositional)** 접근 채택
- Spiking neural network(SNN) 기반 block은 95K 파라미터만으로 monolithic DeepONet(462K) 대비 최대 65% 낮은 L2 에러 달성
- 5 coupled PDE 시스템 평가에서 SCNO with correction이 최고 성능
- **Forgetting-free expansion**: 새 differential operator block을 추가해도 기존 성능 유지

## 연결점
- [[fourier-neural-operator]] — 전통적 neural operator와 SCNO의 차별점: compositional modularity
- [[physics-informed]] — PDE surrogate에서 물리 지식 활용 방식의 차이
- [[surrogate-model]] — SCNO를 surrogate modeling의 새로운 패러다임으로 위치

## References
- arXiv:2604.11625 — SCNO: Spiking Compositional Neural Operator
