---
title: "Infrastructure Notes — Cloud GPU Compute & Local Setup"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [infrastructure, cloud-computing, gpu, pn40, devops, setup]
confidence: high
---

# Infrastructure Notes

Infrastructure notes documenting the hardware and cloud setup used for ML research and development, particularly for GPU-accelerated workloads like RIGOR benchmarking, neural network training, and data assimilation experiments.

## Local Server (PN40)

- **Hardware**: Low-power server, **no GPU**, 4GB RAM.
- **Role**: Development, code editing, data management, LaTeX compilation, git operations.
- **Limitations**: Cannot run GPU workloads locally; all GPU tasks delegated to cloud platforms.
- **OS**: Linux (Ubuntu/Debian-based), SSH access.

## Cloud GPU Platforms

The primary platforms for GPU computation are documented in [[cloud-gpu-compute-platforms]]. Key notes:

### Modal
- Python decorator (`@modal.function`) based deployment.
- Pay-per-second billing, but **GB-sec pricing** makes large-memory workloads expensive.
- **Preemptible** by design — all functions can be terminated without notice.
- Best for short burst jobs and fast prototyping.

### RunPod
- Docker-based, full container control.
- Cheaper for long batch jobs due to simple per-second GPU pricing.
- **No preemption** — containers run to completion.
- Best for long-running benchmarks and model training.

## Development Workflow

```
[PN40 / Local]  →  git push  →  [GitHub]
       ↓                         ↓
[Modal/RunPod]  ←  deploy  ←  [Pull code]
       ↓
[Run benchmark / train model]
       ↓
[Download results → PN40 / Local for analysis]
```

## Environment Management

- Python virtual environments (venv/conda) for dependency isolation.
- Configuration via `.env` or YAML files for API keys, paths, and hyperparameters.
- Experiments tracked via wandb or local logging to structured JSON/CSV files.

## Wikilinks
- [[cloud-gpu-compute-platforms]] — Platform comparison (Modal, RunPod, Beam/Beta9)
- [[rigor-development]] — RIGOR development environment and benchmarks
- [[rigor-filter]] — Core RIGOR differentible SR-UKF

## References
- Modal Labs. [https://modal.com](https://modal.com)
- RunPod. [https://www.runpod.io](https://www.runpod.io)
- Beam/Beta9. [https://github.com/beam-cloud/beta9](https://github.com/beam-cloud/beta9)
