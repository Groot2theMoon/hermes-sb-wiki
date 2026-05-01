---
title: "Differentiable LMI for Contractivity — Train-Time Stability Enforcement"
created: 2026-05-02
updated: 2026-05-02
type: concept
tags: [differentiable-lmi, contractivity, lure-system, shima-lmi, bullo-param, stability]
sources:
  - raw/papers/bullo-nonlinear-separation-principle.md
  - raw/papers/lmi-net-differentiable-projection.md
  - raw/papers/non-euclidean-contractivity.md
confidence: high
---

# Differentiable LMI for Contractivity — Train-Time Stability Enforcement

## 개요

RIGOR의 A+NN 동역학 (x_{t+1} = A·x_t + NN(x_t))은 Lur'e system이며, Shima et al. (2025)의 contractivity LMI로 필요충분 안정성 검증이 가능하다. 그러나 학습 중 이 LMI를 SDP 없이 differentiable하게 적용하는 것이 핵심 과제.

단순한 triangle inequality 조건 (∥A∥₂ + L < ρ)은 lmi.py line 56에 inference-time 검증으로 이미 구현되어 있으며, train-time penalty로 넣어도 새로운 정보가 없다 (∥A∥₂ + L < ρ 조건만으로는 P (Lyapunov matrix)의 상태 공간 geometry를 고려하지 못함).

2026년 3-4월에 발표된 3편의 논문이 이 문제를 해결하는 서로 다른 접근법을 제시함.

## 3가지 접근법

### A. Bullo Exact Unconstrained Parameterization (권장)

**Gokhale, Proskurnikov, Kawano & Bullo (2026).** arXiv:2604.15238, 2604.00119.

**핵심:** Contraction LMI 조건을 weight space에 **대수적으로 내장하는 exact unconstrained parameterization** (Theorem 35).

```
학습 중:  θ (unconstrained) → W(θ) (by construction contractive)
                                  ↑ algebraic map (Theorem 35)
          P(θ) = L(θ)L(θ)^T       λ(θ) = softplus(λ̃)
          JAX에서 완전 미분 가능, no SDP required

배포 시:  check_contractivity_lmi(W) → 항상 통과 (by construction)
```

**장점:**
- 학습 중 SDP 불필요 (zero-overhead)
- Hard constraint guarantee (by construction)
- P = LL^T로 Lyapunov matrix 포함 → state space geometry 고려
- Unconstrained SGD 가능

**단점:**
- Theorem 35의 대수적 parameterization을 RIGOR에 맞게 구현 필요
- 코드 미공개 (April 2026 기준)

**RIGOR 관련성:** Discrete-time firing-rate RNN contraction LMI와 Shima Lur'e LMI는 구조적으로 동일. Bullo의 parameterization 기법을 Shima LMI에 직접 적용 가능.

### B. LMI-Net: Differentiable Projection Layer

**Tang, Goertzen & Azizan (2026).** arXiv:2604.05374.

**핵심:** Douglas-Rachford splitting + implicit differentiation으로 LMI feasible set에 projection하는 differentiable layer.

```
Forward:  W_raw → Douglas-Rachford splitting (10-20 iter) → W_feasible (LMI satisfied)
Backward: Implicit differentiation via fixed-point (no unrolling)
```

**장점:**
- Modular drop-in layer (기존 NN 구조 변경 불필요)
- Hard constraint guarantee
- Implicit diff로 backward 효율적

**단점:**
- Forward pass에 10-20회 iteration 필요 (overhead)
- Bullo param보다 덜 elegant

### C. Non-Euclidean Contractivity (p=1/p=∞)

**Kuang & Lin (2026).** arXiv:2604.00490.

**핵심:** 1-norm 또는 ∞-norm에서 contractivity는 O(d²) 비용으로 검증 가능.

**구조 정리:** 모든 WIC (weakly infinitesimally contracting) vector field는 f(x) = -γx + φ(x), ∥φ∥_{Lip,p} ≤ γ로 표현 가능.

**장점:**
- O(d²) — LMI/SDP 불필요
- Trivially differentiable
- 구조 정리가 명확한 parameterization 제공

**단점:**
- Euclidean (p=2)보다 표현력 제한적
- P의 기하학적 reshaping 상실

## 비교

| 축 | A. Bullo Exact Param | B. LMI-Net Projection | C. Non-Euclidean p=1/∞ |
|:---|:-------------------:|:-------------------:|:--------------------:|
| Hard guarantee | ✅ By construction | ✅ Forward pass 검증 | ✅ By construction |
| P 고려 | ✅ (P=LL^T) | ✅ (P 변수 포함) | ❌ |
| 학습 overhead | 0 | 10-20 iter/step | 0 |
| JAX 호환 | ✅ 완벽 | ⚠️ PyTorch 구현, JAX port 필요 | ✅ 완벽 |
| 구현 난이도 | 중간 (Theorem 35) | 낮음 (모듈형) | 낮음 |
| 표현력 | 높음 | 높음 | 중간 |

## RIGOR 적용 권장

**Phase 1:** Bullo exact parameterization (Option A)을 RIGOR의 A+NN dynamics에 적용. DeltaModulator의 weight를 unconstrained parameter θ로부터 contractive W(θ)로 mapping.

**Phase 2:** LMI-Net (Option B)를 fallback으로 준비 (Bullo 구현이 어려울 경우).

**Phase 3:** Non-Euclidean contractivity (Option C)는 lightweight 대안으로 유지 (LMI가 필요 없는 간단한 시스템용).

## EM Q,R + LMI Novelty

이 조합을 시도한 논문은 0건 확인됨. "EM-based adaptive noise covariance + LMI-based contractivity enforcement"는 differentiable filtering 분야에서 **unexplored synergy**.

## References
- Shima, R., Davydov, A. & Bullo, F. (2025). Contractivity Analysis for Lur'e Systems. arXiv:2503.20177.
- Gokhale, A., Proskurnikov, A. V., Kawano, Y. & Bullo, F. (2026). A Nonlinear Separation Principle via Contraction Theory. arXiv:2604.15238.
- Gokhale, A., Proskurnikov, A. V., Kawano, Y. & Bullo, F. (2026). Contracting Neural Networks: Sharp LMI Conditions. arXiv:2604.00119.
- Tang, S., Goertzen, A. & Azizan, N. (2026). LMI-Net: LMI-Constrained Neural Networks via Differentiable Projection Layers. arXiv:2604.05374.
- Kuang, Z. & Lin, W. (2026). Incremental Stability in Non-Euclidean Norms. arXiv:2604.00490.
- Revay, M., Wang, R. & Manchester, I. R. (2020). A Convex Parameterization of Robust Recurrent Neural Networks. arXiv:2004.05290.
