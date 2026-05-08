---
title: "Neural Operator Framework for Data-Driven Stability & Receptivity"
created: 2026-05-08
updated: 2026-05-08
type: concept
tags: [neural-operator, fluid-dynamics, neural-network, surrogate-model, dynamics, paper, koopman]
confidence: medium
---

# Neural Operator Framework for Data-Driven Stability & Receptivity

## 개요

**Ranade, Pathak & Subramanian (2026)** ^[arXiv:2604.19465]이 제안하는 프레임워크는 **신경망 dynamics emulator**를 학습하고 **자동 미분(automatic differentiation)** 으로 Jacobian을 추출하여, 전통적인 선형 안정성 해석(linear stability analysis)과 resolvent analysis를 **데이터만으로** 수행한다. 즉, governing equation 없이 관측 데이터만으로 유동의 불안정 모드와 입출력 구조를 식별한다.

## 핵심 아이디어

- 신경망을 dynamics emulator로 학습 ($u_{t+1} = f_\theta(u_t)$)
- Autodiff로 Jacobian $\nabla_u f_\theta$ 추출 → 고유모드(eigenmode) 계산
- Resolvent analysis ($(i\omega I - J)^{-1}$)로 최적 강제 응답(optimal forcing response) 식별
- 고차원 유동에 대해 model reduction 적용
- 강한 비선형 영역에서도 지배적 불안정 모드 식별 성공
- 기존 DMD 기반 resolvent analysis보다 풍부한 비선형 동역학 포착

## 연결점
- [[koopman-operator-theory]] — Jacobian 기반 접근과 Koopman DMD의 관계
- [[dynamic-sparsity-perception]] — 데이터 기반 동역학 분석의 대안적 접근
- [[fourier-neural-operator]] — emulator로 FNO 계열 사용 가능성
- [[fluid-dynamics]] — 유동 안정성 해석의 핵심 응용 도메인

## References
- arXiv:2604.19465 — A neural operator framework for data-driven discovery of stability and receptivity in physical systems
