---
title: "Quantitative Stability of Regularized Optimal Transport and Sinkhorn Convergence"
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [mathematics, model, inference, paper, theory]
sources: [raw/papers/2110.06798v3.md]
confidence: medium
---

# Optimal Transport Stability and Sinkhorn's Algorithm

## 개요

Eckstein & Nutz (2022)는 entropic optimal transport의 **marginals에 대한 정량적 안정성**을 분석한다. Quadratic cost, unbounded support 조건에서 value의 Lipschitz 연속성과 optimal coupling의 Hölder 연속성을 증명. 응용으로 **Sinkhorn algorithm의 Wasserstein 수렴**을 보장.

## 핵심 아이디어

### Stability Results
- **Value stability (Theorem 3.7):** $S_{\text{ent}}(\mu_1, \mu_2, c)$가 $W_p$에서 Lipschitz 연속
- **Optimizer stability (Theorem 3.11):** $\pi^*$가 $1/(2p)$-Hölder in $W_p$
  - Transport inequality + strong convexity (Pythagorean property of entropy)
  - Subgaussian tail 조건으로 unbounded support 허용
- **개선된 bound (Theorem 3.13):** bounded cost에서 $1/(p+1)$-Hölder (sharp)

### Two Proof Techniques
1. **Shadow coupling:** explicit gluing construction → 다른 marginal에 coupling 투영
2. **Change of coordinates:** marginal 차이 → cost function 차이로 변환

### Sinkhorn Convergence (Theorem 3.15)
- Sinkhorn iterate $\pi^n$ → $\pi^*$ in Wasserstein distance
- Quadratic cost + subgaussian marginals에서 수렴률 보장
- 기존 total variation 수렴보다 강한 결과

## 의의
- Unbounded cost, unbounded support에서 **최초의 정량적 안정성 결과**
- Constants가 cost에 linear → entropic regularization small-$\varepsilon$ setting에서 실용적
- Divergence regularization 일반화 ($f$-divergence 포함)

## 융합 도메인 연결
- [[score-based-generative-modeling-sde]] — optimal transport와 generative modeling
- [[diffusion-trajectory-optimization]] — transport 기반 trajectory planning
- [[kennedy-ohagan-calibration]] — Wasserstein distance 기반 모델 비교
