---
title: "미세구조 → JCA 5-파라미터 경험식 변환"
created: 2026-05-03
updated: 2026-05-03
type: concept
tags: [jca, microstructure, fibrous-materials, empirical-formulas, garai-pompoli, bruggeman, allard]
sources:
  [
    raw/papers/acoustipy-jakep72-2026.md,
  ]
confidence: high
---

# 미세구조 → JCA 5-파라미터 경험식 변환

## 개요

JCA (Johnson-Champoux-Allard) 5-parameter (σ, φ, τ, Λ, Λ')는 다공성 재료의 미세구조(micro-CT, SEM)에서 측정 가능한 기하학적 파라미터(공극률 φ, 섬유 직경 d_f, bulk 밀도 ρ_b)로부터 경험식을 통해 계산 가능.

이 관계는 DMN(탄성 균질화)과 JCA(음향 전달)를 **병렬로 연결**하는 핵심 브리지.

## 핵심 원리

DMN 7×7 poroelastic stiffness tensor (C_6×6, α, M)와 JCA 5-parameters는 **서로 다른 물리 영역**을 기술하므로 직접 대수 변환 불가:

| 영역 | DMN 7×7 (탄성) | JCA 5-param (음향) |
|:----|:-------------|:-----------------|
| 물리량 | 응력-변형율 관계 | 음파 전파 특성 |
| 지배방정식 | Biot poroelasticity (full) | Biot rigid frame limit |
| 출력 | C_6×6, α, M | ρ̃(ω), K̃(ω) → Z_c, k_c |
| 미세구조 의존성 | fiber stiffness + geometry | pore geometry + fluid properties |

대신, **동일한 미세구조(φ, d_f, 배향 분포)로부터 두 경로가 병렬로 계산됨:**

```
Micro-CT → [FFT: DMN training → C_6×6, α, M → Norris → 7×7]
         → [Empirical: Garai-Pompoli, Bruggeman → JCA 5-param → TMM → α(f)]
```

## 섬유 재료 JCA 파라미터 경험식

### 1. 공극률 φ

- **직접 측정:** Micro-CT voxel count, gas pycnometer
- **Bulk 밀도로부터:** φ = 1 − ρ_b/ρ_f
  - ρ_b = bulk density (kg/m³), ρ_f = fiber material density (e.g., PET ≈ 1380 kg/m³)

### 2. 정적 기류 저항 σ (Static airflow resistivity)

**Garai-Pompoli model** (2005, polyester fiber validated):
```
σ = A · ρ_b^B · d_f^(-C)

A = 25.989  (polyester)
B = 1.404
C = 2
```
- 단위: σ [Pa·s/m²], ρ_b [kg/m³], d_f [μm]
- 적용 범위: d_f = 20-50μm, ρ_b = 10-200 kg/m³
- **참고:** R² ≈ 0.95 for single-component polyester fibers

**Bies-Hansen model** (1980, general fibers):
```
σ = K · ρ_b^1.61 · d_f^(-2)
```
- K = 1.5 × 10⁻⁵ (fiber-type dependent)

**Kozeny-Carman model** (general porous media):
```
σ = (180·η·(1-φ)²)/(d_p²·φ³)
```
- η = air viscosity (1.81 × 10⁻⁵ Pa·s)
- d_p = equivalent pore diameter
- 주의: 섬유재료보다 granular media에 더 적합

### 3. Tortuosity τ (α∞)

**Bruggeman relation:**
```
τ = φ^(-p)
```
- p = 0.5 (standard Bruggeman, 3D isotropic)
- 고공극률(>95%) 섬유: p = 0.3-0.5 범위

**고공극률 근사:**
- φ > 0.98: τ ≈ 1.0 (air-like)
- φ = 0.9-0.95: τ ≈ 1.02-1.05

### 4. Viscous characteristic length Λ

**원통형 섬유 가정 (Allard 1993):**
```
Λ = d_f / (2·√τ)
```

**섬유 배열 random:**
```
Λ = d_f · φ / (2·(1-φ))
```

### 5. Thermal characteristic length Λ'

**원통형 섬유 가정 (Allard 1993):**
```
Λ' = d_f / √τ
```

**일반적 관계:**
```
Λ' ≈ 2·Λ     (섬유재료, cylindrical pore 가정)
Λ' ≈ 1.5·Λ   (foam, irregular pore)
```

## 전형적 섬유 파라미터 예시

| 재료 | ρ_b [kg/m³] | d_f [μm] | φ | σ [Pa·s/m²] | τ | Λ [μm] | Λ' [μm] |
|:----|:-----------|:--------:|:-:|:----------:|:-:|:-----:|:------:|
| PET fiber | 50 | 20 | 0.964 | 11,300 | 1.018 | 9.9 | 19.8 |
| Glass wool | 30 | 8 | 0.978 | 18,500 | 1.011 | 3.97 | 7.95 |
| Needle-punched waste fiber | 80 | 25 | 0.942 | 25,800 | 1.030 | 12.3 | 24.6 |
| Melamine foam | 9 | — | 0.994 | 10,500 | 1.02 | 100 | 200 |

## 공정 변수 → JCA 파라미터 연결

Needle punching 공정 변수와 JCA parameter 사이의 관계는 추후 실험적 보정 필요:

| 공정 변수 | φ 영향 | σ 영향 | τ 영향 | Λ 영향 |
|:---------|:-----:|:-----:|:-----:|:-----:|
| Needle density ↑ | ↓ (미세) | ↑↑ | ↗ (미세) | ↓ |
| Needle penetration ↓ | — | ↗ (열압축) | — | — |
| Air-bow 적층 배향 제어 | — | ↓ (이방성) | ↑ | ↗ |
| Thermal bonding ↑ | ↓ | ↑↑ | ↗ | ↓↓ |

→ 이 관계는 **DMN 학습과 병행하여 실험 데이터로 fitting 필요.**

## DMN → JCA 파이프라인에의 의미

**초기 prototype**: JCA + TMM alone으로 충분 (고공극률 섬유, rigid frame valid)

**DMN 도입 Phase**: 역설계 최적화를 위해 필요
1. DMN: 미세구조(φ, d_f, 배향) → 탄성 특성 (구조 해석용)
2. 경험식: 동일 미세구조 → JCA 파라미터 (음향 해석용)
3. Joint optimization: "α(60Hz) ≥ 0.8 & E ≥ 1MPa" → 최적 미세구조

## 관련 위키 페이지

- [[transfer-matrix-method-acoustic-porous]] — TMM 개념
- [[waste-fiber-acoustic-absorber]] — DMN 기반 흡음재 설계
- [[poroelastic-dmn-research]] — 7×7 DMN 확장
- [[porous-nonwoven-homogenization]] — 부직포 균질화
- [[jca-inverse-parameter-estimation]] — JCA 역추정 (G2)

## 참고 문헌

- Garai, M. & Pompoli, F. (2005). A simple empirical model of polyester fibre materials for acoustical applications. *Applied Acoustics*, 66(12), 1383-1398.
- Bies, D.A. & Hansen, C.H. (1980). Flow resistance information for acoustical design. *Applied Acoustics*, 13(5), 357-391.
- Bruggeman, D.A.G. (1935). Berechnung verschiedener physikalischer Konstanten von heterogenen Substanzen. *Annalen der Physik*, 416(7), 636-664.
- Allard, J.F. & Atalla, N. (2009). *Propagation of Sound in Porous Media*, 2nd ed. Wiley. (Ch. 5: 7×7 poroelastic formulation; appendices: empirical formulas)
- Pelegrinis, M.T., Horoshenkov, K.V. & Burnett, A. (2016). An application of Kozeny-Carman flow resistivity model. *Applied Acoustics*, 103, 1-8.
