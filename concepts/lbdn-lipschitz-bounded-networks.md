---
title: "LBDN — Lipschitz-Bounded Deep Networks via Direct Parameterization"
created: 2026-05-01
updated: 2026-05-01
type: concept
tags: [lipschitz, sdp, robust-accuracy, sandwich-layer, certification]
sources:
  - raw/papers/lbdn-lipschitz-bounded-networks-wang23.md
confidence: high
---

# LBDN — Lipschitz-Bounded Deep Networks

> **Wang, R. & Manchester, I. R. (2023).** "Direct Parameterization of Lipschitz-Bounded Deep Networks." ICML 2023. arXiv:2301.11526.

## 개요

SDP 기반 ℓ₂ Lipschitz bound의 **직접 파라미터화** — SDP 제약 조건을 weight space에 내장하는 방법. **Sandwich layer**라는 새로운 레이어 타입 제안.

## 핵심 기여

1. **SDP Lipschitz bound ↔ weight parameterization의 동치성 증명**
2. **Sandwich layer**: weight sharing을 통한 direct parameterization
3. 기존 projection/barrier 방법보다 **더 나은 empirical + certified robust accuracy**

## 다른 Lipschitz 방법과의 관계

| 축 | LBDN | AOL | LipKernel |
|------|------|-----|-----------|
| 수학 기반 | SDP 직접 파라미터화 | Spectral norm rescaling | 2-D Roesser LMI |
| Lipschitz bound | ℓ₂ (SDP) | ℓ₂ (spectral) | ℓ₂ (generalized Q,R) |
| 구현 복잡도 | 높음 (SDP 이해 필요) | 낮음 | 중간 |
| Conv 적용 | Sandwich layer | Channel-wise scaling | Kernel 직접 param. |

## RIGOR 관련성

LBDN의 접근법은 Shima의 Lur'e contractivity LMI와 직접 연결:
- LBDN: SDP-based ℓ₂ Lipschitz bound를 weight에 내장
- Shima LMI: Lur'e system contractivity의 필요충분 LMI
- **→ RIGOR의 spectral normalization을 LBDN 스타일의 direct LMI parameterization으로 대체 가능**

## Authors
- [[ruigang-wang]], [[ian-r-manchester]]

## Related
- [[shima-contractivity-lure]] — Lur'e contractivity LMI
- [[lure-stability]] — Lur'e stability 통합 개념
- [[spectral-normalization-gan]] — 기존 spectral normalization
- [[aol-almost-orthogonal-layers]] — AOL: spectral rescaling 기반
- [[lipkernel-dissipative-cnn]] — LipKernel: 2-D Roesser dissipativity 기반
