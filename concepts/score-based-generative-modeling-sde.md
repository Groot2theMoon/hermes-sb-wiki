---
title: Score-Based Generative Modeling through SDEs — Unifying SMLD and DDPM
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, neural-network, training, mathematics, landmark-paper, generative-model]
sources: [raw/papers/2011.13456v2.md]
confidence: high
---

# Score-Based Generative Modeling through SDEs

## 개요

Song et al. (Stanford/Google Brain, 2021)은 두 갈래로 발전해온 생성 모델링 접근법 — **Score Matching with Langevin Dynamics (SMLD)**와 **Denoising Diffusion Probabilistic Models (DDPM)** — 을 **연속시간 Stochastic Differential Equation (SDE) 프레임워크로 통합**한 기념비적 논문이다.

## 핵심 아이디어

### 통합: Forward SDE + Reverse SDE

데이터 분포 $p_0(x)$ → 노이즈 분포 $p_T(x)$ (forward process):

$$\mathrm{d}x = f(x,t)\,\mathrm{d}t + g(t)\,\mathrm{d}w$$

여기서 $f(x,t)$는 drift, $g(t)$는 diffusion coefficient.

샘플 생성 (reverse process):

$$\mathrm{d}x = [f(x,t) - g(t)^2\nabla_x\log p_t(x)]\,\mathrm{d}t + g(t)\,\mathrm{d}\bar{w}$$

**key insight:** reverse SDE에 필요한 것은 score function $\nabla_x\log p_t(x)$ 뿐 — score-matching으로 학습.

### VE-SDE와 VP-SDE

| | VE-SDE (Variance Exploding) | VP-SDE (Variance Preserving) |
|---|------|-----|
| 대응 모델 | SMLD (NCSN) | DDPM |
| $f(x,t)$ | 0 | $-\frac{1}{2}\beta(t)x$ |
| $g(t)$ | $\sqrt{\mathrm{d}[\sigma^2(t)]/\mathrm{d}t}$ | $\sqrt{\beta(t)}$ |
| 특성 | 분산이 발산 | 분산이 유지됨 |

### Predictor-Corrector (PC) Sampler

- **Predictor:** reverse SDE의 numerical solver (Euler-Maruyama 등)
- **Corrector:** score-based MCMC (Langevin dynamics)로 predictor 오류 보정

이 조합으로 기존 SMLD/DDPM보다 샘플 품질과 속도가 모두 개선됨.

### Probability Flow ODE

Score $s_\theta(x,t) \approx \nabla_x\log p_t(x)$가 주어지면, 동일한 marginal distribution을 갖는 ODE 유도 가능:

$$\mathrm{d}x = [f(x,t) - \frac{1}{2}g(t)^2 s_\theta(x,t)]\,\mathrm{d}t$$

- **exact likelihood 계산** 가능 (instantaneous change-of-variables)
- **inverse problem** 해결에 결정적 — forward ODE로 encoding, reverse ODE로 reconstruction

## 성능

- CIFAR-10: IS 9.89, FID 2.20 (SOTA at the time)
- PC sampler: DDPM 대비 2-3배 빠른 샘플링
- Exact NLL: 비가역 아키텍처로도 exact log-likelihood 계산 가능

## 융합 도메인 연결

Score-SDE 프레임워크는 물리 시뮬레이션의 [[diffusion-lattice|격자장 이론 생성]], uncertainty quantification, inverse design 등에 활용된다. Probability flow ODE는 결정론적 물리 역문제에 특히 유용하다.

## References
- [[yang-song]]


- [[diffusion-lattice]] — Score-based model의 격자장 응용
- [[generative-models-physics]] — 물리학 생성 모델 개요
- [[flow-based-mcmc]] — 대안적 lattice field sampling
- [[variational-autoencoder]] — 이전 세대 생성 모델
- [[optimal-transport-stability-sinkhorn]]
