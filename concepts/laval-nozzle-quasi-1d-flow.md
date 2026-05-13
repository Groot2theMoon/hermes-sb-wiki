---
title: Laval Nozzle — Quasi-1D Isentropic Flow
created: 2026-05-13
updated: 2026-05-13
type: concept
tags: [fluid-dynamics, thermodynamics, mechanics, pure-mechanics, exercise]
sources: [raw/papers/gd1-tutorial-2-laval-nozzle.md]
confidence: high
---

# Laval Nozzle — Quasi-1D Isentropic Flow (Convergent-Divergent Nozzle)

## 개요

Laval nozzle (convergent-divergent nozzle)는 유동을 **초음속(supersonic)**으로 가속시키는 장치로, 가스터빈, 로켓 추진기관, 풍동 등에 사용된다. 수축부(subsonic) → 목(throat, M=1) → 확대부(supersonic)의 기하학적 구조를 가지며, quasi-1D 등엔트로피 관계식으로 해석 가능하다.

본 문서는 **GD1 (Gas Dynamics 1)** Tutorial 2의 MATLAB 실습 내용을 기반으로 한다.

## 핵심 관계식

### 등엔트로피 관계 (Stagnation → Static)

등엔트로피 유동에서 Mach 수 M에 대한 압력비, 밀도비, 온도비:

$$ \frac{p}{p_0} = \left(1 + \frac{\gamma-1}{2}M^2\right)^{-\gamma/(\gamma-1)} $$

$$ \frac{\rho}{\rho_0} = \left(1 + \frac{\gamma-1}{2}M^2\right)^{-1/(\gamma-1)} $$

$$ \frac{T}{T_0} = \left(1 + \frac{\gamma-1}{2}M^2\right)^{-1} $$

여기서 p₀, ρ₀, T₀는 **stagnation (total)** 조건, γ = c_p/c_v.

### 면적-Mach 수 관계 (Area-Mach Number Relation)

$$ \frac{A}{A^*} = \frac{1}{M}\left[\frac{2}{\gamma+1}\left(1+\frac{\gamma-1}{2}M^2\right)\right]^{\frac{\gamma+1}{2(\gamma-1)}} $$

- A*: **throat area** (M=1 지점 = sonic condition)
- **subsonic branch:** A/A* > 1에서 M < 1 (수축부)
- **supersonic branch:** A/A* > 1에서 M > 1 (확대부)
- **throat:** A/A* = 1에서 M = 1 (유일하게 sonic)

### 면적-압력비 관계

$$ \left(\frac{A}{A^*}\right)^2 = \frac{1}{\left(\frac{p}{p_0}\right)^{2/\gamma}}\frac{\gamma-1}{\gamma+1}\left[1 - \left(\frac{p}{p_0}\right)^{(\gamma-1)/\gamma}\right] $$

면적-Mach 관계와 등엔트로피 압력 관계를 결합하여 유도됨.

## MATLAB Tutorial 2 — Laval Nozzle 실습

### Part 1: 등엔트로피 관계식 함수화

Tutorial 1에서 정의한 함수들을 확장하여 다음 함수들을 작성:

| 함수 | 입력 | 출력 | 수식 |
|------|------|------|------|
| `M = MofP(p_p0, gamma)` | 압력비, γ | Mach 수 | 등엔트로피 관계식 역산 |
| `rho_rho0 = rhoOfM(M, gamma)` | M, γ | 밀도비 | ρ/ρ₀ |
| `p_p0 = pOfM(M, gamma)` | M, γ | 압력비 | p/p₀ |
| `Astar_A = Astar_AofP(p_p0, gamma)` | 압력비, γ | 면적비 A*/A | |

**핵심 계산:** M=1에서의 ρ*/ρ₀, p*/p₀ 값 산출:
- ρ*/ρ₀ = (2/(γ+1))^(1/(γ-1))
- p*/p₀ = (2/(γ+1))^(γ/(γ-1))
- γ=1.4(공기): p*/p₀ ≈ 0.528, ρ*/ρ₀ ≈ 0.634

### Part 2: Laval Nozzle 유동 해석

**노즐 형상:**

$$ r(x) = 0.5\cos(2\pi x) + 1 + r_{min} - 0.1(x - 0.5)^2, \quad 0 \leq x \leq 1 $$

- r_min = 0.4 (목에서의 최소 반경)
- 원형 단면(circular cross-section) 가정 → A(x) = πr(x)²
- **Sonic area** A* = throat area (A_min)

**풀이 과정:**

1. **Subsonic solution** (수축부 전체 + 확대부 초기): calcPMofA 함수에 `subsonic=true`
2. **Supersonic solution** (확대부 후반): calcPMofA 함수에 `subsonic=false`
3. **Fully subsonic solution**: A* < A_min으로 설정하여 전 영역에서 A/A* > 1 → 전 영역 M < 1

### 주요 결과

| 위치 | Subsonic M | Supersonic M | p/p₀ (subsonic) | p/p₀ (supersonic) |
|------|-----------|-------------|----------------|------------------|
| 입구 (x=0) | < 1 | < 1 | > 0.528 | > 0.528 |
| 목 (x=0.5) | = 1 | = 1 | = p*/p₀ ≈ 0.528 | = p*/p₀ ≈ 0.528 |
| 출구 (x=1) | < 1 | > 1 | > 0.528 | < 0.528 |

## 물리적 의미

1. **Choking 현상:** 목에서 M=1 (= sonic)에 도달하면 **질식(choking)** 상태가 되어 더 이상 유량이 증가하지 않음. 이 상태에서 A* = A_throat이 성립.
2. **등엔트로피 가정의 한계:** 실제로는 확대부에서 충격파(shock wave)가 발생하여 isentropic이 깨짐. 비가역적 과정 → 압력 회복 불가.
3. **Back pressure의 역할:** 출구 압력(p_exit)과 배압(back pressure, p_b)의 관계가 노즐 내 유동 패턴(완전 팽창, 과소 팽창, 과대 팽창, 충격파 형성)을 결정함.

## References

- [[isentropic-relations]] — 등엔트로피 관계식 유도 및 Tutorial 1
- [[compressible-flow-governing-equations]] — 압축성 유동 지배방정식
- [[stagnation-properties]] — 정체점 조건

## MATLAB 팁

- `yyaxis left` / `yyaxis right` — 하나의 figure에 다른 scale의 y축 표시
- `subplot(3,1,N)` — 여러 subplot을 수직 배열로 표시
- `disp(['text ' num2str(value)])` — 변수값 출력
- 제공 함수 `calcPMofA`는 `MofP` 함수를 내부 호출하므로, Part 1의 함수가 동일 디렉토리에 있어야 함
