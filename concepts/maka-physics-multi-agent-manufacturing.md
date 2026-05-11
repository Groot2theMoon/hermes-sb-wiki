---
title: MAKA — Physics-Grounded Multi-Agent Architecture for Manufacturing
created: 2026-05-11
updated: 2026-05-11
type: concept
tags: [paper, digital-twin, engineering-design, manufacturing, physics-informed, learning]
confidence: medium
sources: []
---

# MAKA: Multi-Agent Knowledge Analysis for Manufacturing

## 개요
arXiv:2605.04003 (cs.MA, May 2026)은 **물리 기반 multi-agent 아키텍처(MAKA)**를 제안하여 Ti-6Al-4V 로터 블레이드 가공(machining) 공정에서 인간-AI 협업 의사 결정을 지원한다. Intent routing, 정량 해석, 지식 그래프 검색, 물리-안전 검증(critic)을 분리한 human-in-the-loop 구조다.

## 핵심 아이디어
- **4-layer 분리 아키텍처:** (1) Intent routing → (2) Tool-only 수치 해석 → (3) Knowledge graph 검색 → (4) Critic verification (물리 타당성, 안전, 출처 검증)
- **Digital twin what-if:** 16개 블레이드의 가상 가공 경로 추적, 절삭력/변형 시뮬레이션, 3D 스캔 기반 편차 지도를 융합
- **편차 분해:** 경로 관련 성분, 드리프트 기반 마모 프록시, 잔류 컴플라이언스, 변동성 프록시로 체계적 분해
- **결과:** 예측 표면 편차를 ~10⁻² in → ±10⁻³ in 수준으로 감소

## 연결점
- [[digital-twin]] — 제조 공정의 what-if 시뮬레이션 및 실시간 보정
- [[physics-informed]] — 물리 타당성 검증(critic)이 AI 추천의 신뢰성 보장

## References
- arXiv:2605.04003 — Physics-Grounded Multi-Agent Architecture for Traceable, Risk-Aware Human–AI Decision Support in Manufacturing
