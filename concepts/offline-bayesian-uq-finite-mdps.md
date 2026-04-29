---
title: "Offline Bayesian Aleatoric & Epistemic UQ in Finite-State MDPs"
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [uncertainty, inference, reinforcement-learning, paper, healthcare]
sources: [raw/papers/valdettaro24a.md]
confidence: medium
---

# Offline Bayesian UQ in Finite-State MDPs

## 개요

Valdettaro & Faisal (Imperial College, 2024)은 finite-state MDP에서 **aleatoric과 epistemic uncertainty를 분리**하고 **posterior expected value를 최적화**하는 Bayesian 기법을 제안한다. AI Clinician (sepsis 치료)에 적용하여 실용성을 검증.

## 핵심 아이디어

### Uncertainty Decomposition
- **Bayesian dynamics model:** Dirichlet prior → posterior over transition probabilities
- **Return distribution moments:** Sobel (1982)의 closed-form 선형 방정식
- Law of total variance로 aleatoric/epistemic 분리:
  $$\text{Var}[G^\pi] = \mathbb{E}[\text{Var}[G^\pi|\mathcal{M}]] + \text{Var}[\mathbb{E}[G^\pi|\mathcal{M}]]$$

### Posterior Value Optimization
- $\mathbf{v}(\pi) = (\mathbf{I} - \gamma \mathbf{T}(\pi))^{-1} \mathbf{r}$의 closed-form 활용
- Stochastic gradient 기반 policy 최적화
- Delage & Mannor (2010)의 strong posterior assumption 없이 동작

### Application: AI Clinician
- Komorowski et al. (2018)의 sepsis 치료 MDP
- ~$10^3$ states 규모
- Conservative dynamics model로 offline safety 확보
- 데이터 부족 시 Bayesian 접근의 benefit 입증

## 융합 도메인 연결
- [[uncertainty-quantification-deep-learning]] — UQ 방법론 일반
- [[bayesian-uncertainty-vision]] — aleatoric/epistemic uncertainty 구분
- [[pac-bayesian-epistemic-uncertainty]] — Bayesian posterior uncertainty 이론
