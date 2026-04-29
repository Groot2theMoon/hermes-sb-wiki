---
title: t-SNE — t-distributed Stochastic Neighbor Embedding
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [classic-ai, dimensionality-reduction, survey]
sources: [raw/papers/vandermaaten08a.md, raw/papers/ml2-lecture-02.md, raw/papers/ml2-sheet-02.md]
confidence: high
provenance: "van der Maaten & Hinton (2008) JMLR 9, 2579-2605"
---

# t-SNE

[[laurens-van-der-maaten|Laurens van der Maaten]] & [[geoffrey-hinton|Geoffrey Hinton]] (2008)의 **t-SNE (t-distributed Stochastic Neighbor Embedding)**는 고차원 데이터의 시각화를 위해 설계된 비선형 차원 축소 기법이다. [[stochastic-neighbor-embedding|SNE]]의 crowding 문제를 해결하기 위해 저차원에서 Student-t 분포를 사용한다.

## SNE에서 t-SNE로의 발전

### SNE (원본)

SNE는 고차원 공간에서의 점 간 유사도를 조건부 확률로 변환한다:

$$ p_{j|i} = \frac{\exp(-\|x_i - x_j\|^2 / 2\sigma_i^2)}{\sum_{k \neq i} \exp(-\|x_i - x_k\|^2 / 2\sigma_i^2)} $$

저차원에서도 유사한 확률 $q_{j|i}$를 정의하고, 두 분포 간 KL 발산(Kullback-Leibler divergence)을 최소화한다^[raw/papers/ml2-lecture-02.md]:

$$ C = \sum_i KL(P_i \| Q_i) = \sum_i \sum_j p_{j|i} \log \frac{p_{j|i}}{q_{j|i}} $$

### Symmetric SNE

대칭 버전에서는 $p_{ij} = \frac{p_{j|i} + p_{i|j}}{2n}$으로 정의하고, 저차원에서도 $q_{ij} = \frac{\exp(-\|y_i - y_j\|^2)}{\sum_{k \neq l} \exp(-\|y_k - y_l\|^2)}$로 대칭화한다.

### Gradient Derivation (Sheet 02)

Sheet 02에서 유도된 SNE의 그래디언트는 다음과 같다^[raw/papers/ml2-sheet-02.md]:

$$ \frac{\partial C}{\partial q_{ij}} = -\frac{p_{ij}}{q_{ij}} $$

Softmax 파라미터화 $q_{ij} = \frac{\exp(z_{ij})}{\sum \exp(z_{kl})}$를 통해:

$$ \frac{\partial C}{\partial z_{ij}} = -p_{ij} + q_{ij} $$

최종적으로 embedding 좌표 $\mathbf{y}_i$에 대한 그래디언트:

$$ \frac{\partial C}{\partial \mathbf{y}_i} = \sum_{j=1}^N 4(p_{ij} - q_{ij}) \cdot (\mathbf{y}_i - \mathbf{y}_j) $$

이 그래디언트는 물리적으로 점 $y_i$와 $y_j$ 사이의 스프링 힘으로 해석된다: stiffness $(p_{ij} - q_{ij})$에 비례하며, 거리가 너무 가까우면 척력, 너무 멀면 인력으로 작용한다^[raw/papers/ml2-lecture-02.md].

## Crowding Problem

고차원 데이터를 저차원으로 투영할 때, 비슷한 점들은 가까이 모이지만 다른 점들도 함께 밀려드는 현상이다. Lecture 02에서 설명된 것처럼, "서로 다른 점들이 너무 멀리 떨어져야 하는데 공간이 부족해 뭉개지는(crushed) 문제"가 발생한다.

### t-SNE의 해결책

t-SNE는 저차원에서 **Student-t 분포** (자유도 1 = Cauchy 분포)를 사용하여 이 문제를 해결한다:

$$ q_{ij} = \frac{(1 + \|y_i - y_j\|^2)^{-1}}{\sum_{k \neq l} (1 + \|y_k - y_l\|^2)^{-1}} $$

Gaussian(SNE) 대신 heavy-tailed Student-t를 사용하면, 멀리 떨어진 점들이 저차원에서도 적절히 멀게 표현될 수 있어 crowding 문제가 완화된다.

## 알고리즘

1. **Perplexity 기반 $\sigma_i$ 설정**: 사용자가 지정한 perplexity $Perp$에 맞춰 각 점의 $\sigma_i$를 이진 탐색으로 결정
2. **고차원 유사도 $p_{j|i}$ 계산**
3. **대칭 $p_{ij} = \frac{p_{j|i} + p_{i|j}}{2n}$**
4. **초기 embedding**: $\mathcal{Y}^{(0)} \sim \mathcal{N}(0, 10^{-4}I)$에서 샘플링
5. **Gradient descent with momentum**:

$$ \mathcal{Y}^{(t)} = \mathcal{Y}^{(t-1)} + \eta \frac{\partial C}{\partial \mathcal{Y}} + \alpha(t)(\mathcal{Y}^{(t-1)} - \mathcal{Y}^{(t-2)}) $$

## 파라미터

- **Perplexity**: 유효 이웃 수 (보통 5-50). 커질수록 전역 구조 반영, 작아질수록 국소 구조 반영
- **Learning rate $\eta$**: 보통 100-1000
- **Momentum $\alpha(t)$**: 초기 0.5, 후반 0.8

## Multiple Maps t-SNE

Lecture 02에서 다룬 확장으로, 비계량적(non-metric) 유사도나 비대칭 관계를 모델링하기 위해 여러 개의 t-SNE 맵을 동시에 학습한다^[raw/papers/ml2-lecture-02.md]:

$$ q_{j|i} = \frac{\sum_m \pi_i^{(m)} \pi_j^{(m)} (1 + \|y_i^{(m)} - y_j^{(m)}\|^2)^{-1}}{\sum_{m'} \sum_{i \neq k} \pi_i^{(m')} \pi_k^{(m')} (1 + \|y_i^{(m')} - y_k^{(m')}\|^2)^{-1}} $$

각 객체는 모든 맵에 점을 가지며, 맵별 가중치 $\pi_i^{(m)}$가 할당된다. 이를 통해 비추이적 유사도(intransitive similarity), 높은 중심성(high centrality), 비대칭 관계를 표현할 수 있다.

## 참조

- [[lle]] — LLE
- [[stochastic-neighbor-embedding]] — SNE (t-SNE의 전신)
- [[multi-dimensional-scaling]] — MDS
- [[pca-vs-mds-vs-lle-vs-isomap-vs-tsne]] — 방법론 비교
