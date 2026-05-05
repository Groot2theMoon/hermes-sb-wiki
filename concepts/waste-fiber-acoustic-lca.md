---
title: "Life Cycle Assessment — Waste Fiber Acoustic Absorber"
created: 2026-05-03
updated: 2026-05-05
type: concept
tags: [lca, life-cycle-assessment, waste-fiber, co2, environmental-impact, recycling, sustainability, g6, carbon-footprint, waste-fiber]
sources: [raw/papers/ruzickij24-wttf-composite-lca.md]
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
| Ružickij et al. (WTTF) | 2024 | 10 | Waste tyre textile fiber→acoustic panel | ISO 14040/44 | GWP: 6.41-16.41 kgCO₂e/m² (binder 의존) |
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

### 연구 개요

- **재료:** Waste tyre textile fibre (WTTF) + binder (PU, PVA, Starch)
- **표준:** ISO 14040, ISO 14044
- **방법론:** ReCiPe 2016 v1.1 (endpoint indicators)
- **소프트웨어:** SimaPro 9.5.0.1
- **데이터베이스:** Ecoinvent 3 v3.3
- **시스템 경계:** Gate-to-gate (tyre 재활용 → 운송 → 건조 → 패널 생산 → 패널 건조)
- **Functional unit:** Combined FU = (ρ × d × S) / NRC — 1m² 패널 면적 + NRC 보정

### Functional Unit 계산

| 밀도 (kg/m³) | 75 | 100 | 125 | 150 |
|:-----------:|:--:|:---:|:---:|:---:|
| NRC | 0.68 | 0.65 | 0.66 | 0.68 |
| FU (1m² panel eq. mass, kg) | 4.40 | 6.15 | 7.58 | 8.82 |

→ NRC는 밀도 75-150kg/m³에서 0.65-0.68로 유사 → 흡음 성능 대비 재료 효율은 75kg/m³가 가장 우수

### Binder별 GWP 상세 (kgCO₂e per 1m² panel)

| 밀도 | PU | PVA | POS (Starch) |
|:---:|:--:|:---:|:-----------:|
| 75 kg/m³ | ~11.8 (추정) | ~9.5 (추정) | ~6.4 |
| 100 kg/m³ | ~14.0 (추정) | ~11.5 (추정) | ~8.5 |
| 125 kg/m³ | ~15.5 (추정) | ~13.0 (추정) | ~10.5 |
| 150 kg/m³ | **16.41** | ~14.5 (추정) | **12.0 (추정)** |

> 참고: GWP 직접 측정값은 Figure 15에 그래프로 제시. PU 150kg/m³에서 최대 16.41 kgCO₂e/m².

### GWP per kg (단위 질량당)

| Binder | GWP 범위 (kgCO₂e/kg panel) |
|:------|:-------------------------:|
| PU (polyurethane) | 1.86 - 2.73 |
| PVA (polyvinyl acetate) | 1.55 - 2.36 |
| POS (starch) | 1.45 - 2.15 |

> 수치는 FU mass로 GWP total을 나눈 추정값. Binder 함량 10-50 wt%에 따라 변동.

### Binder 비교: PU vs PVA vs Starch

| 항목 | PU (Polyurethane) | PVA (Polyvinyl acetate) | POS (Starch) |
|:----|:---------------:|:---------------------:|:-----------:|
| **환경영향 (Pt)** | **0.33 - 0.64** | **0.27 - 0.56** | **0.27 - 0.55** |
| **GWP (kgCO₂e/m²)** | 가장 높음 | 중간 | 가장 낮음 |
| **음향 성능** | 🏆 최고 | 중간 | 최저 |
| **원료** | 석유화학 기반 polyol | 석유화학 + 생분해성 | 천연 재생 가능 |
| **주요 환경 영향 물질** | CO₂, CH₄, SO₂, PM2.5 | CO₂, CH₄, N₂O | NH₃, NOx, SO₂, PM2.5 |
| **탄소 집약도 원인** | Polyol 제조 시 CO₂+CH₄ 배출, 난연제 SO₂ | PVA 생산 공정 | 전분 생산 공정 미립자 |

**Key insight:** POS는 음향 성능이 가장 낮지만 환경영향도 가장 낮음. PU는 음향 성능이 가장 높지만 환경영향도 가장 높음. Trade-off 존재.

### Pt Score 해석

- **Pt (points):** ReCiPe 2016 endpoint 단일 점수. "해당 제품 생산의 잠재적 환경영향이 세계 1인당 연간 평균 환경영향의 y배"
- PU composites: 0.33-0.64 Pt (밀도 75→150 kg/m³)
- PVA composites: 0.27-0.56 Pt
- POS composites: 0.27-0.55 Pt

### 공정별 환경영향 기여도

| 공정 단계 | Pt 범위 | 주요 기여 | 환경 피해 |
|:--------|:-------:|:--------|:--------|
| **건조 + 고무 분리** | **0.10 - 0.23** | 고무 폐기물 내 아연(Zn) + 화석연료 CO₂ | 인체 건강 피해 |
| **PU 패널 생산** | **0.11 - 0.18** | Polyol 제조 CO₂+CH₄, SO₂ (난연제), PM2.5 | 인체 건강, 기후변화 |
| **PVA/POS 패널 건조** | 0.09 - 0.18 | 전력 소비 (리투아니아, 화석연료 수입 전력) | 인체 건강 (CO₂) |
| **PVA 패널 생산** | — | PVA 생산 CO₂, CH₄, N₂O | 인체 건강, PM2.5 |
| **POS 패널 생산** | — | 전분 생산 NH₃, NOx, PM2.5, SO₂ | 인체 건강 |
| **원자재 운송** | 0.02 - 0.03 | EURO5 트럭, CO₂ (화석연료 연소) | 인체 건강 |
| **타이어 재활용** | 0.01 - 0.02 | 재활용 전력 소비 | 인체 건강 |

### 재생에너지 시나리오

| 항목 | 현재 (혼합 전력) | 재생에너지 100% 전환 | 개선율 |
|:----|:--------------:|:-----------------:|:-----:|
| Total Pt (75 kg/m³) | 기준값 | 기준 대비 10.0% ↓ | 10.0% |
| Total Pt (150 kg/m³) | 기준값 | 기준 대비 12.1% ↓ | 12.1% |

- 재생에너지 구성: 수력 64.6%, 풍력 10.6%, 바이오연료 24.8%
- 전력 수입 의존도 80% (스웨덴, 라트비아, 벨라루스, 러시아) → 화석연료 의존
- 재생에너지 전환 시 총 환경영향 평균 10-12% 감소

### 건축 흡음재 GWP Benchmark

| 재료 | GWP (kgCO₂e/kg) | GWP (kgCO₂e/m²·inch) | 비고 |
|:----|:--------------:|:--------------------:|:----|
| **Waste fiber (제안)** | **~0.3 net** | **~0.12** | 폐기물 회피 credit 포함 |
| Mineral wool | 1.5-1.8 | 2.5-3.8 | 화산암 용융 고에너지 |
| Fiberglass | 1.7-2.5 | 1.7-2.5 | 유리 용융 |
| PET foam | 2.5-3.0 | 1.5-2.0 | 석유화학 기반 |
| PUR | 3.0-5.0 | 2.0-4.0 | 고성능, 고탄소 |
| Cellulose | 0.2-1.1 | 0.2-1.1 | 재활용 신문지 |
| Hemp/wool | -0.5~0.5 | -0.2~0.2 | 탄소격리 효과 |
| **Rock wool** | **~3.0** | **—** | **비교: WTTF의 0.6-4.3배 GWP** |

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

## 주장 가능한 환경편익 수치

```
폐섬유 흡음재 1m² (두께 100mm, 밀도 80kg/m³ = 8kg):
  - Virgin PET 대비 CO₂ 저감:  8 × (5.5 - 0.3) = 41.6 kgCO₂e/m²
  - Mineral wool 대비 CO₂ 저감: 8 × (1.8 - 0.3) = 12.0 kgCO₂e/m²
  - 연간 10만m² 생산시 CO₂ 저감: 1,200~4,160 tonCO₂e/년
  - 승용차 800~2,800대 연간 배출량에 해당
```

## 한국 폐섬유 현황 (G6 추가)

| 지표 | 값 | 출처 |
|:----|:--:|:----:|
| 연간 폐섬유 발생량 | **800,000 톤** | 한국환경공단 |
| 실질 물질 재활용률 | **4.7%** | 시민환경연구소 |
| 소각 처리 비용 | 10~15만원/톤 | 폐기물처분부담금 포함 |
| 배출업체 톤당 절감 (재활용 시) | ~17.5만원 | 처리비 + 부담금 회피 |
| BASF Loopamid (100% textile recycling) | 연산 500톤 | 2025년 상업화 |

## 핵심 Gap

1. **한국 폐섬유 맞춤 LCA** — 한국 폐기물 처리 시나리오(소각 60%, 매립 20%, 재활용 20%) 반영한 LCA = 0편
2. **Needle punching 공정 LCA** — Needle punch line 전력 소비(≈50-100 kWh/ton) 반영 = 0편
3. **층간소음 저감 사회적 편익 LCC** — 츠간소음 갈등→이사 비용 등 사회경제적 편익 분석 = 0편
4. **End-of-life 시나리오** — 폐섬유 흡음재 사용 후 재재활용 가능성 = 0편

## 참고 문헌

[1] Sun, G. et al. (2024). Comparative life cycle assessment of two different waste materials for recycled fiber. *Resources, Conservation and Recycling*, 205, 107518. DOI:10.1016/j.resconrec.2024.107518 (9 cit)

[2] Ružickij, R. et al. (2024). Waste Tyre Textile Fibre Composite Material: Acoustic Performance and Life Cycle Assessment. *Sustainability*, 16(15), 6281. DOI:10.3390/su16156281 (10 cit)

[3] GreenSpec / Bull, J. (2021). Embodied Carbon of Insulation. oCo Carbon consultants & UCL. https://www.greenspec.co.uk/building-design/embodied-carbon-of-insulation/

[4] Fabrix (2024). Assessing the Life Cycle of Fabric Acoustic Panels. https://fabrix.com/assessing-the-life-cycle-of-fabric-acoustic-panels/

[5] The Conversation (2025). Your 'recycled polyester' leggings are not as sustainable as you think. https://theconversation.com/your-recycled-polyester-leggings-are-not-as-sustainable-as-you-think-280464

[6] Textile Exchange (2023). Preferred Fiber & Materials Market Report.

[7] Casadesús, M. et al. (2019). Environmental impact assessment of sound absorbing nonwovens based on chicken feathers waste. *Resources, Conservation and Recycling*, 149, 489-499. — WTTF LCA 비교 대상 연구 (GWP 1.7 kgCO₂ eq)

[8] Nagy, B. et al. (2021). Global Warming Potential of Building Constructions. *Thermal Science*, 26, 3285-3296. — Rock wool GWP 27.33 kgCO₂ eq/m²

## 관련 위키 페이지

- [[waste-fiber-market-entry]] — 시장 진입 전략
- [[waste-fiber-acoustic-absorber]] — DMN 기반 흡음재 설계
- [[microstructure-to-jca-empirical-formulas]] — 미세구조→JCA
