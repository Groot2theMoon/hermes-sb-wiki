---
title: "Kernel Operator-Theoretic Bayesian Filter — Functional Bayesian Filter (FBF) for Nonlinear Dynamical Systems"
created: 2026-05-11
updated: 2026-05-11
type: concept
tags: [kalman-filter, nonlinear-estimation, koopman, kernel-method, bayesian, state-estimation, hybrid-modeling]
sources:
  - raw/papers/kernel-operator-bayesian-filter-2411.00198.md
confidence: high
---

# Kernel Operator-Theoretic Bayesian Filter (FBF / expFBF)

Kan Li, José C. Príncipe — University of Florida, Computational NeuroEngineering Laboratory (CNEL). arXiv:2411.00198, 2024.

## 개요

이 논문은 **Koopman operator theory**와 **reproducing kernel Hilbert space (RKHS)** 이론을 연결하여, 비선형 동역학계에 대한 완전 데이터 기반(data-driven) Bayesian filtering 프레임워크를 제안한다. 핵심 아이디어는 RKHS가 제공하는 **명시적(explicit) 유한 차원 특성 공간**에서 선형 Kalman filter를 적용하여, 원래 입력 공간에서는 비선형인 해를 얻는 것이다.

## 배경: Koopman과 RKHS의 격차

- **Koopman operator theory**: 비선형 동역학을 observable 공간에서 선형 연산자로 표현. 하지만 observable 선택이 성능을 크게 좌우하며, 적절한 observable을 찾는 것이 first-principles 모델링만큼 어려울 수 있음
- **RKHS (kernel methods)**: Gaussian kernel의 universal approximation 성질을 활용해 자동으로 무한 차원 특성 공간을 구성. 그러나 동역학(RKHS에서의 시간 전개)을 적절히 처리하는 방법론이 부족
- **격차**: Koopman은 observable 선택에 민감, kernel method는 동역학 처리에 미흡 — 이 논문은 두 접근법을 통합한 **explicit-space Functional Bayesian Filter (expFBF)**를 제안

## 핵심 방법론

### 1. RKHS에서의 상태 공간 표현

비선형 이산시간 동역학계 $x_{k+1} = f(x_k)$에 대해, RKHS $\mathcal{H}$로의 lifting $\phi: \mathbb{R}^n \to \mathcal{H}$을 정의한다. RKHS에서는 nonlinear transition $f$가 linear operator $F$로 표현된다:

$$\phi(x_{k+1}) = F\phi(x_k), \quad F: \mathcal{H} \to \mathcal{H}$$

### 2. Explicit-Space FBF (expFBF)

Gaussian kernel의 빠른 decay 성질을 이용해, 무한 차원 RKHS를 **수치 적분 (Gaussian quadrature, Taylor series expansion)** 으로 유한 차원 근사:

- Gaussian quadrature (GQ) → 적분 기반 유한 차원 특성 벡터
- Taylor series (TS) expansion → 명시적 특성 맵

이렇게 구성된 유한 차원 Hilbert 공간에서 **classical linear recursive Bayesian estimation (Kalman filter)** 을 적용:

$$\hat{\phi}_{k|k-1} = F_{k-1}\hat{\phi}_{k-1|k-1}$$
$$P_{k|k-1} = F_{k-1}P_{k-1|k-1}F_{k-1}^\top + Q_k$$

그리고 measurement update를 통해 Koopman operator $F_k$를 **온라인으로 적응적 갱신 (adaptive tracking)**

### 3. Koopman vs KAF (expFBF) 비교

| 속성 | Koopman Operator (DMD) | KAF / expFBF |
|------|----------------------|-------------|
| 특성 공간 차원 | unknown → judicious selection 필요 | kernel에 의해 자동 결정 (유한 차원 근사) |
| 데이터 처리 | batch (data-driven + expert knowledge) | online (streaming data) |
| Stationarity 가정 | stationary → observable 선택에 민감 | nonstationary → posterior tracking, robust (최소 분산) |
| 동역학 | nonlinear | nonlinear |
| 적응성 | 낮음 (배치 기반) | 높음 (재귀적 Bayesian update) |

## 기존 KAF 연구와의 연결

이 논문은 CNEL의 kernel adaptive filtering (KAF) 연구 계보의 연장선:
- **KAARMA** (Li & Príncipe, 2015) — RKHS에서의 full state-space representation + learning algorithm
- **FBF** (Li & Príncipe) — 일반 nonlinear Bayesian inference for high-dimensional state estimation
- **Explicit-space KAF** (Li & Príncipe) — GQ/TS로 유한 차원 RKHS 구성 → pre-image problem 회피

## 장점

- **사전 물리 지식 불필요**: 완전 데이터 기반 — 커널만 선택하면 RKHS가 자동으로 특성 공간 구성
- **온라인 적응**: Bayesian filter가 Koopman operator를 실시간 갱신 (nonstationary 환경 적합)
- **Pre-image problem 해결**: 명시적 특성 맵으로 기존 kernel method의 pre-image 탐색 문제 회피
- **낮은 차원으로도 우수한 근사**: Gaussian kernel의 빠른 decay 덕분에 적은 차원으로도 우수한 성능

## 한계

- Gaussian quadrature/Taylor series 근사의 정확도는 상태 차원과 비선형성 정도에 의존
- kernel bandwidth 선택의 민감도
- RKHS가 선형화하는 동역학의 범위가 본질적으로 Gaussian kernel의 보편 근사 성질에 의존

## 관련 페이지
- [[koopman-operator-theory]] — Koopman operator 이론의 기초
- [[kernel-methods]] — 커널 방법론 일반
- [[kalman-filter-koopman-federated]] — UKF 기반 Federated Koopman Learning (유사 Koopman+KF 융합 접근)
- [[conditional-gaussian-koopman-network]] — CGKN: 조건부 Gaussian Koopman Network
- [[square-root-unscented-kalman-filter]] — SR-UKF (RIGOR)
- [[information-koopman-representation]] — Information-theoretic Koopman representation
- [[jose-c-principe]] — José C. Príncipe, CNEL 연구실장
- [[kan-li]] — Kan Li, 제1저자
