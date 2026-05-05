---
title: "Higher-Order Unscented Transform — 4th Moment Matching for Sigma Points"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [sigma-point, ukf, unscented-transform, skewness, kurtosis, tensor-decomposition, quadrature, nonlinear-filtering, rigorous-math]
sources:
  - raw/papers/2006.13429v1.md
confidence: high
---

# Higher-Order Unscented Transform (HOUT)

**Easley & Berry** (George Mason University, 2021). arXiv:2006.13429. *SIAM/ASA JUQ*.

## 개요

표준 Scaled Unscented Transform (SUT = UKF의 sigma point 배치)는 mean + covariance (2차 moment)만 matching → skewness=0, kurtosis는 implicit Gaussian. **HOUT는 rank-1 tensor decomposition으로 skewness(3차) + kurtosis(4차)까지 matching하는 sigma point + weight set을 구성.** Degree of exactness = 4 (임의의 4차 다항식까지 정확). 계산 overhead: CP decomposition (non-minimal but provably convergent).

## 핵심 문제

SUT의 한계:
- 대칭적 sigma point → skewness 항등적으로 0
- 3차 이상 moment는 Gaussian assumption으로 근사 → heavy-tailed 분포, 비대칭 dynamics에서 부정확
- 비선형성이 강한 시스템에서 "sigma point collapse" — 모든 점이 mean 근처에 몰림

## 핵심 수학: Rank-1 Tensor Decomposition

SUT는 covariance matrix의 eigenvalue decomposition: $P = \sum \lambda_i v_i v_i^T$ → $\sigma_i = \mu \pm \sqrt{\lambda_i} v_i$

HOUT는 skewness tensor $S_{ijk}$ (3-tensor), kurtosis tensor $K_{ijkl}$ (4-tensor)에 대해 rank-1 decomposition:
- $S \approx \sum_{i=1}^J v_i \otimes v_i \otimes v_i$ (3rd order)
- $K \approx \sum_{i=1}^L s_i u_i \otimes u_i \otimes u_i \otimes u_i$ (4th order)

Eigenvector-like 방향 $v_i, u_i$에 대응하는 sigma points 추가 → **asymmetric sigma point set** → skewness ≠ 0

### 알고리즘 (Algorithm 4.1)

```
HOUT(μ, C, S, K, f, τ):
  1. S ≈ Σ v˜ᵢ^⊗³ (rank-1 decomposition, tolerance τ/2)
  2. K ≈ Σ sᵢ u˜ᵢ^⊗⁴ (rank-1 decomposition, tolerance τ/2)
  3. C̃ = Σ sᵢ u˜ᵢ^⊗²  →  δ > √(λ_max(C̃)/λ_min(C))
  4. Ĉ = C - δ^{-2} C̃  (positive definite)
  5. β, γ, α bound 계산
  6. 4-moment σ-points 생성 (Definition 4.1)
  7. Output: Σ wᵢ f(σᵢ)  (degree-4 exact)
```

## 증명된 성질

1. **Exact on polynomials ≤ degree 4** (Thm 4.2 + Corollary 4.3)
2. Mean + covariance exactly matched; skewness + kurtosis matched up to tolerance τ
3. Convergence of approximate rank-1 decomposition proved **linear** — 기존 문헌에서는 증명 없었음
4. $N = 2(d + J + L)$ points → SUT의 $2n+1$보다 많지만, 2D 문제에서는 소수 개 추가

## RIGOR 적용 가능성

**현재 RIGOR 문제:** `sigma_cond`에서 skewness 계산 → 항상 0

**HOUT 적용 시:**
1. SUT → HOUT sigma point set으로 대체
2. HOUT의 CP decomposition은 JAX differentiable 구현 가능 (power method 기반)
3. Asymmetric sigma points → non-zero skewness → NN conditioning에 의미 있는 정보 전달
4. 2D VDP에서 overhead 미미 (J+L small)

**실제 구현 challenge:**
- CP decomposition of 3-tensor, 4-tensor → JAX-friendly algorithm (HOPM)
- `softplus`로 positivity constraint handling
- Search over `γ` hyperparameter 영향 평가

## Wikilinks
- [[adurthi-singla-higher-order-unscented-estimator]] — HOUE (closed-form 대안)
- [[generalized-gaussian-cubature]] — GGC (arbitrary order cubature)
- [[ukf-learning-sigma-points]] — UKF-L (learned placement)
- [[rigor-sigma-point-research]] — RIGOR sigma point 연구 로드맵

## References
- Easley, D. & Berry, T. (2021). A Higher Order Unscented Transform. arXiv:2006.13429. *SIAM/ASA Journal on Uncertainty Quantification*.
