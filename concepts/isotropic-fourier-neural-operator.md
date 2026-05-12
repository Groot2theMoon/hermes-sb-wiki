---
title: "Iso-FNO — Isotropic Fourier Neural Operators for Symmetry-Preserving PDE Learning"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [paper, neural-operator, fno, pde, surrogate-model, symmetry]
confidence: medium
sources: [arXiv:2605.02597]
---

# Iso-FNO — Isotropic Fourier Neural Operators

## 개요
**Michael F. Staddon (2026)** — arXiv:2605.02597 (cs.LG, May 2026)은 표준 Fourier Neural Operator (FNO)의 Fourier 레이어에서 파수(wavenumber)별 선형 변환이 **공간 대칭성(spatial symmetry)**을 존중하지 않는 문제를 해결한다. 대부분의 물리 시스템은 등방성(isotropic)이므로 결과가 좌표계 선택에 무관해야 하지만, 기존 FNO는 이를 보장하지 않는다.

## 핵심 아이디어
- **Isotropic linear transformation:** Fourier 모드에 적용되는 선형 변환을 등방성 대칭성을 만족하도록 수정
- **효과:** 모델 성능 향상 + 파라미터 수 2D에서 최대 16배, 3D에서 최대 96배 감소
- **물리적 일관성:** 좌표계에 무관한 물리 법칙을 학습할 수 있어 역학/재료 시뮬레이션에 적합

## 연결점
- [[fourier-neural-operator]] — 기존 FNO와 Iso-FNO의 차이 (대칭성 vs 무대칭성)
- [[physics-informed]] — 물리 대칭성을 아키텍처에 내장하는 접근법
- [[operator-learning]] — Neural operator 학습의 일반적인 맥락

## References
- arXiv:2605.02597 — Isotropic Fourier Neural Operators
