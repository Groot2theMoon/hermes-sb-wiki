---
title: Differentiable Sigma Point Quadrature — UKF/SR-UKF에서 Sigma Point의 적극적 활용
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [rigor-filter, differentiable-filtering, ukf, sigma-point, unscented-transform, research-idea]
sources: []
confidence: medium
---

## 개요

Standard UKF/SR-UKF에서 sigma point는 **moment 계산을 위한 수단**에 불과하다:
1. $2n+1$개의 sigma point를 생성 ($\sqrt{(n+\lambda)P}$)
2. 비선형 함수 $f$로 전파
3. 전파된 점들로 sample mean / sample covariance 계산
4. 계산된 moment를 Kalman gain에 투입

Sigma point는 전파 후 버려지며, 다음 step에서는 다시 생성된다.

**핵심 질문:** Sigma point를 더 적극적으로 활용할 수 있는가? 특히 [[rigor-filter|RIGOR]]와 같은 differentiable filter에서?

---

## 연구 방향 5가지

### ① Parametric Differentiable Sigma Point Selection ⭐ (추천)

**핵심 아이디어:** Sigma point spread를 고정 $\gamma$ 대신 학습 가능한 함수로 대체

**현재 (standard UKF):**
```python
spread = gamma * L_prev  # 고정 spread
sigma_points = [mu, mu + spread.T, mu - spread.T]
```

**제안:**
```python
# Option A: Dimension별 learnable spread
S_diag = softplus(theta_spread)  # (n,) — 학습 가능
spread = diag(S_diag) @ L_prev   # 방향별 adaptive spread

# Option B: State-dependent spread
delta = MLP_theta(mu_prev, diag(L_prev))  # (n,)
spread = diag(exp(delta)) @ L_prev
```

**장점:**
- 각 state dimension의 불확실성 전파 특성에 맞춰 sigma point 배치 최적화
- Backprop으로 end-to-end 학습 가능
- **RIGOR의 contractivity LMI와 충돌 없음** — spread는 dynamics가 아니라 sigma point initialization만 변경
- Minimal architectural change (5~10줄)

**이론적 연결:** Generalized Gaussian quadrature — UKF sigma point는 특정 weight function에 대한 quadrature rule. 이를 learnable quadrature로 확장.

**참고:** [[square-root-unscented-kalman-filter|SR-UKF]]

---

### ② Adaptive Sigma Point Count via LMI Eigenvalues

**핵심 아이디어:** [[differentiable-lmi-contractivity|RIGOR의 LMI]] eigenvalue를 sigma point 수에 반영

- LMI eigenvalue $\lambda_i$가 작은 방향 → dynamics가 불확실성 증폭 가능성 ↑ → **더 많은 sigma point**
- $\lambda_i$가 큰 방향 → dynamics가 불확실성 수축 → **sigma point 절약**

```python
eigvals = jnp.linalg.eigvalsh(LMI_matrix)
n_points_per_dim = ceil(2 / exp(eigvals))
# 총 sigma point 수: sum(n_points_per_dim) — 가변적
```

**장점:**
- LMI 정보를 loss term 외에 **능동적으로 활용** (RIGOR 특화 contribution)
- Contractive 방향 point 수 줄여 계산량 감소
- Contraction theory + adaptive quadrature 연결

**단점:**
- 가변 sigma point 수 → jitted loop에서 padding 필요
- 구현 복잡도 중간

---

### ③ Sigma Point Trajectory as Implicit Feature

**핵심 아이디어:** Sigma point가 시간에 따라 움직이는 **궤적 자체**를 latent feature로 활용

```python
# Sigma point cloud의 고차 모멘트
spread_magnitude = jnp.std(sigma_pred, axis=0)
skew = jnp.mean(((sigma_pred - mu_pred) / spread_magnitude) ** 3, axis=0)
kurt = jnp.mean(((sigma_pred - mu_pred) / spread_magnitude) ** 4, axis=0) - 3

# NN residual 입력에 skew/kurt 정보 추가 conditioning
augmented_state = jnp.concatenate([mu_pred, skew, kurt])
```

**더 과격한 버전 — Sigma Point Memory:**
```python
# sigma_point[i]의 위치 변화량: t-1→t
sigma_delta = sigma_pred[t] - sigma_pred[t-1]
# delta가 크면 → 해당 영역에서 dynamics가 highly nonlinear
```

**장점:**
- 계산 비용 거의 없음 (이미 sigma_pred 존재)
- 고차 모멘트는 NN residual이 nonlinearity를 인지하는 신호로 작용
- NLL loss collapse 방지 효과

---

### ④ Differentiable Sigma Point Weight Learning

**핵심 아이디어:** $w_{mean}$, $w_{cov}$를 고정 hyperparameter 대신 학습 가능한 parameter로

**현재 (Van der Merwe):**
```python
w_mean = jnp.full((2n+1,), 0.5/(n+lambda))
```

**제안:**
```python
raw_weights = self.learnable_weights  # (2n+1,) — 학습 가능
w_mean = softmax(raw_weights)         # sum=1 보장
w_cov = softplus(raw_weights)         # >0 보장
```

**장점:**
- 엄청 간단 (parameter = 7~31개)
- 직관적 해석 가능: center weight 큼 → 선형 근사 우수; edge weight 큼 → nonlinearity 심함
- RIGOR의 loss landscape에 맞춰 자동 최적 quadrature 탐색

**단점:**
- 단독 novelty 약함 → ①이나 ③과 결합 권장

---

### ⑤ Sigma Point-level Correction (Ensemble Kalman Bridge)

**핵심 아이디어:** Kalman update를 mean/covariance가 아니라 **각 sigma point 단위**로 수행

```python
for i in range(num_sigma):
    innov_i = y - h(sigma_pred[i])
    K_i = K_standard + epsilon_theta(sigma_pred[i], mu_pred)
    sigma_post[i] = sigma_pred[i] + K_i @ innov_i
# 그 다음 mu_post = w_mean @ sigma_post
# L_post = QR(sigma_post - mu_post)
```

**의미:**
- 각 sigma point가 위치에 따라 다른 correction 수신 → linear approx 극복
- Sigma point 자체가 **small ensemble** 역할
- Particle filter의 아이디어 + UKF의 principled initialization

**단점:**
- 구현 복잡도 높음
- Theoretical grounding 약함 (per-sigma-point update의 validity)

---

## 종합 추천: ① + ④ (Parametric Selection + Learnable Weights)

| 기준 | 평가 |
|---|---|
| **Novelty** | ★★★★★ — differentiable filter에서 sigma point 자체를 학습한 연구는 없음 |
| **RIGOR 적합성** | ★★★★★ — contractivity LMI와 orthogonal, minimal change |
| **Feasibility** | ★★★★★ — 50~100줄이면 구현 가능 |
| **Publishability** | ★★★★☆ — "Learnable Quadrature for Differentiable Filtering" clean story |
| **실험 증명 용이성** | ★★★★★ — 기존 benchmark(v3_bullo)에 learnable spread 추가만으로 비교 가능 |

> **참고:** 이 페이지는 [[rigor-filter|RIGOR]] 프로젝트와 관련된 연구 방향 논의 (2026-05-05)를 바탕으로 작성되었다.
