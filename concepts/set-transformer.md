---
title: Set Transformer — Attention-based Permutation-Invariant Neural Networks for Sets
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [attention, permutation-invariant, set-structured-data, deep-learning, transformer, meta-learning]
sources: [raw/papers/set-transformer-lee19.md]
confidence: medium
---

# Set Transformer

**Set Transformer**는 [[juho-lee|Juho Lee]], [[yee-whye-teh|Yee Whye Teh]] 등이 2019년 ICML에서 발표한, **집합(set) 구조 데이터를 처리하기 위한 attention 기반의 permutation-invariant 신경망 아키텍처**이다. 기존의 set pooling 방법 (Deep Sets, Zaheer et al. 2017)이 각 원소를 독립적으로 인코딩한 후 단순 pooling (mean/sum/max)으로 집계하는 데 비해, Set Transformer는 **self-attention 메커니즘**을 활용하여 집합 내 원소 간의 pairwise 및 higher-order 상호작용을 명시적으로 모델링한다.

## 핵심 아이디어

1. **Permutation-equivariant encoding**: Self-attention을 통해 집합의 모든 원소를 동시에 인코딩함으로써 원소 간 상호작용을 포착
2. **Inducing point method를 통한 computational complexity 감소**: Sparse Gaussian Process의 inducing point 아이디어를 차용, self-attention의 **O(n²) 복잡도를 O(nm)으로 감소** (m ≪ n)
3. **Attention 기반 pooling (PMA)**: 고정된 pooling 대신 **학습 가능한 seed vector**에 multihead attention을 적용하여 집합 전체의 표현을 aggregate
4. **Universal approximation 증명**: Set Transformer가 임의의 permutation-invariant 함수를 근사할 수 있음을 증명

## 아키텍처 구성 요소

### MAB (Multihead Attention Block)
Transformer의 encoder block을 차용한 기본 빌딩 블록. row-wise feedforward layer와 LayerNorm을 포함하며, positional encoding과 dropout은 제거됨. 입력으로 두 개의 집합 **X, Y**를 받아 attention을 수행:

```
MAB(X, Y) = LayerNorm(X + rFF(LayerNorm(X + Multihead(X, Y, Y))))
```

### SAB (Set Attention Block)
SAB는 MAB에 자기 자신을 query/key/value로 전달하여 집합 내 self-attention을 수행:

```
SAB(X) = MAB(X, X)
```

SAB는 permutation equivariant하며, stacking을 통해 higher-order 상호작용 인코딩 가능.

### ISAB (Induced Set Attention Block)
SAB의 **O(n²)** 복잡도 문제를 해결하기 위해 도입. **m개의 학습 가능한 inducing point 벡터** I ∈ R^{m×d}를 정의하여:

```
ISAB_m(X) = MAB(X, MAB(I, X))
```

- 먼저 inducing point I가 입력 집합 X에 attention (I → X): **O(nm)**
- 그 다음 X가 변환된 inducing point H에 attention (X → H): **O(mn)**
- 전체 복잡도: **O(nm)** (SAB의 O(n²)에 비해 큰 개선)

Inducing point는 학습 가능한 파라미터로, 입력 집합의 전역 구조를 인코딩하는 저차원 표현을 학습.

### PMA (Pooling by Multihead Attention)
고정된 pooling 연산 대신 **k개의 학습 가능한 seed vector S**에 multihead attention을 적용하여 집합을 aggregate:

```
PMA_k(Z) = MAB(S, Z)
```

출력은 k개의 항목을 가진 집합. k=1인 경우 단일 벡터를 출력하며, k>1인 경우 (예: amortized clustering) SAB를 추가로 적용하여 출력 간 상관관계를 모델링.

### 전체 인코더-디코더 구조
```
Encoder: ISAB → ISAB → ... → ISAB  (또는 SAB stack)
Decoder: PMA → SAB → rFF
```

## 실험 결과

| Task | 주요 결과 |
|------|----------|
| **Maximum Value Regression** | Set Transformer (SAB+PMA)가 max-pooling에 준하는 성능 달성 |
| **Unique Character Counting (Omniglot)** | SAB+PMA가 **60.37%** 정확도로 기존 방법(43.82~46.17%)을 크게 상회 |
| **Amortized Clustering (MoG)** | ISAB(16)+PMA가 synthetic/CIFAR-100 모두에서 최고 성능, EM oracle보다 우수한 경우도 존재 |
| **Set Anomaly Detection (CelebA)** | SAB+PMA가 AUROC **0.5941**로 모든 baseline 초월 |
| **3D Point Cloud Classification (ModelNet40)** | 소규모 집합에서 강점, 대규모에서는 ISAB+Pooling이 효과적 |

## 관련 개념

- [[kalmannet|KalmanNet]] — model-based + data-driven hybrid filtering으로 attention과 유사한 weighted aggregation 수행
- [[state-space-model|State-Space Model]] — SSM 기반 시퀀스 모델링은 Set Transformer와 다른 방식으로 장기 의존성 처리
- [[deep-kalman-filter|Deep Kalman Filter]] — neural network와 Bayesian filtering의 결합이라는 점에서 관련
- [[rigor-filter|RIGOR Filter]] — differentiable filtering 프레임워크

## 참고 문헌

- Lee et al., "Set Transformer: A Framework for Attention-based Permutation-Invariant Neural Networks", ICML 2019. [[1810.00825](https://arxiv.org/abs/1810.00825)]
- Zaheer et al., "Deep Sets", NeurIPS 2017 — 기존 set pooling 방법론
- Vaswani et al., "Attention Is All You Need", NeurIPS 2017 — Transformer 원천 기술
