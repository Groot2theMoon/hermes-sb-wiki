---
title: "NN Framework for History-Dependent Constitutive Laws — Thermodynamically Consistent Learning"
created: 2026-05-17
updated: 2026-05-17
type: concept
tags: [materials, solid-mechanics, surrogate-model, micromechanics, paper]
confidence: medium
sources: [arXiv:2605.14179]
---

# NN Framework for History-Dependent Constitutive Laws (Bhattacharya/Stuart)

## 개요

**Mayank Raj, Lianghao Cao, Andrew Stuart, Kaushik Bhattacharya (Caltech, 2026)** ^[arXiv:2605.14179]은 **열역학 제2법칙** 및 **재료 안정성**과 일관된 **이력 의존형 구성 법칙(history-dependent constitutive law)** 학습 프레임워크를 제안한다.

## 핵심 아이디어

- **인과적이고 에너지적인(causal and energetic) 정식화**: 학습된 구성 법칙이 (a) 열역학 제2법칙, (b) 극한 변형 하 안정성, (c) 지배방정식 해의 존재성을 보장
- **내부 변수 식별 가능성**: 데이터로부터 학습된 내부 변수는 **선형 변환까지 유일(unique up to linear transform)**
- **증명**: 동등 클래스(equivalence class) 특성화 — 서로 다른 surrogate가 동일한 입출력 관계를 가질 수 있는 조건 규명
- **응용**: 다결정 마그네슘 단위 셀의 Taylor 평균 응답 학습 — 2% 상대 오차

## 의의

- FE² 계산 비용을 낮추기 위한 multiscale surrogate의 핵심 문제 해결
- 물리적 일관성 없는 surrogate 모델이 잘못된 예측을 할 위험을 이론적으로 차단
- Bhattacharya/Stuart 조합은 Caltech의 solids × ML 연구 방향성을 보여줌

## 연결점
- [[kaushik-bhattacharya]] — Caltech, multiscale materials ML 리더
- [[andrew-stuart]] — Caltech, operator learning, Bayesian inversion
- [[deep-material-network]] — DMN도 구성 법칙 surrogate, 물리적 일관성 비교
- [[constitutive-priors-inverse-design]] — 구성 법칙에 prior를 부여하는 접근법

## References
- arXiv:2605.14179 — Caltech, May 2026
