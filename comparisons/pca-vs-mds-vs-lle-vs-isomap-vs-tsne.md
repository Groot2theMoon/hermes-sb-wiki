---
title: PCA vs MDS vs LLE vs Isomap vs t-SNE vs UMAP — 차원 축소 방법 비교 (6-way)
created: 2026-04-28
updated: 2026-04-28
type: comparison
tags: [comparison, classic-ai, dimensionality-reduction, survey]
sources: [raw/papers/ml2-lecture-01.md, raw/papers/ml2-lecture-02.md, raw/papers/ml2-lle-intro.md]
confidence: high
---

# PCA vs MDS vs LLE vs Isomap vs t-SNE vs UMAP — 차원 축소 방법 비교 (6-way)

**PCA (Principal Component Analysis)** , **MDS (Multi-Dimensional Scaling)** , **LLE (Locally Linear Embedding)** , **Isomap (Isometric Feature Mapping)** , **t-SNE (t-distributed Stochastic Neighbor Embedding)** , **UMAP (Uniform Manifold Approximation and Projection)** 는 각각 다른 수학적 원리로 고차원 데이터를 저차원에 임베딩하는 대표적인 기법들이다. PCA와 MDS는 선형(linear), LLE와 Isomap은 비선형 manifold 학습(nonlinear manifold learning), t-SNE는 확률적 이웃 보존(stochastic neighbor preservation), UMAP은 리만 기하학+위상수학 기반의 퍼지 단체(fuzzy simplicial set) 보존에 기반한다.

## 비교 표

| 차원 (Dimension) | PCA | MDS | LLE | Isomap | t-SNE | UMAP |
|------------------|:---:|:---:|:---:|:------:|:-----:|:----:|
| **Type** | Linear | Linear | Nonlinear | Nonlinear | Nonlinear | Nonlinear |
| **Preserves** | Variance | Pairwise distances | Local geometry | Geodesic distances | Local neighborhoods | Local + global manifold structure |
| **Objective** | Max variance | $\sum(d-\hat{d})^2$ | Reconstruction error | Geodesic + MDS | KL divergence | Cross-entropy between fuzzy simplicial sets |
| **Optimization** | Eigenvalue | Eigenvalue / Gradient | Eigenvalue | Eigenvalue | Gradient descent | SGD |
| **Global structure** | ✅ | ✅ | ❌ (local only) | ✅ | ⚠️ Partially | ✅✅ (best among all) |
| **Computational cost** | Low | Low–Medium | Medium | High (shortest paths) | High | Medium (faster than t-SNE) |
| **Parameter** | None | Target dim | $K$ neighbors | $K$ neighbors | Perplexity | n_neighbors, min_dist |
| **Deterministic** | ✅ | ✅ | ✅ | ✅ | ❌ (random init) | ~ (seeded) |
| **Out-of-sample** | ✅ | ❌ | ❌ | ❌ | ❌ | ✅ (parametric extension) |
| **Suitable for visualization** | ❌ | ✅ | ✅ | ✅ | ✅✅ | ✅✅ |

## 상세 설명 by Dimension

### 1. Type (알고리즘 유형)
선형 기법(PCA, MDS)은 데이터가 저차원 **선형 부분공간**에 존재한다고 가정한다. 비선형 기법(LLE, Isomap, t-SNE, UMAP)은 데이터가 **비선형 다양체**(manifold) 위에 놓여 있다는 가정에서 출발한다. Lecture 01에서 지적되었듯, PCA와 MDS는 Swiss Roll 데이터를 평면에 펼 때 먼 점들이 가까이 오는 왜곡이 발생한다^[raw/papers/ml2-lecture-01.md]. UMAP은 여기에 리만 기하학적 관점을 추가하여 데이터가 다양체 위에 **균일 분포(uniform distribution)**한다는 가정을 명시화한다.

### 2. Preserves (보존 속성)
- **PCA**: 전체 데이터의 **분산(variance)**이 최대가 되는 직교 방향을 찾는다.
- **MDS**: 고차원에서의 **점 간 쌍별 거리(pairwise distances)**를 저차원에서 재현한다. Classical MDS는 Euclidean 거리 사용 시 PCA와 동치.
- **LLE**: 각 점의 **국소 기하(local geometry)** — 즉 이웃 간의 선형 재구성 관계를 보존한다. Step 2에서 계산된 재구성 가중치는 회전·스케일·평행이동에 불변이다^[raw/papers/ml2-lecture-01.md].
- **Isomap**: 고차원 공간에서의 **측지 거리(geodesic distance)**를 그래프 최단 경로로 근사하여 보존한다. Lecture 02에 따르면, Isomap은 MDS의 pairwise distance를 geodesic distance로 대체한 형태로 볼 수 있다^[raw/papers/ml2-lecture-02.md].
- **t-SNE**: 고차원에서 점 간의 **확률적 유사도**(조건부 확률 $p_{j|i}$)를 저차원에서의 t-분포 기반 확률 $q_{ij}$로 근사한다. KL divergence를 최소화하여 국소 이웃 구조를 보존한다^[raw/papers/ml2-lecture-02.md].
- **UMAP**: 고차원 공간에서의 **위상적 구조(topological structure)** — 퍼지 단체(fuzzy simplicial sets)의 1-골격(1-skeleton)을 보존한다. 국소적으로는 가중 K-최근접 이웃 그래프를, 전역적으로는 퍼지 집합 합집합(fuzzy set union)을 통해 국소+전역 다양체 구조를 동시에 보존한다^[raw/papers/1802.03426-umap.md].

### 3. Objective (목적 함수)
- **PCA**: $\max \text{Var}(Xw)$ s.t. $\|w\|=1$
- **MDS**: $\min \sum_{i,j} (d_{ij} - \hat{d}_{ij})^2$
- **LLE**: $\min \sum_i \| \mathbf{x}_i - \sum_j W_{ij} \mathbf{x}_j \|^2$ (재구성 오차)
- **Isomap**: Geodesic distance matrix $\Delta_G$에 classical MDS 적용
- **t-SNE**: $\min \text{KL}(P \| Q) = \sum_i \sum_j p_{ij} \log \frac{p_{ij}}{q_{ij}}$
- **UMAP**: $\min \text{CE}(V, W) = \sum_{i \neq j} \left[ v_{ij} \log \frac{v_{ij}}{w_{ij}} + (1 - v_{ij}) \log \frac{1 - v_{ij}}{1 - w_{ij}} \right]$ (퍼지 집합 교차 엔트로피)

### 4. Optimization (최적화 방법)
PCA, MDS, LLE, Isomap은 모두 **고유값 분해(eigenvalue decomposition)**로 전역 최적해(global optimum)를 찾는다. 반면 t-SNE는 **경사 하강법(gradient descent)**을 사용하며, KL divergence의 non-convexity로 인해 local minimum이 존재한다. **UMAP**도 SGD(stochastic gradient descent)를 사용하지만, 스펙트럴 임베딩(spectral embedding)으로 초기화하여 더 안정적인 수렴을 보장한다. LLE와 Isomap은 고유값 분해로 해석적 해를 제공하지만, 노이즈와 이웃 크기에 민감하다.

### 5. Computational Cost
- **PCA**: $O(\min(D^3, N^3))$ — 공분산 행렬의 고유값 분해
- **MDS**: $O(N^3)$ — 거리 행렬의 이중 중심화(double centering) 후 고유값 분해
- **LLE**: $O(DN^2 + DNK^3 + dN^2)$ — 이웃 탐색 + 국소 공분산 역행렬 + 희소 고유값 문제
- **Isomap**: $O(N^2 \log N + KN \log N)$ (Dijkstra 최단 경로) + $O(N^3)$ (MDS)
- **t-SNE**: $O(N^2)$ — 모든 점 쌍의 확률 계산 (Barnes-Hut 근사: $O(N \log N)$)
- **UMAP**: $O(N \log N + N k + k d)$ — NN-descent 근사 최근접 이웃 탐색 $O(N \log N)$, 퍼지 그래프 구축 $O(Nk)$, SGD 최적화 $O(N k d)$ (k=이웃 수, d=임베딩 차원). t-SNE보다 10-100배 빠름^[raw/papers/1802.03426-umap.md]

## 장단점 분석

### PCA
- **장점**: 가장 빠름, 해석 가능 (주성분 방향), out-of-sample 투영 가능
- **단점**: 선형성 가정 → 비선형 manifold 무력

### MDS
- **장점**: 거리 행렬만 있으면 작동 (유사도 행렬 → embedding), 다양한 변형 가능 (non-metric MDS)
- **단점**: 고차원 Euclidean 거리는 의미가 희석됨(cursing of dimensionality), out-of-sample 어려움

### LLE
- **장점**: 국소 선형성이 잘 맞는 데이터에 탁월, $K$ 파라미터 직관적, 고유값 분해로 전역 최적
- **단점**: $K$ 민감도 높음, 균일 샘플링 가정, 고차원($K > D$)에서 정칙화 필요^[raw/papers/ml2-sheet-01.md]

### Isomap
- **장점**: 전역 기하 보존 (geodesic), 이론적 직관 명확
- **단점**: 최단 경로 계산 비용 높음, geodesic 근사 오류, "short-circuit" 문제 (노이즈에 취약)

### t-SNE
- **장점**: 시각화 품질 최고 (군집 분리 선명), 실제 사용에서 가장 보편적
- **단점**: 비결정론적, perplexity 튜닝 필요, 클러스터 간 거리 무의미, 대규모 데이터 부적합

### UMAP
- **장점**: 속도 빠름 (t-SNE 대비 10-100배), 전역 구조 보존 우수, 임베딩 차원 제한 없음, 대규모 데이터(100K+) 확장 가능, PCA 사전 축소 불필요, 재현 가능(seed 고정 시)
- **단점**: 위상 보존이 목표라 거리 보존 미보장, 해석 가능성 부족(PCA 대비), 작은 데이터셋(<500 samples)에서 근사 오류 가능성, 노이즈에서 별자리 효과(constellation effect) 발생 가능

## 언제 무엇을 선택할까? (When to Choose Which)

| 사용 사례 | 권장 방법 | 이유 |
|-----------|-----------|------|
| **데이터 전처리 (상관관계 제거)** | PCA | 해석 가능하고 빠르며 out-of-sample 지원 |
| **EDA — 전역 구조 탐색** | PCA → MDS | 선형 구조 파악 후 비선형 확인 |
| **비선형 manifold 학습** | LLE 또는 Isomap | 다양체 가정이 데이터에 부합할 때 |
| **고차원 데이터 시각화 (탐색)** | t-SNE | 가장 선명한 군집 시각화 |
| **지리/네트워크 유사도 시각화** | MDS | 거리/유사도 행렬만 있을 때 효과적 |
| **고차원 → 저차원 → classification** | PCA (feature extraction) | out-of-sample 및 downstream task 호환 |
| **초고차원 (>1000D) 시각화** | PCA → t-SNE | PCA로 50D 축소 후 t-SNE 적용 |
| **geodesic 구조가 중요한 경우** | Isomap | Swiss Roll, 얼굴 각도 변화 등 |
| **PINN 잠재 공간 분석** | PCA (NTK) 또는 t-SNE | NTK 분석은 PCA, latent 시각화는 t-SNE |
| **대규모 데이터(100K+) 시각화 + 전역 구조** | UMAP | t-SNE보다 빠르고 전역 구조 보존 우수, n_neighbors 튜닝으로 global-local 균형 조절 가능 |
| **탐색적 데이터 분석 (전역+국소 구조 동시)** | UMAP | n_neighbors와 min_dist 파라미터로 유연한 구조 탐색 |

## 관계

- [[lle]] — Locally Linear Embedding 상세
- [[t-sne]] — t-SNE 상세
- [[multi-dimensional-scaling]] — MDS 상세
- [[isomap]] — Isomap 상세
- [[stochastic-neighbor-embedding]] — SNE (t-SNE의 전신)
- [[kernel-pca]] — PCA의 비선형 확장
- [[umap]] — UMAP (Uniform Manifold Approximation and Projection)
- [[leland-mcinnes]] — UMAP 창시자
