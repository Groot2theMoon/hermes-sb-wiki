---
title: "Deep Material Network (DMN) — 기본 아키텍처"
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [materials, surrogate-model, micromechanics, homogenization]
sources: []
confidence: high
sources: []
---

# Deep Material Network (DMN) — 기본 아키텍처

## 개요

Deep Material Network(DMN)은 Liu et al.(2019, JMPS)가 제안한 **물리 기반 surrogate model**로, 이진 트리(binary tree) 구조의 네트워크와 미세역학(micromechanics) building block을 결합한 프레임워크.

핵심 특징:
- **선형 탄성 데이터만으로 학습 → 비선형 거동 extrapolation 가능**
- 학습 가능한 파라미터가 **물리적 의미**(미세구조 형상)를 가짐
- 열역학 제법칙(monotonicity, convexity, dissipation inequality)이 아키텍처에 내장

참고: Liu M, Wu J. "Exploring the 3D architectures of deep material network in data-driven multiscale mechanics." *J. Mech. Phys. Solids*, 2019.

## 네트워크 구조

### 이진 트리 (Binary Tree)

- **N-layer binary tree**: root(Layer 1) = 균질화된 유효 RVE 응답
- Bottom layer(N)에는 2^(N-1)개의 노드 → 각각 구성 phase의 강성 C_k를 가짐
- 노드 간 연결: weighted activation (ReLU 기반: w^k = ReLU(z^k))
- Weight 축적: w^k_i = w^{2k}_{i+1} + w^{2k-1}_{i+1}
- 전체 building block 수: 2^(N-1) - 1개

### Building Block ℬ^k_i

각 building block은 두 가지 연산을 수행:

1. **회전 ℛ**(α, β, γ) — Tait-Bryan angles:
   - C' = R⁻¹ · C · R  (Mandel notation, 6×6)
   - 변형률: ε' = R · ε
   - 응력: σ' = R⁻ᵀ · σ

2. **균질화 ℋ**(w¹, w²) — 층상 복합재(luminate) 해석해:
   - Interface 법선을 3-방향으로 설정
   - Strain concentration tensor s¹ = (C̅ - C²)⁻¹ · (C¹ - C²)
   - C̅ = C² - f¹ · ΔC · s¹  (ΔC = C¹ - C²)

## Notation

DMN은 **Mandel notation** 사용 (3D 문제):

| 성분 | 3D Elasticity |
|:----|:----|
| 응력 벡터 | σ = (σ₁₁, σ₂₂, σ₃₃, √2·σ₂₃, √2·σ₁₃, √2·σ₁₂)ᵀ |
| 변형률 벡터 | ε = (ε₁₁, ε₂₂, ε₃₃, √2·ε₂₃, √2·ε₁₃, √2·ε₁₂)ᵀ |
| 강성 행렬 | C (6×6) |

Mandel notation의 장점: 변환 행렬 R이 직교(orthogonal)하여 에너지 노름 보존.

## Training (Offline)

**입력**: 두 phase의 강성 (Cᵖ¹, Cᵖ²) 쌍 — 다양한 이방성 탄성 조합
**출력**: DNS로 계산한 균질화 강성 C^DNS
**손실함수**:

L = (1/2N_s) Σ_s ‖C^DNS_s - DMN(Cᵖ¹_s, Cᵖ²_s, ...)‖² / ‖C^DNS_s‖² + λ · (Σ_j ReLU(zʲ) - 2^(N-2))²

파라미터: 각 building block의 (α, β, γ, z₁, z₂, z₃, z₄) — layer 당 7개.

## Online Prediction (비선형 Extrapolation)

- 각 bottom node: 독립적인 constitutive law (elasto-plastic, viscoplastic 등) 적용
- Newton-Raphson 반복으로 stress equilibrium 탐색
- Residual strain δσ → 0 수렴
- **계산 속도: DNS 대비 ~8,100배 향상** (N=8 기준)

## 2D vs 3D DMN

| 구분 | 2D (Liu 2019) | 3D (Liu & Wu 2019) |
|:----|:----|:----|
| Notation | Voigt (3성분) | Mandel (6성분) |
| C 차원 | 3×3 | **6×6** |
| 회전 DOF | 1 (θ) | 3 (α, β, γ) |
| Building block 파라미터 | 3개/층 | 7개/층 |

## 관련
- [[centimeter-nanomechanical-resonators]]

- [[waste-fiber-acoustic-absorber]]
 개념

- `thermoelastic-dmn` — [[dongil-shin|Shin]] 2024: 열팽창 균질화 통합
- `deep-material-network-quilting` — Shin 2023: DMN explainability 및 quilting 전략
- `decoding-material-networks` — DMN vs IMN 성능 비교
- `interaction-based-material-network` — IMN: 회전 없는 DMN 변형

## References

- [[decoding-material-networks]]
- [[fft-homogenization-polymer-composites]]
