---
title: Neural Networks — Tricks of the Trade
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [training, model, benchmark, survey, mathematics]
sources: [raw/papers/file.md]
confidence: high
---

# Neural Networks: Tricks of the Trade

## 개요

*Neural Networks: Tricks of the Trade* (Montavon, Orr, Müller, eds., Springer LNCS, 2nd ed. 2012)는 신경망 학습 실무에서 축적된 **실용적 노하우**의 집대성이다. **Klaus-Robert Müller** (TU Berlin)가 공동 편집한 이 책은 단순한 이론을 넘어 실제 학습 성능을 극대화하는 기술들을 다룬다.

## 핵심 주제

### 1. 입력 전처리 및 초기화

| 기술 | 내용 | 영향 |
|:---|:------|:----:|
| **입력 정규화** | Zero mean + unit variance | 수렴 속도 10배 향상 |
| **PCA whitening** | 상관관계 제거 + 차원 축소 | 과적합 감소 |
| **초기화 전략** | Xavier/Glorot, He initialization | Gradient 소실/폭발 방지 |

### 2. 학습 과정 최적화

- **Learning rate schedule:** Step decay, exponential decay, cyclic LR, cosine annealing
- **Batch normalization (Ioffe & Szegedy, 2015):** 각 층의 입력 분포 정규화 → 더 높은 LR 허용, 정규화 효과
- **Dropout (Srivastava et al., 2014):** 학습 시 무작위 뉴런 비활성화 → 앙상블 효과, 과적합 방지
- **Early stopping:** Validation loss 증가 시 학습 중단 → 가장 간단하면서도 효과적인 정규화

### 3. 그래디언트 처리

| 문제 | 증상 | 해결책 |
|:---|:----|:------|
| **Gradient vanishing** | 깊은 층 학습 안 됨 | ReLU, residual connection, batch norm |
| **Gradient exploding** | Loss가 NaN 발생 | Gradient clipping, weight decay |
| **Saddle point** | Loss 정체 | Momentum, Adam, learning rate warmup |

### 4. 앙상블 및 모델 결합

- **Averaging:** 여러 seed의 출력 평균 → 분산 감소 (1/M 효과)
- **Bagging:** Bootstrap 샘플로 각 모델 학습 → 다양성 확보
- **Snapshot ensemble:** 단일 학습 궤적에서 여러 local minima 수집

### 5. 하이퍼파라미터 튜닝

| 방법 | 장점 | 단점 |
|:---|:----|:----|
| Grid search | 병렬화 용이 | 차원의 저주 |
| Random search | 더 효율적 (Bergstra & Bengio, 2012) | 최적점 근처 분해능 낮음 |
| Bayesian optimization | 샘플 효율성 높음 | 구현 복잡도 높음 |

## 전통적 학습 vs 현대적 학습 파이프라인

| 요소 | 1990-2010 (Tricks era) | 2020+ (Modern era) |
|:---|:--------------------:|:-----------------:|
| 활성화 함수 | tanh, sigmoid | ReLU, GELU, SwiGLU |
| 정규화 | Weight decay + dropout | LayerNorm, RMSNorm |
| 최적화기 | SGD + momentum | AdamW, Muon |
| LR schedule | Manual step decay | Cosine, linear warmup |
| 배치 크기 | 32-256 | 256K+ (gradient accumulation) |

## 융합 도메인 연결

- DMN 학습 시 **초기화 전략**과 **learning rate schedule**의 중요성 — PINN/DMN의 multi-scale loss는 특히 careful tuning 필요
- [[physics-informed-neural-networks]]의 학습 안정화에 이 트릭들이 직접 적용됨
- [[kennedy-ohagan-calibration]]의 Bayesian 접근과 **early stopping**의 관계

## References
- Montavon, G., Orr, G. B., & Müller, K.-R. (Eds.). (2012). *Neural Networks: Tricks of the Trade* (2nd ed.). Springer LNCS 7700.
- [[deep-learning-nature-survey]]
- [[nn-tricks]]
