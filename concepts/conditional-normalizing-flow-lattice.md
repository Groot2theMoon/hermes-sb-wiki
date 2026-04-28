---
title: Conditional Normalizing Flow (C-NF) for Lattice Field Theory Sampling
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, physics-informed, surrogate-model, paper]
sources: [raw/papers/2207.00980v1.md]
confidence: high
---

# Conditional Normalizing Flow (C-NF) for Lattice Field Theory Sampling

## 개요

Ankur Singha, Dipankar Chakrabarti, Vipul Arora (2022)이 제안한 **Conditional Normalizing Flow (C-NF)**는 격자 장론(lattice field theory)의 **임계 영역(critical region)**에서 **critical slowing down** 문제를 해결하기 위한 생성 모델이다^[raw/papers/2207.00980v1.md]. 비임계 영역에서 생성한 HMC 샘플로 조건부 정규화 흐름을 훈련하여, 임계 영역의 여러 $\lambda$ 값에서 격자 구성을 샘플링할 수 있다.

## 핵심 아이디어

### Conditional Normalizing Flow

- 표준 Normalizing Flow에 **조건 매개변수 $c$** (여기서는 $\lambda$)를 coupling layer에 추가
- $s$와 $t$ 신경망이 $c$와 입력을 함께 받아 affine transformation 수행
- 역변환 가능(invertible)하며 정확한 likelihood 계산 가능

### 훈련 및 샘플링 전략

1. **비임계 영역**에서 HMC로 훈련 데이터 생성 (자기상관 낮음)
2. **Forward KL divergence**로 C-NF 모델 훈련 ($\lambda$ 범위: 3~9, 임계 영역 4.1~5.0 제외)
3. **보간(interpolation) 또는 외삽(extrapolation)**으로 임계 영역의 $\lambda$에 대한 샘플 생성
4. **Independent Metropolis-Hastings** 알고리즘으로 정확한 분포 수렴 보장

### 실험 결과

- 1+1차원 scalar $\phi^4$ 이론으로 검증
- C-NF + MH 조합이 HMC와 일치하는 관측값($\langle \phi^2 \rangle$, $\chi$, $C(t)$) 생성
- Naive C-NF (MH 없음)는 bias 존재하지만 MH로 제거 가능
- 하나의 모델로 **여러 $\lambda$ 값**에서 샘플링 가능 (기존 flow 방법과 차별점)

## 관련 개념

- [[mode-collapse-flow-lattice]] — Flow 기반 샘플링의 mode-collapse 문제
- [[hierarchical-autoregressive-networks]] — 다른 lattice 샘플링 접근법
- **Normalizing Flow** — 생성 모델의 기본 방법론
- **Hybrid Monte Carlo (HMC)** — 기존 lattice 샘플링 알고리즘
- **Critical Slowing Down** — 해결하려는 주요 문제