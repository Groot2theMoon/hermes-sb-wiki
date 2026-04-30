---
title: Principal Component Analysis (PCA) — 선형 차원 축소
created: 2026-04-30
updated: 2026-04-30
type: concept
tags: [classic-ai, dimensionality-reduction, kernel-method]
sources: []
confidence: high
---

# Principal Component Analysis (PCA)

## 개요

PCA는 데이터의 분산을 최대화하는 직교 축(주성분)을 찾아 고차원 데이터를 저차원으로 투영하는 선형 차원 축소 방법이다. Karl Pearson (1901)이 제안하고 Harold Hotelling (1933)이 독립적으로 발전시켰다.

## 핵심 아이디어

- **목표:** 데이터 공분산 행렬의 고유값 분해(EVD)를 통해 분산이 가장 큰 방향을 찾음
- **수학적 기반:** 상위 $k$개 고유벡터로 데이터를 투영하여 $d \to k$ 차원 축소
- **최적성:** MSE 관점에서 최적의 선형 차원 축소 (Eckart-Young 정리)

## 변형과 확장

| 변형 | 특징 |
|------|------|
| 표준 PCA | 선형, 공분산 기반 |
| [[kernel-pca|Kernel PCA]] | 비선형 확장, 커널 트릭 적용 |
| Sparse PCA | 희소성 제약 추가 |
| Incremental PCA | 대용량 데이터용 온라인 학습 |

## 한계

- **선형성 가정:** 비선형 구조를 포착하지 못함 → [[kernel-pca|Kernel PCA]], [[lle|LLE]], [[t-sne|t-SNE]] 등으로 확장
- **분산 ≠ 정보:** 분산이 큰 방향이 항상 유용한 것은 아님

## 관련 페이지

- [[kernel-pca]] — 비선형 확장 (Kernel PCA)
- [[canonical-correlation-analysis]] — 두 변수 집단 간 상관관계 최대화
- [[pca-vs-mds-vs-lle-vs-isomap-vs-tsne]] — 차원 축소 방법 6-way 비교
- [[lle]] — 국소 선형 임베딩
- [[t-sne]] — 비선형 시각화 방법

## References

- Pearson, K. (1901). "On Lines and Planes of Closest Fit to Systems of Points in Space"
- Hotelling, H. (1933). "Analysis of a Complex of Statistical Variables into Principal Components"
