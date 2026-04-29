---
title: "Deep Material Network with Quilting Strategy"
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [paper, materials, surrogate-model, optimization]
sources: [raw/papers/shin-2023-deep-material-network-quilting.md, raw/papers/s41524-023-01085-6.md]
confidence: high
---

# Deep Material Network with Quilting Strategy: Visualization and Recursive Training

## 개요

[[dongil-shin|Dongil Shin]], Ryan Alberdi, Ricardo A. Lebensohn, Rémi Dingreville가 *npj Computational Materials* (2023)에 발표. Deep Material Network(DMN)의 가시화(explainability)와 정확도 향상을 위한 **quilting 전략** 제안.

## 배경

DMN은 이진 트리 구조의 물리 기반 surrogate model로, 선형 탄성 데이터만으로 학습하여 비선형 거동까지 extrapolation 가능. 그러나 기존 DMN은 무작위 초기화로 인해 calibration error(모델 불확실성)가 크고, 네트워크 파라미터의 물리적 해석이 어려움.

## 핵심 아이디어

### 1. DMN을 Analogous Unit Cell로 시각화

- 네트워크 파라미터(activation weight ω, normal vector n̂)를 3D unit cell 구조로 매핑
- Weight → 상(phase)의 부피 분율
- Normal vector → 계면(interface) 방향
- 다양한 시각화가 가능하지만 네트워크 학습 내용에 대한 직관적 이해 제공

### 2. Recursive Training via Quilting

- 학습된 얕은 DMN의 unit cell analog를 "patch"로 사용
- 4개 patch를 2×2 배열로 복제 → 새로운 층 추가 → 심층 네트워크 초기화
- 3D로 확장 시 2×2×2 큐브 배열
- 작은 perturbation(10⁻⁶)으로 대칭성 깨기
- **효과:** 잘 정의된 local optima에서 출발하여 더 나은 해 탐색

## 결과

- 무작위 초기화 대비 **낮은 training error + 더 좁은 stress 분포**(better calibration)
- 3D 미세구조에서 **40% calibration error → 크게 감소**
- 다양한 2D/3D 미세구조(포함 복합재, spinodal 분해)에서 일관된 성능 향상
- DMN unit cell analog를 직접 FFT 입력으로 사용 시 탄성 상수 차이 <1%

## 관련 개념

- `deep-material-network` — DMN 기본 아키텍처와 메커니즘
- `interaction-based-material-network` — IMN: 회전 없는 DMN 변형
- `micromechanics` — 미세역학, 복합재료의 균질화 이론
- `physics-informed-surrogate` — 물리 기반 Surrogate Modeling

## 의의

DMN의 explainability를 획기적으로 개선하고, quilting 전략을 통해 random initialization의 한계를 극복하여 더 정확하고 신뢰할 수 있는 multiscale materials modeling을 가능하게 함.

## References

- [[decoding-material-networks]]
