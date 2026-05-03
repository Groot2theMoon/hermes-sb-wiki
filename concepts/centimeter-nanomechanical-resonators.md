---
title: "Centimeter-Scale Nanomechanical Resonators with Low Dissipation"
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [paper, mechanics, materials, optimization]
sources: [raw/papers/ghadimi-2024-centimeter-nanomechanical-resonators.md]
confidence: high
---

# Centimeter-Scale Nanomechanical Resonators with Low Dissipation

## 개요

Andrea Cupertino, Dongil Shin, Leo Guo, Peter G. Steeneken, Miguel A. Bessa & Richard A. Norte가 *Nature Communications* (2024)에 발표한 논문. 나노미터 두께를 유지하면서 센티미터 길이로 확장된 나노기계 공진기(nanomechanical resonator)를 제시.

## 핵심 성과

- **종횡비(aspect ratio):** >4.3 × 10⁵ (1mm 두께 세라믹이 500m 현수되는 것과 동등)
- **Quality factor:** 6.6 × 10⁹ (214 kHz, 상온, <10⁻⁹ mbar) — 기계적 클램프 공진기 중 사상 최고
- **제조 수율:** 최대 93%
- **Coherence time:** ~1ms at 상온
- **Force sensitivity:** ~aN Hz⁻⁰·⁵

## 방법론

### 다중 충실도 베이지안 최적화 (Multi-Fidelity Bayesian Optimization, MFBO)

- **저충실도 모델:** 3mm 공진기 (≈1 비용 단위)
- **고충실도 모델:** 3cm 공진기 (≈8 비용 단위)
- 25개 무작위 초기 시뮬레이션 후 122회 고충실도 + 226회 저충실도 평가
- 단일 충실도 BO 대비 **~20% 높은 Q** 달성
- 설계 변수: 9개 형상 변수 (unit cell 폭/길이 비율, defect 크기, 전체 형태)

### 나노제조 (Nanofabrication)

1. **재료:** 고응력(1.07 GPa) Si₃N₄ on 2mm 실리콘 웨이퍼
2. **리소그래피:** 전자빔 리소그래피 (최소 feature 500nm, UV 포토리소그래피 호환)
3. **건식 식각:** 극저온 DRIE (SF₆ + O₂)로 micro-scaffolding 생성 후 SF₆ 등방성 릴리스
4. **핵심 혁신:** 건식 릴리스로 stiction 및 붕괴 방지, >50μm 기판 갭 확보

## 관련 개념

|- `bayesian-optimization` — Multi-fidelity Bayesian optimization framework
- [[solar-sail-mfbo]] — 태양돛 형상 최적화 MFBO (구조 최적화 영역)
- `nanomechanics` — 나노스케일 기계 시스템
- `quality-factor` — 공진기의 에너지 손실 척도
- `phononic-crystals` — 포노닉 밴드갭을 이용한 진동 격리

## 응용 분야

- 상온 ground-state cooling
- aN급 힘 센싱
- 주파수 표준 (Allan deviation ~3×10⁻¹²/√τ)
- 암흑물질 탐지, Casimir 힘 측정, 양자 메모리
