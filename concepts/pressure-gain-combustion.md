---
title: Pressure Gain Combustion (PGC)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [foundation, thermodynamics, survey]
sources: [raw/papers/wolanski-2013-detonative-propulsion.md, raw/papers/lu-braun-2011-rotating-detonation-wave.md]
confidence: high
---

# Pressure Gain Combustion (PGC)

**Pressure Gain Combustion (PGC)**는 연소파(combustion wave)를 통과하면서 정압(static pressure)이 상승하는 연소 과정을 의미한다. 이는 압력이 감소하는 일반적인 deflagration(화염 전파) 연소와 근본적으로 구별된다. PGC는 detonation 기반 추진 기관의 핵심 열역학적 원리로, [[rotating-detonation-engine]]과 Pulse Detonation Engine (PDE)의 효율 우위를 설명하는 기반 이론이다.

## Deflagration vs Detonation

| 특성 | Deflagration (화염 전파) | Detonation (폭발 연소) |
|------|--------------------------|------------------------|
| 전파 속도 | subsonic (1–10 m/s) | supersonic (1,500–3,000 m/s) |
| 압력 변화 | **감소** (pressure drop) | **증가** (pressure gain) |
| 지배 방정식 | 확산 및 열전도 | 충격파-화학 반응 결합 |
| 연소 효율 | 상대적 낮음 | 상대적 높음 |
| 엔트로피 생성 | 높음 | 낮음 |

Detonation 연소의 핵심 장점은 동일한 초기 조건에서 detonation 생성물의 엔트로피가 deflagration보다 낮다는 점이다 (Zel'dovich, 1940). ^[raw/papers/wolanski-2013-detonative-propulsion.md]

## 열역학적 사이클 비교

PGC의 열역학적 우위를 이해하기 위해 세 가지 이상 사이클(ideal cycle)을 비교할 수 있다:

| 사이클 | 연소 방식 | 수소 기준 효율 | 특징 |
|--------|-----------|----------------|------|
| **Brayton-Joule** | 정압(등압) 연소 | 36.9% | 기존 가스터빈 사이클 |
| **Humphrey** | 정적(등적) 연소 | 54.3% | Constant volume combustion |
| **Fickett-Jacobs (FJ)** | Detonation 연소 | **59.3%** | Detonation wave 사이클 |

위 표는 Wolanski (2013)의 stoichiometric hydrogen-air 혼합물 기준 데이터로, Fickett-Jacobs cycle이 Brayton cycle 대비 약 **22% 포인트의 효율 향상**을 보여준다. FJ cycle은 detonation 과정이 Humphrey cycle보다도 더 유리한 이유를 설명한다 — detonation wave는 충격파 압축과 열 방출이 결합되어 있어, 이상적인 정적 연소(Humphrey)보다도 높은 효율을 달성할 수 있다. ^[raw/papers/wolanski-2013-detonative-propulsion.md]

### 사이클의 T-s 선도

실제 detonation 엔진을 가장 적절히 모델링하는 사이클은 **Zel'dovich-von Neumann-Döring (ZND) cycle**로 간주된다. FJ cycle은 CJ (Chapman-Jouguet) 조건에서의 이상화된 모델이며, 실제 비가역성을 포함한 ZND cycle이 가장 물리적으로 정확하다. Lu & Braun (2011)은 "constant volume combustor"라는 용어가 detonation 과정을 설명하기에는 부적절하다고 지적하며, detonation은 충격파 압축이 수반되는 독특한 과정임을 강조한다. ^[raw/papers/lu-braun-2011-rotating-detonation-wave.md]

## PGC 구현 방식

PGC를 실제 엔진에서 구현하는 방식은 크게 두 가지로 분류된다:

1. **[[rotating-detonation-engine|Rotating Detonation Engine (RDE)]]**: 환형 연소실에서 detonation wave가 연속적으로 회전
2. **Pulse Detonation Engine (PDE)**: 관형 연소실에서 축 방향으로 맥동하는 detonation wave

### RDE vs PDE의 PGC 특성

- RDE는 연속 유입(continuous feed)과 self-purging 특성으로 인해 더 높은 작동 주파수(1–10 kHz)에서 PGC 실현 가능
- PDE는 fill-purge-detonate-blowdown의 4단계 사이클로 인해 주파수 제한(< 100–200 Hz)이 있음
- 두 방식 모두 기존 Brayton cycle 기반 엔진 대비 20% 이상의 효율 향상 잠재력을 가짐

## PGC의 실제적 이점

1. **추진 효율 20%+ 향상**: 동일 연료 소모량 대비更高的 specific impulse
2. **컴팩트한 설계**: 높은 에너지 변환 밀도로 엔진 크기/중량 감소
3. **단순화된 구조**: 고압 압축기 단수 감소 또는 제거 가능
4. **연료 다양성**: 기체 및 액체 연료 모두 사용 가능

## 도전 과제

- 실제 PGC 구현 시 injector backflow, 열 관리, detonation wave 안정성 등 비이상적 효과로 인해 이론적 효율의 일부만 달성 가능
- Pressure gain의 정확한 측정 및 정량화 방법론 미확립
- 기존 터보기계(turbomachinery)와의 통합 시 PGC의 맥동 특성이 미치는 영향 연구 필요

## 관련 페이지

- [[rotating-detonation-engine]] — RDE의 상세 작동 원리
- [[deflagration-to-detonation-transition]] — DDT 메커니즘
- [[pde-vs-rde]] — PDE와 RDE의 상세 비교
