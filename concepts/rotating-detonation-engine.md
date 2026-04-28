---
title: Rotating Detonation Engine (RDE)
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [foundation, fluid-dynamics, thermodynamics, survey]
sources: [raw/papers/wolanski-2013-detonative-propulsion.md, raw/papers/lu-braun-2011-rotating-detonation-wave.md, raw/papers/bykovskii-2006-continuous-spin-detonations.md]
confidence: high
---

# Rotating Detonation Engine (RDE)

**Rotating Detonation Engine (RDE)**는 **Continuous Detonation Engine (CDE)** 또는 **연속 회전 폭발 엔진**이라고도 불리며, 환형(annular) 연소실 내에서 하나 이상의 detonation wave가 원주 방향으로 1–10 kHz의 고주파수로 회전하며 연료를 연소시키는 추진 기관이다. RDE는 [[pressure-gain-combustion]]의 가장 대표적인 실현 형태 중 하나이다.

## 작동 원리

RDE의 중심 개념은 환형 채널(annular chamber)에서 detonation wave가 원주 방향(circumferentially)으로 회전하는 것이다. 연료와 산화제는 연소실 하단의 injector arrays를 통해 지속적으로 공급되며, 회전하는 detonation wave가 이를 소모한다. Wave 통과 후 발생하는 고압 영역이 injector 유로를 일시적으로 차단(backflow/blockage)했다가 압력이 낮아지면 재급유(refueling)가 이루어진다. 이 과정이 연속적으로 반복되면서 detonation wave가 자생적으로 유지된다. ^[raw/papers/lu-braun-2011-rotating-detonation-wave.md]

### 핵심 구조 요소
- **Annular combustion chamber**: 동심원 형태의 환형 연소실
- **Injector orifice arrays**: 연료와 산화제를 별도로 분사하는 인젝터 시스템
- **Detonation wave**: 환형 채널을 회전하는 transverse detonation wave (TDW)
- **Oblique shock wave / tail**: Detonation wave 후방에 형성되는 충격파 구조
- **Nozzle (aerospike 등)**: 고엔탈피 생성물을 가속하는 노즐

## PDE와의 비교

RDE는 [[pde-vs-rde|Pulse Detonation Engine (PDE)]]와 비교하여 몇 가지 중요한 차이점을 가진다:

| 특성 | RDE | PDE |
|------|-----|-----|
| 연소 방식 | 원주 방향 연속 폭발 | 축 방향 맥동 폭발 |
| DDT 장치 | 불필요 (자연 발생) | 필요 (Shchelkin spiral 등) |
| 퍼지(Purge) | 불필요 (self-purging) | 필요 |
| 작동 주파수 | 1–10 kHz | < 100–200 Hz |
| 점화 | 초기 1회만 필요 | 매 펄스마다 필요 |
| 유동 불안정성 | 감소됨 | 높음 |
| 진동 | 감소됨 | 높음 |

RDE가 PDE보다 유리한 점은 DDT enhancement device가 불필요하다는 것이다. RDE는 시동 과도기(startup transient) 동안 화염이 환형 채널을 따라 가속되면서 자연스럽게 DDT가 발생한다. 일단 fully-developed detonation wave가 형성되면, 연료 공급만 지속되면 wave가 자생적으로 유지된다. ^[raw/papers/lu-braun-2011-rotating-detonation-wave.md]

## 장점

1. **높은 열역학 효율**: Fickett-Jacobs cycle 기준으로 Brayton cycle 대비 큰 효율 향상. 수소 기준 Brayton 36.9%, Humphrey 54.3%, Fickett-Jacobs 59.3% ([[pressure-gain-combustion]] 참조)
2. **고밀도 에너지 변환 (High specific power)**: 빠른 에너지 방출로 소형화 가능
3. **단순한 구조**: 움직이는 부품이 없음, 단일 점화 시스템
4. **높은 체적 효율 (Volumetric efficiency)**: PDE보다 컴팩트한 설계 가능
5. **유동 연속성**: 1–10 kHz 고주파수로 quasi-steady flow에 가까움

## 도전 과제

1. **열 관리 (Thermal management)**: Le Naour et al.은 $H_2/O_2$ RDE에서 최대 700°C 이상, 등유/산소에서 1000°C 이상의 벽 온도를 보고했다. 열유속은 최대 17 MW/m²에 달한다. ^[raw/papers/lu-braun-2011-rotating-detonation-wave.md]
2. **Injector 설계**: Detonation wave의 고압이 injector 역류(backflow)를 유발하며, 설계에 큰 제약을 가한다. 매니폴드 압력은 연소실 압력의 2–3배 이상이 필요하다. ^[raw/papers/bykovskii-2006-continuous-spin-detonations.md]
3. **Detonation wave 안정성**: Single vs multiple wave, wave 방향 제어, contact surface burning으로 인한 불안정성
4. **연료/산화제 혼합**: 고속 유동 조건에서의 빠르고 균일한 혼합 문제
5. **재료**: 초고온 및 고열유속 환경을 견딜 수 있는 재료 필요 (C/SiC 복합재 등)
6. **스케일링**: 대형 엔진(직경 2m 이상)으로의 확장성 검증 미흡

## 역사적 발전

| 시기 | 연구자 | 주요 기여 |
|------|--------|----------|
| 1959–1963 | **Voitsekhovskii** (Lavrent'ev Institute of Hydrodynamics, LIH) | 최초의 연속 회전 폭발 실증 — 평면 환형 채널에서 아세틸렌-산소 혼합물 사용 |
| 1960s | **Nicholls, Cullen** (University of Michigan) | RDE 로켓 모터 타당성 연구 |
| 1980–2006 | **[[fedor-bykovskii]], Mitrofanov, Zhdan, Vedernikov** (LIH) | 포괄적 실험 — 다양한 연료(기체/액체/이상), 기하학, 주입 방식에 걸친 CSD 연구 |
| 2006 | **Bykovskii et al.** | "Continuous Spin Detonations" 종합 논문 발표 (JPP) |
| 2010s | **[[piotr-wolanski]] 및 Warsaw University of Technology 팀** | Polish RDE 프로그램 — 다양한 연료-산소 조합 실험 |
| 2011 | **Lu, Braun** (UT Arlington) | RDE 포괄적 리뷰 — 실험적 도전과제 및 모델링 정리 |

Voitsekhovskii는 1959년 Doklady Akademii Nauk SSSR에 "Statsionarnaya dyetonatsiya" (Stationary Detonation)를 발표하며 최초의 연속 detonation 실험 결과를 보고했다. 그는 연속 detonation 과정을 "steady spin detonation" 또는 "continuous spin detonation (CSD)"이라고 명명했다. 이후 [[fedor-bykovskii]]와 LIH 팀은 CSD를 거의 모든 기체 및 액체 연료로 확장했으며, 다양한 챔버 형상(원통형, 확장 채널형, 평면-방사형)에서 실증했다. ^[raw/papers/bykovskii-2006-continuous-spin-detonations.md]

## 관련 페이지

- [[pressure-gain-combustion]] — PGC의 열역학적 기초
- [[deflagration-to-detonation-transition]] — DDT 과정 상세
- [[pde-vs-rde]] — PDE와 RDE의 상세 비교
- [[fedor-bykovskii]] — CSD 연구의 선구자
- [[piotr-wolanski]] — Polish RDE 연구 프로그램
