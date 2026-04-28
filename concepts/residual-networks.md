---
title: Residual Networks (ResNet)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, benchmark, paper]
sources: [raw/papers/1512.03385v1.md]
confidence: high
---

# Residual Networks (ResNet)

## 개요

**ResNet (Deep Residual Learning)**은 Kaiming He, Xiangyu Zhang, Shaoqing Ren, Jian Sun (Microsoft Research)이 2015년 제안한 아키텍처로, **skip connection(지름길 연결)**을 도입하여 수백~수천 층의 심층 신경망 학습을 가능하게 했다^[raw/papers/1512.03385v1.md]. ILSVRC 2015 classification, detection, localization, COCO detection/segmentation 전 분야 1위 석권.

## 핵심 문제: Degradation Problem

층이 깊어질수록 **training error가 증가**하는 현상 발견 (overfitting이 아닌 최적화 문제):
- 20-layer plain network < 56-layer plain network (오히려 56-layer의 training error가 더 높음)
- Vanishing gradient 문제와는 별개 — Batch Normalization 적용에도 발생
- "깊은 plain net은 지수적으로 낮은 수렴 속도를 가질 것"으로 추측

## 핵심 아이디어: Residual Learning

### 기본 블록
$$\mathbf{y} = \mathcal{F}(\mathbf{x}, \{W_i\}) + \mathbf{x}$$

- $\mathcal{H}(\mathbf{x})$ 대신 **잔차(residual)** $\mathcal{F}(\mathbf{x}) = \mathcal{H}(\mathbf{x}) - \mathbf{x}$ 를 학습
- Identity shortcut connection (파라미터 추가 없음, 연산량 거의 없음)
- 최적이 identity mapping일 경우, $\mathcal{F} \to 0$ 으로 쉽게 수렴

### Bottleneck 블록 (50/101/152-layer)
1×1 → 3×3 → 1×1 Conv 구조로 계산 효율성 향상

## 아키텍처

| 모델 | 계층 수 | FLOPs | ImageNet top-5 error |
|------|---------|-------|---------------------|
| ResNet-34 | 34 | 3.6B | 7.40% |
| ResNet-50 | 50 | 3.8B | 6.71% |
| ResNet-101 | 101 | 7.6B | 6.05% |
| **ResNet-152** | 152 | 11.3B | **5.71%** (single) → **3.57%** (ensemble) |

VGG-19 (19.6B FLOPs)보다 낮은 연산량으로 더 깊고 정확한 모델 구현.

## 영향

- **ILSVRC 2015 우승** (classification: 3.57% top-5 error)
- 이후 ResNet은 사실상 CV backbone의 표준이 됨
- [[densenet]], Wide ResNet, ResNeXt 등 수많은 변형의 기반
- 배치 정규화(Batch Normalization, Ioffe & Szegedy 2015)와 함께 딥러닝 실용화에 결정적 기여

## References
- K. He, X. Zhang, S. Ren, J. Sun. "Deep Residual Learning for Image Recognition", *CVPR 2016*
- K. He et al. "Identity Mappings in Deep Residual Networks", *ECCV 2016* (pre-activation ResNet)
- [[yolo-object-detection]] — ResNet은 detection backbone으로도 활용