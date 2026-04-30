---
title: "Contractivity Analysis for Lur'e Systems — Shima, Davydov & Bullo 2025"
created: 2026-05-01
updated: 2026-05-01
type: concept
tags: [contractivity, lure-system, lmi, lipschitz, sector-bound, monotone, stability]
sources:
  - raw/papers/shima-davydov-bullo-contractivity-lure-systems.md
confidence: high
---

# Contractivity Analysis for Lur'e Systems

> **Shima, R., Davydov, A. & Bullo, F. (2025).** "Contractivity Analysis and Control Design for Lur'e Systems: Lipschitz, Incrementally Sector Bounded, and Monotone Nonlinearities." arXiv:2503.20177. To appear at CDC 2025.

## 개요

Lur'e system의 **contractivity**에 대한 필요충분 LMI 조건을 제시. Lipschitz, incrementally sector bounded, monotone nonlinearity 각각에 대해 통합된 LMI 프레임워크 제공.

## 핵심 기여

1. **Lipschitz nonlinearity** — 필요충분 contractivity LMI (기존 연구는 충분조건만)
2. **Incrementally sector bounded** — 동일하게 필요충분 LMI
3. **Monotone nonlinearity** — mild symmetry 가정 하에 sector bounded의 특수 케이스로 포함
4. **Discrete-time 버전** — 동일한 LMI 프레임워크
5. **Controller gain design LMI** — closed-loop contractivity 보장

## 주요 LMI (Lipschitz case, discrete-time)

행렬 A (linear part)와 Lipschitz 상수 L인 비선형성 φ에 대해,
contractivity rate ρ < 1의 필요충분조건:

```
∃ P > 0, λ ≥ 0 s.t.
[ A^T P A - ρ^2 P + λ L^2 I    A^T P B    ]  ⪯ 0
[ B^T P B - λ I               B^T P B     ]  ⪯ 0
```

## RIGOR 관련성

RIGOR의 A+NN 구조 (x→A·x + NN(x)):
- **A** = linear part (known)
- **NN** = φ(C·x) with C=I, B=I
- **L** = Lipschitz 상수 of NN (layer-wise weight norm product)
- 위 LMI로 **필요충분 contractivity 검증 가능**
- Controller gain design LMI로 학습 중 안정성 제약 조건 추가 가능

## Authors
- [[ryotaro-shima]] — UCSB
- [[alexander-davydov]] — UCSB
- [[francesco-bullo]] — UCSB

## Related
- [[lure-stability]] — Lur'e stability 통합 개념
- [[hedesh-siami-sector-bound]] — NN sector bound
