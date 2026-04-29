---
title: Non-linear Embeddings in Hilbert Simplex Geometry
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [mathematics, dimensionality-reduction, kernel-method, classic-ai, paper]
sources: [raw/papers/nielsen23a.md]
confidence: medium
---

# Non-linear Embeddings in Hilbert Simplex Geometry

## 개요

**Hilbert simplex geometry**는 열린 표준 심플렉스(open standard simplex) $\Delta_d$ 위에 정의된 거리 기하학(distance geometry)이다. Frank Nielsen과 Ke Sun이 ICML 2023 TAG-ML 워크숍에서 발표한 이 논문은 **가중 그래프(weighted graph)를 심플렉스 공간에 임베딩**하는 방법을 제안한다.

## 핵심 개념

### Hilbert 거리

심플렉스 $\Delta_d$ 위의 두 점 $p, q$ 사이의 Hilbert 거리는 **cross-ratio의 로그**로 정의된다:

$$\rho_{\text{HG}}^\Delta(p, q) = \log \frac{\|p-\bar{q}\|}{\|p-\bar{p}\|} \frac{\|q-\bar{p}\|}{\|q-\bar{q}\|}$$

이는 **Funk 거리**의 대칭화로 얻어지며, geodesic 성질(직선 위에서 거리 가법성)을 만족한다.

### Hilbert simplex distance (간단한 형태)

심플렉스 좌표 $p = (p_1, ..., p_d)$, $q = (q_1, ..., q_d)$에 대해:

$$\rho_{\text{FD}}(p, q) = \log \max_i \frac{p_i}{q_i}$$

## 의미

- **Hyperbolic geometry의 일반화**: Klein 모델을 임의의 볼록 영역으로 확장
- **Tree graph embedding**: Sarkar의 정리(weighted tree를 hyperbolic 공간에 저왜곡 임베딩 가능)의 확장
- **Homography invariance**: projective transformation에 대해 거리 불변

## 융합 도메인 연결

- [[lle]], [[isomap]], [[t-sne]] — 비선형 차원 축소 방법론의 확장
- [[multi-dimensional-scaling]] — 거리 유지 임베딩의 일반적 프레임워크
- [[kernel-methods]] — 심플렉스 공간에서의 커널 정의 가능성

## References
- Nielsen, F. & Sun, K. "Non-linear Embeddings in Hilbert Simplex Geometry." TAG-ML @ ICML 2023.
