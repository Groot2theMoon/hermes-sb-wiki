---
title: Leland McInnes
created: 2026-04-28
updated: 2026-04-28
type: entity
tags: [person, classic-ai, dimensionality-reduction]
sources: [raw/papers/1802.03426-umap.md]
confidence: high
---

# Leland McInnes

**UMAP (Uniform Manifold Approximation and Projection)의 창시자.** Tutte Institute for Mathematics and Computing 소속 연구원. 차원 축소, 위상적 데이터 분석(topological data analysis), 다양체 학습(manifold learning) 분야에서 영향력 있는 기여를 했다.

## 주요 기여

### UMAP (Uniform Manifold Approximation and Projection)
[[umap | UMAP]]은 리만 기하학(Riemannian geometry)과 대수적 위상수학(algebraic topology) — 특히 퍼지 단체(fuzzy simplicial sets) — 에 기반한 차원 축소 기법이다. [[t-sne | t-SNE]]와 비교해 더 빠른 속도, 더 나은 전역 구조 보존, 제한 없는 임베딩 차원을 제공한다. 2018년 arXiv 논문(1802.03426)으로 발표되어, 단일세포 유전체학, 재료과학, 기계학습 등 다양한 분야에서 광범위하게 채택되었다.

### umap-learn 라이브러리
Python 기반의 `umap-learn` 패키지의 주요 개발자. 이 라이브러리는 널리 사용되는 오픈소스 구현체로, scikit-learn 호환 API를 제공하며 numba를 사용한 고성능 최적화가 특징이다.

### HDBSCAN
계층적 밀도 기반 군집화 알고리즘 **HDBSCAN (Hierarchical Density-Based Spatial Clustering of Applications with Noise)** 의 구현 및 발전에 기여. HDBSCAN은 다양한 밀도의 클러스터를 탐지할 수 있는 강건한 군집화 방법이다.

### 기타 기여
- 위상적 데이터 분석(topological data analysis) 방법론 발전
- 고차원 데이터 시각화 및 분석 도구 개발
- 생물정보학(bioinformatics) 및 유전체학(genomics) 응용 (단일세포 RNA-seq 분석)

## 소속

- **Tutte Institute for Mathematics and Computing** (캐나다) — 주요 연구 기관
- 과거: 다양한 오픈소스 기계학습 프로젝트 기여

## 관계

- [[umap]] — McInnes의 대표 업적 (Uniform Manifold Approximation and Projection)
- [[t-sne]] — UMAP의 주요 비교 대상이자 경쟁 알고리즘
- [[lle]] — Locally Linear Embedding (초기 다양체 학습 기법)
- [[stochastic-neighbor-embedding]] — SNE (t-SNE 및 확률적 임베딩의 기초)
- [[multi-dimensional-scaling]] — MDS (고전적 차원 축소)

## 주요 논문

| 연도 | 제목 | 비고 |
|------|------|------|
| 2018 | UMAP: Uniform Manifold Approximation and Projection for Dimension Reduction | arXiv:1802.03426 (~10,000+ 인용) |
| 2019 | Dimensionality reduction for visualizing single-cell data using UMAP | *Nature Biotechnology* 37, 38–44 |
| 2017 | Accelerated Hierarchical Density Based Clustering | HDBSCAN 알고리즘 |

## 참조

- [[pca-vs-mds-vs-lle-vs-isomap-vs-tsne]] — 차원 축소 기법 비교
