---
title: Hidden Markov Model — Tutorial
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, algorithms, generative-model, sequence-modeling]
sources: [raw/papers/rabiner1.md]
confidence: high
---

# Hidden Markov Model (HMM) Tutorial

## 개요

**Lawrence Rabiner (IEEE Proceedings, 1989)** 의 HMM 튜토리얼은 음성 인식 분야에서 **Hidden Markov Model**의 이론과 응용을 체계적으로 정리한 **가장 영향력 있는 논문 중 하나**이다 (74,000+ 인용). HMM은 **관측 가능한 데이터 뒤에 숨겨진 상태(sequence)가 Markov 과정을 따른다**는 가정 하에 시계열 데이터를 모델링하는 확률적 프레임워크이다^[raw/papers/rabiner1.md].

## 핵심 개념

### HMM의 구성 요소
HMM은 5중 튜플 $\lambda = (N, M, A, B, \pi)$로 정의된다:

- **$N$:** 은닉 상태의 수 (예: 음소分類)
- **$M$:** 관측 심볼의 수 (예: MFCC feature vector)
- **$A = \{a_{ij}\}$:** 상태 전이 확률 행렬 ($N \times N$)
- **$B = \{b_j(k)\}$:** 관측 확률 (emission probability, $N \times M$)
- **$\pi = \{\pi_i\}$:** 초기 상태 분포

### 세 가지 기본 문제 (Rabiner의 정리)

| 문제 | 알고리즘 | 설명 |
|------|---------|------|
| **평가 (Evaluation)** | **Forward-Backward** | 주어진 관측열 $O$에 대해 $P(O \mid \lambda)$ 계산 |
| **디코딩 (Decoding)** | **Viterbi** | 최적 상태열 $Q^* = \arg\max_Q P(Q \mid O, \lambda)$ 탐색 |
| **학습 (Learning)** | **Baum-Welch (EM)** | 관측열에서 $\lambda^* = \arg\max_\lambda P(O \mid \lambda)$ 추정 |

### Forward 알고리즘
$$\alpha_t(i) = P(o_1, o_2, \dots, o_t, q_t = S_i \mid \lambda)$$
$$\alpha_{t+1}(j) = \left[\sum_{i=1}^N \alpha_t(i) a_{ij}\right] b_j(o_{t+1})$$

### Viterbi 알고리즘 (DP 기반 최적 경로)
$$\delta_t(j) = \max_{i} [\delta_{t-1}(i) a_{ij}] \cdot b_j(o_t)$$

### Baum-Welch (EM) 재추정
$$\xi_t(i,j) = P(q_t = S_i, q_{t+1} = S_j \mid O, \lambda)$$
$$\hat{a}_{ij} = \frac{\sum_{t=1}^{T-1} \xi_t(i,j)}{\sum_{t=1}^{T-1} \sum_k \xi_t(i,k)}$$

## HMM의 한계와 발전

| 한계 | 극복 방법 |
|------|----------|
| Markov 가정 (1차) | Higher-order HMM, RNN |
| 상태 수 사전 결정 | Bayesian HMM, Infinite HMM |
| 음향 모델만 가능 | **RNN/LSTM** — 과거 전체 맥락 활용 |
| 순차 처리 강제 | **Transformer** — 병렬 self-attention |

## 융합 도메인에서의 의의

HMM은 PINN, FNO 등 본 도메인의 최신 방법과 직접 비교되는 **sequence modeling의 고전적 기준선(baseline)** 이다:
- **PINN failure modes** (NTK 기반) — HMM의 Forward-Backward와 유사한 message-passing 구조
- **Physics-constrained surrogate** — state-space model과 PINN의 연결점
- **Mamba/SSM** — HMM → 선형 RNN → SSM으로 이어지는 확장선의 시초

## References

- L.R. Rabiner, "A Tutorial on Hidden Markov Models and Selected Applications in Speech Recognition", *Proc. IEEE*, 1989
- [[gated-recurrent-units]] — HMM을 계승한 sequence 모델링 접근법
- [[transformer]] — HMM의 순차적 한계를 극복한 병렬 아키텍처
- [[mamba]] — HMM → 선형 RNN → SSM 계보
- [[linear-rnn-theory]] — HMM과 선형 RNN의 이론적 연결
- [[universal-approximation-theorem]] — 함수 근사 이론의 출발점
