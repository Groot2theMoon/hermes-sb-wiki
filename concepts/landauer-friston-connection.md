---
title: Landauer's Principle ↔ Friston's Free Energy Principle — Information Thermodynamics Connection
created: 2026-04-29
updated: 2026-04-29
type: comparison
tags: [comparison, information-thermodynamics, information-theory, neuroscience, self-organization, thermodynamics]
sources: [raw/papers/The free-energy principle - a rough guide to the brain.md, raw/papers/nrn2787.md]
confidence: high
---

# Landauer's Principle ↔ Friston's Free Energy Principle

정보-열역학의 두 거대 이론 체계를 비교한다. 둘 다 **"정보 처리는 자유에너지를 소모/최소화한다"**는 공통 명제를 다른 수준에서 전개한다. Landauer는 미시적(1 bit) 하한을 정량화했고, Friston은 이를 생물학적 자기조직화로 일반화했다.

## 비교 표

| 차원 | Landauer (1961) | Friston (2006-) |
|------|----------------|-----------------|
| **핵심 명제** | 1 bit 삭제 = 최소 k_B·T·ln2 열 방출 | 생물 시스템은 변분 자유에너지를 최소화하여 생존 |
| **대상** | 논리 게이트, 컴퓨터 메모리 | 뇌, 생물체, 자기조직화 시스템 |
| **규모** | 미시적 (1 bit 수준) | 거시적 (agent 전체 수준) |
| **자유에너지 정의** | 열역학적 Helmholtz: F = U - TS | 변분적: F = Energy - Entropy = -⟨ln p(y,θ)⟩ + ⟨ln q(θ)⟩ |
| **정보-열 연결** | 정보 삭제 → 열역학 entropy 증가 | 감각 entropy 최소화 → 변분 자유에너지 최소화 → 생존 |
| **최적화 방향** | 에너지 하한 (k_B·T·ln2)으로 수렴 | Variational bound (surprise 상한) 최소화 |
| **함의** | "정보는 물리적이다" | "지각과 행동은 자유에너지 최소화의 두 측면이다" |

## 연결 고리

### ① 수학적 동형성

두 이론은 동일한 형태의 자유에너지 식을 사용한다.

**Landauer (Helmholtz 자유에너지):**
```
F = U - TS
```

**Friston (Variational 자유에너지):**
```
F = Energy - Entropy = -⟨ln p(y,θ)⟩_q + ⟨ln q(θ)⟩_q
```

**Friston의 의도:** 자유에너지라는 명칭은 우연이 아니다. 변분 자유에너지는 통계물리의 Helmholtz 자유에너지와 수학적으로 동일한 구조를 가지며, Friston은 이 동형성을 의도적으로 활용했다.

### ② Maxwell's Demon — 두 이론을 잇는 가교

- **Landauer → Bennett:** Charles Bennett이 Landauer 원리로 Maxwell's Demon 역설 해결. 데몬이 정보를 삭제할 때 k_B·T·ln2가 방출되므로 열역학 2법칙은 유지된다.
- **Sagawa-Ueda (2008-09):** 정보-열역학적 피드백 — 측정 정보를 활용하면 Landauer 한계를 우회하여 실질적 일(work)을 얻을 수 있음을 증명.
- **Friston의 Active Inference:** 생물체 = Maxwell's Demon-like agent. 지각(측정) → 행동(정보-열역학적 피드백) → surprise 최소화(entropy 감소).

### ③ Friston이 Landauer를 인용하는 방식

Friston (2006, 2009, 2010)은 생물학적 시스템이 "무질서 경향에 저항한다"고 서술할 때, 이는 Landauer가 정량화한 정보 처리의 열역학적 비용을 생물학적 맥락으로 일반화한 것이다. FEP의 핵심 motivation인 **"living systems resist the second law"**는 Landauer로부터 시작된 정보-열역학 전통에 뿌리를 둔다.

## Sagawa-Ueda 피드백 — FEP로의 다리

2008년 Sagawa & Ueda는 다음을 증명했다:

> 정보-열역학적 피드백: 측정된 정보를 활용하면 Landauer 한계의 **2배**에 달하는 일(work)을 추출할 수 있다.

Friston의 active inference는 이와 정확히 동일한 구조를 따른다:
- **측정 (지각):** 감각 입력으로부터 환경 상태 추론 (Bayesian inference)
- **피드백 (행동):** 추론된 모델을 바탕으로 환경 조작 (active sampling)
- **이득:** surprise 최소화 = entropy 최소화 = 생존

```
Landauer → Sagawa-Ueda → Friston

정보 삭제    정보-열역학 피드백    생물학적 자기조직화
(비용)      (측정으로 이득)      (지각 + 행동 통합)
```

## 통합 프레임워크

```
층위 1: Landauer (1961)
└─ 정보 삭제의 열역학적 하한: k_B·T·ln2 per bit
    └─ 명제: "Information is physical"

층위 2: Bennett / Sagawa-Ueda (1982-2009)
└─ 정보-열역학 피드백: 측정 정보의 열역학적 효용
    └─ 명제: "Information can be converted to work"

층위 3: Friston의 FEP (2006-)
└─ 생물학적 시스템의 자기조직화: 지각 + 행동 = 변분 자유에너지 최소화
    └─ 명제: "Life is free energy minimization"
```

## 언제 무엇을 참조할까?

| 연구 맥락 | 참조할 이론 |
|-----------|------------|
| 양자컴퓨팅의 에너지 하한 | Landauer's Principle |
| 뇌-컴퓨터 인터페이스, 신경 코딩 | Friston's FEP |
| AI의 에너지 효율성 이론적 한계 | Landauer (하한) + FEP (구조적 원리) |
| **Reverse engineering biological intelligence** | FEP → Landauer (FEP가 왜 정보를 효율적으로 처리하는지, Landauer가 그 물리적 한계는 무엇인지) |
| 계산의 물리학 (Physics of Computation) | Landauer (기본) + FEP (생물학적 확장) |
| Active inference robotics | FEP + Sagawa-Ueda (정보-열역학적 최적성) |

## 결론

> **Landauer는 "정보를 지우려면 열을 내야 한다"고 했고, Friston은 "생물은 그 열을 감당하면서도 정보를 처리하는 이유가 생존(entropy 회피) 자체가 free energy 최소화이기 때문"이라고 답한다.**

두 이론은 같은 수학적 프레임워크(자유에너지 최소화)를 다른 수준에서 적용한 것이며, 그 사이를 정보-열역학(Information Thermodynamics)이 연결한다.

## 관련 페이지

- [[free-energy-principle]] — FEP의 상세 개념
- [[karl-friston]] — Karl Friston 인물 정보
- [[variational-autoencoder]] — VAE와 FEP의 수학적 동형성
- [[uncertainty-quantification-deep-learning]] — Entropy 기반 불확실성 정량화
