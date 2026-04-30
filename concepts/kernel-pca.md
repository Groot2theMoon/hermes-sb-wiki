---
title: Kernel PCA — Nonlinear Component Analysis
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, kernel-method, dimensionality-reduction, landmark-paper]
sources: [raw/papers/Nonlinear_Component_Analysis_as_a_Kernel.md]
confidence: high
---

# Kernel PCA — Kernel Principal Component Analysis

## 개요

**Bernhard [[bernhard-scholkopf|Schölkopf]], Alexander Smola, Klaus-Robert Müller (1998)** 가 제안한 **Kernel PCA (KPCA)** 는 기존 **PCA (Principal Component Analysis)** 의 선형성을 **커널 트릭 (kernel trick)** 을 통해 비선형으로 확장한 차원 축소 기법이다^[raw/papers/Nonlinear_Component_Analysis_as_a_Kernel.md]. 10,000+ 인용으로 비선형 차원 축소의 표준 방법 중 하나이다.

## 핵심 아이디어

### PCA의 한계
PCA는 데이터의 **분산이 가장 큰 방향 (주성분)** 을 찾지만, 오직 **선형 변환**만 가능하다:

$$X \approx \hat{X} = ZW^\top + \mu \quad \text{(선형)}$$

따라서 **스위스 롤(Swiss roll)** 같은 곡면 데이터의 비선형 구조를 포착할 수 없다.

### Kernel Trick을 통한 비선형 확장

KPCA는 먼저 데이터 $\{x_i\}$를 **RKHS (Reproducing Kernel Hilbert Space)** 로 매핑한 후 PCA를 수행한다:

$$\phi: \mathbb{R}^d \to \mathcal{H}, \quad x \mapsto \phi(x)$$

**핵심:** $\phi$를 명시적으로 계산할 필요 없이, **커널 함수** $k(x_i, x_j) = \langle \phi(x_i), \phi(x_j) \rangle$만 알면 된다.

### KPCA 알고리즘

1. **커널 행렬 $K$ 구성**: $K_{ij} = k(x_i, x_j)$
2. **중앙화 (centering)**: $\tilde{K} = K - 1_N K - K 1_N + 1_N K 1_N$
3. **고유값 분해**: $\tilde{K} \alpha = \lambda \alpha$
4. **$i$번째 주성분**: $y_i(x) = \sum_{j} \alpha_i^{(j)} k(x, x_j)$

### 대표적 커널

| 커널 | 함수 | 특징 |
|------|------|------|
| **RBF (Gaussian)** | $k(x,y) = \exp(-\gamma \|x-y\|^2)$ | 가장 보편적, 무한 차원 특징 공간 |
| **Polynomial** | $k(x,y) = (x^\top y + c)^d$ | 유한 차원,d 차 다항식 |
| **Sigmoid** | $k(x,y) = \tanh(a x^\top y + b)$ | 신경망 활성화 유사 |

## 차원 축소 방법 비교

| 방법 | 비선형 | 커널 필요 | 해석력 | 계산 복잡도 |
|------|:----:|:---------:|:-----:|:----------:|
| **PCA** | ❌ | ❌ | ⭐⭐⭐ | $O(n d^2)$ |
| **Kernel PCA** | ✅ | ✅ | ⭐⭐ | $O(n^3)$ |
| **t-SNE** | ✅ | ❌ | ⭐ | $O(n^2)$ |
| **LLE** | ✅ | ❌ | ⭐⭐ | $O(n \log n)$ |

## 융합 도메인 연결

| 적용 분야 | 설명 |
|----------|------|
| **PINN latent space 분석** | PINN이 학습한 hidden feature의 비선형 구조 시각화 |
| **상전이 탐지** | [[unsupervised-phase-transitions]]에서 Ising/XY 모델 상태 공간 분석 |
| **Operator learning feature** | FNO/DeepONet의 latent representation 비교 연구 |
| **UQ 차원 축소** | 고차원 매개변수 공간에서 중요 방향 식별 |

## References

- B. [[bernhard-scholkopf|Schölkopf]], A. Smola, K.-R. Müller. "Kernel Principal Component Analysis", *Neural Computation*, 1998
- [[kernel-methods]] — 커널 방법론의 상위 개념
- [[pca-vs-mds-vs-lle-vs-isomap-vs-tsne]] — 차원 축소 방법 비교
- [[t-sne]] — KPCA와 비교되는 확률적 차원 축소
- [[lle]] — 국소적 선형성을 가정한 LLE
- [[unsupervised-phase-transitions]] — 상전이 탐지에서의 차원 축소 활용


- [[canonical-correlation-analysis]] — CCA — 다변량 상관관계 분석
