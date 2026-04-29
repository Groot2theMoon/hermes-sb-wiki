---
title: Linear RNN Parallelization Theory
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [classic-ai, neural-network, model, paper, sequence-modeling]
sources: [raw/papers/2603.03612v2.md]
confidence: high
---

# 선형 RNN 병렬화 이론

## 개요

**Merrill, Jiang, Li, Lin, Sabharwal** ([[allen-institute-for-ai|[[allen-institute-for-ai|Allen Institute]] for AI]] / RPTU / MPI-SWS, 2025)는 **선형 RNN (LRNN)**이 기존 비선형 RNN보다 병렬화에 유리한 이유를 **복잡도 이론(complexity theory)**의 관점에서 엄밀히 분석했다^[raw/papers/2603.03612v2.md]. 이론적 결과는 실험적 검증까지 포함한다.

## 핵심 결과

| RNN 종류 | 복잡도 클래스 | NC 회로 깊이 | 오토마타 |
|:--------:|:----------:|:----------:|:-------:|
| S4, Mamba (대각 SSM) | **TC⁰** | $O(\log n)$ | — |
| PD LRNN (Permutation-Diagonal) | **NC¹** | $O(\log n)$ | DWFA |
| DPLR LRNN (DeltaNet, RWKV-7) | **PNC¹** | $O(\log n \cdot \log^* n)$ | WFA |
| 비선형 RNN (log precision) | **L** | $O(\log^2 n)$ | Counter machine |
| 비선형 RNN (poly precision) | **P** | polylog 초과 | Turing machine |

**결론:** 선형 RNN은 Transformer와 유사한 수준의 병렬 효율성($O(\log n)$ ~ $O(\log n \log^* n)$)을 가지는 반면, 비선형 RNN은 근본적으로 더 **순차적**이다.

## 이론적 직관

### 선형 RNN = 산술 회로

선형 RNN의 상태 업데이트 $h_t = \mathbf{A} h_{t-1} + \mathbf{B} x_t$ (선형)는 **행렬 곱셈의 연쇄**로 표현 가능:

$$h_n = \mathbf{A}^n h_0 + \sum_{i=1}^n \mathbf{A}^{n-i} \mathbf{B} x_i$$

이 연산은 **log-depth 산술 회로**로 병렬화 가능하다 (associativity + prefix sum trick).

### 비선형 RNN = P-완전 문제

비선형 RNN $h_t = f(h_{t-1}, x_t)$의 $f$에 비선형 활성화(tanh, sigmoid 등)가 포함되면, 상태 업데이트가 **P-complete** 문제를 표현할 수 있다 (polynomial precision 기준). 이는 NC (병렬 처리 가능) ≠ P 가설 하에서, 비선형 RNN이 선형 RNN보다 **근본적으로 더 병렬화하기 어렵다**는 증거이다.

## LRNN 변종 간 표현력 차이

| 변종 | 행렬 구조 | 완전 문제 | 예시 모델 |
|:---:|:-------:|:--------:|:--------:|
| **Diagonal** | $\mathbf{A}$ = 대각 행렬 | TC⁰-complete | S4, Mamba |
| **PD** | $\mathbf{A}$ = permutation + diagonal | NC¹-complete | PD-SSM |
| **DPLR** | $\mathbf{A}$ = diagonal + low-rank | PNC¹-complete | DeltaNet, RWKV-7 |

**시사점:** DPLR LRNN(DeltaNet, RWKV-7)은 PD LRNN보다 더 표현력이 높지만, 약간의 회로 깊이 오버헤드($\log^* n$)가 발생한다.

## 실험적 검증

- **L-complete 문제 (그래프 연결성):** 비선형 RNN만 해결 가능 (이론과 일치)
- **PNC¹-complete 문제 (반복 행렬 곱):** DPLR LRNN과 비선형 RNN 해결 가능, Mamba/Transformer는 불가능
- 이는 합성 벤치마크로서 LRNN 아키텍처 개발에 활용 가능

## 융합 도메인 연결

- **대조군:** [[gated-recurrent-units]] (비선형 RNN) → [[mamba]] (선형 RNN/S6)의 이론적 연결고리
- LRNN의 병렬성-표현력 trade-off는 [[transformer-vs-mamba]] 비교 분석에 핵심적 통찰 제공
- 표현력과 계산 효율성의 균형은 모든 ML 아키텍처 설계의 근본적 문제

## References
- Merrill, W. et al. (2025). Why Are *Linear* RNNs More Parallelizable? arXiv:2603.03612.
- [[gated-recurrent-units]]
- [[mamba]]
- [[transformer-vs-mamba]]
