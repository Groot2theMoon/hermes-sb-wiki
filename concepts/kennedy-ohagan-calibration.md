---
title: Kennedy-O'Hagan Bayesian Calibration
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [surrogate-model, model, mathematics, paper]
sources: [raw/papers/kennedy01.md, raw/papers/Kennedy-PredictingOutputComplex-2000.md]
confidence: high
---

# Kennedy-O'Hagan Framework for Computer Model Calibration

Kennedy & O'Hagan (Sheffield, 2001)는 **컴퓨터 모델의 Bayesian 보정(calibration)** 프레임워크를 제시했다^[raw/papers/kennedy01.md]. 복잡한 전산 코드를 Gaussian process surrogate로 대체하고, 모든 불확실성 소스를 체계적으로 처리한다.

**핵심:** $y(x) = \eta(x, \theta) + \delta(x) + \varepsilon$ — 모델 부적합 $\delta(x)$까지 모델링
- GP(Gaussian Process) emulator로 **비싼 전산 코드**의 surrogate 구축
- **Bayesian 접근:** 사전분포 + 관측 데이터 → 사후분포 → 예측
- [[physics-constrained-surrogate]], [[uncertainty-quantification-deep-learning]]의 고전적 전신
- 기계공학/항공우주 분야 **computer experiments**의 표준 방법론