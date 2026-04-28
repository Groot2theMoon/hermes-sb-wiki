---
title: Gated Recurrent Units (GRU & LSTM)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [neural-network, model, training, comparison, paper]
sources: [raw/papers/1412.3555v1.md]
confidence: high
---

# Gated Recurrent Units (GRU & LSTM)

## 개요

**Gated Recurrent Units**는 vanishing gradient 문제를 해결하기 위해 설계된 RNN 아키텍처로, LSTM(Long Short-Term Memory, 1997)과 GRU(Gated Recurrent Unit, 2014)가 대표적이다. Chung et al. (2014)은 이들 게이트 유닛과 전통적인 tanh 유닛을 음악 모델링 및 음성 신호 모델링에서 체계적으로 비교 평가했다^[raw/papers/1412.3555v1.md].

## Vanishing Gradient 문제

전통적 RNN: $h_t = g(Wx_t + Uh_{t-1})$ — 시간이 지날수록 그래디언트가 지수적으로 소멸 또는 폭발하여 장기 의존성 학습이 근본적으로 어려움 (Bengio et al., 1994).

두 게이트 유닛의 공통 해결책: **가법적 업데이트(additive update)** — 기존 상태를 보존하고 새 정보를 덧붙임으로써 그래디언트가 소멸하지 않는 shortcut path 생성

## Long Short-Term Memory (LSTM)

### 구성 요소 (Graves 2013 구현 기준)
- **Memory cell $c_t$:** 핵심 — 장기 정보 저장
- **Input gate $i_t$:** 새 메모리 추가 정도 제어
- **Forget gate $f_t$:** 기존 메모리 삭제 정도 제어
- **Output gate $o_t$:** 메모리 노출 정도 제어
- **Candidate memory $\tilde{c}_t$:** 새로운 메모리 후보

### 업데이트
$$c_t = f_t \odot c_{t-1} + i_t \odot \tilde{c}_t$$
$$h_t = o_t \odot \tanh(c_t)$$

## Gated Recurrent Unit (GRU)

### 구성 요소 (Cho et al., 2014; Bahdanau et al., 2014)
- **Update gate $z_t$:** 기존 상태 유지 vs 새 정보 반영의 선형 보간
- **Reset gate $r_t$:** 이전 상태를 얼마나 잊을지 결정
- **Candidate activation $\tilde{h}_t$:** 리셋 게이트로 조절된 새 활성화

### 업데이트
$$h_t = (1 - z_t) \odot h_{t-1} + z_t \odot \tilde{h}_t$$

### LSTM과의 차이점
| 특성 | LSTM | GRU |
|------|------|-----|
| **게이트 수** | 3 (input, forget, output) | 2 (update, reset) |
| **메모리 셀** | 별도 $c_t$ 있음 | 없음 (상태가 곧 출력) |
| **출력 제어** | Output gate로 제어 | 전노출 |
| **파라미터** | 더 많음 | 더 적음 |
| **계산량** | 더 큼 | 더 적음 |
| **표현력** | 더 풍부함 | 더 효율적 |

## 실험 결과 (Chung et al., 2014)

### Polyphonic Music (Nottingham, JSB, MuseData, Piano-midi)
- GRU-RNN이 대부분의 데이터셋에서 LSTM-RNN과 tanh-RNN보다 우수한 test 성능
- GRU가 수렴 속도(iteration 및 CPU time)에서 우위

### Speech Signal (Ubisoft datasets)
- 게이트 유닛(LSTM, GRU)이 tanh 유닛을 명확히 압도
- Ubisoft A: LSTM 우세, Ubisoft B: GRU 우세
- **데이터셋과 태스크에 따라 최적 게이트 유형이 달라짐**

## 관련 개념
- [[universal-approximation-theorem]] — 피드포워드 신경망의 표현력 이론
- [[yolo-object-detection]] — CNN 기반 접근 (YOLO는 RNN 사용 안 함)
- [[yoshua-bengio]] — Bengio 연구실에서 개발된 GRU

## References
- J. Chung, C. Gulcehre, K. Cho, Y. Bengio. "Empirical Evaluation of Gated Recurrent Neural Networks on Sequence Modeling", *NIPS 2014 Workshop on Deep Learning*
- S. Hochreiter, J. Schmidhuber. "Long Short-Term Memory", *Neural Computation*, 1997
- K. Cho et al. "On the Properties of Neural Machine Translation: Encoder-Decoder Approaches", 2014