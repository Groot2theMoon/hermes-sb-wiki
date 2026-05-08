---
title: "DeepONet for Helmholtz Equation on Non-Parametric Geometries via SDF"
created: 2026-05-08
updated: 2026-05-08
type: concept
tags: [deeponet, neural-operator, acoustics, physics-informed, surrogate-model, paper]
confidence: medium
---

# DeepONet for Helmholtz Equation on Non-Parametric Geometries

## 개요

**Fresca, Manzoni, Zunino (2026)** ^[arXiv:2605.00760]이 제안하는 **physics-informed DeepONet**은 2D Helmholtz 방정식을 **비-파라메트릭(non-parametric)** 도메인에서 학습한다. 산란체(scatterer)의 경계 형상을 **부호 거리 함수(Signed Distance Function, SDF)**로 인코딩하여 DeepONet의 branch network 입력으로 사용하고, Helmholtz 방정식의 residual을 loss에 포함시킨다.

## 핵심 아이디어

- 도메인 형상을 SDF로 표현 → branch net이 형상 정보를 처리
- Trunk net은 공간 좌표 처리
- Physics-informed loss: Helmholtz PDE residual을 collocation points에서 계산
- 학습 결과: SDF 기반 형상 인코딩으로 **임의의 2D 산란체 형상에 대한 산란장(scattered field)** 예측 가능
- 기존 parametric 접근과 달리, 형상이 저차원 파라미터로 표현될 필요 없음
- 검증: 정사각형 도메인 내 임의 형상 inclusion의 Helmholtz 산란 문제

## 연결점
- [[deeponet]] — 기본 DeepONet 아키텍처의 non-parametric 응용
- [[physics-informed]] — PINN 방식의 residual loss를 operator learning에 통합
- [[transfer-matrix-method-acoustic-porous]] — TMM과 비교하여 Helmholtz 방정식 직접 해석의 장점
- [[acoustics]] — Helmholtz 방정식 기반 음향 산란 문제의 핵심 응용
- [[low-frequency-absorption-technologies-comparison]] — 산란 해석이 흡음재 설계에 활용 가능

## References
- arXiv:2605.00760 — Learning the Helmholtz equation operator with DeepONet for non-parametric 2D geometries
