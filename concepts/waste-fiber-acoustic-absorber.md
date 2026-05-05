---
title: "Waste-Fiber Acoustic Absorber — DMN 기반 저주파 흡음재 설계"
created: 2026-04-29
updated: 2026-05-05
type: concept
tags: [research-idea, acoustics, dmn, poroelasticity, upcycling, building-materials, g5, competitive-analysis, needle-punching, nonwoven, waste-fiber]
sources: [raw/papers/1-s2.0-S0003682X21003662-main.md, raw/papers/TIN뉴스.md, raw/papers/소각·매립되는 폐원단 조각  자원으로 품다(보도자료)(생활폐기물 9.9).md, raw/papers/인쇄하기.md, raw/articles/dbr-274-제클린-폐섬유-100퍼센트-재활용.md, raw/papers/messiry23-needle-punching-statistical.md, raw/papers/ruzickij24-wttf-composite-lca.md]
confidence: medium
---

# Waste-Fiber Acoustic Absorber — DMN 기반 저주파 흡음재 설계

## 개요

폐섬유(waste fiber)를 업사이클링하여 건축물 층간소음용 저주파 흡음재를 생산하는 연구 및 창업 아이디어.

Air-blow 적층(섬유 배향 제어) + Needle punching(두께 방향 결속) 공정을 통해 폐섬유 매트를 제작하고, Deep Material Network(DMN) 기반 surrogate model로 미세구조-흡음성능 간 관계를 학습하여 최적 공정 조건을 도출.

## 배경: 층간소음 문제

층간소음에서 가장 취약한 주파수 대역은 **40~80Hz의 저주파 충격음**(뛰는 소리, 쿵쿵거리는 소리).

흡음 성능 예측은 [[transfer-matrix-method-acoustic-porous|TMM]] (Transfer Matrix Method)을 통해 JCA 5-parameter로부터 α(f)를 계산. Python 오픈소스 패키지 `acoustipy`가 Allard & Atalla (2009) 기반 구현 제공. DMN → TMM end-to-end 연결이 핵심 기술 과제. [[microstructure-to-jca-empirical-formulas|미세구조→JCA 경험식 변환]]을 통해 공정변수(φ, d_f, ρ_b)에서 직접 JCA 5-param 계산 가능.

### 저주파 흡음의 물리적 난제

| 주파수 | λ/4 공진 조건 | 두께 제약 (아파트: 100~200mm) |
|:-----|:------------|:--------------------------|
| 60Hz | d = c/(4f) = **1.43m** | ❌ 불가능 |
| 250Hz | d = **0.34m** | ❌ 가능 |
| 1000Hz | d = **86mm** | ✅ 적합 |

→ 순수 흡음(absorption)만으로 60Hz 해결 불가. **Mass-spring-mass 공진 + 구조 전달음 제어** 필요.

## 물리적 메커니즘

### Mass-Spring-Mass 공진 모델

```
콘크리트 슬래브 (m₁)
┌──────────────────────────────────┐
│  폐섬유 흡음층 (스프링 k, 감쇠 c) │ ← DMN이 예측
│  - 동적 강성 (frequency-dependent)│
│  - 손실 계수 (loss factor η)      │
│  - 이방성 (in-plane vs t.t.)     │
├──────────────────────────────────┤
│  마감재 / 천장 패널 (m₂)          │
└──────────────────────────────────┘
```

공진 주파수: f_res = (1/2π) · √(k · (m₁+m₂) / (m₁·m₂))

- k ↑ (Needle punching ↑) → f_res ↑ (저주파 대응에 불리)
- k ↓ (공극률 ↑, 섬유 직경 ↑) → f_res ↓ (저주파 대응에 유리)
- η ↑ (감쇠 계수) → 공진 피크 완화 → 광대역 흡음

### 주파수 대역별 지배 메커니즘

| 주파수 | 지배 메커니즘 | 적합한 모델 |
|:-----|:-----------|:----------|
| >1000Hz | 공기 점성 마찰 (Viscous) | Delany-Bazley (경험식) |
| 200~1000Hz | 점성 + 열 손실 + 기하 효과 | JCA 5-파라미터 |
| **40~200Hz (저주파)** | **골격 탄성 + 공진 + mass-air-spring** | **Biot full model** |

## 왜 DMN인가?

### Delany-Bazley/JCA의 한계 (저주파)

경험식 기반 모델(Delany-Bazley, Miki 등)은 정규화 주파수 f/σ < 0.01 영역(저주파)에서:
- 섬유 골격의 **탄성(elasticity)** 고려 불가
- **기계적 이방성** (needle punching 효과) 반영 불가
- **공진 현상** 포착 불가

→ **DMN만이 골격 탄성을 physics-informed하게 포착하고, 공정 변수와의 관계를 학습 가능** (관련: [[poroelastic-dmn-research]])

### DMN의 차별점 대비표

| 방법 | 저주파 정확도 | 학습 데이터 | 물리 일관성 | 실시간 추론 |
|:----|:----------:|:---------:|:---------:|:---------:|
| DMN (Biot 확장) | ⭐⭐⭐⭐⭐ | 중간 | 내장 | ✅ |
| Black-box NN | ⭐⭐⭐ | 매우 많음 | 보장 불가 | ✅ |
| JCA/Transfer Matrix | ⭐⭐ | 없음 | 경험식 한계 | ✅ |
| FEM (full simulation) | ⭐⭐⭐⭐⭐ | 없음 | 완벽 | ❌ (느림) |

## 저주파 대안 기술 비교 (G5)

60Hz 층간소음 해결을 위한 대안 기술들과의 정량적 비교:

| 기술 | 대역폭 | 60Hz α 달성 | 건물 적용성 | 실용 두께 | 비용 | DMN 대비 우위 |
|:----|:-----:|:----------:|:----------:|:--------:|:---:|:-----------:|
| **균질 Porous (제안)** | 광대역 | ❌ (λ/4=1.43m) | ✅ 용이 | 100-200mm | 낮음 | — |
| **Graded Porous (DMN)** | 광대역 | ⚠️ 0.4-0.6m 가능 | ✅ 용이 | 100-200mm | 낮음 | 🏆 최적 |
| **Membrane/Panel** | 협대역 Q≈5-15 | ✅ 가능 | ✅ 용이 | ⚠️ 대형 cavity | 중간 | Graded+MSM 우위 |
| **Helmholtz** | 극협대역 Q>20 | ✅ 가능 (협대역) | ⚠️ bulky | ~1m³/unit | 중간 | 광대역 부적합 |
| **MPP** | 협대역 | ⚠️ 제한적 | ✅ 용이 | ⚠️ back cavity | 중간 | 저주파 한계 |
| **ANC** | 광대역 | ✅ 탁월 | ❌ 복잡 | 소형 | 고가 (€2,440) | 비용/유지보수 |
| **Hybrid (porous+HR)** | 준광대역 | ✅ 개선됨 | ⚠️ 복잡 | 중간 | 중간 | 설계 복잡성 |

### 왜 Porous인가? — 층간소음의 물리적 특성

층간소음(40-80Hz)은 **충격성 광대역 신호**로, 협대역 공명기(Helmholtz Q>20, membrane Q≈5-15)는 1옥타브 이상의 대역폭을 커버할 수 없음.

**Graded porosity** (Groby 2019, JAP)는 임피던스 정합으로 λ/4 한계를 1.43m→0.4-0.6m로 단축 가능.

**Mass-spring-mass + porous 결합**이 유일한 실용적 접근:
```
콘크리트 슬래브 (m₁ ≈ 300 kg/m²)   ← 충격 전달
폐섬유 흡음층 (스프링 k, 감쇠 c)   ← DMN이 동적 강성 k(f) 예측
천장 패널 (m₂ ≈ 10 kg/m²)          ← mass-air-spring 공진
```
- f_res = (1/2π)·√(k·(m₁+m₂)/(m₁·m₂)) — needle punching으로 k 제어 → 40-80Hz 튜닝
- **DMN만이 이방성 + 주파수 의존적 동적 강성 포착 가능**, 기존 단순 k 모델보다 정밀
- 참고: Allard & Atalla (2009) Ch.11, Fahy & Gardonio (2007)

### 핵심 참고 문헌 (G5)

- Groby, J.P. et al. (2019). Optimally graded porous material for broadband perfect absorption. *J. Applied Physics*, 126, 175101.
- Hybrid porous Helmholtz resonator for low-frequency broadband absorption (2024). *Phys. Rev. Applied*, 22, 044032. (12 cit)
- Berchtenbreiter et al. (2024). Additively manufactured porous absorbers in multi-layer MPP. *Acta Acustica*, 8, 37.
- Maa, D.Y. (1998). Potential of microperforated panel absorber. *J. Acoust. Soc. Am.*, 104(5). (★600+ cit)
- Structure design of low-frequency broadband sound-absorbing material (2020). *Applied Acoustics*, 168, 107315.

### 공정 변수 → 흡음 성능 직접 매핑

DMN이 학습할 수 있는 관계:
- Needle punching 밀도 → 골격 탄성 계수(k_33, k_11)
- Air-blow 압력/방향 → 섬유 배향 분포 → 이방성
- 섬유 직경, 재질 → 공극률, 유동 저항
- **적층 수 / 면밀도 → mass 효과**

## Needle Punching 공정 — Messiry (2023) 데이터

El Messiry et al. (2023)의 통계 분석 결과, needle punch 공정변수 4가지(needle speed, lattice speed, penetration depth, waste ratio) 모두 음향 성능에 유의한 영향을 미침.

### 공정변수 범위

| 변수 | 최소 | 중간 | 최대 | 최적값 |
|:----|:---:|:---:|:---:|:-----:|
| Needle speed (rpm) | 227 | 245 | 280 | 280 |
| Lattice speed (m/min) | 0.72 | 1.47 | 2.35 | 0.72 |
| Penetration depth (mm) | 5 | 10 | 26 | 26 |
| Virgin:waste ratio (%) | 60:40 | 80:20 | 100:0 | 100:0 (virgin) |

### ANOVA 유의성 (α=0.05)

| 변수 | p-value | F-value | 유의 순위 |
|:----|:------:|:-------:|:--------:|
| Waste amount | **7.93E-08** | 85.54 | 1위 |
| Penetration depth | **1.96E-05** | 30.53 | 2위 |
| Needle speed | **0.000106** | 21.57 | 3위 |
| Lattice speed | **0.000211** | 18.60 | 4위 |

### 주파수별 중요 변수

- **저주파 (400-600Hz):** Lattice speed + Waste amount 지배
- **중주파 (800-1200Hz):** Waste amount + Penetration depth 지배
- **고주파 (1400-1600Hz):** Needle speed 중요도 상승, Penetration depth 부분적 감소

### 시사점

- Needle punching 조건(속도, 깊이)은 골격의 동적 강성과 공극률에 직접 영향
- 높은 stitch density = 낮은 공기 투과도 = 높은 유동 저항(σ) → JCA σ 증가
- 최적 공정(NS=280, LS=0.72, DP=26)에서 STL 22dB 달성 (250-1600Hz)

## WTTF Composite 흡음 — Ružickij (2024) 데이터

Ružickij et al. (2024)는 폐타이어 섬유(WTTF)와 3종 바인더(PU, PVA, Starch)로 제조한 복합 흡음재의 음향 성능 평가.

### 재료 및 시편

| 항목 | 값 |
|:----|:---|
| WTTF fiber diameter | 15-30 μm |
| WTTF fiber length | 800-2000 μm |
| WTTF bulk density | 40.1 ± 2.3 kg/m³ |
| 시편 두께 | 40 mm |
| 시편 직경 | 29.9 mm |
| 밀도 | 75, 100, 125, 150 kg/m³ |
| Binder content | 10, 30, 50 wt% |
| 총 시편 수 | 108개 (3종×4밀도×3함량×3반복) |

### 흡음 성능 요약

| 대역 | SAC 범위 | 비고 |
|:----|:-------:|:----|
| 저주파 (160-500Hz) | 0.04 - 0.42 (75kg/m³) → 0.13-0.75 (150kg/m³) | 밀도 증가로 저주파 흡음 향상 |
| 중주파 (630-2000Hz) | 0.11 - 0.99 | 대부분 시편 피크 도달 |
| 고주파 (2500-5000Hz) | 0.52 - 0.99 | 단파장으로 높은 흡음 |
| **전체 범위** | **0.04 - 0.99** | |
| **Peak 주파수** | **800 - 2000 Hz** | 밀도 증가 시 2000→800Hz로 이동 |

### Binder별 성능

| Binder | 저주파 성능 | 중주파 성능 | 비고 |
|:------|:---------:|:---------:|:----|
| **PU** (polyurethane) | 🏆 최고 | 🏆 최고 | 섬유 코팅 + open cavity 유지 |
| PVA (polyvinyl acetate) | 중간 | 중간 | Film-like 구조로 일부 폐색 |
| POS (starch) | 최저 | 최저 | Cavity 대부분 폐색 |

- PU 10 wt% 조합이 전 대역에서 최고 흡음 성능
- Binder 함량 증가 → 흡음 성능 감소 (cavity 폐색으로 porosity 감소)

### 기류 저항(Airflow Resistivity) 범위

| 항목 | 값 |
|:----|:---|
| σ 범위 | 17.4 - 83.6 kPas/m² |
| 밀도 ↑ → σ ↑ | 밀도 증가로 fiber content 증가 → porosity 감소 |
| Binder 영향 | PU < PVA < POS 순서로 σ 증가 |

### 비교 문헌 대비 우위

- 동일 두께(40mm) 천연섬유 복합재 대비 WTTF는 500Hz에서 SAC 0.42-0.75로 **1.5-2배 우수** (비교군 0.39)
- 재활용 청바지 섬유+resin 대비 10wt% binder에서 **4-6배 우수**
- Rock wool (GWP 27.33 kgCO₂e/m²) 대비 **0.6-4.3배 낮은 환경영향**

## WTTF 흡음재의 건축 적용 시사점

- **40mm 두께로 α_max 0.99 달성** → 경쟁력 있는 흡음 성능
- **밀도 150kg/m³, PU 10wt%** 조합이 800Hz에서 peak → 중주파 흡음재로 적합
- **저주파 160-500Hz SAC 0.13-0.75** → 추가 두께 증가 or graded 구조로 개선 필요
- 바인더 최적화(PU) + 재생에너지 전환 시 환경영향 10-12% 추가 저감 가능

## 전체 파이프라인

### 연구 단계

```
Micro-CT (폐섬유 시편)
    ↓ (1) GAP-SBM: meshing 없이 homogenization 반복
[C₁, C₂] 조합 × N개 → homogenized (C̅, α̅, M̅)
    ↓ (2) DMN offline training
훈련된 Poroelastic DMN (7×7 또는 Norris 경유)
    ↓ (3) Online prediction + JCA→α(f)
흡음 계수 α(f) 예측 (ms 단위)
|    ↓ (4) Inverse design / 최적화
|목표 α(60Hz)를 만족하는 공정 조건 도출
||
```

> **권장:** GAP-SBM 대신 [[fft-homogenization-composites]] (Willot 2015, FFT-based homogenization)으로 training data 생성 고려. SBM은 embedded FEM으로 meshing을 회피하지만, FFT 방식이 voxel 기반 미세구조를 직접 입력으로 사용하여 더 빠르고 정확함. 특히 Willot discretization (Gʀ)은 고대비 재료(고체 vs 공극)에서도 빠른 수렴을 보장하므로 폐섬유 매트의 다공성 균질화에 적합. (참고: [[porous-nonwoven-homogenization]] — Kuts 2024의 FEM 기반 nonwoven 균질화도 FFT 접근과 방법론적 유사성 있음)

### 생산라인 Closed-Loop 비전 (장기)

```
CV 센서 (초음파/YOLO) → 미세구조 추정
    ↓
Surrogate model (DMN) → α(f) 예측
    ↓
공정 파라미터 피드백 제어 (needle punch, air-blow, 두께)
```

### 현실적 진입점

| Phase | 제품/서비스 | 기술 수준 | 창업 단계 |
|:----|:----------|:--------|:---------|
| 1 | **설계 도우미 SaaS** — 공정 조건 → 흡음 성능 예측 | TRL 3~4 | 예비 창업 |
| 2 | **공정 모니터링 시스템** — 생산라인 불량 탐지 + 품질 관리 | TRL 5~6 | 시드 |
| 3 | **Closed-Loop 제어** — 자동 공정 보정 | TRL 7+ | 스핀오프 |

## 관련
- [[waste-fiber-market-entry]]
개념

- `poroelastic-dmn-research` — 7×7 DMN 연구 아이디어 및 병목 분석
- `poroelasticity-thermoelasticity-correspondence` — Norris 1992: 포로-열탄성 대응 정리
- `thermoelastic-dmn` — Shin 2024: thermomechanical DMN
- `deep-material-network` — DMN 기본 아키텍처
- `gap-sbm` — GAP-SBM: meshing 없는 embedded FEM
- `dongil-shin` — 신동일 교수 (POSTECH DSLab)
- [[porous-nonwoven-homogenization]] — Kuts 2024 / Wan 2024: 다공성 부직포 균질화 및 압축 모델링 (nonwoven FFT 직접 연결)
- [[ml-acoustic-metamaterials-review]] — Chen et al. 2024: 음향 메타물질 ML 리뷰
- [[deeponet-poroelastic-surrogate]] — Park, Shin & Choo 2025: DeepONet 포로탄성 surrogate (DMN 대안 operator learning)
- [[evoxels-differentiable-voxel]] — Daubner et al. 2025: 미분 가능 복셀 기반 미세구조 시뮬레이션 (미분 가능 물성 예측)

## 참고 문헌

- Allard & Atalla (2009). *Propagation of Sound in Porous Media.* Wiley.
- Biot, M.A. (1956). "Theory of propagation of elastic waves in a fluid-saturated porous solid." *J. Acoust. Soc. Am.*
- Delany & Bazley (1970). "Acoustical properties of fibrous absorbent materials." *Applied Acoustics.*
- Norris (1992). "On the correspondence between poroelasticity and thermoelasticity." *J. Appl. Phys.*
- Shin et al. (2024). "Thermomechanical DMN." *Composites Part B.*
- Santoni, A. et al. (2022). "A hybrid approach for modelling the acoustic properties of recycled fibre mixtures for automotive applications." *Applied Acoustics.* — 재활용 섬유 혼합물 흡음 모델링 (raw/papers/1-s2.0-S0003682X21003662-main.md)
- El Messiry, M. et al. (2023). "Statistical analysis of the effect of processing machine parameters on acoustical absorptive properties of needle-punched nonwovens." *J. Engineered Fibers and Fabrics*, 18. DOI: 10.1177/15589250231155623 (raw/papers/messiry23-needle-punching-statistical.md)
- Ružickij, R. et al. (2024). "Waste Tyre Textile Fibre Composite Material: Acoustic Performance and Life Cycle Assessment." *Sustainability*, 16, 6281. DOI: 10.3390/su16156281 (raw/papers/ruzickij24-wttf-composite-lca.md)
- 종로구 폐원단 자원화 시범사업 보도자료 (raw/papers/TIN뉴스.md)
- 성동구 폐원단 재활용 협약 보도자료 (raw/papers/인쇄하기.md)
