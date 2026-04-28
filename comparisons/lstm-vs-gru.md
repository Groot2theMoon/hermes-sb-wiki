---
title: LSTM vs GRU — Gated RNN 비교
created: 2026-04-28
updated: 2026-04-28
type: comparison
tags: [comparison, neural-network, model]
sources: [raw/papers/1412.3555v1.md, raw/papers/gers2000.md]
---

# LSTM vs GRU — 게이트 RNN 비교

**LSTM (Long Short-Term Memory, 1997)**과 **GRU (Gated Recurrent Unit, 2014)**는 vanishing gradient 문제를 해결하기 위한 게이트 기반 RNN 아키텍처이다. Chung et al. (2014)은 두 유닛과 전통적인 tanh RNN을 체계적으로 비교했다.

## 비교 표

| 차원 | LSTM | GRU |
|------|------|-----|
| **제안 시기** | Hochreater & Schmidhuber (1997) | Cho et al. / Bahdanau et al. (2014) |
| **파라미터 수** | 더 많음 (약 4개의 gate 가중치 행렬) | 더 적음 (약 3개) |
| **게이트 수** | 3개 (input, forget, output) | 2개 (update, reset) |
| **메모리 구조** | Cell state $c_t$ + Hidden state $h_t$ | Hidden state $h_t$ (단일) |
| **메모리 읽기/쓰기** | Input gate로 쓰기, forget gate로 지우기, output gate로 읽기 | Update gate가 메모리 유지/갱신을 **선형 보간** |
| **장기 의존성 캡처** | Forget gate가 cell state를 보존 — 가장 긴 의존성 가능 | 보다 간단한 구조로 때로 LSTM보다 약함 |
| **계산 비용** | 높음 (4개 gate 연산) | 낮음 (3개 gate, 셀 상태 없음) |
| **수렴 속도 (empirical)** | 때로 느림 | 때로 빠름 (단순성 때문) |

## 아키텍처 비교

### LSTM 업데이트
$$c_t = f_t \odot c_{t-1} + i_t \odot \tilde{c}_t \quad \text{(별도의 cell state)}$$
$$h_t = o_t \odot \tanh(c_t) \quad \text{(output gate로 filtered)}$$

- Cell state는 forget gate를 통해 정보를 보존하는 **고속도로**
- Hidden state는 output gate에 의해 **제어된** 정보 노출

### GRU 업데이트
$$h_t = (1 - z_t) \odot h_{t-1} + z_t \odot \tilde{h}_t \quad \text{(직접 선형 보간)}$$

- Cell state와 hidden state가 **통합**됨
- Update gate가 "얼마나 새 정보를 받아들일지"를 직접 결정
- Reset gate는 얼마나 과거 정보를 무시할지 결정

## 언제 무엇을 선택할까?

### LSTM 선택
- 매우 긴 의존성 (100+ steps)이 중요한 문제
- 별도의 장기 메모리가 필요 (forget gate로 cell state 제어)
- 성능보다 계산량이 덜 중요
- 시간적 구조가 예측 불가능한 문제

### GRU 선택
- 계산 자원이 제한적
- 수렴 속도가 중요
- 데이터셋 크기가 작음 (파라미터 수가 적어 과적합 위험 낮음)
- LSTM과 거의 동등한 성능으로 더 빠른 학습 가능

## 정량적 비교 (Chung et al., 2014)

| Task | Tanh RNN | LSTM | GRU |
|------|----------|------|-----|
| Music modeling (polyphonic) | — | SOTA급 | SOTA급 (LSTM과 유사) |
| Speech signal modeling | — | SOTA급 | SOTA급 (LSTM과 유사) |
| 일반적 NLP | 나쁨 | 우수 | 우수 (종종 LSTM 동등) |

대부분의 task에서 GRU는 LSTM과 **거의 동등한 성능**을 보이면서 **계산량이 더 적다**. 이는 GRU가 LSTM보다 널리 채택된 이유 중 하나이다.

## 역사적 영향

- LSTM + **Forget gate** (Gers & Schmidhuber, 2000)가 현재 LSTM 구현의 표준 ([[lstm-forget-gate]])
- GRU는 **Attention 기반 seq2seq** (Bahdanau et al., 2014)에서 처음 등장
- 2017년 Transformer 등장 이후, 두 아키텍처 모두 점차 attention 기반 모델로 대체됨
- 하지만 **edge, mobile, time-series forecasting** 영역에서는 여전히 LSTM/GRU가 사용됨

## 관련 페이지

- [[gated-recurrent-units]] — GRU & LSTM 개요
- [[lstm-forget-gate]] — LSTM Forget Gate 상세
- [[transformer]] — RNN 이후의 sequence modeling 패러다임
- [[mamba]] — 현대적 SSM 기반 sequence model