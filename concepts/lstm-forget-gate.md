---
title: "LSTM Forget Gate — Gers, Schmidhuber & Cummins (2000)"
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [classic-ai, neural-network, sequence-modeling, landmark-paper]
sources: [raw/papers/gers2000.md]
confidence: high
---

# LSTM Forget Gate — "Learning to Forget"

## 개요

Gers, Schmidhuber & Cummins (2000), *Neural Computation*, 12(10), 2451–2471. **~10,000회 인용.**

원조 LSTM(Hochreiter & Schmidhuber, 1997)은 **vanishing gradient 문제**를 해결했지만, **연속적 입력 스트림(continual input stream)**에서 내부 상태가 무한히 증가하여 붕괴되는 문제가 있었다. Forget gate는 **셀이 스스로 리셋 시점을 학습**하게 하여 이 문제를 해결했다.

## 문제: Continual Prediction

### 원조 LSTM의 한계

- **CEC(constant error carousel)**: gradient flow를 일정하게 유지 — 장기 의존성 학습 가능
- **문제점:** 입력 스트림이 연속적이고 경계가 명확하지 않으면, CEC의 셀 상태가 단조 증가
- **예시:** 문장 끝(. )에서 이전 문맥을 리셋해야 하지만, LSTM은 리셋 시점을 알 수 없음
- **결과:** 일정 시간 후 네트워크 붕괴

### Forget Gate 해결책

LSTM cell에 **적응적(forget) 게이트** 추가:

$$f_t = \sigma(W_f \cdot [h_{t-1}, x_t] + b_f)$$

**업데이트된 cell state:**

$$C_t = f_t \odot C_{t-1} + i_t \odot \tilde{C}_t$$

| 게이트 | 원조 LSTM (1997) | Forget Gate LSTM (2000) |
|:------|:----------------|:------------------------|
| Input gate $i_t$ | ✅ | ✅ |
| Output gate $o_t$ | ✅ | ✅ |
| **Forget gate $f_t$** | ❌ (고정=1.0) | ✅ (학습 가능) |
| Cell state | $C_t = C_{t-1} + i_t \odot \tilde{C}_t$ | $C_t = f_t \odot C_{t-1} + i_t \odot \tilde{C}_t$ |

## 핵심 통찰

- Forgetting은 RNN에서 **버그가 아니라 feature**여야 함
- Forget gate가 $f_t \to 0$을 출력하면 이전 컨텍스트 완전히 삭제 → 새 시퀀스 시작점 학습
- Forget gate가 $f_t \to 1$을 출력하면 원조 LSTM과 동일 (정보 보존)
- **리셋이 필요 없는** 연속 문제에서도 forget gate는 $f_t \approx 1$로 수렴하므로 성능 저하 없음

### LSTM 셀 전체 구조 (forget gate 포함)

$$i_t = \sigma(W_i \cdot [h_{t-1}, x_t] + b_i)$$
$$f_t = \sigma(W_f \cdot [h_{t-1}, x_t] + b_f)$$
$$o_t = \sigma(W_o \cdot [h_{t-1}, x_t] + b_o)$$
$$\tilde{C}_t = \tanh(W_C \cdot [h_{t-1}, x_t] + b_C)$$
$$C_t = f_t \odot C_{t-1} + i_t \odot \tilde{C}_t$$
$$h_t = o_t \odot \tanh(C_t)$$

## 결과 / 성능

| 문제 | Standard LSTM | Forget Gate LSTM |
|:----|:-------------:|:----------------:|
| Embedded Reber Grammar (연속형) | 실패 | ✅ 성공 |
| 2-sequence classification | 실패 | ✅ 성공 |
| Latch problem (1000+ steps) | ✅ 성공 | ✅ 성공 (동일) |
| Language modeling (Penn Treebank) | — | 성능 향상 |

## 역사적 의의

- Forget gate는 오늘날 모든 LSTM 구현의 **표준 구성 요소**
- GRU(Gated Recurrent Unit, Cho 2014)는 forget gate와 input gate를 **update gate**로 통합 — 파라미터 33% 감소
- Transformer/ViT의 attention 메커니즘은 **softmax self-attention**으로 forget gate의 역할(컨텍스트 선택적 유지/폐기)을 더 일반화된 방식으로 수행

## References
- Gers, F. A., Schmidhuber, J., & Cummins, F. (2000). "Learning to forget: Continual prediction with LSTM." *Neural Computation*, 12(10), 2451–2471.
- [[felix-gers]] — Forget gate 공동 창시자
- [[juergen-schmidhuber]] — LSTM/GRU 창시자
- [[sepp-hochreiter]] — 원조 LSTM 창시자
- [[gated-recurrent-units]] — GRU/LSTM 상세 비교 ([[lstm-vs-gru]] 참조)
