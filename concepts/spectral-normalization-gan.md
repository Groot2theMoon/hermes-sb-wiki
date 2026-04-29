---
title: Spectral Normalization for GANs — Lipschitz Constraint via Weight Normalization
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [model, training, neural-network, generative-model, landmark-paper]
sources: [raw/papers/Spectral Normalization for Generative Adversarial Networks.md]
confidence: high
---

# Spectral Normalization for GANs

## 개요

Miyato et al. (Preferred Networks, ICLR 2018)이 제안한 **Spectral Normalization (SN)** 은 GAN discriminator의 각 층 weight 행렬의 **spectral norm을 1로 제한**하는 정규화 기법이다. 단 1회의 power iteration으로 Lipschitz constant를 제어하며, 추가 하이퍼파라미터가 없다.

## 핵심 아이디어

### Lipschitz Constraint

GAN discriminator $D$가 1-Lipschitz이면 안정적 학습이 보장된다 (WGAN 이론):

$$\|D(x) - D(y)\| \leq \|x - y\|$$

SN은 각 weight 행렬 $W$에 대해:

$$\bar{W}_{SN}(W) = W / \sigma(W)$$

여기서 $\sigma(W)$는 $W$의 spectral norm (최대 singular value).

### Power Iteration으로 계산

전체 SVD 대신 **power iteration**으로 근사:
- 초기 랜덤 벡터 $u$로 시작
- $v = W^T u / \|W^T u\|$, $u = W v / \|W v\|$ 반복
- $\sigma(W) \approx u^T W v$

1회 반복만으로도 충분한 근사 정확도 — forward/backward pass마다 1회 실행.

## 장점

- **계산 효율성:** gradient penalty (WGAN-GP)보다 훨씬 빠름
- **단일 하이퍼파라미터 불필요:** Lipschitz constant가 1로 auto-tuned
- **안정적 학습:** discriminator over-confidence 방지, mode collapse 완화
- **이론적 정당성:** WGAN Lipschitz constraint의 간결한 구현

## 성능

- CIFAR-10: IS 8.22
- STL-10: IS 9.44
- 128×128 ImageNet 생성 최초 성공

## 한계

- Generator에는 적용 불필요 (discriminator만으로 충분 — Miyato 논문 §3.2)
- Conditional GAN에는 layer-wise가 아닌 최적화된 정규화가 더 효과적일 수 있음

## References

- [[gan-lattice-simulations]] — GAN의 격자 시뮬레이션 응용
- [[generative-models-physics]] — 물리학에서의 생성 모델 활용
- [[nn-tricks]] — 신경망 학습 practical tips
- [[mode-collapse-flow-lattice]] — Mode collapse 문제와 해결
- [[sn-gan-vs-gan-lattice]]
