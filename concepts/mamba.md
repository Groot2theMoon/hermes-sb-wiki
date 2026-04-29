---
title: Mamba — Linear-Time Sequence Models with Selective SSMs
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [model, neural-network, paper, benchmark, state-space-model, sequence-model]
sources: [raw/papers/2312.00752v2.md]
confidence: high
---

# Mamba: Linear-Time Sequence Modeling with Selective State Spaces

## 개요

**Mamba**는 [[albert-gu|Albert Gu]] (CMU)와 Tri Dao (Princeton, Together AI)가 2023년 12월에 발표한 **selective state space model (SSM)** 기반의 시퀀스 모델링 아키텍처이다. Transformer의 $O(n^2)$ self-attention 복잡도를 $O(n)$으로 낮추면서도, 언어·오디오·유전체 등 다양한 modality에서 Transformer와 동등하거나 우수한 성능을 달성했다. Mamba는 기존 SSM(H3, S4 등)의 근본적 한계인 **입력 독립적 파라미터** 문제를 **선택 메커니즘(selection mechanism)** 으로 해결한 획기적 아키텍처다.

## State Space Model (SSM) 이론

### 연속시간 SSM

State Space Model은 1차 선형 ODE 시스템으로, 제어 이론에서 유래한 수학적 프레임워크다:

$$\begin{aligned}
h'(t) &= \mathbf{A} h(t) + \mathbf{B} x(t) \quad &\text{(state equation)} \\
y(t) &= \mathbf{C} h(t) + \mathbf{D} x(t) \quad &\text{(output equation)}
\end{aligned}$$

여기서:
- $x(t) \in \mathbb{R}^D$: 입력 신호
- $h(t) \in \mathbb{R}^N$: 은닉 상태 ($N$은 state dimension)
- $y(t) \in \mathbb{R}^D$: 출력
- $\mathbf{A} \in \mathbb{R}^{N \times N}$: 상태 전이 행렬
- $\mathbf{B} \in \mathbb{R}^{N \times D}$, $\mathbf{C} \in \mathbb{R}^{D \times N}$: 입출력 투영 행렬
- 일반적으로 $\mathbf{D} = 0$ (skip connection 생략)

### 이산화 (Discretization)

연속 SSM을 이산 시퀀스 처리에 사용하려면 **이산화(discretization)** 가 필요하다. Mamba는 Zero-Order Hold (ZOH) 방법을 사용한다:

$$\begin{aligned}
\overline{\mathbf{A}} &= \exp(\Delta \mathbf{A}) \\
\overline{\mathbf{B}} &= (\Delta \mathbf{A})^{-1}(\exp(\Delta \mathbf{A}) - \mathbf{I}) \cdot \Delta \mathbf{B}
\end{aligned}$$

여기서 $\Delta$는 시간 간격(step size)이다. 이산화 후 SSM은 다음과 같은 recurrent form으로 계산된다:

$$h_k = \overline{\mathbf{A}} h_{k-1} + \overline{\mathbf{B}} x_k, \quad y_k = \mathbf{C} h_k$$

### Convolutional Form

Recurrent SSM은 효율적인 병렬 학습을 위해 **convolutional form**으로 변환 가능하다:

$$\mathbf{y} = \mathbf{x} * \overline{\mathbf{K}}, \quad \overline{\mathbf{K}} = (\mathbf{C}\overline{\mathbf{B}}, \mathbf{C}\overline{\mathbf{A}}\overline{\mathbf{B}}, \dots, \mathbf{C}\overline{\mathbf{A}}^{L-1}\overline{\mathbf{B}})$$

이를 FFT로 $O(L \log L)$에 계산할 수 있어 학습 효율이 높다.

## Mamba 이전의 SSM 계보

### Structured SSM (S4)

Gu et al. (ICLR 2022): HiPPO 행렬을 $\mathbf{A}$로 사용해 장기 의존성(long-range dependency)을 효과적으로 포착. $\mathbf{A}$를 Diagonal Plus Low-Rank (DPLR)로 구조화하여 $O(N + L)$ 복잡도 달성.

### H3 (Hungry Hungry Hippos)

Dao, Fu et al. (2023): S4에 gating mechanism을 추가하고 SSM을 attention 대체로 사용. GPT-quality 아키텍처를 subquadratic으로 구현하려는 첫 진지한 시도.

### S4 및 H3의 근본적 한계

**파라미터가 입력에 독립적**이다: $\mathbf{A}, \mathbf{B}, \mathbf{C}, \Delta$가 학습 가능하지만, 시퀀스의 각 토큰에 대해 **동일한 값**이다. 이는 모델이 "선택적으로" 정보를 무시하거나 강조할 수 없음을 의미한다:

```python
# Traditional SSM: fixed parameters
B = nn.Parameter(torch.randn(N))    # Learned but input-independent
C = nn.Parameter(torch.randn(N))    # Learned but input-independent
Δ = nn.Parameter(torch.randn(D))    # Learned but input-independent
```

결과적으로 Copying, Induction Heads 같은 **content-aware reasoning**이 필요한 태스크에서 Transformer에 크게 뒤처졌다.

## Selectivity — Mamba의 핵심 혁신

Mamba는 SSM 파라미터를 **입력의 함수**로 만드는 **선택 메커니즘**을 도입했다:

```python
# Mamba: input-dependent parameters
B = nn.Linear(D, N)(x)   # B varies depending on x — "what to store"
C = nn.Linear(D, N)(x)   # C varies depending on x — "what to output"
Δ = nn.Linear(D, D)(x)   # Step size varies — "how much to focus"
```

### 선택 메커니즘의 의미

| 구성요소 | 선택적 의미 |
|:---|:---|
| $\mathbf{B}(x)$ | 입력 $x$의 어떤 정보를 **상태에 저장**할지 결정 |
| $\mathbf{C}(x)$ | 상태의 어떤 정보를 **출력**할지 결정 |
| $\Delta(x)$ | 현재 토큰에 **얼마나 집중**할지 결정 (copying에 핵심적) |

"Selective SSM"을 저자들은 **S6**라고도 부른다: **S4** + **S**election mechanism + **S**can-based computation.

## Hardware-Aware 알고리즘

선택 메커니즘은 SSM의 convolutional form을 깨뜨려 기존의 효율적 학습이 불가능해진다. Mamba는 이를 해결하기 위해 **hardware-aware parallel scan 알고리즘**을 고안했다.

### Parallel Scan (Prefix Sum)

SSM의 recurrent form $h_k = \overline{\mathbf{A}}_k h_{k-1} + \overline{\mathbf{B}}_k x_k$ 은 $\overline{\mathbf{A}}_k$가 입력 종속적이어도 prefix sum 알고리즘으로 **병렬화 가능**하다. Mamba는 이를 GPU의 SRAM(shared memory)에서 효율적으로 실행하도록 구현했다.

### Kernel Fusion

- 연산을 GPU의 **SRAM**(on-chip, ~20TB/s)에서 수행하고, **HBM**(off-chip, ~1.5TB/s) 접근을 최소화
- SSM scan, discretization, activation function을 하나의 CUDA kernel로 융합
- 이는 Tri Dao의 FlashAttention과 동일한 철학: memory-bound 연산을 compute-bound로 전환

### FlashAttention과의 유사성

| 특성 | FlashAttention | Mamba Scan |
|:---|:---|:---|
| 병목 | Memory I/O (HBM) | Memory I/O (HBM) |
| 해결 | Tiling + SRAM 재계산 | Parallel scan + SRAM kernel fusion |
| 복잡도 | $O(n^2)$ 연산, $O(n)$ I/O | $O(n \cdot N \cdot D)$ 연산, $O(n)$ I/O |
| 저자 | Tri Dao | Tri Dao + Albert Gu |

## Mamba 아키텍처 상세

### Mamba Block

각 Mamba block은 다음과 같이 구성된다:

1. **Input Projection**: $x \to$ Linear $\to$ (두 갈래로 분기)
2. **Branch 1** (Main): 1D Convolution ($d_{\text{conv}}=4$) $\to$ SiLU $\to$ Selective SSM
3. **Branch 2** (Gate): SiLU activation
4. **Output**: Branch 1 $\odot$ Branch 2 (element-wise gating)
5. **Output Projection**: Linear $\to$ residual connection

### 주요 하이퍼파라미터

| 파라미터 | 의미 | 기본값 |
|:---|:---|:---|
| $d_{\text{model}}$ | 은닉 차원 | 768 (130M) ~ 5120 (2.8B) |
| $d_{\text{state}}$ | SSM state 차원 ($N$) | 16 |
| $d_{\text{conv}}$ | Conv1D kernel 크기 | 4 |
| expand | Inner dimension 확장 배율 | 2 |

파라미터 수는 대략 $3 \times \text{expand} \times d_{\text{model}}^2$ 이다.

## 성능 비교: Mamba vs Transformer

### 언어 모델링 (Perplexity ↓)

| 모델 | 파라미터 | Pile PPL | Lambada PPL |
|:---|:---|:---|:---|
| GPT-Neo | 125M | — | — |
| Pythia | 160M | 17.9 | 54.1 |
| **Mamba** | **130M** | **11.0** | **29.2** |
| Pythia | 410M | 13.1 | 28.9 |
| **Mamba** | **370M** | **9.2** | **14.4** |
| Pythia | 1.4B | 10.0 | 14.6 |
| **Mamba** | **1.4B** | **8.2** | **9.6** |
| Pythia | 2.8B | 8.9 | 10.9 |
| **Mamba** | **2.8B** | **7.5** | **8.2** |

### 제로샷 벤치마크 (Mamba-2.8B vs Pythia-2.8B)

| 벤치마크 | Pythia-2.8B | Mamba-2.8B | 차이 |
|:---|:---|:---|:---|
| HellaSwag | 60.5 | **66.9** | +6.4 |
| PIQA | 74.5 | **77.0** | +2.5 |
| WinoGrande | 58.2 | **63.5** | +5.3 |
| ARC-Easy | 64.3 | **69.5** | +5.2 |
| ARC-Challenge | 32.1 | **36.8** | +4.7 |
| Lambada (OpenAI) | 51.6 | **64.1** | +12.5 |

### 추론 속도

- 동일 사이즈 Transformer 대비 **추론 처리량 5배**
- 시퀀스 길이에 대해 **선형 확장** (Transformer는 제곱)
- Million-length sequence에서도 실용적 처리 가능

## Mamba-2 (2024)

Albert Gu & Tri Dao가 2024년 발표한 Mamba-2는 SSM과 linear attention 사이의 **이론적 연결**을 규명했다:

- **Structured State Space Duality (SSD)**: SSM과 linear attention이 structured matrix의 semi-separable form으로 통합됨
- **Tensor core 최적화**: Matrix multiplication으로 재구성하여 GPU tensor core 활용도 극대화
- **Mamba-1 대비 2-8배 빠른 학습** 속도
- Transformer attention의 quadratic softmax kernel을 SSM의 linear state transition으로 대체하는 수학적 등가성 제시

## Transformer와의 비교

| 특성 | Transformer | Mamba |
|:---|:---|:---|
| 복잡도 | $O(n^2)$ | $O(n)$ |
| Attention | Softmax self-attention | Selective state space |
| 장기 의존성 | Attention으로 직접 접근 | State $h_k$에 압축 저장 |
| 추론 속도 | KV cache, $O(n)$ | Recurrent, $O(1)$ per step |
| 강점 | In-context learning, 복잡한 추론 | 극단적 효율, long-range |
| 학습 병렬화 | Native (matrix mult) | Parallel scan |

## Mamba의 기계공학/물리학 적용 가능성

- **Long-sequence 시계열 예측**: 진동 신호, 센서 스트림 (수백만 time step)
- **PDE 시뮬레이션**: 시간 진행(time marching)의 autoregressive surrogate로 활용
- **Spectral bias 보완**: PINN의 multi-scale 실패를 Mamba의 장기 의존성으로 완화 가능성 (연구 초기)
- **Digital twin 실시간 추론**: Edge device에서의 추론 처리량 이점

## 관련 개념

- [[transformer]] — Mamba의 주 비교 대상
- [[linear-rnn-theory]] — 선형 RNN/SSM 이론 기초
- [[state-space-model-emergence-ergodicity]] — SSM의 에르고딕 이론 관점 분석
- [[lstm-forget-gate]] — 게이트 메커니즘의 선조 (LSTM의 forget gate)
- [[gated-recurrent-units]] — GRU — 또 다른 gated recurrent 아키텍처
- [[memory-caching-rnn]] — Memory-caching RNN (Mamba 이전의 효율적 RNN 시도)
- [[effective-theory-transformers]] — Transformer의 effective theory 관점 분석
