---
title: "Delany-Bazley and Miki Empirical Models for Porous Sound Absorbers"
created: 2026-05-03
updated: 2026-05-05
type: concept
tags: [delany-bazley, miki, empirical-model, baseline, fibrous-materials, airflow-resistivity]
sources: [raw/papers/garai05-polyester-empirical-model.md]
confidence: high
---

# Delany-Bazley and Miki Empirical Models for Porous Sound Absorbers

## 개요

Delany-Bazley (1970)는 **flow resistivity σ 단 하나**만으로 다공성 섬유재료의 특성 임피던스 Z_c와 복소파수 k_c를 예측하는 경험적 모델. Miki (1990)는 저주파에서의 비물리적 거동을 보정. 두 모델 모두 φ ≈ 1.0인 고공극률 섬유에 한정.

## 수식

Frequency parameter: X = f / σ (f in Hz, σ in N·s/m⁴)

### Delany-Bazley (1970)

Z_c = ρ₀c₀ [1 + 0.0571·X^(-0.754) - j·0.087·X^(-0.732)]
k_c = ω/c₀ [1 + 0.0978·X^(-0.700) - j·0.189·X^(-0.595)]

**유효 범위:** 0.01 < f/σ < 1.0
- 저주파 한계: f/σ < 0.01에서 surface impedance real part가 음수 → 비물리적
- φ ≈ 1.0인 섬유에만 valid

### Miki (1990)

Z_c = ρ₀c₀ [1 + 0.0696·X^(-0.632) - j·0.107·X^(-0.632)]
k_c = ω/c₀ [1 + 0.109·X^(-0.632) - j·0.160·X^(-0.632)]

**개선점:**
- 지수를 −0.632로 통일 → 저주파 물리적 일관성 확보
- 더 넓은 f/σ 범위에서 valid

### Komatsu (2008)

D-B/Miki 계수 재-fitting, 저유동저항 재료 정확도 향상.
800 Hz ~ 5 kHz에서 오차 <5% 클레임.

### Garai & Pompoli (2005) — Polyester Fibre Model

Garai & Pompoli는 **폴리에스터 섬유(PET fiber)** 재료 전용의 경험적 모델을 제시. 유리섬유(glass wool, φ ≈ 1.0 μm)와 달리 폴리에스터 섬유는 직경 18-48 μm로 훨씬 크며, Bies-Hansen 모델로 flow resistivity를 예측하면 심각한 과소 추정(underestimation)이 발생. 38개 샘플(밀도 10-120 kg/m³, 두께 10-120 mm)을 기반으로 모델 계수 재정의.

**NMR (New Resistivity Model):**

σ = A · ρ_m^B

| Model | A | B |
|:------|:-:|:-:|
| Bies-Hansen (glass wool, d=33μm) | 2.920 | 1.53 |
| **NMR (polyester)** | **25.989** | **1.404** |

- σ: airflow resistivity (Pa·s/m²), ρ_m: bulk density (kg/m³)
- 적용 범위: ρ_m = 12-60 kg/m³ (110 kg/m³ 샘플은 비균질로 제외)
- 평균 편차 9.8%. Bicomponent 섬유 비율이나 표면 열처리(2SL) 영향은 유의미하지 않음.

**NMI (New Impedance Model):**

Delany-Bazley power-law form 유지, 8개 계수 C₁-C₈ 재-fitting:

Z_c = ρ₀c₀ [1 + C₁·X^(-C₂) - j·C₃·X^(-C₄)]
k_c = ω/c₀ [1 + C₅·X^(-C₆) - j·C₇·X^(-C₈)]

| 계수 | Delany-Bazley | Dunn-Davern | **NMI** |
|:----:|:------------:|:-----------:|:-------:|
| C₁ | 0.057 | 0.114 | **0.078** |
| C₂ | 0.754 | 0.369 | **0.623** |
| C₃ | 0.087 | 0.099 | **0.074** |
| C₄ | 0.732 | 0.758 | **0.660** |
| C₅ | 0.189 | 0.168 | **0.159** |
| C₆ | 0.595 | 0.715 | **0.571** |
| C₇ | 0.098 | 0.136 | **0.121** |
| C₈ | 0.700 | 0.491 | **0.530** |

**MI (Integrated Model)** = NMR + NMI: 오직 bulk density와 thickness만으로 흡음률 예측 가능.
- NMI 평균 편차: 3.1% (D-B 4.7%, Dunn-Davern 3.9% 대비 34%/20% 개선)
- MI (NMR+NMI) 전체 평균 편차: 3.0%

**의의:** 폴리에스터 섬유는 유리섬유보다 직경이 크고 밀도-저항 관계가 완전히 다르므로, D-B/Miki 계열 모델을 그대로 적용하면 큰 오차 발생. Garai-Pompoli 모델은 폐섬유 기반 nonwoven의 흡음 예측에도 중요한 reference가 됨.

## 정확도 비교

| 조건 | D-B/Miki 오차 | JCA 오차 | 비고 |
|:----|:-----------:|:--------:|:----|
| φ > 0.98, 500-4000 Hz | 5-10% | 3-8% | D-B acceptable |
| φ = 0.90-0.95 (nonwoven) | **15-30%** | 5-12% | **폐섬유 범위** |
| φ < 0.90, foams | 사용 불가 | 10-15% | D-B rigid frame 위반 |
| 저주파 <200 Hz | 10-25% | 5-15% | Miki 개선 |
| 압축된 섬유 | 30-50% | 10-20% | D-B 심각한 오차 |

## Waste Fiber Project 의미

폐섬유 nonwoven의 φ ≈ 0.94에서 D-B/Miki의 φ ≈ 1.0 가정이 깨져 15-30% 오차 발생. 이 오차가 DMN이 JCA 파라미터를 미세구조에서 학습하여 극복할 수 있는 gap. D-B/Miki는 **"왜 DMN-JCA가 필요한가?"** 를 증명하는 baseline.

## 참고 문헌

- Delany, M.E. & Bazley, E.N. (1970). Acoustical properties of fibrous absorbent materials. *Applied Acoustics*, 3(2), 105-116.
- Miki, Y. (1990). Acoustical properties of porous materials — Modifications of Delany-Bazley models. *J. Acoust. Soc. Jpn. (E)*, 11(1), 19-24.
- Allard, J.F. & Champoux, Y. (1992). New empirical equations for sound propagation in rigid frame fibrous materials. *JASA*, 91(6), 3346-3353.
- Komatsu, T. (2008). Improvement of the Delany-Bazley and Miki models for fibrous sound-absorbing materials. *Acoust. Sci. Tech.*, 29(2), 121-129.
- Garai, M. & Pompoli, F. (2005). A simple empirical model of polyester fibre materials for acoustical applications. *Applied Acoustics*, 66, 1381-1396.

## Wikilinks
- [[transfer-matrix-method-acoustic-porous]] — TMM for porous materials
- [[jca-inverse-parameter-estimation]] — JCA parameter estimation
- [[microstructure-to-jca-empirical-formulas]] — Microstructure → JCA
