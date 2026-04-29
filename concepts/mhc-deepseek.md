---
title: [[deepseek|DeepSeek]] mHC — Manifold-Constrained Hyper-Connections
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [model, architecture, training, paper]
sources: [raw/papers/mhc-deepseek.md]
confidence: medium
---

# DeepSeek mHC: Manifold-Constrained Hyper-Connections

## 개요

**DeepSeek**가 제안한 **mHC (manifold-constrained Hyper-Connections)**는 기존 residual connection을 일반화한 **hyper-connection** 아키텍처에 **다양체 제약(manifold constraint)** 을 추가한 변종이다^[raw/papers/mhc-deepseek.md].

## 배경: Residual Connection의 한계

ResNet 이후 모든 심층 신경망은 $y = x + F(x)$ 형태의 residual connection을 사용한다. 이는 매우 단순한 연결 패턴으로, 층 간 정보 흐름이 **선형 스킵 연결 하나**로 제한된다.

## Hyper-Connection (HC)

Hyper-connection은 residual을 확장하여 **다양한 연결 행렬**을 학습 가능하게 한다:

$$y = W_{skip} \cdot x + W_{main} \cdot F(x)$$

여기서 $W_{skip}$과 $W_{main}$은 학습 가능한 가중치 행렬이다. 이는 정보 흐름을 **더 풍부하게 제어**할 수 있게 한다.

## Manifold Constraint (mHC)

mHC는 **hyper-connection의 가중치가 저차원 다양체(low-dimensional manifold)에 존재**하도록 제약한다. 즉,

$$\text{rank}([W_{skip}, W_{main}]) \ll \text{full rank}$$

| 특징 | Standard ResNet | HC | mHC |
|:---|:--------------:|:--:|:--:|
| 스킵 연결 | $I$ (identity) | 학습 가능 $W_{skip}$ | 학습 가능 (저랭크) |
| 메인 연결 | $I$ | 학습 가능 $W_{main}$ | 학습 가능 (저랭크) |
| 파라미터 수 | 없음 | $2d^2$ (많음) | $O(d \cdot r)$ (적음) |
| 표현력 | 제한적 | 높음 | 높음 + 효율적 |

## 융합 도메인 연결

- [[transformer]]의 attention head 연결 구조와 비교
- [[residual-networks]], [[densenet]] 계열의 정보 흐름 최적화 발전
- DMN의 binary tree 아키텍처에서 층 간 연결 최적화에 참고 가능

## References
- DeepSeek. Manifold-Constrained Hyper-Connections. Technical Report.
- [[residual-networks]]
- [[densenet]]
