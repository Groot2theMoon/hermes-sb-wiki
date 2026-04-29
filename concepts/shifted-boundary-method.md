---
title: Shifted Boundary Method (SBM)
created: 2026-04-28
updated: 2026-04-29
type: concept
tags: [FEM, mathematics, mechanics, paper]
sources: [raw/papers/1-s2.0-S0021999117307799-am.md, raw/papers/1-s2.0-S0045782522001797-main.md]
confidence: high
---

# Shifted Boundary Method (SBM)

## 개요

**Shifted Boundary Method (SBM)**는 Main & [[guglielmo-scovazzi|Scovazzi]] ([[duke-university|Duke University]], 2017)가 제안한 **embedded finite element method**로, **true boundary 대신 surrogate boundary에서 경계 조건을 shifted 형태로 적용**하여 small cut-cell 문제를 해결한다^[raw/papers/1-s2.0-S0021999117307799-am.md].

## 배경: Embedded Method의 문제점

### Small Cut-Cell Problem
- Embedded/immersed boundary 방법에서 **경계가 요소를 아주 작게 자르면** Nitsche penalty parameter가 $\\propto 1/h^\\perp$ 로 발산
- Condition number 악화, 수치 불안정 초래
- 기존 해결책: ghost penalty (4차 연산자, stencil 증가), XFEM (복잡한 적분), extended B-splines

### Approximate Boundary 방법
- Surrogate boundary (잘린 요소 제외, 온전한 요소만 사용)로 대체
- 문제: 단순 경계 이동 시 **$O(h)$ 오차** 발생

## 제안: Shifted Boundary Method

### 핵심 아이디어
- Surrogate boundary $\\tilde{\\Gamma}$ 에서 **Taylor expansion으로 보정된 경계 조건** 적용
- Map $M: \\tilde{\\Gamma} \\to \\Gamma$, distance vector $d = x - \\tilde{x}$
- Dirichlet 조건: $u(\\tilde{x}) + \\nabla u(\\tilde{x}) \\cdot d = u_D(M(\\tilde{x})) + O(\\|d\\|^2)$

### Nitsche Weak Form (Surrogate Domain)
$$(\\nabla w^h, \\nabla u^h)_{\\tilde{\\Omega}} - \\langle w^h, \\nabla u^h \\cdot \\tilde{n} \\rangle_{\\tilde{\\Gamma}_D} - \\langle \\nabla w^h \\cdot \\tilde{n}, u^h + \\nabla u^h \\cdot d - \\bar{u}_D \\rangle_{\\tilde{\\Gamma}_D} + \\text{stabilization terms}$$

- **Unsymmetric form**: 추가 항 포함 (안정성 + 2차 consistency)
- **Symmetric form**: tangential stabilization 제거 가능

### 장점
- **Small cut-cell 문제 완전 회피**: surrogate boundary는 온전한 요소 경계
- **$O(h^2)$ 수렴률**: Taylor 보정으로 2차 정확도 달성
- **단순한 구현**: cut element 기하 연산 불필요
- **복잡한 형상에 robust**: 다양한 형상에서 optimal convergence 유지

## 적용

### Poisson Problem
- Stability + convergence complete analysis 제시
- Dirichlet/Neumann 조건 모두 처리 가능

### Stokes Problem
- Inf-sup condition 만족하는 요소 사용
- **복잡한 형상에서도 optimal convergence** 확인

- [[gap-sbm]] — 개선된 SBM (Gap-SBM)

### High-Order SBM (Atallah, Canuto, Scovazzi 2023)

- **Source:** `raw/papers/1-s2.0-S0045782522001797-main.md`
- Duke University 연구진이 제안한 **고차(high-order) SBM** 확장
- Spectral/hp 요소 기반 고차 근사에서도 **Taylor 보정의 일관성** 유지
- **지수 수렴(exponential convergence)** 달성 — smooth 해에 대해 $O(h^p)$가 아닌 $O(e^{-cN})$ 수렴

| 버전 | 수렴률 | 메모 | 
|:----|:-----:|:----|
| Classical SBM (2017) | $O(h^2)$ | 2차 정확도 |
| High-Order SBM (2023) | $O(h^p)$ / 지수 | p-version, hp-version |

- 다음 단계: GAP-SBM의 고차 확장? — `[[gap-sbm]]` 참조

## References
- A. Main, G. Scovazzi. "The Shifted Boundary Method for Embedded Domain Computations. Part I: Poisson and Stokes Problems", *J. Comput. Phys.* 2017
- FEM, embedded boundary method, Nitsche method