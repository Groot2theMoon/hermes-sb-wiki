---
title: SN-GAN vs GAN Lattice Simulations — GAN 안정화 방법 비교
created: 2026-04-29
updated: 2026-04-29
type: comparison
tags: [comparison, generative-model, neural-network, physics-informed, training]
sources: [raw/papers/Spectral Normalization for Generative Adversarial Networks.md, raw/papers/1811.03533v4.md]
---

# SN-GAN vs GAN Lattice Simulations — GAN 안정화 방법 비교

**Spectral Normalization for GANs (Miyato et al., ICLR 2018)**와 **GAN-based Overrelaxation for Lattice Simulations (Pawlowski & Urban, 2018)**는 모두 GAN의 학습 안정성을 다루지만, **목적과 접근법**이 근본적으로 다르다. SN-GAN은 GAN 학습 자체를 안정화하는 정규화 기법이고, GAN Lattice은 GAN을 물리 시뮬레이션의 도구로 활용하여 기존 Monte Carlo 방법의 효율성을 개선한다.

## 비교 표

| 차원 | [[spectral-normalization-gan\|SN-GAN]] | [[gan-lattice-simulations\|GAN Lattice]] |
|------|----------------------------------------|------------------------------------------|
| **핵심 목표** | GAN 학습 안정화 (discriminator Lipschitz 제어) | 물리 시뮬레이션 효율 개선 (autocorlation time 감소) |
| **적용 대상** | GAN의 discriminator 층별 weight 행렬 | Lattice field theory Monte Carlo 시뮬레이션 |
| **핵심 메커니즘** | Weight 행렬의 spectral norm을 1로 정규화: $W / \sigma(W)$ | GAN overrelaxation으로 $\Delta S = 0$ 조건 자동 만족 |
| **수학적 기반** | Lipschitz constraint 이론 (WGAN) | Markov chain 결합 + latent space gradient flow |
| **계산 비용** | 매우 낮음 (power iteration 1회) | 중간 (GAN 학습 + gradient flow 최적화) |
| **추가 하이퍼파라미터** | 없음 (auto-tuned) | Latent dimension $d_z$, gradient flow step size |
| **주요 장점** | 구현 간단, 계산 효율적, mode collapse 완화 | Critical slowing down 완화, 대규모 병렬화 가능 |
| **한계** | Conditional GAN에서 비최적 | Mode collapse 시 비효율, ergodicity 이슈 가능 |
| **검증 범위** | CIFAR-10, STL-10, ImageNet | $\phi^4$ theory, lattice QCD |

## 핵심 차이: 학습 안정화 vs 시뮬레이션 도구

| 측면 | SN-GAN | GAN Lattice |
|------|--------|-------------|
| **방향** | GAN 자체를 개선 | GAN을 기존 시뮬레이션에 통합 |
| **대상 분야** | 컴퓨터 비전, 이미지 생성 | 격자장 이론, 통계 물리학 |
| **성공 지표** | Inception Score, FID | Autocorrelation time, magnetization 정확도 |
| **GAN 역할** | 최종 생성 모델 | 시뮬레이션 보조 도구 (overrelaxation step) |

## 언제 무엇을 쓸까?

| 사용 사례 | 권장 | 이유 |
|-----------|------|------|
| **이미지 생성 품질 개선** | SN-GAN | discriminator 안정화로 생성 품질 향상 |
| **Lattice QCD 시뮬레이션 가속** | GAN Lattice | autocorrelation time 감소로 독립 샘플 효율 증가 |
| **Mode collapse 방지** | SN-GAN | Lipschitz constraint로 discriminator 과신 방지 |
| **Critical slowing down 완화** | GAN Lattice | 상전이점 근처에서도 효율적 샘플링 |
| **일반적인 GAN 학습** | SN-GAN | 추가 비용 없이 plug-and-play |

## 관련 페이지

- [[spectral-normalization-gan]] — SN-GAN 상세
- [[gan-lattice-simulations]] — GAN Lattice 상세
- [[spectral-margin-generalization-bounds]] — Spectral methods의 이론적 기반
- [[generative-models-physics]] — 물리학에서의 생성 모델
- [[variational-autoencoder]] — 대안적 생성 모델
- [[vae-vs-gan]] — VAE vs GAN 비교
