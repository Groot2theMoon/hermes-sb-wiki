---
title: "PeFNO — Physics-Encoded Fourier Neural Operator for Divergence-Free Stress"
created: 2026-05-08
updated: 2026-05-08
type: concept
tags: [neural-operator, fno, physics-informed, solid-mechanics, surrogate-model, materials, paper]
confidence: medium
---

# PeFNO — Physics-Encoded FNO for Divergence-Free Stress Fields

## 개요

**Wang, Mozaffar & Ehler (2026)** ^[arXiv:2605.00509]이 제안하는 **PeFNO (Physics-Encoded Fourier Neural Operator)** 는 응력 포텐셜(stress potential)을 기반으로 **발산-무제약(divergence-free) 응력장**을 뉴럴 네트워크 아키텍처에 직접 인코딩하는 접근법이다. 기존의 physics-informed(손실함수 페널티) 또는 physics-guided(데이터 증강) 방식과 달리, 물리 법칙을 **아키텍처 수준에서 강제(hard-constraint)**한다.

## 핵심 아이디어

- 응력 포텐셜 함수를 통해 quasi-static mechanical equilibrium ($\nabla \cdot \sigma = 0$)을 아키텍처에 내장
- FNO의 출력을 stress potential로 parameterize한 후, 자동 미분으로 응력장 계산
- 결과: 동일한 정확도에서 응력장의 발산-무제약성이 **훨씬 더 우수** (data-only FNO 대비)
- 세 가지 variants 비교: PgFNO (physics-guided) vs PiFNO (physics-informed) vs PeFNO (physics-encoded)
- 검증: 다결정(polycrystalline) 재료의 응력장 surrogate에 적용

## 연결점
- [[fourier-neural-operator]] — 기본 FNO 아키텍처의 확장
- [[physics-informed]] — physics-encoded vs physics-informed 접근법의 근본적 차이
- [[solid-mechanics]] — quasi-static equilibrium surrogate의 핵심 응용
- [[pinn-failure-modes]] — soft constraint (PINN)와 hard constraint (PeFNO)의 trade-off 비교 관점

## References
- arXiv:2605.00509 — An approach to encode divergence-free stress fields in neural approximations based on stress potentials
