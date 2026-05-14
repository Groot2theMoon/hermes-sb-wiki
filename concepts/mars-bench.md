---
title: Mars-Bench — Benchmark for Foundation Models for Mars Science
created: 2026-05-14
updated: 2026-05-14
type: concept
tags: [benchmark, computer-vision, survey]
sources: [raw/papers/NeurIPS_ML4PS_2025_114.md]
confidence: high
---

# Mars-Bench

화성 과학을 위한 첫 번째 표준화된 foundation model 평가 벤치마크.

## 개요

- **저자:** Purohit et al. (Arizona State University / JPL)
- **NeurIPS ML4PS 2025 Workshop**
- **목적:** 화성 궤도/표면 이미지 데이터셋을 표준화하여 foundation model 평가 플랫폼 제공
- **데이터셋:** 20개 데이터셋 (classification, segmentation, object detection)
- **URL:** https://mars-bench.github.io/

## 데이터셋 구성

| Task | 예시 | 센서 |
|------|------|------|
| Classification (9) | frost, atmospheric dust, landmark, surface | HiRISE, CTX, Mastcam, Pancam |
| Segmentation (7) | crater, boulder, cone, terrain | CTX, THEMIS, HiRISE, Mastcam |
| Object Detection (4) | dust devil, cone, boulder | CTX, HiRISE |

## AI×Mechanics 관점

- 도메인 특화 벤치마크 설계의 모범 사례 — 기계공학/물리 ML 벤치마크 구축 시 참고
- Cross-sensor, cross-mission generalization 디자인 패턴
- Few-shot 평가 프로토콜 및 standardized train/val/test split 제공
- 모든 데이터 CC BY 4.0 라이선스

## 관련 페이지

- [[benchmark]] — ML 벤치마크 방법론
- [[computer-vision]] — 컴퓨터 비전 기초
