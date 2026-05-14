---
title: "Lorenz63 RIGOR Experiments — 2-Lobe Switching & K-step Rollout"
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [rigor, benchmark, lorenz, nonlinear-dynamics, state-estimation, rollout]
sources: []
confidence: high
---

# Lorenz63 RIGOR Experiments

> Benchmarking RIGOR on the Lorenz63 chaotic system: 2-lobe switching, K-step rollout,
> and the transition from static A to state-dependent A(x).

## System

```
ẋ = σ(y - x)
ẏ = x(ρ - z) - y
ż = xy - βz
```

σ=10, ρ=28, β=8/3, dt=0.01. Observation: x₁ only (noisy, σ_obs=0.3). Hidden states: x₂, x₃.

**Challenge:** Lorenz switches between two lobes (x₁ > 0, x₁ < 0) with qualitatively different dynamics. A single static A matrix cannot capture both regimes.

## Core Metric

**Absolute correlation |ρ|** between estimated and true hidden states, averaged over all 3 states. RMSE as secondary metric.

## Experiment Timeline

### Phase 1: Static A, Single Lobe (T=500, no burn-in)

| Config | K | x₁ | x₂ | x₃ | \|ρ\| | Notes |
|--------|:--:|:----:|:----:|:----:|:----:|------|
| Baseline | 4 | 0.999 | -0.943 | 0.247 | 0.730 | gamma=1.5, T=500 (x₁ all negative) |
| +Jacobian | 4 | 0.996 | -0.893 | 0.407 | 0.765 | x₃ +65%, extreme JIT cost |
| Minimal K-step | 8 | 0.920 | +0.370 | -0.660 | 0.650 | K=8, sign recovery |
| UFI + K-step | 8 | 0.920 | -0.450 | -0.570 | 0.647 | x₂ stuck at -0.45 |

**Findings:** Single-lobe (T=500, all x₁<0) works well. gamma=1.5 critical (gamma=0.95 → A≈identity, collapses). Spectral penalty unnecessary (SVD clamp sufficient).

### Phase 2: Static A, Two Lobe (burn-in spin=2000, T=500)

| Config | NN | x₁ | x₂ | x₃ | \|ρ\| | Notes |
|--------|:--:|:----:|:----:|:----:|:----:|------|
| Burn-in (16,) | (16,) | 0.752 | 0.402 | 0.028 | 0.394 | Sign normal, x₃ lost |
| Burn-in (32,32) | (32,32) | 0.694 | -0.589 | 0.005 | 0.430 | A≈identity, loss oscillating |

**Findings:** Static A fails catastrophically on 2-lobe data. Single linear skeleton cannot express sign-flipping coupling across lobes. Increasing NN capacity (16→32) doesn't help — structural limitation, not capacity bottleneck.

### Phase 3: State-Dependent A(x) (attempted, CPU-limited)

| Approach | T | Result |
|----------|:---:|--------|
| LPV MLP (v5.16-17) | 500 | OOM (5GB+ RAM) |
| LPV MLP (v5.18) | 250 | Iter 1 OK (83s), backward pass OOM |
| Quadratic A (v5.19) | 250 | Init OK, JIT OOM |

**Root cause:** Flax `nn.scan` + JIT compilation on CPU cannot handle the LPV/Quadratic A compilation graph for T≥250. Awaiting CPU-friendly execution strategy (for-loop, T=100, or Modal GPU).

## Key Insights

1. **Gamma=1.5 is essential** for Lorenz — standard gamma=0.99 clamps A too tightly for chaotic dynamics
2. **Spectral penalty is redundant** when SVD clamp is active — confirmed by zero-effect ablation
3. **Single A fails 2-lobe switching** — structural limitation, not training issue
4. **Jacobian matters for x₃** (+65%) but at extreme JIT cost — only for final benchmarks
5. **RFF is insufficient** for 2-lobe switching — data-agnostic fixed projection
6. **CPU compilation is the bottleneck** for state-dependent A — LPV and Quadratic A both fail on CPU JIT

## Ablation Table (v5.19 candidate)

| Config | UFI | K-step NN | A type | Target |
|--------|:---:|:---------:|:------:|--------|
| Baseline (K=1) | ❌ | ❌ | Static | Control |
| K-step only | ❌ | ✅ (K=8) | Static | K-step effect |
| Quadratic A(x) | ❌ | ✅ (K=8) | Quadratic | A(x) effect |
| Full RIGOR | ✅ | ✅ (K=8) | Quadratic | Combined |

## See Also

- [[state-dependent-a-quadratic-form]] — A(x) architecture
- [[k-step-rollout-vfe-loss]] — VFE loss with K-step rollout
- [[rigor-filter]] — RIGOR overview
- [[rigor-research-roadmap]] — Broader trajectory
