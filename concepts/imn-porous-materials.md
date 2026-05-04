---
title: "Interaction-based Material Network (IMN) for Porous Materials"
created: 2026-05-03
updated: 2026-05-04
type: concept
tags: [paper, dmn, imn, porous, homogenization, interaction-based]
sources:
  - raw/papers/nguyen23-imn-porous-interaction.md
confidence: high
---

# Interaction-based Material Network (IMN) for Porous Materials

## 개요

**Van Dung Nguyen**와 **Ludovic Noels**가 *International Journal of Plasticity* (Vol.160, 103484, 2023)에 발표. Rotation-free DMN을 기반으로 **다공질 재료(porous materials)**에 특화된 Interaction-based Material Network (IMN) 프레임워크.

DOI: [10.1016/j.ijplas.2022.103484](https://doi.org/10.1016/j.ijplas.2022.103484)

## IMN의 핵심 아이디어

### DMN의 한계 → IMN의 해결

기존 DMN은 다공질 재료(porous media, void-containing composites)에 적용 시:

- Void phase의 자유도 처리 문제
- Hill-Mandel 조건이 building block 레벨에서 보장되지 않음
- 회전 DOF로 인한 과도한 파라미터

IMN은 **rotation-free DMN** (Gajek et al.) 위에 구축되어 이러한 문제를 해결.

### 구조: Material Node + Material Network

IMN은 DMN의 이진 트리 구조를 두 요소로 분리:

1. **Material Nodes** (하단 노드):
   - 독립적인 재료 거동을 가진 N개의 material unit
   - 각 node: 고유한 변형률, 응력, 내부 변수 보유
   - 실제 재료 또는 void phase 할당

2. **Material Network** (상위 트리 구조):
   - M개의 tree node로 구성
   - 각 node = **interaction mechanism**
   - M개의 interaction set으로 RVE 내 material unit들을 그룹화
   - 각 interaction set은 **Hill-Mandel 조건**을 만족

### Interaction Parameters

각 interaction mechanism j는 두 가지 파라미터로 특성화:

| 파라미터 | 역할 | 설명 |
|:---------|:-----|:------|
| **Interaction direction Gⱼ** | Force-equilibrium 방향 | Interface 법선 벡터에 해당 |
| **Interaction incompatibility aⱼ** | 변형률 변동 | Deformation fluctuation 모드 |

### Interaction Mapping

온라인 예측 시 변형 구배의 분할:

```
δε_i = δε̄ + Σⱼ aⱼ ⊗ Gⱼ
```

- i: material node index
- j: interaction mechanism index
- Fluctuation part가 M개의 interaction mode로 분해

## DMN vs IMN 비교

| 측면 | DMN | IMN |
|:-----|:----|:----|
| **Building block** | 2-layer + rotation | Rotation-free interaction |
| **Layer 당 파라미터** | 7개 (α, β, γ, z₁, z₂, z₃, z₄) | 4개 (interaction params) |
| **회전 DOF** | 있음 | **없음** (rotation-free) |
| **De-homogenization** | Layer-by-layer Newton iteration | **행렬 연산**으로 단순화 |
| **Hill-Mandel 조건** | 전역적 | **각 interaction set에서 국소적** |
| **다공질 재료** | 제한적 | **특화됨** |
| **온라인 속도** | 빠름 | **DMN 대비 3.4~4.7배 추가 향상** |

## Training (Offline)

- Rotation-free DMN과 동일한 **선형 탄성 데이터 기반 학습**
- Interaction direction Gⱼ와 incompatibility aⱼ를 trainable parameter로 사용
- 학습 후 파라미터는 미세구조의 기하학적 특성을 인코딩

## Online Prediction

1. **Homogenization**: material node → root로 정보 상향 전파
2. **De-homogenization**: root → material node로 변형률 분배
   - IMN의 경우: interaction mapping을 단일 **행렬 곱셈**으로 처리
   - DMN의 경우: layer-by-layer Newton-Raphson 반복 필요
3. 각 material node에서 독립적인 constitutive law 평가

## Porous Materials에 대한 특화

### Void Phase 처리

- Void material node: **제로 강성 또는 매우 낮은 강성** 할당
- IMN의 interaction mapping이 void 주변의 변형률 집중을 자연스럽게 포착
- Hill-Mandel 조건이 void-material interface에서도 만족

### 장점

- 기존 DMN 대비 **더 적은 수의 material node**로 다공질 RVE 표현 가능
- 높은 porosity에서도 안정적인 수렴
- 다양한 void morphology (구형, 타원형, 불규칙)에 적용 가능

## 관련 개념

- [[deep-material-network]] — DMN 기본 아키텍처
- [[decoding-material-networks]] — DMN vs IMN 성능 비교
- [[dmn-overview-wei25]] — DMN 서베이 (IMN 포함)
- [[deep-material-network-quilting]] — DMN 확장
- [[thermoelastic-dmn]] — 열-기계 DMN

## References

- Nguyen VD, Noels L. "Interaction-based material network: A general framework for porous materials." *Int. J. Plasticity*, 160, 103484, 2023.
- Gajek S, Schneider M, Böhlke T. "On the realization of the deep material network for inelastic materials." *Comput. Methods Appl. Mech. Eng.*, 2020.
- Wan W-N, Wei T-J, Su T-H, Chen C-S. "Decoding Material Networks: DMN vs IMN Performance Comparison." *J. Mechanics*, 2024.
