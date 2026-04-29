---
title: Deep Ensembles for Uncertainty Estimation
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, training, inference, benchmark, paper]
sources: [raw/papers/1612.01474v3 (1).md]
confidence: high
---

# Deep Ensembles for Predictive Uncertainty

## 개요

**Deep Ensembles**는 [[balaji-lakshminarayanan|Balaji Lakshminarayanan]], Alexander Pritzel, Charles Blundell (DeepMind)이 2017년 제안한 방법으로, **Multiple deterministic neural networks의 앙상블**을 통해 간단하면서도 효과적인 불확실성(uncertainty) 추정을 달성한다^[raw/papers/1612.01474v3 (1).md].

Bayesian NN의 복잡성 없이도 **비슷하거나 더 나은 uncertainty calibration**을 제공.

## 핵심 아이디어

### 방법
1. 동일한 아키텍처의 NN을 **다수의 random seed**로 학습
2. 각 네트워크는 **Adversarial training으로 smoothness 확보**
3. 예측 시: 모든 네트워크의 예측을 평균 (ensemble prediction)
4. 불확실성: 예측 분포의 분산으로 추정

### Classification
- 각 네트워크의 softmax 예측을 평균
- 불확실성: 예측 간 분산 (entropy 기반)

### Regression
- 각 네트워크가 **Gaussian distribution의 mean + variance** 모두 예측
- Negative log-likelihood (NLL) loss 최적화
- 앙상블: mixture of Gaussians로 결합

## 장점

| 특성 | Deep Ensembles | Bayesian NN |
|------|---------------|-------------|
| 구현 | 매우 간단 | 복잡 |
| 병렬화 | 완벽 | 제한적 |
| Hyperparameter tuning | 거의 불필요 | 필요 |
| OOD 탐지 | 우수 | 우수 |
| Calibration | 우수 | 우수 |
| Computational cost | N배 (병렬화 가능) | 다양 |

### OOD (Out-of-Distribution) 감지
- MNIST에서 학습 → notMNIST (unknown)에서 더 높은 uncertainty
- SVHN in/out-of-distribution 구분 우수
- **Dataset shift에 robust한 uncertainty 표현**

## References
- B. [[balaji-lakshminarayanan|Lakshminarayanan]], A. Pritzel, C. Blundell. "Simple and Scalable Predictive Uncertainty Estimation using Deep Ensembles", *NeurIPS 2017*
- [[variational-autoencoder]] — VAE도 generative 방식의 uncertainty 제공 가능
- [[mc-dropout]] — MC Dropout (대안적 uncertainty)
- [[ensemble-loss-landscape]] — Loss landscape 분석
