---
title: Isomap — Isometric Feature Mapping
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, dimensionality-reduction]
sources: [raw/papers/ml2-lecture-02.md]
confidence: high
provenance: "Tenenbaum, de Silva & Langford (2000) Science 290, 2319-2323"
---

# Isomap — Isometric Feature Mapping

**Isomap**는 Tenenbaum, de Silva & Langford (2000)이 제안한 비선형 차원 축소 기법으로, [[multi-dimensional-scaling|MDS]]를 비선형 다양체로 확장한다. 핵심 아이디어는 유클리드 거리 대신 **측지 거리(geodesic distance)** 를 사용하는 것이다.

## 알고리즘

Isomap은 세 단계로 구성된다^[raw/papers/ml2-lecture-02.md]:

### Step 1: Neighborhood Graph 구축
각 데이터 포인트를 $K$개의 최근접 이웃(KNN) 또는 반경 $\epsilon$ 내의 점들과 연결한다. 간선(edge)에는 원 공간의 유클리드 거리를 할당한다.

### Step 2: Geodesic Distance 추정
Neighborhood graph에서 모든 점 쌍 간의 **최단 경로(shortest path)** 를 계산한다:
- Dijkstra 알고리즘 (희소 그래프)
- Floyd-Warshall 알고리즘 (밀집 그래프)

측지 거리 $d_G(i,j)$는 그래프 상의 최단 경로 길이로 근사된다. Lecture 02에서 설명된 것처럼, "매니폴드를 따라 거리를 측정하면 $d(1,6) > d(1,4)$"가 성립하며, 이는 유클리드 거리와 대조된다^[raw/papers/ml2-lecture-02.md].

### Step 3: Classical MDS 적용
측지 거리 행렬 $D_G$에 Classical MDS (이중 중심화 + 고유분해)를 적용하여 저차원 임베딩 $Y$를 얻는다:

$$ B = -\frac{1}{2} J D_G^{(2)} J, \quad Y = \Lambda^{1/2} V^\top $$

## LLE vs Isomap 비교

| 특성 | Isomap | LLE |
|------|--------|-----|
| 거리 개념 | 측지 거리 (전역) | 유클리드 거리 (국소) |
| 구조 보존 | 전역 기하학 구조 | 국소 선형 구조 |
| 그래프 | 모든 점 쌍의 최단 경로 | 이웃 관계만 |
| 알고리즘 | MDS on geodesic matrix | 고유분해 on sparse matrix |
| 계산 복잡도 | $O(N^2 \log N + KN^2)$ | $O(DN^2 + DNK^3 + dN^2)$ |
| 전역 구조 | ✅ 잘 보존 | ⚠️ 국소 정보만으로 유추 |

## Isomap의 장점

- **전역 구조 보존**: LLE가 국소 선형성에 집중하는 반면, Isomap은 측지 거리를 통해 다양체의 전역 구조(예: Swiss roll의 언롤링)를 포착한다
- **비반복적 해법**: MDS 단계에서 고유분해를 사용하므로 국소 최적해 문제가 없음
- **명확한 기하학적 해석**: "매니폴드를 따라 측정한 거리"라는 직관적인 의미

## Isomap의 한계

- **Short Circuit 문제**: 이웃 크기 $K$가 너무 크면 매니폴드의 다른 지점을 연결하는 "지름길"이 생겨 측지 거리 추정이 왜곡됨
- **이웃 크기 민감성**: $K$가 너무 작으면 그래프가 불연속이 되어 전역 구조 손실
- **노이즈 민감도**: 노이즈가 심하면 KNN 그래프 구조가 불안정해짐
- **볼록하지 않은 다양체**: 다양체에 구멍(hole)이 있으면 측지 거리 추정이 어려움
- **내재 차원 추정**: LLE와 마찬가지로 내재 차원을 결정하는 강건한 방법이 없음 (Lecture 01)

## 응용

- 얼굴 이미지 다양체 (pose, 조명 변화)
- 손글씨 숫자 시각화 (COIL-20, MNIST)
- Lecture 02의 MNIST 실험에서 Isomap은 PCA나 LLE보다 더 잘 분리된 클러스터를 생성했다^[raw/papers/ml2-lecture-02.md]

## 참조

- [[multi-dimensional-scaling]] — MDS (Isomap의 기반)
- [[lle]] — LLE (국소 접근법)
- [[t-sne]] — t-SNE (확률적 접근법)
- [[pca-vs-mds-vs-lle-vs-isomap-vs-tsne]] — 방법론 간 비교
- [[hilbert-simplex-geometry]]
