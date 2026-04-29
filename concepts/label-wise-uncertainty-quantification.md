---
title: "Label-wise Aleatoric & Epistemic Uncertainty Quantification"
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [uncertainty, inference, mathematics, paper]
sources: [raw/papers/sale24a.md]
confidence: medium
---

# Label-wise Uncertainty Quantification

## 개요

Sale et al. (LMU Munich, 2024)는 classification에서 **label-wise** 관점의 aleatoric/epistemic UQ를 제안한다. 기존 entropy 기반 접근의 한계(Wimmer et al. 2023)를 극복하고 variance 기반 측도를 도입. 클래스별 uncertainty 분해로 cost-sensitive 의사결정 지원.

## 핵심 아이디어

### Global vs Label-wise UQ
- **기존 Global 접근:** 전체 categorical 분포의 entropy, mutual information
  - $TU(Q) = H(\mathbb{E}_Q[\theta]),\quad AU(Q) = \mathbb{E}_Q[H(\theta)],\quad EU(Q) = I(Y;\Theta)$
- **Wimmer et al. (2023)의 한계:** entropy-based measure가 desirable property 위반

### Label-wise Decomposition
- Multinomial → binary classification for each class $k$:
  - $\theta_k = p(y_k|x)$, marginal $\bar{\theta}_k = \mathbb{E}_Q[\theta_k]$
- Variance-based measures:
  - $TU_k(Q) = \bar{\theta}_k(1-\bar{\theta}_k)$ (total)
  - $AU_k(Q) = \mathbb{E}_Q[\theta_k(1-\theta_k)]$ (aleatoric)
  - $EU_k(Q) = \text{Var}_Q[\theta_k]$ (epistemic)

### Properties
- 비음성, 정규화, consistent labeling 등 공리 충족
- Global uncertainty는 label-wise의 합으로 복원 가능
- Cost-sensitive decision: misclassification cost가 다른 상황에서 유용

## 실험
- Image classification, medical domain (MNIST, CIFAR, histopathology)
- Prediction with abstention, OOD detection에서 경쟁력
- Entropy-based 대비 variance-based의 이점 입증

## 융합 도메인 연결
- [[uncertainty-quantification-deep-learning]] — UQ 방법론 종합
- [[bayesian-uncertainty-vision]] — aleatoric/epistemic 구분의 원천
- [[pac-bayesian-epistemic-uncertainty]] — VI 기반 UQ 이론
