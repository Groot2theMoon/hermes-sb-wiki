---
title: "HyParLyVe — Hyperplane Partitioning for Neural Lyapunov Verification"
created: 2026-05-09
updated: 2026-05-09
type: concept
tags: [lyapunov, neural-network-control, safety, verification, paper]
confidence: medium
sources: [arXiv:2605.03992]
---

# HyParLyVe — Hyperplane Partitioning for Neural Lyapunov Verification

## 개요

**Wayment, Yarbrough, Wang, Sundaram & Paré (2026, Purdue University)** ^[arXiv:2605.03992]이 제안하는 **HyParLyVe (Hyperplane Partitioned Lyapunov Verifier)** 는 얕은 ReLU 네트워크를 **초평면 배치(hyperplane arrangement)**로 해석하여 Neural Lyapunov 후보 함수의 **sound and complete verification**을 수행하는 알고리즘이다.

## 핵심 아이디어

- ReLU NN = hyperplane arrangement → **양의 정부호성(positive definiteness)** 검증을 유한한 정점 평가로 축소
- **감소 조건(decrease condition)** 검증을 각 영역별 bounded optimization problem으로 변환
- Invariant set과 region of attraction 발견에도 활용 가능
- 기존 SMT/SDP 기반 검증 도구 대비 **이론적으로 sound하면서도 실용적인** 대안 제시

## 연결점

- [[lyapunov-neural-network]] — Neural Lyapunov 함수 학습의 맥락
- [[lyapunov-stable-nn-control]] — Lyapunov 안정성을 보장하는 NN 제어
- [[safety]] — 안전-critical 시스템 검증
- [[lure-stability]] — Lur'e 시스템 안정성 분석과의 연결점

## References
- arXiv:2605.03992 — eess.SY
