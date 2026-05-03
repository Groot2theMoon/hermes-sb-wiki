---
title: "Refractiveindex.info Database of Optical Constants"
created: 2026-05-03
updated: 2026-05-03
type: concept
tags: [optical-constants, refractive-index, database, solar-sail, spectroscopy, yaml]
confidence: high
sources:
  - raw/papers/polyanskiy2024-refractiveindex-database.md
related:
  - concepts/solar-sail-mfbo
  - entities/mikhail-polyanskiy
---

# Refractiveindex.info Database of Optical Constants

Mikhail N. Polyanskiy (Brookhaven National Laboratory)가 운영하는 **오픈소스 광학 상수 데이터베이스**. 
2008년부터 지속적으로 개발되어 현재 605개 물질에 대한 3,135개의 선형(nk) 데이터와 
89개 물질에 대한 193개의 비선형(n₂) 데이터를 포함.

## 개요

- **논문:** Scientific Data, Volume 11, Article 94 (2024)
- **DOI:** 10.1038/s41597-023-02898-2
- **데이터:** YAML 기반, GitHub에서 관리
- **용도:** 태양돛(Solar Sail) 광학 특성 계산, SRP 모델링에 사용

## 데이터 형식

YAML 파일로 저장되며 각 레코드는:
- **REFERENCES** — 출처 인용 (필수)
- **DATA** — 분산 공식(formula) 또는 테이블화된 n/k 값 (필수)
- **COMMENTS** — 자유 텍스트 맥락 (선택)
- **SPECS** — 온도, 측정 방법, 단위 등 (선택)

## SolarSail-MFBO와의 연결

SolarSail-MFBO 프로젝트에서 태양돛의 SRP (Solar Radiation Pressure) 모델링을 위해 
이 데이터베이스의 `nk_data.csv`와 `sun_data.csv`를 사용하여 
`RA_calc.py`에서 SRP 모델 상수(R₀, A₀)를 계산함.

## 접근

- Figshare: doi:10.6084/m9.figshare.c.6868000.v1
- GitHub DB: github.com/polyanskiy/refractiveindex.info-database
