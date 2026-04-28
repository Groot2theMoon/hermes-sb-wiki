---
title: ResNet vs DenseNet — Skip Connection 비교
created: 2026-04-28
updated: 2026-04-28
type: comparison
tags: [comparison, neural-network, model, benchmark]
sources: [raw/papers/1512.03385v1.md, raw/papers/1608.06993v5.md]
---

# ResNet vs DenseNet — Skip Connection 아키텍처 비교

**ResNet (Deep Residual Learning, 2015)**과 **DenseNet (Densely Connected Convolutional Networks, 2016)** 둘 다 **skip connection (지름길 연결)** 을 통해 심층 신경망의 학습을 가능하게 하지만, 연결 방식이 근본적으로 다르다.

## 비교 표

| 차원 | ResNet | DenseNet |
|------|--------|----------|
| **연결 방식** | **덧셈(addition):** $x_{l+1} = x_l + \mathcal{F}(x_l)$ | **연결(concatenation):** $x_{l+1} = [x_l, \mathcal{F}(x_l)]$ |
| **정보 흐름** | Gradient가 identity path를 통해 직접 역전파 | 각 층이 앞선 **모든** 층의 feature map 수신 |
| **파라미터 효율성** | 적은 연결, 많은 채널 | 적은 채널 (growth rate $k=12$), 많은 연결 |
| **파라미터 수** | ResNet-50: 25.6M | DenseNet-201: 20.0M |
| **Feature reuse** | 암시적 (residual만 학습) | **명시적** — 모든 앞선 feature에 직접 접근 |
| **계산량** | ResNet-50: 3.8 GFLOPs | DenseNet-201: 4.3 GFLOPs (더 효율적일 수 있음) |
| **메모리 사용량** | 낮음 (feature map을 additive로 결합) | 높음 (모든 앞선 feature map을 메모리에 유지) |
| **Gradient 흐름** | identity shortcut으로 소멸 방지 | 각 층이 직접 loss에 연결 → gradient 소멸 거의 없음 |
| **압축/축소 (Transition)** | 없음 (단순히 layer stack) | 있음 (1×1 Conv + 2×2 AvgPool로 압축) |

## 아키텍처 비교

### ResNet (Skip via Addition)
$$\mathbf{y} = \mathcal{F}(\mathbf{x}, \{W_i\}) + \mathbf{x}$$
- **Identity shortcut connection** (추가 파라미터 0, 연산량 거의 없음)
- 최적이 identity mapping일 경우 $\mathcal{F} \to 0$ 으로 쉽게 수렴
- Bottleneck 블록 (50/101/152-layer): 1×1 → 3×3 → 1×1 Conv

### DenseNet (Skip via Concatenation)
$$x_{l+1} = H_l([x_0, x_1, \dots, x_l])$$
- 각 $L$ 층이 $\frac{L(L+1)}{2}$ 개의 직접 연결 (dense connectivity)
- **Dense block** + **Transition layer** 구조
- **Growth rate $k$** (예: $k=12$): 각 층이 12개의 새 feature map만 추가
- 매우 좁은 층(narrow layers)으로도 깊은 네트워크 가능

## 정보 흐름 측면

### Gradient 소멸 관점
| 특성 | ResNet | DenseNet |
|------|--------|----------|
| Gradient path 수 | $L$ (각 layer 하나의 shortcut) | $2^L$ (이론적, 모든 조합 경로) |
| Gradient 소멸 위험 | 낮음 (하나의 identity path 존재) | 거의 없음 (각 층이 loss에 직접 연결) |
| 깊이 확장 한계 | 수천 층까지 확장 가능 | 수백 층에서 saturated (feature map 폭발) |

### Feature reuse 관점
| 특성 | ResNet | DenseNet |
|------|--------|----------|
| Feature reuse | 암시적 (residual만 학습) | **명시적** (모든 feature에 직접 접근) |
| 중복 정보 처리 | 각 층이 중복 정보 학습 가능 | 자연적 압축 (더 적은 채널로도 충분) |
| 파라미터 효율성 | 중간 (25.6M @ ResNet-50) | 높음 (20.0M @ DenseNet-201) |

## ImageNet 성능 비교

| 모델 | Top-1 error | Top-5 error | 파라미터 수 |
|------|------------|------------|-----------|
| ResNet-50 | 24.7% | 7.8% | 25.6M |
| ResNet-101 | 23.6% | 7.1% | 44.5M |
| ResNet-152 | 23.0% | 6.7% | 60.2M |
| DenseNet-121 | 25.0% | 7.9% | 8.0M |
| DenseNet-169 | 23.8% | 6.9% | 14.1M |
| DenseNet-201 | 22.6% | 6.3% | 20.0M |
| DenseNet-264 | **22.2%** | **6.1%** | 33.2M |

→ DenseNet이 **더 적은 파라미터로 더 나은 성능**을 달성했다.

## 어느 것을 선택할까?

### ResNet 선택
- 계산 자원이 제한적 (메모리)
- 수천 층의 극도로 깊은 네트워크 필요
- 기존 ResNet 기반 pretrained model로 전이 학습

### DenseNet 선택
- 파라미터 효율성이 중요 (적은 파라미터로 우수 성능)
- Feature reuse가 유리한 task
- Gradient 소멸이 심각한 극도로 깊은 네트워크
- 압축(compression) 설정으로 추가 효율성

## 관련 페이지

- [[residual-networks]] — ResNet 상세
- [[densenet]] — DenseNet 상세
- [[lenet-5]] — CNN 진화의 시작점
- [[lottery-ticket-hypothesis]] — 심층망의 중복성과 가지치기
- [[transformer]] — Skip connection이 활용된 현대 아키텍처