---
title: DiT — Scalable Diffusion Models with Transformers
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, architecture, landmark-paper, generative-model, transformer]
sources: [raw/papers/2212.09748v2.md]
confidence: high
---

# Diffusion Transformers (DiT)

## 개요

**Peebles & Xie** (UC Berkeley / NYU, 2023)는 기존 diffusion model의 backbone이었던 **U-Net을 Transformer로 대체**한 **DiT (Diffusion Transformer)**를 제안했다^[raw/papers/2212.09748v2.md]. Latent diffusion model의 latent space에서 Transformer backbone을 적용하여 ImageNet $256\times256$과 $512\times512$에서 SOTA 이미지 품질을 달성했다.

## 핵심 설계

### Transformer Backbone for Diffusion

ViT(Vision Transformer) 아키텍처를 diffusion의 denoising network로 채택:
- 입력 latent를 patchify → patch embedding → Transformer blocks
- Timestep $t$와 class label $c$를 **adaptive layer norm (adaLN)**으로 주입

### adaLN (Adaptive Layer Normalization)

Conditional information을 Transformer에 주입하는 핵심 메커니즘:
- $t$와 $c$의 embedding을 MLP에 통과 → scale/shift 파라미터 $(\gamma, \beta, \alpha)$ 생성
- 각 Transformer block에서 $\text{adaLN}(h) = \gamma \cdot \text{LayerNorm}(h) + \beta$
- 추가로 residual path 전에 $\alpha$로 scale

### 4가지 변형 (DiT-S/B/L/XL)

| 모델 | Layers | Hidden dim | Heads | Params |
|:-----|:------:|:----------:|:-----:|:------:|
| DiT-S | 12 | 384 | 6 | 33M |
| DiT-B | 12 | 768 | 12 | 130M |
| DiT-L | 24 | 1024 | 16 | 458M |
| DiT-XL | 28 | 1152 | 16 | 675M |

## 주요 발견

### Scaling Behavior

- **모델 크기 증가 → FID 지속적 개선:** Gflops 증가에 따라 FID가 power-law로 감소
- DiT-XL/2: ImageNet $256\times256$ FID **2.27** (SOTA at the time)
- **Transformer가 U-Net보다 scaling에 유리:** 더 큰 모델에서도 안정적 수렴

### adaLN vs. Cross-Attention vs. In-Context

Conditioning 방식 비교:
- **adaLN-Zero:** 각 residual block을 zero-initialized $\alpha$로 초기화 → 학습 안정성 향상
- Cross-attention 및 in-context conditioning보다 adaLN이 더 효율적

## U-Net vs. Transformer

| | U-Net (기존) | DiT (Transformer) |
|:--|:-----------|:----------------|
| Inductive bias | 지역성 (convolution) | 전역적 attention |
| Conditioning | FiLM, cross-attention | adaLN |
| Scaling | U-Net 구조에 제한적 | Transformer처럼 자유롭게 확장 |
| 해상도 | Pixel space 가능 | Latent space 필요 |

## 융합 도메인 연결

- [[score-based-generative-modeling-sde]] — Transformer backbone의 이론적 기반이 되는 SDE 프레임워크
- [[diffusion-metamaterial-inverse-design]] — U-Net 기반 diffusion의 mechanical 응용 (Transformer로의 전환 가능성)
- [[latent-diffusion-models]] — DiT가 작동하는 latent space 프레임워크

## References

- Peebles, W. & Xie, S. (2023). Scalable Diffusion Models with Transformers. arXiv:2212.09748.
- [[denoising-diffusion-probabilistic-models]]
