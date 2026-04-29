---
title: Pseudo-Differential Neural Operator (PDNO)
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [neural-network, surrogate-model, mathematics, physics-informed, paper, model]
sources: [raw/papers/2201.11967v3.md]
confidence: high
---

# Pseudo-Differential Neural Operator (PDNO)

## 개요

Jin Young Shin, Jae Yong Lee, Hyung Ju Hwang (2022)이 제안한 **PDNO (Pseudo-Differential Neural Operator)**는 Fourier Neural Operator (FNO)를 **pseudo-differential operator (PDO)** 관점에서 일반화한 operator learning 모델이다^[raw/papers/2201.11967v3.md]. FNO의 Fourier integral operator가 위치(position) $x$에 대한 의존성을 무시하는 한계를 극복하고, 신경망으로 parameterize한 symbol을 통해 더 smooth하고 일반화 성능이 뛰어난 operator를 학습한다.

## 수학적 배경

### Pseudo-Differential Operator (PDO)

미분 연산자 $\mathcal{L}_a = \sum_\alpha c_\alpha D^\alpha$에 Fourier 변환을 적용하면:

$$a(\xi)\hat{u} = \hat{f}, \quad a(\xi) = \sum_\alpha c_\alpha (i\xi)^\alpha$$

PDO는 미분 연산자의 일반화로, $1/a(\xi)$를 **symbol** $a(x, \xi)$로 대체:

$$T_a(f)(x) = \int_{\mathbb{R}^n} a(x, \xi) \hat{f}(\xi) e^{2\pi i \xi \cdot x} d\xi$$

**Symbol class** $S_{\rho,\delta}^m$: $a(x, \xi)$의 smoothness를 보장하는 조건:

$$|\partial_\xi^\beta \partial_x^\alpha a(x, \xi)| \leq c_{\alpha\beta} \langle\xi\rangle^{m - \rho|\alpha| + \delta|\beta|}$$

### FNO vs PDO의 차이

| 측면 | FNO의 Fourier integral operator | PDO |
|------|-------------------------------|-----|
| **Symbol** | $R(\xi)$ — frequency만 의존 | $a(x, \xi)$ — 위치 + frequency |
| **Smoothness 보장** | ❌ 없음 | ✅ symbol class 조건 |
| **Continuity** | 보장 불가 | Sobolev space에서 연속 |
| **위치 정보** | 무시 | $x$-의존성으로 캡처 |

## PDNO 아키텍처

### Pseudo-Differential Integral Operator (PDIO)

Symbol을 분리된 신경망으로 매개변수화:

$$a_\theta^{nn}(x, \xi) = a_{\theta_1}^{nn}(x) \cdot a_{\theta_2}^{nn}(\xi)$$

PDIO 연산:

$$\mathcal{K}_a[f](x) = a_{\theta_1}^{nn}(x) \cdot \mathcal{F}^{-1}[a_{\theta_2}^{nn}(\xi) \cdot \mathcal{F}[f](\xi)]$$

```
f(x) ──→ [FFT] ──→ f̂(ξ) ──→ [× a_{θ₂}^{nn}(ξ)] ──→ [IFFT] ──→ [× a_{θ₁}^{nn}(x)] ──→ output
                                    ↑                          ↑
                              freq symbol net            position symbol net
                              (GELU FC NN)               (GELU FC NN)
```

### Symbol Network의 Smoothness (핵심 정리)

**Proposition 1**: GELU 활성화 함수를 사용한 fully connected NN으로 parameterize한 symbol network가 $S_{1,0}^1(\mathbb{T}^n \times \mathbb{R}^n)$에 속함.

$$|\partial_\xi^\alpha \partial_x^\beta a_\theta^{nn}(x, \xi)| \leq c_{\alpha\beta} \langle\xi\rangle^{1-|\alpha|}$$

**Theorem 2 (Boundedness)**: $S_{1,0}^1$의 symbol을 가진 PDO는 Sobolev space $W^{p,s}(\mathbb{T}^n)$에서 $W^{p,s-1}(\mathbb{T}^n)$으로의 **유계 선형 연산자** (bounded linear operator).

**의미**: PDIO는 overfitting을 완화하는 smooth operator를 학습 — 이것이 실험에서 관찰된 뛰어난 일반화 성능의 이론적 근거.

### 전체 PDNO 구조

Neural operator의 iterative update:

$$f_{t+1}(x) = \sigma\left(Wf_t(x) + \mathcal{K}_a[f_t](x)\right)$$

PDNO는 PDIO를 neural operator의 integral operator로 사용:

$$\mathcal{K}_a(f_t)(x) = \left[\sum_{i=1}^{c_{in}} a_{\theta_1,ij}^{nn}(x) \mathcal{F}^{-1}[a_{\theta_2,ij}^{nn}(\xi) \mathcal{F}[f_{t,i}](\xi)](x)\right]_{j=1}^{c_{out}}$$

### Time-dependent PDIO

시간 의존 PDE에는 time-dependent symbol network 적용:

$$\mathcal{K}_a[f](x, t) = a_{\theta_1}^{nn}(x, t) \cdot \mathcal{F}^{-1}[a_{\theta_2}^{nn}(\xi, t) \cdot \mathcal{F}[f](\xi)]$$

열방정식 $u(x,t) = e^{t\mathcal{L}}u_0(x)$의 경우 symbol $e^{-4\pi^2\xi^2 ct}$를 학습하며, **훈련 데이터에 없는 시간 $t$에서도 보간 가능**.

## FNO/KNO와의 비교

| 측면 | [[fourier-neural-operator|FNO]] | Multiwavelet (MWT) | **PDNO** |
|------|------|------|------|
| **Symbol 의존성** | $\xi$만 | multi-scale | $x + \xi$ |
| **Smoothness** | 보장 없음 | wavelet 기반 | $S_{1,0}^1$ 보장 |
| **Overfitting** | 심함 | 심함 | **완화됨** |
| **Darcy flow** | good | good | **best** |
| **Navier-Stokes** ($\nu=10^{-5}$) | test error 급증 | test error 급증 | **안정적** |
| **Time extrapolation** | 제한적 | 제한적 | **continuous-in-time** |

### 실험 결과 하이라이트

- **Darcy flow**: FNO, MWT 대비 낮은 상대 $L^2$ 오차
- **Navier-Stokes** ($\nu = 10^{-5}$): train/test gap이 가장 작음 → overfitting 저항
- 시간 horizon $t = 10,...,19$에서 FNO와 MWT는 오차 급증, PDNO는 안정

## 관련 개념

- [[fourier-neural-operator]] — FNO: PDNO의 기반이 되는 방법
- [[deeponet]] — 또 다른 operator learning 접근법
- [[ppi-no]] — Physics-preserving neural operator
- [[physics-informed-neural-networks]] — PDE 해결을 위한 ML 접근
- [[physics-constrained-surrogate]] — PDE 기반 surrogate modeling
