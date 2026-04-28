---
title: When and Why PINNs Fail — NTK Perspective
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [physics-informed, model, training, mathematics, paper]
sources: [raw/papers/1-s2.0-S002199912100663X-main.md]
confidence: high
---

# When and Why PINNs Fail: An NTK Perspective

Wang, Yu, [[paris-perdikaris|Perdikaris]] (2021)가 Journal of Computational Physics에 발표한 논문으로, **Neural Tangent Kernel (NTK) 관점에서 PINN 학습 실패 원인을 규명**한다^[raw/papers/1-s2.0-S002199912100663X-main.md].

- PINN 손실 함수의 여러 항(PDE residual, BC, IC)이 **서로 다른 수렴 속도**를 가짐
- NTK 고유값 분해로 각 손실 항의 **spectral bias** 분석
- PDE residual과 boundary 조건 간 **kernel conditioning 불균형**이 수렴 실패의 주 원인
- **학습 가능한 가중치(learnable weights)**로 각 손실 항의 균형 자동 조절 → **학습 안정성 대폭 개선**
- PINN이 고주파수(high-frequency) 해에 취약한 이유를 NTK 이론으로 설명
- [[neural-tangent-kernel]]의 직접적 응용 사례
- [[physics-constrained-surrogate]], [[bayesian-pinns]]와 함께 PINN 3대 핵심 이론