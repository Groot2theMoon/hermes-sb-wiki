---
title: Deep Ensembles — Loss Landscape Perspective
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [classic-ai, training, benchmark, uncertainty, paper]
sources: [raw/papers/1912.02757v2.md]
confidence: high
---

# Deep Ensembles: Loss Landscape View

## 개요

**Fort, Hu, [[balaji-lakshminarayanan|Lakshminarayanan]]** (Google Research / DeepMind, 2019)은 **loss landscape 관점**에서 deep ensembles의 성공 원인을 분석했다^[raw/papers/1912.02757v2.md]. 왜 단순히 random initialization만 다르게 한 앙상블이 Bayesian 신경망(Bayesian NN)보다 실제로 더 잘 작동하는지 설명한다.

## 관찰된 현상

Deep ensembles (Lakshminarayanan et al., 2017)는 단순히 **랜덤 초기화 + 독립적 학습**만으로도:
- OOD(out-of-distribution) 검출에서 Bayesian NN보다 우수
- 예측 불확실성 보정(calibration)에서 우수
- Bootstrap 없이도 잘 작동

| 방법 | 모드 탐색 | OOD 성능 | 계산 비용 |
|:---:|:--------:|:--------:|:--------:|
| **Deep ensemble** | ✅ 여러 모드 | 우수 | M배 (병렬 가능) |
| MAP 추정 | ❌ 단일 모드 | 낮음 | 1배 |
| Variational Bayesian | ❌ 단일 모드 중심 | 보통 | M배 근사 |
| MC Dropout | ❌ 단일 모드 subspace | 보통 | 1배 |

## 핵심 가설

Bayesian NN은 단일 모드(single mode) 주변의 국소적 불확실성만 포착하는 반면, Deep ensemble은 **서로 다른 loss basin** → **서로 다른 함수 공간 모드**를 탐색한다.

$$
\text{서로 다른 random seed} \rightarrow \text{서로 다른 loss basin} \rightarrow \text{다양한 예측 패턴} \rightarrow \text{앙상블 이점}
$$

### Loss Basin 다양성

- 같은 random seed 내에서는 서로 다른 최적화 궤적의 함수들이 **함수 공간에서 매우 유사** (무게 공간에서는 멀리 떨어져 있어도)
- 서로 다른 random seed는 **완전히 다른 모드** 탐색 → 함수 공간에서 낮은 상관관계
- Low-loss tunnel(Garipov et al., 2018)은 두 모드를 연결하지만, **터널 중간의 함수들은 크게 다름**

## Diversity-Accuracy 평면

저자들은 **diversity-accuracy 평면**을 도입했다:

- x축: 예측 다양성 (pairwise disagreement)
- y축: accuracy

**핵심 발견:**
- Random initialization이 만드는 다양성은 **subspace sampling 방법보다 지배적으로 높음**
- Subspace 내 샘플링(dropout, diagonal Gaussian, low-rank Gaussian)은 accuracy는 높지만 **다양성이 현저히 낮음**
- **앙상블 + subspace의 조합**도 subspace 단독보다 크게 개선되지 않음

## 이론적 시사점

1. **Mode connectivity ≠ function similarity:** Low-loss tunnel이 존재해도 터널 내 함수들은 크게 다름
2. **Epistemic uncertainty 포착엔 다양한 함수 모드가 필수적:** Loss landscape의 multi-modality가 deep ensemble 성공의 핵심
3. **\"Local\" UQ 방법(VI, MC Dropout)의 한계:** 같은 모드 내에서만 샘플링 → OOD 검출 성능 제한

## 융합 도메인 연결

- [[deep-ensembles]]의 **이론적 보충** — "왜 앙상블이 잘 작동하는가"에 대한 설명
- [[mc-dropout]] — MC Dropout (Gal & Ghahramani)의 근사적 Bayesian 접근과의 비교
- [[uncertainty-quantification-deep-learning]] — UQ 리뷰의 핵심 참고문헌 중 하나
- DMN 앙상블로 재료 특성 예측의 **epistemic uncertainty** 정량화 시 활용 가능

## References
- Fort, S., Hu, H., & Lakshminarayanan, B. (2019). Deep Ensembles: A Loss Landscape Perspective. arXiv:1912.02757.
- [[deep-ensembles]]
- [[mc-dropout]]
- [[bayesian-uncertainty-vision]]
- [[mc-dropout-vs-deep-ensembles]]
- [[stanislav-fort]]
