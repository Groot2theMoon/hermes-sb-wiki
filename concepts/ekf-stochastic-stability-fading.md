---
title: "EKF Stochastic Stability over Fading Channels"
created: 2026-05-01
updated: 2026-05-01
type: concept
tags: [ekf, stochastic-stability, fading-channels, transmission-failure, signal-fluctuation]
sources:
  - raw/papers/modified-ekf-stochastic-stability-fading-liu17.md
confidence: high
---

# EKF Stochastic Stability over Fading Channels

> **Liu, X., Li, L., Li, Z., Iu, H. H. C. & Fernando, T. (2017).** "Stochastic stability of modified extended Kalman filter over fading channels with transmission failure and signal fluctuation." Signal Processing, 138, 220–232.

## 개요

**Fading channel** 환경에서 EKF의 stochastic stability 분석. Transmission failure + signal fluctuation을 동시에 고려한 **design-oriented analysis**.

## 핵심 기여

- **Fading channel model**: transmission failure (packet loss) + signal fluctuation (fading magnitude)
- **Sufficient conditions for stochastic stability**: fading channel parameters와 EKF gain의 관계
- **Reif (1999)**의 EKF stability 분석을 fading channel로 확장

## RIGOR 관련성

- Reif (1999)의 EKF stochastic stability가 fading channel로 확장된 버전
- RIGOR의 A+NN 구조에서 measurement model이 nonlinear일 때의 stability 분석에 적용
- EM Q,R이 fading channel 환경에서도 수렴 안정성을 유지함을 보이는 근거

## Related
- [[ukf-stochastic-stability]] — UKF 버전
- [[lure-stability]] — Lur'e stability
