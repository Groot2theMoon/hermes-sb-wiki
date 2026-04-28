---
title: "Kernel Methods — An Introduction (Müller et al. 2001 Survey)"
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [classic-ai, kernel-method, survey, landmark-paper]
sources: [raw/papers/kernel_survey.md]
confidence: high
---

# Kernel-Based Learning Algorithms

## 개요

Müller, Mika, Rätsch, Tsuda, [[bernhard-scholkopf|Schölkopf]] (IEEE Trans. Neural Networks, 2001)의 **커널 방법(Kernel Methods)** 종합 서베이 — 약 **5,000회 인용**.

커널 방법은 데이터를 고차원 특징 공간(feature space)으로 **암시적(implicit) 매핑**한 후 선형 알고리즘을 적용하여, 원래 공간에서는 불가능한 **비선형 패턴**을 학습한다. SVM, kernel PCA, kernel Fisher discriminant 등의 이론적 기반.

**대조군/비교 기준:** 커널 방법은 PINN/Deep Learning 이전 시대의 대표적 비선형 학습 패러다임. 융합 도메인에서 GP 기반 surrogate modeling의 이론적 전신.

## 핵심 아이디어

### Kernel Trick

매핑 $\Phi: \mathcal{X} \to \mathcal{F}$를 **명시적으로 계산하지 않고**, 내적만 커널 함수로 대체:

$$k(\mathbf{x}, \mathbf{x}') = \langle \Phi(\mathbf{x}), \Phi(\mathbf{x}') \rangle_\mathcal{F}$$

| 특징 | 명시적 매핑 | Kernel Trick |
|:----|:-----------|:-------------|
| 계산 비용 | $O(DN + \dim(\mathcal{F})N^2)$ | $O(DN^2)$ |
| 차원 폭발 | $\mathcal{F}$가 무한차원이면 불가능 | 가능 |
| 특징 해석 | 가중치 $\mathbf{w}$ 직접 관찰 | dual coefficients $\alpha_i$만 해석 가능 |

### Mercer 정리

연속 대칭 양정치(positive definite) 커널 $k$는 항상 어떤 특징 공간 $\mathcal{F}$에서의 내적으로 표현 가능:

$$k(\mathbf{x}, \mathbf{x}') = \sum_{i=1}^\infty \lambda_i \phi_i(\mathbf{x})\phi_i(\mathbf{x}'), \quad \lambda_i \geq 0$$

## 대표적 커널과 알고리즘

### 커널 종류

| 커널 | 식 | 특성 |
|:----|:--|:-----|
| 선형 | $k(\mathbf{x}, \mathbf{x}') = \mathbf{x}^\top\mathbf{x}'$ | PCA/SVM의 선형 버전과 동일 |
| 다항식 | $k(\mathbf{x}, \mathbf{x}') = (\mathbf{x}^\top\mathbf{x}' + c)^d$ | $d$차 다항 특징 공간 |
| **RBF (Gaussian)** | $k(\mathbf{x}, \mathbf{x}') = \exp(-\gamma\|\mathbf{x} - \mathbf{x}'\|^2)$ | 무한차원 특징 공간, 가장 널리 사용 |
| 시그모이드 | $k(\mathbf{x}, \mathbf{x}') = \tanh(a\mathbf{x}^\top\mathbf{x}' + b)$ | 특정 조건에서 2-layer NN과 동등 |

### Kernel 알고리즘

| 알고리즘 | 태스크 | 핵심 원리 | 위키 페이지 |
|:--------|:------|:----------|:-----------|
| SVM | 분류/회귀 | 최대 마진 초평면 + 커널 | — |
| Kernel PCA | 차원 축소 | 특징 공간에서 PCA 수행 | [[kernel-pca]] |
| Kernel Fisher Discriminant (KFD) | 분류 | 특징 공간에서 LDA 수행 | — |
| Gaussian Process (GP) | 회귀/분류 | 베이지안 커널 방법 | [[physics-constrained-surrogate]] 간접 참조 |

### SVM의 정형화된 손실 함수

$$ \min_{\mathbf{w}, b, \xi} \frac{1}{2}\|\mathbf{w}\|^2 + C\sum_i \xi_i $$
$$\text{s.t. } y_i(\langle\mathbf{w}, \Phi(\mathbf{x}_i)\rangle + b) \geq 1 - \xi_i, \quad \xi_i \geq 0$$

Dual formulation으로 변환하면 오직 커널 $k(\mathbf{x}_i, \mathbf{x}_j)$만 필요:

$$ \max_{\alpha} \sum_i \alpha_i - \frac{1}{2}\sum_{i,j} \alpha_i \alpha_j y_i y_j k(\mathbf{x}_i, \mathbf{x}_j) $$

## 융합 도메인 연결

| 연결점 | 설명 |
|:------|:-----|
| **GP surrogate** | GP는 커널 방법의 베이지안 확장 → [[physics-constrained-surrogate]]의 대안적 접근 |
| **Kernel PCA** | 고차원 특징 공간에서의 비선형 차원 축소 → [[kernel-pca]] |
| **Neural Tangent Kernel** | 무한 너비 신경망 = NTK (특정 커널) → [[neural-tangent-kernel]] |
| **RKHS 이론** | 커널 방법의 수학적 기반 → PINN의 함수 근사 이론과 연결 |

### PINN/Deep Learning과의 관계

| 측면 | Kernel Methods | Deep Learning |
|:----|:--------------|:--------------|
| 표현력 | 커널 선택에 의존 (고정) | 학습된 특징 (적응적) |
| 스케일링 | $O(N^3)$ (GP), $O(N^2)$ (SVM) | $O(N)$ (SGD, 미니배치) |
| 대규모 데이터 | 비실용적 | 강점 |
| 소규모 데이터 | 강점 (낮은 분산) | 과적합 위험 |
| 물리 법칙 통합 | GP prior로 제한적 | PINN: PDE residual 직접 통합 |

## References
- Müller, K.-R., Mika, S., Rätsch, G., Tsuda, K., & [[bernhard-scholkopf|Schölkopf]], B. (2001). "An introduction to kernel-based learning algorithms." *IEEE Trans. Neural Networks*, 12(2), 181–201.
- [[klaus-robert-muller]] — 공저자, TU Berlin ML 교수
- [[kernel-pca]] — Kernel PCA 상세
- [[neural-tangent-kernel]] — NTK: 딥러닝과 커널 방법의 연결
