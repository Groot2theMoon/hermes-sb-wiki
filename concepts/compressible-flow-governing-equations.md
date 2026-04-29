---
title: Compressible Flow Governing Equations — Gas Dynamics 1
created: 2026-04-29
updated: 2026-04-29
type: concept
tags: [fluid-dynamics, thermodynamics, foundation, pure-mechanics]
sources: [raw/papers/gasdynamic-lecture-2-governing-equations.md, raw/papers/gasdynamic-thermodynamics-review.md]
confidence: high
---

# Compressible Flow Governing Equations

## 개요

압축성 유동(compressible flow)은 7개의 미지수(ρ, p, U⃗ = (u, v, w), ε, T)를 가지며, 이들을 결정하기 위해 7개의 방정식이 필요하다. 1D의 경우 속도 벡터가 u 하나로 줄어 5개의 방정식으로 충분하다.

## 7-Equation System

| # | Equation | Role |
|---|----------|------|
| 1 | Conservation of mass (continuity) | Mass balance |
| 3 | Conservation of momentum (x, y, z) | Newton's 2nd law |
| 1 | Conservation of energy | 1st law of thermodynamics |
| 2 | Equations of state (thermal + caloric) | Material properties |

## Conservation of Mass (Continuity)

**Conservative form:**
$$ \frac{\partial\rho}{\partial t} + \nabla\cdot(\rho\vec{U}) = 0 $$

**Non-conservative form:**
$$ \frac{D\rho}{Dt} + \rho\nabla\cdot\vec{U} = 0 $$

**Index notation (Einstein convention):**
$$ \frac{\partial\rho}{\partial t} + \frac{\partial(\rho U_i)}{\partial x_i} = 0 $$

- Conservative form guarantees mass conservation numerically (telescoping sum property)
- Non-conservative form does NOT — mass can be artificially created/destroyed in numerical schemes

## Conservation of Momentum

**Conservative form (full, with viscous stress):**
$$ \frac{\partial(\rho U_i)}{\partial t} + \frac{\partial(\rho U_i U_j + p\delta_{ij} - \tau_{ij})}{\partial x_j} = 0 $$

**Non-conservative form:**
$$ \rho\frac{D\vec{U}}{Dt} = -\nabla p + \nabla\cdot\tau + \rho\vec{g} $$

### Euler Equations (Inviscid, No Body Forces)

In Gas Dynamics 1, we assume inviscid flow (τ = 0) and neglect body forces:

$$ \rho\frac{D\vec{U}}{Dt} = -\nabla p $$
$$ \text{(1D: } \rho\frac{du}{dt} = -\frac{dp}{dx} \text{)} $$

## Conservation of Energy

From the 1st law of thermodynamics, balancing rate of change of total energy (internal + kinetic + potential) with heat addition and work done:

$$ \frac{\partial}{\partial t}\left[\rho\left(e + \frac{\vec{U}^2}{2} + gz\right)\right] + \nabla\cdot\left[\rho\left(e + \frac{\vec{U}^2}{2} + gz\right)\vec{U}\right] = \dot{q}\rho - \nabla\cdot(p\vec{U}) + \rho\vec{f}\cdot\vec{U} + \dot{Q}'_{viscous} + \dot{W}'_{viscous} $$

For **steady, inviscid, adiabatic, no body forces, ignore potential energy:**
$$ \nabla\cdot\left[\rho\left(e + \frac{\vec{U}^2}{2}\right)\vec{U}\right] = -\nabla\cdot(p\vec{U}) $$

Using enthalpy h = e + p/ρ:
$$ h + \frac{\vec{U}^2}{2} = \text{const} $$
$$ h_1 + \frac{u_1^2}{2} + q = h_2 + \frac{u_2^2}{2} \quad \text{(1D with heat addition)} $$

## Reynolds Transport Theorem (RTT)

For any extensive property B with intensive counterpart b = B/m:

$$ \frac{dB}{\partial t} = \frac{\partial}{\partial t}\int_V \rho b\,dV + \int_A \rho b(\vec{U}\cdot\vec{n})\,dA $$

| Property | B (extensive) | b (intensive) |
|----------|---------------|---------------|
| Mass | m | 1 |
| Momentum | mU⃗ | U⃗ |
| Energy | E | e + U²/2 + gz |

RTT provides a unified framework to derive all three conservation laws by setting appropriate B and b.

## References

- [[knudsen-number-and-continuum]] — validity of continuum assumption
- [[compressibility-and-speed-of-sound]] — compressibility β, speed of sound derivation
- [[stagnation-properties]] — total conditions from energy equation
- [[isentropic-relations]] — thermodynamic closure for the EOS
- [[mach-number-and-flow-regimes]] — flow classification from governing equations
