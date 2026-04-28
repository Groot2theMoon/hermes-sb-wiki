---
title: B-PINNs (Bayesian Physics-Informed Neural Networks)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, model, training, inference, paper]
sources: [raw/papers/1-s2.0-S0021999120306872-main.md]
confidence: high
---

# B-PINNs: Bayesian Physics-Informed Neural Networks

Yang, Meng, Karniadakis (Brown, 2020)가 제안한 **Bayesian PINN**으로, 기존 PINN의 결정론적 가중치를 **확률적 Bayesian 추론**으로 대체하여 잡음이 있는 데이터에서도 강건한 추론을 가능하게 한다^[raw/papers/1-s2.0-S0021999120306872-main.md].

- **Hamiltonian Monte Carlo (HMC)**로 사후분포 샘플링
- PINN의 예측 불확실성 정량화 — aleatoric + epistemic 불확실성 모두 포착
- 순방향(forward) 및 역방향(inverse) PDE 문제 모두에 적용
- 잡음 수준이 높은 데이터에서 표준 PINN보다 우수
- [[bayesian-uncertainty-vision]]의 컴퓨터 비전 불확실성 개념을 PINN에 적용
- [[physics-constrained-surrogate]]와 함께 AI × Mechanics의 핵심 연구