---
title: "Waste-Fiber Acoustic Absorber — DMN 기반 저주파 흡음재 설계"
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [research-idea, acoustics, dmn, poroelasticity, upcycling, building-materials]
sources: [raw/papers/1-s2.0-S0003682X21003662-main.md, raw/papers/TIN뉴스.md, raw/papers/소각·매립되는 폐원단 조각  자원으로 품다(보도자료)(생활폐기물 9.9).md, raw/papers/인쇄하기.md]
confidence: medium
---

# Waste-Fiber Acoustic Absorber — DMN 기반 저주파 흡음재 설계

## 개요

폐섬유(waste fiber)를 업사이클링하여 건축물 층간소음용 저주파 흡음재를 생산하는 연구 및 창업 아이디어.

Air-blow 적층(섬유 배향 제어) + Needle punching(두께 방향 결속) 공정을 통해 폐섬유 매트를 제작하고, Deep Material Network(DMN) 기반 surrogate model로 미세구조-흡음성능 간 관계를 학습하여 최적 공정 조건을 도출.

## 배경: 층간소음 문제

층간소음에서 가장 취약한 주파수 대역은 **40~80Hz의 저주파 충격음**(뛰는 소리, 쿵쿵거리는 소리).

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

→ **DMN만이 골격 탄성을 physics-informed하게 포착하고, 공정 변수와의 관계를 학습 가능**

### DMN의 차별점 대비표

| 방법 | 저주파 정확도 | 학습 데이터 | 물리 일관성 | 실시간 추론 |
|:----|:----------:|:---------:|:---------:|:---------:|
| DMN (Biot 확장) | ⭐⭐⭐⭐⭐ | 중간 | 내장 | ✅ |
| Black-box NN | ⭐⭐⭐ | 매우 많음 | 보장 불가 | ✅ |
| JCA/Transfer Matrix | ⭐⭐ | 없음 | 경험식 한계 | ✅ |
| FEM (full simulation) | ⭐⭐⭐⭐⭐ | 없음 | 완벽 | ❌ (느림) |

### 공정 변수 → 흡음 성능 직접 매핑

DMN이 학습할 수 있는 관계:
- Needle punching 밀도 → 골격 탄성 계수(k_33, k_11)
- Air-blow 압력/방향 → 섬유 배향 분포 → 이방성
- 섬유 직경, 재질 → 공극률, 유동 저항
- **적층 수 / 면밀도 → mass 효과**

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
    ↓ (4) Inverse design / 최적화
목표 α(60Hz)를 만족하는 공정 조건 도출
```

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

## 관련 개념

- `poroelastic-dmn-research` — 7×7 DMN 연구 아이디어 및 병목 분석
- `poroelasticity-thermoelasticity-correspondence` — Norris 1992: 포로-열탄성 대응 정리
- `thermoelastic-dmn` — Shin 2024: thermomechanical DMN
- `deep-material-network` — DMN 기본 아키텍처
- `gap-sbm` — GAP-SBM: meshing 없는 embedded FEM
- `dongil-shin` — 신동일 교수 (POSTECH DSLab)

## 참고 문헌

- Allard & Atalla (2009). *Propagation of Sound in Porous Media.* Wiley.
- Biot, M.A. (1956). "Theory of propagation of elastic waves in a fluid-saturated porous solid." *J. Acoust. Soc. Am.*
- Delany & Bazley (1970). "Acoustical properties of fibrous absorbent materials." *Applied Acoustics.*
- Norris (1992). "On the correspondence between poroelasticity and thermoelasticity." *J. Appl. Phys.*
- Shin et al. (2024). "Thermomechanical DMN." *Composites Part B.*
- Santoni, A. et al. (2022). "A hybrid approach for modelling the acoustic properties of recycled fibre mixtures for automotive applications." *Applied Acoustics.* — 재활용 섬유 혼합물 흡음 모델링 (raw/papers/1-s2.0-S0003682X21003662-main.md)
- 종로구 폐원단 자원화 시범사업 보도자료 (raw/papers/TIN뉴스.md)
- 성동구 폐원단 재활용 협약 보도자료 (raw/papers/인쇄하기.md)
