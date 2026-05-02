---
title: Information Shapes Koopman Representation
tags: [koopman, information-bottleneck, representation-learning, dynamical-systems, iclr-2026]
confidence: high
created: 2026-05-02
updated: 2026-05-02
sources: [raw/papers/information-koopman-2510.13025.md]
---

# Information Shapes Koopman Representation

**Cheng, Yuan, Yang, Zhang, Cheng, He, Sun** (UCL, NYU, SFU, Imperial College, Northeastern) — ICLR 2026

> 정보 이론(Information Bottleneck)의 관점에서 Koopman representation 학습을 재해석하고, **표현력(expressivity)과 단순성(simplicity)** 간의 균형을 **정보 이론적 Lagrangian formulation**으로 해결한 연구.

---

## 핵심 통찰

### 문제 정의

Koopman 연산자는 비선형 동역학을 선형화하는 강력한 프레임워크지만, 적절한 유한 차원 부분공간(subspace)을 찾는 것이 어렵다. 저자들은 이 어려움의 근본 원인이 **잠재 변수(latent variable)의 표현력과 단순성 간 균형 실패**에 있다고 주장한다.

### 정보 병목(Information Bottleneck) 관점

Koopman 학습을 Information Bottleneck(IB) 렌즈로 재해석:

- **단순성(Simplicity):** 잠재 상호 정보(Mutual Information)가 작을수록 표현이 간결해짐
  - $`I(z_t; z_{t+\tau})`$ 최소화 → 중복 정보 제거
  - 지나치면 잠재 공간이 소수 모드로 붕괴(collapse)
- **표현력(Expressivity):** von Neumann 엔트로피가 모드 다양성을 유지
  - $`S(\rho) = -\text{Tr}(\rho \log \rho)`$, $\rho = \Sigma / \text{Tr}(\Sigma)$
  - 잠재 공간의 유효 차원(effective dimensionality) 유지
  - 붕괴 방지 — 충분한 수의 모드가 활성화되도록 보장

### 제안: 정보 이론적 Lagrangian

$$
\mathcal{L} = \underbrace{\mathcal{L}_{\text{pred}}}_{\text{forward MSE}} + \lambda_{\text{id}} \underbrace{\mathcal{L}_{\text{id}}}_{\text{autoencoder reconstruction}} + \lambda_{\text{MI}} \underbrace{I(z_t; z_{t+\tau})}_{\text{simplicity}} - \lambda_S \underbrace{S(\rho)}_{\text{expressivity}}
$$

- $\mathcal{L}_{\text{pred}}$: Koopman 선형 예측 (forward dynamics)
- $\mathcal{L}_{\text{id}}$: Autoencoder 재구성 (identity mapping)
- $I(z_t; z_{t+\tau})$: InfoNCE로 추정된 상호 정보 (단순성 유도)
- $S(\rho)$: von Neumann 엔트로피 (표현력 유지, 모드 붕괴 방지)

---

## 아키텍처

```
Encoder → z_t → [Koopman: C_forward] → z_{t+1} → Decoder → x_{t+1}
              ↘                                      ↗
        [InfoNCE MI]                          [von Neumann Entropy]
```

### Encoder-Decoder
- `ENCODER_BASE` / `DECODER_BASE`: 임의의 NN 모듈을 래핑
- `ROM_BASE`: Encoder → Koopman(linear) → Decoder 파이프라인

### Koopman 연산자 학습
- `batch_pinv()`: Tikhonov 정규화된 pseudo-inverse로 $`C_{\text{forward}}`$ 계산
  ```python
  C_forward = (Z^T Z + λI)^{-1} Z^T Z_next
  ```
- SVD 추적: 학습 중 C_forward의 singular value 분포 모니터링

### InfoNCE (상호 정보 최소화)
- 시간 축 상의 neighborhood 구조 활용
- 각 anchor $`z_n`$에 대해:
  - Positive: $`\{z_{n\pm i} | 1 \leq i \leq k\}`$
  - Negative: 그 외 모든 time step
- Multiple positive InfoNCE: $`-\log \frac{\sum e^{\text{sim}(z_n, z_p)/\tau}}{\sum e^{\text{sim}(z_n, z_p)/\tau} + \sum e^{\text{sim}(z_n, z_n')/\tau}}`$

### von Neumann Entropy (표현력 유지)
- 잠재 공간의 covariance matrix $`\Sigma = Z^T Z / (N-1)`$ 계산
- 정규화: $`\rho = \Sigma / \text{Tr}(\Sigma)`$
- 엔트로피: $`S = -\sum \lambda_i \log \lambda_i`$ (eigenvalue 기반)
- $\rho$의 eigenvalue 분포가 균일할수록 = 많은 모드 활성화 = 높은 표현력

---

## 실험 검증

### 검증 시스템
1. **Cylinder flow** — 2D 유체 역학 (vortex shedding)
2. **Dam break** — 자유 표면 유동 (shallow water equation)

### 결과
- 기존 Koopman 학습 방법 대비 일관된 성능 향상
- 잠재 공간 시각화: 저자들의 이론적 예측과 일치
  - 단순성만 강조 → 소수 모드로 붕괴
  - 표현력만 강조 → 잡음 과적합
  - 둘의 균형 → 안정적이고 해석 가능한 표현

---

## 코드 구조

| 경로 | 설명 |
|------|------|
| `model/physical_simulation/base.py` | Encoder/Decoder/ROM_BASE, loss 계산 (forward + ID + MI + entropy) |
| `model/physical_simulation/Cylinder/` | Cylinder flow 전용 모델 |
| `model/physical_simulation/Dam/` | Dam break 전용 모델 |
| `train_scripts/physical_simulation/trainer.py` | 학습 루프, validation, early stopping |
| `train_scripts/physical_simulation/cylinder/` | Cylinder 학습 설정 및 스크립트 |
| `train_scripts/physical_simulation/dam/` | Dam 학습 설정 및 스크립트 |

> **참고:** Physical simulation experiments만 공개됨. 나머지 실험 코드는 논문 게재 후 공개 예정.

---

## RIGOR 관련성

이 논문과 RIGOR의 접점:

1. **정보 이론적 loss 설계:** RIGOR도 NLL + Jeffreys prior + entropy 기반 loss를 사용. 이 논문의 MI-entropy Lagrangian은 loss 설계에 대한 정보 이론적 정당화 제공
2. **잠재 공간 정규화:** von Neumann entropy로 모드 붕괴 방지 — RIGOR의 SpectralDense.limit_factor(spectral norm regularization)와 유사한 역할을 정보 이론적으로 달성
3. **Koopman vs A+NN:** 이 논문은 표준 Koopman 접근법(linear dynamics in lifted space). RIGOR는 A+NN (x_{t+1} = A·x_t + NN(x_t)) — Lur'e 시스템. 두 접근법 모두 "선형 골격 + 비선형 보정" 구조를 공유하지만, 이 논문은 정보 이론적 정규화에 초점
4. **차이점:** 이 논문은 InfoNCE로 MI 최소화. RIGOR는 EM 기반 Q,R 추정. 두 접근법은 직교하지만, 잠재 공간의 질을 제어한다는 점에서 유사

---

## Wikilinks
- [[koopman-learner-continual-lifting]] — Koopman dynamics + continual learning (로봇 제어)
- [[koopman-resolvent-dynamics]] — Koopman-Resolvent generator learning
- [[rigor-filter]] — RIGOR: Differentiable SR-UKF (A+NN + Lur'e 안정성)
- [[lure-stability]] — Lur'e system + NN feedback (RIGOR A+NN과 동형)

## References
- arXiv: [2510.13025](https://arxiv.org/abs/2510.13025)
- GitHub: [Wenxuan52/InformationKoopman](https://github.com/Wenxuan52/InformationKoopman)
