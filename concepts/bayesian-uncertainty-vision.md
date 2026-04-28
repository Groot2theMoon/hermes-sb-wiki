---
title: Aleatoric & Epistemic Uncertainty in Deep Learning
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, inference, training, paper, benchmark]
sources: [raw/papers/1703.04977v2.md]
confidence: high
---

# Aleatoric & Epistemic Uncertainty in Bayesian Deep Learning

## 개요

Alex Kendall & Yarin Gal (Cambridge, 2017)은 컴퓨터 비전에서 **두 가지 유형의 불확실성** — aleatoric (데이터 노이즈)과 epistemic (모델 불확실성) — 을 구별하여 모델링하는 프레임워크를 제시했다^[raw/papers/1703.04977v2.md]. Monocular depth regression과 semantic segmentation에서 SOTA 달성.

## 두 가지 불확실성

### Aleatoric Uncertainty (偶然的不確実性)
- 데이터 관찰 자체에 내재된 노이즈 (센서 노이즈, 모션 블러 등)
- **데이터가 많아도 줄어들지 않음**
- Heteroscedastic: 입력에 따라 변화 (예: 먼 물체 > 가까운 물체)
- **실시간 추론 가능** (Monte Carlo sampling 불필요)

### Epistemic Uncertainty (認識論的不確実性)
- 모델 파라미터에 대한 불확실성 (= model uncertainty)
- **데이터가 많을수록 감소** (explain away)
- Out-of-distribution 입력 탐지에 필수적
- Monte Carlo Dropout으로 근사 (50회 sampling)

### 결합 모델
- 손실 함수: $\mathcal{L}_{\text{BNN}}(\theta) = \frac{1}{D}\sum_i \frac{1}{2}\hat{\sigma}_i^{-2}\|y_i - \hat{y}_i\|^2 + \frac{1}{2}\log\hat{\sigma}_i^2$
- $\hat{\sigma}^2$를 log-variance $s_i := \log\hat{\sigma}_i^2$로 예측 (수치 안정성)

## 주요 결과

| Task | 개선 효과 |
|------|----------|
| CamVid segmentation | IoU 66.9→**67.5** |
| NYUv2 segmentation | IoU 36.5→**37.3** |
| Make3D depth | rel 0.167→**0.149** |
| NYUv2 depth | rel 0.117→**0.110** |

- Aleatoric uncertainty = **Learned loss attenuation** (잘못된 레이블의 영향을 자동 감쇠)
- OOD 탐지: Epistemic uncertainty만이 out-of-distribution 입력에서 증가

## References
- A. Kendall, Y. Gal. "What Uncertainties Do We Need in Bayesian Deep Learning for Computer Vision?", *NeurIPS 2017*
- [[deep-ensembles]] — 대안적 uncertainty 추정 방법
- [[densenet]] — 실험에서 backbone으로 사용