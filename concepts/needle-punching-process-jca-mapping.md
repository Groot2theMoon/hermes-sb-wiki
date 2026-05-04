---
title: "Needle Punching Process — Microstructure — JCA Parameter Mapping"
created: 2026-05-03
updated: 2026-05-03
type: concept
tags: [needle-punching, nonwoven, manufacturing, process-parameters, jca, acoustic-fibrous]
sources: []
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

## 핵심 문헌

### 폐섬유 needle punch acoustic (직접 관련)

[1] El Messiry, M. (2023). Statistical analysis of the effect of processing machine parameters on acoustical absorptive properties of needle-punched nonwovens. *J. Engineered Fibers and Fabrics*.
→ 유일하게 폐섬유 + needle punch + acoustic을 동시에 다룸. 4개 변수 모두 통계적 유의 확인.

### 일반 needle punch → 물성

[2] RSC Advances (2017). Influence of process parameters on needle punched nonwovens. — punch frequency > penetration depth 영향.

[3] Springer (2023). Effect of punch density on mechanical properties. — 최적 punch density 220-300 cm⁻².

## DMN 연결

공정변수 → JCA 5-param의 정량적 differentiable model은 존재하지 않음. DMN이 이 gap을 채우는 핵심 도구.
