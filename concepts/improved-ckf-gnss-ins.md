---
title: "Improved Cubature Kalman Filter for GNSS/INS — Posterior Sigma-Point Error Transformation"
created: 2026-05-05
updated: 2026-05-09
type: concept
tags: [ckf, gnss, ins, navigation, sigma-point, nonlinear-filtering, ieee-tsp]
sources:
  - raw/papers/improved-ckf-gnss-ins.md
  - raw/papers/cui17-improved-ckf-sigma-transform.md
confidence: medium
---

# Improved Cubature Kalman Filter for GNSS/INS — Posterior Sigma-Point Error Transformation

**Cui, Chen, Tang** (Southeast University, China, 2017)  
*IEEE Transactions on Signal Processing*, 65(11), 2975-2986

## 개요

GNSS 신호 두절(signal outage) 상황에서 강건한 CKF를 위해 **posterior sigma-point error transformation** 기법을 제안. Prediction 단계의 sigma-point error 공분산을 update 단계의 posterior 도메인으로 변환하여, observation이 unavailable할 때도 covariance를 정확하게 유지.

## 문제 정의

Tightly coupled GNSS/INS에서 GNSS 신호 두절이 발생하면:
- Observation 부재로 filter gain이 0에 가까워짐
- Prediction uncertainty가 과소 또는 과대 추정
- 재획득(re-acquisition) 시 filter divergence

## 제안: ICKF (Improved CKF)

### 핵심 아이디어
기존 CKF/Cubature rule의 한계는 prediction → update 단계에서 sigma point error covariance가 **단순히 identity matrix로 scaling**된다는 점. 저자들은 **posterior sigma-point error 행렬**을 prediction 단계에서 update 도메인으로 직접 변환:

$P_{k|k} = P_{k|k-1} - K_k P_{zz,k} K_k^T$ (표준)
→ $S_{k|k} = \text{Tria}([S_{k|k-1} - K_k S_{zz,k}, K_k\sqrt{R_k}])$ (제안: square-root form)

### 이론적 보장
- Error covariance의 upper bound 이론적 분석
- Signal outage 시간이 길어져도 error covariance가 유계임을 증명
- 기존 CKF 대비 observation missing 상황에서 일관된 성능 향상

## 성능

| 시나리오 | CKF | ICKF (제안) |
|:--------|:---|:-----------|
| 정상 GNSS | 동등 | 동등 |
| 10s outage | 발산 위험 | 안정적 유지 |
| 30s outage | 발산 | 복원 가능 |
| 재획득 후 | 느린 수렴 | 빠른 수렴 |

## Wikilinks
- [[bing-cui]] — First author
- [[square-root-unscented-kalman-filter]] — SR-UKF (square-root form)
- [[generalized-gaussian-cubature]] — Generalized Gaussian Cubature (Linares & Crassidis)
- [[multi-scaled-ukf]] — Multi-scaled UKF
- [[optimized-sigma-points-n-plus-1]] — n+1 sigma point

## References
- DOI: [10.1109/TSP.2017.2679685](https://doi.org/10.1109/TSP.2017.2679685)
- Southeast University, Key Lab of Micro-Inertial Instrument
