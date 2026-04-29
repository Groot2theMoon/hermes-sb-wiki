---
title: [[deepseek|DeepSeek]] Engram — Conditional Sparse Memory for LLMs
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [model, architecture, training, paper, inference]
sources: [raw/papers/Engram_paper.md]
confidence: medium
---

# DeepSeek Engram: Conditional Sparse Memory

## 개요

**DeepSeek Engram**은 LLM의 **주의력(attention)을 조건부 희소 메모리(conditional sparse memory)** 로 확장하는 아키텍처이다^[raw/papers/Engram_paper.md]. Engram은 $k$번째 이전 attention 연산의 **key-value를 메모리 뱅크에 저장**하고, 현재 토큰이 조건부 게이트를 통해 메모리를 선택적으로 읽는다.

## 핵심 아이디어

기존 Transformer의 attention은 **동일 층의 이전 토큰**만 볼 수 있다 (causal mask). Engram은 **다른 층의 이전 attention 결과**를 메모리로 저장하고, 현재 층이 필요할 때 이를 참조한다:

$$ \text{EngramMemory} = \{ (K_i, V_i) \mid i \in \text{memory\_set} \} $$
$$ \text{Output} = \text{Attention}(Q_t, \text{Concat}(K_{\text{local}}, K_{\text{engram}}), \text{Concat}(V_{\text{local}}, V_{\text{engram}})) $$

## 기존 방법과의 비교

| 방법 | 메모리 위치 | 희소성 | 조건부 |
|:---|:----------:|:-----:|:-----:|
| Standard Attention | 동일 층 | ❌ | ❌ |
| Transformer-XL | 이전 세그먼트 | ❌ | ❌ |
| Sparse Attention | 패턴 기반 (고정) | ✅ | ❌ |
| **Engram** | **모든 층** (동적) | ✅ 조건부 게이트 | ✅ |

## 잠재적 장점

- **더 긴 문맥:** 고정된 attention window를 넘어 정보에 접근
- **계산 효율성:** 조건부 게이트로 불필요한 attention 계산 생략
- **계층 간 정보 흐름:** 하위 층의 처리 결과를 상위 층이 직접 참조

## 융합 도메인 연결

- [[transformer]] 아키텍처의 **메모리 확장** 계열 — Mamba, Linear RNN과의 비교
- [[mamba]]의 SSM 기반 메모리와 Engram의 attention 기반 메모리의 구조적 차이
- [[gpt-1]]의 초기 transformer 설계와의 발전 비교

## References
- DeepSeek. Engram: Conditional Sparse Memory for LLMs. Technical Report.
- [[transformer]]
- [[mamba]]
