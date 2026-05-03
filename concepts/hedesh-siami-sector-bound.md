---
title: "Sector-Bounded Nonlinearity for NN-Controlled Systems — Hedesh & Siami 2024"
created: 2026-05-01
updated: 2026-05-03
type: concept
tags: [sector-bound, nn-control, lure-system, aizerman, stability, positive-system]
sources:
  - raw/papers/hedesh-siami-positivity-stability-sector-bound-nn.md
confidence: high
---

# Sector-Bounded Nonlinearity for NN-Controlled Systems

> **Hedesh, Montazeri H. & Siami, M. (2024).** "Ensuring Both Positivity and Stability Using Sector-Bounded Nonlinearity for Systems with Neural Network Controllers." arXiv:2406.12744.

## 개요

FFNN (bias 없음) 전체에 대한 **sector bound**를 제시하고, positive Lur'e system에서의 안정성 검증에 활용.

## 핵심 기여

1. **FFNN sector bound 계산법** — weight 행렬과 activation function에서 직접 sector [α, β] 도출
2. **Positive Aizerman conjecture 기반 안정성 정리** — sector bound의 upper/lower bound가 각각 Hurwitz/Metzler 조건을 만족하면 global exponential stability
3. **연속시간 시스템 지원** — 대부분의 NN verification 방법이 이산시간에 집중된 것과 차별화

## 방법론

- **Sector [α, β]**: NN(x) ∈ [αx, βx] for all x (elementwise). 즉 input-output map이 linear cone 내에 존재.
- **α, β 계산**: 최대/최소 activation slope × weight norm으로부터 도출
- **기존 IBP/Lipschitz와의 차이점**: IBP는 output polytope의 bound (input-output 관계 없음), Lipschitz는 scalar. Sector bound는 input-output 직접 관계 + 다차원 가능.

## RIGOR 관련성

A+NN 구조의 NN_θ(·)에 sector bound [α, β]를 계산하면:
- α와 β로 선형 부분 A의 effective gain range 결정
- Shima의 contractivity LMI에 입력 → polynomial-time stability verification
- **Heuristic total budget을 rigorous sector-bound LMI로 대체 가능**

## Authors
- [[hamidreza-montazeri-hedesh]] — Northeastern University
- [[milad-siami]] — Northeastern University

## Related
- [[lure-stability]] — Lur'e stability 통합 개념
- [[shima-contractivity-lure]] — Contractivity LMI
- [[monotone-operator-equilibrium-networks]] — monDEQ: $I - W \succeq mI$ 강한 단조성 조건 → sector-bound nonlineary의 극단적 사례에 해당
