---
title: Neural Tangent Kernel (NTK)
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [model, training, mathematics, paper, pinn, optimization, theory]
sources: [raw/papers/1806.07572v4.md]
confidence: high
---

# Neural Tangent Kernel (NTK)

## 개요

**Neural Tangent Kernel (NTK)** 은 Arthur Jacot, Franck Gabriel, Clément Hongler (EPFL, 2018)가 제안한 이론적 틀로, **무한 너비(infinite-width) 극한**에서 신경망의 경사 하강법(gradient descent) 학습 동역학이 **kernel regression**과 정확히 일치함을 증명한다. NTK는 복잡한 비선형 신경망의 학습 과정을 이해하는 강력한 분석 도구로, PINN의 학습 실패 원인 분석, spectral bias 이론, 일반화 이론 등에 광범위하게 응용된다.

## NTK의 수학적 정의

### 유한 너비에서의 정의

$f_\theta(x)$를 파라미터 $\theta \in \mathbb{R}^P$를 가진 신경망이라 하자. NTK는 파라미터에 대한 함수 출력의 그래디언트 내적으로 정의된다:

$$\Theta(x, x') = \nabla_\theta f_\theta(x)^\top \nabla_\theta f_\theta(x') = \sum_{p=1}^P \frac{\partial f_\theta(x)}{\partial \theta_p} \frac{\partial f_\theta(x')}{\partial \theta_p}$$

### 무한 너비 극한

신경망의 각 레이어 너비를 $n \to \infty$로 보내면, 적절한 초기화 하에서 NTK는 **결정론적(deterministic) 커널로 수렴**한다:

$$\Theta(x, x') \xrightarrow{n \to \infty} \Theta_\infty(x, x')$$

이 극한에서 NTK는 **학습 과정 내내 일정(constant)** 하다. 이는 신경망 학습이 kernel regression과 완전히 동등해짐을 의미한다:

$$f_t(x) \approx f_0(x) + \sum_{i} \Theta_\infty(x, x_i) \cdot \alpha_i(t)$$

## NTK와 Gaussian Process의 관계

### NNGP (Neural Network Gaussian Process)

- **초기화 시점($t=0$)**: 무한 너비 신경망의 함수 값 분포는 Gaussian Process (NNGP)와 동등
- 공분산 함수: $\mathbb{E}[f_\theta(x) f_\theta(x')] \to \mathcal{K}(x, x')$

### NTK = 학습 동역학의 커널

NNGP가 초기화 분포라면, NTK는 **학습 중 변화의 방향**을 결정하는 커널이다.

$$f_t(x) - f_0(x) \approx -\sum_i \int_0^t \Theta(x, x_i) \cdot (f_\tau(x_i) - y_i) \, d\tau$$

신경망이 GD로 학습될 때, 함수 공간에서의 변화는 항상 NTK가 정의하는 reproducing kernel Hilbert space (RKHS) 안에서 일어난다.

## 무한 너비 한계에서의 학습 동역학

### Gradient Flow 형태

연속 시간(learning rate $\to$ 0)에서 학습은 gradient flow로 기술된다:

$$\partial_t f_t(x) = -\sum_{i} \Theta(x, x_i) \cdot \nabla_f \mathcal{L}(f_t(x_i), y_i)$$

MSE 손실 $\mathcal{L} = \frac{1}{2} \sum_i (f_t(x_i) - y_i)^2$ 에서:

$$\partial_t f_t(x) = -\sum_i \Theta(x, x_i) \cdot (f_t(x_i) - y_i)$$

### 고유값 분해와 수렴 속도

NTK를 고유값 분해하면:

$$\Theta(x, x') = \sum_{k=1}^\infty \lambda_k \phi_k(x) \phi_k(x')$$

- 각 고유모드 $\phi_k$의 학습 속도가 고유값 $\lambda_k$에 **비례**
- $\lambda_k$가 큰 성분은 빠르게, 작은 성분은 느리게 수렴 → **spectral bias**

## Spectral Bias (주파수 편향)

NTK 이론은 신경망이 **저주파(low-frequency) 함수를 고주파(high-frequency) 함수보다 먼저 학습**한다는 경험적 관찰을 수학적으로 설명한다:

- NTK의 고유값 $\lambda_k$는 주파수 $k$가 증가할수록 **급격히 감소**
- 따라서 고주파 모드는 학습 속도가 지수적으로 느려짐
- 이는 PINN에서 multi-scale PDE (난류, 충격파 등)를 학습할 때 결정적 장애로 작용

**완화 전략**:
- Fourier feature embedding → 고주파 모드의 고유값 증폭
- Multi-scale NTK → 주파수 대역별 학습률 조정
- Curriculum learning → 낮은 주파수부터 높은 주파수 순서로 학습

## Finite-Width NTK (유한 너비)

현실의 모든 신경망은 유한 너비를 가진다. 유한 너비에서 NTK는:

1. **초기화 시점**: 무한 너비 NTK의 noisy Monte Carlo 추정값
2. **학습 진행 중**: NTK가 학습에 따라 **진화(evolve)** 함
3. **특징 학습(feature learning)**: NTK 변화 = 신경망이 데이터에 적응적으로 표현을 학습하고 있다는 신호

$$\Theta_t(x, x') = \Theta_0(x, x') + \underbrace{\Delta\Theta_t(x, x')}_{\text{finite-width correction}}$$

$\Delta\Theta_t$ 항이 feature learning의 척도이며, neural scaling law의 기원으로 연결된다.

## PINN 학습 실패와 NTK

### "When and Why PINNs Fail to Train" (Wang et al., 2020)

NTK 관점에서 PINN 학습 실패는 **PDE residual loss의 NTK 고유값 불균형**으로 설명된다 ([[pinn-failure-modes]]):

#### 주요 발견

1. **Loss term 간 불균형**: $\mathcal{L}_{\text{physics}}$와 $\mathcal{L}_{\text{boundary}}$의 NTK 고유값 스펙트럼이 크게 다름
2. **Spectral bias**: PINN은 PDE의 저주파 해 성분을 빠르게 학습하나, 고주파 성분(경계층, 진동 등)을 극도로 느리게 학습
3. **Stiffness**: PDE residual의 NTK가 ill-conditioned — 고유값 비율이 $10^4$ 이상 → 수치적 불안정성

#### 해결책 (Learning Rate Annealing)

Wang et al.은 NTK 고유값 기반 **adaptive learning rate**을 제안:

$$\lambda_k^{\text{adaptive}} = \lambda_0 \cdot \frac{\max_k \sigma_k}{\sigma_k}$$

여기서 $\sigma_k$는 각 loss term의 NTK 고유값이다.

### Nonlinear Regime (Krishnapriyan et al., 2022)

강한 비선형 PDE에서는:
- **NTK가 상수가 아님** — 학습 중 지속적으로 변화
- **Hessian이 무시 불가** — 2차 최적화(Newton, L-BFGS)가 효과적
- NTK의 random matrix 이론 적용의 한계

## 주요 결과 요약

| 결과 | 내용 | 논문 |
|:---|:---|:---|
| NTK 정의 및 수렴 | Infinite-width NTK는 결정론적 커널로 수렴 | Jacot et al. (2018) |
| NNGP와 NTK | 초기화=NNGP, 학습=NTK의 이중 서술 | Lee et al. (2019) |
| Spectral Bias | NTK 고유값이 주파수별 학습 속도 결정 | Cao et al. (2019) |
| PINN 실패 분석 | NTK 고유값 불균형이 PINN 학습 실패의 원인 | Wang et al. (2020) |
| Nonlinear PINN | 비선형 PDE에서 NTK 비상수성과 Hessian의 역할 | Krishnapriyan et al. (2022) |
| Feature Learning | Finite-width NTK 변화 = representation 학습의 증거 | Yang & Hu (2021) |
| $\mu$P (Maximal Update) | NTK 이론에 기반한 최적 하이퍼파라미터 스케일링 | Yang et al. (2021) |

## NTK의 공학적 응용

1. **신경망 아키텍처 설계**: NTK 분석을 통해 특정 PDE에 최적화된 아키텍처 선택
2. **하이퍼파라미터 튜닝**: $\mu$P 패러다임으로 모델 크기에 독립적인 최적 learning rate 결정
3. **Loss balancing**: PINN의 다중 손실 항 간 자동 가중치 조절
4. **Early stopping**: NTK의 고유값 감소 패턴을 통한 최적 학습 종료 시점 결정
5. **Spectral bias 완화**: Fourier feature, random Fourier feature, multi-scale network 설계

## NTK와 기계공학의 접점

- **구조 동역학**: 고유진동수 해석에서 PINN의 multi-frequency 학습 실패 분석
- **유체역학**: 난류의 multi-scale 특성과 PINN spectral bias 간 충돌 이해
- **열전달**: 급격한 온도 구배(thermal boundary layer)의 고주파 특성 학습 지연
- **Surrogate model**: NTK로 surrogate model의 수렴 속도와 일반화 성능 사전 예측

## 관련 개념

- [[pinn-failure-modes]] — NTK로 PINN 실패 분석 (직접 응용)
- [[universal-approximation-theorem]] — 무한 너비 신경망의 표현력 이론
- [[physics-informed]] — PINN의 포괄적 개요
- [[deep-ensembles]] — 앙상블 방법의 NTK 관점 분석
- [[kernel-methods]] — 커널 방법의 기초 이론
- [[function-space-variational-inference-bnn]] — 함수 공간 추론과 NTK의 연결
- [[ensemble-loss-landscape]] — Loss landscape와 NTK의 관계
- [[spectral-margin-generalization-bounds]] — Spectral 방법을 통한 일반화 경계
