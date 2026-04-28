---
title: DeepONet — Deep Operator Networks
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, surrogate-model, mathematics, physics-informed, paper]
sources: [raw/papers/2281727.md]
confidence: high
---

# DeepONet — Deep Operator Networks

## 개요

Lu Lu, Pengzhan Jin, George Em Karniadakis (Brown University)이 제안한 **Deep Operator Networks (DeepONet)**은 **연산자의 보편 근사 정리(universal approximation theorem of operators)**[^chen1995]를 실제로 구현한 딥러닝 아키텍처이다^[raw/papers/2281727.md]. 적은 데이터로도 비선형 연산자(nonlinear operators)를 정확하고 효율적으로 학습할 수 있다.

## 핵심 아이디어

### Branch Net + Trunk Net 구조

DeepONet은 두 개의 서브네트워크로 구성된다:

- **Branch net**: 입력 함수 $f$를 고정된 수의 센서 $x_i$ ($i=1,\dots,m$)에서 인코딩
- **Trunk net**: 출력 위치 $y$를 인코딩
- 두 네트워크의 출력을 내적(dot product)하여 $G(f)(y)$ 근사

$$G(f)(y) \approx \sum_{k=1}^p \underbrace{b_k(f(x_1),\dots,f(x_m))}_{\text{branch}} \cdot \underbrace{t_k(y)}_{\text{trunk}}$$

### 수학적 보장

- Chen & Chen (1995)의 operator universal approximation theorem 기반
- 단일 은닉층으로도 모든 비선형 연속 연산자 근사 가능 (이론적 보장)
- 실제 구현에서는 **deep** architecture로 최적화 및 일반화 성능 향상

### 응용 분야

- 미분방정식 식별 (identifying differential equations)
- Parametric PDE의 solution operator 학습
- Surrogate modeling (물리 시뮬레이션 대체)

## 관련 개념

- [[universal-approximation-theorem]] — 함수 근사에 대한 보편 정리
- [[pseudo-differential-neural-operator]] — 다른 operator learning 접근법 (PDNO)
- [[physics-informed]] — PINN과의 연관성
- **Neural Operator** — Green 함수 기반 operator learning

[^chen1995]: Chen, T., & Chen, H. (1995). Universal approximation to nonlinear operators by neural networks with arbitrary activation functions and its application to dynamical systems.