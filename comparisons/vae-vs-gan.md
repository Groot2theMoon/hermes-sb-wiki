---
title: VAE vs GAN — Generative Model 비교
created: 2026-04-28
updated: 2026-04-28
type: comparison
tags: [comparison, neural-network, model, inference]
sources: [raw/papers/1312.6114v11.md]
---

# VAE vs GAN — 생성 모델 패러다임 비교

**VAE (Variational Autoencoder)**와 **GAN (Generative Adversarial Network)**은 딥러닝 기반 생성 모델의 두 대표적 접근법이다. VAE는 변분 추론(variational inference)을, GAN은 적대적 학습(adversarial training)을 기반으로 한다.

## 비교 표

| 차원 | VAE | GAN |
|------|-----|-----|
| **제안** | Kingma & Welling (2013) | Goodfellow et al. (2014) |
| **학습 메커니즘** | ELBO 최적화 (재구성 + KL divergence) | Generator vs Discriminator 적대적 학습 |
| **잠재 공간** | 연속적, 구조화됨 (인코더 학습) | 암시적 (명시적 인코더 없음) |
| **생성 품질** | 흐릿함(blurry), 덜 선명함(less sharp) | 선명하고 현실적인 이미지 |
| **생성 다양성** | 높음 (mode coverage 우수) | **Mode collapse** 위험 |
| **학습 안정성** | 안정적 (ELBO는 단일 손실) | 불안정 (minimax game, equilibrium 찾기 어려움) |
| **수학적 기반** | 변분 추론 (명시적 하한) | 게임 이론 (Nash equilibrium) |
| **추론 (inference)** | 인코더로 $z$ 추론 가능 (encoder $q_\phi(z\|x)$) | $z$ 추론 불가 (inverse mapping 필요) |
| **재구성** | 입력 $\to$ 잠재 $\to$ 입력 재구성 가능 | 재구성 없음 (순수 생성) |
| **밀도 추정** | 대략적 하한 제공 | 없음 (암시적 분포만 학습) |
| **응용 분야** | 반감독 학습, 이상 탐지, 분자 설계 | 이미지 생성, 스타일 변환, super-resolution |

## 핵심 차이: 확률적 프레임워크 vs 적대적 학습

### VAE 접근
- **확률적 생성 모델** 명시적 정의
- ELBO 최적화: 재구성 정확도와 잠재 공간 정규화 사이의 trade-off
- **재매개변수화 트릭** (Reparameterization Trick) — 확률적 노드를 미분 가능하게 변환
- 장점: 의미론적으로 구조화된 잠재 공간 (보간, 속성 조작)
- 단점: Negative log-likelihood + KL divergence가 blurry 샘플 생성 (L2 loss의 한계)

### GAN 접근
- **암시적 생성 모델** — 밀도 함수를 명시적으로 정의하지 않음
- Discriminator가 "진짜 vs 가짜"를 판별하도록 학습
- Generator는 discriminator를 속이도록 학습 (적대적 관계)
- 장점: 매우 현실적인 샘플 생성 가능 (adversarial loss가 perceptual quality 보상)
- 단점: **Mode collapse** (특정 모드만 생성), 학습 불안정성 (G vs D 균형 유지 어려움)

## VAE와 GAN 사이의 스펙트럼

현대 생성 모델은 VAE와 GAN의 장점을 결합:

| 모델 | 아이디어 |
|------|---------|
| **VAE-GAN** (2016) | VAE 인코더 + GAN discriminator 결합 |
| **ALI / BiGAN** (2016) | 쌍방향 매핑으로 GAN에 인코더 추가 |
| **VQ-VAE** (2017) | 이산 잠재 변수 + autoregressive prior |
| **StyleGAN** (2019) | GAN 기반 + 구조화된 잠재 공간 |
| **Diffusion** (2020-) | VAE의 ELBO + GAN 수준의 품질 (SOTA) |

## 언제 무엇을 쓸까?

| Task | 권장 | 이유 |
|------|------|------|
| **이상 탐지 (Anomaly Detection)** | VAE | 재구성 오차로 이상치 식별 |
| **이미지 생성 (고품질)** | GAN / Diffusion | 더 선명하고 현실적인 이미지 |
| **반감독 학습** | VAE | 라벨 없이도 표현 학습 |
| **잠재 공간 해석** | VAE | 의미론적으로 구조화된 $z$ |
| **스타일 변환 (Pix2Pix)** | cGAN | 조건부 생성에 적합 |
| **분자 설계 / 약물 발견** | VAE | 연속적인 구조화된 잠재 공간 필요 |

## 관련 페이지

- [[variational-autoencoder]] — VAE 상세
- [[neural-variational-inference]] — 변분 추론의 신경망 확장
- [[gan-lattice-simulations]] — GAN의 물리학 응용 (lattice QCD)
- [[diffusion-lattice]] — Diffusion 모델 (현대 SOTA 생성 모델)