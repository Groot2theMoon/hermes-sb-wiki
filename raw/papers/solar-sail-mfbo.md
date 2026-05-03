---
title: "SolarSail-MFBO: Multi-Fidelity Bayesian Optimization for Solar Sail Design"
github: https://github.com/Groot2theMoon/SolarSail-MFBO
authors: ["Seungwon Lee (이승원)"]
year: 2025
source: code-repo
ingested: 2026-05-03
sha256: 96923fa2967d3a40524ee4bda1b25a99585895d66d74135ada67466e10ba10eb
---

# SolarSail-MFBO: Multi-Fidelity Bayesian Optimization for Solar Sail Design

- **Repository:** Groot2theMoon/SolarSail-MFBO (GitHub)
- **Purpose:** Optimize solar sail shape (clamp position & displacement) using Multi-Fidelity Bayesian Optimization (MFBO) to minimize costly high-fidelity nonlinear post-buckling simulations.

## Optimization Problem

- Design variables: clamp attachment position (x_c) and displacement amount (d_c)
- Output metric: Thrust Loss (HF) / Compression Area Ratio (LF)

## Multi-Fidelity Setup

| Fidelity | Abaqus Method | Output Metric | Relative Cost |
|----------|---------------|---------------|--------------|
| **LF** (Low) | Linear / Nonlinear Static | Compression Area Ratio | 1.0 |
| **HF** (High) | Post-Buckling (Static, General) | Thrust Loss (based on actual deformed shape) | 10.0 |

**Hypothesis:** 선형 해석(LF)에서 압축 응력이 넓게 분포하는 디자인은, 실제 포스트버클링 해석(HF)에서도 주름(Wrinkle)이 크게 발생하여 추력 성능이 떨어질 것이다.

## System Architecture

- Two Python environments communicate via subprocess:
  - `mfbo.py` (main optimizer) — PyTorch, BoTorch, GPyTorch, WandB
  - `run_abaqus.py` + `eval_abaqus.py` — Abaqus simulation and post-processing
- subprocess call: `abaqus cae noGUI=run_abaqus.py -- [Mode] [x1] [x2]`

## Files

- `mfbo.py` — Main BO loop with checkpointing, MF acquisition (qMultiFidelityLowerBoundMaxValueEntropy)
- `run_abaqus.py` — Abaqus simulation script (LF: linear static, HF: post-buckling with imperfections)
- `eval_abaqus.py` — Post-processing: extracts LF metrics and HF thrust loss from bulkDataBlocks
- `RA_calc.py` — SRP (Solar Radiation Pressure) model constants calculation from nk_data.csv, sun_data.csv
- `solution_space.py` / `solution_lf.py` — Solution space exploration
- Reference paper: Polyanskiy (2024) — Refractiveindex.info database, Scientific Data 11, 94

