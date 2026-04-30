---
title: "Jeffreys Prior Dimension Scaling — 표준 vs RIGOR 변형 분석"
created: 2026-05-01
updated: 2026-05-01
type: concept
tags: [jeffreys-prior, dimension-scaling, covariance-estimation, reference-prior, bayesian]
sources:
  - raw/papers/rigor_v2/loss.py
confidence: high
---

# Jeffreys Prior Dimension Scaling

## 개요

RIGOR v2.3은 noise covariance Q에 대한 Jeffreys prior를 dimension-averaged 형태로 사용:
`log p(Q) = -(d+1)/(2d) · log|det(Q)|`

본 페이지는 이 변형의 이론적 정당성과 표준 Jeffreys와의 차이를 분석한다.

## 세 버전 비교

Q가 diagonal (Q = diag(σ₁², ..., σ_d²))일 때 각 prior의 log-density:

| 버전 | log p(Q) | 각 σ²당 계수 | d=10 | d=1 | d=100 |
|:----|:---------|:-----------:|:----:|:---:|:-----:|
| **Element-wise Jeffreys** (독립 σ²) | -Σ log σᵢ² | 1.0 | 1.0 | 1.0 | 1.0 |
| **RIGOR 변형** | -(d+1)/(2d) · log\|det(Q)\| | (d+1)/(2d) | **0.55** | 1.0 | **0.505** |
| **Full-matrix Jeffreys** | -(d+1)/2 · log\|det(Q)\| | (d+1)/2 | **5.5** | 1.0 | **50.5** |

## 이론적 배경

### 표준 Jeffreys (Full Covariance Matrix)

Jeffreys' rule: `p(Σ) ∝ √|I(Σ)|` where I는 Fisher Information Matrix.

Full covariance matrix Σ (d×d)에 대해:
```
p(Σ) ∝ |Σ|^{-(d+1)/2}
```

대각 Q = diag(σ₁², ..., σ_d²)로 제한하면:
```
p(σ₁², ..., σ_d²) ∝ Π (1/σᵢ²)^{(d+1)/2}
```

### RIGOR 변형의 해석

`p(Q) ∝ |Q|^{-(d+1)/(2d)}`는 다음 중 하나로 해석 가능:

1. **Berger-Sun-Song (2020) generalized prior**: `p(Σ) ∝ |Σ|^{-α}` class에서 `α = (d+1)/(2d)`.
2. **Geometric mean over dimensions**: 표준 Jeffreys의 1/d 제곱근. 각 dimension에 대한 per-dimension prior의 곱.
3. **Dimension-invariant scale prior**: d에 무관하게 prior의 total strength 유지.

## 관련 문헌

### Yang & Berger (1994) — Reference Prior for Covariance
**"Estimation of a Covariance Matrix Using the Reference Prior"** (Annals of Statistics, 22(3))

표준 Jeffreys prior가 고차원 covariance matrix에서 바람직하지 않은 성질(too informative)을 가짐을 지적. 대안으로 **reference prior** (less informative) 제안. RIGOR 변형은 reference prior의 방향성과 일관됨.

### Berger, Sun & Song (2020) — New Class of Priors
**"Bayesian analysis of the covariance matrix of a multivariate normal distribution with a new class of priors"** (Annals of Statistics, 48(4))

Jeffreys prior의 power를 조절하는 generalized prior class `p(Σ) ∝ |Σ|^{-α}` 제안. RIGOR의 `α = (d+1)/(2d)`는 이 class의 특수한 경우.

### Alvarez, Niemi & Simpson (2014) — Prior Comparison
**"Bayesian inference for a covariance matrix"** (arXiv:1408.4050)

Inverse Wishart, scaled IW, separation strategy 비교. IW (Jeffreys limit)는 variances/correlations 간 undesirable prior relationship이 있음을 보임. Diagonal Q에서는 이 문제가 없음.

## RIGOR 적합성 판단

### RIGOR 변형의 장점

1. **대각 Q 구조와 일관성**: Q = diag(σ²)는 d개의 독립 variance. Full-matrix Jeffreys (계수 5.5 at d=10)는 과도하게 강한 regularization → gradient 기반 학습에서 Q를 0으로 붕괴시킬 위험.

2. **차원 불변성 (Dimension invariance)**: (d+1)/(2d) 계수는 d→∞에서 0.5로 수렴, d=1에서 1.0. Prior strength가 dimension에 대해 안정적 → 동일한 `prior_type='jeffreys'`로 다양한 dimension 실험 가능.

3. **Scale invariance 유지**: `log|det(Q)|` 형태이므로 scale transformation c·Q에서 log-prior는 `-(d+1)/(2d) · (log c^d + log|det(Q)|)` = 상수 shift → Jeffreys의 핵심 desideratum 유지.

4. **d=1에서 element-wise Jeffreys와 일치**: (1+1)/(2·1) = 1.0 → 1차원 시스템에서 자연스러운 uninformative prior.

### RIGOR 변형의 한계

1. **Bayesian 정당성의 약화**: 표준 Jeffreys는 Fisher Information에서 유도되지만, RIGOR 변형은 ad-hoc dimension scaling.
2. **Berger-Sun-Song framework 내에서는 정당화 가능**: Generalized prior `p(Σ) ∝ |Σ|^{-α}`은 formal prior로 받아들여짐.

### 결론

**RIGOR 변형 `(d+1)/(2d) · log|det(Q)|`는 표준 Jeffreys와 element-wise Jeffreys 사이의 principled interpolation이며, Berger-Sun-Song (2020)의 generalized prior class의 특수한 경우로 정당화 가능. 고차원 대각 Q에 대한 gradient-based learning에서 표준 Jeffreys보다 실용적으로 적합함.**

## Related
- [[james-o-berger]] — James O. Berger (Duke), objective prior 이론의 창시자
- [[dongchu-sun]] — Dongchu Sun (UNL), generalized prior class 공동 저자
- [[ruoyong-yang]] — Ruoyong Yang, reference prior for covariance matrix
- [[lure-stability]] — Lur'e Stability (RIGOR stability argument)
- [[em-kalman-smoother-noise-covariance]] — EM Q,R estimation
- [[lure-stability]] — Lur'e Stability (RIGOR stability argument)
- [[em-kalman-smoother-noise-covariance]] — EM Q,R estimation
- [[shima-contractivity-lure]] — Shima LMI
