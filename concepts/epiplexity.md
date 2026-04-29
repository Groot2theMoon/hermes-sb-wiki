---
title: Epiplexity — Structural Information for Computationally Bounded Observers
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [information-theory, theory, learning, neuroscience]
sources: [raw/papers/epiplexity.md]
confidence: medium
---

# Epiplexity

**Finzi, Qiu, Jiang, Izmailov, Kolter, Wilson** (CMU & NYU, 2025)가 제안한 새로운 정보 측도. Shannon 정보와 Kolmogorov 복잡도로는 설명되지 않는, **computationally bounded observer가 데이터로부터 추출할 수 있는 구조적 정보**를 정량화한다.

## 동기: 세 가지 역설 (Three Paradoxes)

기존 정보이론과 ML 현실 사이의 괴리를 세 가지 역설로 제시:

### 역설 1: 결정론적 과정은 정보를 증가시킬 수 없다
- **Shannon/Kolmogorov 원리:** 결정론적 변환은 정보를 증가시킬 수 없음 (Data Processing Inequality)
- **현실 반례:** AlphaZero는 zero human data로부터 결정론적 게임 규칙만으로 초인공적 전략 학습, PRNG가 무작위성 생성, 수학자가 공리로부터 새로운 지식 도출
- **epiplexity의 해결:** 계산적 제약 하에서는 결정론적 과정이 **정보를 생성**할 수 있음 (귀납, 창발)

### 역설 2: 정보는 데이터 순서와 무관하다
- **Shannon/Kolmogorov 원리:** X→Y와 Y→X의 정보량이 동일
- **현실 반례:** LLM은 영어 텍스트를 순방향으로 학습할 때 역방향보다 훨씬 잘 학습 ("arrow of time"), 암호는 한 방향으로 쉽고 역방향으로 어려운 함수에 의존
- **epiplexity의 해결:** 계산적 제약 하에서 factorization order는 정보량을 결정

### 역설 3: Likelihood 모델링은 단순한 분포 매칭이다
- **Shannon/Kolmogorov 원리:** 최대 likelihood는 데이터 생성 과정을 재현할 뿐
- **현실 반례:** Conway's Game of Life에서 단순한 규칙으로부터 emergent structure (glider, oscillator) 학습 가능, 창발적 현상
- **epiplexity의 해결:** Computationally bounded observer는 데이터 생성 과정보다 **더 많은 구조**를 추출 가능

^[raw/papers/epiplexity.md]

## 정의: Epiplexity

**Epiplexity** (epistemic complexity) = computationally bounded observer가 데이터로부터 추출할 수 있는 **구조적 정보**의 양.

### 형식적 정의 (Definition 8)

Epiplexity는 **계산적 제약 하에서 MDL (Minimum Description Length) 원리**를 확장:

- **Random content (time-bounded entropy):** 계산적으로 예측 불가능한 무작위 성분 (예: CSPRNG 출력, chaotic system의 장기 예측 불가능성)
- **Structural content (epiplexity):** 계산적으로 추출 가능한 패턴, 규칙, 알고리즘 (예: 소팅 알고리즘, 중력 법칙, emergent object의 행동)

### 핵심 속성

1. **Observer-dependent:** 동일한 데이터라도 관찰자의 계산 능력에 따라 random/structural 구분이 달라짐
2. **Computation으로 증가 가능:** 결정론적 알고리즘 실행, 데이터 순서 재배열, synthetic data 생성 등으로 epiplexity 증가
3. **Likelihood modeling ≠ distribution matching:** Emergent structure 학습 가능
4. **OOD generalization과 양의 상관관계:** 높은 epiplexity 데이터는 더 다양한 downstream task로 전이

## 실용적 추정

Loss curve로부터 heuristic하게 추정:

```
Epiplexity ≈ ∫(L(t) - L_final) dt
             (area under loss curve above final loss)
```

더 엄밀한 방법: Teacher-student 모델 간의 **cumulative KL divergence** 측정.

실험 결과:
- 텍스트 데이터가 이미지 데이터보다 epiplexity 높음 → 더 넓은 전이 가능
- Dataset pruning (e.g., high loss 샘플 제거)은 epiplexity를 낮추고 OOD 성능 저하
- 데이터 순서 재배열 (e.g., curriculum learning) → epiplexity 변화

^[raw/papers/epiplexity.md]

## Shannon Entropy / Kolmogorov Complexity와의 비교

| 측도 | 대상 | 계산 제약 | 정보 유형 | 변환으로 증가? |
|------|------|----------|----------|--------------|
| **Shannon Entropy** | Random variable | 없음 (무한) | Communication | ❌ |
| **Kolmogorov Complexity** | 개별 문자열 | Turing-complete | Compressibility | ❌ (O(1)) |
| **Martin-Löf Randomness** | 개별 문자열 | Computable (무한) | Algorithmic randomness | — |
| **Sophistication** | 개별 문자열 | 무한 계산 | Structural | 이론적, 비구성적 |
| **Epiplexity** | 데이터셋 + 모델 | Bounded (poly-time) | **Structural for bounded observer** | ✅ |

## 관련 페이지

- [[free-energy-principle]] — Friston의 variational free energy도 surprise bound; epiplexity는 계산적 제약을 추가
- [[landauer-friston-connection]] — Landauer 원리의 정보-열역학; epiplexity는 "정보 생성은 가능하다"는 대비되는 주장
- [[denoising-diffusion-probabilistic-models]] — Diffusion model에서 entropy 증가 과정과 epiplexity의 관계
- [[deep-kalman-filter]] — DKF의 temporal dynamics 학습에서 구조적 정보 추출

## References

- Finzi, M., Qiu, S., Jiang, Y., Izmailov, P., Kolter, J. Z., & Wilson, A. G. (2025). From Entropy to Epiplexity: Rethinking Information for Computationally Bounded Intelligence. *arXiv:2601.03220*.
