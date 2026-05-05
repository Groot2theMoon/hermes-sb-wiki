---
title: Autoencoder-Based Reduced Order Models (ROM)
created: 2026-05-04
updated: 2026-05-05
type: concept
tags: [surrogate-model, dimensionality-reduction, autoencoder, simulation]
sources: []
confidence: medium
---

# Autoencoder-Based Reduced Order Models (ROM)

## 개요

Autoencoder 기반 ROM은 고차원 시뮬레이션 데이터를 오토인코더로 저차원 잠재 공간에 압축하고, 잠재 공간에서 효율적으로 시간 전개(time evolution)를 계산하는 surrogate modeling 방법.

## Pipeline

```
고해상도 시뮬레이션 → {u₁, u₂, ..., u_T}
                         ↓
              Encoder: u_t → z_t (latent)
                         ↓
              Latent dynamics: z_{t+1} = f(z_t)
                         ↓
              Decoder: z_t → ũ_t (reconstructed)
```

## 구성 요소

### Encoder-Decoder
- **CNN / ConvAE:** 격자 기반 데이터 (FEM, CFD mesh)
- **GNN / MeshGraphNet:** 비정형 메시
- **PCA (Proper Orthogonal Decomposition):** 선형 차원 축소 (고전적)

### Latent Dynamics
- **Linear:** $z_{t+1} = Az_t$ (DMD-like)
- **Neural ODE:** $\dot{z} = f_\theta(z)$
- **LSTM / Transformer:** 시계열 모델링
- **Koopman:** 선형 lifted dynamics

## 장점

| 항목 | 설명 |
|:----|:-----|
| **계산 속도** | 고해상도 시뮬레이션 대비 $10^2$–$10^4$배 가속 |
| **비선형성** | PCA/POD 대비 비선형 manifold 표현 가능 |
| **메모리** | 잠재 공간에서만 연산 → 메모리 절약 |
| **확장성** | 파라미터 연구, 최적화, UQ에 활용 가능 |

## Wikilinks
- [[neural-odes]] — Neural ODE (잠재 동역학 모델링)
- [[pseudo-differential-neural-operator]] — PDNO (neural operator)
- [[deeponet]] — DeepONet (operator learning)
- [[fourier-neural-operator]] — FNO
- [[state-space-model]] — State-space models
- [[differentiable-sigma-point-quadrature]] — Sigma point quadrature (RIGOR)

## References
- Hesthaven, J. S. & Ubbiali, S. (2018). "Non-intrusive reduced order modeling of nonlinear problems using neural networks." *J. Comput. Phys.*, 363, 55-78.
- Lee, K. & Carlberg, K. T. (2020). "Model reduction of dynamical systems on nonlinear manifolds using deep convolutional autoencoders." *J. Comput. Phys.*, 404, 108973.
