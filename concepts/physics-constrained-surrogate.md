---
title: Physics-Constrained Deep Learning for Surrogate Modeling
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [physics-informed, surrogate-model, FEM, model, paper, mathematics]
sources: [raw/papers/1-s2.0-S0021999119303559-main.md]
confidence: high
---

# Physics-Constrained Surrogate Modeling

## 개요

Zhu, Zabaras, Koutsourelakis, [[paris-perdikaris|Perdikaris]] (2019)가 *Journal of Computational Physics*에 발표한 논문으로, **레이블 데이터 없이 물리 법칙만으로 고차원 Surrogate Model을 학습**하는 방법을 제시한다^[raw/papers/1-s2.0-S0021999119303559-main.md]. 기존 supervised surrogate model이 요구하는 expensive simulation output 데이터를 완전히 생략하고, PDE의 에너지 함수형(energy functional)이나 잔차(residual)만으로 학습한다.

## 핵심 아이디어

### 문제 정의

물리 시스템이 PDE로 지배된다고 가정:

$$\mathcal{N}(u(s); K(s)) = f(s), \quad s \in \mathcal{S}$$

여기서 $K(s)$는 확률적 입력 장(예: 투과율 필드), $u(s)$는 출력 해. **Darcy flow** 문제를 motivating example로 사용:

$$-\nabla \cdot (K(s)\nabla u(s)) = f(s)$$

에너지 함수형 $V(u; K)$를 최소화하여 해를 구하는 것이 목표:

$$\arg\min_u V(u; K)$$

### 학습 손실 함수

레이블 데이터 없이 **PDE 잔차**만으로 학습하는 것이 핵심. 두 가지 파라미터화 방법:

| 파라미터화 | 입력 | 장점 | 한계 |
|-----------|------|------|------|
| **FC-NN** | 좌표 $s$ → $u_\phi(s)$ | mesh-free, 미분 가능 | multiscale 특성 포착 어려움 |
| **CNN decoder** | latent $z$ → $\hat{y}_\theta(z)$ | multiscale, translation equivariant | 고정 격자 |

**Deterministic surrogate**의 손실 함수:

$$\mathcal{L}_{\text{det}}(\theta) = \frac{1}{N}\sum_{i=1}^N V(\hat{y}_\theta(\mathbf{x}^{(i)}); \mathbf{x}^{(i)})$$

Sobel filter로 spatial gradient를 효율적으로 근사하여 FEM 유사 정확도 달성.

### Probabilistic Surrogate — Reverse KL

확률적 surrogate를 위해 **conditional normalizing flow**를 결합. 핵심은 **Reverse KL divergence** 최소화:

$$D_{\text{KL}}(p_\theta(\mathbf{y}|\mathbf{x}) \| p_{\text{ref}}(\mathbf{y}|\mathbf{x}))$$

여기서 $p_{\text{ref}}$는 Boltzmann-Gibbs 분포로 정의:

$$p_{\text{ref}}(\mathbf{y}|\mathbf{x}) \propto \exp\left(-\frac{1}{T} V(\mathbf{y}; \mathbf{x})\right)$$

이 접근법의 장점:
- **레이블 데이터 불필요** — 입력 샘플 $\mathbf{x}^{(i)} \sim p(\mathbf{x})$만 필요
- **확장성** — high-dimensional stochastic input에 적용 가능
- **보정된 불확실성** — calibrated uncertainty quantification

## 아키텍처

```
입력 K(s) ─→ [Conv Encoder] ─→ latent z ─→ [Conv Decoder] ─→ 해 u(s)
                                       │
                              [Normalizing Flow]
                                       │
                                  p_θ(y|x) 분포
```

Encoder-decoder는 deterministic surrogate를, flow 기반 생성 모델은 probabilistic surrogate를 구성한다.

## PINN과의 비교

| 측면 | [[physics-informed-neural-networks|PINN]] | Physics-Constrained Surrogate |
|------|------|------|
| **학습 방식** | coordinate 입력, 자동미분으로 PDE 잔차 | CNN decoder, Sobel filter로 잔차 |
| **출력** | 단일 해 $u(x,t)$ | 분포 $p_\theta(\mathbf{y}|\mathbf{x})$ |
| **데이터** | 레이블 불필요 | 레이블 불필요 |
| **UQ** | 별도 Bayesian 추론 내장 | conditional flow로 내장 |
| **고차원 입력** | 좌표 기반 → scalability 제한 | CNN latent space → high-dim 가능 |
| **Out-of-distribution** | 일반화 어려움 | better extrapolation 성능 |

## 실험 결과

- **Darcy flow**: 고주파 multiscale permeability field에서 CNN 기반 방법이 FC-NN 대비 훨씬 우수
- **Data-free**: 레이블 데이터 없이 data-driven supervised model과 comparable 성능
- **Out-of-distribution**: 분포 밖 테스트 입력에서도 더 robust한 예측
- **UQ**: calibrated predictive uncertainty 제공

## 관련 개념

- [[physics-informed-neural-networks]] — PINN의 원래 프레임워크
- [[fourier-neural-operator]] — FNO: operator learning 관점의 대안
- [[pinn-failure-modes]] — PINN 실패 분석
- [[uncertainty-quantification-deep-learning]] — ML 기반 UQ
- [[surrogate-model]] — Surrogate modeling 일반
