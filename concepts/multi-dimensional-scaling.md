---
title: Multi-Dimensional Scaling (MDS)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, dimensionality-reduction]
sources: [raw/papers/ml2-lecture-02.md]
confidence: high
provenance: "Torgerson (1952), Gower (1966); Lecture 02 (Müller, Samek, Montavon)"
---

# Multi-Dimensional Scaling (MDS)

**MDS (다차원 척도법)** 는 고차원 데이터 점들 간의 쌍별 거리(pairwise distance)를 최대한 보존하는 저차원 임베딩을 찾는 고전적인 차원 축소 기법이다. PCA가 공분산 행렬의 고유벡터를 사용하는 반면, MDS는 거리/비유사도(dissimilarity) 행렬을 입력으로 받는다.

## Metric MDS

Metric MDS는 원 공간의 거리 $d_{ij}$와 저차원 공간의 거리 $\hat{d}_{ij}$ 사이의 제곱 오차를 최소화한다^[raw/papers/ml2-lecture-02.md]:

$$ \text{Cost} = \sum_{i < j} (d_{ij} - \hat{d}_{ij})^2 $$

$$ d_{ij} = \|x_i - x_j\|^2, \quad \hat{d}_{ij} = \|y_i - y_j\|^2 $$

### Double-Centering을 통한 해법

MDS의 핵심 통찰은 데이터를 이중 중심화(double-centering)하면 PCA와 동등해진다는 것이다. 거리 행렬 $D$로부터 내적 행렬(inner product matrix) $B$를 계산한다:

$$ B = -\frac{1}{2} J D^{(2)} J $$

여기서 $D^{(2)}_{ij} = d_{ij}^2$이고, $J = I - \frac{1}{n}\mathbf{1}\mathbf{1}^\top$은 centering 행렬이다. $B$는 $XX^\top$에 해당하며, $B$의 고유분해를 통해 embedding 좌표를 얻는다:

$$ B = V \Lambda V^\top, \quad Y = V \Lambda^{1/2} $$

이중 중심화는 각 행과 열의 평균을 0으로 만드는 연산으로, Lecture 02에서 "if we double-center the data, metric MDS is equivalent to PCA"라고 설명된다^[raw/papers/ml2-lecture-02.md].

## Classical MDS vs Metric MDS

| 구분 | Classical MDS | Metric MDS |
|------|---------------|------------|
| 거리 유형 | 유클리드 거리 가정 | 모든 거리 행렬 허용 |
| 최적화 | 고유분해 (비반복) | 반복적 최적화 (steepest descent) |
| PCA와의 관계 | 동등함 | 일반적으로 다름 |
| Stress 함수 | 암묵적 | 명시적 |

## Stress 함수

Metric MDS에서 embedding 품질을 측정하는 **Stress** 함수는:

$$ \text{Stress} = \sqrt{\frac{\sum_{i,j} (f(d_{ij}) - \hat{d}_{ij})^2}{\sum_{i,j} \hat{d}_{ij}^2}} $$

여기서 $f$는 단조 변환 함수이다.

## Sammon Mapping

Lecture 02에서 언급된 Sammon mapping은 MDS의 비선형 변형으로, 작은 거리에 더 큰 가중치를 부여한다:

$$ \text{Cost} = \sum_{i<j} \frac{(\|x_i - x_j\| - \|y_i - y_j\|)^2}{\|x_i - x_j\|} $$

이를 통해 국소 구조를 더 잘 보존할 수 있지만, 국소 최적해(local optima) 문제가 발생할 수 있다^[raw/papers/ml2-lecture-02.md].

## 비계량적 MDS (Non-Metric MDS)

원 거리의 절대값 대신 순위(rank)만 보존하는 방법. 거리 행렬이 계량적 성질(삼각부등식, 대칭성 등)을 만족하지 않을 때 사용한다.

### Metric Violations

Lecture 02에서는 비계량적 유사도 데이터의 중요성을 강조한다^[raw/papers/ml2-lecture-02.md]:
- 노이즈 측정, 인간의 유사도 판단, 텍스트 마이닝에서 비계량성이 발생
- 비계량 데이터는 등거리적으로 벡터로 표현될 수 없음
- 음의 고유값을 갖는 유사 행렬로 이어짐

## MDS의 한계

- 선형성 가정: 비선형 다양체에는 효과적이지 않음
- 거리 행렬의 크기가 $N \times N$으로 큰 데이터에 비효율적
- 이중 중심화가 허위 구조(spurious structure)를 도입할 수 있음 (Lecture 02)

## 응용

- 심리학: 유사도 판단 데이터의 시각화
- 생물정보학: 유전자 발현 프로파일 분석
- 사회과학: 설문 응답 기반 포지셔닝 맵
- [[isomap]]의 기반이 되는 방법론

## 참조

- [[isomap]] — Isomap (MDS를 비선형 다양체로 확장)
- [[t-sne]] — t-SNE (확률적 MDS의 일종)
- [[lle]] — LLE (국소 선형성 기반)
- [[pca-vs-mds-vs-lle-vs-isomap-vs-tsne]] — 방법론 간 비교
