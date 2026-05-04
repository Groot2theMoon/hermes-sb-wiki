---
title: "Low-Frequency Sound Absorption Technologies Comparison"
created: 2026-05-03
updated: 2026-05-03
type: concept
tags: [low-frequency, membrane-absorber, helmholtz-resonator, mpp, anc, porous-absorber, comparison]
sources: []
confidence: high
---

# Low-Frequency Sound Absorption Technologies Comparison

## 개요

60Hz 저주파 흡음의 λ/4 두께 한계(~1.43m for porous)를 극복하기 위한 대안 기술들의 비교 분석. 층간소음 충격음(40-80Hz 광대역) 해결을 위한 최적 기술 선정이 목적.

## 비교 Matrix

| 기술 | 원리 | 60Hz 필요 조건 | α(60Hz) | 대역폭 | 비용 | 건축 적용성 |
|:----|:----|:-------------|:------:|:-----:|:---:|:---------:|
| Porous λ/4 | 점성+열 손실 | d=1.43m (λ/4) | 0.3-0.5 | 광대역 | 저렴 ($5-20/m²) | ⚠️ 두께 |
| Porous graded | 계단식 공극률 | d=0.4-0.6m | 0.5-0.7 | 광대역 | 중간 | ✅ 가능 |
| Membrane | 판 진동 + 공동 | d=0.1-0.3m | 0.8-0.9 | 협대역 (1/3 oct) | 중간 ($50-200/m²) | ⚠️ 중량 |
| Helmholtz | 공진기 | V=0.5-1.0m³ | 0.9-0.95 | 극협대역 (Q=5-20) | 중간 | ❌ 부피 |
| MPP | 미세공 점성 | d=0.3-0.5m | 0.6-0.8 | 중대역 | 고가 ($100-300/m²) | ⚠️ 특수제조 |
| ANC (AVAA) | 능동 상쇄 | 424×509×300mm | 0.9+ | 광대역 | €2,440/개 | ❌ 단위가격 |

## 층간소음 특성

층간소음 충격음은 단일 주파수가 아닌 **40-80Hz 광대역** — 협대역 공진기(membrane, Helmholtz) 부적합. Porous absorber의 본질적 broadband 특성이 필요.

## DMN-Porous의 경쟁력

DMN 최적화(특히 graded porosity 설계)를 통해 λ/4보다 얇은 두께에서 LF 흡음 달성이 목표. 폐섬유를 원료로 하여 원가 경쟁력 확보.

## 참고 문헌

- Acoustic Fields. "Resonant Absorbers & Why You Need Them." https://www.acousticfields.com/resonant-absorbers/
- Zhang, W. & Xin, F. "Broadband low-frequency sound absorption via Helmholtz resonators." *J. Sound Vib.* (2024).
- Phys. Rev. Applied 22, 044032 (2024). "Hybrid porous Helmholtz resonator for low-frequency broadband."
- PSI Audio. "AVAA Technology." https://www.psiaudio.swiss/avaa-technology/
- CinemaConfig. "Bass Traps." https://cinemaconfig.com/reference/bass-traps
- Nature (2025). "Composite acoustic system for low-frequency sound absorption."
- Hal Science. "Potential of microperforated panel absorber." https://hal.science/hal-04161348
- Fiveable. "Key Concepts of Sound Absorption Coefficients." https://fiveable.me/lists/key-concepts-of-sound-absorption-coefficients
