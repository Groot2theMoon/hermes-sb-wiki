---
title: "RIGOR Loss Structure — VFE + K-step Plain MSE: 이론적 정당화"
created: 2026-05-15
updated: 2026-05-15
type: concept
tags: [rigor, loss-function, theory, vfe, rollout, kl-divergence, spectral-radius, q-inverse]
sources: []
confidence: high
---

# RIGOR Loss Structure — VFE + K-step Plain MSE: 이론적 정당화

> **핵심 주장:** `Q^{-1}` weight는 1-step dynamics consistency에는 정보이론적으로 정확하지만, K-step에서는 `Q_K \neq Q`로 인해 부정확해진다. 따라서 K-step rollout은 plain MSE + tuned λ가 실용적 최선이다.

---

## 1. 최종 Loss 구조

$$
\mathcal{L}_{\text{total}} = \underbrace{\text{NLL} + \text{KL}_{\text{cov}} + \text{KL}_{\text{1step}}(Q^{-1})}_{\text{VFE (exact ELBO)}} \;+\; \lambda \cdot \underbrace{\text{MSE}_{\text{rollout},K}}_{\text{plain, no }Q^{-1}}
$$

| 항 | Weighting | 출처 | 역할 |
|:--|:---------:|:----|:-----|
| **NLL** | $S_t^{-1}$ (innovation cov) | VFE accuracy | 관측 정확도 |
| **KL_cov** | $Q^{-1}$ (log-det) | VFE complexity | Q self-regulation |
| **KL_1step** | $Q^{-1}$ | VFE mean term | 1-step dynamics consistency (principled) |
| **rollout_K** | **None (plain MSE)** | 외부 함수 | K-step dynamics consistency |

---

## 2. VFE의 유도 — 3개 항의 기원

### 2.1 Variational Free Energy

ELBO의 negative = VFE:

$$\mathcal{F} = \mathbb{E}_{q(x_{0:T})}\left[ \log q(x_{0:T}) - \log p(y_{0:T}, x_{0:T}) \right]$$

Filtering recursion + mean-field factorization:

$$\mathcal{F} = \sum_{t=1}^T \Big[ \underbrace{-\log p(y_t | y_{1:t-1})}_{\text{NLL}} + \underbrace{\text{KL}\big(q(x_t | y_{1:t-1}) \,\|\, p(x_t | x_{t-1}, y_{1:t-1})\big)}_{\text{KL dynamics}} \Big]$$

### 2.2 NLL (관측 정확도)

**정의:**

$$-\log p(y_t | y_{1:t-1}) = \frac{1}{2}\left[d_y \log(2\pi) + \log|S_t| + \nu_t^\top S_t^{-1} \nu_t\right]$$

where:
- $\nu_t = y_t - C\mu_t^{\text{pred}}$ (innovation)
- $S_t = C P_t^{\text{pred}} C^\top + R$ (innovation covariance)

**이론적 지위:** Variational EM의 E-step과 M-step 사이의 필수 연결. VFE accuracy term.

### 2.3 KL_dynamics의 분해

두 Gaussian $q = \mathcal{N}(\mu^{\text{pred}}, P^{\text{pred}})$와 $p = \mathcal{N}(A\mu^{\text{filt}}_{t-1}, Q)$ 사이의 KL divergence:

$$
\begin{aligned}
\text{KL}(q\|p) &= \frac{1}{2}\Big[ \text{tr}(Q^{-1}P^{\text{pred}}) - d_x + \log\frac{|Q|}{|P^{\text{pred}}|} \\
&\quad + (\mu^{\text{pred}} - A\mu^{\text{filt}}_{t-1})^\top Q^{-1} (\mu^{\text{pred}} - A\mu^{\text{filt}}_{t-1}) \Big]
\end{aligned}
$$

#### 2.3.1 KL_cov (Covariance Consistency)

$$
\boxed{\text{KL}_{\text{cov}} = \frac{1}{2}\left[ \text{tr}(Q^{-1}P^{\text{pred}}) - d_x + \log|Q| - \log|P^{\text{pred}}| \right]}
$$

**Q 자기조절 메커니즘:**

| Q regime | $\text{tr}(Q^{-1}P)$ | $\log\|Q\|$ | Net effect |
|:---------|:--------------------:|:----------:|:----------:|
| $Q \to 0$ | $\infty$ (loss ↑) | $-\infty$ (loss ↓) | **$\infty$ dominates → blocks Q→0** |
| $Q \to \infty$ | $\to d_x$ (constant) | $\infty$ (loss ↑) | **$\log\|Q\|$ dominates → blocks Q→∞** |
| $Q \approx P$ | $\to d_x$ | constant | **Equilibrium** |

**해석:** KL_cov는 Q를 $P^{\text{pred}}$ 근처로 유지하는 **self-regulating mechanism**. 하이퍼파라미터 불필요.

#### 2.3.2 KL_1step (Mean Consistency)

$$
\boxed{\text{KL}_{\text{1step}} = \frac{1}{2}(\mu_t^{\text{filt}} - \mu_t^{\text{pred}})^\top Q^{-1} (\mu_t^{\text{filt}} - \mu_t^{\text{pred}})}
$$

$\mu_t^{\text{pred}} = f_\theta(\mu_{t-1}^{\text{filt}})$이므로:

$$
\text{KL}_{\text{1step}} = \frac{1}{2}\|\mu_t^{\text{filt}} - f_\theta(\mu_{t-1}^{\text{filt}})\|_{Q^{-1}}^2
$$

**중요:** 이 항은 정보이론적으로 정확하다. 1-step transition의 noise covariance는 정확히 $Q$이므로 $Q^{-1}$ weight가 올바르다.

> **기존 `rollout_1step_loss`(plain MSE)와의 관계:** KL_1step이 $Q^{-1}$로 정확한 weight를 제공하므로, 별도의 `rollout_1step_loss`는 **완전히 redundant**. 제거하고 KL_1step으로 통일해야 한다.

---

## 3. K-step Rollout: $Q^{-1}$가 부정확한 이유

### 3.1 K-step Transition의 Noise Covariance

1-step: $x_{t+1} = f_\theta(x_t) + \epsilon_t$, $\epsilon_t \sim \mathcal{N}(0, Q)$

K-step: $x_{t+K} = f_\theta^K(x_t) + \epsilon^{(K)}_t$

K-step noise $\epsilon^{(K)}_t$의 covariance:

$$Q_K = \sum_{i=0}^{K-1} A_{\text{eff}}^i Q (A_{\text{eff}}^\top)^i$$

여기서 $A_{\text{eff}}$는 effective dynamics matrix (empirical linearization).

### 3.2 $Q_K$ vs $Q$의 차이

| Property | 1-step ($Q$) | K-step ($Q_K$) |
|:---------|:------------:|:--------------:|
| 정의 | $p(x_t\|x_{t-1})$의 noise | $p(x_{t+K}\|x_t)$의 noise |
| 크기 | $Q$ | $\sum_{i=0}^{K-1} A_{\text{eff}}^i Q (A_{\text{eff}}^\top)^i$ |
| $A \approx I$ | $Q$ | $\approx K \cdot Q$ |
| **올바른 weight** | $Q^{-1}$ | **$Q_K^{-1} \neq Q^{-1}$** |

**핵심:** VFE의 K-step rollout 항이 $Q^{-1}$를 사용하면, 실제보다 $Q_K / Q$배 과대/과소 가중된다.

### 3.3 $A_{\text{eff}}$의 영향

$$
Q_K = \sum_{i=0}^{K-1} A_{\text{eff}}^i Q (A_{\text{eff}}^\top)^i
$$

| $\rho(A_{\text{eff}})$ | $Q_K$ 스케일 | $Q^{-1}$를 썼을 때 |
|:----------------------:|:------------:|:-----------------:|
| $< 1$ (contractive) | Bounded ($\leq \frac{Q}{1-\rho^2}$) | **과대평가** ($Q_K < KQ$) |
| $= 1$ (marginal) | $\approx K \cdot Q$ | **$K$배 과대평가** |
| $> 1$ (chaotic) | Exponential growth | **심각한 과대평가** |

### 3.4 수치 예시

**Pendulum ($\rho \approx 0.95$, K=8):**
- $Q_K \approx \sum_{i=0}^{7} 0.95^{2i} \cdot Q \approx 5.5 \cdot Q$
- $Q^{-1}$ weight = 실제보다 $8/5.5 \approx 1.45$배 과대 → 미미한 영향

**Lorenz63 ($\rho \approx 1.5$, K=4):**
- $Q_K \approx \sum_{i=0}^{3} 1.5^{2i} \cdot Q \approx (1 + 2.25 + 5.06 + 11.39) \cdot Q \approx 19.7 \cdot Q$
- $Q^{-1}$ weight = 실제보다 $4/19.7 \approx 0.20$배 — **5배 과소평가**
- 결과: K-step gradient가 실제보다 5배 약해짐 → dynamics 학습 부족

---

## 4. K-step Rollout: Plain MSE로의 전환

### 4.1 Plain MSE의 정의

$$
\mathcal{L}_{\text{rollout}_K} = \frac{1}{K} \sum_{t=0}^{T-K} \|\mu_{t+K}^{\text{filt}} - f_\theta^K(\mu_t^{\text{filt}})\|^2
$$

### 4.2 장점

| 문제점 | $Q^{-1}$ weighted | Plain MSE |
|:-------|:-----------------:|:---------:|
| $Q_K \neq Q$ | 부정확한 weight | **영향 없음** |
| $\rho$ 의존성 | $\rho>1$에서 gradient 소실 | **균일한 스케일** |
| Q 학습 중 변화 | Loss landscape 변동 | **안정적** |
| 구현 복잡성 | $Q^{-1}$ 행렬 연산 필요 | **단순** |

### 4.3 단점 및 대응

| 단점 | 설명 | 대응 |
|:----|:-----|:-----|
| 정보이론적 해석 불가 | ELBO의 일부가 아님 | Regularization term으로 명시적定位 |
| λ 튜닝 필요 | VFE와 스케일 불일치 | $\rho$ 기반 이론 범위로 guided tuning |

---

## 5. λ의 이론적 정당화 — 완전한 휴리스틱이 아닌 이유

### 5.1 λ의 존재 이유

$Q^{-1}$ weight가 K-step에서 부정확하므로, **다른 weight 체계**(plain MSE)가 필요하고, 이 둘 사이의 **스케일 차이**를 보정하는 λ가 필요하다.

$$\lambda \text{의 존재 이유} = Q_K \neq Q$$

### 5.2 λ의 이론적 기준값

VFE의 KL_1step과 rollout_K의 기댓값 비율:

$$\lambda_{\text{theory}} \approx \frac{\mathbb{E}[\text{KL}_{\text{1step}}]_{\text{converged}}}{\mathbb{E}[\text{rollout}_K]_{\text{converged}}} \times \alpha_{\text{margin}}$$

여기서 $\alpha_{\text{margin}} \in [0.1, 0.5]$는 rollout이 VFE를 압도하지 않도록 하는 safety factor.

**K-step error amplification factor $f(\rho, K)$:**

K-step error의 1-step error 대비 증폭비:

$$
f(\rho, K) = \frac{\mathbb{E}[\|\delta_K\|]}{\mathbb{E}[\|\delta_1\|]} \approx 
\begin{cases}
\displaystyle \frac{1 - \rho^K}{1 - \rho}, & \rho < 1 \quad \text{(contractive)} \\[1em]
\displaystyle \frac{\rho^K - 1}{\rho - 1}, & \rho > 1 \quad \text{(expansive)}
\end{cases}
$$

이는 Lemma 7 (Option B Rollout Error Bound)에서 유도된 $\|\delta_K\|$ bound의 구조와 동일하다.

$\lambda$는 KL_1step의 $Q^{-1}$ weight를 plain MSE 스케일로 변환하므로:

$$\lambda_{\text{theory}} \approx \frac{1}{K \cdot \bar{Q} \cdot f(\rho, K)}$$

여기서 $\bar{Q}$는 학습된 Q의 평균값. 실제로는 수렴 후 관측 비율로 결정하는 것이 실용적.

### 5.3 λ의 허용 범위

**하한 (rollout gradient 소실 방지):**

$$\lambda > \frac{\text{VFE gradient scale} / K}{\text{rollout gradient scale per step}}$$

`optax.clip_by_global_norm(1.0)`이 두 gradient를 함께 정규화하므로, $\lambda$가 0.05~0.1이어도 rollout signal이 완전히 사라지지 않는다.

**상한 (VFE 압도 방지):**

$$\lambda < \frac{\mathbb{E}[\text{NLL} + \text{KL}_{\text{cov}} + \text{KL}_{\text{1step}}]}{\mathbb{E}[\text{rollout}_K]}$$

rollout gradient가 VFE를 압도하면 dynamics consistency에 과도한 weight가 주어져 filter 성능 저하.

### 5.4 Clip-by-global-norm의 하한 완화 효과

현재 optimizer chain: `optax.clip_by_global_norm(1.0)` + `adamw`

$$\nabla\mathcal{L} = \nabla\text{VFE} + \lambda \nabla\text{rollout}_K$$

clipping이 **전체 gradient의 norm을 1.0으로 제한**하므로:
- VFE gradient가 rollout보다 크면 → clipping이 VFE를 더 많이 줄임 → rollout signal **상대적 증가**
- $\lambda$가 작아도 clipping이 rollout gradient 비중을 간접적으로 높임

**실제 영향 (Pendulum):**
- VFE gradient norm ≈ $0.8$, rollout gradient norm ≈ $0.08$ ($\lambda=0.5$)
- Total norm ≈ $0.8$ → clipping 미적용 (이미 < 1.0)
- $\lambda=0.1$이라도 rollout gradient norm ≈ $0.016$ — optimizer가 여전히 감지 가능

### 5.5 정리: λ의 정체

| 측면 | 판정 |
|:----|:-----|
| **λ의 존재** | ✅ **이론적으로 필수** — $Q_K \neq Q$ 때문에 별도의 weight 체계 필요 |
| **λ의 정확한 값** | ❌ **완전한 이론 결정 불가** — Q가 학습 중 변화, $\rho$ 시스템 의존 |
| **λ의 범위** | ✅ **이론적으로 결정 가능** — $\rho$, $K$, Q scale, clipping threshold로부터 유도 |
| **λ의 튜닝 전략** | ✅ **$\rho$ 기반 초기값 + 수렴 후 관측 비율로 조정** |

> **결론:** λ의 정확한 값은 empirical하지만, **λ의 존재 자체와 허용 범위는 엄밀히 정당화된다.** VFE의 $Q^{-1}$ weight가 K-step에서 부정확하다는 사실($Q_K \neq Q$)이 λ의 이론적 근거이다.

---

## 6. 시스템별 λ 권장값

| System | $\rho$ | $f(\rho,4)$ | Q scale | 관측 KL/roll 비 | **권장 λ** |
|:-------|:------:|:----------:|:-------:|:--------------:|:---------:|
| Pendulum | ~0.95 | ~3.5 | ~0.01 | KL≈2 / roll≈0.3 | **0.5** |
| VDP | ~0.93 | ~3.3 | ~0.02 | KL≈2 / roll≈0.5 | **0.3** |
| Lorenz63 | ~1.5 | ~8.1 | ~0.05 | KL≈3 / roll≈2.0 | **0.1** |

**튜닝 가이드:**
1. $\rho$가 클수록 λ를 작게 (K-step error 증폭 때문)
2. K가 클수록 λ를 작게 (K-step error 누적 때문)
3. $\lambda \in [0.05, 2.0]$ 범위를 벗어나면 loss 구조 재검토

---

## 7. 기존 loss와의 차이점

| 항목 | 기존 (v5.14) | 제안 |
|:-----|:------------|:-----|
| 1-step loss | `rollout_1step_loss` (plain MSE) + VFE 내부 KL_1step | **KL_1step($Q^{-1}$)으로 통일** — 중복 제거 |
| K-step loss | VFE 내부 $Q^{-1}$ weighted + `rollout_k_step_loss` (plain MSE) | **Plain MSE만** — $Q^{-1}$ 제거 |
| Loss 구성 | VFE(3항) + rollout_1 + rollout_k (혼재) | **VFE(3항) + rollout_k(plain)** — 명확한 분리 |

---

## 8. 구현 스케치

```python
def total_loss(hist, params, config):
    is_valid = ~jnp.isnan(y_obs).any(axis=-1)
    Q = jax.nn.softplus(params['Q_residual_param']) + 1e-8

    # VFE: NLL + KL_cov + KL_1step (Q⁻¹ weighted)
    vfe = vfe_loss(hist, is_valid, Q, eps_arith=config.eps_arith,
                   K_rollout=1)  # K_rollout=1: only 1-step, no K-step

    # K-step rollout: plain MSE, no Q⁻¹
    rollout_k = jnp.array(0.0)
    if config.K_rollout > 1:
        rollout_k = rollout_k_step_loss(
            hist['mu_filt'], hist.get('A_eff_dyn', hist['A_eff']),
            is_valid, K=config.K_rollout,
        )

    return vfe + config.rollout_weight * rollout_k
```

---

## 9. Wikilinks

- [[rigor-filter]] — Core RIGOR architecture (v5.14)
- [[k-step-rollout-vfe-loss]] — 기존 K-step rollout VFE 설계 (deprecation 참고)
- [[k-step-rollout-error-bound]] — Lemma 7: Option B rollout error bound ($f(\rho, K)$ 유도)
- [[ukf-enkf-gradient-variance-analysis]] — Lemma 1-3
- [[a-plus-nn-svd-projection-analysis]] — Lemma 4-5
- [[rigor-development]] — Changelog (loss 구조 변경 이력)
