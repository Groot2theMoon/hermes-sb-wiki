---
title: "1-Lipschitz Layers Compared — Comprehensive Benchmark of Lipschitz Constraint Methods"
created: 2026-05-02
updated: 2026-05-02
type: concept
tags: [lipschitz, comparison, benchmark, certified-robustness, orthogonal-layers]
sources:
  - raw/papers/1-lipschitz-layers-compared.md
confidence: high
---

# 1-Lipschitz Layers Compared

> **Prach, B., Brau, F., Buttazzo, G. & Lampert, C. H. (2023).** "1-Lipschitz Layers Compared: Memory, Speed, and Certifiable Robustness." arXiv:2311.16833.

## 개요

다양한 1-Lipschitz layer 방법론을 **memory usage, speed, accuracy, certified robust accuracy** 등 6가지 메트릭으로 체계적으로 비교. 방법 선택을 위한 실용적 가이드라인 제공.

## 비교 대상 방법

| 방법 | 약칭 | 수학적 기반 | 주요 특징 |
|------|:----:|:----------:|:---------:|
| AOL (ECCV 2022) | AOL | Spectral norm rescaling | 일반성+효율성 |
| BCOP (NeurIPS 2019) | BCOP | Björck orthonormalization | 반복적 orthogonalization |
| Cayley (ICML 2019) | Cayley | Cayley transform | Orthogonal weight |
| SOC (ICML 2020) | SOC | Skew-symmetric + expm | Matrix exponential |
| CPL (2023) | CPL | Convex potential layer | Convex-concave 조합 |
| Orthogonal (ICML 2019) | Orthogonal | Householder/expm | Strict orthogonal |

## 평가 메트릭

1. **Training time** — 각 방법의 학습 시간
2. **Inference time** — 추론 시간
3. **Memory usage** — 추가 파라미터/버퍼
4. **Standard accuracy** — 일반 정확도
5. **Certified robust accuracy** — 인증된 강건 정확도
6. **Empirical robustness** — PGD 공격 대응

## 주요 결과

Figure 1 (radar chart) 기준 종합 순위:

| 순위 | 방법 | 강점 | 약점 |
|:---:|:----:|:----|:-----|
| 1 | **CPL** | 최고 성능 + 낮은 복잡도 | 상대적 신규성 |
| 2 | **AOL** | 우수한 종합 성능, 적은 메모리 | 표현력 제한 |
| 3 | **SOC** | 강건 정확도 우수 | expm 계산 비용 |
| 4 | **Cayley** | 안정적 성능 | Conv 확장 어려움 |
| 5 | **BCOP** | 좋은 강건성 | 반복 연산 overhead |

## 선택 가이드라인

| 사용 사례 | 권장 방법 |
|-----------|:---------:|
| 최고 certified robustness | CPL 또는 SOC |
| 메모리/시간 제약 환경 | AOL |
| FC network 중심 | Cayley or SOC |
| CNN 중심 | AOL or CPL |
| 최소 구현 복잡도 | AOL (simple rescaling) |
| 최고 standard accuracy | CPL |

## RIGOR 관련성

1-Lipschitz layer의 종합 비교는 RIGOR의 [[lbdn-lipschitz-bounded-networks|LBDN]]/[[aol-almost-orthogonal-layers|AOL]]/[[lipkernel-dissipative-cnn|LipKernel]] 선택의 근거 자료로 활용 가능:
- AOL: 가장 간단한 구현, RIGOR A+NN의 spectral normalization 대체 가능
- LipKernel: CNN-heavy RIGOR 확장에 적합
- LBDN: SDP 접근법으로 RIGOR LMI 기반 contractivity 검증과 방법론적 일관성

## Authors
- [[bernd-prach]]
- [[fabio-brau]]
- [[giorgio-buttazzo]]
- [[christoph-h-lampert]]

## Related
- [[aol-almost-orthogonal-layers]] — AOL 상세
- [[lipkernel-dissipative-cnn]] — LipKernel 상세
- [[lbdn-lipschitz-bounded-networks]] — LBDN 상세
- [[spectral-normalization-gan]] — Spectral normalization
