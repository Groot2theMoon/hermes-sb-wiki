---
title: Replay-Based Continual Learning for Physics-Informed Neural Operators
created: 2026-05-11
updated: 2026-05-11
type: concept
tags: [paper, neural-operator, operator-learning, surrogate-model, physics-informed, continual-learning]
confidence: medium
sources: []
---

# Replay-Based Continual Learning for PINOs

## 개요
arXiv:2605.04832 (May 2026)는 **continual learning (CL)을 physics-informed neural operators (PINOs)에 최초로 도입**한 연구다. Transolver 아키텍처 기반 PINO에 replay 기반 CL 전략을 적용하여, out-of-distribution (OOD) 문제에서 catastrophic forgetting을 방지하면서도 새로운 물리 도메인에 빠르게 적응하는 방법을 제안한다.

## 핵심 아이디어
- **Replay + Distillation:** 새로운 OOD 데이터가 들어오면 소량의 과거 데이터를 distillation 기반 제약 조건과 함께 replay하여 기존 지식을 보존
- **LoRA transfer learning:** 새로운 도메인에 빠르게 적응하기 위해 parameter-efficient fine-tuning (LoRA) 적용
- **Fully physics-informed:** 레이블 데이터 없이 입력 필드 + 물리 제약 조건만으로 학습
- **검증 문제:** Darcy flow (유체 역학), 2D hyperelastic brain tumor (생체 역학), 3D linear elastic TPMS (고체 역학)

## 연결점
- [[continual-learning-physical-systems]] — 물리 시스템에서의 continual learning (기존 CL 방법론과의 차별점)
- [[operator-learning]] — Transolver 기반 neural operator 아키텍처
- [[physics-informed]] — 완전 물리 기반 학습 (레이블 불필요)

## References
- arXiv:2605.04832 — Replay-Based Continual Learning for Physics-Informed Neural Operators
