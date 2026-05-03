---
title: "Local Stability and ROA for NN Feedback Systems — Hedesh, Wafi & Siami 2025"
created: 2026-05-01
updated: 2026-05-03
type: concept
tags: [local-stability, roa, lure-system, sector-bound, lmi, nn-control]
sources:
  - raw/papers/hedesh-local-stability-nn-feedback-positivity.md
confidence: high
---

# Local Stability and ROA for NN Feedback Systems

> **Hedesh, H. M., Wafi, M. K. & Siami, M. (2025).** "Local Stability and Region of Attraction Analysis for Neural Network Feedback Systems under Positivity Constraints." arXiv:2505.22889.

## 개요

Positive Lur'e system에 **localized Aizerman conjecture**를 적용하여,
NN 피드백 시스템의 **local exponential stability + ROA 추정** 방법 제시.

## 핵심 기여

1. **Localized positive Aizerman conjecture** — compact set 내 궤적의 exponential stability 충분조건
2. **Lyapunov-based LMI 방법** — quadratic Lyapunov function의 invariant sublevel set으로 ROA 추정
3. **Layer-wise local sector bound for FFNN** — 기존 global sector bound (2406.12744)의 local version. FFNN에 대한 최초의 tight local sector bound
4. **IQC보다 큰 ROA + 더 나은 scalability**

## 방법론 비교

| 방법 | ROA 크기 | Scalability | Complexity |
|------|:-------:|:----------:|:----------:|
| IQC 기반 | 작음 | 나쁨 (고차원 비현실적) | 높음 |
| Lyapunov LMI (제안) | 중간 | 좋음 | O(n³) |
| Local sector bound (제안) | **큼** | **가장 좋음** | O(n·L) |

## RIGOR 관련성

- A+NN이 Lur'e system일 때, **sector bound가 tight할수록 안정성 보장 범위 확대**
- Local sector bound는 global bound보다 덜 보수적 → **더 넓은 state space에서 안정성 보장 가능**
- 학습 초기 (NN 가중치 불안정)의 local stability 분석에 활용 가능

## Authors
- [[hamidreza-montazeri-hedesh]] — Northeastern University
- [[milad-siami]] — Northeastern University
- Moh Kamalul Wafi — Northeastern University

## Related
- [[lure-stability]] — Lur'e stability 통합 개념
- [[hedesh-siami-sector-bound]] — Global sector bound for FFNN
- [[shima-contractivity-lure]] — Contractivity LMI
- [[monotone-operator-equilibrium-networks]] — monDEQ: monotone operator 접근법과 Lur'e ROA 분석의 연결점
