---
title: Higher-Order Correlation UKF (HOC-UKF) — Grothe (2012)
created: 2026-05-08
updated: 2026-05-08
type: concept
tags: [kalman-filter, ukf, state-estimation, unscented-transform, hidden-state, theory]
sources: [raw/papers/grothe12-higher-order-correlation-ukf.md]
confidence: high
---

# Higher-Order Correlation UKF (HOC-UKF)

**Oliver Grothe** (University of Cologne, 2012). arXiv:1207.4300.

## 개요

표준 UKF/EKF는 2-moment (mean + covariance) Gaussian approximation에 기반한다. 이는 observation과 **상관관계(correlation)가 있는 state만 추정**할 수 있다는 근본적 한계가 있다. 즉, $P_{xy}$ (state-observation cross-covariance)가 0에 가까운 state (예: Bouc-Wen의 z, volatility parameter)는 UKF로 추정이 불가능하다.

Grothe는 이 문제를 **higher-order correlation measurement update**로 해결한다. 표준 UKF의 1차 correlation을 넘어, 2차 이상의 correlation moment를 이용해 observation과 무상관인 state도 추정할 수 있도록 measurement update를 확장한다.

## 핵심 문제

> "these filters only estimate states that are correlated with the observation. Therefore, sequential estimation of diffusion parameters, e.g., volatility, which are not correlated with the observations is not possible."

이는 우리의 Bouc-Wen 문제와 **정확히 동일한 근본적 한계**다 ([[bouc-wen-filter-landscape]] 참조):
- Bouc-Wen에서 z의 dynamics는 $\dot{z} = f_z(x, z)$이지만, observation $y = x$와 correlation이 0에 가까움
- UKF의 Kalman gain $K_z ≈ 0$ → z 추정 불가
- Loss horizon K=4가 z의 장기 효과를 볼 수 없어 학습도 실패

## HOC-UKF 솔루션

Grothe의 핵심 아이디어는 **continuous-discrete state space**에서 **higher-order correlation**을 위한 **explicit formula**를 유도한 것:

1. 표준 UKF measurement update: $\hat{x}^+ = \bar{x} + K(y - \hat{y})$
   - $K = P_{xy}P_{yy}^{-1}$ → 오직 1차 correlation (covariance)만 사용
   
2. HOC-UKF: observation과 state의 **higher-order joint moment**를 계산하여 measurement update에 반영
   - 2차 correlation: $\mathbb{E}[(x - \bar{x})(y - \hat{y})^{\otimes 2}]$ 형태의 텐서
   - Continuous-discrete formulation: continuous dynamics + discrete measurement

## Relation to RIGOR

| Aspect | Grothe HOC-UKF | RIGOR UFI |
|--------|---------------|-----------|
| 목적 | Uncorrelated state 추정 | Sigma cloud conditioning |
| 방법론 | Analytical higher-order moment | Learned NN (Dense) |
| 계산 | Closed-form (CUT 필요) | Data-driven (backprop) |
| 장점 | Principled, certifiable | Flexible, scalable |
| 단점 | Moment truncation order 결정 | 정보 병목 (loss horizon) |

**시너지 가능성:** Grothe의 higher-order correlation formula를 UFI의 **loss function에 regularizer**로 추가. 즉, UFI의 NN output $\Delta K$가 Grothe가 유도한 HOC-UKF gain에 근접하도록 regularize.

## Wikilinks
- [[rigor-sigma-point-research]] — RIGOR gap analysis (#7: Grothe HOC-UKF)
- [[polynomial-unscented-kalman-filter]] — Servadio & Cherian polynomial update (관련 접근)
- [[unscented-feature-interaction]] — UFI: sigma point pairwise feature
- [[rigor-development]] — RIGOR framework development
- [[rigor-filter]] — Bouc-Wen 실험: z correlation 문제
