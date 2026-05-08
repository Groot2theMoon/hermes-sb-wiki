---
title: "The Geometry of Consolidation — Consolidation-Interference Duality & GAC"
created: 2026-05-08
updated: 2026-05-08
type: concept
tags: [memory, embedding, compression, theory, algorithm, paper, landmark]
sources: [raw/papers/main.md]
confidence: high
---

# The Geometry of Consolidation

**Vangara, Gopinath (2026)** — University of Waterloo + Sentra + MIT
NeurIPS 2026 submission

## 개요

의미 기반 메모리 시스템(벡터 DB, RAG, 에이전트 메모리)이 클러스터 압축(consolidation) 시 겪는 **identity 손실의 정확한 하한**을 수리적으로 증명하고, 이를 회피하는 **기하학 인식 압축 알고리즘(GAC)** 을 제시한다. 이는 "Geometry of Memory" trilogy의 완결편.

## Consolidation-Interference Duality 정리

모든 consolidator에 대해, retrieval cap $\theta' = 1-\theta$가 클러스터 내 평균 거리 $\bar d$보다 작을 때:

$$ \varepsilon_{\text{id}} \geq 1 - c_1 \cdot m \cdot \left(\frac{\theta'}{\bar d}\right)^{d_{\text{eff}}/2} $$

**두 가지 체제 (Two Regimes):**

| Regime | 조건 | $c_1$ (95% coverage) | $c_1=1$로 충분한 비율 |
|--------|------|---------------------|---------------------|
| **Tight** | $\bar d < \theta'$ | **0.046** (Berry-Esseen 이론적 한계와 동일 order) | 97.3% |
| **Spread** | $\bar d \geq \theta'$ | **4.61 × 10¹⁰** (11자리 폭발!) | 11.3% |

→ **압축 전 $\bar d$와 $\theta'$만 비교하면 catastrophe를 예측할 수 있다.**

## GAC (Geometry-Aware Consolidation) 알고리즘

단 3줄의 per-cluster 라우터:

1. 각 클러스터의 $d_{\text{eff}}$와 $\bar d$를 cheap하게 측정 (작은 eigendecomposition)
2. **Tight regime** ($\bar d < \theta'$) → **Centroid** (k-means averaging, near-optimal)
3. **Spread regime** ($\bar d \geq \theta'$) → **Residual-budgeted medoid** (threshold margin 기반)

**결과:** PQ, OPQ, LSH, HNSW-prune, PCA+int8, Centroid, Medoid, IW — 전 baseline에 대해 전체 Pareto frontier에서 우위.

## 실험 결과

| Corpus | $d_{\text{eff}}$ | 특성 |
|--------|-----------------|------|
| HotpotQA | **1.5** | 가장 안전한 압축 |
| DRM templated | 2.3 | |
| MS MARCO | 5.5 | |
| Natural Questions | 12.6 | |
| Wikipedia sections | 30.1 | |
| **arXiv titles** | **107.5** | 압축에 가장 취약, PQ가 centroid보다 나은 유일한 영역 |

**Centroid가 PQ/OPQ를 5/6 코퍼스에서 Pareto-dominates** — arXiv ($d_{\text{eff}} \approx 107$)만이 예외.

## 연결점
- [[geometry-of-forgetting]] — 동일 trilogy 1편: interference가 망각의 원인
- [[price-of-meaning]] — 동일 trilogy 2편: No-Escape impossibility theorem
- [[spectralquant]] — 선행 연구: 동일한 spectral concentration을 기회로 활용
- [[deep-material-network]] — DMN material clustering에도 동일한 consolidation 문제 존재 가능성
- [[rigor-sigma-point-research]] — Sigma point cloud의 압축/consolidation에 직접 적용 가능

## References
- NeurIPS 2026 submission — The Geometry of Consolidation (Vangara & Gopinath)
- GitHub: github.com/niashwin/geometry-of-consolidation (MIT License, 완전 재현 가능)
