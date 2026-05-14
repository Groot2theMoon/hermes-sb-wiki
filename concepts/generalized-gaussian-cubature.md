---
title: "Generalized Gaussian Cubature for Nonlinear Filtering"
created: 2026-05-05
updated: 2026-05-05
sources: [raw/papers/aas-2015-423-ukf.md]
type: concept
tags: [cubature, quadrature, gaussian-filter, nonlinear-filtering, sigma-point, optimal-sampling]
sources:
  - raw/papers/aas-2015-423-ukf.md
confidence: high
---

# Generalized Gaussian Cubature for Nonlinear Filtering

**Linares & Crassidis** (LANL × University at Buffalo, 2015)  
*AAS 15-423*

## 개요

**Generalized Gaussian Cubature (GGC)** — 1차원 직교 규칙(quadrature rules)에 기반하지 않고, 다차원 가우시안 분포에 대한 **직접적인 cubature rules**를 구성하는 방법을 제안. 기존 CKF, GHQF, UKF가 odd-order accuracy로 제한된 반면, GGC는 **임의의 정확도 차수**를 지원하며, anisotropic case로 확장 가능.

## 핵심 차별점

### Classical vs Generalized Cubature

| 구분 | Classical (CKF, GHQF) | Generalized GGC |
|:----|:--------------------|:----------------|
| 기반 | 1D quadrature의 tensor product | 다차원 직접 최적화 |
| Point 수 | $m^d$ (tensor product) | 사용자 지정 가능 |
| 정확도 | Odd-order only (3, 5, 7...) | **임의 차수** |
| Anisotropy | 불가능 | **지원** (차원별 다른 정확도) |
| 구성 | 사전 정의된 규칙 | 비선형 방정식 풀이 필요 |

### Generalized Gaussian Quadrature (GGQ)

1D에서 GGQ는 orthogonal polynomial이 아닌 **일반 함수 클래스**의 적분에 최적화된 quadrature rule. $N$개의 node로 $2N$개의 moment 조건을 만족.

### 다차원 확장 (GGC)

저자들이 제안하는 GGC는:
1. $n$차원 가우시안 적분 $\int f(x) \mathcal{N}(x; 0, I) dx$에 대한 cubature rule
2. Point 위치와 weight를 **비선형 방정식 시스템**의 해로 결정
3. 각 차원별로 다른 정확도 차수 설정 가능 (anisotropic)

## 적용: Gaussian Mixture

GGC를 Gaussian mixture 분포로 확장:
- 각 component에 대해 별도의 cubature rule
- Mixture weight에 따라 결합
- Heavy-tailed 분포에도 적용 가능

## Wikilinks
- [[differentiable-sigma-point-quadrature]] — RIGOR differentiable sigma point quadrature
- [[square-root-unscented-kalman-filter]] — SR-UKF
- [[improved-ckf-gnss-ins]] — ICKF for GNSS/INS
- [[optimized-sigma-points-n-plus-1]] — n+1 sigma points

## References
- AAS 15-423, AIAA/AAS Space Flight Mechanics Meeting
- LANL (Los Alamos National Laboratory) × UB (SUNY Buffalo)
- Authors: Richard Linares (Director's Postdoctoral Fellow), John L. Crassidis (CUBRC Professor)
