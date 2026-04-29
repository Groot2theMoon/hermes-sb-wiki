---
title: Sam T. Roweis
created: 2026-04-28
updated: 2026-04-28
type: entity
tags: [person, classic-ai]
sources: [raw/papers/ml2-lle-intro.md]
confidence: high
---

# Sam T. Roweis

**LLE (Locally Linear Embedding)의 공동 창시자.** Gatsby Computational Neuroscience Unit, UCL (University College London) 소속 연구자. 비선형 차원 축소, EM 알고리즘, Kalman 필터, 신경 계산(neural computation) 분야에 깊은 영향을 남겼다.

## 주요 기여

### Locally Linear Embedding (LLE)
[[lawrence-saul| Lawrence Saul]]과 공동으로 개발한 [[lle| LLE]]는 *Science* 2000년 290권 5496호에 게재되어 **~15,000회 이상 인용**된 landmark 논문이다. LLE는 고차원 데이터가 저차원 비선형 다양체(manifold) 위에 놓여 있다는 가정 하에:
1. 각 점의 **K-최근접 이웃**을 찾고
2. 이웃들의 **선형 재구성 가중치**를 계산하며
3. 동일한 가중치를 저차원 embedding에서 **재사용**하는
3단계 알고리즘이다. PCA나 MDS가 포착하지 못하는 비선형 다양체 구조를 효과적으로 발견한다.

### EM Algorithm 및 Kalman Filter
EM (Expectation-Maximization) 알고리즘의 이론적 발전과, 은닉 마르코프 모델(HMM)을 포함한 잠재 변수 모델(latent variable models)에서의 응용에 기여. 또한 Kalman filter와 같은 상태 공간 모델(state-space models)의 추론 및 학습 알고리즘을 연구.

### Neural Computation
뉴런의 계산 모델, 신경 회로의 정보 처리 원리 등 신경과학과 기계학습의 교차점에서 연구를 수행. Gatsby Unit의 학문적 전통에 따라 **이론 신경과학(theoretical neuroscience)**에 깊이 관여.

## 생애

Sam Roweis는 2010년 1월 12일, 37세의 나이로 안타깝게 세상을 떠났다. 그의 사후, [[lle]] 논문의 영향력은 꾸준히 증가하여 현재까지 manifold learning 분야의 foundational work으로 남아 있다. UCL Gatsby Unit과 NIPS (NeurIPS) 커뮤니티는 그의 업적을 기리는 다양한 추모 활동을 진행했다.

## 관계

- [[lle]] — Roweis의 대표 업적 (Locally Linear Embedding)
- [[lawrence-saul]] — LLE 공동 창시자, AT&T Labs – Research
- [[t-sne]] — t-SNE (SNE의 후속, Hinton & van der Maaten, 2008)는 Roweis의 SNE 아이디어를 계승

## 주요 논문

| 연도 | 제목 | 비고 |
|------|------|------|
| 2000 | Nonlinear Dimensionality Reduction by Locally Linear Embedding | *Science* 290, 2323–2326 (~15,000 인용) |
| 1999 | Stochastic Neighbor Embedding (Hinton & Roweis) | SNE 원조 논문 |
| 1998 | EM Algorithms for PCA and SPCA | EM 관점의 PCA 해석 |
