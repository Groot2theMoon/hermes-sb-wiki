---
title: Cloud GPU Compute Platforms — Modal vs RunPod vs Beam
created: 2026-05-05
updated: 2026-05-05
type: concept
tags: [tool, infrastructure, comparison]
confidence: high
---

# Cloud GPU Compute Platforms

> 서버리스 GPU 컴퓨팅 플랫폼 비교: Modal, RunPod, Beam/Beta9의 가격, 아키텍처, 적합한 워크로드 분석
> From discussion with user, May 2026

## 개요

PN40 (저전력 서버, GPU 없음) 환경에서 GPU가 필요한 연구용 batch job (RIGOR benchmark, 모델 학습 등)을 실행하기 위한 클라우드 GPU 플랫폼 비교. 핵심 기준: Python decorator 기반 DX, pay-per-second 과금, GPU 종류, 가격.

---

## 비교표

| 차원 | Modal | RunPod | Beam/Beta9 |
|:----|:------|:-------|:-----------|
| **철학** | Python abstraction — Docker 불필요 | GPU 마켓플레이스 — Docker 필수 | Modal과 동일 패턴, 오픈소스 |
| **라이선스** | Proprietary | Proprietary | **AGPL-3.0** (완전 오픈소스) |
| **Self-host 가능?** | ❌ | ❌ | ✅ (단 K8s 필요) |
| **개발 속도** | ~5분 (`pip install modal`) | 1~2시간 (Docker 작성부터) | ~5분 (Modal과 유사) |
| **GPU 종류** | T4, L4, A10, A100, H100 (약 10종) | T4, L4, A100, H100, RTX 4090, A6000 등 다양 | T4, A100, H100 등 (설정 따라) |

---

## 가격 비교

### GPU별 시간당 가격

| GPU | Modal | RunPod (Secure Cloud) | RunPod (Community Cloud) |
|:---|:-----|:---------------------|:------------------------|
| **L4 (24GB)** | $1.10/hr | **$0.54/hr** | $0.40~0.50/hr |
| **A100 (40GB)** | $2.50/hr | $1.29~2.38/hr | $1.10~1.50/hr |
| **A100 (80GB)** | $3.48/hr (US 할증 포함) | $1.89~2.49/hr | $1.50~2.00/hr |
| **H100 (80GB)** | $3.95~4.29/hr | $2.79~3.71/hr | $2.50~3.00/hr |

### 실제 사용 비교 (2주 동일 워크로드)

- **워크로드:** Mistral 7B inference, A100 80GB, bursty traffic
- **Modal:** $187 (웜 컨테이너 유지비 $60~70 포함)
- **RunPod:** $124 (피크타임만 웜 유지)
- **→ RunPod 34% 저렴**, 연간 $4,800 vs $3,200

### 장기 Batch 작업 (Llama 2 70B, 10M tokens, H100)

- **Modal:** ~$160 (GB-sec 과금: $0.00042/GB-sec × 80GB × 4,762초)
- **RunPod:** ~$4.91 (초당 과금: $0.00103/sec × 4,762초 + $0.30 setup)
- **→ RunPod 약 25배 저렴** (GB-sec 과금의 배율 차이)

가격 차이의 핵심: Modal은 **GB-sec**(GPU 메모리 크기 × 시간)으로 과금하여 H100 80GB 사용 시 80배율이 붙지만, RunPod은 **GPU 초당 단순 과금**.

---

## Cold Start

| 측면 | Modal | RunPod |
|:----|:------|:-------|
| Raw cold start (14GB 모델) | 18~25초 | 19~22초 |
| 최적화 후 | ~8초 (Memory Snapshot) | 0.18초 (FlashBoot hit) 또는 19~22초 (miss) |
| 일관성 | 항상 ~8초 | 불규칙 (off-hours hit율 ~30%) |
| Snapshot 문제 | 가중치 업데이트 시 silent failure (perplexity 상승, 2일 진단 소요) | N/A |

---

## Preemption (강제 종료)

| 플랫폼 | Preemption | 영향 |
|:------|:----------|:-----|
| **Modal** | **✅ 모든 GPU 함수가 preemptible, opt-out 불가** | 장기 batch 도중 강제 종료 가능. 실제 사례: 새벽 2시 503 error, 40건 요청 드롭 |
| **RunPod** | **✅ Preemption 없음** | 컨테이너가 끝날 때까지 안정적 실행 |
| **Beam/Beta9** | 설정에 따라 다름 | self-host시 제어 가능 |

---

## 개발 경험 (DX)

### Modal
```python
import modal

@modal.function(gpu="A100")
def train():
    # GPU training code
    ...

modal deploy script.py  # 30초 배포
```
- **장점:** Docker 불필요, 30초 iterative cycle, built-in versioning, 자동 rollback
- **단점:** 플랫폼 lock-in, 제한된 GPU 선택지, preemption 불가피

### RunPod
```dockerfile
FROM nvidia/cuda:12.0-runtime
COPY handler.py /app/
```
- **장점:** 전체 Docker 제어, 저렴한 가격, preemption 없음
- **단점:** Docker build 필요 (처음 1~2시간, 재배포 5~10분), 개발 속도 느림

### Beam/Beta9
```python
from beta9 import endpoint

@endpoint(gpu="A100")
def train():
    # GPU training code
    ...
```
- **장점:** Modal과 동일한 @decorator 패턴, AGPL-3.0 오픈소스, self-host 가능
- **단점:** Self-host시 K8s 클러스터 필요 (PN40 단독 운영 불가)

---

## Beam/Beta9 Self-Host 상세

### 왜 K8s가 필요한가

Beta9는 단순 Python SDK가 아니라 **분산 컨트롤 플레인 시스템** (Go 기반)이다:

```
[PN40 (컨트롤러)]
  └ Beta9 (K3s 위에서 동작)
       │
       ├── GPU Worker A (T4)    ← K8s node로 join
       ├── GPU Worker B (A100)
       └── GPU Worker C (RTX 4090)
```

- Beta9 컨트롤러: job scheduling, container orchestration, scaling을 K8s API 위에서 처리
- 위키 원칙: 단순 Python SDK 아님 — 1,500+ commits, Go binary + 여러 마이크로서비스

### PN40에서의 현실적 문제

| 문제 | 설명 |
|:----|:-----|
| **GPU 부재** | PN40에 GPU 없음 → GPU pod를 띄울 노드가 없음 |
| **외부 GPU join** | Vast.ai/RunPod 머신에 K3s agent 설치 + VPN (Tailscale/WireGuard) 필요 |
| **메모리** | PN40의 4GB RAM으로는 K3s + Beta9 컨트롤러만으로도 부족 |

**결론:** Beam/Beta9는 **이미 K8s 클러스터가 구축된 환경**에서 Modal-like DX를 원하는 팀에게 적합. 개인 연구 서버 용도로는 오버스펙.

---

## 사용 사례별 추천

| 워크로드 | 추천 플랫폼 | 이유 |
|:--------|:----------|:-----|
| **짧은 burst inference** (초~분) | Modal ($30/월 무료 크레딧) | 빠른 cold start, 무료 티어 |
| **장기 batch / benchmark** (수분~수시간) | **RunPod Serverless** | 25배 저렴, preemption 없음 |
| **Prototype → 빠른 iteration** | Modal (30초 재배포) → RunPod 포팅 | 투-플랫폼 전략 |
| **K8s 클러스터 보유 팀** | Beam/Beta9 self-host | 오픈소스, lock-in 없음 |

---

## 관련 페이지
- [[rigor-development]] — RIGOR benchmark 실행 환경
- [[infrastructure-notes]] — PN40 서버 환경

## Sources
- [Modal Pricing](https://modal.com/pricing)
- [RunPod Serverless](https://www.runpod.io/serverless-gpu)
- [Beam/Beta9 GitHub](https://github.com/beam-cloud/beta9)
- breakingcube.com Modal vs RunPod 실사용 2주 비교 (2026-04)
- deploybase.ai Modal vs RunPod 비교 (2026)
