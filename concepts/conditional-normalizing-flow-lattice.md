---
title: Conditional Normalizing Flow (C-NF) for Lattice Field Theory Sampling
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [model, neural-network, physics-informed, surrogate-model, paper, generative-model, mathematics]
sources: [raw/papers/2207.00980v1.md]
confidence: high
---

# Conditional Normalizing Flow (C-NF) for Lattice Field Theory Sampling

## 개요

Ankur Singha, Dipankar Chakrabarti, Vipul Arora (2022)이 제안한 **Conditional Normalizing Flow (C-NF)**는 격자 장론(lattice field theory)의 **임계 영역(critical region)**에서 **critical slowing down** 문제를 해결하기 위한 생성 모델이다^[raw/papers/2207.00980v1.md]. 비임계 영역에서 생성한 HMC 샘플로 조건부 정규화 흐름을 훈련하여, 임계 영역의 여러 $\lambda$ 값에서 격자 구성을 샘플링할 수 있다.

## Critical Slowing Down 문제

격자 장론에서 임계점(critical point) 근처의 Monte Carlo 시뮬레이션은 **integrated autocorrelation time**이 급격히 증가하여 비용이 폭발한다:

| 영역 | 자기상관 시간 | HMC 비용 | 대안 |
|------|-------------|----------|------|
| **비임계 영역** ($\lambda < 4.1$ 또는 $\lambda > 5.0$) | 낮음 | 효율적 | HMC 충분 |
| **임계 영역** ($4.1 \leq \lambda \leq 5.0$) | 발산 | 비효율적 | C-NF 필요 |

## 정규화 흐름(Normalizing Flow) 기초

변환 $f_\theta: \mathbb{R}^d \to \mathbb{R}^d$로 단순 prior $p_c(z)$를 복잡한 목표 분포로 변환:

$$p_m(x; \theta) = p_c(z) \left|\det \frac{\partial f_\theta(z)}{\partial x}\right|^{-1}, \quad x = f_\theta(z)$$

### Affine Coupling Block

입력을 두 half로 분할하여 affine transformation 적용:

$$\begin{aligned} x_1 &= z_1 \odot \exp(s_1(z_2)) + t_1(z_2) \\ x_2 &= z_2 \odot \exp(s_2(x_1)) + t_2(x_1) \end{aligned}$$

$s$와 $t$는 임의의 비선함수(신경망) — 역변환 시 역함수 불필요.

## 조건부 Normalizing Flow (C-NF)

### Conditioning 메커니즘

조건 파라미터 $c$ (여기서는 $\lambda$)를 coupling layer의 $s$, $t$ 신경망에 concatenation:

$$\begin{aligned} x_1 &= z_1 \odot \exp(s_1(z_2, c)) + t_1(z_2, c) \\ x_2 &= z_2 \odot \exp(s_2(x_1, c)) + t_2(x_1, c) \end{aligned}$$

```
          ┌──────────┐
 z ──────→│  Split    │──→ z₁, z₂
          └──────────┘
               ↓            ↓
 c ──→ [Concat(z₂, c)]   [Concat(x₁, c)]
               ↓            ↓
         [s₁, t₁ NN]   [s₂, t₂ NN]
               ↓            ↓
          x₁ = z₁⊙e^s₁+t₁  x₂ = z₂⊙e^s₂+t₂
               ↓            ↓
          ┌──────────┐
          │  Merge   │──→ x
          └──────────┘
```

### 손실 함수 (Forward KL)

$$\mathcal{L}(\theta) = D_{\text{KL}}[p_t(\phi; \lambda) \| p_m(\phi; \lambda, \theta)] = -\mathbb{E}_{\phi \sim p_t}[\log p_m(\phi; \lambda, \theta)] + \text{const}$$

### C-NF 아키텍처 상세

| 구성 요소 | 사양 |
|----------|------|
| **Affine block 수** | 8개 |
| **$s$, $t$ 네트워크** | FC layer (Conv2D 3×3, Tanh 활성화) |
| **필터 수** | 64 (보간) / 32 (외삽) |
| **Padding** | periodic (격자 경계 조건) |
| **조건 입력** | $\lambda$를 각 coupling layer에 concatenation |
| **격자 크기** | 8×8 |
| **훈련 데이터** | 10,000 configurations/$\lambda$ (보간), 15,000 (외삽) |
| **Optimizer** | Adam, lr = 0.0003 |

## 훈련 및 샘플링 전략

### 3단계 파이프라인

1. **비임계 영역에서 HMC로 훈련 데이터 생성** — 낮은 자기상관으로 효율적
2. **Forward KL로 C-NF 훈련** — $\lambda \in \{3, 3.2, ..., 3.8, 5.8, ..., 9\}$ (임계 영역 4.1~5.0 제외)
3. **보간/외삽 + Independent Metropolis-Hastings** — 정확한 분포 수렴 보장

### 보간(Interpolation) vs 외삽(Extrapolation)

| 전략 | 훈련 $\lambda$ 범위 | 목표 $\lambda$ | 데이터 크기 |
|------|---------------------|---------------|------------|
| **보간** | $\{3,...,3.8\} \cup \{5.8,...,9\}$ | $4.1 \leq \lambda \leq 5.0$ | 10K/$\lambda$ |
| **외삽** | $\{3, 3.1, ..., 3.9\}$ | $4.2 \leq \lambda \leq 4.6$ | 15K/$\lambda$ |

### Independent Metropolis-Hastings

C-NF 직접 샘플은 bias 존재 가능. MH 알고리즘으로 정확한 분포 수렴:

- C-NF을 proposal 분포로 사용
- acceptance rate: 25~40%
- 자기상관이 무시 가능한 수준 (HMC 대비 극적으로 감소)

## HMC와의 비교

| 측면 | HMC | C-NF + MH |
|------|-----|-----------|
| **임계 영역 비용** | $\tau_{\text{int}}$ 발산 | $\tau_{\text{int}} \approx 1$ |
| **여러 $\lambda$** | 각각 별도 시뮬레이션 | 하나의 모델로 모든 $\lambda$ |
| **정확성** | 정확 (baseline) | MH 보정 후 정확 |
| **초기 비용** | 없음 | 비임계 영역 훈련 필요 |
| **병렬화** | trajectory 내 제한 | 직접 샘플링 완전 병렬 |

## 실험 결과 (1+1D scalar $\phi^4$ 이론)

- $m^2 = -4$ 고정, $\lambda$ 변이로 2차 상전이 관찰
- 관측값 $\langle \phi^2 \rangle$, susceptibility $\chi$, correlation function $C(t)$에서 HMC와 일치
- Naive C-NF (MH 없음): bias 존재 → MH로 제거
- **하나의 모델로 여러 임계 $\lambda$ 값**에서 샘플링 가능

## 관련 개념

- [[mode-collapse-flow-lattice]] — Flow 기반 샘플링의 mode-collapse 문제
- [[variational-autoregressive-networks]] — Autoregressive 접근법
- [[hierarchical-autoregressive-networks]] — 다른 lattice 샘플링 접근법
- [[score-based-generative-modeling-sde]] — SDE 기반 생성 모델
