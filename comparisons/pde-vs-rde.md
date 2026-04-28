---
title: Pulse Detonation Engine (PDE) vs Rotating Detonation Engine (RDE)
created: 2026-04-28
updated: 2026-04-28
type: comparison
tags: [comparison, foundation, fluid-dynamics, thermodynamics]
sources: [raw/papers/wolanski-2013-detonative-propulsion.md, raw/papers/lu-braun-2011-rotating-detonation-wave.md]
confidence: high
---

# Pulse Detonation Engine (PDE) vs Rotating Detonation Engine (RDE)

**Pulse Detonation Engine (PDE)**와 **Rotating Detonation Engine (RDE)**는 모두 detonation 연소를 활용하는 [[pressure-gain-combustion]] 기반 엔진이지만, 작동 방식과 구조적 특성이 근본적으로 다르다. 본 문서는 두 엔진 개념을 주요 차원에서 비교·분석한다.

## 비교 표

| 차원 (Feature) | PDE | RDE |
|----------------|------|------|
| **DDT 장치** | 필요 (필연적) — Shchelkin spiral, obstacle 등 | 불필요 — 시동 과도기 중 자연 DDT |
| **퍼지 (Purge)** | 필요 — 고온 생성물 배출 및 예연소 방지 | 불필요 — self-purging 특성 |
| **작동 주파수** | < 100–200 Hz | **1–10 kHz** (10–50배 높음) |
| **점화 (Ignition)** | **매 펄스마다 필요** — 고주파 점화 시스템 부담 큼 | **초기 1회만 필요** — 점화 시스템 단순/경량화 |
| **유동 불안정성** | 높음 — inlet unstart 위험, 맥동 배기 | **감소됨** — quasi-steady에 가까운 연속 유동 |
| **진동 (Vibration)** | 높음 — jackhammer 유사 소음 및 구조 피로 | **감소됨** — 지속적 roar, distinct thud 없음 |
| **연소 방식** | 축 방향 detonation tube (axial) | **원주 방향 detonation in annulus** (circumferential) |
| **연소실 형상** | 관형/원통형 (tube/cylinder) | 환형 연소실 (annular chamber) |
| **비추력 (Specific impulse)** | 이론적으로 유사 — 특정 Mach 수에서 PDE 우위 가능 | 이론적으로 유사 — 저속 조건에서 RDE 유리 가능성 |
| **컴팩트성 (Compactness)** | DDT 길이 제약으로 최소 체적 존재 | **더 컴팩트** — 축 방향 및 반경 방향 모두 작음 |
| **스케일링 (Scalability)** | 입증됨 (일정 한계 내) | 소형 입증, 대형(>2m) 미검증 |
| **기술 성숙도 (TRL)** | **비행 실증 완료** (2008년 Long EZ 개조) | 주로 **지상 시험** 단계 (수 초 이내) |
| **열 부하 (Heating)** | 높음 (간헐적) | **매우 높음** (연속적, 최대 17 MW/m²) |
| **소음** | 시끄러움 (특징적 thudding) | 시끄러움 (지속적 roar) |
| **터보기계 통합** | 가능 | 가능 |

^[raw/papers/lu-braun-2011-rotating-detonation-wave.md]의 Table 1을 기반으로 확장.

## 상세 비교

### 1. DDT 및 퍼지 (DDT Device & Purge)

PDE는 detonation 달성을 위해 DDT enhancement device(obstacle, Shchelkin spiral 등)가 필수적이다. DDT 길이는 O(0.1–1)m로, 이는 최소 연소관 길이를 결정짓는 핵심 설계 변수이다. 또한 PDE는 fill-purge-detonate-blowdown의 4단계 사이클로 작동하며, 퍼지 과정 없이는 고온 생성물이 신선한 연료를 조기에 점화(pre-ignition)시키는 문제가 발생한다.

반면 RDE는 연속적으로 연료가 공급되며, detonation wave 통과 후 압력이 낮아지면 자연스럽게 재급유가 이루어지는 self-purging 특성을 가진다. DDT는 시동 시 annulus를 따라 화염이 가속되면서 자연 발생하므로 별도의 DDT enhancement device가 불필요하다.

### 2. 작동 주파수와 비추력

PDE의 사이클 주파수는 fill/purge 과정의 시간 소모로 인해 낙관적으로도 100–200 Hz로 제한된다. RDE는 1–10 kHz의 고주파수로 작동하여 quasi-steady flow에 가깝다. 이는 turbine inlet과의 통합 시 유리하며, 맥동에 의한 손실을 최소화한다.

비추력(Isp) 측면에서는 두 방식이 이론적으로 유사한 성능을 보일 수 있다. Wolanski (2013)의 분석에 따르면 특정 조건(Mach 수, 연료/산화제 조합)에서 PDE가 약간 유리한 경우가 있으나, RDE의 고주파수 연속 작동이 시스템 통합 측면에서 실질적 이점을 제공한다. ^[raw/papers/wolanski-2013-detonative-propulsion.md]

### 3. 기술 성숙도

PDE는 2008년 1월 31일 Scaled Composites Long EZ 항공기를 개조한 비행 실증에 성공한 반면, RDE는 아직 장시간(>5초) 연속 작동 실증이 제한적이다. 현재 RDE 연구는 주로 단기 지상 시험(<1초)에 머물러 있으며, 실용화를 위해서는 열 관리, injector 설계, wave 안정성 제어 등 여러 과제가 해결되어야 한다.

## 장단점 요약

### PDE 장점
- 비행 실증 완료 (더 높은 TRL)
- 단순한 관형 형상 (제조 용이)
- 다양한 연료/산화제 조합 검증 완료
- 특정 Mach 수에서 추력 특성 우위 가능

### PDE 단점
- DDT 장치 필수 (중량 및 체적 증가)
- 낮은 작동 주파수 (< 200 Hz)
- 매 펄스 점화 필요 (시스템 복잡성)
- 높은 유동 불안정성 및 진동
- 퍼지 과정 필요 (효율 손실)

### RDE 장점
- DDT 장치 불필요 (컴팩트 설계)
- 1–10 kHz 고주파수 (quasi-steady flow)
- 1회 점화 (단순화된 시스템)
- Self-purging (퍼지 손실 없음)
- 감소된 진동/소음

### RDE 단점
- 낮은 TRL (장시간 연속 작동 미검증)
- 극심한 열 부하 (17 MW/m² 이상)
- Injector 설계의 어려움 (backflow 문제)
- Wave 안정성 및 방향 제어 미해결
- 대형 스케일링 미검증

## 언제 무엇을 선택할까? (When to Choose Which)

### PDE를 선택해야 할 때
- **빠른 실증이 필요**한 경우 — PDE 기술은 이미 비행 실증됨
- **저주파수 맥동**이 시스템에 허용되는 경우
- **소형/단순 관형 연소실**이 요구되는 경우
- **예측 가능한 성능**이 중요한 경우 (PDE 특성 데이터 풍부)
- **고 Mach 수 (초음속)** 조건에서 운용 (PDE의 Isp 특성이 유리할 수 있음)

### RDE를 선택해야 할 때
- **최고 효율과 컴팩트성**이 중요한 경우
- **고주파수 연속 유동**이 필요한 turbomachinery 통합형
- **장기 운용 수명**이 중요한 경우 (단일 점화, 단순 구조)
- **진동/소음 최소화**가 필요한 플랫폼
- **우주 발사체 (launch vehicle)** 응용 — 연속 연료 공급, self-purging 특성 유리
- **신규 플랫폼 설계** — RDE의 paradigm shift 가능성을 최대화

## 관련 페이지

- [[rotating-detonation-engine]] — RDE 상세
- [[pressure-gain-combustion]] — PGC 열역학적 기초
- [[deflagration-to-detonation-transition]] — DDT 과정 상세
