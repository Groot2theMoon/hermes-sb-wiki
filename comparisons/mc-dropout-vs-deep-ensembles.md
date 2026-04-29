---
title: MC Dropout vs Deep Ensembles — 비교
created: 2026-04-29
updated: 2026-04-29
type: comparison
tags: [comparison, uncertainty, benchmark, training]
sources: [raw/papers/1912.02757v2.md]
---

# MC Dropout vs Deep Ensembles — 불확실성 정량화 방법 비교

MC Dropout과 Deep Ensembles은 딥러닝에서 **epistemic uncertainty**를 정량화하는 대표적 방법이다. MC Dropout은 단일 모델 내에서 확률적 샘플링으로 불확실성을 추정하는 반면, Deep Ensembles은 여러 독립적 모델의 다양성으로 불확실성을 포착한다.

## 비교 표

| 차원 | MC Dropout (Gal & Ghahramani, 2016) | Deep Ensembles (Lakshminarayanan et al., 2017) |
|------|:----------------------------------:|:---------------------------------------------:|
| **핵심 메커니즘** | 학습 시 dropout + 추론 시 Monte Carlo 샘플링 | 여러 random seed로 독립적 학습 → 예측 평균/분산 |
| **모드 탐색** | 단일 모드 내 local uncertainty | **여러 모드 탐색** (multi-modal posterior) |
| **계산 비용** | 1회 학습 (추론 시 M배) | M배 학습 (병렬 가능) |
| **OOD 검출 성능** | 보통 | ✅ 우수 |
| **Calibration** | 보통 | ✅ 우수 |
| **이론적 정당성** | Bayesian NN 근사 (variational inference) | Bootstrap 직관 (실제로는 모드 다양성) |
| **Loss landscape** | 단일 basin 내 샘플링 | 여러 basin의 함수 모드 |

## 장단점

| 방법 | 장점 | 단점 |
|:---|:----|:----|
| **MC Dropout** | 구현 간단, 단일 모델만 저장 | 불확실성 과소추정 경향, calibration 불량 (Fort et al., 2019) |
| **Deep Ensembles** | 높은 OOD 검출력, 우수한 calibration | M배 학습/저장 비용, 무작위성에 의존 |

## 언제 무엇을 선택할까?

| 사용 사례 | 권장 방법 |
|-----------|:--------:|
| 계산 자원이 제한적인 경우 | MC Dropout |
| OOD 검출이 중요한 경우 (ex: 안전-critical 시스템) | Deep Ensembles |
| 이미 학습된 단일 모델이 있는 경우 | MC Dropout (fine-tuning 불필요) |
| Uncertainty calibration이 중요한 경우 | Deep Ensembles |
| DMN/PINN uncertainty 정량화 | Deep Ensembles (mode 다양성 필요) |

## 관련 페이지
- [[mc-dropout]] — MC Dropout 상세
- [[deep-ensembles]] — Deep Ensembles 상세
- [[ensemble-loss-landscape]] — Deep Ensembles 이론적 분석
- [[uncertainty-quantification-deep-learning]] — UQ 리뷰
- [[kennedy-ohagan-calibration]] — 고전적 Bayesian calibration
- [[balaji-lakshminarayanan]] — Deep Ensembles 제안자
