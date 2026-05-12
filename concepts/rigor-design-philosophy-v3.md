---
title: "RIGOR v3 Design Philosophy — A+NN Partition, UFI, Structural Skeleton"
created: 2026-05-11
updated: 2026-05-12
type: concept
tags: [rigor, kalman-filter, differentiable-filtering, architecture, design-philosophy, ufi]
sources: []
confidence: high
---

# RIGOR v3 Design Philosophy — A+NN Partition, UFI, Structural Skeleton

> Synthesis of v3.x design direction after extensive ablation experiments (May 2026).
> Focus: how to make **A the main dynamics driver**, with NN learning only residual correction,
> while preserving UKF's deterministic non-blackbox nature.

## Core Philosophy

**UKF as foundation** — chosen over EnKF / Particle Filter because:
1. **Deterministic**: No Monte Carlo sampling noise → clean gradient flow
2. **Non-blackbox**: A, Q, R, P structure is interpretable
3. **Nonlinearity via sigma points**: Deterministic propagation through known dynamics

## Central Tension

> **"A가 메인이 되도록 유도하고, NN은 residual만 배워야 한다."**

**The contradiction:**
- A is linear → Duffing's x³ term, VDP's (1-x²)v term cannot be captured by A
- NN MUST carry the nonlinear burden
- But "A as main" requires NN output to be small → conflicts with NN needing to learn nonlinearity
- Result: **velocity amplitude deficit** (~40-60% of GT)

## Empirical Findings

### Projection (SVD Row-Space): 필수

| Condition | Duffing cv (velocity) | Status |
|-----------|:---------------------:|:------:|
| Projection ON + UFI ON | ~0.96 | ✅ |
| Projection ON + UFI OFF | ~0.93 | ✅ |
| Projection OFF + UFI ON | ~0.87 | 🟡 Partial |
| Projection OFF + UFI OFF | ~0.43 | 🔴 Collapse |

**Key insight:** Projection resolves A-NN gradient competition by removing A's dominant direction from NN's output space. Without it, NN receives conflicting gradients (learn dynamics vs. correct dynamics) → collapse.

### UFI as Gradient Routing Device

UFI ([[UFI|Uncertainty Feature Injection]]) is NOT just a performance boost — it's a **gradient routing mechanism**:
- Sigma point mean/std → NN learns "what A has already covered" via information channel
- UFI ON → NN gradient flows more stably toward velocity correction
- UFI OFF → NN receives competing position and velocity gradients → collapse under high LR

**Novelty positioning:**
> "UFI: An information-theoretic gating mechanism that stabilizes A-NN gradient partitioning,
> uniquely enabled by UKF's deterministic sigma point structure."

This is **only possible in UKF** — EnKF's ensemble sampling is stochastic → noisy gradients;
Particle Filter's resampling is non-differentiable.

### Structural Skeleton (A_prior)

A_prior = [[1, dt], [-dt, 1]] × 0.9 (position-velocity coupling)

- **Principled**: Derived from dx/dt = v, dv/dt = -x (harmonic oscillator skeleton)
- **General**: Applies to ANY 2nd-order mechanical system
- **Non-heuristic**: Structural bias, not empirical tuning
- Initializes A close to true dynamics → reduces NN burden

## Component Audit: Principled vs Heuristic

| Component | Principled? | Justification |
|-----------|:-----------:|---------------|
| UKF (A, Q, R, P) | ✅ | Bayesian filtering theory |
| SVD clamping (γ=0.99) | ✅ | Bounded linear operator theory |
| Spectral normalization | ✅ | Lipschitz constraint theory |
| Structural skeleton | ✅ | Physical ODE structure (Euler integration of position-velocity coupling) |
| UFI (sigma point stats) | ✅ | Information-theoretic conditioning |
| SVD row-space projection | 🟡 | Empirically justified — works in Duffing, breaks in VDP (velocity inversion) |
| Leaky projection | ❌ | Excluded — arbitrary scaling, no theory |
| Soft penalty | ❌ | Excluded — no principled basis |

**SVD projection is the most controversial component.** It causes velocity inversion in VDP (A near-identity → u₁ aligns with position direction → projection removes position → NN alone handles velocity → unstable). In Duffing (A has damping → u₁ mixes position-velocity → projection is balanced). System-specific heuristic with empirical justification.

## ISAB: Unnecessary for Low-D

For d_state=2, ISAB ([[set-transformer|Set Transformer]]) is overkill. Raw sigma cloud (2n+1=5 sigma points × d_state=2 = 10 dim) can be directly processed by MLP. ISAB would be relevant for d_state >> 2 (e.g., d_state=50+).

## VFE / Epiplexity Philosophical Framing

**VFE (Variational Free Energy) lens:**
- UKF prediction step = **Gaussian posterior approximation** → free energy minimization
- A-NN partition = **structured mean-field** (A: coarse dynamics, NN: fine residual)
- UFI = **information bottleneck** (NN modulates correction magnitude based on uncertainty)
- Structural skeleton = **physical prior** (constraining hypothesis space → reduced free energy)

**Epiplexity lens:**
- A: linear transition (2×2, ~4 params = **low complexity**)
- NN: MLP with spectral norm (**high complexity**)
- **Epiplexity condition**: A captures main dynamics at low complexity; NN corrects residual at high complexity. Their capacities should NOT overlap.
- SVD projection is the mechanism enforcing non-overlap.

## Forward Direction: v3.x

### Proposal: Basis Expansion for A

The main direction to resolve the central tension:
- A = Σ w_k · A_k where A_k are known physics bases
  - A₁ = I (identity)
  - A₂ = [[0,1],[-ω₀²,-2ζω₀]] (damping + stiffness)
  - A₃ = [[0,0],[-x²,0]] (nonlinear position coupling — optional)
- w_k are scalar **learnable but interpretable**
- A's expressivity ↑ → NN burden ↓ → "A as main" achievable
- Still non-blackbox (each basis has physical meaning)

**→ Generalization:** [[koopman-lifting-rigor|Koopman Lifting]] (2026-05-12 deep-research) — polynomial/kernel-based state augmentation으로 A를 lifted space로 확장. Physics-specific basis 대신 universal polynomial/RFF lifting을 통해 **어떤 비선형 시스템에도 적용 가능**. Lifted A에 contractivity LMI 직접 적용 가능.

### Near-term Plan

1. ✅ **Structural skeleton** implemented and tested (May 11)
2. 🟡 **Basis expansion** — next architectural step
3. 🟡 **Joint bounded stability** — `||A + NN_proj|| ≤ γ` instead of separate bounds
4. 🔴 **Longer training** (10k+ iter) for convergence analysis

### Open Questions

1. **How to ensure bounded stability of A + NN jointly?** Separate SVD + spectral norm doesn't guarantee sum is bounded.
2. **Where exactly does heuristic end?** SVD projection is the grayest area — basis expansion may make it unnecessary.
3. **UFI novelty framing** — "gradient routing" vs "information-theoretic gating" vs "attention-like conditioning"? Need precise mathematical formulation.

## See Also

- [[rigor-development]] — Implementation history and benchmarks
- [[rigor-heuristics-analysis]] — Detailed heuristic audit
- [[rigor-filter]] — Differentiable SR-UKF overview
- [[rigor-research-roadmap]] — Broader research trajectory
- [[square-root-unscented-kalman-filter]] — Base algorithm
