---
title: "Transfer Matrix Method (TMM) for Acoustic Porous Materials"
created: 2026-05-03
updated: 2026-05-03
type: concept
tags: [tmm, transfer-matrix-method, jca, acoustics, porous-materials, impedance-tube, iso-10534]
sources:
  [
    raw/papers/acoustipy-jakep72-2026.md,
  ]
confidence: high
---

# Transfer Matrix Method (TMM) for Acoustic Porous Materials

## 개요

Transfer Matrix Method (TMM)는 다층 다공성 흡음 구조의 **표면 임피던스 → 흡음계수 α(f)** 를 계산하는 표준 방법. Allard & Atalla (2009)의 *Propagation of Sound in Porous Media*가 바이블.

TMM의 입력은 JCA (Johnson-Champoux-Allard) 5-parameter이고, 출력은 주파수별 α(f) 곡선.

## TMM 파이프라인

```
JCA 5-param (σ, φ, τ, Λ, Λ')
    ↓ (analytic formula)
Dynamic density ρ̃(ω) + Dynamic bulk modulus K̃(ω)    [Champoux & Allard 1991]
    ↓
Characteristic impedance Zc = √(ρ̃·K̃)
Complex wavenumber kc = ω·√(ρ̃/K̃)
    ↓
Layer Transfer Matrix T(d)                            [Allard & Atalla 2009, Ch.4]
    ↓ (multi-layer cascade: T_total = T₁·T₂·T₃·...)
Surface impedance Zs = T_total[0,0] / T_total[1,0]
    ↓
α(f) = 1 - |(Zs - ρ₀c₀)/(Zs + ρ₀c₀)|²               [ISO 10534-2]
```

## JCA 5-parameter

| 파라미터 | 기호 | 단위 | 물리적 의미 |
|:--------|:---:|:----:|:----------|
| Static airflow resistivity | σ | Pa·s/m² | 공기 흐름 저항 |
| Open porosity | φ | — | 열린 공극률 |
| Tortuosity | τ | — | 굴곡도 (고주파) |
| Viscous characteristic length | Λ | μm | 점성 손실 특성 길이 |
| Thermal characteristic length | Λ' | μm | 열 손실 특성 길이 |

## Layer Transfer Matrix (Equivalent Fluid Model)

단일 등가유체 층의 전달행렬:

```
T(d) = [[cos(kc·d),      j·Zc·sin(kc·d)],
        [j·sin(kc·d)/Zc,  cos(kc·d)     ]]
```

경계조건: 강체 벽 (rigid backing) → Z(D) = -j·Zc·cot(kc·D)

## Biot-TMM (Elastic Frame)

Equivalent fluid model은 **rigid frame 가정** (골격 움직임 무시). 섬유재료(fibrous materials)의 경우 유효하지만, 고무/폼 등 elastic frame 재료는 Biot theory 필요.

Biot-TMM의 경우 **6×6 or 4×4 전달행렬** 사용 (solid displacement + fluid pressure 두 개의 wave type). Allard & Atalla (2009) Ch.6 참조.

## 측정 표준

| 표준 | 내용 |
|:----|:----|
| **ISO 10534-2** | 임피던스 관: Transfer-function method |
| **ASTM E1050** | ISO 10534-2 상응 |
| **ASTM E2611** | Transmission loss 측정 |

## 오픈소스 구현

| 패키지 | 언어 | 라이선스 | 특징 |
|:------|:---:|:-------:|:----|
| **acoustipy** | Python | MIT | JCA/JCAL/MPP + inverse optimization |
| **acoucalc** | Python | ? | 기본 TMM |
| **APMR (Matelys)** | Matlab/Python | CC-BY | 참조 구현, JCAL 전체 지원 |
| **COMSOL Multiphysics** | 상용 | — | JCA built-in, Poroelastic Waves physics |
| **GeoDict** | 상용 | — | Acoustic 전용, 디지털 재료 연구실 |

## DMN 프로젝트와의 연결

TMM은 DMN 출력과 α(f) 사이의 **필수 연결 도구**:

1. DMN (thermomechanical, Shin 2024) → Norris correspondence → 7×7 poroelastic stiffness
2. 7×7 stiffness → JCA 5-param homogenization (G2에서 다룸)
3. JCA 5-param → TMM → α(f)

**acoustipy 포팅 (JAX differentiable)이 필요.** 현재 numpy 기반 → jax.numpy로 변환하면 end-to-end gradient 계산 가능.

## 참고 문헌

- Allard, J.F. & Atalla, N. (2009). *Propagation of Sound in Porous Media: Modelling Sound Absorbing Materials*, 2nd ed. Wiley.
- Johnson, D.L., Koplik, J. & Dashen, R. (1987). Theory of dynamic permeability. *J. Fluid Mech.*, 176, 379-402.
- Champoux, Y. & Allard, J.F. (1991). Dynamic tortuosity and bulk modulus. *J. Appl. Phys.*, 70(4), 1975-1979.
- ISO 10534-2:1998. Acoustics — Determination of sound absorption coefficient and impedance in impedance tubes — Part 2: Transfer-function method.
- acoustipy (2026). https://github.com/jakep72/acoustipy

## 관련 위키 페이지

- [[acoustipy]] — acoustipy 오픈소스 패키지 상세
- [[waste-fiber-acoustic-absorber]] — DMN 기반 저주파 흡음재 설계
- [[poroelastic-dmn-research]] — 7×7 Acusto-Elastic DMN
- [[porous-nonwoven-homogenization]] — 다공성 부직포 균질화
- [[ml-acoustic-metamaterials-review]] — ML 음향 메타물질 리뷰
- [[jca-inverse-parameter-estimation]] — JCA 역추정 (G2)
