---
title: Generative Diffusion Models for Lattice Field Theory
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [physics-informed, model, paper, generative-model]
sources: []
confidence: medium
---

# Diffusion Models for Lattice Field Theory

## 개요

**Wang, Aarts, Zhou (2023)**는 **확산 모델(diffusion model)**을 격자 장 이론(lattice field theory)의 **샘플 생성**에 적용했다. 기존 HMC(Hybrid Monte Carlo)의 **critical slowing down** 문제 (연속체 극한에서 상관 시간 발산)를 생성 모델로 해결하는 접근법이다.

## Critical Slowing Down 문제

격자 QCD에서 HMC는 격자 간격 $a \to 0$ (연속체 극한)으로 갈수록 **상관 시간(correlation time)**이 $\tau \propto a^{-z}$ 형태로 발산한다. 이는 Monte Carlo 샘플링의 효율성을 급격히 떨어뜨린다.

## 생성 모델 접근법 비교 (Lattice Field Theory)

| 방법 | 원리 | 장점 | 단점 |
|:---|:----|:----|:----|
| **HMC** | Hamiltonian dynamics + Metropolis | 정확함 (exact) | Critical slowing down |
| **GAN** | Generator + Discriminator 경쟁 | 빠른 샘플링 | Mode collapse 가능성 |
| **Normalizing Flow** | 가역 변환 + Jacobian | 정확한 확률 계산 | 표현력 제한 |
| **Diffusion** | Forward/Reverse diffusion SDE | 고품질 샘플 | 느린 샘플링 |

## 융합 도메인 연결

- [[gan-lattice-simulations]] (GAN 기반)과 [[flow-based-mcmc]] (Normalizing flow 기반)에 이은 **세 번째 생성 모델 접근법**
- [[generative-models-physics]] — 물리학 생성 모델 계열의 최신 동향
- [[mode-collapse-flow-lattice]] — Flow 기반 방법의 mode collapse 문제와의 비교
- [[conditional-normalizing-flow-lattice]] — 조건부 normalizing flow와의 연결

## References
- Wang, L., Aarts, G., & Zhou, K. (2023). Diffusion models for lattice field theory. arXiv:2311.03578.
- [[gan-lattice-simulations]]
- [[flow-based-mcmc]]
- [[generative-models-physics]]
