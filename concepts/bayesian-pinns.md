---
title: B-PINNs — Bayesian Physics-Informed Neural Networks
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [physics-informed, uncertainty, model, paper]
sources: [raw/papers/1904.12072v3.md]
confidence: high
---

# B-PINNs (Bayesian Physics-Informed Neural Networks)

## 개요

**Yang, Meng, [[george-em-karniadakis|Karniadakis]] (2019)**가 제안한 B-PINN은 PINN의 결정론적 예측을 **Bayesian 추론 프레임워크**로 확장하여 예측의 **불확실성 정량화(Uncertainty Quantification)**를 가능하게 한다. HMC (Hamiltonian Monte Carlo)로 posterior를 샘플링한다.

## 핵심 아이디어

### PINN vs B-PINN

| | PINN | B-PINN |
|---|------|--------|
| 파라미터 | 점추정 (point estimate) | Posterior 분포 |
| 예측 | 결정론적 | 확률적 (mean ± σ) |
| UQ | 불가능 | Aleatoric + Epistemic 분리 가능 |
| 계산 비용 | 낮음 (1회 학습) | 매우 높음 (MCMC sampling) |

### Posterior Sampling

$$\theta \sim p(\theta|\mathcal{D}) \propto p(\mathcal{D}|\theta) \, p(\theta)$$

HMC로 PDE residual + 데이터의 joint likelihood 기반 posterior 샘플링:

$$p(\mathcal{D}|\theta) \propto \exp\left(-\lambda_r \mathcal{L}_{PDE} - \lambda_d \mathcal{L}_{data}\right)$$

## 불확실성 분리

Epistemic (모델 불확실성)과 Aleatoric (데이터 노이즈) 분리:

- **Epistemic:** Posterior variance $\text{Var}_{\theta}[\hat{u}(x;\theta)]$ — 충분한 데이터로 감소 가능
- **Aleatoric:** Gaussian noise model의 precision 파라미터 — 데이터 품질 의존

## 한계

- HMC가 고차원에서 비효율적 (수천 개 이상 파라미터)
- VI 기반 대안 등장 ([[pac-bayesian-epistemic-uncertainty|PAC-Bayes VI]])
- [[mc-dropout|MC Dropout]]이나 [[deep-ensembles|Deep Ensembles]]가 더 가벼운 대안

## 융합 도메인 연결

B-PINN은 **신뢰할 수 있는 물리 예측**이 요구되는 공학 응용 (항공우주, 에너지)에서 결정적. UQ 없는 surrogate model은 위험 — B-PINN이 그 해결책.

## References

- [[physics-informed-neural-networks]] — 기반 아키텍처
- [[pinn-failure-modes]] — NTK 기반 PINN 한계 분석
- [[deep-ensembles]] — 대안적 UQ 방법
- [[mc-dropout]] — Bayesian approximation 대안
