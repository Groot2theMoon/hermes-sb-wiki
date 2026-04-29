---
title: Deep Delta Learning — Householder Reflection as Learnable Residual Connections
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, neural-network, training, mathematics, paper]
sources: [raw/papers/Deep_Delta_Learning.md]
confidence: high
---

# Deep Delta Learning

## 개요

Zhang, Gu et al. (Princeton/UCLA)이 제안한 **Deep Delta Learning (DDL)** 은 표준 residual connection $x + F(x)$를 **Householder reflection 기반의 학습 가능한 Delta Operator**로 일반화한다.

$$\text{Output} = x + \Delta(x; W)$$

여기서 $\Delta(x; W) = W \cdot h$이고 $h$는 non-linear feature이다. 이는 identity mapping($I$), orthogonal projection, geometric reflection을 단일 파라미터화된 모듈로 통합한다.

## 핵심 아이디어

### Delta Operator

ResNet의 $x + F(x)$에서 $F(x)$가 학습 가능한 **rank-1 Householder reflection**으로 일반화:

$$\Delta = I - 2 \cdot \frac{vv^T}{\|v\|^2}$$

여기서 $v$는 학습 가능한 벡터.

**3가지 모드:**
| 모드 | 조건 | 해석 |
|------|------|------|
| Identity | $v = 0$ | 표준 ResNet skip |
| Reflection | $v \neq 0$ | 데이터를 법선 벡터에 대해 반사 |
| Projection | 특수 조건 | 부분공간으로 사영 |

### DeltaNet과의 연결 (§4.2)

DDL의 Delta Operator는 **DeltaNet (Yang et al., 2024)** 선형 어텐션의 구조와 수학적 동형 관계를 가진다. 이는 residual connection 개선이 sequence modeling ([[mamba|Mamba]]/[[linear-rnn-theory|Linear RNN]])의 attention 메커니즘과 동일한 수학적 구조를 공유함을 시사한다.

## 장점

- **표현력 확장:** identity, reflection, projection을 자동 선택
- **학습 안정성:** Householder parameterization으로 기하학적으로 well-behaved
- **범용성:** CNN, Transformer, MLP 모두에 plug-and-play
- **이론적 연결:** DeltaNet/Mamba와의 등가성으로 새로운 연구 방향 제시

## References

- [[residual-networks]] — DDL의 기반이 된 ResNet 아키텍처
- [[mamba]] — DeltaNet과의 수학적 연결
- [[linear-rnn-theory]] — Linear RNN과 Delta operator의 관계
- [[transformer]] — 대안적 아키텍처로서의 residual 개선
- [[memory-caching-rnn]] — RNN/Delta 모델의 메모리 패러다임
