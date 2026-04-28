---
title: YOLO — You Only Look Once
created: 2026-04-28
updated: 2026-04-28
type: concept
tags: [model, neural-network, benchmark, paper]
sources: [raw/papers/1506.02640v5.md]
confidence: high
---

# YOLO: Unified, Real-Time Object Detection

## 개요

**YOLO (You Only Look Once)**는 [[joseph-redmon|Joseph Redmon]], Santosh Divvala, [[ross-girshick|Ross Girshick]], Ali Farhadi가 2015년 제안한 **실시간 객체 탐지(object detection) 알고리즘**이다^[raw/papers/1506.02640v5.md]. 기존 접근법과 달리 객체 탐지를 **단일 회귀 문제(single regression problem)**로 프레임화하여, 하나의 CNN이 전체 이미지를 한 번만 보고 바운딩 박스와 클래스 확률을 동시에 예측한다.

## 핵심 아이디어

### Detection을 Regression으로
- 기존: Region proposal → 분류기 → 후처리 (복잡한 파이프라인, 속도 느림)
- YOLO: **한 번의 네트워크 평가**로 바운딩 박스 + 클래스 확률 동시 예측

### 아키텍처
- 입력: $448 \times 448$
- **24개 Conv 레이어 + 2개 FC 레이어** (GoogLeNet 영감)
- ImageNet 사전학습 (224×224) → 해상도 증가 (448×448) → Detection 미세조정
- 출력: $S \times S \times (B \cdot 5 + C)$ 텐서 ($S=7, B=2, C=20$ → $7 \times 7 \times 30$)
- 활성화: Leaky ReLU ($\phi(x)=x$ if $x>0$, else $0.1x$)

### 격자 기반 예측
- 입력 이미지를 $S \times S$ 격자로 분할
- 각 격자 셀: $B$개의 바운딩 박스 + confidence 예측
- 각 격자 셀: $C$개의 조건부 클래스 확률 $Pr(\text{Class}_i|\text{Object})$
- 최종: $Pr(\text{Class}_i) \times \text{IOU}_{\text{pred}}^{\text{truth}}$

### 손실 함수
다중 부분 손실:
$$\begin{aligned} &\lambda_{\text{coord}} \sum_{i=0}^{S^2} \sum_{j=0}^B \mathbb{1}_{ij}^{\text{obj}} [(x_i - \hat{x}_i)^2 + (y_i - \hat{y}_i)^2] \\ &+ \lambda_{\text{coord}} \sum_{i=0}^{S^2} \sum_{j=0}^B \mathbb{1}_{ij}^{\text{obj}} [(\sqrt{w_i} - \sqrt{\hat{w}_i})^2 + (\sqrt{h_i} - \sqrt{\hat{h}_i})^2] \\ &+ \sum_{i=0}^{S^2} \sum_{j=0}^B \mathbb{1}_{ij}^{\text{obj}} (C_i - \hat{C}_i)^2 \\ &+ \lambda_{\text{noobj}} \sum_{i=0}^{S^2} \sum_{j=0}^B \mathbb{1}_{ij}^{\text{noobj}} (C_i - \hat{C}_i)^2 \\ &+ \sum_{i=0}^{S^2} \mathbb{1}_i^{\text{obj}} \sum_{c \in \text{classes}} (p_i(c) - \hat{p}_i(c))^2 \end{aligned}$$

- $\lambda_{\text{coord}} = 5$, $\lambda_{\text{noobj}} = 0.5$

## 성능

| 모델 | mAP (VOC 2007) | FPS |
|------|----------------|-----|
| Fast YOLO | 52.7% | **155** |
| YOLO | **63.4%** | 45 |
| 30Hz DPM | 26.1% | 30 |
| Faster R-CNN (ZF) | 62.1% | 18 |

- **Localization error**가 많지만 **Background false positive는 훨씬 적음** (4.75% vs Fast R-CNN 13.6%)
- Fast R-CNN + YOLO 결합 시 mAP 75.0% (Fast R-CNN 71.8% → +3.2%)

## 한계
- **작은 객체 탐지 취약:** 각 격자가 2개 박스 + 1개 클래스만 예측
- **새로운 종횡비/aspect ratio 일반화 어려움**
- **Localization error가 주요 오류 원인** (19.0%)

## 의의 및 발전
- **최초의 실시간 single-shot detector** — 이후 YOLOv2~v8, SSD, RetinaNet 등 발전
- 자연 이미지 학습 후 **예술 작품에도 잘 일반화** (domain shift에 강함)
- 로봇 비전, 자율주행, 실시간 감시 시스템의 기반 기술

- [[ls-yolo]] — YOLO의 경량 확장 (자율주행)
- [[residual-networks]] — CNN backbone 발전

## References
- J. Redmon, S. Divvala, R. Girshick, A. Farhadi. "You Only Look Once: Unified, Real-Time Object Detection", *CVPR 2016*
- [[universal-approximation-theorem]] — CNN 기반 함수 근사의 이론적 배경
- R. Girshick. "Fast R-CNN", 2015 (비교 대상)