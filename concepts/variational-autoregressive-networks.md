---
title: Variational Autoregressive Networks for Statistical Mechanics
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [model, paper, physics-informed, mathematics, generative-model, neural-network]
sources: [raw/papers/1809.10606v2.md]
confidence: high
---

# Variational Autoregressive Networks for Statistical Mechanics

## 개요

Wu, Wang, Zhang (2018)이 제안한 방법으로, **변분 자동회귀 네트워크(Variational Autoregressive Network, VAN)**를 사용해 통계역학의 어려운 문제(유한계 자유 에너지 계산, #P-hard)를 해결한다^[raw/papers/1809.10606v2.md]. 기존 변분 평균장(variational mean-field) 방법을 deep autoregressive neural network로 확장한 일반적 프레임워크이다.

## 수학적 배경

### Boltzmann 분포와 자유 에너지

통계물리 모델에서 스핀 구성 $\mathbf{s} \in \{\pm 1\}^N$의 결합 확률분포:

$$p(\mathbf{s}) = \frac{e^{-\beta E(\mathbf{s})}}{Z}$$

진짜 자유 에너지 $F = -\frac{1}{\beta}\ln Z$를 계산하는 것은 **#P-hard** 문제이다.

### 변분 자유 에너지

변분 ansatz $q_\theta(\mathbf{s})$를 도입하면, KL 발산:

$$D_{\text{KL}}(q_\theta \| p) = \beta(F_q - F) \geq 0$$

따라서 변분 자유 에너지 $F_q$는 진짜 자유 에너지의 **상한(upper bound)**:

$$F_q = \frac{1}{\beta}\sum_{\mathbf{s}} q_\theta(\mathbf{s})[\beta E(\mathbf{s}) + \ln q_\theta(\mathbf{s})] = \mathbb{E}_q[E] - T \cdot H[q]$$

## 자동회귀 네트워크 구조

### 핵심 인수분해

$$q_\theta(\mathbf{s}) = \prod_{i=1}^N q_\theta(s_i | s_1, \dots, s_{i-1})$$

각 조건부 확률 $q_\theta(s_i | s_{<i})$를 신경망 출력 $\hat{s}_i = \sigma(\sum_{j<i} W_{ij} s_j)$으로 매개변수화.

### 아키텍처 변형

| 아키텍처 | 구조 | 특성 | 적용 |
|----------|------|------|------|
| **Fully visible sigmoid belief net** | 1-layer, triangular $W$ | 가장 간단, $N(N-1)/2$ 파라미터 | SK 모델, Hopfield |
| **Hidden layer network** | 은닉층 추가 | 더 expressive | 중간 크기 문제 |
| **Masked convolutional (PIXELCNN)** | 2D lattice masking | locality + translation symmetry | Ising 격자 |

### 직접 샘플링의 장점

1. **독립 샘플 생성**: autoregressive 순서로 각 변수를 순차 샘플링 → Markov chain 불필요
2. **정확한 확률 계산**: $q_\theta(\mathbf{s})$의 normalized 값을 직접 계산 가능
3. **GPU 병렬화**: Markov chain 없이 독립 샘플 → 이상적 병렬화

## 훈련: Policy Gradient

그라디언트:

$$\beta \nabla_\theta F_q = \mathbb{E}_{\mathbf{s} \sim q_\theta} \{[\beta E(\mathbf{s}) + \ln q_\theta(\mathbf{s})] \nabla_\theta \ln q_\theta(\mathbf{s})\}$$

- **강화학습 관점**: $q_\theta$는 policy, $[\beta E + \ln q_\theta]$는 reward signal
- **Control variates**로 분산 감소
- **Unbiased gradient estimate**: 직접 샘플링으로 autocorrelation 없는 정확한 추정

## 다른 lattice 방법과의 비교

| 방법 | 자유 에너지 | 독립 샘플 | 상한 보장 | 스케일링 |
|------|------------|----------|----------|----------|
| **NMF (naïve mean-field)** | 분석적 | N/A | ✅ | $O(N)$ |
| **Bethe approximation** | message passing | N/A | ❌ (RSB에서) | $O(N \cdot \text{degree})$ |
| **MCMC/HMC** | sampling 기반 | ❌ (correlated) | ❌ | $O(N \cdot \tau_{\text{int}})$ |
| **Tensor network** | variational | N/A | depends | lattice-specific |
| **VAN** | sampling 기반 | ✅ | ✅ | $O(N \cdot N_{\text{params}})$ |

## 실험 결과

### 2D Ising 모델 (ferromagnetic)
- $16 \times 16$ 격자에서 exact solution과 비교
- **Conv VAN**: NMF, Bethe 대비 압도적 정확도
- 최대 오차: critical point 근처 (장거리 상관관계)

### Antiferromagnetic triangular lattice
- frustration이 있는 시스템에서 정확한 entropy 포착
- 지수적으로 많은 축퇴(degenerate) 바닥 상태의 수를 올바르게 추정

### Hopfield 모델 ($N=100$, $P=2$)
- 저온에서 4개의 순수 상태를 모두 포착 (mode collapse 없음)
- 온도 annealing으로 retrieval phase의 다중 모드 학습

### Sherrington-Kirkpatrick (SK) 모델 ($N=20$)
- replica symmetry breaking phase에서 정확한 자유 에너지
- NMF, Bethe 대비 압도적 우위
- $N(N-1)/2$ 파라미터로 Belief Propagation의 $N(N-1)$ 파라미터보다 적음

### Inverse Ising 문제
- 주어진 상관관계에서 coupling $J_{ij}$를 재구성
- glassy phase ($\beta > 1$)에서 기존 mean-field 방법 대비 탁월

## 관련 개념

- [[unsupervised-phase-transitions]] — ML×Physics 상전이 탐지
- [[variational-autoencoder]] — VAE: 밀접한 생성 모델 구조
- [[conditional-normalizing-flow-lattice]] — Flow 기반 격자 샘플링
- [[hierarchical-autoregressive-networks]] — 다른 lattice 샘플링 접근법
