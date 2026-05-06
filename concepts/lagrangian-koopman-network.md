---
title: "LaCGKN — Lagrangian Conditional Gaussian Koopman Network"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [lagrangian-data-assimilation, koopman-operator, conditional-gaussian, deep-learning, data-assimilation, tracer-dynamics]
sources: [raw/papers/lagrangian-koopman-wang26.md]
confidence: high
---

# LaCGKN: Lagrangian Conditional Gaussian Koopman Network

**arXiv:** [2603.14115](https://arxiv.org/abs/2603.14115)
**Authors:** [[zhongrui-wang|Zhongrui Wang]], [[chuanqi-chen-wisconsin|Chuanqi Chen]], [[jin-long-wu|Jin-Long Wu]], [[nan-chen-wisconsin|Nan Chen]] (UW-Madison)
**Year:** 2026

## 개요

LaCGKN은 **Lagrangian 데이터 동화**(이류 추적자(tracer)의 궤적에서 Eulerian 유동장 복원)를 위한 **구조 보존 데이터 기반 프레임워크**이다. [[conditional-gaussian-koopman-network|CGKN]]을 Lagrangian 설정으로 확장하여, 추적자 위치 관측으로부터 고차원 유동장을 효율적으로 추정한다.

## 핵심 아이디어

- **Conditional Gaussian 구조** — 잠재 공간에서 비선형 확률적 시스템이 조건부 가우시안 구조를 가지도록 설계하여 **앙상블 없이 해석적 사후 업데이트** 가능
- **Koopman 이론 기반 잠재 동역학** — Eulerian 유동장을 저차원 잠재 공간으로 인코딩하고 선형 동역학으로 근사
- **추적자 균질화 (Tracer Homogenization)** — 모든 추적자에 동일한 신경망을 적용하여 **순열 동변성(permutation equivariance)** 확보 → [[tracer-homogenization]] 참조
- **푸리에 위치 인코딩** — 이동 추적자 위치에서 국소 유동 특징 재구성 능력 향상
- **SVD 기반 저랭크 전이 연산자** — `G2 ≈ U diag(s) V^T + diag(δ)`로 파라미터 수를 O(d_z²)에서 O(d_z·r)로 감소

## 아키텍처

1. **인코더 E**: CNN으로 Eulerian 유동장(u2)을 저차원 잠재 상태 z로 압축
2. **디코더 D**: 잠재 상태를 다시 물리 공간으로 복원
3. **Conditional Gaussian Network (CGN) η**: 계수 F1, G1, F2, G2 출력
   - F1, G1: 추적자 균질화 + 푸리에 위치 인코딩 적용
   - G2: SVD 기반 저랭크 근사
4. **조건부 가우시안 필터**: 해석적 사후 평균/공분산 업데이트 (Kalman-Bucy 필터 일반화)
5. **불확실성 네트워크 U**: 사후 표준편차 추정

## 2단계 학습

- **Stage 1**: DA 손실 제외하고 AE + 예측 손실로 학습 → Sigma1 추정
- **Stage 2**: DA 손실 포함 재학습 → 불확실성 네트워크 U 학습

## 관련 개념

- [[tracer-homogenization|Tracer Homogenization]] — 순열 동변성 인코딩 (시그마 포인트 집합 연결성)
- [[conditional-gaussian-koopman-network|CGKN]] — 기본 CGKN 프레임워크
- [[auto-diff-data-assimilation|Auto-differentiable Data Assimilation]] — 데이터 기반 DA 패러다임
- [[kalmannet|KalmanNet]] — 다른 접근의 learnable filter
- [[rigor-filter|RIGOR Filter]] — 미분 가능 필터
- [[ensemble-kalman-filter|Ensemble Kalman Filter]] — EnKF (비교 기준)

## 시그마 포인트 연구와의 연결

**추적자 균질화**는 시그마 포인트 클라우드를 순열 불변 집합(permutation-invariant set)으로 처리하는 문제와 직접적으로 연결됨:
- 각 추적자(시그마 포인트)에 동일한 함수를 적용하여 순열 동변성 확보
- 임의 개수의 추적자(시그마 포인트)로 일반화 가능
- Set Transformer, Deep Sets 등 집합 인코딩 방법론과 밀접한 관련

## 성능

- 예측: LaCGKN32 (d_z=32×32×2)가 CNN 기반 baseline보다 안정적인 장기 예측
- DA: 완전 QG 모델을 사용하는 EnKF보다 낮은 posterior RMSE 달성 (0.464 vs 0.481)
- 효율성: EnKF 대비 약 100배 빠름 (CPU 기준)
- 추적자 수 불변성: 학습 후 임의 개수 추적자에 일반화 가능
