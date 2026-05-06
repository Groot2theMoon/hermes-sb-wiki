---
title: "Unscented Feature Interaction (UFI) — Sigma Point Pairwise Features for Neural Residual"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [rigor, sigma-point, ukf, differentiable-filter, state-estimation, research-idea, feature-engineering, vdp]
confidence: medium
sources:
  - raw/papers/wu25-dkfnet.md
  - raw/papers/bach25-enhanced-ensemble-filter.md
---

# Unscented Feature Interaction (UFI)

## 개요

**UFI (Unscented Feature Interaction)** 는 SR-UKF의 sigma point 집합에서 **pairwise 기하학적 상호작용**을 명시적으로 추출하여 neural network residual의 입력 특징으로 제공하는 방법. 기존의 sigma point 평탄화(flatten) 접근법이 1차 정보(sigma point 위치)만 전달하는 데 비해, UFI는 sigma point 간의 **2차 상호작용(quadratic interaction)** 을 구조적으로 추가한다.

## 동기: MLP의 VDP 학습 한계

Van der Pol oscillator (VDP μ=1.0)의 dynamics:

```
dx/dt = y
dy/dt = μ(1 − x²)y − x
```

VDP의 핵심 비선형성 `x²y`는 **sharp decision boundary (x=±1)** + **cubic nonlinearity** 의 조합:

| x | 영역 | dy/dt 부호 |
|---|------|:----------:|
| x < 1 | amplification | dy/dt > 0 |
| x > 1 | damping | dy/dt < 0 |

MLP (GELU activation)가 이 구조를 학습하는 데는 세 가지 근본적 한계가 있음:

| 필요 연산 | MLP 표현 방식 | 비용 |
|----------|--------------|:----:|
| x² | GELU 2개 조합으로 근사 | ~2 layer |
| x²y | x²×y의 곱셈을 암시적 학습 | ≥3-4 layer |
| Sharp boundary (x=±1) | GELU의 exp-smooth 전이 | 많은 뉴런 필요 |

→ MLP는 VDP를 "억지로" 근사할 수 있지만, `x²y`를 암시적 재발견해야 하므로 비효율적. (관련: [[rigor-filter]] VDP benchmark)

## 방법

### 현재 (기존 sigma point 처리)

```
sigma_points (5 × d_state) → flatten (5·d_state) → NN residual
```

### UFI (제안)

```
sigma_points (5 × d_state)
    │
    ├─→ flatten → 1차 특징 (10-dim for d=2)
    │
    └─→ 편차 계산: δ_i = sigma_point[i] - μ        (5 × 2)
       └─→ pairwise outer product: δ_i ⊗ δ_j        (C(5,2) = 10쌍)
          └─→ 각 쌍 = 2-dim (element-wise product) → 20-dim
             └─→ concat → 30-dim 총 특징 → NN residual
```

### 구체적 구현 (JAX)

```python
from itertools import combinations

def ufi_features(sigma_points, mu_pred):
    """Sigma point pairwise interaction features.

    Args:
        sigma_points: (n_sigma, d_state) — sigma points after dynamics
        mu_pred: (d_state,) — predicted mean

    Returns:
        features: (n_ufi_features,) — concatenated pairwise interactions
    """
    n_sigma, d_state = sigma_points.shape
    diffs = sigma_points - mu_pred[None, :]  # (n_sigma, d_state)

    # Pairwise element-wise products
    pairs = []
    for i, j in combinations(range(n_sigma), 2):
        # δ_i ⊙ δ_j (element-wise, preserves geometric structure)
        pairs.append(diffs[i] * diffs[j])  # (d_state,)

    quad_features = jnp.concatenate(pairs)  # (C(n_sigma,2) × d_state,)
    base_features = sigma_points.reshape(-1)  # (n_sigma × d_state,)

    return jnp.concatenate([base_features, quad_features])
```

VDP (d_state=2, n_sigma=5) 기준:
- Base: 5×2 = 10-dim
- UFI: C(5,2)×2 = 10×2 = 20-dim
- **총: 30-dim** (기존 10-dim 대비 3배)

## 이론적 정당성

### UT와의 철학적 연속성

| 방법 | moment 정확도 | 특징 제공 방식 |
|------|:-----------:|:-------------:|
| 표준 UT (EKF 대비) | 2차까지 정확 | weight로 인코딩 |
| HOUT (Adurthi & Singla 2021) | 4차까지 정확 | 더 많은 sigma point |
| **UFI (제안)** | 2차 정보를 **명시적 특징**으로 | sigma point 간 상호작용을 NN에 전달 |

UFI는 UT가 이미 보장하는 **2차 moment 정보를 NN이 재발견할 필요 없이** 직접 제공한다:

- UT: sigma point의 가중합으로 **2차 moment까지 정확한** mean/cov 추정
- UFI: 동일한 sigma point에서 **pairwise 편차 곱 = 공분산 유사 정보**를 추출
- NN은 이 2차 특징을 활용해 `x²y` 같은 **cubic nonlinearity를 선형 조합으로 표현** 가능

### Sigma Cloud Conditioning (wiki ③)과의 차이

| 방법 | 특징 | 정보 보존 | 계산 비용 |
|------|------|:--------:|:--------:|
| Sigma Cloud (wiki ③) | std, skew, kurtosis **scalar 통계량** | ❌ 분산 정보 압축/손실 | 낮음 |
| **UFI (제안)** | Per-pair **기하학적 구조 보존** | ✅ 모든 쌍별 상호작용 보존 | 중간 |

### HOUT과의 직교성

UFI와 HOUT은 서로 다른 차원에서 접근:

```
HOUT: O(n²) sigma point → 더 높은 moment → 더 정확한 UT 전파
UFI:  O(n) sigma point 유지 → pairwise interaction을 NN이 학습
```

→ UFI + HOUT 조합 가능 (4차 moment를 포함한 sigma point 집합에 UFI 적용)

## 관련 RIGOR 아이디어와의 관계

[[rigor-sigma-point-research]] Gap Matrix에서 UFI의 위치:

| Idea | 선행연구 | Novelty | 난이도 | Impact |
|------|:------:|:-------:|:-----:|:-----:|
| ③ Sigma Cloud Conditioning | 0건 | ★★★★★ | 낮음 | 중간 |
| **③' UFI (제안)** | **0건** | **★★★★★** | **낮음** | **높음** |
| ① Diff. per-state spread | 3건 | ★★★★☆ | 낮음 | 높음 |

UFI는 ③의 자연스러운 확장. ①과 결합 시 시너지 예상.

## 예상 효과

| 메트릭 | v3_bullo baseline | Sigma Cloud (③) | UFI (예상) |
|--------|:----------------:|:--------------:|:---------:|
| vel_corr | 0.905 | 0.919 | **0.93-0.95** |
| RMSE | 0.798 | ~0.74 | **0.65-0.70** |
| 추가 파라미터 | 0 | ~5 | ~0 (feature만 확장) |

## References

### Sigma Point / Unscented Transform

[1] Easley, D. & Berry, T. (2021). A Higher Order Unscented Transform. *SIAM/ASA J. UQ*, 9(3). [arXiv:2006.13429](https://arxiv.org/abs/2006.13429) — 4th moment matching UT, UFI의 철학적 기반

[2] Adurthi, N. & Singla, P. (2021). Higher-Order Unscented Estimator. *J. Guidance, Control, and Dynamics*. — HOUE, asymmetric sigma points + closed-form weights

[3] Turner, R. & Rasmussen, C.E. (2012). Model based learning of sigma points in UKF. *Neurocomputing*. — UKF-L, sigma point 위치 학습

### Differentiable Filter + Sigma Point Feature Learning

[4] Majewski, K. et al. (2026). Robust Unscented Kalman Filtering via Recurrent Meta-Adaptation of Sigma-Point Weights. *FUSION 2026*. [arXiv:2603.04360](https://arxiv.org/abs/2603.04360) — MA-UKF, adaptive sigma point weight (UFI와 직교)

[5] Bach, E. et al. (2025). Learning Enhanced Ensemble Filters. *J. Comp. Physics*. [arXiv:2504.17836](https://arxiv.org/abs/2504.17836) — Set transformer로 ensemble member 간 **암시적 상호작용** 학습. UFI의 **명시적 feature 접근과 직접 비교 대상**

[6] Chen, Y. et al. (2021). Auto-differentiable Ensemble Kalman Filters. *SIAM J. Sci. Comp.* [arXiv:2107.07687](https://arxiv.org/abs/2107.07687) — AD-EnKF

[7] Wu, Y. & He, S. (2025). DKFNet: Differentiable Kalman Filter for Field Inversion and Machine Learning. [arXiv:2509.07474](https://arxiv.org/abs/2509.07474) — Adjoint-based differentiable KF

### VDP + Neural Dynamics

[8] SKANODE (2025). Structured Kolmogorov-Arnold Neural ODEs. [arXiv:2506.18339](https://arxiv.org/abs/2506.18339) — KAN이 VDP cubic term(x²y)을 자연스럽게 표현, UFI 가정 간접 검증

### 관련 wiki 페이지

- [[rigor-sigma-point-research]] — RIGOR Sigma Point Innovation: Gap Matrix
- [[higher-order-unscented-transform]] — HOUT (4차 UT)
- [[adurthi-singla-higher-order-unscented-estimator]] — HOUE
- [[rigor-filter]] — RIGOR SR-UKF VDP benchmark
- [[ma-ukf-meta-adaptive]] — MA-UKF
- [[auto-diff-data-assimilation]] — Auto-differentiable data assimilation
