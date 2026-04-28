---
title: "Decoding Material Networks: DMN vs IMN Performance Comparison"
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [paper, materials, surrogate-model, comparison]
sources: [raw/papers/wan-2024-decoding-material-networks.md]
confidence: high
---

# Decoding Material Networks: DMN vs IMN Performance Comparison

## 개요

Wen-Ning Wan, Ting-Ju Wei, Tung-Huan Su, Chuin-Shan Chen이 *Journal of Mechanics* (2024)에 발표. Deep Material Network(DMN)와 Interaction-based Material Network(IMN)의 포괄적인 비교 연구.

## DMN vs IMN

| 측면 | DMN | IMN |
|:----|:----|:----|
| **기본 구조** | 2-layer building block + 회전 행렬 | Material node 간 interaction 기반, 회전 불필요 |
| **학습 파라미터** | Layer 당 7개 (α, β, γ, z₁, z₂, z₃, z₄) | Layer 당 4개 (z₁, z₂, z₃, z₄) |
| **온라인 계산** | 회전 행렬 연산 추가 필요 | 회전 불필요 → **3.4~4.7배 속도 향상** |
| **정확도** | 유사 | 유사 (일부 케이스에서 DMN 우세) |
| **Extrapolation** | 선형 탄성 → 비선형 우수 | DMN과 유사 |

## 주요 발견

- IMN은 회전이 없는 단순화된 formulation으로 DMN 대비 **3.4~4.7배 빠른 온라인 예측**
- DMN은 특정 복잡한 변형 경로에서 더 높은 정확도
- 두 방법 모두 elastic training → nonlinear extrapolation에 효과적
- 네트워크 깊이가 깊어질수록 성능 차이 감소

## 관련 개념

- `deep-material-network` — DMN 기본 아키텍처
- `interaction-based-material-network` — IMN formulation
- `surrogate-model` — Surrogate modeling in multiscale materials
- `micromechanics-homogenization` — 미세역학 균질화 이론

## 의의

DMN과 IMN의 첫 번째 체계적인 비교 연구. IMN의 속도 이점과 DMN의 정확도 강점을 정량화하여, 문제 특성에 따라 적절한 방법론을 선택할 수 있는 가이드라인 제시.
