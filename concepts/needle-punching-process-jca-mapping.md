---
title: "Needle Punching Process — Microstructure — JCA Parameter Mapping"
created: 2026-05-03
updated: 2026-05-05
type: concept
tags: [needle-punching, nonwoven, manufacturing, process-parameters, jca, acoustic-fibrous, acoustics]
sources: [raw/papers/messiry23-needle-punching-statistical.md]
confidence: medium
---

# Needle Punching Process — Microstructure — JCA Parameter Mapping

## 개요

Needle punching 공정변수(punch density, penetration depth, lattice speed, fiber diameter)와 JCA 5-parameter(σ, φ, τ, Λ, Λ') 사이의 경험적 관계. 현재 문헌은 통계적 상관관계 수준이며, 정량적 differentiable model은 존재하지 않음.

## 공정변수 범위 (산업 표준)

| 변수 | 범위 | acoustic 영향도 |
|:----|:----|:-------------|
| Punch density | 50-400 punch/cm² | ★★★ (σ 가장 민감) |
| Penetration depth | 5-30 mm | ★★ |
| Lattice speed | 0.5-3 m/min | ★ |
| Fiber diameter | 10-50 μm | ★★★ (σ ∝ d_f⁻²) |

## 공정변수 → JCA 파라미터 경향

| 공정변수 ↑ | φ | σ | τ | Λ, Λ' |
|:---------|:-:|:-:|:-:|:-----:|
| Punch density | ↓ | ↑↑ | — | ↓ |
| Penetration depth | ↓ | ↑ | — | ↓ |
| Lattice speed | ↑ | ↓ | ↑ (MD) | ↑ |
| Fiber diameter | ↑ | ↓↓ | — | ↑↑ |

## Messiry (2023) 통계 분석 결과

### 개요

El Messiry et al. (2023)는 재활용 폴리에스터 폐섬유와 virgin 폴리에스터 블렌드로 제조된 needle-punched 부직포의 흡음 성능에 대한 공정변수의 통계적 유의성을 ANOVA로 분석. 4개 공정변수 모두 5% 유의수준에서 통계적으로 유의한 영향을 확인.

### 시편 사양

| 변수 | 설정값 |
|:----|:------|
| Needle speed | 227, 245, 280 rpm |
| Lattice speed | 0.72, 1.47, 2.35 m/min |
| Penetration depth | 5, 10, 26 mm |
| Virgin:waste ratio | 100:0, 80:20, 60:40 % |
| Areal density | 166-287 g/m² |
| Thickness | 1.5-5 mm |
| Fiber length | 37.5-75 mm |
| Air permeability | 24.9-79.8 cm³/cm²/s |
| Mean pore diameter | 2.28-7.33 μm |

### ANOVA 결과 (Two-way, α=0.05)

| 변수 | SS | DF | MS | F | p-value | F_crit | 유의성 |
|:----|:-:|:-:|:--:|:-:|:------:|:-----:|:-----:|
| **Needle speed** | 29.91 | 2 | 14.95 | 21.57 | **0.000106** | 3.885 | ✅ 유의 |
| Frequency (block) | 540.83 | 6 | 90.14 | 130.04 | 3.29E-10 | 2.996 | |
| Error | 8.32 | 12 | 0.69 | | | | |
| **Lattice speed** | 47.93 | 2 | 23.96 | 18.60 | **0.000211** | 3.885 | ✅ 유의 |
| Frequency (block) | 450.41 | 6 | 75.07 | 58.26 | 3.53E-08 | 2.996 | |
| Error | 15.46 | 12 | 1.29 | | | | |
| **Penetration depth** | 47.24 | 2 | 23.62 | 30.53 | **1.96E-05** | 3.885 | ✅ 유의 |
| Frequency (block) | 578.42 | 6 | 96.40 | 124.61 | 4.23E-10 | 2.996 | |
| Error | 9.28 | 12 | 0.77 | | | | |
| **Waste amount** | 214.96 | 2 | 107.48 | 85.54 | **7.93E-08** | 3.885 | ✅ 유의 |
| Frequency (block) | 478.06 | 6 | 79.68 | 63.41 | 2.17E-08 | 2.996 | |
| Error | 15.08 | 12 | 1.26 | | | | |

### 표준화 회귀계수 (주파수별 변수 중요도)

| 주파수 (Hz) | Needle speed | Lattice speed | Penetration depth | Waste amount |
|:---------:|:----------:|:------------:|:----------------:|:-----------:|
| 400 | 0.173 | -0.447 | 0.334 | -0.420 |
| 600 | 0.342 | -0.454 | 0.399 | -0.567 |
| 800 | 0.175 | -0.503 | 0.731 | -0.743 |
| 1000 | -0.109 | -1.152 | 1.326 | -1.059 |
| 1200 | 0.234 | -0.862 | 0.923 | -1.426 |
| 1400 | 0.710 | -0.589 | 0.986 | -1.415 |
| 1600 | 0.741 | -1.691 | 0.718 | -1.062 |

**주요 발견:**
- **Waste amount**가 전 주파수 대역에서 가장 높은 중요도를 가짐 (음의 계수: 폐섬유 증가 → STL 감소)
- **주파수가 증가할수록 needle speed의 중요도 증가**, penetration depth의 중요도는 부분적 감소
- Lattice speed는 대부분의 주파수에서 음의 계수 (빠른 lattice speed → STL 감소)
- 변수 간 상관관계는 미미함 (correlation matrix: 최대 |r| = 0.067)

### 최적 공정 조건

- Needle speed: **280 rpm** (가장 높은 값)
- Lattice speed: **0.72 m/min** (가장 낮은 값)
- Penetration depth: **26 mm** (가장 높은 값)
- Waste ratio: **0% (virgin polyester)**
- STL vs frequency at optimum: 250-1600Hz 대역에서 최대 22dB 달성

### Stitch 밀도 효과

- Stitch 밀도(punch/cm²) 증가 → STL 증가
- Lattice speed ↓ → stitch density ↑ → STL ↑
- Lattice speed 0.72 m/min에서 stitch density 약 500 punch/cm²에서 STL 최대 (400Hz 기준)

## 핵심 문헌

### 폐섬유 needle punch acoustic (직접 관련)

[1] El Messiry, M., Al-Oufy, A.K., Ayman, Y., & Abdel Latif, S. (2023). Statistical analysis of the effect of processing machine parameters on acoustical absorptive properties of needle-punched nonwovens. *J. Engineered Fibers and Fabrics*, 18, 1-14. DOI: 10.1177/15589250231155623
→ 유일하게 폐섬유 + needle punch + acoustic을 동시에 다룸. 4개 변수 모두 통계적 유의 확인. ANOVA + 표준화 회귀분석으로 주파수별 변수 중요도 정량화.

### 일반 needle punch → 물성

[2] RSC Advances (2017). Influence of process parameters on needle punched nonwovens. — punch frequency > penetration depth 영향.

[3] Springer (2023). Effect of punch density on mechanical properties. — 최적 punch density 220-300 cm⁻².

## STL 예측 회귀 모델

Messiry (2023)는 실험 데이터 기반 STL 예측 다중회귀식 제시:

```
STL = f(NS, LS, DP, waste%, frequency)
```

여기서 NS = needle strokes/min, LS = lattice speed (m/min), DP = penetration depth (mm). 측정값과 계산값 간 높은 상관관계 확인 (Figure 12, R² ≈ 0.95+).

## DMN 연결

공정변수 → JCA 5-param의 정량적 differentiable model은 존재하지 않음. DMN이 이 gap을 채우는 핵심 도구. Messiry (2023)의 통계적 모델은 DMN 학습을 위한 사전 지식(prior) 및 feature importance 가이드로 활용 가능.

## Wikilinks
- [[waste-fiber-acoustic-absorber]] — Waste-fiber acoustic absorber
- [[jca-inverse-parameter-estimation]] — JCA parameter estimation
- [[microstructure-to-jca-empirical-formulas]] — Microstructure → JCA
