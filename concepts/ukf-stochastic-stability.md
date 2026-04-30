---
title: "UKF Stochastic Stability — Modified UKF with Fading Measurements"
created: 2026-05-01
updated: 2026-05-01
type: concept
tags: [ukf, stochastic-stability, fading-measurements, bounded-error, nonlinear-filtering]
sources:
  - raw/papers/modified-ukf-stochastic-stability-li17.md
confidence: high
---

# UKF Stochastic Stability with Fading Measurements

> **Li, L., Yu, D., Xia, Y. & Yang, H. (2017).** "Stochastic stability of a modified unscented Kalman filter with stochastic nonlinearities and multiple fading measurements." Journal of the Franklin Institute, 354, 650–667.

## 개요

**수정된 UKF**의 stochastic stability를 stochastic nonlinearities (곱셈 확률적 교란) + 다중 fading measurement 환경에서 분석. 각 센서별 독립적 fading probability.

## 핵심 결과

- **Fading probability의 평균에 하한이 존재하면** UKF error boundedness 보장
- 충분조건 도출 (sufficient conditions for stochastic stability)
- Stochastic nonlinearity → multiplicative disturbance로 모델링
- **Xiong (2002)**의 UKF stability 분석을 확장

## RIGOR 관련성

RIGOR가 SR-UKF 기반이므로, UKF stochastic stability 조건은:
- EM Q,R + SR-UKF에서 **estimation error boundedness의 이론적 근거** 제공
- Fading measurement 모델 → RIGOR의 measurement dropout scenario 분석에 활용
- **충분조건 하에서 EM Q,R의 self-calibration과 무관하게 error boundedness 유지**

## Related
- [[ekf-stochastic-stability-fading]] — EKF 버전
- [[lure-stability]] — Lur'e stability (complementary)
