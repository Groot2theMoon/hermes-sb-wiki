---
title: "SOLIS: Physics-Informed Learning of Interpretable Neural Surrogates"
tags: [pinn, system-identification, quasi-lpv, physics-informed, surrogate-model, nonlinear-dynamics, curriculum-learning]
confidence: high
created: 2026-05-02
updated: 2026-05-02
sources: [raw/papers/2604.14879v1.md]
---

# SOLIS: Physics-Informed Learning of Interpretable Neural Surrogates for Nonlinear Systems

**Murat Furkan Mansur, Tufan Kumbasar** (Istanbul Technical University) — arXiv: 2604.14879

> 비선형 시스템 식별에서 **물리적 해석 가능성(interpretability)**과 **모델 유연성(flexibility)** 사이의 간극을 메우기 위해 제안된 프레임워크. SOLIS는 **state-conditioned second-order surrogate model**을 통해 Quasi-LPV (Quasi-Linear Parameter-Varying) 표현을 학습하고, 자연 주파수(natural frequency), 감쇠비(damping ratio), DC 게인(gain)을 해석 가능하게 복원한다.

---

## 핵심 통찰

### 문제 정의

기존 System Identification (SysID) 접근법의 한계:

- **고전적 방법**: 구조화되고 제어-지향적이지만, 강한 비선형성에서 경직됨
- **Neural ODEs**: 표현력이 뛰어나지만 black-box — damping ratio, natural frequency 등 제어 관련 물리량 추출 불가
- **Inverse PINN (IPINN)**: 알려진 지배 방정식(known governing equation)과 고정 계수를 가정 — 실제 미지 동역학이나 state-dependent parameter에선 **identifiability failure** 발생

### Second-Order Surrogate 가설

> *"국소적 궤적 기하학(local temporal geometry)은 2차 Quasi-LPV surrogate 동역학으로 근사 가능하다."*

즉, 비선형 시스템의 궤적을 **state-dependent mass-spring-damper**로 모델링:

$$\hat{\mathbf{f}}(\mathbf{x}, u; \boldsymbol{\theta}(\mathbf{x})) = \begin{bmatrix} v \\ -k(\mathbf{x})y - d(\mathbf{x})v + g(\mathbf{x})u \end{bmatrix}$$

| 계수 | 물리적 해석 |
|------|-------------|
| $k(\mathbf{x})$ | 강성 (stiffness) → $\omega_n(\mathbf{x}) = \sqrt{k(\mathbf{x})}$ |
| $d(\mathbf{x})$ | 감쇠 (damping) → $\zeta(\mathbf{x}) = d(\mathbf{x}) / (2\sqrt{k(\mathbf{x})})$ |
| $g(\mathbf{x})$ | 입력 게인 → $K(\mathbf{x}) = g(\mathbf{x}) / k(\mathbf{x})$ |

### 기존 IPINN과의 차별점

- IPINN: $\boldsymbol{\theta}$는 상수 벡터 — state-dependent parameter를 포착 불가
- SOLIS: $\boldsymbol{\theta}(\mathbf{x})$는 **state-conditioned vector field** — 각 상태에서 국소적으로 해석 가능한 물리량 제공

---

## 아키텍처

### Two-Network 구조

SOLIS는 **Solution Network**와 **Parameter Network**의 두 네트워크로 구성되며, Physics Loss로 연결된다.

```
Measurement Data ──→ [Solution Network (N_sol)] ──→ State Estimates (ŷ, v̂)
                                                           │
                                                           ▼
                                              [Parameter Network (N_param)]
                                                           │
                                                           ▼
                                              Affine Coeffs (k̂, d̂, ĝ)
                                                           │
                                              ┌────────────┴────────────┐
                                              ▼                        ▼
                                    Physics Loss (L_phys)    Ridge Hints (L_hint)
```

### Solution Network ($\mathcal{N}_{sol}$)

- **역할**: 시점 $t$에서 연속적인 상태 궤적 $\hat{\mathbf{x}}(t) = [\hat{y}(t), \hat{v}(t)]^\top$ 재구성
- **Context Embedding**: GRU로 제어 입력 시퀀스를 고정 차원의 context vector $\mathbf{c}$로 인코딩
- **FiLM Conditioning**: Feature-wise Linear Modulation [22]으로 context로 내부 특징 맵 변조
  $$\mathbf{z}'_l = \gamma_l(\mathbf{c}) \odot \mathbf{z}_l + \beta_l(\mathbf{c})$$
- **Fourier Encoding (선택사항)**: 고주파 진동 동역학을 위해 Random Fourier Features 사용

### Parameter Network ($\mathcal{N}_{param}$)

- **역할**: 상태 $(\hat{y}, \hat{v})$와 입력 $u$를 입력받아 $[\hat{k}, \hat{d}, \hat{g}]^\top$ 출력
- **Mixture-of-Experts (선택사항)**: 레짐 의존적 동역학에 대해 MoE 헤드로 국소 표현력 향상
  $$[\hat{k}, \hat{d}, \hat{g}]^\top = \sum_{j=1}^M \alpha_j(\mathbf{x}, u) \mathcal{E}_j(\mathbf{x}, u)$$
- **State Feature Augmentation (선택사항)**: $y^2, y^3, |y|, y \cdot v$ 등 고정 비선형 변환 입력 확장

---

## 학습 전략: Cyclic Curriculum

Naïve joint optimization은 gradient conflict로 인해 trivial solution ($\hat{y} \to 0, \hat{k} \to 0$)으로 붕괴. SOLIS는 **두 Phase를 교차하는 cyclic curriculum**으로 해결.

### Phase 1 — Trajectory Reconstruction

- $\mathcal{N}_{param}$ 고정, $\mathcal{N}_{sol}$만 최적화
- 목표: 희소 측정값으로부터 매끄러운 연속 궤적 복원
- 손실: $$\mathcal{L}_{P1} = \lambda_d \mathcal{L}_{data} + \lambda_{ic} \mathcal{L}_{ic} + \lambda_p \mathcal{L}_{phys}$$
- Physics residual은 **geometric regularizer** 역할 — 현재 parameter 추정에 따른 미분 제약을 interpolation에 주입

### Phase 2 — Parameter Identification

- $\mathcal{N}_{sol}$ 고정, $\mathcal{N}_{param}$ 최적화
- 손실: $$\mathcal{L}_{P2} = \lambda_p \mathcal{L}_{phys} + \lambda_{roll} \mathcal{L}_{rollout} + \lambda_h \mathcal{L}_{hint} + \lambda_{reg} (\mathcal{L}_{TV} + \mathcal{L}_{div})$$

### Local Physics Hints (핵심 기여)

Phase 2의 초기 최적화 붕괴를 방지하기 위한 **sliding-window ridge regression anchor**:

1. 각 collocation point $t$에서 window size $w \sim \mathcal{U}\{5, |\mathcal{T}_c|\}$ 샘플링
2. 로컬 윈도우 내에서 $\mathbf{Y} \approx \Phi \theta$의 ridge estimator 계산:
   $$\theta_{ridge}^*(t) = (\Phi^\top \Phi + \lambda_r \mathbf{I})^{-1} \Phi^\top \mathbf{Y}$$
3. Hint loss: 예측 $\hat{\theta}(t)$와 ridge anchor 간 편차를 가중치 $w_t$로 규제
   $$\mathcal{L}_{hint} = \frac{1}{|\mathcal{T}_c|} \sum_{t \in \mathcal{T}_c} w_t \left\| \hat{\theta}(t) - \theta_{ridge}^*(t) \right\|_2^2$$
4. 가중치 $w_t$는 $\Phi^\top \Phi$의 eigen-structure 기반 — ill-conditioned 영역에서 hint 억제
5. Hint 가중치 $\lambda_h$는 epoch마다 $\gamma$로 감소 (decay)

> **직관**: Ridge hint는 locally linearized convex proxy를 제공하여 비볼록 물리 손실의 warm-start 역할을 한다.

### 추가 정규화

- **$\mathcal{L}_{TV}$**: Total Variation — parameter field의 공간적 평활성 유도
- **$\mathcal{L}_{roll}$**: Short-horizon rollout — RK4 적분으로 예측한 상태와 solution network 출력 간 차이 최소화

---

## 실험 결과

### 검증 시스템

| 시스템 | 특성 | 식별 과제 |
|--------|------|-----------|
| **Duffing Oscillator** | Cubic stiffness $k(x) = \alpha + \beta x^2$ | State-dependent stiffness 복원 |
| **Van der Pol Oscillator** | Nonlinear damping $d(x) = \mu(x^2 - 1)$ | Self-sustained oscillation 식별 |
| **Two-Tank System** | 실제 실험실 데이터, 결합 탱크, 측정 잡음 | Real-world noise robustness |

### 비교 방법

- **IPINN**: 상수 $(k, d, g)$ 가정의 표준 inverse PINN
- **IPINN-M**: Multiple trajectory IPINN
- **TF**: MATLAB `tfest` 2차 전달함수 추정

### Solution Reconstruction (In-sample)

| System | IPINN | IPINN-M | **SOLIS** |
|--------|-------|---------|-----------|
| Van der Pol | 95.94% | 98.07% | **98.89%** |
| Duffing | 95.43% | 97.56% | **99.01%** |
| Two-Tank | 88.64% | 91.25% | **98.62%** |

(Accuracy: $(1 - \text{NRMSE}) \times 100\%$)

### Phase Portrait Similarity

| System | IPINN | IPINN-M | **SOLIS** |
|--------|-------|---------|-----------|
| Van der Pol | 0.70 | 0.67 | **0.86** |
| Duffing | 0.81 | 0.82 | **0.96** |

(Cosine similarity to ground-truth vector field)

### Predictive Rollout (Test trajectories)

| System | IPINN | IPINN-M | TF | **SOLIS** |
|--------|-------|---------|----|-----------|
| Van der Pol | 83.72% | 81.84% | 70.22% | **90.54%** |
| Duffing | 76.60% | 75.27% | 74.60% | **83.07%** |
| Two-Tank | 82.74% | 82.9% | 77.74% | **84.29%** |

> SOLIS는 모든 벤치마크에서 in-sample reconstruction, phase portrait similarity, out-of-sample rollout에서 일관되게 최고 성능. 특히 IPINN이 실패하는 **state-dependent parameter 영역**에서도 안정적인 복원을 보임.

---

## RIGOR 관련성

| 접점 | 설명 |
|------|------|
| **Physics-informed sysID** | RIGOR는 A+NN $x_{t+1} = A x_t + \text{NN}(x_t)$ 형태의 physics-informed 식별. SOLIS는 2차 Quasi-LPV surrogate라는 서로 다른 구조적 가정으로 PINN 기반 식별을 수행 |
| **Optimization 안정화** | RIGOR는 EM 기반 점진적 추정으로 안정화. SOLIS는 cyclic curriculum + ridge hint로 최적화 붕괴 방지 — **서로 다른 경로로 동일한 문제(IPINN의 ill-conditioning) 해결** |
| **해석 가능성** | RIGOR는 Lur'e 안정성 이론으로 NN 피드백 해석. SOLIS는 $k(\mathbf{x}), d(\mathbf{x}), g(\mathbf{x})$로 자연 주파수/감쇠비/게인을 직접 추출 — **제어 지향적 해석 가능성** |
| **Local Physics Hints** | Ridge regression anchor는 [[jeffreys-prior-dimension-scaling]]과 유사하게 locally linearized proxy로 비볼록 문제를 warm-start. RIGOR의 prior-guided Q,R 추정과 병렬적 통찰 |
| **Curriculum Learning** | Phase 1→Phase 2 교대는 RIGOR의 E-step/M-step 교대와 구조적 유사성 — coupled 역문제를 분해하는 일반적 전략 |

---

## Wikilinks

- [[pinn-failure-modes]] — SOLIS가 직접적으로 해결하는 PINN 최적화 실패 모드 (gradient pathology, spectral bias)
- [[physics-informed-neural-networks]] — SOLIS의 기반 프레임워크인 PINN에 대한 개념 페이지
- [[neural-odes]] — SOLIS Solution Network의 대안적 연속시간 모델링 접근법
- [[state-space-model]] — Quasi-LPV surrogate의 제어이론적 배경 (LPV state-space)
- [[universal-differential-equations]] — Neural ODE + universal approximation의 관점에서 SOLIS와 연결

---

## References

- arXiv: [2604.14879](https://arxiv.org/abs/2604.14879)
- GitHub: [github.com/Assaciry/solis](https://github.com/Assaciry/solis)
