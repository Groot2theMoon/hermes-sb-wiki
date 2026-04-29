---
title: Deep Kalman Filter (DKF) — Variational Inference for Temporal Generative Models
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, sequence-modeling, state-space-model, kalman-filter, variational-inference, latent-dynamics]
sources: [raw/papers/deep-kalman-filters.md]
confidence: high
---

# Deep Kalman Filter (DKF)

Krishnan, Shalit, Sontag (2015)가 제안한, **VAE의 variational inference + Kalman filter의 temporal structure**를 결합한 프레임워크. 고전적 Kalman filter의 transition/emission을 deep neural network로 대체하고, variational inference로 학습 가능한 일반 알고리즘을 제공한다.

## 동기

고전적 Kalman filter (Linear Gaussian SSM)은 강력하지만 **linear transition + linear emission**이라는 한계가 있다. Extended KF / Unscented KF는 non-linear를 다루지만 학습이 어렵고, long-range temporal interaction을 포착하기 어렵다.

**핵심 아이디어:** VAE의 **amortized variational inference** (inference network)를 Kalman filter 학습에 적용 → 복잡한 non-linear dynamics를 **ELBO 최적화로 단일 알고리즘**으로 학습 가능.

^[raw/papers/deep-kalman-filters.md]

## 모델 구조

### Generative Model (Decoder)

```
z_0 ~ N(0, I)
z_t = f_trans(z_{t-1}, u_t) + ε_t    (transition: neural network)
x_t = f_emiss(z_t) + δ_t              (emission: neural network)
```

- `u_t`: action / control input
- `z_t`: latent state
- `x_t`: observation
- `f_trans`, `f_emiss`: deep neural networks

### Inference Model (Encoder) — 3 Variants

DKF의 핵심 기여는 **다양한 recognition distribution** 제안:

| Variant | 구조 | 특성 |
|---------|------|------|
| **DKF (full)** | Bidirectional RNN → 전체 시퀀스 z_1:T 추론 | 가장 정확, offline |
| **DKF (smoother)** | Forward RNN (filtering) → Backward RNN (smoothing) | Real-time filtering 가능 |
| **DKF (filter)** | Forward RNN만 → causal inference | Online/real-time |

^[raw/papers/deep-kalman-filters.md]

## 학습: ELBO 최적화

VAE와 동일한 변분 하한 (ELBO):

```
L = Σ_t [ E_{z_t ~ q} [log p(x_t | z_t)]  -  KL(q(z_t | x_≤t, u_≤t) || p(z_t | z_{t-1}, u_t)) ]
     └── reconstruction ┘    └── temporal KL regularization ┘
```

- **Reconstruction term:** 얼마나 잘 복원하는지
- **Temporal KL:** latent transition prior와 inference network의 차이 → **FEP의 complexity term**과 동일

## 적용

### 1. Healing MNIST
- MNIST 숫자에 회전, 노이즈, perturbation을 가한 시계열 데이터
- DKF가 action의 **short-term + long-term effect**를 모두 포착

### 2. EHR Counterfactual Inference (8,000 환자)
- 당뇨 환자의 진료 기록을 바탕으로 **anti-diabetic medication의 효과** 추정
- **"이 환자가 약을 먹지 않았다면?"** 이라는 counterfactual 질문에 답변
- 단순 prediction과 달리, **인과적 추론(causal inference)** 이 핵심

## FEP / VAE와의 연결

수학적 동형성:

| 프레임워크 | ELBO / Free Energy | 구조 |
|-----------|-------------------|------|
| **VAE** | -KL(q(z|x) || p(z)) + E[log p(x|z)] | 정적 이미지 |
| **DKF** | -Σ KL(q(z_t) || p(z_t|z_{t-1})) + Σ E[log p(x_t|z_t)] | 시계열 (temporal) |
| **FEP** | -KL(q(θ) || p(θ)) + E[log p(y|θ)] | 지각 + 행동 |

DKF는 **VAE의 temporal 확장**이면서, **Friston FEP의 hierarchical dynamic model의 single-level 구현**으로 볼 수 있다.

## 관련 페이지

- [[square-root-unscented-kalman-filter]] — 고전적 Kalman filter 변형 (SR-UKF)
- [[variational-autoencoder]] — VAE와 ELBO의 기초
- [[free-energy-principle]] — Friston FEP과의 수학적 동형성
- [[state-space-model]] — SSM 일반 이론
- [[kyunghyun-cho]] — 공동 저자 (Gru, Bahdanau Attention)

## References

- Krishnan, R. G., Shalit, U., & Sontag, D. (2015). Deep Kalman Filters. *arXiv:1511.05121*.
