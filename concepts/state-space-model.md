---
title: State-Space Model (SSM) — State-Space Representation of Dynamical Systems
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, sequence-modeling, state-space-model, kalman-filter, control-theory]
sources: []
confidence: medium
---

# State-Space Model (SSM)

## 개요

**State-Space Model (SSM)**은 동적 시스템을 **잠재 상태(latent state)**와 **관측(observation)**의 두 가지 확률 과정으로 표현하는 프레임워크. 선형 동적 시스템(LDS)부터 비선형, 심층 신경망 기반 SSM까지 다양한 변형이 존재한다.

## 수학적 구조

### 이산 시간 SSM

$$
\begin{aligned}
\mathbf{z}_t &= f(\mathbf{z}_{t-1}, \mathbf{u}_t) + \epsilon_t \quad &\text{(transition / state evolution)} \\
\mathbf{x}_t &= g(\mathbf{z}_t, \mathbf{u}_t) + \delta_t \quad &\text{(emission / observation)}
\end{aligned}
$$

- $\mathbf{z}_t$: 잠재 상태 (hidden state)
- $\mathbf{x}_t$: 관측 (observation)
- $\mathbf{u}_t$: 제어 입력 (control input)
- $\epsilon_t, \delta_t$: process / observation noise

### 선형 가우시안 SSM (Classic Kalman Filter)

$$
\mathbf{z}_t = \mathbf{A}\mathbf{z}_{t-1} + \mathbf{B}\mathbf{u}_t + \epsilon_t, \quad \mathbf{x}_t = \mathbf{C}\mathbf{z}_t + \mathbf{D}\mathbf{u}_t + \delta_t
$$

- $\mathbf{A}$: transition matrix
- $\mathbf{C}$: emission matrix
- $\epsilon_t \sim \mathcal{N}(0, \mathbf{Q})$, $\delta_t \sim \mathcal{N}(0, \mathbf{R})$

## SSM의 분류

| 유형 | Transition | Emission | 추론 방식 | 예 |
|------|-----------|----------|-----------|-----|
| **Linear Gaussian SSM** | 선형 | 선형 | Kalman filter (closed-form) | 고전적 tracking |
| **Nonlinear SSM** | 비선형 | 비선형 | EKF, UKF, Particle filter | SLAM, GPS |
| **Deep SSM** | DNN | DNN | Variational inference (ELBO) | DKF, VRNN |
| **Structured SSM (S4)** | 선형 + 구조화 | 선형 | Convolutional (FFT) | Mamba, S4 |

## SSM의 핵�

1. **Markov property:** $\mathbf{z}_t$는 $\mathbf{z}_{t-1}$에만 의존 (1차 Markov)
2. **Conditional independence:** $\mathbf{x}_t$는 $\mathbf{z}_t$에만 의존
3. **Recursive estimation:** Filtering은 예측(predict) → 갱신(update)의 반복

## 관련 페이지

- [[deep-kalman-filter]] — Variational inference 기반 Deep SSM
- [[square-root-unscented-kalman-filter]] — 고전적 nonlinear state estimation
- [[gru-d]] — RNN 기반 시계열 missing value 모델링
- [[rnn-enhanced-ukf]] — RNN 예측을 UKF에 통합한 hybrid state estimation
- [[variational-autoencoder]] — VAE의 latent variable 모델과 SSM의 연결
- [[free-energy-principle]] — Friston FEP의 variational inference와 SSM의 동형성
