---
title: Variational Autoencoder (VAE)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, training, inference, paper]
sources: [raw/papers/1312.6114v11.md]
confidence: high
---

# Variational Autoencoder (VAE)

## 개요

**Variational Autoencoder (VAE)**는 [[diederik-kingma|Diederik Kingma]]와 Max Welling이 2013년 제안한 생성 모델로, 변분 추론(variational inference)과 딥러닝을 결합하여 복잡한 확률 분포를 학습한다^[raw/papers/1312.6114v11.md]. 연속 잠재 변수(continuous latent variables)를 가진 방향성 확률 모델(directed probabilistic models)에서 효율적인 추론과 학습을 가능하게 한다.

## 핵심 아이디어

### 재매개변수화 트릭 (Reparameterization Trick)
VAE의 가장 중요한 기여:

- 문제: 샘플링 과정이 미분 불가능 → 역전파 불가
- 해결: $z \sim q_\phi(z|x)$ 대신 $z = \mu_\phi(x) + \sigma_\phi(x) \cdot \epsilon$, $\epsilon \sim \mathcal{N}(0, I)$
- 결과: 확률적 노드를 미분 가능한 결정론적 노드로 변환 → 역전파 가능

### 변분 하한 (ELBO)
Evidence Lower Bound 최적화:
$$\mathcal{L}(\theta, \phi; x) = \mathbb{E}_{q_\phi(z|x)}[\log p_\theta(x|z)] - KL(q_\phi(z|x) \parallel p(z))$$

- 첫째 항: **재구성 손실(reconstruction loss)** — 디코더가 잠재 변수에서 데이터를 복원
- 둘째 항: **KL 발산** — 근사 사후분포와 사전분포 간 차이 조절 (정규화)

### 구조
- **인코더(Encoder) / 추론 네트워크:** $q_\phi(z|x)$ — 입력 $x$를 잠재 변수 $z$의 분포 파라미터($\mu, \sigma$)로 매핑
- **디코더(Decoder) / 생성 네트워크:** $p_\theta(x|z)$ — 잠재 변수 $z$에서 데이터 $x$를 생성
- **잠재 공간(Latent Space):** 저차원 연속 공간, 구조화된 표현 학습

## 특징 및 장점

- **생성 모델:** 단순한 오토인코더와 달리 확률적 생성 모델로, 새로운 데이터 샘플 생성 가능
- **연속 잠재 공간:** 의미 있는 구조화된 표현(disentangled representation) 학습 가능
- **스케일러블:** SGD로 최적화 가능, 대규모 데이터셋에 적용 가능
- **i.i.d. 가정:** 각 데이터 포인트마다 독립적인 잠재 변수

## 관련 연구

- [[neural-variational-inference]] — VAE와 동시대에 개발된 또 다른 VI + 딥러닝 접근법
  - VAE: **재매개변수화 트릭** (연속 변수 전용, low variance)
  - NVIL: **REINFORCE + variance reduction** (이산/연속 모두 가능, higher variance)
- [[universal-approximation-theorem]] — 인코더/디코더의 함수 근사 능력의 이론적 토대

## References
- Diederik P. Kingma, Max Welling. "Auto-Encoding Variational Bayes", *ICLR 2014* (arXiv:1312.6114)
- D. J. Rezende, S. Mohamed, D. Wierstra. "Stochastic Backpropagation and Variational Inference in Deep Latent Gaussian Models", 2014 (동시 발견)