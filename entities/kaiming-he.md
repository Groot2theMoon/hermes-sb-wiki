---
title: Kaiming He
created: 2026-04-28
updated: 2026-04-28
type: entity
tags: [person, neural-network, computer-vision, model]
sources: [raw/papers/1512.03385v1.md]
---

# Kaiming He (何恺明)

**ResNet 창시자.** Microsoft Research (현재)에서 활동하는 세계적 컴퓨터 비전 및 딥러닝 연구자. ILSVRC 2015에서 **잔차 학습(Residual Learning)**으로 전 분야 1위를 석권했다.

## 주요 기여

### ResNet (Deep Residual Learning)
He, Zhang, Ren, Sun (Microsoft Research, 2015)이 제안한 [[residual-networks]]는 **skip connection (identity shortcut connection)**을 도입하여 수백~수천 층의 심층 신경망 학습을 가능하게 했다. ILSVRC 2015 classification, detection, localization, COCO detection/segmentation 전 분야 1위.

### Mask R-CNN
Instance segmentation의 표준이 된 Mask R-CNN 개발.

### 기타
- **He Initialization (Kaiming Init):** ReLU 신경망을 위한 초기화 방법 (PReLU 논문에서 제안)
- **MoCo (Momentum Contrast):** Self-supervised learning에서 contrastive learning 방법론
- **ImageNet 우수 성과:** ResNet-152, ImageNet top-5 error 4.49% (인간 수준)

## 관계

- [[residual-networks]] — He의 대표 업적
- [[densenet]] — ResNet의 아이디어를 확장한 아키텍처
- [[lenet-5]] — CNN의 원형 (LeNet → ResNet 진화 관계)
- [[lottery-ticket-hypothesis]] — ResNet에서 발견된 가지치기 현상과 연결