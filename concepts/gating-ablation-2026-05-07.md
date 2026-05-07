---
title: "Gating Ablation — Statistical Gating ON vs OFF"
created: 2026-05-07
updated: 2026-05-07
type: concept
tags: [rigor, gating, ablation, experiment, v4.8]
confidence: high
---

# Gating Ablation — Statistical Gating ON vs OFF

**Experiment date:** 2026-05-07
**System:** VDP μ=1.0, dt=0.1, steps=500, obs_std=0.3, N_BATCH=4, SEED=43
**Architecture:** GELU(16,16), UFI+raw cloud, γ=0.99, VFE loss

## Results

| Config | Iters | pos_corr | vel_corr | RMSE | Δ RMSE |
|:------:|:-----:|:--------:|:--------:|:----:|:------:|
| Gating ON | 500 | 0.9940 | 0.9443 | 0.4431 | baseline |
| Gating OFF | 500 | 0.9943 | 0.9453 | 0.5284 | **+19.3%** |
| Gating ON | 1000 | 0.9971 | 0.9612 | 0.3834 | baseline |
| **Gating OFF** | **1000** | **0.9969** | **0.9683** | **0.3892** | **+1.5%** |

## Key Findings

1. **At 500 iters:** Gating provides significant benefit (+19% RMSE) — acts as early training stabilizer
2. **At 1000 iters:** Gating OFF catches up to within 1.5% RMSE — nearly identical performance
3. **vel_corr at 1000 iters:** Gating OFF (0.9683) is actually *better* than ON (0.9612)
4. Loss and spectral radius nearly identical between ON/OFF at convergence
5. **Gating effect only appears in post-training filtering quality, not in loss surface**

## Conclusion

Statistical gating (Mehra 1970 + Sage-Husa 1969 EMA) is beneficial only as an **early training stabilizer**. With sufficient training iterations (≥1000), it becomes redundant.

**Recommendation:** Set `use_statistical_gating=False` for production runs with ≥1000 iterations. Keep config flag for quick ablation and low-iteration experiments.

## Config

```python
config = RigorConfig(
    ...
    use_statistical_gating=False,  # v4.8
)
```

## Wikilinks
- [[rigor-heuristics-analysis]] — Full heuristic audit with proposed fixes
- [[rigor-development]] — Main RIGOR development page
