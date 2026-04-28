---
title: Neural Tangent Kernel (NTK)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, training, mathematics, paper]
sources: [raw/papers/1806.07572v4.md]
confidence: high
---

# Neural Tangent Kernel (NTK)

**NTK**는 Jacot, Gabriel, Hongler (EPFL, 2018)가 제안한 이론으로, **무한 너비(infinite-width) 극한에서 신경망의 학습이 kernel regression과 동등**함을 증명한다^[raw/papers/1806.07572v4.md].

- 초기화 시 infinite-width ANN은 **Gaussian process (NNGP)**와 동등
- 학습 중 network function $f_\theta$는 **NTK를 가진 linear dynamics**를 따름
- $\partial_t f_t(x) = -\sum_i \text{NTK}(x, x_i) \cdot (f_t(x_i) - y_i)$
- 유한 너비에서도 NTK로 수렴 특성 분석 가능
- [[universal-approximation-theorem]]을 kernel 방법 관점에서 확장
- 이후 PINN 학습 실패 분석("When and why PINNs fail")에서 NTK 관점이 핵심 도구로 활용
- [[pinn-failure-modes]] — NTK로 PINN 실패 분석
- [[universal-approximation-theorem]] — 함수 근사
