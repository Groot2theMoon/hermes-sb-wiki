---
title: "REN — Recurrent Equilibrium Networks with Guaranteed Stability and Robustness"
created: 2026-05-01
updated: 2026-05-01
type: concept
tags: [contracting, ren, iqc, lipschitz, stability, nn-dynamics, system-identification]
sources:
  - raw/papers/ren-recurrent-equilibrium-networks-revay21.md
confidence: high
---

# REN — Recurrent Equilibrium Networks

> **Revay, M., Wang, R. & Manchester, I. R. (2021).** "Recurrent Equilibrium Networks: Flexible Dynamic Models with Guaranteed Stability and Robustness." arXiv:2104.05942. To appear in IEEE TAC.

## 개요

REN은 **contracting** (강한 비선형 안정성)과 **IQC** (Lipschitz bound, incremental passivity 등)가 **내장된** 비선형 동적 모델 클래스. 안정성/강건성이 파라미터 제약 없이 보장되므로 unconstrained optimization (SGD)로 학습 가능.

## 핵심 특징

- **모든 contracting RNN, ESN, feedforward NN, stable linear system, Wiener/Hammerstein 모델을 표현 가능**
- **모든 fading-memory 및 contracting 비선형 시스템을 근사 가능** (universal approximation)
- 파라미터 직접 파라미터화 (R^N → 모델) → 제약 없는 SGD 학습
- IQC 기반 강건성 보장 (Lipschitz, passivity 등)

## RIGOR 관련성

REN의 contracting property는 A+NN 구조의 안정성 보장과 직접 연결:
- REN = A·x_t + f(x_t, u_t) 형태로 A+NN과 유사한 구조
- Contractivity LMI ([[shima-contractivity-lure]])와 REN의 IQC 보장은 complementary
- REN의 direct parameterization 아이디어 → RIGOR의 spectral normalization을 대체 가능성?

## Authors
- [[max-revay]], [[ruigang-wang]], [[ian-r-manchester]]

## Related
- [[youla-ren-stabilizing-controllers]] — Youla-REN: 모든 안정화 비선형 제어기 학습
- [[lure-stability]] — Lur'e stability 분석
