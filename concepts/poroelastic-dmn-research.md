---
title: "7×7 Acusto-Elastic DMN — 확장 연구 분석"
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [research-idea, dmn, poroelasticity, surrogate-model, acoustoelasticity]
sources: [raw/papers/1992_JAppliedPhysics_71_1138-1141.md, raw/papers/1-s2.0-S0020722518316872-main.md, raw/papers/LBiot_long.md, raw/papers/gurevich_schoemberg_Jjasa_99.md]
confidence: medium
---

# 7×7 Acusto-Elastic DMN — 확장 연구 분석

## 개요

표준 DMN은 3차원 탄성 문제를 6×6 Mandel notation으로 표현한다. 이 아이디어는 **7×7 행렬로 확장하여 포로탄성(Biot-type acousto-elasticity) 문제**를 DMN 프레임워크에서 다루는 것에 대한 분석.

## 7×7 System

포로탄성(Biot)의 constitutive equation:

```
[ σ_6×1 ]   =   [ C_6×6    -α_6×1 ] [ ε_6×1 ]
[ ζ_1×1 ]       [ α_1×6ᵀ    β_1×1 ] [ p_1×1 ]
```

- σ: bulk stress (6성분, Mandel)
- ε: bulk strain (6성분, Mandel)
- p: 간극 압력 (스칼라) ← 7번째 DOF
- ζ: 유체 함량 변화 (스칼라) ← 7번째 응답
- C: 배수(drained) 강성 (6×6)
- α: Biot-Willis 계수 벡터 (6×1)
- β: M 계수 관련 (스칼라, = 1/M)

## 핵심 발견: [[andrew-norris|Norris]] Correspondence

[[andrew-norris|Norris]] (1992, J. Appl. Phys.)는 포로탄성과 열탄성 사이의 **완전한 정적 대응 관계**를 증명:

| 포로탄성 | ↔ | 열탄성 |
|:---------|:--|:-------|
| p (간극 압력) | ↔ | θ (온도) |
| ζ (유체 함량) | ↔ | s (엔트로피) |
| α (Biot 계수) | ↔ | β (열팽창) |
| 1/M (저류 계수) | ↔ | c_σ (정압 비열) |

→ Shin(2024)의 thermomechanical DMN은 [[andrew-norris|Norris]] 정리에 의해 **준정적 포로탄성 DMN과 수학적으로 동일한 구조**를 가짐.

## 병목 분석 (Bottleneck Analysis)

### Bottleneck 1: "Phase 정의" ⬅ 최우선

포로탄성 RVE에서 DMN의 bottom node가 무엇을 나타내는가?

| 접근 | Phase 정의 | 장점 | 단점 |
|:----|:----------|:----|:----|
| **A** | 고체 골격 vs 간극 유체 | 기공 형상 직접 학습 | 극단적 stiffness contrast (고체 >> 유체) → 학습 어려움 |
| **B** | 서로 다른 다공성 매질 (예: 모래층 vs 셰일층) | moderate contrast, DMN에 적합 | RVE 내 기공 구조 자체는 학습 안 함 (이미 homogenized) |
| **C** | 층상 지층의 두 매질 (지구물리학 응용) | laminate 가정에 정확히 부합 | 적용 범위가 제한적 |

**권장:** B 또는 C에서 시작, A는 Phase 1의 단순화(유체를 soft elastic phase로 근사) 후 점진적 확장.

### Bottleneck 2: 준정적 vs 동적 ⬅ 근본적

| 측면 | 준정적 (Quasi-static) | 동적 (Dynamic) |
|:----|:--------------------|:--------------|
| 지배 방정식 | div σ = 0, div q = 0 | 지배방정식 + ρ·ü, ρ_f·ẅ |
| Building block | 정적 laminate homogenization | 주파수 의존적, DMN 패러다임과 부정합 |
| DMN 적용 | **Shin(2024)이 거의 직접적인 blueprint** | 새로운 이론적 프레임워크 필요 |
| 적용 범위 | Biot consolidation, 배수/비배수 천이 | 파동 전파, 감쇠, 음향 |

**권장:** 준정적 근사부터 시작. 동적 효과가 중요한 문제인지 사전 검토 필요.

### Bottleneck 3: Training Data 생성

| 방법 | 장점 | 단점 |
|:----|:----|:----|
| FFT homogenization (Monchiet 2015 외) | 빠름 | 표준 라이브러리 부족, 직접 구현 필요 |
| FEM (Abaqus, FreeFEM) | 검증된 코드 | FFT 대비 10~100배 느림 |
| Analytical (Backus averaging) | 정확함 | 복잡한 미세구조에 적용 불가 |

**권장:** 층상 구조(B)로 시작하면 **closed-form Backus averaging**으로 training data 생성 가능 → 병목 회피.

### Bottleneck 4: 회전 연산 확장

**사실상 병목 아님.** p는 스칼라이므로 회전 불변:

```
R_7×7 = [R_6×6   0_6×1]
        [0_1×6     1   ]
```

Shin(2024)의 thermoelastic DMN에서 θ(온도)를 다루는 방식과 동일.

### Bottleneck 5: 비선형 Extrapolation

| Training (선형) | Online Prediction (비선형) | 난이도 |
|:----------------|:--------------------------|:------:|
| Biot elastic | Poro-plasticity (고체 골격 항복) | ⭐⭐ |
| Darcy (k=const) | Forchheimer (비Darcian) / k(ε) 연성 | ⭐⭐⭐ |
| 포화 단상 | 부분 포화 / 2상 유동 | ⭐⭐⭐⭐ |

## 보충 이론 자료 (신규 Source Papers)

다음 3편의 논문이 `raw/papers/`에 추가되어 포로탄성 DMN 연구에 필요한 이론적 기반을 보강합니다:

### 다중 공극 포로탄성 계수 (Mehrabian 2018)
- **Source:** `raw/papers/1-s2.0-S0020722518316872-main.md`
- **핵심 기여:** 퍼텐셜 에너지 밀도 함수의 유일성(uniqueness) 원리를 이용하여 N-공극 포로탄성 재료의 물성 계수를 체계적으로 결정하는 방법 제시
- **DMN 연결:** 다중 공극(multiple-porosity) 재료는 DMN building block의 phase 정의(B 접근법: 서로 다른 다공성 매질)에 직접 적용 가능. 기존 이중-공극 이론(Berryman)이 N≥3에서 underdetermined였던 문제를 해결.
- **관련 계수:** Biot-Willis 계수 α_i, 저장 계수 s_{ij}, 체적 탄성률 K — N-porosity 시스템의 (N+1)(N+2)/2개 상수

### Biot 방정식 Interface 조건 (Gurevich & Schoenberg 1999)
- **Source:** `raw/papers/gurevich_schoemberg_Jjasa_99.md`
- **핵심 기여:** Biot 방정식으로부터 유도된 Deresiewicz-Skalak open-pore 조건이 유일하게 일관된 경계 조건임을 증명. 불완전 접촉(partial/impermeable interface)은 얇은 transition layer의 극한으로 모델링.
- **DMN 연결:** DMN building block 간 interface 조건은 배수(drained, open-pore) 또는 비배수(undrained, sealed)로 설정 가능. 이 논문은 두 조건 사이의 수학적 연속성을 보장하며, DMN 층간 hydraulic connectivity 모델링의 이론적 기반 제공.
- **관련 개념:** [[shifted-boundary-method|SBM]], [[gap-sbm|Gap-SBM]] — 경계 조건 처리의 대안적 접근

### 층상 이방성 포로탄성 매질 (Berryman)
- **Source:** `raw/papers/LBiot_long.md`
- **핵심 기여:** 직교 이방성(orthotropic) 포로탄성 층상 매질의 배수(drained) 및 비배수(undrained) boundary condition에서의 유효 물성 해석. 단순 해석적 결과가 없는 이방성 문제에 대한 일반적 프레임워크 제공.
- **DMN 연결:** DMN의 laminate homogenization과 직접 연결 — 층상 구조에서 drained/undrained 조건이 어떻게 유효 물성에 영향을 미치는지 이론적 이해 가능. 특히 DMN quilting 전략(Shin 2023)과의 결합이 유망.
- **Berryman & Milton 대응:** [[andrew-norris|Norris]] 대응 정리와 연결되어, 열탄성 결과로부터 포로탄성 계수를 직접 유도하는 Berryman-Milton 접근법의 이론적 배경 포함.

## Aero-elasticity와의 차이

| | Acusto-Elastic (Biot) | Aero-Elastic |
|:--|:---------------------|:-------------|
| Coupling 성질 | 국소적, 재료 내 | 비국소적, 형상-유동 시스템 |
| DMN building block 접근 | ✅ 가능 (7×7 또는 [[andrew-norris|Norris]] 경유) | ❌ 부적합 |
| 대안 접근 | DMN 확장 | FNO, DeepONet, PINN |

## 연구 로드맵 (제안)

### Phase 1: [[andrew-norris|Norris]] 경유 — 최소 진입 장벽
- Shin(2024) thermomechanical DMN 코드를 그대로 활용
- 열탄성 계수(θ, β, c_σ)를 포로탄성 계수(p, α, 1/M)로 대체
- 검증: 단순 배수/비배수 문제

### Phase 2: 7×7 직접 구현
- Building block의 homogenization을 Biot formalism으로 직접 유도
- 회전 + 균질화 + thermal→porous 변환 통합
- 다양한 기공 구조(microstructure) 학습

### Phase 3: 비선형 확장
- 포로-소성(고체 골격 항복)
- 변형-투과율 연성(k = k(ε))
- (선택) 부분 포화

## 관련
- [[waste-fiber-acoustic-absorber]]
 개념

- `poroelasticity-thermoelasticity-correspondence` — [[andrew-norris|Norris]] 1992: 포로-열탄성 대응 정리
- `thermoelastic-dmn` — Shin 2024: thermomechanical DMN
- `deep-material-network` — DMN 기본 아키텍처

## 참고 문헌

- [[andrew-norris|Norris]], A. (1992). "On the correspondence between poroelasticity and thermoelasticity." *J. Appl. Phys.*, 71, 1138.
- Shin, D. et al. (2024). "A deep material network approach for predicting the thermomechanical response of composites." *Composites Part B*, 272, 111177.
- Berryman, J. (1997). "Mechanics of layered anisotropic poroelastic media." *Stanford Exploration Project*.
- Liu, M. & Wu, J. (2019). "Exploring the 3D architectures of DMN." *J. Mech. Phys. Solids*.
- Mehrabian, A. (2018). "The poroelastic constants of multiple-porosity solids." *Int. J. Eng. Sci.*, 133, 23–35. — 에너지 밀도 기반 N-공극 포로탄성 계수 결정
- Gurevich, B. & Schoenberg, M. (1999). "Interface conditions for Biot's equations of poroelasticity." *J. Acoust. Soc. Am.*, 105(5), 2584–2592. — Biot 방정식의 경계 조건 유도
- Berryman, J. G. (2011). "Mechanics of layered anisotropic poroelastic media." *J. Appl. Phys.* — 층상 이방성 포로탄성 매질의 배수/비배수 경계 조건
