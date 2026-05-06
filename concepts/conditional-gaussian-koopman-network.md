---
title: "Conditional Gaussian Koopman Network (CGKN)"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [koopman-operator, conditional-gaussian, data-assimilation, nonlinear-filtering, lagrangian-da]
confidence: medium
---

# Conditional Gaussian Koopman Network (CGKN)

## 개요

Conditional Gaussian Koopman Network(CGKN)는 Chen, Wu & Chen(UW-Madison)이 개발한 **구조 보존 데이터 기반 DA 프레임워크**로, 비선형 stochastic 시스템을 **conditional Gaussian 구조**를 가진 저차원 잠재 공간으로 임베딩한다. CGKN의 핵심 장점은 잠재 공간에서 **분석적(closed-form) posterior 업데이트**가 가능하다는 점으로, ensemble forecast 없이도 exact Bayesian inference를 수행할 수 있다.

## LaCGKN과의 관계

[[lagrangian-koopman-network|LaCGKN]]은 CGKN 프레임워크를 Lagrangian 설정으로 확장한 버전이다. LaCGKN은 CGKN의 conditional Gaussian 구조를 유지하면서, Lagrangian tracer field의 비선형 coupling 문제를 처리하기 위해 **tracer homogenization** ([[tracer-homogenization]])과 **Fourier positional encoding**을 추가한다.

## References
1. Chen, N. et al. — CGKN series papers, UW-Madison.
