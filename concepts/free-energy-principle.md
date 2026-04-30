---
title: Free Energy Principle — Variational Free Energy Minimization as a Unified Brain Theory
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [neuroscience, cognitive-science, self-organization, information-theory, theory]
sources: [raw/papers/The free-energy principle - a rough guide to the brain.md, raw/papers/nrn2787.md]
confidence: high
---

# Free Energy Principle (FEP)

Karl Friston이 제안한 뇌 기능 통합 이론. 모든 자기조직화 시스템은 **변분 자유에너지(variational free energy)를 최소화**하며, 이로부터 지각(perception), 행동(action), 학습(learning)이 자연스럽게 도출된다.

## 동기: 무질서에 저항하기

생물학적 시스템의 핵심 특성은 **환경 변화에도 불구하고 자신의 상태를 유지**하는 것이다 (homeostasis). 수학적으로 이는 감각 상태의 **entropy가 낮아야** 함을 의미한다.

- **Entropy:** 오랜 기간 평균 surprise의 기댓값
- **Surprise:** 어떤 결과의 음의 로그 확률 = -ln p(y|m)
- 생물은 "surprising한 상태" (예: 물 밖의 물고기)를 피해야 함 → entropy 최소화
- 그러나 surprise는 직접 계산 불가능 (세계의 모든 숨은 상태를 알아야 하므로)

**핵심 통찰:** 자유에너지는 surprise의 **상한(upper bound)**이므로, 자유에너지를 최소화하면 surprise도 암묵적으로 최소화된다. 자유에너지는 감각 데이터와 내부 표현만으로 계산 가능하다.

^[raw/papers/nrn2787.md]

## 수학적 정의

자유에너지 F는 다음 세 가지 등가 형태로 표현된다:

**① Energy - Entropy 분해 (열역학적 형태):**
```
F = Energy - Entropy
  = -⟨ln p(y,θ|m)⟩_q + ⟨ln q(θ)⟩_q
```
- Energy: 감각 y와 원인 θ의 결합 surprise에 대한 기댓값
- Entropy: 인식 밀도 q(θ)의 entropy (시스템 자신의 불확실성)

**② Divergence + Surprise 분해 (지각 최적화):**
```
F = Divergence + Surprise
  = D_KL(q(θ,μ) || p(θ|y)) - ln p(y|m)
```
- KL divergences → 0에 접근: q(θ) → p(θ|y) (인식 밀도가 진짜 사후분포로 수렴)
- F → surprise의 tight bound: 지각 = Bayesian inference

**③ Complexity - Accuracy 분해 (행동 최적화):**
```
F = Complexity - Accuracy
  = D_KL(q(θ) || p(θ)) - ⟨ln p(y|θ)⟩_q
```
- Action은 accuracy만 증가시킬 수 있음 (complexity는 불변)
- 행동 = 예측과 일치하는 감각을 선택적으로 샘플링

^[raw/papers/The free-energy principle - a rough guide to the brain.md] ^[raw/papers/nrn2787.md]

## 두 가지 최적화: 지각과 행동

### 지각 (Perception) = 내부 상태 μ 최적화

```
μ = arg min_μ D_KL(q(θ,μ) || p(θ|y))
```

- 인식 밀도 q(θ,μ)를 사후분포 p(θ|y)에 근사시킴
- **Predictive coding**으로 구현: 예측 오차(prediction error)를 상위로 전달하고, 예측을 하위로 전달하는 재귀적 메시지 전달
- 피질 계층구조는 hierarchical generative model의 자연스러운 구현

### 행동 (Action) = Active Inference

```
a = arg max_a Accuracy = arg max_a ⟨ln p(y|θ)⟩_q
```

- 감각 입력을 예측과 일치시키도록 환경에 작용
- **"자기실현적 예언"**: 예측을 충족시키는 방향으로 행동하여 surprise 회피
- Value-learning의 대안: prior expectations 만으로 최적 제어 가능 (mountain car 문제 해결)

^[raw/papers/The free-energy principle - a rough guide to the brain.md]

## 신경생물학적 구현

| 인지 기능 | 최적화 대상 | 생물학적 구현 |
|-----------|------------|--------------|
| **지각 추론** | Synaptic activity (states μ^x, μ^v) | 뉴런 발화율, 예측 코딩 |
| **학습/기억** | Synaptic efficacy (parameters μ^θ) | Hebbian plasticity (연관성 기반) |
| **주의** | Synaptic gain (precision μ^λ) | Neuromodulation (dopamine, ACh) |

**계층적 메시지 전달 (Hierarchical Message Passing):**
- Forward connections: 예측 오차 전달 (superficial pyramidal cells)
- Backward connections: 예측 전달 (deep pyramidal cells)
- Precisions은 각 수준에서 bottom-up 오차와 top-down 예측의 상대적 가중치를 제어

^[raw/papers/nrn2787.md]

## FEP가 통합하는 이론들

Friston이 nrn2787에서 제시한 통합:

| 이론 | FEP 내 역할 |
|------|------------|
| **Bayesian Brain Hypothesis** | 지각 = generative model의 Bayesian inversion |
| **Predictive Coding** | Laplace 근사 하에서 FEP의 구체적 구현 |
| **Infomax / Efficient Coding** | FEP에서 uncertainty 무시한 특수 사례 |
| **Cell Assembly / Hebbian Plasticity** | Parameter inference = 자유에너지 경사하강 |
| **Neural Darwinism** | 가치(value) = -surprise, prior expectations이 innate value 인코딩 |
| **Optimal Control / RL** | Cost = free energy, policy = action이 prior expectations 실현 |
| **Attention (Biased Competition)** | Precision 최적화 = synaptic gain modulation |

^[raw/papers/nrn2787.md]

## 핵심 공식 요약

```
자유에너지 = Energy - Entropy = Complexity - Accuracy = Divergence + Surprise

지각: q(θ) → p(θ|y)   (KL 발산 최소화 → Bayesian inference)
행동: y → 예측과 일치   (Accuracy 최대화 → active inference)
학습: θ → causal regularities 포착  (자유에너지 경사하강 = Hebbian plasticity)
주의: λ → precision 최적화  (synaptic gain = neuromodulation)
```

## 다른 개념과의 연결

- [[variational-autoencoder]] — VAE의 ELBO는 FEP와 수학적으로 동일한 자유에너지 최소화
- [[uncertainty-quantification-deep-learning]] — Predictive entropy는 FEP의 surprise 개념과 연결
- [[optimal-control]] — FEP에서 optimal control은 prior expectations의 실현
- [[bayesian-pinns]] — Bayesian inference as free energy minimization
- [[landauer-friston-connection]] — 정보-열역학적 Landauer 원리와의 연결

## References

- Friston, K. (2009). The free-energy principle: a rough guide to the brain? *Trends in Cognitive Sciences*, 13(7), 293-301.
- Friston, K. (2010). The free-energy principle: a unified brain theory? *Nature Reviews Neuroscience*, 11, 127-138. doi:10.1038/nrn2787


- [[brain-active-inference]] — BRAIN — Active Inference AI Systems
