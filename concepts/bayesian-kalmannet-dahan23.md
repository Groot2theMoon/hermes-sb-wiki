---
title: "Bayesian KalmanNet — Uncertainty Quantification in DNN-Augmented Kalman Filter"
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [kalman-filter, deep-learning, uncertainty-quantification, bayesian, differentiable-filtering, kalmannet]
sources: [raw/papers/bayesian-kalmannet-dahan23.md]
confidence: high
---

# Bayesian KalmanNet — Uncertainty-Aware KalmanNet

**Dahan, Revach, Dunik & Shlezinger** (2023). arXiv:2309.03058.

## 개요

KalmanNet (Revach et al. 2021)의 확장판. KalmanNet은 **KF의 Kalman gain을 RNN으로 학습**하지만, covariance 정보를 제공하지 않는 근본적 한계가 있다. Bayesian KalmanNet은 **Bayesian deep learning (MC Dropout)** 을 통합하여 error covariance를 추가적인 domain knowledge 없이 추출한다.

## 핵심 방법론

- **KalmanNet recap:** RNN이 observation innovation $\Delta y_t$와 state evolution 차이를 입력받아 Kalman gain $K_t$ 출력 → KF update
- **Bayesian extension:** RNN weights에 MC Dropout 적용 → $S$회 stochastic forward pass → $K_t^{(s)}$ 샘플링 → covariance 추정
- **Covariance extraction:** $\hat{P}_{t|t} = \text{Cov}( \{ K_t^{(s)} \Delta y_t \}_{s=1}^S )$ — 추가 모듈 없이 dropout만으로 uncertainty 획득

## RIGOR와의 차별점

| 요소 | Bayesian KalmanNet | RIGOR |
|------|-------------------|-------|
| **Gain 구조** | RNN-learned $K_t$ (black-box) | UKF analytic gain (interpretable) |
| **Dynamics** | SS model assumed partially known | A(x)·x + NN — jointly learned |
| **Covariance** | MC Dropout → 근사 (noise) | UKF: analytic P_pred, P_filt |
| **Uncertainty** | Post-hoc sampling | Built-in (KF covariance propagation) |
| **Robustness** | Dropout rate tuning 필요 | Deterministic → 재현성 |

**핵심 차이:** Bayesian KalmanNet은 **MC Dropout으로 uncertainty를 "붙인"** 반면, RIGOR는 **UKF 자체가 uncertainty (P_pred, P_filt)를 구조적으로 제공**한다. RIGOR의 covariance는 analytic하게 propagate되므로 추가 sampling overhead 없이 uncertainty-aware filtering이 가능.

## 한계 (RIGOR 대비)

1. MC Dropout은 근사적 uncertainty — true Bayesian posterior가 아님
2. $S$회 forward pass → inference latency 증가
3. KalmanNet 자체가 KF의 부분적 지식(SS 모델)을 요구 → RIGOR처럼 완전 data-driven이 아님
4. UKF 대비 Kalman gain이 black-box → 해석 불가능

## 참고 문헌

- Dahan et al. (2023). Bayesian KalmanNet. arXiv:2309.03058.
- Revach et al. (2021). KalmanNet. arXiv:2107.10043. (이미 wiki [[kalmannet|참조]])

## Wikilinks
- [[kalmannet]] — 원본 KalmanNet
- [[rigor-filter]] — RIGOR의 UKF 기반 uncertainty propagation
- [[maml-kalmannet]] — MAML 기반 KalmanNet 확장
- [[variational-bayes-adaptive-kalman-filter]] — VB 기반 noise adaptation과의 비교
