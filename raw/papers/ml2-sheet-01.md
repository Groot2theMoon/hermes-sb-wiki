---
title: "ML2 - Sheet 01"
source: lecture
ingested: 2026-04-28
sha256: ba85562f7467d5a2a5e17b69470a1103ea15df11d7fa1783a9a429de89818609
---



# Exercise Sheet 1

## Exercise 1: Symmetries in LLE (30 P)

The Locally Linear Embedding (LLE) method takes as input a collection of data points  $\mathbf{x}_1, \dots, \mathbf{x}_N \in \mathbb{R}^d$  and embeds them in some low-dimensional space. LLE operates in two steps, with the first step consisting of minimizing the objective

$$\mathcal{E}(W) = \sum_{i=1}^N \left\| \mathbf{x}_i - \sum_j W_{ij} \mathbf{x}_j \right\|^2$$

where  $W$  is a collection of reconstruction weights subject to the constraint  $\forall i : \sum_j W_{ij} = 1$ , and where  $\sum_j$  sums over the  $K$  nearest neighbors of the data point  $\mathbf{x}_i$ . The solution that minimizes the LLE objective can be shown to be invariant to various transformations of the data.

*Show* that invariance holds in particular for the following transformations:

- Replacement of all  $\mathbf{x}_i$  with  $\alpha \mathbf{x}_i$ , for an  $\alpha \in \mathbb{R}^+ \setminus \{0\}$ ,
- Replacement of all  $\mathbf{x}_i$  with  $\mathbf{x}_i + \mathbf{v}$ , for a vector  $\mathbf{v} \in \mathbb{R}^d$ ,
- Replacement of all  $\mathbf{x}_i$  with  $U \mathbf{x}_i$ , where  $U$  is an orthogonal  $d \times d$  matrix.

## Exercise 2: Closed form for LLE (30 P)

In the following, we would like to show that the optimal weights  $W$  have an explicit analytic solution. For this, we first observe that the objective function can be decomposed as a sum of as many subobjectives as there are data points:

$$\mathcal{E}(W) = \sum_{i=1}^N \mathcal{E}_i(W) \quad \text{with} \quad \mathcal{E}_i(W) = \left\| \mathbf{x}_i - \sum_j W_{ij} \mathbf{x}_j \right\|^2$$

Furthermore, because each subobjective depends on different parameters, they can be optimized independently. We consider one such subobjective and for simplicity of notation, we rewrite it as:

$$\mathcal{E}_i(\mathbf{w}) = \left\| \mathbf{x} - \sum_{j=1}^K w_j \mathbf{\eta}_j \right\|^2$$

where  $\mathbf{x}$  is the current data point (we have dropped the index  $i$ ), where  $\eta = (\eta_1, \dots, \eta_K)$  is a matrix of size  $K \times d$  containing the  $K$  nearest neighbors of  $\mathbf{x}$ , and  $\mathbf{w}$  is the vector of size  $K$  containing the weights to optimize and subject to the constraint  $\sum_{j=1}^K w_j = 1$ .

- Prove* that the optimal weights for  $\mathbf{x}$  are found by solving the following optimization problem:

$$\min_{\mathbf{w}} \quad \mathbf{w}^\top C \mathbf{w} \quad \text{subject to} \quad \mathbf{w}^\top \mathbf{1} = 1.$$

where  $C = (\mathbf{1} \mathbf{x}^\top - \eta)(\mathbf{1} \mathbf{x}^\top - \eta)^\top$  is the covariance matrix associated to the data point  $\mathbf{x}$  and  $\mathbf{1}$  is a vector of ones of size  $K$ .

- Show* using the method of Lagrange multipliers that the minimum of the optimization problem found in (a) is given analytically as:

$$\mathbf{w} = \frac{C^{-1} \mathbf{1}}{\mathbf{1}^\top C^{-1} \mathbf{1}}.$$

- Show* that the optimal  $\mathbf{w}$  can be equivalently found by solving the equation  $C \mathbf{w} = \mathbf{1}$  and then rescaling  $\mathbf{w}$  such that  $\mathbf{w}^\top \mathbf{1} = 1$ .

## Exercise 3: Programming (40 P)

Download the programming files on ISIS and follow the instructions.