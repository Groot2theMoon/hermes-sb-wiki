---
title: "Micropolar Deep Material Network (Francis, Shin et al. 2025)"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [materials, surrogate-model, micromechanics, homogenization, solid-mechanics]
sources:
  - raw/papers/francis-2025-micropolar-dmn.md
confidence: high
---

# Micropolar Deep Material Network

## 개요

Noah M. Francis, [[dongil-shin|Dongil Shin]], Ricardo A. Lebensohn, Fatemeh Pourahmadian, [[remi-dingreville|Rémi Dingreville]]가 *Computer Methods in Applied Mechanics and Engineering* (2025, Vol. 446, 118329)에 발표. 기존 [[deep-material-network|Deep Material Network (DMN)]]를 **Micropolar (Cosserat) 연속체 이론**으로 확장.

## 배경

기존 DMN은 **고전 연속체 역학(classical Cauchy continuum)** 에 기반:
- 변위 구배(displacement gradient)만으로 변형 표현
- 회전 자유도(rotational DOF)를 독립적으로 다루지 못함
- 국부 회전 효과가 중요한 미세구조(예: 격자 구조, granular media, cellular solids)에서 정확도 제한

**Micropolar (Cosserat) 이론**:
- 각 변위점에서 **변위(3) + 미소회전(3)** = 총 6자유도
- Couple stress (모멘트 응력) 도입
- 내재적 길이 스케일(internal length scale) 포함 → 크기 효과(size effect) 포착 가능

## 핵심 방법론

### 1. DMN Building Block의 Micropolar 확장

기존 DMN의 균질화 building block을 micropolar 연속체로 확장:

- **층상 복합재 균질화 해석해**를 micropolar 탄성으로 재유도
- Interface 조건: 변위 연속성 + **회전 연속성** (기존: 변위만)
- 변형률 집중 텐서: 9×9 (고전 6×6 → micropolar 9×9)
  - 고전 변형률 성분(ε_ij) 6개 + **곡률 성분(κ_ij)** 3개

### 2. Building Block 내부 구조

각 building block ℬ^k_i:

1. **회전 ℛ**(α, β, γ) — Tait-Bryan angles (6×6 회전 행렬 → 9×9로 확장)
2. **균질화 ℋ**(w¹, w²) — Micropolar 층상 복합재 균질화 해석해:
   - Force-stress (σ_ij)와 couple-stress (m_ij)를 동시에 고려
   - 균질화된 강성 텐서: C^̅ (9×9)

### 3. 학습 가능 파라미터

기존 DMN과 동일한 구조 유지:
- Phase fraction weights: w^k_i = ReLU(z^k_i)
- Orientation angles: (α, β, γ)
- 학습 데이터: FFT 기반 micropolar DNS

## 주요 결과

| 항목 | 고전 DMN | Micropolar DMN |
|:----|:---------|:---------------|
| 적용 가능 문제 | Cauchy 연속체 | **Micropolar 연속체** |
| 포착 가능 현상 | 변위 기반 변형 | 변위 + **회전 + couple stress** |
| Internal length scale | 없음 | **있음** (크기 효과 포착) |
| Building block DOF | 6×6 | 9×9 |
| 균질화 정확도 | 기존 | 미세구조에 따라 **향상** |

### 검증 사례

- 주기적 격자 구조(periodic lattice)에서 micropolar 효과 검증
- 국부 회전 경계 조건이 지배적인 문제에서 우수한 성능
- 고전 DMN 대비 균질화 응력 및 couple stress 예측 정확도 향상

## 의의

- **DMN을 generalized continuum으로 확장한 첫 연구**
- Cosserat 효과가 중요한 미세구조(격자, 발포체, granular media)로 DMN 적용 범위 확대
- 기존 DMN의 물리 내장 구조(binary tree + analytical homogenization) 유지
- 향후 acoustic/elastic wave propagation 문제로 확장 가능성

## 한계

- Building block 수가 증가할수록 9×9 연산으로 인한 계산 비용 증가
- Micropolar 물성 자체의 실험적 측정/검증 필요
- 선형 탄성 영역에 대한 검증 (비선형 확장은 미검증)

## 관련 개념

- [[deep-material-network]] — DMN 기본 아키텍처 (Cauchy 연속체 기반)
- [[deep-material-network-quilting]] — DMN quilting 전략 (Shin et al. 2023)
- [[unet-architected-dmn]] — U-Net DMN (Shin et al. 2026)
- [[dongil-shin]] — 신동일 교수 (POSTECH, DMN 연구자)
- [[thermoelastic-dmn]] — 열탄성 DMN 확장
