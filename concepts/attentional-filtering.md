---
title: Attentional Filtering (AF) — Dynamic System State Estimation as an Attention Mechanism
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [state-estimation, attention, hybrid-model, deep-learning, kalman-filter, bayesian-filter, ssrn]
sources: [raw/papers/attentional-filtering-lin25.md]
confidence: medium
---

# Attentional Filtering (AF)

**Attentional Filtering (AF)** 는 [[andi-lin|Andi Lin]], Wen-An Zhang, [[lei-guo|Lei Guo]]가 2025년 Information Fusion 저널에 발표한 프레임워크로, **인간의 주의(attention) 메커니즘에서 영감을 받아 동적 시스템 상태 추정 문제를 attention 메커니즘으로 재구성**한다. 기존 베이지안 필터가 Gaussian 가정 하의 분포 융합에 의존하는 반면, AF는 **attention 가중치 기반의 선형 가중합**으로 상태 추정을 수행한다.

> **참고:** 본 논문은 SSRN preprint (5123240)으로, 전체 분량이 105줄에 불과하며 일부 내용이 truncated된 상태이다.

## 핵심 아이디어

1. **Bayesian 분포 융합 → Attention 가중치 기반 융합**: 기존 베이지안 필터의 posterior 분포 계산을 attention weight 기반의 weighted arithmetic average로 대체
2. **Hybrid SSM (지식 기반 + 학습 기반)**: 부분적으로 알려진 동역학 시스템에서 knowledge-based model과 DNN의 기여도를 **attention selection mechanism**으로 제어
3. **Selective Transition Model**: GRU 등의 RNN으로 **누락된 동역학 정보를 hidden state로 학습**하여 knowledge-based transition을 보완
4. **Selective Emission Model**: Trunk-mask branch 구조로 knowledge-based feature와 learning-based feature를 선택적으로 결합

## 아키텍처

### Prediction Step: Selective Transition Model
```
x_t, h_t = f^selection_t(x_{t-1}, h_{t-1})
x_{t|t-1} = f(x_{t-1|t-1}) + c_t ⊙ h̃_t
```
- **c_t**: selection factor — hidden state에서 얼마나 많은 정보를 선택할지 결정
- GRU 기반 RNN으로 missing dynamics 학습

### Update Step: Selective Emission Model
```
y_t = E_knowledge(o_t)         # 지식 기반 encoder
a_t = Trunk(o_t; θ_T)          # 학습 기반 encoder (trunk branch)
m_t = Mask(a_t, y_t)           # soft mask
z_t = y_t + m_t ⊙ a_t          # selective emission output
```

### Attentional Fusion
```
x_{t|t} = α^(1)_t ⊙ x_{t|t-1} + α^(2)_t ⊙ z_t
```
- **α_t**: softmax로 정규화된 attention 가중치, GRU 기반 attention score network에서 계산
- 학습된 가중치로 dynamic 정보와 measurement 정보의 중요도를 결정

## 실험 결과

| 실험 환경 | AF 성능 (MSE [dB]) | 비교 대상 |
|-----------|-------------------|----------|
| **Canonical Linear System (F mismatch)** | **-41.57** | KF 12.61, OKF -39.71, KalmanNet -40.68 |
| **Canonical Linear System (H mismatch)** | **-40.55** | KF 16.74, OKF -38.32, KalmanNet -21.19 |
| **Lorenz Attractor (J=5)** | **-20.86** | EKF -13.28, UKF -13.27, KalmanNet -18.63 |
| **Target Tracking (avg RMSE)** | **0.425** | KF 0.410, KalmanNet 0.449 |
| **Michigan NCLT (MSE [m²])** | **2.910** | KF 3.103, KalmanNet 3.269 |
| **Non-Gaussian Noise (Beta)** | **-7.2414** | PF -5.4489, KalmanNet -6.9356 |

AF는 **KalmanNet보다 적은 파라미터**(2,794개 vs 5,208~18,050개)로 더 우수한 성능을 달성했으며, **model mismatch, 비선형성, non-Gaussian noise** 환경에서 특히 강건함.

## 관련 개념

- [[kalmannet|KalmanNet]] — Kalman gain을 RNN으로 대체한 hybrid filter, AF의 가장 직접적인 비교 대상
- [[deep-kalman-filter|Deep Kalman Filter]] — VAE 기반 non-linear SSM 학습, attention 기반 융합과의 차별점
- [[rigor-filter|RIGOR Filter]] — Differentiable SR-UKF, model-based + data-driven의 다른 접근
- [[state-space-model|State-Space Model]] — AF의 기반이 되는 SSM 프레임워크
- [[kalman-filter|Kalman Filter]] — 고전적 Bayesian 필터, AF가 확장하는 기반
- [[robust-filter-attention|Robust Filter Attention]] — Attention을 filtering으로 재해석한 병렬 연구

## 한계점

- **Preprint**: SSRN preprint으로, peer review를 거치지 않음
- **정보량 제한**: 105줄로 truncated되어 상세한 이론적 유도 및 ablation study가 부족
- **Attention 융합의 단순성**: 2개의 정보 소스(dynamic, measurement)만을 고려, 다중 센서 융합으로의 일반화 검증 필요
- **Gaussian 가정**에서 완전히 벗어나지는 않음 (MSE loss 기반 학습)

## 참고 문헌

- Lin, Zhang, Guo, "Attentional Filtering: Dynamic System State Estimation as an Attention Mechanism", *Information Fusion*, 2025. SSRN: 5123240
- Revach et al., "KalmanNet: Neural Network Aided Kalman Filtering for Partially Known Dynamics", IEEE TSP, 2022 — [[kalmannet]]
- Haarnoja et al., "Backprop KF: Learning Discriminative Deterministic State Estimators", NeurIPS 2016
