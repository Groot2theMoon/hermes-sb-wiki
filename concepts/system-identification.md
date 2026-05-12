---
title: "System Identification"
created: 2026-05-12
updated: 2026-05-12
type: concept
tags: [system-identification, dynamical-systems, surrogate-model, state-estimation, system-model]
confidence: medium
---

# System Identification

System identification is the field of building mathematical models of dynamical systems from observed input-output data. It encompasses a wide range of methods — from classical linear subspace identification and ARX models to modern deep learning approaches — for discovering governing equations, state-space representations, or input-output mappings that explain observed system behavior.

## 개요

Given time-series measurements $\{u_t, y_t\}_{t=1}^T$ of inputs $u_t$ and outputs $y_t$ of an unknown dynamical system, system identification seeks a model $\mathcal{M}_\theta$ such that $y_t \approx \mathcal{M}_\theta(u_t)$. The identified model can take various forms: state-space models ($x_{t+1} = f(x_t, u_t), y_t = g(x_t, u_t)$), polynomial NARMAX models, neural network dynamics, or Koopman-linearized representations. Classical methods (subspace ID, prediction error minimization) remain widely used, while neural network-based approaches (neural ODEs, reservoir computing, deep state-space models) dominate contemporary research.

## 주요 방법론

- **Classical methods**: ARX/ARMAX, subspace identification (N4SID, MOESP), prediction error minimization (PEM).
- **Koopman-based identification**: Approximating the Koopman operator from data via DMD, EDMD, or deep Koopman networks to obtain globally linear representations.
- **Neural network approaches**: Neural ODEs, LSTM/GRU dynamics, neural state-space models (Deep SSM), and physics-informed system identification.
- **Sparse identification**: SINDy (Sparse Identification of Nonlinear Dynamics) discovers parsimonious governing equations from a library of candidate functions.

## 응용

System identification is fundamental to control system design, digital twinning, structural health monitoring, fault detection, and simulation-based prediction across aerospace, automotive, robotics, and civil engineering domains. Methods like [[nn-poly-dynamical-system-constraints|NN-Poly]] bridge learned neural dynamics with verifiable physical constraints.

## 관련 개념

- [[koopman-operator-theory]] — Linear operator framework for nonlinear system identification
- [[nn-poly-dynamical-system-constraints]] — Neural network to Taylor polynomial for constraint-aware identification
- [[physics-informed]] — Physics-informed approaches to system identification
- [[hybrid-modeling]] — Hybrid physics+data system identification
- [[surrogate-model]] — Surrogate modeling for dynamical systems
- [[kalman-filter]] — State estimation from identified system models
