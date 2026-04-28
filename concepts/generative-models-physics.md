---
title: Generative Models for Physics — Spin Systems and Lattice Field Theory
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, physics-informed, mathematics, paper, comparison]
sources: [raw/papers/2001.05361v2.md, raw/papers/2006.11868v1.md, raw/papers/2007.07115v2.md]
confidence: medium
---

# Generative Models for Physics

## 개요

생성 모델(generative models)은 통계물리학 및 격자장 이론에서 **MCMC의 한계를 극복하는 도구**로 주목받고 있다. 본 문서는 세 가지 주요 연구를 종합한다: (1) RBM/VAE로 Ising 모델 학습, (2) GAN으로 XY 모델 상전이 탐지, (3) Normalizing flows로 격자장 이론 자유 에너지 추정.

## 1. RBM & VAE for Ising Model

**Francesco D'Angelo & Lucas Böttcher** (2020)^[raw/papers/2001.05361v2.md]

### 방법
- **Restricted Boltzmann Machine (RBM)**: 이분할 그래프, 에너지 기반 확률 모델
- **Variational Autoencoder (VAE)**: 잠재 변수 기반 생성 모델 (convolutional 및 non-convolutional)
- 모든 온도에 대해 **단일 생성 모델** 학습

### 주요 결과
- 자화(magnetization), 에너지, 스핀-스핀 상관관계의 온도 의존성 포착
- RBM 생성 샘플: 온도별 더 균일한 분포
- VAE: convolutional layer가 스핀 상관관계 모델링에 중요
- 손실 함수 근사로 **분할 함수 직접 계산 없이** 학습 모니터링

## 2. GAN for XY Model Phase Transition

**Japneet Singh, Vipul Arora, Vinay Gupta, Mathias S. Scheurer** (2020)^[raw/papers/2006.11868v1.md]

### 방법
- **Conditional GAN (Implicit model)**: 온도 조건부 생성
- **Interpolation trick**: 임계 영역 밖 데이터로 학습 → 임계 영역 샘플 생성
- 대칭성 활용 (물리적 구조 반영)

### 주요 결과
- **Implicit model (GAN)** 이 prescribed model (VAE)보다 격자 간 상관관계 포착에 우수
- **비지도 상전이 탐지**: GAN의 tuning parameter 변화에 대한 민감도(fidelity measure)로 BKT 전이 탐지
- 생성 샘플로 vortex 계산 가능

## 3. Normalizing Flows for Lattice Field Theory

**Kim A. Nicoli et al.** (2020)^[raw/papers/2007.07115v2.md]

### 방법
- **Normalizing flows**: 가역 신경망 $g_\theta$로 단순 사전 분포를 복잡한 목표 분포로 변환
- $p_\theta(\phi) = q_Z(g_\theta^{-1}(\phi)) \cdot |\det J_{g_\theta}^{-1}|$

### 주요 결과
- **자유 에너지 $F = -T \ln Z$의 절댓값 직접 추정** — MCMC는 차분(difference)만 가능
- 엄밀한 오차 추정기 및 점근적 보장
- 2D $\phi^4$ 이론에서 MCMC 기반 방법과 비교 검증
- 압력, 엔트로피 등 열역학적 관측량 계산 가능

## 비교

| 특징 | RBM (Ising) | GAN (XY model) | Normalizing Flow ($\phi^4$) |
|------|-------------|-----------------|---------------------------|
| 모델 유형 | Prescribed (에너지 기반) | Implicit | Prescribed (가역) |
| Likelihood | 계산 가능 | 계산 불가 | 계산 가능 |
| 주요 장점 | 해석 가능성 | 상관관계 포착 | 자유 에너지 직접 계산 |
| 조건부 생성 | 가능 (온도) | 가능 (온도) | 파라미터별 재학습 |

## References

- F. D'Angelo, L. Böttcher, "Learning the Ising Model with Generative Neural Networks", 2020
- J. Singh et al., "Generative models for sampling and phase transition indication in spin systems", 2020
- K.A. Nicoli et al., "Estimation of Thermodynamic Observables in Lattice Field Theories with Deep Generative Models", 2020
- [[unsupervised-phase-transitions]] — 비지도 상전이 탐지 (ML × Physics)
- [[variational-autoencoder]] — VAE 기본 개념
- [[bayesian-uncertainty-vision]] — 생성 모델 불확실성