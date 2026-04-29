---
title: DenseNet (Densely Connected Convolutional Networks)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, benchmark, paper]
sources: [raw/papers/1608.06993v5.md]
confidence: high
---

# DenseNet (Densely Connected Convolutional Networks)

## 개요

**DenseNet**은 Gao Huang, Zhuang Liu, [[laurens-van-der-maaten|Laurens van der Maaten]], Kilian Q. Weinberger가 2016년 제안한 CNN 아키텍처로, **모든 앞선 레이어와 모든 뒤 레이어를 직접 연결**하는 밀집 연결(dense connectivity) 패턴을 도입했다^[raw/papers/1608.06993v5.md].

$L$개 레이어가 $L$개 연결인 전통적 구조와 달리, DenseNet은 $\frac{L(L+1)}{2}$개의 직접 연결을 가짐.

## 핵심 아이디어

### Dense Connectivity
$$\mathbf{x}_\ell = H_\ell([\mathbf{x}_0, \mathbf{x}_1, \dots, \mathbf{x}_{\ell-1}])$$

- $[\dots]$는 **concatenation** (ResNet의 summation과의 핵심 차이)
- 각 레이어는 모든 이전 레이어의 feature-map에 접근
- 정보 흐름 극대화, gradient 소멸 문제 완화

### Growth Rate $k$
- 각 레이어는 $k$개의 feature-map만 추가 (예: $k=12$)
- 좁은(narrow) 레이어로도 충분 — feature reuse가 핵심
- 네트워크의 "집단 지식(collective knowledge)" 개념

### 구성 요소
- **Dense Block:** 동일 feature-map 크기 내에서 dense connection
- **Transition Layer:** 1×1 Conv + 2×2 Average Pooling (downsampling)
- **Bottleneck (DenseNet-B):** 1×1 Conv → 3×3 Conv (4k feature-map 생성)
- **Compression (DenseNet-C):** transition에서 $\theta=0.5$로 feature-map 축소
- **DenseNet-BC:** Bottleneck + Compression 결합

## 성능

| 설정 | C10+ 에러 | 파라미터 |
|------|----------|---------|
| ResNet-1001 (pre-act) | 4.62% | 10.2M |
| DenseNet-BC (k=12, L=100) | 4.51% | **0.8M** |
| DenseNet-BC (k=40, L=190) | **3.46%** | 25.6M |

- ResNet 대비 **약 1/3 파라미터**로 동등 성능 달성
- Feature reuse 덕분에 파라미터 효율성 극대화
- Implicit deep supervision 효과

## ResNet vs DenseNet

| 특성 | ResNet | DenseNet |
|------|--------|----------|
| 결합 방식 | Summation | Concatenation |
| Feature reuse | 제한적 | 극대화 |
| 파라미터 효율 | 낮음 | 매우 높음 |
| 그래디언트 흐름 | Skip connection | Direct path |

## References
- G. Huang, Z. Liu, L. van der Maaten, K.Q. Weinberger. "Densely Connected Convolutional Networks", *CVPR 2017*
- [[residual-networks]] — DenseNet의 직접적 전신 및 비교 대상
- [[yolo-object-detection]] — CNN 기반 detection의 다른 접근
- [[resnet-vs-densenet]]
