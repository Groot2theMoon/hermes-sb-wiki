---
title: PCA vs t-SNE vs LLE — 차원 축소 방법 비교
created: 2026-04-28
updated: 2026-04-28
type: comparison
tags: [comparison, classic-ai, dimensionality-reduction, kernel-method]
sources: [raw/papers/Nonlinear_Component_Analysis_as_a_Kernel.md, raw/papers/vandermaaten08a.md, raw/papers/lleintro.md]
---

# PCA vs t-SNE vs LLE — 차원 축소 3대 고전 기법 비교

**PCA (Principal Component Analysis)**, **t-SNE (t-distributed Stochastic Neighbor Embedding)**, **LLE (Locally Linear Embedding)**는 고차원 데이터를 저차원(주로 2D/3D)으로 축소하는 대표적인 기법들이다. PCA는 선형 분산 최대화, t-SNE는 확률적 이웃 보존, LLE는 국소 선형 재구성을 각각 최적화한다. 현대 AI/ML 연구(pinn-failure-modes, VAE latent space 등)에서 시각화 및 분석의 baseline으로 널리 사용된다.

## 비교 표

| 차원 | PCA (선형) | t-SNE (비선형) | LLE (비선형) |
|------|-----------|----------------|--------------|
| **핵심 아이디어** | 분산 최대화 방향으로 투영 | 고차원/저차원에서 점 간 확률 분포 일치 | 국소 선형 재구성 가중치 보존 |
| **수학적 기반** | 공분산 행렬의 고유값 분해(EVD) 또는 SVD | KL-divergence 최소화 + t-분포 | 최소제곱 재구성 오차 + 고유값 분해 |
| **목적 함수** | $\max \text{Var}(Xw)$ s.t. $\|w\|=1$ | $\min \text{KL}(P\|Q)$ ($P$: 고차원, $Q$: 저차원) | $\min \sum_i \|x_i - \sum_j W_{ij}x_j\|^2$ |
| **출력 특성** | 전역 구조 유지 (분산 순 정렬) | 지역 구조 유지, 군집화 선명 | 지역 manifold 구조 보존 |
| **계산 복잡도** | $O(d^3 + n d^2)$ (d: 차원) | $O(n^2)$ (페어와이즈 거리) | $O(n \log n \cdot k)$ (k: 이웃 수) |
| **결정론적** | ✅ (항상 같은 결과) | ❌ (랜덤 초기화 의존) | ✅ (근사적 결정론) |
| **하이퍼파라미터** | 없음 | perplexity (5-50), 학습률 | k-이웃 수 |
| **글로벌 구조** | ✅ (가장 잘 보존) | ❌ (클러스터 간 거리 무의미) | ⚠️ (부분적) |
| **로컬 구조** | ❌ (선형성 가정) | ✅ (매우 우수) | ✅ (우수) |
| **대규모 데이터** | ✅ (1M+ 샘플 가능) | ❌ (n > 10K에서 매우 느림) | ⚠️ (중간 규모) |
| **새 데이터 임베딩** | ✅ (명시적 투영 행렬) | ❌ (별도 학습/변환 불가) | ❌ (매개변수적 X) |

## 장단점 분석

### PCA
| 측면 | 설명 |
|------|------|
| 장점 | • 해석 가능 (주성분 직교, 분산 기여도 측정)<br>• 매우 빠름<br>• 전역 구조 유지<br>• 새 데이터에 즉시 적용 가능 |
| 단점 | • 선형성 가정 → 비선형 manifold 포착 불가<br>• 분산만 고려 (클러스터 구조 무시) |

### t-SNE
| 측면 | 설명 |
|------|------|
| 장점 | • 탁월한 시각화 품질 (군집/패턴 명확)<br>• 다양한 perplexity에서 robust<br>• 비선형 구조 포착 |
| 단점 | • 확률적 결과 (실행마다 다름)<br>• perplexity 튜닝 필요<br>• 클러스터 간 거리 신뢰 불가<br>• 대규모 데이터에 부적합 |

### LLE
| 측면 | 설명 |
|------|------|
| 장점 | • 매니폴드 가정에 이론적 근거<br>• k-이웃 파라미터 직관적<br>• 지역 선형성 가정의 수학적 우아함 |
| 단점 | • k-이웃 민감 (너무 작으면 불안정, 너무 크면 선형 근사 악화)<br>• 균일하지 않은 샘플링 밀도에 취약 |

## 언제 무엇을 선택할까?

| 사용 사례 | 권장 |
|-----------|------|
| **EDA (탐색적 분석) — 전역 패턴 파악** | PCA (1순위) |
| **클러스터 시각화 — 군집 구분** | t-SNE |
| **Manifold 학습 — 저차원 구조 발견** | LLE |
| **특징 추출 (Feature extraction) → downstream task** | PCA |
| **초고차원 데이터 (1000D+)** | PCA → t-SNE (PCA로 50D 축소 후 t-SNE) |
| **데이터 전처리 (상관관계 제거)** | PCA (whitening) |
| **딥러닝 latent space 해석** | PCA 또는 t-SNE |
| **PINN 실패 모드 분석 (pinn-failure-modes)** | PCA (NTK 분석) 또는 t-SNE (latent 시각화) |

## 관계

- [[kernel-pca]] — PCA의 비선형 확장 (Kernel PCA)
- [[t-sne]] — t-SNE 상세
- [[lle]] — LLE 상세
- [[variational-autoencoder]] — 현대 비선형 차원 축소 (VAE latent space)
- [[pinn-failure-modes]] — PINN 분석에서 PCA (NTK) 활용
