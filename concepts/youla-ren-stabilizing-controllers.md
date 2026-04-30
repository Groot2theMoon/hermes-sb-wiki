---
title: "Youla-REN — Learning over All Stabilizing Nonlinear Controllers"
created: 2026-05-01
updated: 2026-05-01
type: concept
tags: [youla, ren, stabilizing-control, nonlinear-control, partial-observation]
sources:
  - raw/papers/youla-ren-stabilizing-nonlinear-control-wang21.md
confidence: high
---

# Youla-REN — Stabilizing Nonlinear Controller Learning

> **Wang, R., Barbara, N. H., Revay, M. & Manchester, I. R. (2021).** "Learning over All Stabilizing Nonlinear Controllers for a Partially-Observed Linear System." arXiv:2112.04219.

## 개요

**비선형 Youla 파라미터화** + [[ren-recurrent-equilibrium-networks|REN]]을 결합하여, **부분 관측 선형 시스템에 대한 모든 안정화 비선형 제어기**를 학습하는 프레임워크.

## 핵심 기여

1. REN이 contracting + Lipschitz 비선형 시스템의 universal approximator임을 증명
2. Youla-REN 아키텍처가 모든 안정화 비선형 제어기의 universal approximator임을 증명
3. Unconstrained optimization으로 학습 가능 (안정성 보장 때문)
4. Model-based (exact gradient) + RL (zeroth-order) 모두 지원

## RIGOR 관련성

RIGOR가 A+NN + EM Q,R로 system identification을 수행할 때:
- Youla-REN의 "안정화 제어기 공간 전체를 탐색"하는 아이디어를
- "안정한 system dynamics 공간을 탐색"하는 방식으로 확장 가능
- 특히 EM Q,R + Lur'e LMI 안정성 조건 = 학습 중 안정성 보장

## Authors
- [[ruigang-wang]], [[ian-r-manchester]], [[max-revay]]

## Related
- [[ren-recurrent-equilibrium-networks]] — REN 기본
- [[lure-stability]] — Lur'e stability
