---
title: "RIGOR Sigma Point Innovation — Research Landscape & Gap Analysis"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [rigor, sigma-point, ukf, differentiable-filter, state-estimation, research-landscape]
sources:
  - raw/papers/turras10.md
  - raw/papers/2603.04360v1.md
  - raw/papers/optimized-sigma-points-ukf.md
  - raw/papers/ukf-scaling-adaptive-setting.md
  - raw/papers/aas-2015-423-ukf.md
  - raw/papers/2604.04792v1.md
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
- **Bach et al. (2025):** Set transformer로 ensemble member 간 **암시적(implicit) 상호작용** 학습 (arXiv:2504.17836, J. Comp. Physics). [[unscented-feature-interaction|UFI]]의 Set transformer 대비 **명시적(explicit) pairwise feature** 접근과 비교 핵심 대상.

**③' 확장 — Unscented Feature Interaction (UFI) (제안):**
- Sigma point 간 **pairwise outer product**를 명시적 feature로 NN에 제공
- [[unscented-feature-interaction]] 별도 개념 페이지 참조
- ③의 scalar 통계량 수준을 넘어 **모든 쌍별 기하학적 구조 보존**
- 예상: vel_corr 0.93-0.95 (baseline 0.905, ③: 0.919)

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

### ⑥ Polynomial Measurement Update (NEW — Cherian & Servadio, 2026)

**선행연구:** Cherian & Servadio, arXiv:2603.20259 — Polynomial UKF (PUKF) with CUT.

**핵심 아이디어:** UKF의 측정 업데이트를 **선형(LMMSE)이 아닌 다항식(quadratic/cubic) 함수**로 확장. CUT로 고차 central moment 계산.

**RIGOR 연결:**
- RIGOR의 SR-UKF는 현재 LMMSE만 사용 → differentiable PUKF update로 확장 가능 ($\delta\mathbf{y}^{[2]}$ Kronecker square + augmented gain)
- CUT4 ($O(n^2)$ sigma points)는 ①의 differentiable spread와 독립적 — orthogonal contribution
- Non-Gaussian noise에서 RIGOR 성능 향상 (KKL observer `z` 분포가 비가우시안일 가능성)
- **① (differentiable spread) + ③ (sigma cloud conditioning) + ⑥ (polynomial update)의 조합 가능성** — 각각 sigma point positioning, feature extraction, measurement correction의 독립적 개선

**난이도:** 중간 (augmented covariance block 구현 필요, SR-Cholesky 호환성 확인)
**Impact:** 높음 (non-Gaussian likelihood에서 근본적 개선)
→ **추천: ①/③ 이후 세 번째 우선순위**

---

### ⑦ Higher-Order Correlation UKF — Grothe (2012) ⭐

**선행연구:** Grothe (2012), arXiv:1207.4300. "A higher order correlation unscented Kalman filter."

**핵심 발견:** 표준 UKF/Gaussian filter는 **observation과 correlation이 있는 state만 추정 가능**하다는 근본적 한계. $P_{xy} \\approx 0$인 state (volatility, Bouc-Wen z)는 UKF가 추정하지 못함.

**해결책:** Higher-order correlation (2차 이상 joint moment)을 measurement update에 포함 → continuous-discrete state space에서 explicit formula 유도.

**RIGOR 연결:**
- Bouc-Wen z correlation 문제의 **이론적 해결책을 정확히 명시한 유일한 논문**
- UFI가 현재 heuristic하게 학습하는 것을 Grothe는 analytical formula로 정식화
- **Loss function 수정:** Grothe의 HOC-UKF formula를 UFI regularizer로 사용 가능
- **직접 실현:** UFI + Temporal Encoder의 정보 흐름을 Grothe의 analytical higher-order moment로 가이드

**Bouc-Wen 특화 분석:**
- Bouc-Wen z는 observation y=x와 **linear correlation 0**이지만, **2차 moment (z²-observation)** 는 nonzero (Bouc-Wen의 quadratic nonlinearity)
- Grothe의 HOC-UKF는 이 2차 correlation을 measurement update에 포함
- 현재 UFI가 학습하는 quadratic feature (tensored sigma points)가 이 higher-order correlation을 암시적으로 포착
- 문제는 loss horizon K=4가 이 correlation 학습을 방해 → Grothe의 접근이 loss 구조 개선의 principled한 방향 제시

**관련 접근:**
- [[polynomial-unscented-kalman-filter]] — Servadio & Cherian (2026): Polynomial UKF via CUT. Grothe와 같은 higher-order moment를 활용하지만 measurement update 확장 방식에서 차이.
- [[higher-order-unscented-transform]] — HOUT (4차 moment matching, 2021)

**난이도:** 중간 (moment 계산 공식 구현 필요)
**Impact:** 매우 높음 (z correlation 0.4 → 0.7+ 가능성)
→ **추천: UFI+TE와 병행 연구. loss regularizer로 시작.**

---

## 종합 Gap Matrix

```
Idea    선행연구  Novelty   난이도  Impact   추천
────────────────────────────────────────────────────
| ①       3건       ★★★★☆    낮음    높음    ✅ 즉시
| ②       0건       ★★★★☆    높음    낮음    ❌ 보류
| ③       0건       ★★★★★    낮음    중간    ✅ ①과 병행
| **③' (UFI)** | **0건** | **★★★★★** | **낮음** | **높음** | **✅ 제안**
| ④       2건       ★★☆☆☆    매우 낮음 중간    ⚠️ 결합 필요
| ⑤       0건       ★★★★★    매우 높음 높음    📌 장기 과제
| **⑥ Polynomial Update** | **1건 (Cherian & Servadio 2026)** | **★★★★☆** | **중간** | **높음** | **⏳ ①/③ 이후**\n| **⑦ HOC-UKF (Grothe 2012)** | **1건 (Grothe 2012)** | **★★★★☆** | **중간** | **매우 높음** | **⏳ UFI+TE와 병행**\n| **⑧ Virtual Measurement (TE→pseudo-z→UKF)** | **— (new)** | **★★★★★** | **낮음** | **매우 높음** | **✅ test_E 진행 중: TE pseudo-measurement로 observation augment**\n```
```

## References

1. Turner, R. & Rasmussen, C.E. (2012). Model based learning of sigma points in unscented Kalman filtering. *Neurocomputing*, 80, 47-53.
2. Dunik, J., Simandl, M., & Straka, O. (2012). Unscented Kalman filter: Aspects and adaptive setting of scaling parameter. *IEEE Trans. Automatic Control*, 57(9), 2411-2416.
3. Levy, A. & Klein, I. (2026). Multi-Scaled Unscented Kalman Filter. arXiv:2604.04792.
4. Majewski, K. et al. (2026). Robust Unscented Kalman Filtering via Recurrent Meta-Adaptation of Sigma-Point Weights. *FUSION 2026*. arXiv:2603.04360.
5. Cui, B., Chen, X. & Tang, X. (2017). Improved cubature Kalman filter for GNSS/INS based on transformation of posterior sigma-points error. *IEEE Trans. Signal Processing*, 65(11), 2975-2987.
6. Cheng & Liu (2011). Optimized selection of sigma points in the unscented Kalman filter. IEEE.
7. Revach, G. et al. (2022). KalmanNet: Neural Network Aided Kalman Filtering for Partially Known Dynamics. *IEEE Trans. Signal Processing*.
8. Bach, E. et al. (2025). Learning Enhanced Ensemble Filters. *J. Comp. Physics*. arXiv:2504.17836. — Set transformer 기반 implicit ensemble interaction (③ 유사 접근)
9. Cherian & Servadio (2026). Polynomial Updates for the Unscented Kalman Filter. arXiv:2603.20259. — **⑥ Polynomial Update**의 선행연구
10. Grothe, O. (2012). A higher order correlation unscented Kalman filter. arXiv:1207.4300. — **⑦ HOC-UKF**: observation과 uncorrelated인 state 추정을 위한 higher-order measurement update
11. Liu, W., Lai, Z., Bacsa, K. & Chatzi, E. (2022). Neural Extended Kalman Filters for Learning and Predicting Dynamics of Structural Systems. *Structural Health Monitoring*, 2023. arXiv:2210.04165. — Neural EKF: learnable EKF for SHM
12. Oh, S., Song, J. & Kim, T. (2024). Deep learning-based modularized loading protocol for parameter estimation of Bouc-Wen class models. arXiv:2411.02776. — CNN-based Bouc-Wen parameter ID

## Wikilinks
- [[differentiable-sigma-point-quadrature]] — RIGOR sigma point quadrature
- [[ma-ukf-meta-adaptive]] — MA-UKF
- [[ukf-learning-sigma-points]] — UKF-L
- [[multi-scaled-ukf]] — MS-UKF
- [[optimized-sigma-points-n-plus-1]] — Minimal sigma points
- [[generalized-gaussian-cubature]] — GGC
- [[ukf-scaling-adaptive-dunik]] — Adaptive scaling
- [[rigor-filter]] — RIGOR 실험 로그 포함
- [[higher-order-unscented-transform]] — HOUT (4차 moment matching, 2021)
- [[adurthi-singla-higher-order-unscented-estimator]] — HOUE (closed-form, 2021)
- [[unscented-feature-interaction]] — UFI (③' 확장, sigma point pairwise feature)
- [[polynomial-unscented-kalman-filter]] — ⑥ Polynomial Update with CUT (Cherian & Servadio 2026)
- [[robust-sigma-point-kalman-filter]] — Robust Sigma Point KF: Minimax Approach (Yi & Zorzi, 2025)
- [[exact-affine-conditioning-ensemble-kalman-update]] — Exact Affine Conditioning beyond Gaussians (Jorgensen & Marzouk, 2025)
- [[set-transformer]] — Set Transformer: Attention-based Permutation-Invariant NN (Lee et al., 2019)
- [[robust-filter-attention]] — Robust Filter Attention: Self-Attention as Parallel Filter (Racioppo, 2025)

## Experiment Updates (2026-05-05)

### Tested Approaches on VDP μ=1.0

| Priority | Idea | Status | Result |
|----------|------|--------|--------|
| ① Differentiable per-state spread | ✅ Tested | vel_corr=0.899 (≈baseline), RMSE 개선(0.798→0.742) |
| ② LMI-aware adaptive point count | ❌ 보류 | 실용적 impact 낮음 |
| ③ Sigma point trajectory regularizer | ✅ Tested | vel_corr=0.920 (최고), pos_corr 희생 |
| ④ Learnable sigma weights | ⚠️ 결합 필요 | 단독 novelty 낮음 |
| ⑤ Per-sigma-point correction | 📌 장기 | risk 높음 |
| **③' UFI (Unscented Feature Interaction)** | **✅ 제안** | **예상: vel_corr 0.93-0.95** |

### New: Sigma Cloud Conditioning (v4.3, 2026-05-05)
→ Sigma point의 pre-dynamics std + skewness를 NN residual의 추가 입력으로 사용.
→ vel_corr=0.919 (baseline 0.905 대비 개선) 확인했으나 pos_corr 희생.

### Key Insight
근본적 한계: **position NLL만으로 velocity 비선형성을 covariance를 통해 간접 학습하는 SR-UKF 구조의 정보 병목.** 해결 방향:
1. Loss 구조 개선 (rollout NLL, innovation whiteness)
2. 구조적 확장 (parameter-conditioned A+NN)
3. Delay embedding (Takens)으로 관측 정보 augment
4. **UFI (③' Unscented Feature Interaction)** — sigma point 간 pairwise 상호작용을 명시적 특징으로 NN 제공. [[unscented-feature-interaction]] 참조.
5. **[[rigor-geometry-of-memory-integration]]** — Sentra+MIT "Geometry of Memory" 3부작 접목: $d_{\text{eff}}$ 진단, GAC-inspired adaptive UFI, Phase 2 residual 재해석.
