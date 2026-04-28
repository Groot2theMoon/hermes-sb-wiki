---
title: Stochastic Neighbor Embedding (SNE)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, dimensionality-reduction]
sources: [raw/papers/ml2-lecture-02.md, raw/papers/ml2-sheet-02.md]
confidence: high
provenance: "Hinton & Roweis (2002) NIPS 15, 833-840"
---

# Stochastic Neighbor Embedding (SNE)

**SNE (확률적 이웃 임베딩)** 은 Hinton & Roweis (2002)가 제안한 비선형 차원 축소 기법으로, 고차원 공간과 저차원 공간에서의 점들 간 유사도를 **확률 분포**로 모델링하고, 두 분포 간 [[t-sne|KL 발산]]을 최소화한다. [[t-sne|t-SNE]]의 직접적인 전신이다.

## 알고리즘

### 고차원 유사도

고차원 공간에서 점 $x_i$가 $x_j$를 이웃으로 선택할 조건부 확률:

$$ p_{j|i} = \frac{\exp(-\|x_i - x_j\|^2 / 2\sigma_i^2)}{\sum_{k \neq i} \exp(-\|x_i - x_k\|^2 / 2\sigma_i^2)} $$

여기서 $\sigma_i$는 점 $x_i$ 주변의 유효 이웃 수를 조절하며, 사용자가 지정한 **perplexity**에 맞춰 결정된다^[raw/papers/ml2-lecture-02.md].

### 저차원 유사도

저차원 embedding $y_i$에서도 동일한 형태를 사용하되, 분산을 고정 ($\sigma = 1/\sqrt{2}$)한다:

$$ q_{j|i} = \frac{\exp(-\|y_i - y_j\|^2)}{\sum_{k \neq l} \exp(-\|y_k - y_l\|^2)} $$

### 목적 함수

두 분포 간 Kullback-Leibler 발산을 최소화한다:

$$ C = \sum_i KL(P_i \| Q_i) = \sum_i \sum_j p_{j|i} \log \frac{p_{j|i}}{q_{j|i}} $$

## Gradient Derivation (Sheet 02)

Sheet 02에서는 SNE의 그래디언트를 단계별로 유도한다^[raw/papers/ml2-sheet-02.md]:

### Step 1: $q_{ij}$에 대한 미분

$$ \frac{\partial C}{\partial q_{ij}} = -\frac{p_{ij}}{q_{ij}} $$

### Step 2: Softmax 파라미터화

$q_{ij} = \frac{\exp(z_{ij})}{\sum \exp(z_{kl})}$로 재파라미터화하면:

$$ \frac{\partial C}{\partial z_{ij}} = -p_{ij} + q_{ij} $$

이 형태가 수치적으로 더 안정적이며, 확률 분포 제약을 자동으로 만족시킨다.

### Step 3: Embedding 좌표에 대한 최종 그래디언트

$z_{ij} = -\|y_i - y_j\|^2$를 대입하고 연쇄 법칙을 적용하면:

$$ \frac{\partial C}{\partial \mathbf{y}_i} = \sum_{j=1}^N 4(p_{ij} - q_{ij}) \cdot (\mathbf{y}_i - \mathbf{y}_j) $$

### 물리적 해석

Lecture 02에서 설명된 대로, 이 그래디언트는 스프링 시스템으로 해석된다^[raw/papers/ml2-lecture-02.md]:

- 스프링 강성(stiffness) = $p_{ij} - q_{ij}$
- $p_{ij} > q_{ij}$: 인력 (실제보다 너무 멂) → $\mathbf{y}_i$를 $\mathbf{y}_j$ 쪽으로 당김
- $p_{ij} < q_{ij}$: 척력 (실제보다 너무 가까움) → $\mathbf{y}_i$를 $\mathbf{y}_j$에서 밀어냄
- 힘의 크기는 거리 $\|y_i - y_j\|$에 비례

## Perplexity

Perplexity는 점 $i$ 주변의 유효 이웃 수로 정의되며, $\sigma_i$를 결정한다:

$$ \text{Perp}(P_i) = 2^{H(P_i)}, \quad H(P_i) = -\sum_j p_{j|i} \log_2 p_{j|i} $$

Perplexity가 높을수록 더 많은 점을 "이웃"으로 간주하여 전역 구조를 반영한다.

## SNE vs t-SNE

| 특성 | SNE | t-SNE |
|------|-----|-------|
| 저차원 분포 | Gaussian | Student-t (Cauchy) |
| Crowding 문제 | ❌ 심각 | ✅ 완화 |
| 대칭화 | 비대칭 $p_{j|i}$ | 대칭 $p_{ij}$ |
| 그래디언트 | $\sum 4(p_{j|i} - q_{j|i} + p_{i|j} - q_{i|j})(y_i - y_j)$ | $\sum 4(p_{ij} - q_{ij})(y_i - y_j)(1 + \|y_i - y_j\|^2)^{-1}$ |
| 시각화 품질 | 중간 | 우수 |

## 한계점

- **Crowding Problem**: 저차원에서 멀리 떨어져야 할 점들이 공간 부족으로 뭉개짐 (t-SNE가 Student-t 분포로 해결)
- **비대칭 그래디언트**: $p_{j|i} \neq p_{i|j}$로 인해 최적화가 불안정 (Symmetric SNE로 해결)
- **국소 최적해**: 확률적 경사 하강법 사용으로 여러 번 실행 필요
- **계산 복잡도**: $O(N^2)$으로 대규모 데이터에 비효율적

## 참조

- [[t-sne]] — t-SNE (SNE의 후속, crowding 문제 해결)
- [[multi-dimensional-scaling]] — MDS
- [[lle]] — LLE
- [[pca-vs-mds-vs-lle-vs-isomap-vs-tsne]] — 방법론 간 비교
