---
title: UMAP — Uniform Manifold Approximation and Projection
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, dimensionality-reduction, neural-network]
sources: [raw/papers/1802.03426-umap.md]
confidence: high
provenance: "McInnes, Healy & Melville (2018) arXiv:1802.03426"
---

# UMAP — Uniform Manifold Approximation and Projection

**UMAP (Uniform Manifold Approximation and Projection)** 는 차원 축소(dimension reduction)를 위한 최신 다양체 학습(manifold learning) 기법이다. [[leland-mcinnes| Leland McInnes]], John Healy, James Melville (2018)이 개발했으며, 리만 기하학과 대수적 위상수학을 융합한 강력한 수학적 기초 위에 구축되었다.

## 개요

UMAP은 고차원 데이터의 다양체 구조를 퍼지 단체(fuzzy simplicial sets)로 표현한 후, 저차원 임베딩과의 차이를 최소화하는 방향으로 최적화한다. [[t-sne| t-SNE]]와 시각화 품질에서 경쟁력이 있으며, 더 나은 전역 구조 보존, 더 빠른 실행 시간, 제한 없는 임베딩 차원을 제공한다.

핵심 가정:
1. 데이터가 균일하게 분포된 다양체(uniformly distributed manifold) 위에 존재한다.
2. 관심 있는 다양체는 국소적으로 연결되어 있다(locally connected).
3. 이 다양체의 위상적 구조를 보존하는 것이 일차적 목표이다.

## 수학적 기초

### 리만 기하학 (Riemannian Geometry)
UMAP은 데이터가 놓여 있는 다양체 $\mathcal{M}$에 리만 계량 $g$가 존재한다고 가정한다. Lemma 1에 따르면, 계량이 국소적으로 상수 대각 행렬일 때 측지 거리(geodesic distance)는 모멘트 공간 거리에 비례한다:

$$d_{\mathcal{M}}(p, q) = \frac{1}{r} d_{\mathbb{R}^n}(p, q)$$

### 퍼지 단체 (Fuzzy Simplicial Sets)
범주론(category theory)을 사용하여, 국소적 퍼지 단체 표현을 구성한 후 확률적 t-conorm으로 통합(union)한다. 각 점 $x_i$에 대해 fuzzy singular set functor $\text{FinSing}((X, d_i))$를 적용하고, 이들을 합집합하여 전역 위상 표현을 얻는다:

$$\bigcup_{i=1}^n \text{FinSing}((X, d_i))$$

### 교차 엔트로피 손실
두 퍼지 단체 집합 간의 차이는 1-골격(1-skeleton)의 교차 엔트로피(cross-entropy)로 측정된다:

$$CE(X,Y) = \sum_{a,b} \left[ w_h(a,b) \log\left(\frac{w_h(a,b)}{w_l(a,b)}\right) + (1-w_h(a,b)) \log\left(\frac{1-w_h(a,b)}{1-w_l(a,b)}\right) \right]$$

이 손실 함수는 [[t-sne| t-SNE]]의 KL 발산과 달리, 멀리 떨어진 점들 사이의 관계도 패널티에 포함시켜 **전역 구조를 더 잘 보존**한다.

## 알고리즘

UMAP은 두 단계로 구성된다:

### Phase 1: 퍼지 위상 그래프 구축 (Fuzzy Topological Graph Construction)
1. 각 점 $x_i$에 대해 **$n$개의 최근접 이웃**(n_neighbors)을 찾는다 (NN-descent 알고리즘 사용)
2. 국소 연결성 상수 $\rho_i = \min\{d(x_i, x_{i_j}) \mid d(x_i, x_{i_j}) > 0\}$ 계산
3. 정규화 인자 $\sigma_i$를 이진 탐색으로 결정: $\sum_{j=1}^k \exp\left(\frac{-\max(0, d(x_i, x_{i_j}) - \rho_i)}{\sigma_i}\right) = \log_2(k)$
4. 가중 방향 그래프 엣지 $w((x_i, x_{i_j})) = \exp\left(\frac{-\max(0, d(x_i, x_{i_j}) - \rho_i)}{\sigma_i}\right)$
5. 확률적 t-conorm으로 대칭화: $B = A + A^\top - A \circ A^\top$

### Phase 2: 저차원 임베딩 최적화
1. **스펙트럴 임베딩**(spectral embedding)으로 초기화
2. **확률적 경사 하강법**(SGD)으로 교차 엔트로피 최소화:
   - 인력(attractive force): $\frac{-2ab\|y_i - y_j\|_2^{2(b-1)}}{1 + \|y_i - y_j\|_2^2} w((x_i, x_j)) (y_i - y_j)$
   - 척력(repulsive force): $\frac{2b}{(\epsilon + \|y_i - y_j\|_2^2)(1 + a\|y_i - y_j\|_2^{2b})} (1 - w((x_i, x_j))) (y_i - y_j)$

### Algorithm 1 (요약)
```
function UMAP(X, n, d, min-dist, n-epochs)
    for all x in X do
        fs-set[x] ← LOCALFUZZYSIMPLICIALSET(X, x, n)
    top-rep ← ∪ fs-set[x]        # 확률적 t-conorm 사용
    Y ← SPECTRALEMBEDDING(top-rep, d)
    Y ← OPTIMIZEEMBEDDING(top-rep, Y, min-dist, n-epochs)
    return Y
```

## UMAP vs t-SNE 비교

| 특성 | UMAP | t-SNE |
|------|------|-------|
| **속도** | ✅ 훨씬 빠름 (C++/numba 최적화) | ❌ 느림 (O(N²) 정규화 필요) |
| **전역 구조** | ✅✅ 더 잘 보존 | ⚠️ 부분적 (KL 발산의 한계) |
| **임베딩 차원** | ✅ 제한 없음 (2D~100D+) | ❌ 주로 2D/3D |
| **초기화** | 스펙트럴 임베딩 (결정론적 요소) | 랜덤 (비결정론적) |
| **수학적 엄밀성** | 리만 기하학 + 위상수학 기반 | 경험적 발견 + 휴리스틱 |
| **목적 함수** | 교차 엔트로피 | KL 발산 |
| **파라미터** | n_neighbors, min_dist | perplexity |
| **확장성** | 100만 개 이상 데이터 처리 가능 | 수만 개 제한 |
| **안정성** | 높음 (서브샘플링에도 안정적) | 낮음 (실행마다 결과 다름) |

## 하이퍼파라미터

### n_neighbors (이웃 수)
- **작은 값** (5-15): 미세한 국소 구조 포착, 다양체가 여러 연결 요소로 분할될 위험
- **큰 값** (50-500): 대규모 전역 구조 포착, 세부 구조 손실
- **기본값**: 15

### min_dist (최소 거리)
- **작은 값** (0.0-0.1): 점들이 빽빽하게 밀집, 다양체 구조 충실한 표현
- **큰 값** (0.5-0.9): 점들이 널리 퍼짐, 시각화에 유리 (overplotting 방지)
- **기본값**: 0.1
- 주로 **심미적(æsthetic) 파라미터** — 시각화 목적에 중요

## 장점

- ✅ **확장성**: 10만 개 이상의 대규모 데이터셋에 효율적
- ✅ **속도**: t-SNE보다 10-100배 빠름 (특히 고차원 임베딩에서)
- ✅ **전역 구조 보존**: KL 발산 대신 교차 엔트로피 사용으로 전역 구조 유지
- ✅ **PCA 사전 축소 불필요**: 극고차원 데이터(100만 차원 이상)에도 직접 적용 가능
- ✅ **재현성**: 시드(seed) 고정으로 결정론적 결과 생성 가능
- ✅ **다양한 거리 척도**: Euclidean 외에도 cosine, Manhattan 등 지원
- ✅ **임의 임베딩 차원**: 시각화(2D)부터 feature extraction(수십-수백 차원)까지
- ✅ **안정성**: 서브샘플링에도 embedding 안정적 (Procrustes 거리 낮음)

## 약점

- ❌ **해석 가능성 부족**: PCA의 주성분처럼 각 차원에 의미 부여 어려움
- ❌ **노이즈 과적합**: 작은 데이터셋에서 노이즈를 구조로 잘못 해석할 가능성 (별자리 효과)
- ❌ **국소 구조 우선**: 전역 구조보다 국소 구조에 더 가중치
- ❌ **작은 데이터셋 부적합**: 500개 미만 샘플에서는 근사 오류 가능성
- ❌ **거리 보존 미보장**: MDS처럼 정확한 거리 보존이 아닌 위상 보존이 목표

## 응용 분야

- **단일세포 유전체학** (scRNA-seq): 세포 유형 클러스터링 및 시각화
- **재료과학**: 물질 특성 공간 탐색
- **이미지 임베딩**: MNIST, Fashion-MNIST 등 고차원 이미지 시각화
- **자연어 처리**: Word embedding (word2vec, BERT) 시각화
- **생물정보학**: 유전자 발현 데이터 분석
- **이상 탐지(Anomaly Detection)**: 저차원 임베딩에서의 이상치 식별

## 관계

- [[t-sne]] — t-SNE (UMAP의 주요 비교 대상)
- [[lle]] — Locally Linear Embedding
- [[stochastic-neighbor-embedding]] — SNE (확률적 임베딩의 기초)
- [[leland-mcinnes]] — UMAP 창시자
- [[multi-dimensional-scaling]] — MDS
- [[isomap]] — Isomap
- [[pca-vs-mds-vs-lle-vs-isomap-vs-tsne]] — 차원 축소 기법 비교 (6-way)
