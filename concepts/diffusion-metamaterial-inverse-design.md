---
title: Guided Diffusion for Inverse Design of Mechanical Metamaterials
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [physics-informed, model, paper, generative-model, mechanical-engineering, inverse-design]
sources: [raw/papers/2401.13570v2.md]
confidence: high
---

# Diffusion-based Inverse Design of Mechanical Metamaterials

## 개요

**Yang, Wang, Zhai et al.** (USTC / BAAI, 2024)는 **self-conditioned diffusion model**을 사용하여 복셀(voxel) 기반 기계적 메타물질의 **초고속 역설계(inverse design)**를 구현했다^[raw/papers/2401.13570v2.md]. $128^3$ 해상도에서 0.42초 만에 목표 균질화 탄성 텐서(homogenized elasticity tensor)에 근접하는 미세구조를 생성한다.

## 핵심 방법론

### Self-Conditioned Diffusion Model

DDPM 프레임워크에서 U-Net이 $x_0$를 직접 예측하는 **$x_0$-prediction** 방식을 사용하며, self-conditioning 기법으로 이전 예측 $\hat{x}_0^t$를 추가 입력으로 활용한다.

**조건부 생성:** 목표 탄성 텐서 $(C_{11}, C_{12}, C_{44})$와 체적 분율(volume fraction)을 sinusoidal embedding으로 인코딩하여 classifier-free guidance로 주입.

**3D U-Net:** $64^3 \to 32^3 \to 16^3 \to 8^3 \to 4^3$의 5레벨 구조, 각 레벨에 ResNet + Self-Attention 블록.

### Active Learning Data Augmentation

초기 데이터셋의 한계(특정 모듈러스 범위만 커버)를 극복하기 위해 **active learning** 루프 도입:
1. 현재 diffusion model로 생성 → 2. 연결성/경계 조건 검증 후 클리닝 → 3. 클린된 데이터를 학습셋에 추가 → 4. 재학습

3사이클 후 144,054개의 미세구조 → 균일 분포 확보를 위해 21,212개로 다운샘플링.

## 주요 성능

| 지표 | 값 |
|:-----|:---|
| 해상도 | $128^3$ (저장은 $64^3$, cubic symmetry) |
| 생성 시간 | **0.42초** (NVIDIA RTX 3090) |
| 평균 상대 오차 | 3.08% (best-of-4: 1.30%) |
| 유사도 (vs. 학습셋) | 평균 93.48% |
| 다양성 (생성 간) | 평균 79.07% |

## 세 가지 응용

### 1. 극한 물성 탐색 (Approaching Extremum)

Diffusion model이 생성한 초기 구조를 topology optimization으로 fine-tuning:
- **음의 Poisson's ratio:** 데이터셋 최소 -0.560 → 생성된 초기치 -0.544 → 최적화 후 **-0.629**
- **최대 Young's modulus:** Hashin-Shtrikman bound에 근접
- **최대 Shear modulus:** HS bound에 근접, 등방성 유지

### 2. 미세구조 보간 (DDIM Interpolation)

Noise latent space에서 구면 보간(spherical interpolation)으로 시작-끝 구조 사이의 연속적 전이 시퀀스 생성. Universal guidance로 bulk modulus가 HS bound에 가까운 구조군(family) 생성 가능.

### 3. Multiscale Design

생성 모델을 이용한 $40 \times 40 \times 40$ 기계적 투명 망토(mechanical cloak) 설계 — 변위 왜곡을 34.3% → 4.12%로 감소.

## 융합 도메인 연결

- [[score-based-generative-modeling-sde]] — Diffusion model의 연속시간 SDE 기반
- [[diffusion-lattice]] — Lattice field theory에서의 diffusion 응용과 방법론적 유사성
- 메타물질 역설계에 AI/ML을 접목한 대표적 사례

## References

- Yang, Y., Wang, L., Zhai, X., et al. (2024). Guided Diffusion for Fast Inverse Design of Density-based Mechanical Metamaterials. arXiv:2401.13570.
- [[denoising-diffusion-probabilistic-models]]
- [[score-based-generative-modeling-sde]]
