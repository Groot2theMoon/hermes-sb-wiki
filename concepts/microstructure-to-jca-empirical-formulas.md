---
title: "미세구조 → JCA 5-파라미터 경험식 변환"
created: 2026-05-03
updated: 2026-05-04
type: concept
tags: [jca, microstructure, fibrous-materials, empirical-formulas, garai-pompoli, bruggeman, allard, needle-punch, process-parameters, g4]
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

## 공정 변수 → 미세구조 관계 (G4)

### 개요

Needle punching 공정변수와 JCA parameter 사이의 정량적 관계는 **현재 통계적-경험적 수준에 머물러 있음**. 미분 가능한 end-to-end 모델은 존재하지 않으며, 이는 G4의 핵심 갭.

### 주요 문헌 (인용 순)

| 논문 | 연도 | ★cit | 핵심 내용 |
|:----|:----|:----:|:---------|
| Yilmaz et al. | 2011 | 100 | Porosity, fiber size, layering → SAC. 표준 reference. |
| Shahani et al. | 2014 | 75 | Fiber type/fineness/cross-section, areal density, **punch density** |
| Applied Acoustics | 2022 | 24 | Natural/synthetic fiber, punch density → compactness → α (비단조) |
| El Messiry et al. | 2023 | 6 | **유일한 recycled polyester waste + 공정변수 연구.** Needle speed, lattice speed, punch density, stroke frequency → SAC (ANOVA + 회귀) |
| Leshchenko et al. | 2024 | 4 | Bulk density → fiber orientation fraction → permeability 계수. 유일한 microstructure 정량 모델 |
| Prahsarn et al. | 2020 | 8 | Fiber denier (7 vs 15), hole config, multi-layer + perforated rubber |
| σ empirical model | 2024 | — | σ = exp(6.454 + 0.039·ρ_b − 0.028·d_f), R²=0.949 (203 PP samples) |

### 공정변수 ↔ JCA 파라미터 관계 (실험 기반)

| 공정 변수 | φ | σ | τ | Λ | 비고 |
|:---------|:-:|:-:|:-:|:-:|:----|
| Punch density ↑ (10→30 cm⁻²) | ↓ (미세) | ↑↑ (비단조) | ↗ (미세) | ↓ | 최적점 존재, excessive → fiber damage |
| Needle speed ↑ (strokes/min) | ↓ | ↑ | ↗ | ↓ | Fiber entanglement ↑ → σ↑ |
| Lattice/belt speed ↑ | ↑ | ↓ | ↓ | ↑ | Areal density ↓ |
| Needle penetration depth ↑ | — | ↗ | ↑ (z-dir) | ↓ | z-orientation ↑ (Leshchenko 2024) |
| Fiber linear density ↓ (finer) | → | ↑↑ | ↑ | ↓↓ | 더 많은 fiber surface area |
| Hollow/circular cross-section | ↑ (hollow) | ↓ | ↑ | ↑ | Hollow conjugated > hollow > circular |
| Air-blow 압력 ↑ | → | ↓ (in-plane) | ↑ (thickness) | — | Fiber orientation distribution 변화 |
| Blend ratio (waste:virgin) | ↑ (waste↑) | ↑ | ? | ? | **데이터 전무** (El Messiry 2023 유일) |

### 정량적 관계 (현재까지 확인된 것)

**σ 예측 (needle-punched nonwoven, thin & low-density):**
```
σ = exp(6.454 + 0.039·ρ_b − 0.028·d_f)   [203 PP samples, R²=0.949]
```
- 적용 범위: t < 20mm, ρ_b < 50 kg/m³
- ISO 9053-1 airflow resistivity test

**Garai-Pompoli (PET fiber, 일반):**
```
σ = 25.99 · ρ_b^1.404 · d_f^(-2)          [R²≈0.95, polyester staple fiber]
```
- 적용 범위: d_f = 20-50μm, ρ_b = 10-200 kg/m³
- 폐섬유 매트(고밀도, 두꺼움)에는 적용 범위 확인 필요

**Leshchenko permeability model (유일한 orientation 정량화):**
```
K_coeff = f(ρ_bulk, ρ_fabric)              [fiber orientation fraction in airflow direction]
P(z) = K_coeff · K_0                       [permeability from orientation]
```
- Bulk/fabric density → perpendicular fiber fraction → permeability

### 공정변수 → JCA 5-param 전체 파이프라인

```
공정변수 (punch density, needle speed, belt speed, N_depth, d_f, blend ratio)
    │
    ▼  [경험식/통계 모델 — 미분 가능 모델 없음]
ρ_b, φ, σ
    │
    ▼  [Bruggeman, Allard 경험식 — 미분 가능]
τ = φ^(-0.5),  Λ = d_f/(2√τ),  Λ' = d_f/√τ
    │
    ▼  [JCA dynamic density & bulk modulus]
TMM → α(f)
```

### 핵심 갭 (Closed-loop 제어 불가 원인)

1. **미분 가능 공정변수→미세구조 모델 없음** — Needle speed/lattice speed/punch density를 JCA param으로 미분 가능하게 연결 = **0편**
2. **폐섬유(waste fiber) 특화 모델 부재** — El Messiry (2023) 외 0편
3. **Punch density → tortuosity/Λ 정량 모델 없음** — 정성적 관계만 있음
4. **Needle penetration depth → z-direction anisotropy 미연결** — Leshchenko (2024)가 방향성 계수 예측하나 acoustics 연결 안 됨
5. **Air-blow 공정 변수와의 관계 없음** — Fiber orientation distribution과 air-blow 압력 관계 = 0편
6. **폐섬유 혼합물(blend ratio) 효과 없음** — PET + waste blend ratio 영향 = 0편

### 기회 (Novelty)

**"Needle Punch 공정변수 → JCA 5-param 미분 가능 ML surrogate"** — El Messiry (2023) 데이터 + Yilmaz (2011) porosity 관계 + Garai-Pompoli σ 모델 통합:
- 입력: (P_punch, N_depth, v_belt, d_f, ρ_b, blend_ratio)
- 출력: (σ, φ, τ, Λ, Λ')
- DMN+GAP-SBM 파이프라인에 미분 가능 연결
- **현재 0편 — novelty gap 확인됨**

### 참고 문헌 (G4 추가)

- Yilmaz, N.D. et al. (2011). Effects of porosity, fiber size, and layering sequence on sound absorption performance of needle-punched nonwovens. *J. Applied Polymer Science*. DOI:10.1002/app.33312
- Shahani et al. (2014). The Analysis of Acoustic Characteristics and Sound Absorption Coefficient of Needle Punched Nonwoven Fabrics. *J. Engineered Fibers and Fabrics*. DOI:10.1177/155892501400900210
- Acoustic behaviour of needle punched nonwoven structures from natural and synthetic fibers (2022). *Applied Acoustics*, 199, 109043. DOI:10.1016/j.apacoust.2022.109043
- El Messiry, M. et al. (2023). Statistical analysis of the effect of processing machine parameters on acoustical absorptive properties of needle-punched nonwovens. *J. Engineered Fibers and Fabrics*. DOI:10.1177/15589250231155623
- Leshchenko, T.A. et al. (2024). Orientation of Fibers in Needle-Punched Nonwoven Fabrics. *Fibre Chemistry*, 55, 323-327. DOI:10.1007/s10692-024-10484-4
- Prahsarn, C. et al. (2020). Sound absorption performance of needle-punched nonwovens and their composites with perforated rubber. *Discover Applied Sciences*. DOI:10.1007/s42452-020-2401-4
- Development of an empirical model for the prediction of the airflow resistivity of thin and low-density fibrous materials (2024). *J. Measurements in Engineering*. DOI:10.21595/jme.2024.23382
- Influence of airflow resistance on acoustic behaviour of needle-punched nonwoven structures (2024). *J. Textile Institute*. DOI:10.1080/00405000.2024.2343152

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
