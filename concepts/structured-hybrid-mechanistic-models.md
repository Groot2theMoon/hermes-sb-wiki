---
title: Structured Hybrid Mechanistic Models — Physics + ML for Intervention Outcome Estimation
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [hybrid-modeling, physics-informed, system-identification, learning]
sources: [raw/papers/structured-hybrid-mechanistic-models.md]
confidence: medium
---

# Structured Hybrid Mechanistic Models

물리 기반 모델과 신경망을 체계적으로 결합하여 **time-dependent intervention outcomes**을 추정하는 프레임워크.

## 핵심 아이디어

```
y(t) = f_physics(t, θ) + f_NN(t, residual context)
```

- 물리 모델이 main dynamics 담당
- NN이 알려지지 않은 intervention 효과 / residual 학습
- A+NN 구조와 동일한 패러다임

## 관련 페이지
- [[orthogonal-projection-regularization]] — 동일한 A+NN 구조에서 identifiability 해결
- [[deep-kalman-filter]] — 의료 intervention (counterfactual) 추정
- [[gru-d]] — EHR 시계열 모델링
