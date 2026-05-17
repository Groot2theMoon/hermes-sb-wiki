---
title: "Flow Field Reconstruction with Sensor Placement Policy Learning"
created: 2026-05-17
updated: 2026-05-17
type: concept
tags: [model, fluid-dynamics, surrogate-model]
sources: [raw/papers/flow-reconstruction-sensor-placement-policy.md]
confidence: high
---

# Flow Field Reconstruction with Sensor Placement Policy Learning

**Ruoyan Li, Guancheng Wan, Zijie Huang, Zixiao Liu, Haixin Wang, Xiao Luo, Wei Wang, Yizhou Sun** (arXiv:2605.14137)

## 개요

유체 역학에서 sparse sensor 측정값으로부터 전체 flow field를 재구성하는 것은 고해상도 데이터의 필요성과 실제 센서 배치의 물리적 제약 사이의 근본적인 충돌로 인해 지속적인 난제로 남아 있다. 기존의 딥러닝 기반 방법들은 2차원 도메인, 사전 정의된 지배 방정식, 또는 수동으로 설계된 센서 배치와 같은 단순화 가정에 의존하는 한계를 가진다. 본 논문은 이러한 가정 없이 실제 조건에서 작동 가능한 강화학습(RL) 기반 센서 배치 정책을 제안한다.

## 핵심 아이디어

- **RL-driven sensor placement policy**: 강화학습 에이전트가 센서 위치를 순차적으로 선택하는 정책을 학습. 보상 함수는 재구성 오차를 최소화하도록 설계됨.
- **Neural operator backbone**: 센서 측정값을 전체 flow field로 매핑하는 Neural-Operator 기반 재구성 백본이 센서 배치 정책과 **공동 최적화(joint optimization)**됨.
- **3차원 유동장 적용**: 2차원 단순화 없이 실제 3차원 유동 환경에서 검증.
- **사전 정의된 방정식 불필요**: 지배 방정식에 대한 가정 없이 데이터 기반으로 학습 가능.

## 결과

- **32% 낮은 재구성 오차** — 균일(uniform) 센서 배치 대비
- **18% 낮은 재구성 오차** — 휴리스틱(heuristic) 센서 배치 대비
- **Reynolds 수 전이(Re=100–1000)**: 학습된 센서 배치 정책이 다양한 Reynolds 수 조건으로 일반화 가능함을 입증

## 의의

- **Adaptive sensor placement는 학습 가능함**: RL을 통해 센서 배치를 능동적으로 최적화할 수 있음을 최초로 실증.
- **일반화 가능성**: 단일 유동 조건에서 학습된 정책이 이전에 보지 못한 Reynolds 수로 전이됨 → 실제 실험 환경에서의 활용 가능성 시사.
- **Neural operator + RL 결합**: 두 패러다임의 결합이 sparse sensing 문제에서 강력한 시너지를 발휘함을 보임.

## Wikilinks

- [[neural-operator]] — flow reconstruction backbone으로 사용된 핵심 방법론
- [[fluid-dynamics]] — 유체 역학 문제에의 적용
- [[surrogate-model]] — surrogate 모델링 관점
- [[digital-twin]] — sparse sensor 기반 디지털 트윈 복원
- [[physics-informed]] — 물리 정보 활용 가능성
- [[ruoyan-li]] — 제1저자
- [[yizhou-sun]] — 교신/선임 저자
