---
title: "HyCOP — Hybrid Composition Operators for Interpretable PDE Learning"
created: 2026-05-09
updated: 2026-05-09
type: concept
tags: [surrogate-model, neural-operator, hybrid-modeling, physics-informed, paper]
confidence: medium
sources: [arXiv:2605.00820]
---

# HyCOP — Hybrid Composition Operators for Interpretable PDE Learning

## 개요

**Anonymous authors (2026)** ^[arXiv:2605.00820]이 제안하는 **HyCOP (Hybrid Composition Operators)** 는 PDE 해석 연산자를 모듈(advection, diffusion, learned closure, boundary handling)의 조합으로 학습하는 **모듈형 프레임워크**이다. 단일 monolithic neural operator와 달리, HyCOP는 쿼리 조건(query conditioning)에 따라 어느 모듈을 적용할지, 얼마나 오래 적용할지를 결정하는 **정책(policy)**을 학습한다.

## 핵심 아이디어

- **모듈형 구성:** 각 모듈은 수치 서브-솔버 또는 학습된 컴포넌트일 수 있음 → 진정한 hybrid surrogate
- **비-자기회귀(non-autoregressive) 평가:** 임의 쿼리 시간에서도 autoregressive rollout 없이 평가 가능
- **OOD 일반화:** 다양한 PDE 벤치마크에서 monolithic neural operator 대비 **order-of-magnitude OOD 개선**
- **이론적 기여:** Composition error와 module error 분해 → process-level diagnostic으로 활용
- **전이 학습:** Dictionary update(경계 조건 교체, residual enrichment)를 통한 modular transfer

## 연결점

- [[neural-operator]] — 기존 monolithic neural operator(FNO, DeepONet 등)와의 차별점: 모듈형 구성
- [[surrogate-model]] — 일반적인 surrogate modeling 맥락에서 HyCOP의 hybrid 접근법
- [[hybrid-modeling]] — Physics-ML hybrid의 새로운 패러다임: solver 선택을 학습
- [[fourier-neural-operator]] — FNO는 monolithic; HyCOP은 FNO를 하나의 모듈로 사용 가능

## References
- arXiv:2605.00820 — cs.CE, cs.LG, math.NA
