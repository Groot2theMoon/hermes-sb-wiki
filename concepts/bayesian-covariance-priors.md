---
title: "Bayesian Covariance Matrix Priors — SIW, IW, Reference Prior"
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [bayesian, covariance-estimation, prior, jeffreys-prior, reference-prior, shrinkage-prior]
sources:
  - raw/papers/1408.4050v2.md
  - raw/papers/Download.md
confidence: medium
---

# Bayesian Covariance Matrix Priors

다변량 정규 분포의 공분산 행렬 $\Sigma$에 대한 Bayesian 사전 분포(prior)들의 비교 및 분류.

## 공분산 행렬 Prior의 필요성

다변량 데이터 ($y_i \sim N(0, \Sigma)$)에서 $\Sigma$ 추정은 고전적으로 MLE $\hat{\Sigma}_0 = S/m$을 사용하지만, 이는 고차원에서 suboptimal. Bayesian 접근법은 양정치(positive definiteness) 보장, 불확실성 정량화, 사전 정보 통합의 장점이 있음.

## 핵심 Prior 종류

### Inverse Wishart (IW)
가장 일반적인 conjugate prior:
$$\pi(\Sigma) \propto |\Sigma|^{-(\nu+d+1)/2} e^{-\frac{1}{2}\text{tr}(\Lambda\Sigma^{-1})}$$

- **장점:** Conjugacy → Gibbs sampling 용이
- **단점:** (1) 단일 자유도로 모든 분산 통제, (2) 분산의 사전 분포가 0 근처에서 낮은 밀도, (3) 상관과 분산 간 unwanted 사전 의존성

### Scaled Inverse Wishart (SIW)
$\Sigma = \Delta Q \Delta$, $Q \sim IW(\nu, \Lambda)$, $\log\delta_i \sim N(b_i, \xi_i^2)$
- 각 분산에 독립적인 사전 정보 부여 가능
- 상관 분포는 IW와 동일

### Shrinkage Inverse Wishart (Berger, Sun, Song 2020)
**핵심 기여:** 고유값을 강제로 분리시키는 IW/Jeffreys prior의 문제 해결

일반화된 prior class:
$$\pi(\Sigma \mid a, b, H) \propto \frac{\text{etr}(-\frac{1}{2}\Sigma^{-1}H)}{|\Sigma|^a [\prod_{i<j}(\lambda_i - \lambda_j)]^b}$$

- $b=0$: IW prior ($a > k$)
- $b=1$: **Shrinkage IW** — 고유값 분리 문제 해결
- Posterior는 $m \geq 3$에서 차원 $k$와 무관하게 proper
- **Low-rank learning:** $k$보다 적은 관측치로도 trace 등 특정 feature 추정 가능
- $k=100$까지 computation 가능한 MCMC 알고리즘 제공

### Reference Prior (Yang & Berger 1994)
$$\pi^R(\Sigma) = |\Sigma|^{-1}[\prod_{i<j}(\lambda_i - \lambda_j)]^{-1}$$

- Jeffreys prior ($\pi^J(\Sigma) = |\Sigma|^{-(k+1)/2}$)가 고차원에서 너무 informative한 문제 해결
- RIGOR의 dimension-averaged Jeffreys 변형과 정신적 일관성

## 실험 비교 (Alvarez, Niemi, Simpson 2014)

| Prior | Variance bias | Correlation bias | Flexibility |
|:-----|:-------------|:----------------|:-----------|
| IW (default) | 심함 (작은 variance 과대추정) | 0으로 편향 | 낮음 |
| SIW | 양호 | 양호 | 중간 |
| HIW | 양호 | 양호 | 높음 |
| Separation strategy | 양호 | 양호 | 높음 |

**결론:** IW prior는 true variance가 prior mean보다 작을 때 심각한 bias 발생. 대안 priors (SIW, HIW, separation)가 모두 더 나은 성능.

## RIGOR 관련성

RIGOR v2.3의 dimension-averaged Jeffreys `p(Q) ∝ |Q|^{-(d+1)/(2d)}`:
1. **Berger-Sun-Song class**의 특수한 경우 ($a = (d+1)/(2d)$, $b=0$, $H=0$)
2. **Yang-Berger reference prior**의 방향성과 일관됨 (dimension에 덜 민감)
3. 대각 Q 구조에서 full-matrix Jeffreys (계수 5.5 at d=10)보다 적절한 regularization 강도

## Wikilinks
- [[jeffreys-prior-dimension-scaling]] — RIGOR 변형 Jeffreys prior 상세 분석
- [[dongchu-sun]] — Dongchu Sun, SIW prior 공동 저자
- [[james-o-berger]] — James O. Berger, objective prior 창시자

## References
- Berger, Sun & Song (2020). "Bayesian analysis of the covariance matrix..." *Annals of Statistics*, 48(4), 2285-2312
- Alvarez, Niemi & Simpson (2014). "Bayesian inference for a covariance matrix." arXiv:1408.4050
- Yang & Berger (1994). "Estimation of a Covariance Matrix Using the Reference Prior." *Annals of Statistics*, 22(3)
