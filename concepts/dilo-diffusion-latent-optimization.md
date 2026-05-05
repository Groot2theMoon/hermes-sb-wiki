---
title: DiLO — Diffusion Latent Optimization for PDE-Constrained Inverse Problems
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [surrogate-model, inference, theory, physics-informed]
confidence: medium
---

# DiLO — Diffusion Latent Optimization

## 개요
**DiLO (Diffusion Latent Optimization)** (arXiv:2604.11375, 2026)는 diffusion model 기반 generative prior와 neural operator 기반 forward model을 **decoupling**하여 PDE-constrained inverse problem을 해결하는 프레임워크이다.

## 핵심 아이디어
- 기존 접근법과 달리 generative prior(parameter 분포)와 forward physical model(operator)을 명시적으로 분리
- **Manifold Consistency Requirement** 정립: physical surrogate는 fully denoised parameter에 대해서만 평가되어야 함
- Diffusion sampling process를 **deterministic latent trajectory**로 변환하여 측정 gradient의 안정적인 역전파 가능하게 함
- Electrical Impedance Tomography, Inverse Scattering, Inverse Navier-Stokes에서 우수한 성능

## 연결점
- [[fourier-neural-operator]] — DiLO가 활용하는 neural operator의 forward model 역할
- [[physics-informed]] — inverse problem 해결 시 physics prior 활용의 새로운 방법
- [[denoising-diffusion-probabilistic-models]] — diffusion model의 inverse problem 응용 확장

## References
- arXiv:2604.11375 — DiLO: Decoupling Generative Priors and Neural Operators via Diffusion Latent Optimization
