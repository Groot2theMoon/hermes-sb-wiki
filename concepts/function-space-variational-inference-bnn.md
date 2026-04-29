---
title: "Generalized Function-Space Variational Inference for Bayesian Neural Networks"
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [inference, training, mathematics, neural-network, paper]
sources: [raw/papers/cinquin25a.md]
confidence: high
---

# Function-Space Variational Inference in Bayesian Neural Networks

## 개요

Cinquin & Bamler (U. Tübingen, 2025)는 BNN에서 **function-space prior** 사용 시 KL divergence가 무한대가 되는 근본적 문제(Wild et al. 2022a 지적)를 **regularized KL divergence**로 해결한다. GP prior를 BNN에 적용할 수 있는 최초의 well-defined variational objective를 제시.

## 핵심 아이디어

### 문제: Function-Space VI의 KL Divergence
- Weight-space prior 대신 function-space prior(e.g., GP prior) 사용 시:
  $$\mathcal{L}(\phi) = \mathbb{E}_{q_\phi(\mathbf{w})}[\log p(\mathcal{D}|\mathbf{w})] - D_{\text{KL}}(\mathbb{Q}_\phi \| \mathbb{P})$$
- Wild et al. (2022a): $\mathbb{P}$가 GP인 경우 $D_{\text{KL}}(\mathbb{Q}_\phi \| \mathbb{P}) = \infty$

### 해결: Regularized KL Divergence
- Generalized VI framework (Knoblauch et al., 2022)
- Regularized KL (Quang, 2019): Gaussian measure 간 KL을 finite로 유지
- Linearized BNN (Rudner et al., 2022b)과 결합 → closed-form variational measure

### GFSVI (Generalized Function-Space VI)
1. Linearized BNN → $\mathbb{Q}_\phi$가 GP로 표현됨
2. Regularized KL로 infinite-divergence 문제 회피
3. GP prior로부터 smoothness, periodicity 등 구조적 특성 부여

## 실험 결과
- Matérn-1/2, 3/2, 5/2, RBF, Periodic kernel 등 다양한 GP prior 실현
- Regression, classification, OOD detection에서 경쟁력 있는 성능
- GP prior의 성질(smoothness 등)이 posterior에 성공적으로 반영됨

## 융합 도메인 연결
- [[uncertainty-quantification-deep-learning]] — BNN과 UQ의 관계
- [[pac-bayesian-epistemic-uncertainty]] — VI 기반 epistemic uncertainty 이론
- [[kennedy-ohagan-calibration]] — GP prior 설계와 calibration
