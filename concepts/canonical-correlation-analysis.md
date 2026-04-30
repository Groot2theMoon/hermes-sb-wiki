---
title: Canonical Correlation Analysis (CCA) — CCA, kCCA, tkCCA, CTA
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [classic-ai, dimensionality-reduction, learning, algorithms, kernel-method, survey]
sources: [raw/papers/ml2-lecture-03-cca.md]
confidence: high
---

# Canonical Correlation Analysis (CCA)

## 개요

CCA는 두 개의 서로 다른 multivariate dataset $X$와 $Y$ 사이의 **상관관계(correlation)를 최대화하는 projection**을 찾는 방법이다. 공통된 잠재 변수(latent variable) $Z$가 두 측정에 어떻게 반영되는지를 분석하는 데 사용된다.

- **원리:** $X$와 $Y$ 각각에 linear projection $w_x$, $w_y$를 적용해 $w_x^T X$와 $w_y^T Y$의 상관계수를 최대화
- **수식:** $\max_{w_x, w_y} \frac{w_x^T \Sigma_{XY} w_y}{\sqrt{w_x^T \Sigma_{XX} w_x \cdot w_y^T \Sigma_{YY} w_y}}$
- **해법:** Generalized eigenvalue problem으로 변환하여 풀이

## CCA의 수학적 유도

Centering된 데이터 $X \in \mathbb{R}^{d_x \times n}$, $Y \in \mathbb{R}^{d_y \times n}$에 대해:

1. 공분산 행렬 계산: $\Sigma_{XX} = \frac{1}{n} X X^T$, $\Sigma_{YY} = \frac{1}{n} Y Y^T$, $\Sigma_{XY} = \frac{1}{n} X Y^T$
2. 최대화 문제를 generalized eigenvalue 문제로 변환:
   - $\Sigma_{XX}^{-1} \Sigma_{XY} \Sigma_{YY}^{-1} \Sigma_{YX} w_x = \lambda^2 w_x$
   - $\Sigma_{YY}^{-1} \Sigma_{YX} \Sigma_{XX}^{-1} \Sigma_{XY} w_y = \lambda^2 w_y$
3. $\lambda$가 **canonical correlation** (0과 1 사이)

## 한계 (Shortcomings)

- **고차원 데이터:** Bag-of-Words처럼 차원이 매우 높거나 무한한 경우 공분산 행렬 계산 불가
- **비선형 의존성:** CCA는 linear correlation만 포착 → 비선형 관계 탐지 불가

## Kernel CCA (kCCA)

Kernel trick을 적용하여 CCA를 비선형 의존성 포착 및 고차원 데이터에 확장:

- 데이터를 kernel feature space로 mapping: $X \to \phi(X)$, $Y \to \psi(Y)$
- Kernel trick: $\phi(X)^T \phi(X) = K_X$, $\psi(Y)^T \psi(Y) = K_Y$
- **해법:** Dual formulation으로 kernel matrices에 대해 풀이
- **응용:** Kernel ICA (Bach 2002), Mutual information estimation (Gretton 2005)

## Temporal Kernel CCA (tkCCA)

두 변수 간에 **시간 지연(time delay)**이 있는 coupling을 분석하기 위한 확장:

- **문제:** 동시(simultaneous) 샘플 간 correlation이 낮은 경우 표준 CCA/kCCA가 실패
- **해법:** 한 변수를 시간 축에서 shift하여 모든 relative time lag에 대해 correlation 합을 최대화
- **tkCCA 결과:** Canonical variates + **canonical correlogram** (시간 지연 함수)
- **응용:** Neuro-vascular coupling (fMRI BOLD ↔ 신경 활동), 시계열 다중 모달 분석

## Canonical Trend Analysis (CTA)

소셜 네트워크 데이터(트위터 리트윗 등)의 **시공간 패턴 분석**을 위한 tkCCA 응용:

- 뉴스 기사의 리트윗 위치(지리 정보)와 시간적 추세를 동시에 모델링
- Canonical subspace에 projection하여 dominant spatiotemporal pattern 추출
- **응용:** 뉴스 확산 패턴 분석, 지역별 반응 차이, 트렌드 감지

## 관련 개념

- [[principal-component-analysis]] — 분산 최대화 vs 상관관계 최대화
- [[kernel-methods]] — kernel trick의 일반적 원리
- 차원 축소 — 차원 축소 방법론
- 독립 성분 분석 — 독립 성분 분석 (CCA와의 관계)

## References

- Klaus-Robert Müller, Machine Learning 2 Lecture, TU Berlin 2023
- Akaho (2001) — Kernel CCA 최초 제안
- Bach & Jordan (2002) — Kernel ICA via CCA
- Gretton et al. (2005) — Mutual information estimation via CCA
- Bießmann et al. (2009) — tkCCA for multi-modal recordings
