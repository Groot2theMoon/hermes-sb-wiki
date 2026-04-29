---
title: PINN Failure Modes — NTK Perspective on Why and When PINNs Fail
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [physics-informed, neural-network, training, mathematics, paper]
sources: []
confidence: high
---

# PINN Failure Modes — NTK Perspective

## 개요

**Wang, Yu, Perdikaris (2021)**는 [[neural-tangent-kernel|NTK (Neural Tangent Kernel)]] 이론을 통해 **PINN이 왜, 언제 실패하는지**를 수학적으로 분석했다. 핵심 발견: PINN 학습 실패는 PDE 각 항의 NTK eigenvalue 분포 불균형에서 비롯된다.

## 핵심 발견

### NTK Eigenvalue Imbalance

PDE residual $\mathcal{R}$의 NTK $\Theta_{\mathcal{R}}$를 분해하면:

$$\Theta_{\mathcal{R}} = \Theta_{PDE} + \Theta_{BC} + \Theta_{IC}$$

각 구성요소의 leading eigenvalue가 다를 때, gradient descent는 dominant eigenvalue 방향으로만 학습 — 결과적으로 다른 loss 항이 수렴하지 않음.

### Learning Rate Annealing

제안된 해결책: 각 loss 항의 gradient statistics에 기반한 **adaptive learning rate**:

$$\lambda_i^{(t+1)} = \lambda_i^{(t)} \cdot \frac{\max_j\|\nabla_{\theta}\mathcal{L}_j\|}{\|\nabla_{\theta}\mathcal{L}_i\|}$$

### 주요 실패 모드

| 실패 모드 | NTK 진단 | 예시 |
|----------|---------|------|
| BC 미충족 | $\Theta_{BC}$ eigenvalue» $\Theta_{PDE}$ | von Karman vortex street |
| PDE residual stagnation | $\Theta_{PDE}$ eigenvalue 소멸 | high-frequency Burgers |
| Initial condition drift | Time-shifted IC loss | Allen-Cahn equation |
| Causality violation | Temporal NTK eigenvalue imbalance | Time-marching problems |

## NTK 분석의 의의

PINN을 "블랙박스 최적화 문제"에서 **스펙트럼 분석 가능한 수학적 객체**로 격상. NTK eigenvalue 분포를 진단 도구로 활용하면 학습 전에 실패 가능성을 예측할 수 있다.

## NTK와 Neural Operator

NTK 분석은 [[fourier-neural-operator|FNO]]나 [[deeponet|DeepONet]] 같은 operator learning에도 적용 가능 — operator의 spectral bias 분석.

## References

- [[neural-tangent-kernel]] — NTK 기초 이론
- [[physics-informed-neural-networks]] — PINN 아키텍처
- [[deeponet]] — 대안: operator learning
- [[bayesian-pinns]] — B-PINN으로 PINN 한계 우회
