---
title: Conditional Diffusion Model for LES Super-Resolution in Atmospheric Boundary Layer
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [physics-informed, CFD, fluid-dynamics, surrogate-model, wind-energy, generative-model]
sources: []
confidence: medium
---

# Conditional Diffusion Model for LES Super-Resolution in Atmospheric Boundary Layer

## 개요

Sallam, Fürth (2026)가 제안한 **조건부 확산 확률 모델(Conditional DDPM) 기반 대기경계층(ABL) LES 초해상도(super-resolution)** 기법. coarse한 LES 입력으로부터 고해상도 난류 유동장을 재구성하여, 풍력 에너지 응용에서 LES의 계산 비용을 획기적으로 절감한다.

## 핵심 아이디어

### 생성형 AI 기반 LES 초해상도

고충실도 LES는 계산 비용이 매우 높아 대규모/실시간 적용이 어렵다. 이 연구는 Conditional Denoising Diffusion Probabilistic Models (DDPM)을 사용하여 **저해상도(coarse) LES 입력 → 고해상도(fine) 난류장** 매핑을 학습한다:

1. **고충실도 데이터셋 생성**: 병렬 고차 유한차분 solver로 다양한 지상풍 속도, IEC 풍력 등급 표면 거칠기, 여러 grid 해상도에서 데이터 생성
2. **Super-resolution 훈련**: 다양한 scale factor에 대해 diffusion model 훈련
3. **내삽(interpolation) 및 외삽(extrapolation) 평가**: 훈련 도메인 내 일반화와 더 높은 풍속에 대한 일반화 각각 평가

### 주요 발견

| 시나리오 | 성능 |
|:---|:---|
| **내삽 (interpolation)** | 미세 난류 구조, Reynolds stress, 통계적 특성 정확 복원 — **강한 물리적 일관성** |
| **외삽 (extrapolation, 더 높은 풍속)** | noise 증가, 난류 응력 과대 예측 — **일반화 한계** 노출 |

외삽 시나리오에서의 성능 저하는 생성형 AI 모델이 훈련 분포를 벗어난 조건에서 물리적 일관성을 유지하기 어렵다는 근본적인 한계를 보여준다.

## 연결점

- [[wind-energy-ml]] — 풍력 에너지 분야 AI/ML 응용의 직접적 연장선
- [[physics-informed]] — Diffusion 모델이 물리적 통계량을 복원하는 physics-consistent 생성
- [[denoising-diffusion-probabilistic-models]] — DDPM의 기본 이론
- [[ai-hallucination-physics]] — 외삽 시나리오에서의 물리적 inconsistency와 직접적 연관

## References
- arXiv:2604.26776 — "Conditional diffusion denoising probabilistic model for super-resolution of atmospheric boundary layer large eddy simulation"
