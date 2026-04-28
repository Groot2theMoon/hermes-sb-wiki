---
title: Pseudo-Differential Neural Operator (PDNO)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [neural-network, surrogate-model, mathematics, physics-informed, paper]
sources: [raw/papers/2201.11967v3.md]
confidence: high
---

# Pseudo-Differential Neural Operator (PDNO)

## 개요

Jin Young Shin, Jae Yong Lee, Hyung Ju Hwang (2022)이 제안한 **PDNO (Pseudo-Differential Neural Operator)**는 Fourier Neural Operator (FNO)를 **pseudo-differential operator (PDO)** 관점에서 일반화한 operator learning 모델이다^[raw/papers/2201.11967v3.md]. FNO의 Fourier integral operator가 위치(position) $x$에 대한 의존성을 무시하는 한계를 극복하고, 신경망으로 parameterize한 symbol을 통해 더 smooth하고 일반화 성능이 뛰어난 operator를 학습한다.

## 핵심 아이디어

### Pseudo-Differential Integral Operator (PDIO)

PDIO는 PDO 이론에서 영감을 받아 Fourier integral operator를 일반화한다:

- 기존 FNO: $R(\xi)$만 사용 — frequency $\xi$에만 의존, 위치 $x$ 무시
- PDIO: $a(x, \xi) = a_{\theta_1}^{nn}(x) \cdot a_{\theta_2}^{nn}(\xi)$ — **symbol network**로 위치와 frequency 모두 고려

### Symbol Network와 Smoothness

GELU 활성화 함수를 사용한 fully connected neural network로 symbol을 parameterize하면, 이 symbol이 **toroidal symbol class $S_{1,0}^1$**에 속함을 증명한다. 이는 PDIO가 Sobolev space에서 연속 연산자(continuous operator)임을 보장하며, overfitting을 완화하는 효과가 있다.

### 성능

- **Darcy flow** 및 **Navier-Stokes equation** 실험에서 FNO, Multiwavelet-based operator 대비 우수
- 시간 의존 PDE에는 **time-dependent symbol network** 적용 가능
- 특히 overfitting 저항성이 뛰어남 (Figure 1 참조)

## 수학적 배경

### PDO (Pseudo-Differential Operator)

$$T_a(f)(x) = \int_{\mathbb{R}^n} a(x, \xi) \hat{f}(\xi) e^{2\pi i \xi \cdot x} d\xi$$

$a(x, \xi)$를 **symbol**이라 하며, PDO는 differential operator의 일반화. $a(x, \xi)$가 smooth할수록 연산자가 더 smooth한 출력을 생성한다.

## 관련 개념

- [[deeponet]] — 또 다른 operator learning 접근법
- [[physics-informed]] — PDE 해결을 위한 ML 접근
- **Fourier Neural Operator (FNO)** — PDNO의 기반이 되는 방법
- **Neural Operator** — Green 함수 기반 iterative architecture