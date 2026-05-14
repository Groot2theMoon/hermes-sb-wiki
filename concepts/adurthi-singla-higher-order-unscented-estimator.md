---
title: "Higher-Order Unscented Estimator — Asymmetric Sigma Points with Closed-Form Weights"
created: 2026-05-05
updated: 2026-05-05
sources: [raw/papers/adurthi-singla-2022-higher-order-unscented-estimator.md]
type: concept
tags: [sigma-point, ukf, unscented-transform, skewness, kurtosis, kalman-filter, nonlinear-estimation]
sources:
  - raw/papers/adurthi-singla-2022-higher-order-unscented-estimator.md
confidence: high
---

# Higher-Order Unscented Estimator (HOUE)

**Stojanovski & Savransky** (Cornell University, 2021). *J. Guidance, Control & Dynamics*, 44(12).

## 개요

HOUT의 CP tensor decomposition 접근과 달리, **closed-form explicit solution으로 3rd, 4th moment를 matching하는 asymmetric sigma points + weights**를 생성. 표준 UKF 대비 추가 계산 overhead 거의 없음. 세 가지 동역학계(aircraft coordinated turn, rotating rigid body, projectile with drag)에서 검증.

## 핵심 차별점 (vs HOUT)

| 구분 | HOUT (Easley) | HOUE (Stojanovski) |
|------|-------------|-------------------|
| 방법 | CP tensor decomposition (iterative) | **Closed-form explicit solution** |
| Convergence | Linear convergence 증명 | 해석적 — convergence 문제 없음 |
| Applicability | 범용적 | Skewness/kurtosis에 대한 **rigorous constraints** 존재 |
| 계산 복잡도 | 중간 (power method) | **낮음** (closed-form) |
| Point 수 | $2(d+J+L)$ | $2n+1$ 근처 유지 |
| JAX suitability | HOPM 구현 필요 | **즉시 differentiable** (closed-form) |

## 핵심 수학

표준 UKF: $\sigma_i = \mu \pm \sqrt{(n+\lambda)P}_i$ — symmetric

HOUE: $\sigma$-points = {mean point + covariance-encoding points + **skewness-encoding points + kurtosis-encoding points**}

- 3rd moment matching: 추가적인 asymmetric point pairs → skewness ≠ 0
- 4th moment matching: kurtosis 조정을 위한 weight modification → fat-tail 포착
- 모든 식이 closed-form → UKF 대비 execution time "only slightly longer"

## 실험 결과

- High kurtosis noise에서 UKF보다 robust (extreme outlier 미발생)
- Conjugate unscented transform filter보다 훨씬 빠름
- Execution time: UKF와 거의 동일, CUT filter의 수 배 빠름

## RIGOR 적용성

**강점:**
- JAX에서 closed-form → 그냥 함수 호출로 대체 가능 (no iterative decomposition)
- Sigma point 수가 standard UKF와 유사 → 기존 scan 구조 훼손 없음
- Differentiable — 모든 연산이 elementary arithmetic

**약점:**
- Applicability constraints — VDP에서 만족되는지 검증 필요
- Skewness/kurtosis가 특정 bound 안에 있어야 함 (Corollary-type constraints)

## Wikilinks
- [[higher-order-unscented-transform]] — HOUT (tensor decomposition 접근)
- [[generalized-gaussian-cubature]] — GGC (arbitrary order cubature)
- [[square-root-unscented-kalman-filter]] — SR-UKF 기반
- [[rigor-sigma-point-research]] — RIGOR 연구 방향

## References
- Stojanovski, Z. & Savransky, D. (2021). Higher-Order Unscented Estimator. *J. Guidance, Control & Dynamics*, 44(12). DOI:10.2514/1.G006109.
