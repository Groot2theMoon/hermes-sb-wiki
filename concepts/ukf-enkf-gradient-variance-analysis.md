---
title: "UKF vs EnKF Gradient Variance Analysis — Why Deterministic Sigma Points"
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [rigor, kalman-filter, ukf, enkf, gradient-analysis, theory, lemma]
confidence: high
---

# UKF vs EnKF Gradient Variance Analysis

> Lemma: UKF의 deterministic sigma point 선택이 EnKF의 random ensemble보다 differentiable filtering에서 gradient variance 측면에서 strictly superior함을 증명.

---

## Lemma 1 (Gradient Variance)

$n$차원 상태 공간에서 Gaussian filtering을 고려하자. Posterior $p(x_t | y_{1:t}) \approx \mathcal{N}(\mu_t, P_t)$ 를 근사할 때:

- **UKF:** $2n+1$개 deterministic sigma points $\{\chi_i\}_{i=0}^{2n}$ 사용
- **EnKF:** $N$개 random ensemble members $\{x^{(j)}\}_{j=1}^N \sim \mathcal{N}(\mu_t, P_t)$ 사용

Dynamics model $f_\theta(x)$의 parameter $\theta$에 대한 loss $\mathcal{L}$의 gradient가 filter를 통과할 때:

$$\nabla_\theta \mathcal{L}^{\text{UKF}} = \sum_{i=0}^{2n} w_i \cdot \frac{\partial \mathcal{L}}{\partial \hat{\mu}} \cdot \nabla_\theta f_\theta(\chi_i)$$

$$\nabla_\theta \mathcal{L}^{\text{EnKF}} = \frac{1}{N} \sum_{j=1}^N \frac{\partial \mathcal{L}}{\partial \hat{\mu}} \cdot \nabla_\theta f_\theta(x^{(j)})$$

UKF의 sigma points $\chi_i$는 **deterministic**하게 선택되므로:

$$\text{Var}[\nabla_\theta \mathcal{L}^{\text{UKF}}] = 0$$

반면 EnKF의 $x^{(j)}$는 **random sample**이므로:

$$\text{Var}[\nabla_\theta \mathcal{L}^{\text{EnKF}}] = \frac{1}{N} \text{Var}_{x\sim\mathcal{N}(\mu,P)} \left[ \frac{\partial \mathcal{L}}{\partial \hat{\mu}} \nabla_\theta f_\theta(x) \right] \propto \frac{1}{N}$$

---

## Lemma 2 (Information Efficiency)

UKF의 sigma points는 Gaussian의 1, 2차 moment를 **정확히** 포착하도록 설계된다:

$$\chi_0 = \mu, \quad \chi_i = \mu + \left(\sqrt{(n+\lambda)P}\right)_i, \quad \chi_{i+n} = \mu - \left(\sqrt{(n+\lambda)P}\right)_i$$

이 선택은 다음 moment-matching 조건을 만족한다:

$$\sum_{i=0}^{2n} w_i \chi_i = \mu, \quad \sum_{i=0}^{2n} w_i (\chi_i-\mu)(\chi_i-\mu)^\top = P$$

동일한 $N=2n+1$개 particle로 EnKF가 달성하는 moment-matching은 random sampling error를 포함한다:

$$\mathbb{E}\left[ \left\| \frac{1}{N}\sum_{j=1}^N x^{(j)} - \mu \right\|^2 \right] = \frac{\text{tr}(P)}{N}$$

**따라서 동일한 particle 수에서 UKF는 EnKF보다 strictly 더 많은 정보를 전달한다.**

---

## Practical Implication for Differentiable Filtering

| 측면 | UKF | EnKF |
|------|:---:|:----:|
| Gradient noise | **0** (deterministic) | $\mathcal{O}(1/N)$ |
| Information per particle | Maximal (moment-matched) | Suboptimal (random) |
| Reproducibility | Deterministic | Seed-dependent |
| Computational cost | $\mathcal{O}(n^3)$ (Cholesky) | $\mathcal{O}(N n^2)$ |

**RIGOR의 선택 근거:** 학습 안정성(stable gradient)과 정보 효율성(information efficiency)이 EnKF 대비 결정적 우위를 갖는다. 특히 UKF의 deterministic sigma point는 UFI(sigma cloud conditioning)의 기반이 된다 — EnKF의 random ensemble로는 일관된 conditioning feature를 얻을 수 없다.

---

## 참고 문헌

- Wan & van der Merwe (2000). The Unscented Kalman Filter for Nonlinear Estimation.
- Julier & Uhlmann (2004). Unscented Filtering and Nonlinear Estimation.
- Särkkä (2013). Bayesian Filtering and Smoothing. Cambridge.

## Wikilinks
- [[rigor-filter]] — RIGOR의 UKF 구현
- [[ensemble-kalman-filter]] — EnKF 기본 개념
- [[unscented-feature-interaction]] — UFI: sigma cloud conditioning
- [[square-root-unscented-kalman-filter]] — SR-UKF 수식
