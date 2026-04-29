---
title: Quadratic ISS Lyapunov Functions for Linear Analytic Systems
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [mathematics, control-system, paper]
sources: [raw/papers/2303.15093v2.md]
confidence: high
---

# Quadratic ISS Lyapunov Functions for Linear Analytic Systems

## 개요

[[andrii-mironchenko|Andrii Mironchenko]], Felix L. Schwenninger가 제안한 이 연구는 **무한 차원 선형 해석적 시스템(infinite-dimensional linear analytic systems)**에 대한 **입력-상태 안정성(Input-to-State Stability, ISS)의 역 Lyapunov 정리(converse Lyapunov theorem)**를 최초로 증명한다^[raw/papers/2303.15093v2.md].

## 핵심 결과

### 주요 정리

1. **선형 시스템의 ISS ≠ coercive quadratic ISS Lyapunov 함수 존재**: 입력 연산자 $B$가 유계(bounded)이고 semigroup이 analytic이어도 coercive quadratic ISS Lyapunov 함수가 항상 존재하는 것은 아니다.
2. **충분 조건**: semigroup이 Hilbert 공간에서 contraction semigroup과 유사(similar)하면, 모든 유계 입력 연산자 $B$에 대해 coercive quadratic ISS Lyapunov 함수가 존재한다.
3. **비자족(non-coercive) ISS Lyapunov 함수**: 더 약한 조건에서도 non-coercive ISS Lyapunov 함수 구성 가능.

### 응용 분야

- **PDE 경계 제어 시스템** (특히 Dirichlet 경계 입력이 있는 열 방정식)
- 유계(bounded) 및 비유계(unbounded) 입력 연산자 모두 분석
- 비선형 PDE의 ISS 분석을 위한 Lyapunov 방법 발전에 기여

### 수학적 배경

- **ISS Lyapunov 함수 정의**: $V(x) = \langle Px, x \rangle$ 형태 (자기수반, 양의 정부호 연산자 $P$)
- **Coercive**: $\alpha_1(\|x\|) \leq V(x) \leq \alpha_2(\|x\|)$를 만족
- **$L^p$-ISS Lyapunov 함수**: $p=2$일 때만 quadratic 형태 가능 (증명됨)

## 관련 개념

- [[physics-informed]] — PDE 해결을 위한 다른 ML 접근법
- **Input-to-State Stability (ISS)** — 제어 시스템의 강건 안정성 개념
- **Lyapunov Function** — 동적 시스템 안정성 분석의 핵심 도구
- **Analytic Semigroup** — 포물형 PDE의 해석적 성질
- [[iss-lyapunov-theory]] — ISS 일반 이론
- [[pseudo-hamiltonian-neural-networks]] — ML+Hamiltonian
