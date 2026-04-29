---
title: Dropout as Bayesian Approximation (Gal & Ghahramani)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, training, inference, uncertainty, landmark-paper]
sources: [raw/papers/gal16.md]
confidence: high
---

# Monte Carlo Dropout — Dropout as Bayesian Approximation

## 개요

**Yarin Gal & Zoubin Ghahramani (University of Cambridge, 2016)** 는 기존의 **Dropout (Hinton et al., 2012)** 을 **Bayesian variational inference**로 해석할 수 있음을 증명하여, 딥러닝에서의 **불확실성 정량화 (Uncertainty Quantification, UQ)** 에 혁명을 일으켰다^[raw/papers/gal16.md]. 10,000+ 인용으로 현대 실용적 UQ의 표준 방법론이 되었다.

## 핵심 아이디어

### 기존 Dropout (Hinton 2012)
- 학습 시: 각 뉴런을 확률 $p$로 **랜덤 드롭** → overfitting 방지
- 추론 시: **dropout 제거** + 가중치 $p$배 스케일링 (deterministic)

### Gal의 통찰: Dropout = Bayesian Approximation

Gal은 **학습 시의 dropout**을 **Bernoulli 분포를 사용한 variational posterior**로 해석:

$$q_\theta^*(\mathbf{W}) \approx p(\mathbf{W} \mid \mathbf{X}, \mathbf{Y})$$

즉, **dropout을 켠 상태로 여러 번 forward pass**를 수행하면:

1. **평균** = 모델 예측
2. **분산** = **epistemic uncertainty** (모델이 얼마나 확신하는지)

### MC Dropout 알고리즘

```
입력: 학습된 모델 (dropout 유지)
for i = 1 to T:
    $y^{(i)} = f_\theta^{(i)}(x)$  ← 서로 다른 드롭패턴
예측: $\hat{y} = \frac{1}{T} \sum_i y^{(i)}$
불확실성: $\sigma^2 = \frac{1}{T} \sum_i (y^{(i)} - \hat{y})^2$
```

## 다른 UQ 방법과 비교

| 방법 | 이론적 기반 | 계산 비용 | 구현 복잡도 | PINN 호환성 |
|------|-----------|:--------:|:----------:|:----------:|
| **MC Dropout** | Variational inference | 낮음 | 매우 낮음 | ✅ 최적 |
| **Deep Ensembles** | Frequentist | 중간 | 낮음 | ✅ |
| **Bayesian NN (HMC)** | Exact Bayesian | 매우 높음 | 높음 | ❌ |
| **BNN (VI)** | Variational | 중간 | 높음 | ⚠️ |

## 융합 도메인에서의 중요성

MC Dropout은 **PINN 및 Physics-Constrained 모델의 불확실성 정량화에서 가장 실용적인 도구**로 사용된다:

| 적용 분야 | 설명 |
|----------|------|
| **PINN failure detection** | MC Dropout 분산으로 PINN 예측의 신뢰도 판단 |
| **B-PINNs** | HMC 기반 Bayesian PINN의 계산 비용 대비 간단한 대안 |
| **Aeroelastic UQ** | 구조-유체 연성 문제의 예측 불확실성 추정 |
| **Physics-Constrained Surrogate** | 레이블 없는 surrogate의 신뢰 구간 제공 |

## 한계

- Epistemic uncertainty만 추정 (aleatoric은 별도 모델링 필요)
- Dropout rate $p$는 하이퍼파라미터로 사전 설정 필요
- $T$ (MC sample 수)가 클수록 정확하지만 **T$\times$ 계산 비용**

## References

- Y. Gal & Z. Ghahramani, "Dropout as a Bayesian Approximation: Representing Model Uncertainty in Deep Learning", *ICML 2016*
- [[bayesian-uncertainty-vision]] — Aleatoric vs Epistemic 분류 (Kendall & Gal, 2017)
- [[deep-ensembles]] — MC Dropout과 비교되는 앙상블 기반 UQ
- [[uncertainty-quantification-deep-learning]] — UQ 전체 조망
- [[bayesian-pinns]] — MC Dropout을 PINN에 적용한 확장
- [[vvuq-framework]] — 과학 컴퓨팅 VV&UQ 프레임워크
- [[mc-dropout-vs-deep-ensembles]]
- [[koh-vs-deep-uq]]
