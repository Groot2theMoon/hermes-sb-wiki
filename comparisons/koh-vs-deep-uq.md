---
title: KOH Bayesian Calibration vs Deep Learning UQ Methods — 비교
created: 2026-04-29
updated: 2026-04-29
type: comparison
tags: [comparison, uncertainty, surrogate-model, benchmark]
sources: [raw/papers/kennedy01.md]
---

# Kennedy-O'Hagan Calibration vs Deep Learning UQ Methods — 불확실성 정량화 시대 비교

Kennedy-O'Hagan (2001)은 **고전적 Bayesian UQ**의 표준이고, Deep Ensembles/MC Dropout (2016-2019)은 **딥러닝 시대의 UQ** 접근법이다. 두 접근법의 철학과 적용 영역이 다르므로, 비교를 통해 각각의 적합성을 이해하는 것이 중요하다.

## 비교 표

| 차원 | KOH Bayesian Calibration (2001) | Deep Learning UQ (DLMC Dropout/Emsemble) |
|:-----|:-------------------------------:|:----------------------------------------:|
| **핵심 아이디어** | GP emulator + model discrepancy $\delta(x)$ | Random initialization / dropout → 예측 분산 |
| **Model inadequacy** | ✅ 명시적 모델링 ($\delta(x)$) | ❌ 암묵적 (데이터로 흡수) |
| **Surrogate** | GP (closed-form posterior) | DNN (no closed-form) |
| **데이터 효율성** | ✅ 우수 (소규모 데이터) | ❌ 대량 데이터 필요 |
| **확장성 (고차원)** | ❌ GP의 차원 저주 | ✅ DNN의 고차원 표현력 |
| **계산 비용** | GP: $O(N^3)$ (offline) + cheap (online) | DNN: cheap (offline) + $O(M)$ (online) |
| **주요 적용 분야** | Computer experiments, engineering simulation | Vision, NLP, robotics |
| **물리 법칙 통합** | 가능 (GP prior로) | ✅ PINN, physics-constrained loss |

## 장단점

| 방법 | 강점 | 약점 |
|:----|:----|:----|
| **KOH Calibration** | Model inadequacy 명시적 처리, 불확실성의 모든 소스 체계적 분해, GP의 closed-form 예측 | GP의 차원 저주, 대규모 데이터 비효율, 비싼 커널 학습 |
| **Deep UQ (Ensemble/Dropout)** | 고차원/대규모 데이터 적합, DNN의 표현력, end-to-end 학습 | Model inadequacy 무시, calibration 불량 가능, 이론적 정당성 약함 |

## 보완적 사용

가장 강력한 접근법은 두 방법을 **결합**하는 것이다:

- **Deep Surrogate + Bayesian Calibration:** DNN으로 surrogate 구축 (표현력) → KOH 스타일의 Bayesian calibration으로 불확실성 정량화
- **Physics-informed + UQ:** PINN으로 물리 법칙 보존 → Deep ensemble/MC Dropout으로 예측 불확실성 추정

## 언제 무엇을 선택할까?

| 사용 사례 | 권장 방법 |
|-----------|:--------:|
| 실험 데이터가 적고 (10-100개) 고전산 모델 calibration | KOH Bayesian Calibration |
| 대량 데이터 (10K+)로 복잡한 패턴 학습 | Deep Ensembles |
| 시뮬레이션 + 실험 데이터 결합 (DMN 흡음재) | **KOH + Deep Surrogate 결합** |
| 물리 법칙 준수가 critical | PINN + Deep Ensembles |
| DMN 파라미터 보정 (실험 데이터) | KOH 스타일 Bayesian calibration on DMN surrogate |

## 관련 페이지
- [[kennedy-ohagan-calibration]] — KOH 상세
- [[mc-dropout]] — MC Dropout
- [[deep-ensembles]] — Deep Ensembles
- [[ensemble-loss-landscape]] — Loss landscape 이론
- [[uncertainty-quantification-deep-learning]] — UQ 리뷰
- [[physics-constrained-surrogate]] — Physics-constrained surrogate
- [[anthony-ohagan]] — KOH 공동 저자
