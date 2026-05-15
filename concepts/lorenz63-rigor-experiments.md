---
title: "Lorenz63 RIGOR Experiments — Single Lobe to LPV"
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [rigor, benchmark, lorenz, chaotic, state-estimation, rollout, lpv]
sources: []
confidence: medium
---

# Lorenz63 RIGOR Experiments

> Benchmarking RIGOR on the Lorenz63 chaotic system: single-lobe recovery, K-step NN residual rollout, static A → LPV transition.

## System

```
ẋ = σ(y - x)
ẏ = x(ρ - z) - y
ż = xy - βz
```

σ=10, ρ=28, β=8/3, dt=0.01. Observation: x₁ only (noisy, σ_obs=0.3). Hidden states: x₂, x₃.

**Challenge:** Lorenz switches between two lobes (x₁ > 0, x₁ < 0) with qualitatively different dynamics. A single static A matrix cannot capture both regimes.

## Core Metric

**Absolute correlation |ρ|** between estimated and true hidden states, averaged over all 3 states.

---

## Experiment Timeline

### Phase 1: Static A, Single Lobe (T=500, no burn-in, all x₁<0)

| Config | K | γ | x₁ | x₂ | x₃ | abs_avg | Notes |
|:-------|:-:|:-:|:--:|:--:|:--:|:-------:|-------|
| Baseline | 4 | 1.5 | 0.999 | -0.943 | 0.247 | 0.730 | UFI+RFF20, Option B |
| +Jacobian | 4 | 1.5 | 0.996 | -0.893 | 0.407 | 0.765 | x₃ +65%, extreme JIT |
| Minimal K-step | 8 | 1.5 | 0.920 | +0.370 | -0.660 | 0.650 | K=8, sign flip |
| UFI + K-step | 8 | 1.5 | 0.920 | -0.450 | -0.570 | 0.647 | x₂ stuck at -0.45 |

**Findings:** Single-lobe works well. γ=1.5 critical (γ=0.95 → A collapses to identity).

### Phase 2: Static A, Two Lobe (burn-in spin=2000, T=500)

| Config | NN | x₁ | x₂ | x₃ | abs_avg | Notes |
|:-------|:--:|:--:|:--:|:--:|:-------:|-------|
| Burn-in (16,) | (16,) | 0.752 | 0.402 | 0.028 | 0.394 | x₃ lost, sign normal |
| Burn-in (32,32) | (32,32) | 0.694 | -0.589 | 0.005 | 0.430 | A≈identity, oscillating |

**Findings:** Static A fails catastrophically on 2-lobe data. Structural limitation — not capacity bottleneck.

### Phase 3: LPV Post-Compute (v5.14, 현재)

| Config | T | K | γ | Status |
|:-------|:-:|:-:|:-:|:-------|
| LPV post-compute | 500 | 4 | 1.5 | WSL 정상 작동 |
| LPV + UFI + RFF | 500 | 4 | 1.5 | 실험 중 |
| LPV + K=8 rollout | 500 | 8 | 1.5 | 계획 중 |

**LPV post-compute approach** (`filter.py` v5.14):
```python
A_base = broadcast(A, (B, T, S, S))
A_delta = vmap(vmap(lpv_net))(mu_filt))  # 0.05·tanh(MLP(mu))
A_eff_dyn = A_base + A_delta
```

LPV delta는 `mu_filt` (observation-corrected)에서 post-compute. Flax `nn.scan` 내부에서 호출되지 않아 CPU compilation 문제 없음.

---

## Key Insights

| # | Insight | Evidence |
|:-:|:--------|:---------|
| 1 | **γ=1.5 essential** for Lorenz | γ=0.99 → A≈identity |
| 2 | **Spectral penalty redundant** with SVD clamp | Zero-effect ablation |
| 3 | **Single A fails 2-lobe** — structural limitation | abs_avg 0.73→0.39 |
| 4 | **Jacobian helps x₃** (+65%) at extreme cost | Only for final benchmarks |
| 5 | **K=4 > K=8** for Lorenz | 8.5× faster, same abs_avg |
| 6 | **LPV post-compute works on CPU** | v5.14, WSL verified |
| 7 | **Lemma 7 predicts Option B failure** for ρ>1 | Exponential error growth |

---

## See Also

- [[rigor-filter]] — Core architecture (v5.14)
- [[k-step-rollout-error-bound]] — Lemma 7: Option B error bound
- [[state-dependent-a-quadratic-form]] — A(x) evolution
- [[k-step-rollout-vfe-loss]] — VFE loss with K-step rollout
- [[rigor-development]] — Implementation history
