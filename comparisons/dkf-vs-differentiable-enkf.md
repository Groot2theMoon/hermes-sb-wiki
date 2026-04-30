---
title: Deep Kalman Filter vs Differentiable Ensemble Kalman Filter — Temporal Inference 비교
created: 2026-04-29
updated: 2026-04-29
type: comparison
tags: [comparison, kalman-filter, state-space-model, variational-inference, system-identification]
sources: [raw/papers/deep-kalman-filters.md, raw/papers/structured-inference-networks-ssm.md, raw/papers/enhancing-state-estimation-robots.md]
confidence: medium
---

# DKF vs Differentiable EnKF — Temporal Generative Model 비교

두 접근법 모두 **미분 가능한 temporal inference + data-driven dynamics learning**을 목표로 하지만, 철학과 구현이 완전히 다르다. DKF는 VAE의 variational approach를, Differentiable EnKF는 ensemble filtering의 Monte Carlo approach를 따른다.

## 비교 표

| 차원 | Deep Kalman Filter (DKF) | Differentiable Ensemble KF |
|------|-------------------------|---------------------------|
| **핵심 메커니즘** | VAE-style variational inference (amortized posterior) | Ensemble Kalman filtering with AD |
| **Posterior 표현** | Gaussian (diagonal covariance) | Ensemble of particles (non-parametric) |
| **Inference network** | Bidirectional RNN (learned recognition model) | EnKF update equations (algorithmic prior) |
| **Dynamics 모델** | Neural net transition + emission (black-box) | Learnable dynamics + EnKF update (structured) |
| **학습 목적함수** | ELBO = reconstruction - KL | Reconstruction loss on observations |
| **미분 가능** | ✅ (reparameterization trick) | ✅ (autodiff through EnKF steps) |
| **Non-Gaussian posterior** | ❌ (Gaussian 가정) | ✅ (ensemble이 multi-modal 표현 가능) |
| **Online inference** | ❌ (offline, bidirectional) | ✅ (causal filtering) |
| **Scalability (latent dim)** | 좋음 (amortized) | 나쁨 (ensemble size × latent dim) |
| **Prior knowledge 활용** | 어려움 (black-box) | 쉬움 (EnKF에 물리 모델 통합 가능) |

## 장단점

| | DKF | Diff. EnKF |
|---|-----|-----------|
| **장점** | Scalable, stable training, 압축된 latent 표현 | Non-Gaussian posterior, algorithmically grounded, online 가능 |
| **단점** | Gaussian 가정의 한계, offline only, model collapse 위험 | Ensemble size에 따른 계산 비용, 고차원에서 비효율적 |

## 언제 무엇을 선택할까?

| 사용 사례 | 권장 | 이유 |
|-----------|------|------|
| EHR counterfactual inference | **DKF** | Gaussian posterior로 충분, latent dim 큼 |
| 로봇 실시간 상태 추정 | **Diff. EnKF** | Non-Gaussian noise, online |
| 물리+ML 하이브리드 | **Diff. EnKF** | 물리 모델을 EnKF dynamics에 자연스럽게 임베드 |
| 고차원 이미지 시계열 | **DKF** | Amortized inference가 efficient |
| **사이드 프로젝트 (A+NN SR-UKF)** | **UKF (hybrid)** | UKF가 EnKF보다 sigma point efficient (2L+1 vs ensemble) |

## 관련 페이지
- [[deep-kalman-filter]] — DKF 상세
- [[differentiable-enkf]] — Diff. EnKF 상세
- [[deep-variational-smc]] — Particle filter + VI (중간 지점)
- [[square-root-unscented-kalman-filter]] — SR-UKF baseline
- [[structured-inference-networks]] — DMM (DKF 개선)
