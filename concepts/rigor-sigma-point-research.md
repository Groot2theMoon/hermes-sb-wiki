---
title: "RIGOR Sigma Point Innovation — Research Landscape & Gap Analysis"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [rigor, sigma-point, ukf, differentiable-filter, state-estimation, research-landscape]
sources:
  - raw/papers/TurRas10_model_based_learning_sigma_points.md
  - raw/papers/majewski26_ma_ukf.md
confidence: high
---

# RIGOR Sigma Point Innovation — Research Landscape

## 개요

RIGOR의 SR-UKF sigma point handling을 개선하기 위한 5가지 아이디어에 대한 기존 연구 조사 결과. 각 아이디어의 선행연구 현황, RIGOR-specific novelty, 구현 우선순위를 정리.

---

## RIGOR 현재 SR-UKF 구현 (rigor_334.py 기준)

현재 RIGOR의 sigma point 처리는 고정 parameterization:

```python
# Line 450-497: 고정 UKF weight (alpha, beta, kappa로 결정)
gamma_raw, w_mean_raw, w_cov_raw = self.ukf_weights

# Line 1081: 고정 scalar gamma spread
spread = gamma * L_prev  # gamma = sqrt(d_state + lambda) — scalar

# Line 1099-1101: sigma point → mean만 추출, dispersion 정보 버림
mu_pred = jnp.dot(w_mean, x_dyn)

# Line 1158-1190: Kalman update는 mean+cov 수준 (per-sigma-point 아님)
K = stable_solve(L_innov_solve, cross_xy).T
mu_f = mu_pred + K @ innov_val
```

---

## 아이디어별 연구 현황

### ① Parametric Differentiable Sigma Point Selection ⭐

**선행연구 3건:**

| 연구 | 방법 | 한계 |
|------|------|------|
| **Turner & Rasmussen (2010)** | Sigma point location 직접 학습 (GP-based) | Overfit 위험, GP-specific, end-to-end 아님 |
| **Dunik, Simandl & Straka (2012)** | Innovation 기반 α 적응 (IEEE TAC) | Heuristic adaptation rule |
| **MS-UKF — Levy & Klein (2026)** | Dimension별 α_i 수동 튜닝 (arXiv:2604.04792) | Non-differentiable, grid search 필요 |

**RIGOR 차별화:** `softplus(spread_d) × L_prev`로 dimension별 spread를 **end-to-end backprop**으로 학습. MS-UKF를 generalizing하면서 수동 튜닝 제거.

- Turner & Rasmussen, C. E. (2010/2012). Model based learning of sigma points in unscented Kalman filtering. *Neurocomputing*, 80, 47-53. [MLSP 2010 → Neurocomputing 2012]
- Dunik, J., Simandl, M., & Straka, O. (2012). Unscented Kalman filter: Aspects and adaptive setting of scaling parameter. *IEEE Trans. Automatic Control*, 57(9), 2411-2416.
- Levy, A. & Klein, I. (2026). Multi-Scaled Unscented Kalman Filter. arXiv:2604.04792.
- MA-UKF (Majewski et al., 2026)는 weight를 adaptive하게 학습 (spread가 아님) — 별도 범주

→ **Novelty 인정. SR-UKF + differentiable spread는 선행연구 없음.**

---

### ② Adaptive Sigma Point Count via LMI Eigenvalues

**직접적 선행연구 없음.** Contraction LMI eigenvalue로 quadrature order를 결정하는 접근은 완전히 새로운 아이디어.

**관련 접근 (직접적 연관 없음):**
- Generalized Gaussian Cubature for nonlinear filtering (AAS 2015): Multi-dimensional cubature, fixed
- Truncated Unscented KF (2012): State dimension 축소 (LMI 기반 아님)
- Strong tracking sigma point filter: Innovation 기반 covariance scaling

**문제점:**
- Contractive 방향에서 sigma point를 줄여도 nonlinearity approximation error 가능성
- v3 benchmark (저차원)에서 point 수 절약 효과 미미 (2n+1=11 → 7~9)
- JAX jitted loop에서 가변 point 수 → padding/masking 필요

→ **Novelty 높음, 실용적 impact 낮음. 보류 권장.**

---

### ③ Sigma Point Trajectory as Implicit Feature

**직접적 선행연구 없음.** Sigma point의 intra-step dispersion (skew/kurtosis)를 NN residual의 conditioning signal로 사용하는 접근은 novel.

**유사 접근 (철학적 유사성, 메커니즘 다름):**
- **Cui, Chen & Tang (2017):** Posterior sigma-point error matrix를 prediction 단계로 재투영 (IEEE TSP, vol. 65, no. 11)
- **KalmanNet (Revach 2022):** Innovation sequence를 RNN encoding
- **MA-UKF (Majewski 2026):** Innovation history를 RNN context로 encoding

**RIGOR 차별화:** `spread_mag, skew, kurt = f(sigma_pred)` → NN residual 입력에 conditioning. 계산 비용 거의 0. NLL blind spot 완화 가능성.

→ **Novelty 높음. ①과 병행 추천.**

---

### ④ Differentiable Sigma Point Weight Learning

**선행연구: MA-UKF (Majewski et al., 2026, FUSION 2026)**
- RNN이 time-varying weight 동적 합성
- Gaussian RMSE 0.71x, Glint RMSE 0.45x (표준 UKF 대비)
- ⚠️ MA-UKF는 dynamics가 fixed/known. RIGOR는 dynamics + SR-UKF jointly 학습 중.

**Cheng & Liu (2011):** Optimized selection of sigma points — 위치와 weight 공동 최적화

→ **단순 learnable weight (2n+1 params)는 novelty 낮음.** MA-UKF가 먼저 함. RIGOR contribution이 되려면 ①+③+④ 결합 시너지 필요.

---

### ⑤ Sigma Point-level Correction (Ensemble Kalman Bridge)

**직접적 선행연구 없음.** UKF의 deterministic sigma point 각각에 per-point Kalman correction 적용.

**관련 접근 (직접적 연관 없음):**
- **EnKF (Evensen 1994):** Ensemble member마다 Kalman-style update — sampling-based
- **Cui et al. (2017):** Posterior sigma-point error transformation — per-point correction 아님
- **Particle filter with UKF proposal:** UKF로 proposal 분포 생성 — proposal 단계, correction과 다름

**이론적 난제:**
1. Per-point K_i perturbation이 Gaussian posterior consistency 보장?
2. `epsilon_theta(sigma_pred[i], mu_pred)` 함수의 inductive bias 설계
3. RIGOR의 K는 least-squares optimal (line 1160-1162). Perturbation이 overfit 위험

→ **장기 research direction. Short-term 실험은 minimal version (K_i = K * (1 + 0.1 * tanh(innov_embed[i]))) 부터.**

---

## 종합 Gap Matrix

```
Idea    선행연구  Novelty   난이도  Impact   추천
────────────────────────────────────────────────────
①       3건       ★★★★☆    낮음    높음    ✅ 즉시
②       0건       ★★★★☆    높음    낮음    ❌ 보류
③       0건       ★★★★★    낮음    중간    ✅ ①과 병행
④       2건       ★★☆☆☆    매우 낮음 중간    ⚠️ 결합 필요
⑤       0건       ★★★★★    매우 높음 높음    📌 장기 과제
```

## References

1. Turner, R. & Rasmussen, C.E. (2012). Model based learning of sigma points in unscented Kalman filtering. *Neurocomputing*, 80, 47-53.
2. Dunik, J., Simandl, M., & Straka, O. (2012). Unscented Kalman filter: Aspects and adaptive setting of scaling parameter. *IEEE Trans. Automatic Control*, 57(9), 2411-2416.
3. Levy, A. & Klein, I. (2026). Multi-Scaled Unscented Kalman Filter. arXiv:2604.04792.
4. Majewski, K. et al. (2026). Robust Unscented Kalman Filtering via Recurrent Meta-Adaptation of Sigma-Point Weights. *FUSION 2026*. arXiv:2603.04360.
5. Cui, B., Chen, X. & Tang, X. (2017). Improved cubature Kalman filter for GNSS/INS based on transformation of posterior sigma-points error. *IEEE Trans. Signal Processing*, 65(11), 2975-2987.
6. Cheng & Liu (2011). Optimized selection of sigma points in the unscented Kalman filter. IEEE.
7. Revach, G. et al. (2022). KalmanNet: Neural Network Aided Kalman Filtering for Partially Known Dynamics. *IEEE Trans. Signal Processing*.
