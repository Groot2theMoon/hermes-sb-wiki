---
title: Continuous Representations of Baryonic Feedback — Flow Matching for Cosmology Simulations
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [physics-informed, surrogate-model, generative-model, latent-dynamics, uncertainty]
sources: [raw/papers/NeurIPS_ML4PS_2025_362.md]
confidence: medium
---

# Continuous Baryonic Feedback Representation

Flow matching 기반으로 여러 hydrodynamical 시뮬레이션 스위트 간 baryonic physics의
연속적 잠재 표현(continuous latent representation)을 학습하는 프레임워크.

## 개요

- **저자:** Ming-Shau Liu & Carolina Cuesta-Lazaro (Cambridge / Flatiron Institute)
- **NeurIPS ML4PS 2025 Workshop**
- **문제:** 서로 다른 시뮬레이터(IllustrisTNG, SIMBA, EAGLE, Astrid, Magneticum)는 각기 다른 subgrid physics 가정을 사용 → 이론적 불확실성의 이산화(discretization) 문제
- **해결책:** 연속적인 $z_{\text{baryon}}$ latent space를 학습하여 시뮬레이터 간 보간(interpolation) 및 robust uncertainty quantification

## 방법론

**Architecture: Flow Matching + ResNet Encoder + UNet + FiLM**

$$p(\delta_{\text{baryons}} | \delta_{\text{dm}}, \mathcal{C}, z_{\text{baryons}})$$

- **Flow matching:** continuous normalizing flow로 dark matter density → baryonic fields ($M_*$, $\delta_{\text{gas}}$, $T$, $P$) 매핑
- **ResNet encoder:** multi-channel baryonic fields → 8-dim $z_{\text{baryon}}$ latent
- **UNet decoder:** FiLM conditioning으로 $\delta_{\text{dm}}$, $\mathcal{C}$ (cosmology params), $z_{\text{baryon}}$ 통합
- **훈련:** Astrid, IllustrisTNG, SIMBA, EAGLE로 훈련 → Magneticum으로 held-out test

## 결과

- Cross-simulation generalization: IllusrisTNG에서 훈련된 모델이 Magneticum에서도 유사한 reconstruction 성능
- $z_{\text{baryon}}$ latent space가 시뮬레이터별 클러스터링을 보이면서도 연속적 보간 가능
- Large scale ($k < 1 h \text{Mpc}^{-1}$): cross-correlation > 0.9

## AI×Mechanics 관점

- Multiple simulator → single continuous latent space 프레임워크는 multi-fidelity surrogate modeling에 직접 적용 가능
- Simulation-based inference with marginalization over simulator systematics
- Flow matching + UNet + FiLM conditioning 패턴이 범용적인 physics-conditioned 생성 모델로 확장 가능

## 관련 페이지

- [[surrogate-model]] — Surrogate modeling overview
- [[generative-models-physics]] — Physics generative models
- [[conditional-normalizing-flow-lattice]] — Flow-based lattice sampling
- [[uncertainty-quantification-deep-learning]] — UQ in DL
