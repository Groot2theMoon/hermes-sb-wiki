---
title: LeNet-5 — Gradient-Based Learning for Document Recognition
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [classic-ai, computer-vision, neural-network, landmark-paper]
sources: [raw/papers/lecun1998.md]
confidence: high
---

# LeNet-5 — Gradient-Based Learning for Document Recognition

## 개요

**Yann LeCun, Léon Bottou, Yoshua Bengio, Patrick Haffner (1998)** 가 제안한 LeNet-5는 **CNN (Convolutional Neural Network)의 원형**이자, **역전파(backpropagation)를 이용한 gradient-based learning**을 실제 이미지 인식에 성공적으로 적용한 최초의 사례이다^[raw/papers/lecun1998.md]. 30,000+ 인용으로 컴퓨터 비전 전체 분야의 출발점으로 평가된다.

## 아키텍처

### 7층 구조 (Conv + Pooling + FC)

| 레이어 | 유형 | 커널/크기 | 출력 | 설명 |
|--------|------|----------|------|------|
| C1 | Convolution | $5 \times 5$, 6채널 | $28 \times 28 \times 6$ | 엣지/코너 검출 |
| S2 | Average Pooling | $2 \times 2$ | $14 \times 14 \times 6$ | 서브샘플링 + 가중치 |
| C3 | Convolution | $5 \times 5$, 16채널 | $10 \times 10 \times 16$ | 고차 패턴 조합 |
| S4 | Average Pooling | $2 \times 2$ | $5 \times 5 \times 16$ | 서브샘플링 |
| C5 | Conv (FC) | $5 \times 5$ | 120 | 완전 연결 |
| F6 | Fully Connected | — | 84 | 특징 벡터 |
| Output | RBF / Softmax | — | 10 | 문자 분류 |

### 핵심 혁신

1. **Local connectivity + weight sharing**: 각 뉴런은 입력의 국소 영역만 보고, 동일 필터를 전체 이미지에 공유 → **파라미터 수 급감**
2. **Hierarchical feature extraction**: 저수준(edge) → 중수준(shape) → 고수준(객체)의 계층적 학습
3. **Gradient-based end-to-end learning**: 수작업 feature 없이 raw pixel → 최종 분류까지 한 번에 학습

### 손글씨 인식 성능

| 데이터셋 | 오류율 | 당시 SOTA 대비 |
|---------|-------|--------------|
| **MNIST** | **0.95%** (비즈니스: 0.7-0.8%) | 수작업 시스템 압도 |
| NIST SD 19 (digit) | 0.9% | 인간 수준 |

## 역사적 영향

| 연대 | 발전 |
|------|------|
| **1998** | LeNet-5 — 우편번호 자동 인식 실용화 |
| **2012** | **AlexNet** — LeNet 구조를 대규모(8층) + GPU로 확장, ImageNet 혁명 |
| **2015~** | ResNet, DenseNet, YOLO 등 현대 CNN의 **구조적 조상** |

## 융합 도메인에서의 의의

LeNet-5의 **계층적 특징 추출 + 역전파 학습** 패러다임은:
- **PINN** — PDE residual의 multi-scale feature 학습
- **FNO** — Fourier layer에서의 spectral feature 추출
- **DeepONet** — branch net에서 입력 함수의 feature encoding
- 모두 LeNet-5가 정립한 **gradient-based representation learning**의 연장선상에 있다

## References

- Y. LeCun, L. Bottou, Y. Bengio, P. Haffner. "Gradient-Based Learning Applied to Document Recognition", *Proc. IEEE*, 1998
- [[yann-lecun]] — LeNet-5 창시자
- [[yoshua-bengio]] — LeNet-5 공동 저자
- [[residual-networks]] — CNN의 현대적 발전
- [[densenet]] — CNN의 밀집 연결 발전
- [[yolo-object-detection]] — CNN 기반 객체 탐지
- [[deep-learning-nature-survey]] — 딥러닝 전체를 조망한 Nature Survey
