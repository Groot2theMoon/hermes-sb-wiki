---
title: Locally Linear Embedding (LLE)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, dimensionality-reduction, survey]
sources: [raw/papers/ml2-lle-intro.md, raw/papers/ml2-lecture-01.md, raw/papers/ml2-sheet-01.md]
confidence: high
provenance: "Roweis & Saul (2000) Science 290, 2323-2326"
---

# Locally Linear Embedding (LLE)

Roweis & Saul (2000)의 **LLE**는 고차원 데이터가 저차원 비선형 다양체(manifold) 위에 놓여 있다는 가정 하에, 국소 선형성(locally linear)을 보존하는 비선형 차원 축소 기법이다. PCA와 MDS가 선형 구조에만 효과적인 반면, LLE는 뒤틀린 다양체를 효과적으로 펼 수 있다.

## 알고리즘

LLE는 3단계로 구성된다.

### Step 1: Neighbors 선택
각 데이터 포인트 $\mathbf{x}_i \in \mathbb{R}^D$에 대해 $K$개의 최근접 이웃(nearest neighbors)을 Euclidean 거리 기준으로 찾는다.

### Step 2: Reconstruction Weights 계산
각 $\mathbf{x}_i$를 이웃들의 선형 결합으로 재구성하는 가중치 $W_{ij}$를 최소화한다:

$$ \mathcal{E}(W) = \sum_{i=1}^N \left\| \mathbf{x}_i - \sum_{j \in N_i} W_{ij} \mathbf{x}_j \right\|^2, \quad \sum_j W_{ij} = 1 $$

최적 가중치는 국소 공분산 행렬 $C_{jk} = (\mathbf{x}_i - \mathbf{x}_j)^\top (\mathbf{x}_i - \mathbf{x}_k)$로부터 해석적으로 구해진다:

$$ \mathbf{w}_i = \frac{C^{-1} \mathbf{1}}{\mathbf{1}^\top C^{-1} \mathbf{1}} $$

$K > D$인 경우 정칙화(regularization) $C \leftarrow C + \frac{\Delta^2}{K}I$가 필요하다^[raw/papers/ml2-lle-intro.md].

### Step 3: Embedding Coordinates 계산
동일한 가중치 $W_{ij}$를 저차원 공간 $\mathbb{R}^d$에서 재사용하여 embedding $\mathbf{Y} = [\mathbf{y}_1, \dots, \mathbf{y}_n]^\top$을 구한다:

$$ \Phi(Y) = \sum_{i=1}^n \left\| \mathbf{y}_i - \sum_j W_{ij} \mathbf{y}_j \right\|^2 = \operatorname{tr}\{Y^\top M Y\} $$

여기서 $M = (I - W)^\top (I - W)$이고, 해는 $M$의 하위 $d+1$개 고유벡터 중 최소 고유값에 해당하는 $d$개이다 (첫 번째는 자명해 $\mathbf{1}$은 제외)^[raw/papers/ml2-lecture-01.md].

## 불변성 (Invariance Properties)

Sheet 01에서 증명되었듯, LLE의 재구성 가중치는 세 가지 변환에 대해 불변이다^[raw/papers/ml2-sheet-01.md]:

- **Scaling invariance**: $\mathbf{x}_i \to \alpha \mathbf{x}_i$ ( $\alpha \neq 0$)
- **Translation invariance**: $\mathbf{x}_i \to \mathbf{x}_i + \mathbf{v}$ (sum-to-one constraint 덕분)
- **Rotation invariance**: $\mathbf{x}_i \to U\mathbf{x}_i$ (orthogonal $U$)

이 불변성은 가중치가 데이터의 절대 좌표가 아닌 **국소 기하학적 구조**만을 포착함을 의미한다.

## LLE vs PCA 비교

| 특성 | LLE | PCA |
|------|-----|-----|
| 가정 | 국소 선형 다양체 | 전역 선형 부분공간 |
| 최적화 | 고유값 문제 (비반복) | 고유값 문제 (비반복) |
| 국소 구조 보존 | ✅ (이웃 관계 유지) | ❌ (먼 점이 가까이 올 수 있음) |
| Out-of-sample | ❌ (별도 학습 필요) | ✅ (선형 투영) |
| 초파라미터 | $K$ (이웃 수) | 없음 (PC 수만 선택) |
| 시간 복잡도 | $O(DN^2 + DNK^3 + dN^2)$ | $O(D^2N + D^3)$ |

## 한계점 (Limitations)

- **고차원에서의 실패**: $K > D$인 경우 국소 공분산이 특이(singular)해져 정칙화가 필요하며, Sheet 01에서 지적된 바와 같이 데이터가 일반 위치(general position)에 있지 않으면 가중치가 고유하게 결정되지 않는다^[raw/papers/ml2-sheet-01.md]
- **노이즈 민감도**: 국소 선형성 가정이 노이즈에 취약함
- **비균일 샘플링**: 다양체가 균일하게 샘플링되지 않으면 왜곡 발생
- **매핑 함수 부재**: 새로운 데이터에 대한 명시적 투영 함수를 제공하지 않음
- **이웃 크기 $K$ 선택**: 자동 결정 방법이 없어 경험적 선택에 의존

## Kernel View

LLE는 데이터로부터 학습된 커널을 사용한 Kernel PCA로 해석될 수 있다 (Ham et al. 2003):

$$ K := (\lambda_{\max} I - M), \quad M = (I - W)(I - W)^\top $$

LLE의 고유벡터 2부터 $p+1$까지가 embedding 좌표를 제공한다^[raw/papers/ml2-lecture-01.md].

## 응용

- 얼굴 이미지 다양체 학습 (Saul & Roweis, 2000)
- 입술 이미지 차원 축소 및 음성 애니메이션
- 단어 문서 공간에서의 의미 구조 발견
- [[multi-dimensional-scaling]] 및 [[isomap]]과 함께 고전 manifold learning 삼대장

## 참조

- [[t-sne]] — t-SNE (SNE의 후속)
- [[isomap]] — Isomap (geodesic distance 기반)
- [[pca-vs-mds-vs-lle-vs-isomap-vs-tsne]] — 기법 간 비교
- [[multi-dimensional-scaling]] — MDS
