---
title: DeepONet — Deep Operator Networks
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [model, neural-network, surrogate-model, mathematics, physics-informed, paper, operator-learning]
sources: [raw/papers/2281727.md]
confidence: high
---

# DeepONet — Deep Operator Networks

## 개요

[[lu-lu|Lu Lu]], Pengzhan Jin, [[george-em-karniadakis|George Em Karniadakis]] ([[brown-university|Brown University]])이 제안한 **Deep Operator Networks (DeepONet)** 은 연산자(operator) 학습을 위한 딥러닝 아키텍처로, **함수 공간 간의 매핑(operator mapping)** 을 직접 근사한다. Chen & Chen (1995)의 **연산자 보편 근사 정리(universal approximation theorem for operators)**[^chen1995]를 실제 딥러닝으로 구현한 최초의 성공적 사례이며, PDE 파라미터가 변경되어도 **재학습 없이** 순간적으로 해를 예측할 수 있다는 점에서 전통적인 PINN과 근본적으로 차별화된다.

## Operator Learning의 수학적 정식화

### 연산자란?

함수 공간 $\mathcal{U}$에서 함수 공간 $\mathcal{V}$로의 매핑:

$$G: \mathcal{U} \to \mathcal{V}, \quad G(u) = v$$

예를 들어, PDE $\mathcal{N}[u(x); \lambda] = f(x)$에서:
- $G_1: \lambda \mapsto u$ (파라미터 → 해) 
- $G_2: f \mapsto u$ (소스항 → 해)
- $G_3: u|_{t=0} \mapsto u|_{t=T}$ (초기조건 → 미래 상태)

### Operator Regression Task

주어진 $N$개의 입출력 함수 쌍 $\{(u^{(i)}, v^{(i)})\}_{i=1}^N$에서 연산자 $G_\theta$를 학습:

$$v^{(i)}(y) = G_\theta(u^{(i)})(y), \quad y \in \Omega$$

핵심 도전 과제: $u^{(i)}$는 **함수 자체**(무한차원 객체)이며, $y$는 연속적인 **평가 지점**이다.

## Branch + Trunk 아키텍처

DeepONet은 이 문제를 **두 개의 서브네트워크**로 분해한다:

### Branch Net $b(\cdot)$

입력 함수 $u$를 $m$개의 센서 위치 $\{x_1, \dots, x_m\}$에서 샘플링하여 **고정 차원 벡터**로 인코딩:

$$\mathbf{b} = [b_1(\mathbf{u}), b_2(\mathbf{u}), \dots, b_p(\mathbf{u})] \in \mathbb{R}^p$$

여기서 $\mathbf{u} = [u(x_1), u(x_2), \dots, u(x_m)]$ 는 이산화된 입력 함수이다.

### Trunk Net $t(\cdot)$

출력 공간의 좌표 $y$를 동일한 $p$차원으로 인코딩:

$$\mathbf{t} = [t_1(y), t_2(y), \dots, t_p(y)] \in \mathbb{R}^p$$

### 연산자 근사 (Dot Product)

두 네트워크 출력의 내적(dot product)으로 연산자 출력 계산:

$$G_\theta(u)(y) \approx \sum_{k=1}^p \underbrace{b_k(u(x_1), \dots, u(x_m))}_{\text{branch: 입력 함수 의존}} \cdot \underbrace{t_k(y)}_{\text{trunk: 출력 위치 의존}}$$

### 왜 이 구조가 동작하는가?

Branch net은 *어떤 입력 함수인지* 파악하고, Trunk net은 *어느 위치에서 평가할지* 결정한다. 내적은 이 두 정보를 결합하여 특정 입력 함수의 특정 위치에서의 해를 출력한다.

## Universal Approximation Theorem for Operators

Chen & Chen (1995)의 정리는 DeepONet의 이론적 토대를 제공한다:

**정리 (Chen & Chen, 1995)** : 임의의 비선형 연속 연산자 $G: C(K_1) \to C(K_2)$ (compact $K_1, K_2$)에 대해, 적절한 $m, p$와 활성화 함수 $\sigma$를 가진 단일 은닉층 연산자 네트워크가 존재하여, 임의의 $\epsilon > 0$에 대해:

$$\sup_{u \in C(K_1)} \|G(u) - G_\theta(u)\|_{C(K_2)} < \epsilon$$

즉, **모든 연속 연산자를 임의의 정밀도로 근사 가능**하다. 이는 함수 근사에 대한 [[universal-approximation-theorem]]의 연산자 버전이다.

### Deep 구현의 이점

- 이론적으로는 단일 은닉층으로도 universal approximation 보장
- 실제 구현에서는 **deep architecture** 사용 → 최적화 용이, 일반화 성능 향상
- Branch net과 Trunk net 모두 DNN, CNN, ResNet 등 다양한 아키텍처 사용 가능

## DeepONet 학습

### 데이터 구성

학습 데이터는 연산자 입출력 쌍 $\{(u^{(i)}, v^{(i)})\}_{i=1}^N$:
- $u^{(i)}$: 다양한 입력 함수 (예: 다른 초기조건, 다른 PDE 파라미터, 다른 소스항)
- $v^{(i)} = G(u^{(i)})$: 각 입력 함수에 대응하는 해 (numerical solver로 생성)

### 손실 함수

MSE 손실:

$$\mathcal{L}(\theta) = \frac{1}{N} \sum_{i=1}^N \frac{1}{P} \sum_{j=1}^P \left[ G_\theta(u^{(i)})(y_j) - v^{(i)}(y_j) \right]^2$$

또는 상대 $L^2$ 오차:

$$\mathcal{L}(\theta) = \frac{1}{N} \sum_{i=1}^N \frac{\|G_\theta(u^{(i)}) - v^{(i)}\|_{L^2}}{\|v^{(i)}\|_{L^2}}$$

### Physics-Informed DeepONet (PI-DeepONet)

데이터가 충분하지 않을 때, PINN 방식으로 **PDE residual을 추가 손실 항**으로 부과:

$$\mathcal{L}_{\text{total}} = \mathcal{L}_{\text{data}} + \lambda \cdot \mathcal{L}_{\text{physics}}$$

여기서 $\mathcal{L}_{\text{physics}} = \frac{1}{N_r} \sum \|\mathcal{N}[G_\theta(u^{(i)})](y_r) - f(y_r)\|^2$ 이다.

## DeepONet vs FNO vs PINN

### 종합 비교표

| 특성 | PINN | DeepONet | FNO (Fourier Neural Operator) |
|:---|:---|:---|:---|
| **학습 대상** | 단일 PDE의 해 $u(x,t)$ | 연산자 $G: u \mapsto v$ | 연산자 $G: u \mapsto v$ |
| **출력** | 특정 파라미터의 해 | 임의 파라미터의 해 (추론 시) | 임의 파라미터의 해 (추론 시) |
| **아키텍처** | 단일 MLP | Branch + Trunk 네트워크 | Fourier 레이어 + MLP |
| **PDE 제약** | 핵심 (손실 항) | 선택적 (PI-DeepONet) | 선택적 (PINO) |
| **재학습** | 파라미터 변경 시 필요 | **불필요** (단일 forward pass) | **불필요** (단일 forward pass) |
| **Data 필요** | 적음 (unsupervised) | 중간 (함수 쌍 필요) | 중간 (함수 쌍 필요) |
| **훈련 비용** | 낮음 (1회) | 높음 (다양한 파라미터에 대해) | 높음 |
| **추론 비용** | 높음 (재학습) | **극도로 낮음** (forward pass) | **극도로 낮음** |
| **이론적 보장** | Universal approx. theorem (함수) | Operator universal approx. theorem | Fourier representation |
| **약점** | 고주파 불연속, spectral bias | 센서 위치 민감도 | 격자 의존성 |

### DeepONet vs FNO 상세

| 측면 | DeepONet | FNO |
|:---|:---|:---|
| **연산 방식** | Branch-Trunk 분리 + 내적 | Fourier space convolution |
| **이산화 독립성** | 센서 위치 독립적 (mesh-free) | 격자에 민감 (grid-dependent) |
| **복잡한 형상** | 우수 (point-wise 평가) | 제한적 (균일 격자 선호) |
| **고차원** | 우수 (차원 의존성 낮음) | 양호 |
| **Unseen sensor** | Interpolation 필요 | N/A |
| **물리 제약 통합** | PI-DeepONet | PINO |
| **학습 속도** | 일반적으로 더 느림 | FFT 가속으로 더 빠름 |

## DeepONet 변형 (Extensions)

| 변형 | 설명 |
|:---|:---|
| **PI-DeepONet** | PDE residual을 손실에 추가한 physics-informed 버전 |
| **Multi-Input DeepONet** | 여러 입력 함수를 동시에 처리 (다중 branch net) |
| **DeepONet-UQ** | Bayesian DeepONet — 연산자의 불확실성 정량화 |
| **Nested Fourier-DeepONet** | FNO의 Fourier layer와 DeepONet의 분리 구조 결합 |
| **RaNN-DeepONet** | Randomized NN으로 branch/trunk 은닉층 초기화, 최소제곱법으로 학습 |

## 응용 분야

### PDE Surrogate Modeling
- 파라미터가 변할 때마다 FEM/FVM solver를 실행하는 대신, 사전학습된 DeepONet이 **밀리초 단위**로 해 예측
- Design optimization, uncertainty quantification, real-time control에서 결정적 이점

### 역문제 (Inverse Problems)
- $G: \text{measurements} \mapsto \text{parameters}$ 연산자 학습
- 파라미터 추정을 forward pass로 수행

### 다중물리 (Multiphysics)
- Branch net이 다른 물리 현상의 파라미터를 입력받아 trunk net이 공통 공간에서 해 예측
- 유체-구조 연성(FSI), 열-기계 연성 문제

### 실시간 제어 (Real-Time Control)
- MPC (Model Predictive Control)의 플랜트 모델을 DeepONet으로 대체 → 실시간 최적화 가능
- [[predictive-control-barrier-functions]]와의 시너지

## 한계와 미해결 문제

1. **센서 위치 민감도**: Branch net의 입력 센서 위치에 성능이 크게 의존
2. **고차원 입력 함수**: 입력 함수의 차원이 높아질수록 센서 수 $m$이 폭발적으로 증가
3. **학습 데이터 생성 비용**: 다양한 파라미터에 대한 numerical 해를 사전 생성해야 함
4. **외삽(extrapolation)**: 학습 분포 밖의 파라미터에서 성능 저하
5. **불연속 해**: 충격파, 균열 등 불연속면이 있는 연산자 학습은 여전히 어려움

## 관련 개념

- [[universal-approximation-theorem]] — 함수 근사의 보편 정리 (연산자 정리의 기반)
- [[physics-informed]] — PINN 패러다임 개요 (DeepONet의 대안적 접근법)
- [[fourier-neural-operator]] — FNO: 또 다른 neural operator 아키텍처
- [[pseudo-differential-neural-operator]] — PDNO: Pseudo-differential operator 기반 접근법
- [[physics-constrained-surrogate]] — 물리 제약 기반 surrogate model
- [[in-context-modeling-physics]] — ICM: Operator learning의 in-context 버전
- [[pinn-failure-modes]] — PINN 실패 원인 (operator learning의 동기)
- [[predictive-control-barrier-functions]] — MPC/CBF (DeepONet 응용처)

[^chen1995]: Chen, T., & Chen, H. (1995). Universal approximation to nonlinear operators by neural networks with arbitrary activation functions and its application to dynamical systems. *IEEE Transactions on Neural Networks*, 6(4), 911-917.
