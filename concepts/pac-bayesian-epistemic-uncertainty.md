---
title: "PAC-Bayesian Analysis of Epistemic Uncertainty in Variational Inference"
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [uncertainty, training, mathematics, classic-ai, paper]
sources: [raw/papers/futami25a.md]
confidence: medium
---

# PAC-Bayesian Epistemic Uncertainty in Variational Inference

## 개요

Futami (Osaka U. / RIKEN AIP)는 변분 추론(Variational Inference, VI)에서 널리 사용되는 **epistemic uncertainty (EU) 지표** — posterior predictive variance 및 conditional mutual information — 에 대한 최초의 수렴 이론을 제시한다. PAC-Bayesian 프레임워크를 통해 EU metrics와 excess risk 간의 새로운 관계를 확립하고, EU 평가를 직접 최적화하는 새로운 VI 목적 함수를 제안한다.

## 핵심 이론

### Bayesian Excess Risk (BER)

기존 excess risk는 test data가 실제 분포 $\nu(Y|x)$에서 생성된다고 가정하지만, BER은 새로운 joint distribution을 도입:

$$p^\theta(\theta, \mathbf{Z}^N, Z) := \nu(Z^N) q(\theta|Z^N) \nu(X) p(Y|X, \theta)$$

즉, test data가 posterior predictive distribution에서 생성된다고 가정한다.

### Theorem 1: EU = BER

- **Log loss**: $\text{BER}^{\log}(Y|x, \mathbf{z}^N) = I_q(\theta, Y|x, \mathbf{z}^N)$
- **Squared loss**: $\text{BER}^{(2)}(Y|x, \mathbf{z}^N) = \text{Var}_{\theta|\mathbf{z}^N}[m_\theta(x)]$

즉, 실무에서 사용되는 EU 지표들은 "모델이 옳다고 가정할 때의 excess risk"로 해석된다.

### Theorem 2 & 3: Convergence

- **Squared loss (well-specified)**: $\text{PER} + \text{BER} = \text{ER} = \mathcal{O}(\sqrt{\log N / N})$
- **Log loss (general)**: $\text{BER}^{\log} \leq 2\sqrt{\sigma^2 (\text{KL misspecification} + \text{ER})}$

즉, BER은 exact excess risk의 **lower bound (optimistic 평가)**이며 동일한 수렴 속도를 가진다.

## 실용적 기여

### $\alpha$-Divergence VI 분석

$\alpha$-divergence VI는 KL divergence VI보다 BER에 대한 regularization이 약하다 → EU 추정치가 더 크게 나오는 이유에 대한 이론적 설명.

### PAC-Bayesian VI (제안 방법)

EU metrics를 직접 최적화하는 새로운 VI 목적 함수:

$$\min_q \text{BER}(q) + \frac{\text{KL}(q|p)}{\lambda}$$

실험 결과, 기존 VI 대비 EU 추정이 유의미하게 개선됨.

## AI/ML × Mechanics 관점

이 이론은 [[uncertainty-quantification-deep-learning|불확실성 정량화(UQ)]]의 수학적 기초를 제공한다. 특히 물리 시스템의 ML 예측에서 EU의 신뢰할 수 있는 추정은 [[kennedy-ohagan-calibration|모델 캘리브레이션]], [[digital-twin|디지털 트윈]]의 신뢰도 평가, [[surrogate-model]]의 적용 가능 영역 판단 등에 필수적이다.

## 관련 개념

- [[uncertainty-quantification-deep-learning]] — DL에서의 UQ 리뷰
- [[bayesian-uncertainty-vision]] — Aleatoric & Epistemic Uncertainty (Kendall & Gal 2017)
- [[deep-ensembles]] — Deep Ensembles for Uncertainty
- [[kennedy-ohagan-calibration]] — KOH Bayesian Calibration
- [[variational-autoencoder]] — VAE (VI + DL의 또 다른 예)

## 참고

- 본 논문은 VI에서 EU metrics에 대한 **최초의 체계적 수렴 분석**을 제공
- Theorem 2/3의 결과는 EU metrics가 excess risk의 optimistic lower bound임을 의미 — 실제로 EU가 과소평가되는 현상과 일치
- PAC-Bayesian VI는 [[vvuq-framework|VV&UQ Framework]]에서 불확실성 전파를 위한 이론적 기반으로 활용될 수 있음
