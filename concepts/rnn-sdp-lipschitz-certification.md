---
title: "RNN-SDP — Lipschitz Robustness Certification for RNNs"
created: 2026-05-01
updated: 2026-05-01
type: concept
tags: [lipschitz, sdp, rnn, certification, robustness, convex-relaxation]
sources:
  - raw/papers/rnn-sdp-lipschitz-certification-hamelbeck25.md
confidence: high
---

# RNN-SDP — Lipschitz Robustness Certification for RNNs

> **Hamelbeck, P. & Schiffer, J. (2025).** "Lipschitz-Based Robustness Certification for Recurrent Neural Networks via Convex Relaxation." arXiv:2509.17898.

## 개요

RNN의 Lipschitz 상수 certified upper bound를 **SDP (semidefinite programming)**으로 계산하는 방법. RNN 레이어 간 상호작용을 convex problem으로 모델링.

## 핵심 기여

- RNN layer interaction → convex relaxation → certified Lipschitz upper bound
- Input constraint 통합으로 tighter bound 가능
- Sequence length 증가에도 reasonable tightness 유지
- **초기화 에러 (initialization error)의 영향 분석** — MPC에서 중요

## RIGOR 관련성

- RNN-SDP 방법론은 A+NN의 NN(·) 부분의 Lipschitz certification에 직접 적용 가능
- Shima LMI ([[shima-contractivity-lure]])에 Lipschitz 상수 대입 → contractivity 검증
- RNN-SDP → Lipschitz 상수 인증 → Shima LMI → contractivity 보장

## Authors
- [[paul-hamelbeck]], [[johannes-schiffer]]

## Related
- [[lbdn-lipschitz-bounded-networks]] — SDP Lipschitz bound의 direct parameterization
- [[lure-stability]] — Lur'e stability
