---
title: "PSIntelligence: AI & ML Pipeline for Rocket Apogee Prediction"
github: https://github.com/postech-psi/psintelligence
authors: ["Seungwon Lee (이승원)"]
year: 2025
source: code-repo
ingested: 2026-05-03
sha256: 654fe611bdfea09da73eb7bbccf641e3057e36e11d5d5a7f4056484bcc1993e4
---

# Postech-PSI/PSIntelligence: AI & ML Pipeline for Rocket Apogee Prediction

This repository provides an educational AI pipeline for **real-time apogee (maximum altitude) prediction during rocket flight**, designed for deployment on avionics hardware. The focus is on safety, physical consistency, and uncertainty awareness.

## Repository Structure

| File | Description |
|------|-------------|
| `main.py` | Entry point for inference |
| `motor_data.eng` | Rocket motor data |
| `requirements.txt` | Python dependencies |
| `step1.5-data generation.ipynb` | Data generation |
| `step2-EKF&UKF.ipynb` | Step 2: Nonlinear filtering |
| `step3-ANN&PINN.ipynb` | Step 3: Neural networks + Physics-Informed |
| `step4-LSTM&GRU.ipynb` | Step 4: Sequence modeling |
| `step5-UQ.ipynb` | Step 5: Uncertainty quantification |
| `step6-Mamba&Deploy.ipynb` | Step 6: Lightweight deployment |

## Core Themes

| Theme | Description |
|-------|-------------|
| **Physical law compliance** | AI predictions must not violate energy conservation, equations of motion |
| **Time-series context learning** | Past flight history influences future prediction |
| **Uncertainty quantification** | AI detects when it is uncertain and triggers safe mode |
| **Onboard deployment** | Real-time inference on limited memory/power flight computers |
| **Safety-first engineering** | Confidence intervals and fail-safe logic prioritized over raw accuracy |

## Pipeline Steps (1→6)

Step 1: Linear Kalman Filter — Estimate rocket state (altitude, velocity) while removing sensor noise.
Step 2: EKF & UKF — Handle nonlinear rocket dynamics (thrust, drag, gravity).
Step 3: PINN — Physics-Informed Neural Networks for prediction without violating physical laws.
Step 4: GRU — Time series estimator with memory for past faults.
Step 5: UQ — Uncertainty Quantification via MC Dropout for OOD detection.
Step 6: Mamba + ONNX — Quantization and edge deployment on resource-constrained flight computers.

## Key References

- Kalman (1960) — Linear filtering
- Raissi et al. (2019) — PINN
- Chung et al. (2014) — GRU
- Gal & Ghahramani (2016) — MC Dropout as Bayesian Approximation
- Gu & Dao (2023) — Mamba: Linear-Time Sequence Modeling

