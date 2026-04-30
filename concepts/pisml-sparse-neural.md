---
title: PISML — Physics-Informed Sparse ML (Sparse + Neural Residual for Dynamics Discovery)
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [system-identification, sparse-regression, neural-residual, hybrid-modeling, power-systems]
sources: [raw/papers/zheng26_pisml.md]
confidence: medium
---

# PISML (Zheng 2026)

## 개요

**Zheng, Batta, Liu & Lu** (IEEE TPEL 2026)가 제안한, **sparse symbolic backbone + neural residual branch**로 inverter governing equation을 발견하는 Physics-Informed Sparse Machine Learning 프레임워크. A+NN 구조와 동일한 패러다임 — sparse part가 물리적 골격(skeleton)을 담당하고, neural branch가 complex nonlinear control logic을 보정.

> Zheng, J. et al. (2026). Discovering Unknown Inverter Governing Equations via Physics-Informed Sparse Machine Learning. *IEEE Trans. Power Electronics*. arXiv:2602.16166.

## 핵심 아이디어

### PISML 구조

```
입력: external measurements (inverter terminal voltage/current)
     ↓
┌──────────────────────────────────────────────┐
│  🔷 Sparse Symbolic Backbone                   │
│  → 물리적 법칙에 기반한 sparse ODE 형태         │
│  → 해석 가능한 지배 방정식의 골격(skeleton)     │
├──────────────────────────────────────────────┤
│  🔶 Neural Residual Branch                     │
│  → Black-box nonlinear control logic 학습       │
│  → Sparse backbone이 설명 못하는 residual 보정  │
├──────────────────────────────────────────────┤
│  Jacobian-Regularized Physics-Informed Training │
│  → Large-scale + small-scale behavior 동시 보존 │
└──────────────────────────────────────────────┘
     ↓
Symbolic Regression on neural residual → explicit equation
```

### Multi-Scale Physics-Informed Training

$$L = L_{\text{data}} + \lambda_1 L_{\text{physics}} + \lambda_2 L_{\text{jacobian}}$$

- $L_{\text{physics}}$: ODE residual constraint
- $L_{\text{jacobian}}$: Jacobian-scale consistency (small-signal behavior)
- Multi-scale consistency → **local dynamics + global dynamics 동시 보존**

### 최종 출력: 완전한 해석적 ODE

1. Sparse backbone → dominant physical terms
2. Neural residual → symbolic regression → compact explicit form
3. **최종 출력은 fully interpretable ODE**

## RIGOR과의 연결점

PISML과 RIGOR의 **A+NN 구조는 동일한 패러다임**:

| 구성 요소 | PISML | RIGOR |
|----------|-------|-------|
| **물리 파트** | Sparse symbolic ODE | **A matrix (learned linear dynamics)** |
| **신경망 파트** | Neural residual branch | **NN residual (spectrally-normalized)** |
| **분해 보장** | Jacobian regularization | **Orthogonal projection regularization** |
| **최종 목표** | 완전히 해석 가능한 ODE | **A: physics 해석 + NN: residual 보정** |
| **Domain** | Inverter power systems | **Mechanical/chaotic systems** |

## References

- Zheng, J. et al. (2026). Discovering Unknown Inverter Governing Equations via PISML. *IEEE TPEL*.
- [[orthogonal-projection-regularization]] — Győrök (2025) — 같은 A+NN identifiability 문제 해결
- [[structured-hybrid-mechanistic-models]] — A+NN 패러다임의 일반 이론
- [[universal-differential-equations]] — UDE (Universal DE)
