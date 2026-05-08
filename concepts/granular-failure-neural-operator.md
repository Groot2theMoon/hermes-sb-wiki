---
title: "Granular Micromechanics Failure Envelope Neural Operator"
created: 2026-05-08
updated: 2026-05-08
type: concept
tags: [neural-operator, deeponet, solid-mechanics, materials, surrogate-model, micromechanics, paper]
confidence: medium
---

# Granular Micromechanics Failure Envelope Neural Operator

## 개요

**Han, Poorsolhjouy, Bahmani et al. (2026)** ^[arXiv:2604.19027]이 제안하는 **미분 가능한 신경 연산자(differentiable neural operator)**는 **미세구조(microstructure) 구성 → 파손 포락선(failure envelope)** 매핑을 학습한다. DeepONet 기반 아키텍처를 사용하며, 불규칙 점군(point cloud)으로 표현된 파손 포락선을 학습하여 다중 해상도 데이터에서도 동작한다.

## 핵심 아이디어

- **입력:** granular material의 미세구조 구성 (입자 크기 분포, 형상비 등)
- **출력:** 파손 포락선 (failure envelope) — 불규칙 점군 형식
- **학습:** 미세역학(micromechanics) 시뮬레이션 데이터로 학습
- **Active learning:** 높은 epistemic uncertainty 영역을 적응적으로 쿼리하여 학습 효율 향상
- **차별화된 기능:** 순방향 예측 + 역방향 식별 (주어진 파손 포락선 → 미세구조 구성)
- 유한 차분(finite difference)과 자동 미분(automatic differentiation) 비교: FD가 실용적 trade-off 제공

## 연결점
- [[deeponet]] — 기반 아키텍처로 DeepONet 사용
- [[micromechanics-homogenization]] — granular media의 미세역학-거시거동 매핑
- [[fft-homogenization-composites]] — 대안적 multiscale 접근법 (연속체 기반)
- [[active-inference-ai-science]] — active learning 전략이 우도 기반 불확실성 추정과 연결

## References
- arXiv:2604.19027 — Neural Operator Representation of Granular Micromechanics-Based Failure Envelopes
