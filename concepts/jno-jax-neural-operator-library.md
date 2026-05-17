---
title: "jNO — JAX Library for Neural Operator and Foundation Model Training"
created: 2026-05-17
updated: 2026-05-17
type: concept
tags: [tool, neural-operator, pde, open-source, paper]
confidence: medium
sources: [arXiv:2605.10159]
---

# jNO — JAX Neural Operator Library (Fraunhofer IISB)

## 개요

**Leon Armbruster, Rathan Ramesh, Georg Kruse, Christopher Straub (Fraunhofer IISB, 2026)** ^[arXiv:2605.10159]이 공개한 **jNO (jax Neural Operators)**는 JAX 네이티브 neural operator 및 PDE foundation model 훈련 라이브러리다.

## 핵심 특징

- **통합 지원**: data-driven + physics-informed 훈련을 동일 워크플로우에서 처리
- **Symbolic tracing 시스템**: 도메인, 모델 호출, residual, supervised loss, diagnostics를 하나의 symbolic 언어로 작성 → 단일 최적화 파이프라인으로 컴파일
- **세부 제어**: 모델/옵티마이저/learning rate의 parameter-level 제어
- **Multi-model composition**: 여러 NO 모델의 조합 및 fine-tuning 지원
- **GitHub**: https://github.com/FhG-IISB/jNO

## 의의

- 기존 NO 라이브러리(neuraloperator, FNO 등)와 달리 JAX 생태계에 특화
- Symbolic tracing으로 operator regression, mesh-aware residual evaluation, PDE-constrained training 간 전환이 코드 재구성 없이 가능

## 연결점
- [[neural-operator]] — NO 방법론의 일반적 맥락
- [[fourier-neural-operator]] — jNO로 구현 가능한 주요 NO 아키텍처
- [[surrogate-model]] — NO 기반 surrogate 모델링

## References
- arXiv:2605.10159 — Fraunhofer IISB, May 2026
- GitHub: https://github.com/FhG-IISB/jNO
