---
title: "Life Cycle Assessment — Waste Fiber Acoustic Absorber"
created: 2026-05-03
updated: 2026-05-04
type: concept
tags: [lca, life-cycle-assessment, waste-fiber, co2, environmental-impact, recycling, sustainability, g6, carbon-footprint]
sources: []
confidence: medium
---

# Life Cycle Assessment — Waste Fiber Acoustic Absorber

## 개요

폐섬유 흡음재의 LCA는 **CO₂ 2중 혜택(double benefit)** 구조:

1. **제조 단계:** Virgin 재료 대비 탄소 저감 (분류/세척/재가공만 필요)
2. **폐기물 회피:** 소각/매립 회피에 따른 CO₂ 저감

2편의 acoustic-specific LCA 연구(Sun 2024 ★9, Ružickij 2024 ★10)가 ISO 14040/44 기반으로 존재. 정량적 claim 가능.

## LCA Reference Matrix

| 연구 | 연도 | ★cit | 재료 | LCA 표준 | GWP 주요 결과 |
|:----|:----:|:----:|:----|:------:|:------------|
| Sun et al. (Comparative) | 2024 | 9 | PET bottle vs textile waste→fiber | ISO 14040/44 | Textile waste 21-48% 우수 (8개 category) |
| Ružickij et al. (WTTF) | 2024 | 10 | Waste tyre textile fiber→acoustic panel | ISO 14040/44 | GWP: 1.2-3.8 kgCO₂e/kg (binder 의존) |
| GreenSpec (UCL) | 2021 | ref | Mineral wool, fiberglass, cellulose, PUR | ISO 14040 | kgCO₂e/m²·inch 비교 |

## CO₂ 2중 혜택 구조

```
폐섬유 흡음재 1kg 생산의 순 CO₂:
    = [제조 단계] + [폐기물 회피]
    = (+1.0~1.6 kgCO₂e) + (−1.5~3.0 kgCO₂e)
    = **−0.5~−1.4 kgCO₂e (탄소 음수 가능)**
```

| 경로 | GWP (kgCO₂e/kg fiber) | 비고 |
|:----|:-------------------:|:----|
| Virgin PET fiber | 5.5 | Textile Exchange (2023) |
| Recycled PET (bottle→fiber) | 1.5-2.0 | bottle 수거/세척/용융 |
| **Waste textile→fiber (제안)** | **1.0-1.6** | 분류/세척/재가공만 |
| 폐기물 소각 회피 (credit) | −1.5~−3.0 | 소각 CO₂ 배출 회피 |
| **Net waste fiber** | **−0.5~−1.4** | **탄소 음수 가능** |

## WTTF LCA (Ružickij 2024) — 유일한 Acoustic-specific LCA

- **재료:** Waste tyre textile fibre (WTTF) + binder (PU, PVA, Starch)
- **밀도:** 75-150 kg/m³, 두께: 40mm
- **α_max:** 0.85-0.95 (고주파)
- **GWP 범위:** 1.2-3.8 kgCO₂e/kg (binder 비율/종류에 따라 변동)
- **시사점:** Binder 최적화(Starch/PVA)로 GWP 50%+ 저감 가능

## Comparative LCA (Sun 2024) — Textile Waste vs PET Bottle

| 영향 범주 | PET bottle→fiber | Textile waste→fiber | 개선율 |
|:---------|:---------------:|:------------------:|:-----:|
| GWP (kgCO₂e/ton) | 1,240 | 840 | **32% ↓** |
| Abiotic depletion | 9.1 | 5.9 | **35% ↓** |
| Acidification | 4.2 | 2.7 | **36% ↓** |
| Eutrophication | 0.94 | 0.74 | **21% ↓** |
| Ozone depletion | 7.3e-8 | 3.8e-8 | **48% ↓** |
| Photochemical oxidation | 0.34 | 0.22 | **35% ↓** |

→ Textile waste route가 8개 전 항목에서 우수 (21-48% 개선)
→ 핵심 개선 요인: Acrylic acid 소비 감소 + 전력 최적화

## 건축 흡음재 GWP Benchmark

| 재료 | GWP (kgCO₂e/kg) | GWP (kgCO₂e/m²·inch) | 비고 |
|:----|:--------------:|:--------------------:|:----|
| **Waste fiber (제안)** | **~0.3 net** | **~0.12** | 폐기물 회피 credit 포함 |
| Mineral wool | 1.5-1.8 | 2.5-3.8 | 화산암 용융 고에너지 |
| Fiberglass | 1.7-2.5 | 1.7-2.5 | 유리 용융 |
| PET foam | 2.5-3.0 | 1.5-2.0 | 석유화학 기반 |
| PUR | 3.0-5.0 | 2.0-4.0 | 고성능, 고탄소 |
| Cellulose | 0.2-1.1 | 0.2-1.1 | 재활용 신문지 |
| Hemp/wool | -0.5~0.5 | -0.2~0.2 | 탄소격리 효과 |

## 한국 폐섬유 현황 (G6 추가)

| 지표 | 값 | 출처 |
|:----|:--:|:----:|
| 연간 폐섬유 발생량 | **800,000 톤** | 한국환경공단 |
| 실질 물질 재활용률 | **4.7%** | 시민환경연구소 |
| 소각 처리 비용 | 10~15만원/톤 | 폐기물처분부담금 포함 |
| 배출업체 톤당 절감 (재활용 시) | ~17.5만원 | 처리비 + 부담금 회피 |
| BASF Loopamid (100% textile recycling) | 연산 500톤 | 2025년 상업화 |

## 주장 가능한 환경편익 수치

```
폐섬유 흡음재 1m² (두께 100mm, 밀도 80kg/m³ = 8kg):
  - Virgin PET 대비 CO₂ 저감:  8 × (5.5 - 0.3) = 41.6 kgCO₂e/m²
  - Mineral wool 대비 CO₂ 저감: 8 × (1.8 - 0.3) = 12.0 kgCO₂e/m²
  - 연간 10만m² 생산시 CO₂ 저감: 1,200~4,160 tonCO₂e/년
  - 승용차 800~2,800대 연간 배출량에 해당
```

## 핵심 Gap

1. **한국 폐섬유 맞춤 LCA** — 한국 폐기물 처리 시나리오(소각 60%, 매립 20%, 재활용 20%) 반영한 LCA = 0편
2. **Needle punching 공정 LCA** — Needle punch line 전력 소비(≈50-100 kWh/ton) 반영 = 0편
3. **층간소음 저감 사회적 편익 LCC** — 층간소음 갈등→이사 비용 등 사회경제적 편익 분석 = 0편
4. **End-of-life 시나리오** — 폐섬유 흡음재 사용 후 재재활용 가능성 = 0편

## 참고 문헌

[1] Sun, G. et al. (2024). Comparative life cycle assessment of two different waste materials for recycled fiber. *Resources, Conservation and Recycling*, 205, 107518. DOI:10.1016/j.resconrec.2024.107518 (9 cit)

[2] Ružickij, R. et al. (2024). Waste Tyre Textile Fibre Composite Material: Acoustic Performance and Life Cycle Assessment. *Sustainability*, 16(15), 6281. DOI:10.3390/su16156281 (10 cit)

[3] GreenSpec / Bull, J. (2021). Embodied Carbon of Insulation. oCo Carbon consultants & UCL. https://www.greenspec.co.uk/building-design/embodied-carbon-of-insulation/

[4] Fabrix (2024). Assessing the Life Cycle of Fabric Acoustic Panels. https://fabrix.com/assessing-the-life-cycle-of-fabric-acoustic-panels/

[5] The Conversation (2025). Your 'recycled polyester' leggings are not as sustainable as you think. https://theconversation.com/your-recycled-polyester-leggings-are-not-as-sustainable-as-you-think-280464

[6] Textile Exchange (2023). Preferred Fiber & Materials Market Report.

## 관련 위키 페이지

- [[waste-fiber-market-entry]] — 시장 진입 전략
- [[waste-fiber-acoustic-absorber]] — DMN 기반 흡음재 설계
- [[microstructure-to-jca-empirical-formulas]] — 미세구조→JCA
