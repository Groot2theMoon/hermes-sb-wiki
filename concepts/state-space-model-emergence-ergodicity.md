---
title: "State Space Models — Emergence, Ergodicity, and Critical Parameter Thresholds"
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [neural-network, mathematics, training, paper, theory]
sources: [raw/papers/ziemann25a.md]
confidence: medium
---

# SSM Emergence and Ergodicity

## 개요

Ziemann, Matni, Pappas (UPenn, 2025)는 LLM의 **emergent capability** 현상을 선형 동적 시스템(linear dynamical system) 이론으로 설명한다. Self-supervised learning의 간단한 모델로서 **비에르고딕(non-ergodic)** 선형 시스템에서 parameter 수가 임계값을 넘지 않으면 안정적 예측이 불가능함을 증명.

## 핵심 아이디어

### Emergence as Phase Transition
- LLM에서 관찰되는 emergent capabilities → parameter count threshold
- 선형 시스템 학습에서도 대응되는 상전이 존재
- 비에르고딕 시스템: trajectory의 시작과 끝에서 통계적 특성이 다름

### Theoretical Model
- **Assumption:** data $Z_{1:T}$가 latent SSM $X_{t+1} = A_*X_t + W_t$에 의해 생성
- **KL-risk lower bound:**
  $$d_{\text{KL}}(P_Z \| Q_Z) \gtrsim \sum_{t=1}^T \mathbb{E}_P \|\mathbb{E}_P^{t-1}Y_t - \mathbb{E}_Q^{t-1}Y_t\|^2$$
- Stable learner 존재 조건: parameter count > critical threshold

### 핵심 결과
- 모든 non-ergodic linear system에 대해 **critical parameter threshold** 존재
- Threshold 미만 → long sequence에서 bounded error 불가능 ($T^{-1} \cdot \text{KL} \to \infty$)
- 예: hidden state가 있는 random walk — linear filter length가 horizon-dependent threshold 초과해야

## 의의
- Emergence 현상의 **mechanistic explanation** 제공
- SSM architecture (Mamba, S4 등) 설계에 이론적 근거
- Bias-variance tradeoff의 bias 항이 phase transition을 겪는 사례

## 융합 도메인 연결
- [[linear-rnn-theory]] — SSM과 RNN의 이론적 분석
- [[koopman-learner-continual-lifting]] — 동적 시스템 학습
- [[nn-tricks]] — 모델 스케일링과 학습 안정화
