---
title: "Graph Neural Network (GNN)"
created: 2026-05-06
updated: 2026-05-06
type: concept
tags: [deep-learning, graph, message-passing, neural-network, representation-learning]
confidence: high
---

# Graph Neural Network (GNN)

Graph Neural Networks are deep learning architectures designed for **graph-structured data**, where entities (nodes) and their relationships (edges) define the computational structure. Unlike Euclidean data (images, sequences), graphs are permutation-invariant and can have variable topology across samples.

## Message Passing Framework

The core computational primitive in GNNs is **message passing** (or neighborhood aggregation). Each node `v` updates its hidden representation `h_v` by aggregating messages from its neighbors `N(v)`:

```
h_v^(k+1) = UPDATE^(k)(h_v^(k), AGG^(k)({m_uv : u ∈ N(v)}))
```

where `m_uv = MSG^(k)(h_u^(k), h_v^(k), e_uv)` encodes edge features `e_uv`. Common aggregators include sum, mean, and max. After K rounds of message passing, each node's representation captures information from its K-hop neighborhood.

## Major Variants

- **Graph Convolutional Networks (GCN)**: Kipf & Welling (2017) — spectral-based convolution with normalized adjacency, first-order approximation.
- **Graph Attention Networks (GAT)**: Veličković et al. (2018) — attention-weighted aggregation with learnable neighbor importances.
- **Graph Isomorphism Networks (GIN)**: Xu et al. (2019) — maximally expressive MPNN under the WL graph isomorphism test.
- **Message Passing Neural Networks (MPNN)**: Gilmer et al. (2017) — general framework unifying prior GNN variants.
- **Graph Transformers**: Applying self-attention across nodes with positional/structural encodings.

## Applications in Physical Sciences

- **Structural mechanics**: GNNs model truss structures, finite element meshes, and deformable bodies as graphs where nodes represent material points and edges encode mechanical constraints.
- **Physical simulations**: Mesh-based GNNs (Pfaff et al., 2021) learned simulators for fluid dynamics, cloth, and rigid bodies.
- **Molecular modeling**: Equivariant GNNs (SchNet, DimeNet, MACE) predict quantum properties from molecular graphs.

## Wikilinks
- [[graph-neural-ode-structural-dynamics]] — GNODE combining GNN with Neural ODE for structural dynamics
- [[pigg-graph-kalman-filter]] — PiGGO: Physics-Guided Graph Kalman Filter using GNNs
- [[neural-ode]] — Neural ODE for continuous dynamics
- [[lagrangian-koopman-network]] — LaCGKN conditional Gaussian Koopman network

## References
- Kipf, T. & Welling, M. (2017). Semi-Supervised Classification with Graph Convolutional Networks. ICLR 2017.
- Veličković, P. et al. (2018). Graph Attention Networks. ICLR 2018.
- Gilmer, J. et al. (2017). Neural Message Passing for Quantum Chemistry. ICML 2017.
- Battaglia, P. et al. (2018). Relational Inductive Biases, Deep Learning, and Graph Networks. arXiv:1806.01261.
