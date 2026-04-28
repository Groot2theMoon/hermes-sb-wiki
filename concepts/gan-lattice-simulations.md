---
title: GAN-based Overrelaxation for Lattice Simulations
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [neural-network, model, physics-informed, surrogate-model, paper]
sources: [raw/papers/1811.03533v4.md]
confidence: high
---

# GAN-based Overrelaxation for Lattice Field Theory

## 개요

**GAN 기반 overrelaxation**은 Pawlowski & Urban (Heidelberg, 2018)이 제안한 방법으로, [[ian-goodfellow|Ian Goodfellow]]의 **Generative Adversarial Network (GAN)**을 lattice field theory Monte Carlo 시뮬레이션의 **overrelaxation step**으로 활용하여 autocorrelation time을 획기적으로 줄인다^[raw/papers/1811.03533v4.md].

## 문제: Critical Slowing Down

- Lattice 시뮬레이션에서 **상전이점 근처** autocorrelation time $\\tau \\sim \\xi^z$ 발산
- 기존 HMC/Hybrid Monte Carlo로는 독립 샘플 생성에 많은 step 필요
- 특히 scalar field theory에서 **$Z_2$ 대칭**만 있는 경우 conventional overrelaxation 불가능

## 제안 방법: GAN Overrelaxation

### 아이디어
1. HMC로 일부 샘플 생성 → **GAN 학습** (HMC 샘플을 training data로)
2. GAN에서 candidate $G(z)$ 생성
3. **Latent space gradient flow**로 action 일치: $z' = \\arg \\min_z (S[G(z)] - S[\\phi])^2$
4. $\\Delta S = 0$ → **자동 accept** (symmetry 조건 충족 시)
5. HMC step과 번갈아 사용 → Markov chain 결합

### 핵심 특징
- **Action과 무관한 observable의 autocorrelation 제거** — Markov chain 단절 효과
- 기존 overrelaxation과 달리 **action의 특정 대칭성 불필요**
- Consistency check로 ergodicity 및 statistical exactness 검증 가능

## 결과

### $\\phi^4$ Theory on $32 \\times 32$ Lattice
- **Vanilla GAN**으로도 disordered phase에서 observable 정확히 재현
- GAN overrelaxation 도입 시 **magnetization autocorrelation time 크게 감소**
- 1000개 training sample만으로 효과적

### 실용적 이점
- **Critical slowing down 완화**: 상전이점 근처에서도 효율적
- **대규모 병렬화 가능**: GAN sampler는 i.i.d. 샘플 생성
- 복잡한 action에도 적용 가능 (lattice QCD 등)

## 한계
- Latent space 차원 $d_z$ < target space 차원 $N^d$ → ergodicity 이슈 가능
- Mode collapse 시 overrelaxation step 비효율
- Gradient flow 과정의 계산 비용

## References
- J.M. Pawlowski, J.M. Urban. "Reducing Autocorrelation Times in Lattice Simulations with Generative Adversarial Networks", *Mach. Learn.: Sci. Technol.* 2020
- [[flow-based-mcmc]] — 정규화 플로우 기반 MCMC (대안적 접근)
- [[variational-autoregressive-networks]] — Autoregressive network 기반 lattice 접근법