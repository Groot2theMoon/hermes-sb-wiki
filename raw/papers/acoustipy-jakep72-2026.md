---
title: "acoustipy — Acoustic Transfer Matrix Method Python Package"
created: 2026-05-03
updated: 2026-05-03
type: raw
tags: [tmm, transfer-matrix-method, jca, acoustics, porous-materials, open-source, python]
confidence: high
---

# acoustipy — Acoustic TMM Python Package

- **GitHub:** https://github.com/jakep72/acoustipy (⭐ 9, MIT License)
- **PyPI:** `pip install acoustipy`
- **Documentation:** https://jakep72.github.io/acoustipy/
- **Author:** jakep72
- **License:** MIT

## 개요

acoustipy는 Allard & Atalla (2009)의 Transfer Matrix Method(TMM)를 Python으로 구현한 오픈소스 패키지. Johnson-Champoux-Allard (JCA) 모델을 기반으로 다층 다공성 흡음 구조의 흡음계수 α(f)를 계산. 순방향 예측(forward)과 역방향 물성 추정(inverse optimization) 모두 지원.

## 주요 기능

1. **JCA Model** — 5-parameter (σ, φ, τ, Λ, Λ') → dynamic density ρ̃(ω), bulk modulus K̃(ω)
2. **JCAL Model** — Lafarge 확장 (static thermal permeability k₀' 추가)
3. **JCAPL Model** — Pride-Lafarge 확장 (저주파 정밀도 향상)
4. **Multi-layer TMM** — 임의의 층 구성 cascade
5. **Inverse/Indirect/Hybrid Optimization** — impedance tube 측정값 → JCA parameter 역추정
6. **Microperforate panel (MPP)** 지원

## TMM 수식 (acoustipy 구현 기준)

**Dynamic density:**
ρ̃ = ρ₀·α̃(ω)/φ
α̃(ω) = τ[1 + F̃(ω)/(j·ω̄)]
F̃(ω) = 1 - P + P·√(1 + M·j·ω̄/(2P²))
ω̄ = ω·ρ₀·τ/(σ·φ)
M = 8·η·τ/(σ·φ·Λ²)

**Dynamic bulk modulus:**
K̃ = γ·P₀/(φ·β̃(ω))
β̃(ω) = γ - (γ-1)[1 + F̃'(ω)/(j·ω̄')]⁻¹
ω̄' = ω·ρ₀·Pr·Λ'²/(8·η)

**Layer transfer matrix:**
T(d) = [[cos(kc·d),  j·Zc·sin(kc·d)],
        [j·sin(kc·d)/Zc,  cos(kc·d)]]
Zc = √(ρ̃·K̃),  kc = ω·√(ρ̃/K̃)

**Surface impedance → α(f):**
Zs = T_total[0,0] / T_total[1,0]
α(f) = 1 - |(Zs - ρ₀c₀)/(Zs + ρ₀c₀)|²

## 참고 문헌

- Allard, J.F. & Atalla, N. (2009). *Propagation of Sound in Porous Media*, 2nd ed. Wiley.
- Johnson, D.L., Koplik, J. & Dashen, R. (1987). Theory of dynamic permeability and tortuosity in fluid-saturated porous media. *J. Fluid Mech.*, 176, 379-402.
- Champoux, Y. & Allard, J.F. (1991). Dynamic tortuosity and bulk modulus in air-saturated porous media. *J. Appl. Phys.*, 70(4), 1975-1979.
- Atalla, Y. & Panneton, R. (2005). Inverse acoustical characterization of open cell porous media. *Canadian Acoustics*, 33(3).

## DMN 프로젝트와의 연결

acoustipy의 JCA + TMM 코어는 DMN 출력(7×7 poroelastic stiffness tensor) → α(f) 변환의 **backbone**으로 사용 가능. 현재는 numpy 기반이므로 JAX differentiable 포팅이 필요.
