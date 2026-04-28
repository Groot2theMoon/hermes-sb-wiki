---
title: Zongyi Li
created: 2026-04-28
updated: 2026-04-28
type: entity
tags: [person, neural-network, mathematics, fluid-dynamics]
sources: [raw/papers/2010.08895v3.md]
---

# Zongyi Li

**Fourier Neural Operator (FNO) 창시자.** Caltech에서 Anima Anandkumar와 함께 연구한 머신러닝 연구자로, **Neural Operator** 접근법을 개척했다.

## 주요 기여

### Fourier Neural Operator (FNO)
Li, Kovachki, Azizzadenesheli, Liu, Bhattacharya, Stuart, Anandkumar (Caltech, 2020)가 제안한 [[fourier-neural-operator]]는 적분 커널을 **Fourier 공간에서 직접 매개변수화**하여 PDE 계열 전체를 한 번에 학습한다. 기존 PINN이나 FEM과 달리 discretization에 불변(discretization-invariant)인 operator를 학습한다.

### Neural Operator 프레임워크
Li는 Fourier 도메인에서의 convolution 연산을 신경망으로 구현하여, 해상도 독립적인 PDE 솔버를 구축하는 프레임워크를 정립했다.

### 연구 분야
- Neural operators for PDEs
- Fourier-domain deep learning
- Discretization-invariant ML
- Scientific computing with deep learning

## 관계

- [[fourier-neural-operator]] — FNO (Li의 대표 업적)
- [[george-em-karniadakis]] — 경쟁/보완 operator learning 연구자
- [[deeponet]] — FNO와 비교되는 대표적 operator learning 방법
- [[pseudo-differential-neural-operator]] — FNO를 일반화한 PDNO