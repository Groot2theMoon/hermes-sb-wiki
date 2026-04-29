---
title: Physics-Informed Temporal U-Net — Fluid Interpolation
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [physics-informed, fluid-dynamics, model, CFD, neural-network]
sources: [raw/papers/trending/2026-04-28-04.md]
confidence: medium
---

# Physics-Informed Temporal U-Net for Fluid Interpolation

## 개요

Eshwar R. A., Thomas, Nehal G, Begam (2026)이 제안한 **시변 유체 데이터의 고충실도 보간을 위한 Temporal U-Net** 아키텍처. 기존 딥러닝 보간법이 sparse temporal observation에서 **spatial blurring**과 **temporal strobing**을 유발하는 문제를 해결한다.

## 문제 정의

유체 역학 데이터의 시간 보간은 다음 이유로 어렵다:

| 문제 | 원인 | 현상 |
|------|------|------|
| **Spatial blurring** | MSE/L1 손실의 평균회귀(regression to mean) | 난류 구조의 고주파 세부 정보 손실 |
| **Temporal strobing** | anchor frame에서의 불연속 전환 | 시간적으로 깜빡이는 아티팩트 |
| **저충실도 재구성** | perceptual fidelity 부재 | 텍스처와 에지 구조 파괴 |

## 아키텍처: Temporal U-Net

### 전체 구조

```
frame t₀ ──→ [Encoder] ──→ F₀ ──→ [Bottleneck] ──→ [Decoder] ──→ frame t*
frame t₁ ──→ [Encoder] ──→ F₁ ──→      ↑              ↑
                                      PI Bridge    Time-weighted
                                      (t*(1-t*))    Feature Blending
```

### Physics-Informed Bridge (PI Bridge)

핵심 물리적 제약 조건: **parabolic boundary condition** $t^*(1-t^*)$

- $t^* = 0$ (anchor frame $t_0$)과 $t^* = 1$ (anchor frame $t_1$)에서 가중치가 0이 됨
- 중간 시간 $t^* = 0.5$에서 최대 영향
- **endpoint consistency 보장**: 관측 프레임에서 완벽한 reconstruction

$$\text{blend}(F_0, F_1, t^*) = (1 - t^*) \cdot F_0 + t^* \cdot F_1 + t^*(1-t^*) \cdot \mathcal{B}(F_0, F_1)$$

여기서 $\mathcal{B}$는 PI Bridge가 학습하는 보간 특성이다.

### 손실 함수 구성

| 손실 항 | 수식 | 역할 |
|---------|------|------|
| **L1 reconstruction** | $\|I_{\text{pred}} - I_{\text{gt}}\|_1$ | 픽셀 수준 정확도 |
| **VGG perceptual loss** | $\sum_l \|\phi_l(I_{\text{pred}}) - \phi_l(I_{\text{gt}})\|_2^2$ | perceptual fidelity, 텍스처 보존 |
| **PI Bridge penalty** | $\lambda \cdot \|t^*(1-t^*)\|$ | 물리적 경계 조건 강제 |

VGG 기반 perceptual loss가 고주파 난류 구조의 perceptual fidelity를 보장하고, PI Bridge가 시간적으로 부드러운 전환을 강제한다.

## 훈련 데이터 전략

- **RGB multi-channel fluid 데이터**: 3채널 컬러 유체 시뮬레이션
- **Sparse temporal observation**: 전체 타임스텝 중 소수의 anchor frame만 사용
- **Self-supervised**: 프레임 사이의 보간을 학습 목표로 활용

## 실험 결과

| 지표 | L1 Baseline | Temporal U-Net (제안) | 향상 배수 |
|------|-------------|----------------------|----------|
| **MAE** | 0.085 | 0.015 | **5.7×** |
| **Temporal consistency** | strobing 아티팩트 | smooth transition | — |
| **PSD (고주파)** | high-freq loss | high-freq preserved | qualitative |

**Spatial Power Spectral Density (PSD)** 분석에서 고주파 난류 세부 구조가 보존됨을 확인. deterministic reconstruction에서 흔히 손실되는 난류의 미세 스케일을 유지한다.

## 관련 개념

- [[physics-informed]] — Physics-Informed Bridge의 제약 조건 부여 방식
- [[fourier-neural-operator]] — 고주파 유체 구조 포착의 대안적 접근법
- [[physics-informed-neural-networks]] — PINN의 물리 제약 학습 프레임워크
- [[ai-hallucination-physics]] — temporal fluid 재구성에서 hallucination 방지와의 연관성

## References

- arXiv:2604.23372 — "Physics-Informed Temporal U-Net for High-Fidelity Fluid Interpolation"
