---
title: Lottery Ticket Hypothesis
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, training, paper, benchmark]
sources: [raw/papers/1803.03635v5.md]
confidence: high
---

# Lottery Ticket Hypothesis

## 개요

**Lottery Ticket Hypothesis**는 Jonathan Frankle & Michael Carbin (MIT, 2018)이 제안한 가설로, **밀집(dense) 신경망 내부에 처음부터 학습 가능한 부분망(subnetwork)이 존재**한다는 주장이다^[raw/papers/1803.03635v5.md]. 표준 가지치기(pruning)로 추출된 "winning ticket"은 원래 네트워크와 유사한 정확도에 도달 가능.

## 핵심 아이디어

### Winning Ticket
- 가지치기(pruning)로 찾은 부분망
- **초기 가중치를 재설정하지 않고** 그대로 유지
- 원래 네트워크와 유사한 성능에 유사한 iteration 수로 수렴
- "초기화 복권(initialization lottery)에 당첨된" 부분망

### 발견 알고리즘
1. 밀집 네트워크 학습
2. 작은 가중치 가지치기 (예: 가장 작은 20%)
3. 남은 가중치를 **원래 초기값으로 재설정**
4. 반복: 다시 학습 → 가지치기 → 재설정

## 주요 실험 결과

### MNIST (LeNet)
- 전체 네트워크의 **3.8%** 가지만으로 유사 성능 달성
- 반복적 가지치기가 단일 가지치기보다 우수

### CIFAR-10 (ConvNet)
- **13.5%** 가지로 유사 성능 달성

### 구조적 특징
- Winning ticket의 가중치 분산이 원래보다 훨씬 좁음
- 특정 초기화 분포(작은 분산)가 winning ticket 발견에 유리
- **전이 학습(transfer learning)**에서도 winning ticket 존재 확인

## 영향
- 신경망 가지치기와 초기화의 중요성 재조명
- 모델 압축, efficient AI 연구 방향에 영향
- 이후 "Rethinking the Value of Network Pruning" 등 후속 연구에 영감

## References
- J. Frankle, M. Carbin. "The Lottery Ticket Hypothesis: Finding Sparse, Trainable Neural Networks", *ICLR 2019*
- [[densenet]] — DenseNet의 feature reuse도 파라미터 효율성과 연결
- [[universal-approximation-theorem]] — 부분망의 표현력에 대한 이론적 배경