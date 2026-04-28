---
title: Neural Variational Inference (NVIL)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, training, inference, paper]
sources: [raw/papers/1402.0030v2.md]
confidence: high
---

# Neural Variational Inference and Learning (NVIL)

## 개요

**Neural Variational Inference and Learning (NVIL)**은 Andriy Mnih와 Karol Gregor가 2014년 Google DeepMind에서 제안한 방법으로, **이산(discrete)** 및 **연속(continuous)** 잠재 변수를 가진 방향성 그래프 모델(directed graphical models)을 학습하기 위한 변분 추론 알고리즘이다^[raw/papers/1402.0030v2.md].

VAE와 달리 **REINFORCE 알고리즘**에 기반하여, 이산 잠재 변수를 포함한 더 넓은 범위의 모델에 적용 가능하다.

## 핵심 아이디어

### Inference Network (추론 네트워크)
- 피드포워드 신경망을 사용하여 입력 $x$에서 변분 사후분포 $Q_\phi(h|x)$로 매핑
- **로컬 변분 파라미터 불필요** — 모든 관측치에 대해 단일 추론 네트워크 공유
- MCMC와 달리 **단일 포워드 패스**로 독립 샘플 생성 → 빠른 추론

### 그래디언트 추정
모델 파라미터 $\theta$:
$$\nabla_\theta \mathcal{L}(x) \approx \frac{1}{n} \sum_i \nabla_\theta \log P_\theta(x, h^{(i)})$$

추론 네트워크 파라미터 $\phi$:
$$\nabla_\phi \mathcal{L}(x) \approx \frac{1}{n} \sum_i (\log P_\theta(x, h^{(i)}) - \log Q_\phi(h^{(i)}|x)) \nabla_\phi \log Q_\phi(h^{(i)}|x)$$

### 분산 감소 기법 (핵심 기여)
Naive gradient estimator는 분산이 너무 커서 실용적이지 않음 → 3가지 기법:

1. **Centering (Baseline):** 학습 신호에서 입력-의존적 baseline $C_\psi(x)$와 입력-독립적 baseline $c$ 차감. 강화학습의 baseline과 동일 개념
2. **Variance Normalization:** 표준편차 추정값으로 centered signal 정규화 (단, std > 1일 때만)
3. **Local Learning Signals:** 계층별(layer-specific) 학습 신호 사용 — 잡음 감소

## 특징 및 차별점

| 특성 | NVIL | VAE (SGVB) |
|------|------|-------------|
| **잠재 변수** | 이산 + 연속 | 연속 전용 |
| **그래디언트** | REINFORCE | Reparameterization |
| **분산** | 높음 (VR 필요) | 낮음 |
| **사후분포 구조** | 복잡한 의존성 가능 | 조건부 독립 가정 |
| **일반성** | 더 넓음 | 제한적 |

## Wake-Sleep 알고리즘과의 관계
- Wake-Sleep: 변분 목적함수를 최적화하지 않음 → 수렴 보장 없음
- NVIL: **ELBO를 직접 최적화** → Well-defined objective
- wake-sleep보다 MNIST에서 3.4~8.6 nats 개선

- [[variational-autoencoder]] — VAE (동시대 VI+DL)
- [[bayesian-uncertainty-vision]] — 불확실성 추정

## References
- A. Mnih, K. Gregor. "Neural Variational Inference and Learning in Belief Networks", *ICML 2014*
- [[variational-autoencoder]] — 연속 잠재변수에 대한 대안적 접근
- R. J. Williams. "Simple statistical gradient-following algorithms for connectionist reinforcement learning", 1992 (REINFORCE)