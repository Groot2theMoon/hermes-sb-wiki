---
title: "Optimized Sigma Point Selection — n+1 Points for UKF"
created: 2026-05-05
updated: 2026-05-05
sources: [raw/papers/optimized-sigma-points-ukf.md]
type: concept
tags: [sigma-point, ukf, kalman-filter, nonlinear-estimation, sampling]
sources:
  - raw/papers/optimized-sigma-points-ukf.md
confidence: high
---

# Optimized Sigma Point Selection — n+1 Points for UKF

**Cheng & Liu** (Beijing Jiaotong University, 2015)

## 개요

표준 UKF는 2n+1개의 sigma point를 사용하지만, **n+1개의 sigma point만으로도 mean과 covariance를 완전히 표현할 수 있음**을 증명. 기존 simplex sigma point set의 수치적 불안정성 문제(n차원에서 radius가 $2^{\lfloor n/2\rfloor}$로 폭발)를 해결하는 새로운 n+1-point 전략 제안.

## Sigma Point 수의 진화

| 방법 | Point 수 | 특징 | 문제점 |
|:----|:--------|:-----|:-------|
| Standard UKF (Julier) | 2n+1 | 대칭적 배치, 3차 정확도 | 계산량 n에 비례 |
| Simplex (Julier 2002) | n+1 | 최소점, 3차 정확도 | radius $2^{\lfloor n/2\rfloor}$로 발산 |
| Cheng-Liu (본 논문) | **n+1** | 최소 유지, radius $O(\sqrt{n})$ | 수치적으로 안정 |

## 핵심 아이디어

기존 n+1 simplex set의 문제는 spherical radius가 차원에 따라 지수적으로 증가한다는 점. Cheng & Liu는 **Mercer's theorem**과 **Gram matrix** 분석을 통해:

1. Simplex에서 각 점의 norm이 $n / (n+1)$로 bounded된 새로운 구성법 제안
2. Point distribution radius가 $\sqrt{n/(n+1)}$로 $O(\sqrt{n})$에 비례 → 수치적 안정성 확보
3. Mean, covariance, 그리고 (중요하게) **3차 모멘트**까지 기존 n+1 set과 동등하게 유지

## 수치 실험

- **비선형 변환 테스트:** 제안된 n+1 set이 2n+1 set과 비교해 comparable accuracy
- **UKF 적용:** tracking 문제에서 유사한 MSE 성능 유지하면서 40-50% 계산량 감소
- **고차원 (n=10):** simplex radius 문제로 기존 n+1 point는 발산하지만, 제안 방법은 안정적

## Wikilinks
- [[differentiable-sigma-point-quadrature]] — Differentiable sigma point quadrature (RIGOR)
- [[square-root-unscented-kalman-filter]] — SR-UKF
- [[ma-ukf-meta-adaptive]] — MA-UKF (meta-learned weights)
- [[ukf-learning-sigma-points]] — UKF-L (Turner & Rasmussen)

## References
- DOI: Not available (journal paper)
- Beijing Jiaotong University
