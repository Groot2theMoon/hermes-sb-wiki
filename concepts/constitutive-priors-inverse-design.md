---
title: "Constitutive Priors for Inverse Design — End-to-End Elastic Network Design"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [paper, inverse-design, surrogate-model, materials, mechanics, constitutive-modeling]
confidence: medium
sources: [arXiv:2605.09307]
---

# Constitutive Priors for Inverse Design

## 개요
**Han, Bahmani (2026)** — arXiv:2605.09307 (physics.comp-ph, May 2026)은 **탄성 네트워크(elastic network)의 역설계(inverse design)**를 위한 **end-to-end 프레임워크**를 제안한다. 구성 거동(constitutive behavior) 자체를 설계 변수로 직접 최적화하는 접근법으로, 기존의 매개변수화된 재료 모델에 의존하지 않는다.

## 핵심 아이디어
- **Constitutive prior:** 잡음이 있는 응력-변형률 데이터에서 잠재 표현(latent representation)으로 admissible 재료 법칙의 다양체(manifold)를 구성, 열역학적 일관성(thermodynamic consistency)을 강제
- **PDE-constrained optimization:** 역문제(inverse problem)를 잠재 구성 변수(latent constitutive variables)에 대한 PDE 제약 최적화로 정식화
- **Homotopy continuation:** 중간 목표 점군(intermediate target point clouds)을 affine registration으로 생성하여 비볼록 최적화의 강건성 향상
- **Chamfer distance:** 목표-참조 형상 간 메시 대응(mesh correspondence) 없이 최적화 가능
- **Smoothness prior:** 제조 제약 조건을 반영한 NN 기반 평활성 + 그래프 기반 평활성 메트릭

## 연결점
- [[deep-material-network]] — DMN도 재료의 constitutive behavior 학습; 본 연구는 역설계 문제로 확장
- [[inverse-design-materials]] — 재료 역설계의 일반적 맥락
- [[physics-informed]] — PDE 제약 최적화 접근법
- [[multi-fidelity-surrogate-composites]] — 복합재료 설계와의 연결점

## References
- arXiv:2605.09307 — Constitutive Priors for Inverse Design
