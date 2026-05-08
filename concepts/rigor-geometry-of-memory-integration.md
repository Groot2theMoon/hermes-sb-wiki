---
title: "RIGOR × Geometry of Memory Trilogy — Sigma Cloud Embedding & GAC-Inspired Adaptive UFI"
created: 2026-05-08
updated: 2026-05-08
type: concept
tags: [rigor, ufi, sigma-point, embedding, memory, research-idea, integration, analysis]
sources:
  - raw/papers/2604.06222v1.md
  - raw/papers/2603.27116v1.md
  - raw/papers/main.md
confidence: medium
---

# RIGOR × Geometry of Memory Trilogy — Integration Analysis

> Sentra+MIT의 "Geometry of Memory" 3부작(Forgetting, Price of Meaning, Consolidation)을
> RIGOR의 sigma point cloud conditioning에 접목한 심층 분석 및 실험 제안.

---

## 핵심 통찰: Sigma Point Cloud = Embedding Memory

RIGOR가 매 timestep 생성하는 sigma point cloud $(2n+1, d_x)$는 **작은 크기의 embedding memory**이다. UFI(Unscented Feature Interaction)는 이 cloud를 NN으로 압축/처리하는 **consolidation 연산자**이며, 이 trilogy가 분석하는 문제와 정확히 일치한다.

| RIGOR 개념 | Trilogy 개념 | 대응 관계 |
|:----------|:------------|:---------|
| Sigma point cloud | Cluster of embeddings | 매 timestep 생성되는 작은 semantic memory |
| UFI neural network | Consolidation operator | Cloud → representative 압축 |
| UFI features | CompressedStore.vectors | 보존된 semantic 정보 |
| Raw sigma points | Episodic / original members | 압축 전 원본 정보 |
| sigma_cond (NN input) | Retrieval query | 압축된 store에서 정보 검색 |
| Phase 2 residual (NN→sigma) | Consolidation–Interference Duality | 압축이 identity를 파괴하는 문제 |

---

## ① $d_{\text{eff}}$ 진단 — Sigma Cloud의 숨은 유효 차원 측정

**Trilogy의 핵심 발견:** 고차원 embedding의 명목 차원과 유효 차원($d_{\text{eff}}$)은 극명하게 다르다. 생산 embedding 모델(384-1024차원)의 $d_{\text{eff}} \approx 16$으로, 간섭에 극도로 취약.

**RIGOR에 적용:** Sigma point의 covariance $P$에서 $d_{\text{eff}}$를 매 timestep 계산:

$$d_{\text{eff}} = \frac{(\sum \lambda_i)^2}{\sum \lambda_i^2}, \quad \lambda_i = \text{eigenvalues of } P$$

```python
# PyTorch implementation
Xc = sigma_points - sigma_points.mean(dim=1, keepdim=True)
cov = (Xc.transpose(1,2) @ Xc) / (2*n_sigma)
eigs = torch.linalg.eigvalsh(cov)
d_eff = (eigs.sum(dim=1)**2) / (eigs**2).sum(dim=1)
```

**예상 행동:** VDP benchmark에서 sigma cloud의 $d_{\text{eff}}$는 시간에 따라 변동:
- **Convergence 후** (정상 상태): Tight regime ($d_{\text{eff}}$ 작음, ~2-5) → UFI 압축 안전
- **Transient/관측 불연속 시:** Spread regime ($d_{\text{eff}}$ 큼, ~10+) → UFI가 정보 파괴 위험

---

## ② Tight vs Spread Regime — UFI 실패 지점 예측

**Consolidation-Interference Duality**에 따르면, consolidation 전에 regime을 알면 압축 손실을 예측 가능:

| Regime | 조건 | UFI 성능 예측 |
|:------|:----|:-------------|
| **Tight** | $\bar d < \theta'$ | ✅ 안전한 압축 — centroid(현재 UFI)로 충분 |
| **Spread** | $\bar d \geq \theta'$ | ❌ Identity collapse — UFI가 sigma point 구조 파괴 |

**$\bar d$ (mean within-cloud cosine distance):**
```python
Xn = F.normalize(sigma_points, dim=-1)
sims = Xn @ Xn.transpose(1,2)
d_bar = 1 - (sims.sum() - n) / (n*(n-1))
theta_prime = 1 - theta  # e.g., theta=0.85 → theta'=0.15
```

**실험 제안 A:** VDP 500iter 전체 timestep에 대해 $(d_{\text{eff}}, \bar d)$를 기록하고, RIGOR의 RMSE spike와 spread regime timestep의 상관관계 분석.

---

## ③ GAC-Inspired Adaptive UFI

현재 RIGOR는 모든 sigma cloud에 동일한 NN을 적용한다. GAC의 per-cluster routing 아이디어를 차용:

**GAC-RIGOR architecture:**
```
sigma_points
├── Tight regime (d̄ < θ'):
│   └── UFI(NN) → features (현재 방식, 안전)
└── Spread regime (d̄ ≥ θ'):
    ├── Option A: Two-layer memory (UFI + raw sigma)
    └── Option B: Residual-budgeted medoid (GAC original)
```

**Option A — Two-layer memory (from Price of Meaning):**
```python
if regime == "tight":
    h = UFI(sigma_points)
else:
    h_semantic = UFI(sigma_points)      # semantic (일반화, 학습 패턴)
    h_episodic = sigma_points.flatten()  # episodic (정확성 보장)
    h = torch.cat([h_semantic, h_episodic])
```

이는 **Price of Meaning**에서 제안한 "two-layer memory" 아키텍처와 정확히 일치:
- Semantic layer (UFI processed) — 일반화, 패턴 학습
- Episodic layer (raw sigma) — 정확성 보장, identity 손실 방지

---

## ④ Phase 2 Residual의 재해석

Phase 2 실패(distortion carry as residual, self-conditioning feedback loop)의 근본 원인은 **GAC의 관점에서 명확해짐:**

| 접근 | 방법 | 결과 |
|:----|:----|:-----|
| ❌ Phase 2 기존 | residual = NN_output → feedback loop | 자기 조건화, collapse |
| ✅ GAC 원칙 | residual = 실제 data point (budgeted medoid) | 정보 보존, identity 유지 |

**즉, residual의 source가 NN이 아니라 원본 data여야 함.** 수정된 Phase 2:

```python
# Keep M farthest-from-centroid sigma points as residual
centroid = sigma_points.mean(dim=0)
dists = torch.norm(sigma_points - centroid, dim=1)
_, idx = torch.topk(dists, M)  # information-rich sigma points
residual_sigma = sigma_points[idx]
sigma_cond_with_residual = torch.cat([
    UFI(sigma_points),           # semantic
    residual_sigma.flatten()     # episodic
])
```

**Why farthest?** GAC의 residual-budgeted medoid는 "budget margin" 개념을 사용한다. Threshold $\theta'$를 넘는 sigma point가 collapse의 원인이므로, centroid에서 가장 먼(M farthest) 점들이 가장 많은 정보를 담고 있다. 이는 "가장 멀리 있는 점이 가장 많은 정보를 가진다"는 UFI의 철학과도 일치.

---

## ⑤ 구체적 실험 제안 3가지

### 실험 1: $d_{\text{eff}}$ Diagnostic on VDP
- VDP 500iter benchmark에서 timestep별 $(d_{\text{eff}}, \bar d)$ 계산
- RIGOR error(RMSE, pos_corr)와 spread regime timestep의 상관관계 분석
- Plot: x=timestep, y=(d_eff, RMSE) overlay

### 실험 2: GAC-RIGOR Ablation
| Variant | Description | 예상 |
|:--------|:------------|:----|
| Baseline v4.9 | Current RIGOR | Reference |
| +d_eff_gate | Tight→UFI, Spread→skip UFI (raw sigma) | Spread에서 개선 |
| +two_layer | UFI + raw sigma subset conditioning | 전반적 개선 |
| +residual_medoid | Keep M farthest sigma points as residual | Phase 2 재구현 (correct) |

### 실험 3: UFI-as-Consolidation Eval
- GAC 코드(`gac/` 패키지의 `identity_retrieval()`, `coverage_at_theta()`)를 RIGOR sigma_cond에 적용
- UFI 처리 전후 sigma point의 identity preservation 측정
- $d_{\text{eff}}$가 높은 timestep에서 identity loss가 큰지 검증

---

## 연결점
- [[geometry-of-forgetting]] — interference가 정보 손실의 원인
- [[price-of-meaning]] — two-layer memory 아키텍처 제안
- [[geometry-of-consolidation]] — GAC 알고리즘과 Consolidation-Interference Duality
- [[rigor-sigma-point-research]] — RIGOR의 sigma point 혁신 연구 지형도
- [[rigor-research-roadmap]] — RIGOR 연구 로드맵 (UFI + raw cloud + ISAB)
- [[unscented-feature-interaction]] — UFI 상세 설계
- [[rigor-development]] — RIGOR 개발 히스토리

## References
- raw/papers/2604.06222v1.md — The Geometry of Forgetting (Barman et al., 2026)
- raw/papers/2603.27116v1.md — The Price of Meaning (Barman et al., 2026)
- raw/papers/main.md — The Geometry of Consolidation (Vangara & Gopinath, 2026)
