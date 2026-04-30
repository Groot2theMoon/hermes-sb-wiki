---
title: "LipKernel — Lipschitz-Bounded CNNs via Dissipative Layers (2-D Roesser Parameterization)"
created: 2026-05-02
updated: 2026-05-02
type: concept
tags: [lipschitz, dissipativity, cnn, 2d-systems, roesser-model, lmi, lipkernel]
sources:
  - raw/papers/lipkernel-dissipative-cnn.md
confidence: high
---

# LipKernel — Lipschitz-Bounded CNNs via Dissipative Layers

> **Pauli, P., Wang, R., Manchester, I. R. & Allgöwer, F. (2024).** "LipKernel: Lipschitz-Bounded Convolutional Neural Networks via Dissipative Layers." *Automatica* 188 (2026): 112959. arXiv:2410.22258.

## 개요

LipKernel은 **2-D Roesser-type state space model**을 사용하여 convolution kernel을 직접 parameterize하는 방법론. 각 layer가 LMI (Linear Matrix Inequality) 조건을 만족하도록 설계하여 **dissipativity**를 보장하고, 이를 통해 전체 NN의 Lipschitz bound를 보장. 기존 Fourier domain 기반 방법보다 **runtime이 orders of magnitude 빠름**.

## 핵심 기여

1. **Convolution kernel의 Roesser state-space parameterization** — kernel entries를 직접 parameterize (Fourier domain 불필요)
2. **Dissipativity 기반 LMI** — 각 layer가 prescribed supply rate에 대해 dissipative하도록 강제
3. **Layer-wise Lipschitz bound 누적** — 전체 네트워크의 ℓ₂ Lipschitz bound 보장
4. **광범위한 layer 타입 지원** — 1D/2D conv, max/avg pooling, strided/dilated conv, zero padding 모두 포함

## 수학적 구조

### 2-D Roesser Model

Convolution kernel $K$를 2-D state space 모델로 표현:

```
[ x^h(i+1, j) ]   [ A₁₁  A₁₂ ] [ x^h(i, j) ]   [ B₁ ]
[ x^v(i, j+1) ] = [ A₂₁  A₂₂ ] [ x^v(i, j) ] + [ B₂ ] · u(i, j)
```

출력: $y(i,j) = C · [x^h(i,j); x^v(i,j)] + D · u(i,j)$

### Dissipativity LMI

각 layer가 $(\rho, Q, S, R)$-dissipative하도록:

```
∃ P > 0, s.t. LMI constraints → each layer's Lipschitz constant ≤ ρ
```

여기서 $Q$와 $R$을 통해 generalized Lipschitz bound (ℓ₂, incremental passivity 등) 표현 가능.

## 계산 효율성

| 방법 | 학습 시간 | 추론 시간 | 추가 메모리 |
|------|:---------:|:---------:|:----------:|
| Fourier (Orthogonal/Sandwich) | 느림 (FFT) | 느림 (FFT) | 높음 |
| **LipKernel** | **빠름 (O(n))** | **없음 (표준 conv)** | **없음** |
| AOL | 빠름 (power iter.) | 없음 | 없음 |

→ 추론 시 표준 convolution 연산만 필요 — **Fourier 변환/역변환 불필요**

## 실험 결과 (CIFAR-10, 2C2F Architecture)

| Method | Cert. UB | Emp. LB | Test Acc. | Cert. Robust (ε=36/255) |
|--------|:-------:|:-------:|:--------:|:----------------------:|
| Vanilla | — | 221.7 | 99.0% | 0.0% |
| Orthogonal | 1 | 0.960 | 94.6% | 92.9% |
| Sandwich | 1 | 0.914 | 97.3% | 91.0% |
| **LipKernel** | **1** | **0.952** | **96.6%** | **92.9%** |
| **LipKernel** | **2** | **1.703** | **98.2%** | **96.3%** |
| **LipKernel** | **4** | **3.110** | **98.9%** | **97.4%** |

→ LipKernel은 더 높은 upper bound (ρ=4)에서도 tight한 empirical lower bound 유지, Vanilla 대비 약간 낮은 clean accuracy로 **훨씬 높은 certified robustness** 달성.

## RIGOR 관련성

LipKernel의 **dissipativity + LMI** 접근법은 RIGOR v2.3의 [[shima-contractivity-lure|Lur'e system LMI contractivity 검증]]과 직접적 방법론적 평행:
- LipKernel: 각 레이어의 dissipativity LMI → Lipschitz bound
- RIGOR A+NN: Lur'e system LMI → contractivity 보장
- 두 접근법 모두 **LMI 기반 필요충분 조건** 사용
- LipKernel의 2-D Roesser 모델 → CNN 구조의 A+NN 안정성 분석으로 확장 가능?

## 다른 Lipschitz 방법과의 관계

| 축 | AOL | LBDN | LipKernel |
|------|-----|------|-----------|
| 수학 기반 | Spectral norm rescaling | SDP 직접 파라미터화 | 2-D Roesser LMI |
| Conv 지원 | Channel-wise scaling | Sandwich layer | **Kernel 직접 (가장 자연스러움)** |
| 계산 overhead | 미미 | 없음 | 없음 |
| Lipschitz bound | ℓ₂ | ℓ₂ (SDP) | **일반화 (Q,R 선택)** |

## Authors
- [[patricia-pauli]]
- [[ruigang-wang]]
- [[ian-r-manchester]]
- [[frank-allgoewer]]

## Related
- [[aol-almost-orthogonal-layers]] — AOL: spectral rescaling 기반
- [[lbdn-lipschitz-bounded-networks]] — LBDN: SDP Lipschitz direct param.
- [[ren-recurrent-equilibrium-networks]] — REN: contracting + IQC
- [[shima-contractivity-lure]] — Lur'e contractivity LMI
- [[1-lipschitz-layers-comparison]] — 1-Lipschitz 방법 비교
