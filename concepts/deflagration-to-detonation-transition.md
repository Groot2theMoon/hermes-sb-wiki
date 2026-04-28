---
title: Deflagration-to-Detonation Transition (DDT)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [foundation, fluid-dynamics, thermodynamics]
sources: [raw/papers/wolanski-2013-detonative-propulsion.md, raw/papers/lu-braun-2011-rotating-detonation-wave.md]
confidence: high
---

# Deflagration-to-Detonation Transition (DDT)

**Deflagration-to-Detonation Transition (DDT)**는 아음속(subsonic) 화염 전파(deflagration)가 가속되어 초음속(supersonic) detonation wave로 전이되는 과정을 의미한다. DDT는 [[pressure-gain-combustion]] 기반 추진 기관의 핵심 물리적 과정 중 하나이며, [[rotating-detonation-engine]]과 PDE에서의 역할이 상이하다.

## DDT의 물리적 메커니즘

DDT 과정은 다음과 같은 일련의 단계로 진행된다:

1. **화염 가속 (Flame acceleration)**: 점화된 화염이 연소실 내를 전파하면서 난류(turbulence)를 생성
2. **난류 생성 및 화염면 왜곡**: 장애물(obstacle) 또는 벽면 마찰에 의한 난류 생성으로 화염면이 왜곡되고 연소 면적 증가
3. **압력파 형성**: 급속한 열 방출로 인해 선행 충격파(precursor shock wave)가 형성
4. **충격파-화염 결합**: 충격파에 의한 미연소 혼합물의 압축/가열로 화염 속도가 더욱 증가
5. **Detonation 천이**: 충격파와 화염 반응대가 결합하여 self-sustaining detonation wave 형성

DDT 길이는 일반적으로 **O(0.1–1) m** 범위이며, 연료 종류, 당량비, 초기 온도/압력, 혼합물의 detonation cell size에 따라 달라진다. ^[raw/papers/lu-braun-2011-rotating-detonation-wave.md]

## DDT 촉진 장치 (DDT Enhancement Devices)

PDE에서는 DDT 길이를 단축하기 위해 다양한 촉진 장치가 사용된다:

| 장치 | 설명 | 효과 |
|------|------|------|
| **Shchelkin spiral** | 나선형 금속 스트립을 연소관 내에 설치 | 난류 생성으로 화염 가속 촉진 |
| **Orifice plate / baffle** | 유로에 장애물 배열 | 충격파 반사 및 난류 증대 |
| **Wall obstacles** | 연소관 벽면의 돌출부 | 화염면 왜곡 및 면적 증가 |
| **Predetonator tube** | 소형 DDT 관에서 먼저 detonation 유도 후 주 연소관 전달 | 안정적이고 신뢰성 높은 기법 |

## PDE에서의 DDT

PDE에서 DDT는 **필수적이면서도 가장 제약적인 요소**이다:

- DDT enhancement device 없이는 detonation 달성이 어려움
- DDT 길이(0.1–1 m)가 최소 연소관 길이를 결정 → 엔진 체적 증가
- DDT 과정 자체가 사이클 시간 소모 → 작동 주파수 제한(< 100–200 Hz)
- 직접 점화(direct initiation)는 과도한 에너지가 필요하므로 현실적이지 않음
- DDT의 불확실성(probability)으로 인해 반복성(repeatability) 문제 발생 가능

## RDE에서의 DDT

RDE에서는 DDT가 **자연적으로 발생**하며, 별도의 촉진 장치가 필요하지 않다:

1. **시동 과도기 (Startup transient)**: 점화 후 화염이 환형 채널을 따라 가속
2. **원주 방향 가속**: 화염이 annulus를 한 바퀴 회전하면서 자연스럽게 DDT 달성
3. **자생적 유지**: 일단 fully-developed detonation wave가 형성되면 연료 공급만으로 유지

RDE의 DDT 과정은 PDE와 달리 **추가 장치 없이** 작동하며, 이는 RDE의 주요 장점 중 하나이다. Bykovskii et al. (2006)은 RDE 시동 시 detonation wave가 안정화되기까지 수 회전이 소요되며, 이 과정에서 wave 수(n)의 변화나 회전 방향의 반전이 관찰될 수 있다고 보고했다. ^[raw/papers/bykovskii-2006-continuous-spin-detonations.md]

## DDT의 핵심 파라미터

### Detonation Cell Size (λ)

Detonation cell size λ는 DDT 과정과 밀접한 관련이 있다:

- λ가 작을수록 DDT가 쉽게 발생 (수소 > 메탄 > 프로판 순)
- RDE 연소실 설계에서 annulus 폭(Δ)과 혼합물 층 높이(h)는 λ에 비례하여 결정됨
- Bykovskii의 경험식: $h \cong (12 \pm 5)a$ (a = cell width), $h \cong (17 \pm 7)\lambda$ (λ = reaction zone length)

### DDT 길이 스케일링

DDT 길이는 연료의 화학적 활성도, 초기 압력, 온도, 그리고 연소관 형상에 크게 의존한다:

- 활성 연료(H₂, C₂H₂): 짧은 DDT 길이 (~0.1 m)
- 비활성 연료(CH₄, kerosene): 긴 DDT 길이 (~1 m 이상)
- 초기 압력 증가 → λ 감소 → DDT 길이 감소

## 직접 점화 (Direct Initiation) vs DDT

| 방식 | 에너지 요구량 | 신뢰성 | 주파수 영향 | 실용성 |
|------|---------------|--------|-------------|--------|
| **DDT** | 매우 낮음 | 중간 (확률적) | 제한적 (시간 소모) | 높음 |
| **Direct initiation** | 매우 높음 (kJ-MJ) | 높음 | 적음 | 낮음 (과도한 에너지) |

직접 점화는 blast wave를 통해 즉시 detonation을 달성하지만, 필요한 에너지가 지나치게 커서 실제 엔진 응용에는 부적합하다. 따라서 대부분의 detonation 엔진은 DDT 경로를 사용한다. ^[raw/papers/wolanski-2013-detonative-propulsion.md]

## 관련 페이지

- [[rotating-detonation-engine]] — RDE에서의 DDT 자연 발생 과정
- [[pressure-gain-combustion]] — PGC의 열역학적 기초
- [[pde-vs-rde]] — PDE(DDT 필수)와 RDE(DDT 불필요)의 비교
