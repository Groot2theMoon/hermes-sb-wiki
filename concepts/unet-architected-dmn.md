---
title: "U-Net Architected Deep Material Network (Shin et al. 2026)"
created: 2026-05-05
updated: 2026-05-05
sources: [raw/papers/shin-2026-unet-dmn.md]
type: concept
tags: [materials, surrogate-model, micromechanics, homogenization, deep-learning]
sources:
  - raw/papers/shin-2026-unet-dmn.md
confidence: high
---

# U-Net Architected Deep Material Network

## 개요

[[dongil-shin|Dongil Shin]], Ricardo A. Lebensohn, [[remi-dingreville|Rémi Dingreville]]가 *Computational Mechanics* (2026)에 발표. 기존 [[deep-material-network|Deep Material Network (DMN)]]의 훈련 방식을 **U-Net 아키텍처**로 확장하여, 균질화된 유효 물성뿐 아니라 **미세구조 국부장(local field) 정보**를 훈련에 활용하는 방법론 제안.

## 배경 및 문제의식

기존 DMN 훈련은 **Direct Numerical Simulation (DNS)의 균질화된 유효 물성**만 사용:
- Volume-averaged stress → homogenized stiffness tensor C_h
- 국부 응력/변형률 분포의 풍부한 정보가 훈련에서 완전히 배제됨
- 결과적으로 국부 응력 예측 정확도가 제한적

핵심 아이디어: DNS의 **local field 데이터(응력 분포의 1차/2차 통계적 모멘트)** 를 DMN 훈련 목적함수에 통합.

## 방법론

### U-Net DMN Framework

```
입력: base material properties (C_A, C_B)
  ↓
Encoder (DMN Homogenization Path):
  [기존 DMN 이진 트리 — 계층적 균질화 수행]
  → 균질화된 유효 응력 (global homogenized response)
  ↓
Skip Connections:
  [중간 레이어의 물리 정보를 Decoder로 전달]
  ↓
Decoder (DMN Localization Path):
  [Skip connection을 통해 전달받은 정보로 국부장 재구성]
  → 국부 응력 분포의 통계적 모멘트 (M_j, SD_j)
```

### 학습 데이터

- **입력:** FFT 기반 DNS로 생성 (~1,000 쌍)
  - 256×256 픽셀의 2D 주기 단위 셀 (5개 inclusion, 29% volume fraction)
  - Orthotropic 탄성 상수, Latin hypercube sampling
  - 3가지 독립적인 macroscopic 변형률 경계 조건
- **출력 (기존 DMN):** 균질화된 stiffness tensor C_h (3×3)
- **출력 (확장):** 각 phase별 응력의 평균(M) + 표준편차(SD) 행렬

행렬 M_j와 SD_j (j = phase A 또는 B):
- 3개 경계조건 × 3개 응력성분(σ_11, σ_22, σ_12)
- 총 18개 스칼라 값 (3×3×2 phases)

### U-Net Architecture Details

- **Encoder 경로:** 기존 DMN의 계층적 균질화 (binary tree)
  - 학습 가능 파라미터: phase fraction w^k, orientation n̂ (회전 각도)
  - 물리 내장: rank-N sequential laminate에 수학적 등가
- **Skip connections:** 인코더의 각 레이어 정보를 디코더의 해당 레이어로 전달
  - 중간 스케일 물리 정보 유실 방지
  - 글로벌 컨텍스트(경계 조건)가 국부장 재구성 가이드
- **Decoder 경로:** 역균질화 (localization) 연산
  - Skip connection 정보 + 하위 레이어 정보를 결합하여 국부 응력 통계 재구성

### 지역 역 Building Block (Inverse Building Block for Localization)

기존 DMN의 building block이 균질화(ℋ)를 수행한다면, U-Net DMN은 이의 **역연산**을 통해 균질화된 정보를 다시 국부장으로 분해:
- 각 building block에서 변형률 집중 텐서(strain concentration tensor) 활용
- Skip connection을 통해 전달된 맥락 정보가 분해 과정의 가이드 역할

### 온라인 예측

- 훈련된 파라미터(fixed) → 비선형 구성 법칙 적용
- Newton-Raphson 반복법으로 계면 평형 조건 풀이
- 원래 DMN과 동일한 온라인 추론 프로세스 유지

## 주요 결과

| 항목 | 기존 DMN | U-Net DMN (제안) |
|:----|:---------|:----------------|
| 유효 강성 예측 | 우수 | 우수 (동등) |
| **국부 응력 예측 오차** | 기준 | **~1 order of magnitude 감소** |
| 비선형 일반화 | 우수 | **현저히 향상** |
| 훈련 데이터 생성 비용 | 동일 | 동일 (추가 비용 없음) |
| 훈련 시간 | 기준 | 약간 증가 (확장된 출력 차원) |

### Generalization 성능

- 비선형 구성 법칙(J2 소성, Armstrong-Frederick kinematic hardening)에 대한 extrapolation
- U-Net DMN이 기존 DMN 대비 **국부 응력 히스테리시스 루프**를 훨씬 정확하게 예측
- 다양한 inclusion 형태(원형, 타원형, 불규칙)에서 일관된 성능 향상

## 의의 및 한계

### 의의
- DMN 훈련에 **local field supervision**을 도입한 첫 연구
- U-Net 아키텍처를 DMN의 물리 내장 구조와 자연스럽게 통합
- 추가 데이터 생성 비용 없이 훈련 출력만 확장 → 실용적
- 국부 예측 정확도를 1 order of magnitude 향상

### 한계
- 2D microstructure에만 검증 (3D 확장은 미검증)
- 응력의 1차/2차 통계적 모멘트만 사용 (고차 모멘트는 오히려 성능 저하)
- 훈련 데이터 생성에 여전히 FFT 기반 DNS 필요

## 관련 개념

- [[deep-material-network]] — DMN 기본 아키텍처
- [[deep-material-network-quilting]] — DMN quilting 전략 (Shin et al. 2023)
- [[micropolar-deep-material-network]] — Micropolar DMN 확장 (Francis et al. 2025)
- [[dongil-shin]] — 신동일 교수 (POSTECH, DMN 연구자)
