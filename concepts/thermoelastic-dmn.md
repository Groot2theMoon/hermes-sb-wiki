---
title: "Thermoelastic Deep Material Network"
created: 2026-04-28
updated: 2026-05-03
type: concept
tags: [paper, materials, surrogate-model, thermomechanics, homogenization]
sources: [raw/papers/shin-2023-deep-material-network-quilting.md]
confidence: medium
---

# Thermoelastic Deep Material Network

## 개요

[[dongil-shin|Dongil Shin]](신동일), Ryan Alberdi, Ricardo A. Lebensohn, Rémi Dingreville가 *Composites Part B: Engineering* (Vol.272, 111177, 2024)에 발표. 기존 isothermal [[deep-material-network|DMN]]을 **thermo-elasto-viscoplastic** 문제로 확장. 열팽창 특성을 building block homogenization에 직접 통합하고, thermal boundary condition을 online formulation에 포함시킴.

DOI: [10.1016/j.compositesb.2023.111177](https://doi.org/10.1016/j.compositesb.2023.111177)

## 핵심 확장 사항

### 1. Building Block에 열팽창 균질화 통합

기존 DMN building block은 두 phase의 **강성 텐서 C**를 homogenization했다면, thermoelastic DMN은 **열팽창 계수 α**를 추가로 포함시킴:

- 각 phase: (C_k, α_k) — C_k는 6×6 stiffness (Mandel notation), α_k는 6-성분 thermal expansion vector
- Building block에서 homogenization:
  - **기계적 균질화**: 표준 DMN laminate theory와 동일 (interface equilibrium & compatibility)
  - **열팽창 균질화**: thermal eigenstrain ε^th = α·ΔT를 homogenization 과정에 반영
  - 결과: homogenized (C̅, α̅) 쌍이 다음 layer로 전달

### 2. 온라인 예측 시 Thermal Boundary Condition

- Online prediction 단계에서 온도 변화 ΔT가 각 phase에 독립적으로 인가됨
- 각 building block에서 Newton-Raphson iteration 시 thermal residual strain을 포함:
  - δσ = C : (δε - δ·α·ΔT)
  - Residual = δσ_homogenized → 0 수렴

### 3. Uncertainty Quantification 및 Inverse Design

- DMN의 계산 효율성을 활용한 **Monte Carlo UQ** 시연
- **Inverse design** — 목표 응답을 만족하는 재료 조합 탐색

## Building Block 상세

### Formulation (6×6 Matrix Form)

DMN은 **Mandel notation**을 사용하여 3차원 탄성 문제를 표현:

- 응력/변형률: 6-성분 벡터 (σ₁₁, σ₂₂, σ₃₃, √2·σ₂₃, √2·σ₁₃, √2·σ₁₂)
- 강성 텐서: 6×6 행렬 C
- 열팽창 계수: 6-성분 벡터 α (α₁₁, α₂₂, α₃₃, 0, 0, 0 — 등방/직교 이방성의 경우)

각 building block의 연산:

1. **Rotation** ℛ(α, β, γ): Tait-Bryan 각을 이용한 6×6 회전 변환
   - C' = R⁻¹(α, β, γ) · C · R(α, β, γ)
   - α' = R⁻¹(α, β, γ) · α

2. **Homogenization** ℋ: 두 phase의 (C₁, α₁)과 (C₂, α₂)로부터 유효 (C̅, α̅) 계산
   - Strain concentration tensor s¹: (C̅ - C₂)⁻¹ · (C₁ - C₂)와 interface 조건으로 결정
   - C̅ = f₁·C₁·A₁ + f₂·C₂·A₂ (Mori–Tanaka 유사, 단 laminate geometry)
   - α̅도 동일한 concentration tensor로 균질화

## Thermomechanical Coupling

| 모드 | Isothermal DMN (기존) | Thermoelastic DMN (Shin 2024) |
|:----|:----|:----|
| **Building block I/O** | C₁, C₂ → C̅ | (C₁, α₁), (C₂, α₂) → (C̅, α̅) |
| **Online state** | σ, ε | σ, ε, ΔT |
| **Constitutive law** | σ = C : ε | σ = C : (ε - α·ΔT) |
| **Extrapolation** | elasto-plastic, viscoplastic | **thermo-elasto-viscoplastic** |

## 관련 개념

- `deep-material-network-quilting` — Shin 2023: DMN explainability 및 quilting 전략
- `deep-material-network` — DMN 기본 아키텍처와 메커니즘
- `decoding-material-networks` — DMN vs IMN 성능 비교
- `dmn-overview-wei25` — DMN 서베이 (열-기계 DMN, MIpDMN 등 포함)
- `imn-porous-materials` — IMN 프레임워크 (다공질 재료)
- `micromechanics-homogenization` — 미세역학 균질화 이론
- [[deeponet-poroelastic-surrogate]] — Park, Shin & Choo 2025: DeepONet 포로탄성 surrogate (열탄성 DMN → Norris 대응 → 포로탄성 DMN과 비교 가능)

## 의의

첫 번째로 DMN 프레임워크에 **열-기계 연성(thermomechanical coupling)**을 체계적으로 통합한 연구. Building block 하나만 수정하면 되므로, 기존 DMN 코드베이스에 최소한의 변경으로 thermoelastic 확장이 가능함을 입증. UQ 및 inverse design으로의 응용 가능성도 제시.
