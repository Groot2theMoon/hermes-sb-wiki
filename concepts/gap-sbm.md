---
title: Gap-SBM — Shifted Boundary Method Variant
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [foundation, pure-mechanics, FEM-pure, boundary-method, mathematics]
sources: [raw/papers/1-s2.0-S0045782526000678-main.md]
confidence: high
---

# Gap-SBM: 개선된 Shifted Boundary Method

## 개요

**Collins, Li, Lozinski, [[guglielmo-scovazzi|Scovazzi]]** ([[duke-university|Duke University]] / [[penn-state-university|Penn State]] / Université Marie et Louis Pasteur, CMAME 2025)가 제안한 **Gap-SBM**은 기존 Shifted Boundary Method(SBM)의 새로운 개념화로, Neumann 및 Dirichlet 문제 모두에서 **최적 수렴성**을 달성한다^[raw/papers/1-s2.0-S0045782526000678-main.md].

## 배경: SBM의 한계

기존 SBM은 cut cell 문제를 피하기 위해 경계 조건을 근사 경계(surrogate boundary)로 **shift**하는 방법이다. P1 (piecewise-linear) 공간에서 Neumann 조건을 shift하면 Taylor 전개의 Hessian 항이 사라져 **L² 노름에서 1차 수렴 손실**이 발생한다. Atallah et al. (2020)은 mixed formulation으로 이를 해결했지만, 계산 비용이 증가했다.

| 방법 | L² 수렴 차수 | H¹ 수렴 차수 | 추가 계산 |
|------|:----------:|:----------:|:--------:|
| 표준 SBM (shift only) | **O(h¹)** (suboptimal) | O(h¹) | 없음 |
| Mixed SBM | **O(h²)** (optimal) | O(h¹) | 경계층 mixed DOF |
| **Gap-SBM** | **O(h²)** (optimal) | O(h¹) | gap quadrature만 |
| cutFEM | O(h²) | O(h¹) | cut cell + ghost penalty |
| Body-fitted FEM | O(h²) | O(h¹) | conforming mesh 필요 |

## 핵심 아이디어

Gap-SBM의 세 가지 단계:

1. **Gap 형상 근사:** Surrogate 경계 $\tilde{\Gamma}_h$와 실제 경계 $\Gamma$ 사이의 거리 맵(distance map) $\mathbf{d}_M$을 사용하여 gap 영역 $\Omega \setminus \tilde{\Omega}_h$의 기하학적 근사 구성
2. **해 확장:** Surrogate 영역 $\tilde{\Omega}_h$에서 정의된 수치 해 $u_h$와 시험 함수 $w_h$를 gap 영역으로 Taylor 전개를 통해 확장 → 확장 요소 $\tilde{T}_e^{\text{ext}}$ (2D: 삼각형→사각형, 3D: 사면체→삼각기둥)
3. **변분 적분:** 확장된 요소에서 DG (Discontinuous Galerkin) 방식의 jump/평균 처리를 통해 변분 공식 적분, 모든 적분을 surrogate 경계 **$\tilde{\Gamma}_h$ 위에서만** 수행 (cut cell 불필요)

## 수학적 구성

Poisson 문제에 대해, Gap-SBM의 변분 공식은 interior penalty DG 이산화 형태를 취한다:

$$(\nabla w_h, \nabla u_h)_{\tilde{\Omega}_h} + (\nabla w_h, \nabla u_h)_{\tilde{T}_h^{\text{ext}}} - \langle w_h, h_N \rangle_{\Gamma_{N,h}} - \langle \llbracket w_h \rrbracket, \llbracket \nabla u_h \rrbracket \rangle_{\mathcal{E}^{\text{ext},\circ}} - \langle w_h, \nabla u_h \cdot n \rangle_{\Gamma_{D,h}} + \text{(penalty terms)} = (w_h, f)_{\tilde{\Omega}_h} + (w_h, f)_{\tilde{T}_h^{\text{ext}}}$$

핵심은 gap 영역 적분을 surrogate 경계 적분으로 **재조정(rescaling)**하는 것:

$$(\nabla w_h, \nabla u_h)_{\tilde{T}_h^{\text{ext}}} \approx \sum_{\tilde{e} \in \tilde{\mathcal{F}}_h} \langle \nabla w_h, \nabla u_h H_{\tilde{e}} \rangle_{\tilde{e}}, \quad H_{\tilde{e}} = \frac{|\tilde{T}_e^{\text{ext}}|}{|\tilde{e}|}$$

이때 $H_{\tilde{e}}$는 gap의 두께 정보를 포함하는 scaling factor이다.

## 검증 결과

- 2D 및 3D (사면체 및 Cartesian 격자)에서 Poisson 문제와 선형 탄성 문제 모두 **최적 수렴** 확인
- L² 노름에서 O(h²), H¹ 반노름에서 O(h¹) 달성
- Mixed formulation 없이 primal formulation만으로 **처음으로** 최적 L² 수렴성 증명
- 대칭(symmetric, θ=1, γ>0) 및 비대칭(skew-symmetric, θ=-1, γ=0) 변종 모두 이론적 분석 완료

## 융합 도메인 연결

- **AI 기반 mesh-free solver**의 경계 조건 처리 기법으로 활용 가능
- [[shifted-boundary-method]]의 직접적 후속 연구
- P1 요소를 넘어 **고차 이산화**로 확장 가능 (논문 Section 3.3 참조)
- [[hpinns-inverse-design]]의 hard constraint 방식과 비교 가능
- Gap-SBM의 mesh-free 장점은 [[physics-informed]] 기반 solver와의 결합에 유리

## References
- Collins, Li, Lozinski, Scovazzi. "Gap-SBM: A new conceptualization of the shifted boundary method with optimal convergence for the Neumann and Dirichlet problems." *Computer Methods in Applied Mechanics and Engineering*, 2025.
- [[shifted-boundary-method]]
- [[hpinns-inverse-design]]
