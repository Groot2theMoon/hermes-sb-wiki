---
title: "UKF Scaling Parameter — Analysis and Adaptive Setting"
created: 2026-05-05
updated: 2026-05-09
sources: [raw/papers/dunik12-ukf-adaptive-scaling.md, raw/papers/ukf-scaling-adaptive-setting.md]
type: concept
tags: [ukf, scaling-parameter, adaptive-filtering, nonlinear-estimation, ieee-tac]
sources:
  - raw/papers/ukf-scaling-adaptive-setting.md
  - raw/papers/dunik12-ukf-adaptive-scaling.md
confidence: high
---

# UKF Scaling Parameter — Analysis and Adaptive Setting

**Duník, Simandl, Straka** (University of West Bohemia, 2012)  
*IEEE Transactions on Automatic Control*, 57(9), 2411-2416

## 개요

UKF의 scaling parameter $\kappa$ (혹은 scaled UT의 $\lambda = \alpha^2(n+\kappa) - n$)의 선택이 estimation quality에 미치는 영향을 체계적으로 분석하고, **adaptive scaling parameter 설정 알고리즘**을 제안한 TAC technical note.

## Scaling Parameter의 역할

UKF sigma point 배치에서 scaling parameter $\kappa$는:

- Sigma point의 spread 제어: $\mathcal{X}_i = \hat{x} \pm \sqrt{(n+\kappa)P_x}$
- $\kappa = 0$: **CKF** (cubature Kalman filter)와 일치
- $\kappa = 3-n$: **Gaussian 최적** (4차 moment matching, Julier 추천)
- $\kappa > 0$: point spread 증가 → nonlinearity 강한 경우 유리
- $\kappa < 0$: spread 축소 → semi-definiteness 위험

## 분석 결과

1. **표준 추천값($\kappa = 3-n$)의 문제:** n > 3이면 $\kappa$가 음수가 되어 covariance positive semi-definiteness 보장이 어려움
2. **Scaling parameter가 estimation quality에 미치는 영향**을 이론적으로 정량화
3. UKF와 CKF는 **scaling parameter만 다른 동일 알고리즘**임을 재확인

## Adaptive Setting Algorithm

제안된 방법:

1. 각 time step에서 candidate $\kappa$ 값들에 대해:
   - Predicted covariance $P_{k|k-1}^{(\kappa)}$ 계산
   - Measurement innovation covariance $P_{zz,k}^{(\kappa)}$ 계산
2. 실제 innovation $\tilde{z}_k$와의 consistency를 평가:
   - $\tilde{z}_k^T [P_{zz,k}^{(\kappa)}]^{-1} \tilde{z}_k$가 $\chi^2$ 분포와 일치하는지 검정
3. 가장 consistent한 $\kappa$ 선택

**결과:** Fixed $\kappa$ 대비 adaptive setting이 MSE를 최대 30-50% 개선.

## Wikilinks
- [[square-root-unscented-kalman-filter]] — SR-UKF
- [[multi-scaled-ukf]] — Multi-scaled UKF (Levy & Klein)
- [[ma-ukf-meta-adaptive]] — MA-UKF (meta-learned weights)
- [[optimized-sigma-points-n-plus-1]] — n+1 sigma point

## References
- DOI: [10.1109/TAC.2012.2188424](https://doi.org/10.1109/TAC.2012.2188424)
- UWB (University of West Bohemia), NTIS Centre
