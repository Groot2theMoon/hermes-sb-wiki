---
title: Polynomial Unscented Kalman Filter — PUKF/QUKF/CUT Higher-Order Measurement Update
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [kalman-filter, state-estimation, sigma-point, nonlinear-filtering, unscented-transform, rigorous-math]
sources:
  - raw/papers/2603.20259v1.md
confidence: high
---

# Polynomial Unscented Kalman Filter (PUKF/QUKF/CUT)

**Cherian & Servadio** (Iowa State University, 2026). arXiv:2603.20259. 38 pages, 9 figures.

## 개요

기존 UKF의 measurement update는 **state estimate가 measurement의 affine (선형) 함수**로 제한됨 (= Linear MMSE). 이 논문은 **polynomial Bayesian update**로 확장하여, measurement update가 state-measurement relation의 **curvature를 포착**할 수 있도록 함. CUT (Conjugate Unscented Transformation)으로 고차 central moment를 정확히 계산.

## 핵심 문제

UKF는 sigma point로 nonlinear dynamics를 잘 전파하지만, **measurement update는 여전히 선형**:

$$\hat{\mathbf{x}}^+ = \hat{\mathbf{x}}^- + \mathbf{K}(\mathbf{y} - \hat{\mathbf{y}}^-)$$

→ 비선형 측정 모델 $h(\mathbf{x})$에서 curvature가 강할 때 bias 발생. 비대칭/heavy-tailed noise에서 covariance inconsistency.

## Polynomial MMSE Estimator

### Optimal Quadratic Estimator (QMMSE)

$$\hat{\mathbf{x}}^+ = \mathbf{A} + \mathbf{B} \delta\mathbf{y} + \mathbf{C} \delta\mathbf{y}^{[2]}$$

여기서 $\delta\mathbf{y}^{[2]} = \delta\mathbf{y} \otimes \delta\mathbf{y}$ (Kronecker square). Orthogonality principle로 optimal constants $\mathbf{A}^*, \mathbf{B}^*, \mathbf{C}^*$ 결정:

$$\mathbb{E}[(\mathbf{x} - \hat{\mathbf{x}}^+) \cdot \psi(\delta\mathbf{y})^T] = 0$$

→ **augmented Kalman gain** $\tilde{\mathbf{K}} = \mathbf{P}_{xy}^{aug} (\mathbf{P}_{yy}^{aug})^{-1}$의 형태로 정리됨. 여기서 $\mathbf{P}_{xy}^{aug}$와 $\mathbf{P}_{yy}^{aug}$는 $\delta\mathbf{y}$와 $\delta\mathbf{y}^{[2]}$를 포함하는 block-wise covariance.

### Arbitrary-order Polynomial (PAUKF)

$N$차 polynomial update로 일반화:

$$\hat{\mathbf{x}}^+ = \sum_{i=0}^N \mathbf{K}_i \delta\mathbf{y}^{[i]}$$

증가하는 차수에 따라 MMSE에 점근적 수렴. 단, 실용적으로는 quadratic (2차) 또는 cubic (3차)에서 saturation.

## CUT (Conjugate Unscented Transformation)

### 필요성

Polynomial update는 4차 이상의 central moment 필요. Standard UT (3차 정확도, $2n+1$ points)로는 부정확. CUT는 **conjugate-symmetric sigma point set**으로 임의 차수까지 moment matching.

| CUT Rule | Moment Matching | Point Count | 용도 |
|----------|----------------|-------------|------|
| UT (CUT2) | 2nd (covariance) | $2n+1$ | Baseline UKF |
| CUT4 | 4th (kurtosis) | $O(n^2)$ | Quadratic update |
| CUT6 | 6th | $O(n^3)$ | Cubic update |
| CUT8 | 8th | $O(n^3)$ | Higher-order |

### 핵심 원리

CUT는 conjugate tuples (axis-aligned signed permutations)로 sigma point 구성:

- Zero-mean Gaussian $\boldsymbol{\xi} \sim \mathcal{N}(\mathbf{0}, \mathbf{I})$에 대해 $n$차원 conjugate points $\boldsymbol{\xi}^{(i)}$ 생성
- 모든 odd moment는 symmetry로 항등적 소멸
- Even moment (4th, 6th, 8th)는 moment constraint equation으로 exact matching
- Radii와 weights는 **차원 독립적** → 1회 계산으로 모든 차원 재사용 가능
- CUT4 기준 $O(n^2)$ points = Gauss-Hermite ($e^n$) 대비 실용적

## Filter Hierarchy

| Filter | Measurement Update | Moment Propagation | Noise Model |
|--------|-------------------|-------------------|-------------|
| **UKF** | Linear (LMMSE) | UT (3rd order) | Additive |
| **QUKF** | Quadratic (QMMSE) | UT | Additive |
| **QAUKF** | Quadratic (QMMSE) | Augmented UT | Non-additive (embedded) |
| **QACUKF-4** | Quadratic (QMMSE) | CUT4 ($O(n^2)$) | Augmented |
| **CACUKF-6** | Cubic (CMMSE) | CUT6 ($O(n^3)$) | Augmented |
| **PACUKF-8** | Polynomial (PMMSE) | CUT8 ($O(n^3)$) | Augmented |

**Augmented formulation**이 중요: noise도 sigma point에 포함시켜 noise의 고차 moment까지 전파.

## 실험 결과

### Scalar Toy Problem
- Polynomial update (Q/C) → nonlinear MMSE 곡선을 더 잘 근사
- UKF (LMMSE): 직선 → bias 큼
- QACUKF-4: true QMMSE에 거의 근접
- CACUKF-6: true CMMSE와 동등
- **Accuracy gain:** UKF 대비 ~25% RMSE 개선

### Clohessy-Wiltshire (Linear Dynamics + Nonlinear Measurement)
- Linear dynamics → state PDF는 정확히 Gaussian 유지
- **비-Gaussian noise** (discrete multimodal)에서 차이 발생
- QUKF와 QCUKF-4의 error std가 UKF 대비 **현저히 낮음**
- Consistent covariance: estimated vs actual covariance 일치

### Circular Restricted 3-Body Problem (CR3BP, Halo Orbit)
- 가장 강한 nonlinearity + Gaussian noise
- 고차 필터 (CACUKF-6)가 consistent covariance 유지하며 best accuracy
- Process noise의 Gaussianity 아래에서는 차이가 작지만, non-Gaussian noise에서 격차 확대

## RIGOR 연결점

### ① Polynomial Measurement Update in SR-UKF
RIGOR의 SR-UKF는 현재 **LMMSE (선형)** update만 사용. QUKF/QACUKF의 quadratic update를 **differentiable SR-UKF에 통합** 가능:
- $\delta\mathbf{y}^{[2]}$ term 추가 → Kronecker square 연산
- Augmented covariance $\mathbf{P}_{yy}^{aug}$ block 구조 → SR-UKF의 Cholesky factor와 호환성 확인 필요
- JAX autograd로 polynomial gain $\mathbf{K}_i$ 학습? → 논문은 closed-form이지만 RIGOR는 learned gain도 가능

### ② CUT as Alternative Sigma Point Strategy
RIGOR의 sigma point 혁신 candidate:
- 기존: 고정 scalar gamma spread
- CUT: higher-order moment matching으로 spread 자동 조정
- CUT4 ($O(n^2)$) vs standard UT ($2n+1$) → 6D에서 2n+1=13 vs O(36) = acceptable tradeoff
- KKL observer의 lifted space에서 CUT 적용 가능?

### ③ Noise-Adaptive Augmentation
RIGOR의 EM noise covariance 추정 + QUKF의 augmented formulation 조합:
- Noise의 고차 moment (skewness, kurtosis)를 EM 추정에 포함
- Non-Gaussian noise (multimodal, heavy-tailed)에서 RIGOR 성능 향상 예상

## 한계
- Quadratic 이상 order → 점증적 이득 감소 (cubic 이상부터 saturation)
- $O(n^2)$ CUT4는 10D 이상에서 부담 (100+ sigma points)
- Single-mode Gaussian approximation 유지 → severe multimodality에서는 particle filter에 미치지 못함
- Differential Algebra (DA) 기반 STT보다 구현 복잡도는 낮지만, CUT rule derivation 필요

## 관련 페이지
- [[higher-order-unscented-transform]] — HOUT (Easley & Berry): rank-1 tensor decomposition으로 4th moment matching. CUT와 다른 접근.
- [[adurthi-singla-higher-order-unscented-estimator]] — HOUE: closed-form polynomial UKF (Stojanovski & Savransky). PUKF보다 제한된 형태.
- [[square-root-unscented-kalman-filter]] — RIGOR의 SR-UKF base
- [[rigor-sigma-point-research]] — RIGOR sigma point 혁신 로드맵
- [[generalized-gaussian-cubature]] — 고차 cubature rule (Jenkins & Ma)

## References
- arXiv: 2603.20259
- Cherian & Servadio, "Polynomial Updates for the Unscented Kalman Filter", 2026
- Adurthi et al. — CUT foundation [39-41]
