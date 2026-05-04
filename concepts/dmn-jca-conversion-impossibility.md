---
title: "DMN 7×7 ↔ JCA 5-Parameter 변환 불가능성과 병렬 파이프라인 설계"
created: 2026-05-04
updated: 2026-05-04
type: concept
tags: [dmn, jca, poroelasticity, biot-theory, norris-correspondence, rigid-frame, equivalent-fluid, parallel-pipeline, gap-sbm]
sources:
  [
    raw/papers/norris1992-poroelastic-thermoelastic.md,
    raw/papers/allard-atalla2009-porous-media.md,
    raw/papers/wei25-dmn-overview.md,
  ]
confidence: high
---

# DMN 7×7 ↔ JCA 5-Parameter 변환 불가능성과 병렬 파이프라인

## 개요

DMN 7×7 poroelastic stiffness tensor (C⁶ˣ⁶, α, M)와 JCA 5-parameter (σ, φ, τ, Λ, Λ')는 완전히 다른 물리 영역을 기술한다. 대수적 변환은 **구조적으로 불가능**하며, 유일한 해결책은 동일 미세구조에서 **병렬 계산**하는 파이프라인이다.

## 변환 불가능성의 6가지 근거

### 1. 서로 다른 물리 영역

DMN 7×7은 **Biot 포로탄성 구성법칙** (고체+유체 결합)을 인코딩. JCA는 **등가유체 모델** (강체골격 내 유체만의 음향). Allard & Atalla (2009)는 Biot 전파 모델의 고체 변위가 0일 때 등가유체 모델이 유도됨을 정리 [1].

```                                         
Biot full (u_s + u_f, 10-parameter)         
    ↓ u_s = 0 (강체골격 가정)               
JCA equivalent fluid (u_f only, 5-param)    
    ↓ TMM                                    
α(f)                                        
```

### 2. 강체골격 가정이 소거하는 정보

JCA는 **u_solid = 0** 가정. 이는 7×7 텐서의 고체 강성 부분(C⁶ˣ⁶ drained stiffness) 전체를 무의미하게 만든다. COMSOL Poroacoustics 문서: "poroacoustics fluid model = equivalent fluid model assuming u=0, yielding complex density and bulk modulus" [2].

역으로, 7×7 텐서는 JCA가 기술하는 점성/열 소산의 주파수 의존성을 전혀 인코딩하지 않음.

### 3. 정적 vs 동적

| 텐서/파라미터 | 성질 | 주파수 의존성 | 물리적 의미                |
|:-------------|:---:|:-----------:|:-------------------------|
| C⁶ˣ⁶ (drained stiffness) | 정적 | 없음 | 골격 강성               |
| α (Biot-Willis) | 정적 | 없음 | 응력 분할                |
| M (Biot modulus) | 정적 | 없음 | 유체 저장                |
| σ (flow resistivity) | 동적 | ✅ | 점성 저항                |
| τ (tortuosity) | 동적 | ✅ (고주파) | 굴곡 경로               |
| Λ, Λ' (char. lengths) | 동적 | ✅ | 점성/열 경계층           |

### 4. 비교 불가능한 기하학적 척도

Biot-Willis 계수 **α = 1 − K/K_g**는 배수 vs 입자 체적탄성률 비로 응력 분할 측정 [3].

JCA 특성 길이:
- **Λ** ≈ 2 × (pore volume) / (wetted area, flow-weighted) — 점성 경계층
- **Λ'** ≈ 2 × (pore volume) / (total surface area) — 열 경계층

α를 알아도 Λ를 결정할 수 없고, 역도 성립하지 않음.

### 5. Norris Correspondence는 정적 매핑일 뿐

Norris (1992, J. Appl. Phys.)는 포로탄성과 **열탄성** 사이의 정적 대응 관계 증명 [4]:

```
pore pressure p  ↔  temperature θ
fluid content ζ  ↔  entropy s
Biot modulus 1/M ↔  heat capacity c_σ
α/(3K)          ↔  thermal expansion β
```

이 매핑은 포로탄성 간의 관계. 등가유체 음향 모델과 무관.

### 6. 다대다 매핑 (Many-to-Many)

동일한 7×7 텐서를 생성하는 무수히 많은 미세구조가 존재하며, 이들은 완전히 다른 JCA 파라미터를 가질 수 있음. 역도 성립. 전단사(bijection) 불가능 → 대수적 변환 원천적 불가.

## 병렬 파이프라인 설계 (유일한 해결책)

직접 변환이 불가능하므로 동일 미세구조에서 **병렬 분기**:

```
                         ┌→ DMN training (FFT) → C⁶×⁶, α, M (Biot)
                         │      ↓ Norris correspondence
Microstructure (φ, d_f) ─┤      Thermoelastic DMN → E, ν (구조 해석)
  (GAP-SBM → features)   │
                         └→ Empirical formulas → JCA 5-param → TMM → α(f)
                              (Garai-Pompoli, Bruggeman, Allard)
```

두 경로는 미세구조에서 분기되어 각자의 물리 영역을 독립적으로 계산하며, 최종 **공동 최적화**에서 만남:
- "α(60Hz) ≥ 0.8 **&** E ≥ 1MPa" → 최적 미세구조(φ, d_f, 배향)

## GAP-SBM의 역할

GAP-SBM은 micro-CT에서 추출한 정량적 미세구조 특징을 두 경로에 공급:
- DMN 경로: 3D voxel geometry → FFT homogenization training data
- JCA 경로: φ, d_f, fiber orientation distribution → empirical formulas

**Novelty:** 미세구조 특징을 미분 가능하게 추출하면 두 경로 모두 미분 가능하게 연결 → end-to-end gradient 기반 최적화.

## Phase별 권장 로드맵

| Phase | 내용 | 난이도 | 기간 |
|:------|:-----|:-----:|:----:|
| 즉시 | GAP-SBM → 경험식 → JCA → TMM (rigid frame) | 낮음 | 1-2주 |
| Phase 2 | GAP-SBM → DMN (7×7) + 경험식 → JCA 병렬 | 중간 | 2-4주 |
| Phase 3 | Joint optimization (α(f) + stiffness) | 높음 | 4-8주 |

## 관련 위키 페이지

- [[poroelastic-dmn-research]] — 7×7 Acusto-Elastic DMN 확장 연구
- [[jca-inverse-parameter-estimation]] — JCA 역추정 (G2)
- [[transfer-matrix-method-acoustic-porous]] — TMM 개념 (G1)
- [[microstructure-to-jca-empirical-formulas]] — 미세구조→JCA 경험식
- [[dmn-overview-wei25]] — DMN survey (Wei et al. 2025)

## 참고 문헌

[1] Allard, J.F. & Atalla, N. (2009). *Propagation of Sound in Porous Media*, 2nd ed. Wiley. Ch. 5-6.

[2] COMSOL (2025). About the Poroacoustics Models. *COMSOL Multiphysics 6.3.*

[3] Biot-Willis coefficient measurement. McGill University. https://www.mcgill.ca/civil/files/civil/338.pdf

[4] Norris, A.N. (1992). On the correspondence between poroelasticity and thermoelasticity. *J. Applied Physics*, 71(3), 1138–1141. DOI: 10.1063/1.351278

[5] Wei, T.J. et al. (2025). Deep Material Network: Overview, applications and current directions. arXiv:2504.12159.
