---
title: "ML2 - Lecture 01"
source: lecture
ingested: 2026-04-28
sha256: a4a5db008e2081a44d04071095990ecd04ad3a6bb9ffd9f401d5fff19a31a558
---



# Lecture 1Low-Dimensional Embedding 1 (LLE)

Klaus-Robert Müller & Wojciech Samek & Grégoire Montavon

![Logo of the Technical University of Berlin (TU Berlin) and a small heatmap visualization.](30a26f2d17ca95672702bf50fb4f0242_img.jpg)

The image contains two elements: on the left, the logo of the Technical University of Berlin (TU Berlin), which consists of a stylized red 'TU' and the word 'berlin' in a vertical orientation; on the right, a small square visualization showing a heatmap or density plot with concentric circular patterns in shades of red, yellow, and blue.

Logo of the Technical University of Berlin (TU Berlin) and a small heatmap visualization.

## Today ---

## Local Linear Embedding (LLE)

![Three panels (A, B, C) illustrating the Local Linear Embedding (LLE) process on a Swiss Roll dataset.](e05232e09f8d0a603eef5812f7313d4b_img.jpg)

The figure illustrates the Local Linear Embedding (LLE) process through three panels:

- A**: A 3D visualization of a Swiss Roll dataset, represented as a continuous, twisted ribbon. The surface is colored with a gradient from green at the bottom to red at the top. The ribbon is shown in a 3D coordinate system with three axes.
- B**: A 2D projection of the Swiss Roll dataset. The data points are colored based on their position along the roll, showing a circular arrangement. A small black circle highlights a specific region on the right side of the circle.
- C**: A 2D projection of the Swiss Roll dataset, showing the data points flattened into a rectangular shape. The colors transition from purple on the left to red on the right. A small black circle highlights a specific region on the right side of the rectangle.

Three panels (A, B, C) illustrating the Local Linear Embedding (LLE) process on a Swiss Roll dataset.

[from Roweis & Saul Science 290, p 2323 (2000)]

### Dimensionality Reduction ---

In many applications, we have

- high-dimensional data
  - reason to believe they lie close to a lower dimensional subspace
- Fewer parameters needed to account for the data properties  
*hidden causes or latent variables*

Examples:

- you want to classify high resolution images
- you want to make a predictive model based on hundreds of customer attributes
- you want to analyse high dimensional neural data
- you want to detect trends in news data

### Dimensionality Reduction

#### Electromyographic (EMG) Signal

![A photograph of a prosthetic arm with four EMG sensors attached to the residual limb, used for signal acquisition.](ddfe517a5ad9c77c89a57a5e780b24ca_img.jpg)

A photograph of a prosthetic arm with four EMG sensors attached to the residual limb, used for signal acquisition.

![A plot showing four stacked EMG signal traces (cyan, red, green, blue) over time (0 to 1400). The traces show bursts of activity corresponding to muscle contractions.](f961cbef0f8217e216b553bed270315b_img.jpg)

A plot showing four stacked Electromyographic (EMG) signal traces over time. The x-axis is labeled 'Time' and ranges from 0 to 1400. The y-axis represents the signal amplitude. The traces are colored cyan, red, green, and blue from top to bottom. Each trace shows bursts of activity, indicating muscle contractions.

A plot showing four stacked EMG signal traces (cyan, red, green, blue) over time (0 to 1400). The traces show bursts of activity corresponding to muscle contractions.

![A plot showing the variance explained by orthogonal dimensions (0 to 200). The variance drops sharply to near zero after the first dimension.](b7251436a2a3c0d1c00c3e935df2a8f5_img.jpg)

A plot showing the variance explained by orthogonal dimensions. The x-axis is labeled 'Orthogonal dimensions' and ranges from 0 to 200. The y-axis is labeled 'Variance explained'. The plot shows a sharp drop in variance explained by the first dimension, with the variance remaining near zero for the subsequent dimensions.

A plot showing the variance explained by orthogonal dimensions (0 to 200). The variance drops sharply to near zero after the first dimension.

### Dimensionality Reduction

#### Word2Vec Embedding

![Diagram illustrating Word2Vec embedding transformation from one-hot vectors to dense vectors.](e394c2b5c61344f6a12397f430086072_img.jpg)

The diagram illustrates the transformation of one-hot vectors into dense Word2Vec embeddings. On the left, three one-hot vectors are shown for the words "a", "abbreviations", and "zoology". The vector for "a" has a 1 in the first position and 0s elsewhere. The vector for "abbreviations" has a 1 in the second position. The vector for "zoology" has a 1 in the last position. An arrow points to the right, where the same three words are shown with their corresponding dense embeddings, which are vectors of floating-point numbers.

| "a" | "abbreviations" | "zoology" |
|-----|-----------------|-----------|
| 1   | 0               | 0         |
| 0   | 1               | 0         |
| 0   | 0               | 0         |
| ⋮   | ⋮               | ⋮         |
| 0   | 0               | 0         |
| 0   | 0               | 1         |
| 0   | 0               | 0         |

| "a" | "abbreviations" | "zoology" |
|-----|-----------------|-----------|
| 0.1 | 1.1             | 8.3       |
| 1.3 | -1.1            | 3.1       |
| 4.2 | 2.8             | -0.2      |

Diagram illustrating Word2Vec embedding transformation from one-hot vectors to dense vectors.

Word2Vec embedding encodes semantic information  
(more than simple dimensionality reduction)

### Dimensionality Reduction ---

#### Why dimensionality reduction / embeddings ?

- **Visualization:**  
Insights into high-dimensional structures in the data
- **Better Generalization:**  
Fewer dimensions → less chances of overfitting / better representation
- **Speeding up** learning algorithms:  
Most algorithms scale badly with increasing data dimensionality
- **Data compression:**  
Less storage requirements

### Recap: PCA ---

We obtained some data  $X = [\mathbf{x}_1, \mathbf{x}_2, \dots, \mathbf{x}_N] \in \mathbb{R}^{D \times N}$

PCA finds a direction  $\mathbf{w} \in \mathbb{R}^D$  such that the variance of the projected data  $\mathbf{w}^T X$  is maximal

$$\begin{aligned}\text{Var}(\mathbf{w}^T X) &= \frac{1}{N} \sum_{n=1}^N (\mathbf{w}^T \mathbf{x}_n - \mathbb{E}(\mathbf{w}^T \mathbf{x}))^2 \\&= \frac{1}{N} \sum_{n=1}^N (\mathbf{w}^T \mathbf{x}_n - \mathbf{w}^T \mathbb{E}(\mathbf{x}))^2 = \frac{1}{N} \sum_{n=1}^N (\mathbf{w}^T (\mathbf{x}_n - \mathbb{E}(\mathbf{x})))^2 \\&= \frac{1}{N} \sum_{n=1}^N \mathbf{w}^T (\mathbf{x}_n - \mathbb{E}(\mathbf{x})) \cdot (\mathbf{x}_n - \mathbb{E}(\mathbf{x}))^T \mathbf{w} \\&= \mathbf{w}^T \underbrace{\left( \frac{1}{N} \sum_{n=1}^N (\mathbf{x}_n - \mathbb{E}(\mathbf{x})) \cdot (\mathbf{x}_n - \mathbb{E}(\mathbf{x}))^T \right)}_{\text{Covariance matrix S}} \mathbf{w}\end{aligned}$$

### Recap: PCA ---

For  $S\mathbf{w} = \lambda\mathbf{w}$ , we see that the variance in direction  $\mathbf{w}$  is given by:

$$\operatorname{argmax}_{\mathbf{w}} \frac{\mathbf{w}^\top S\mathbf{w}}{\mathbf{w}^\top \mathbf{w}} = \frac{\mathbf{w}^\top \lambda\mathbf{w}}{\mathbf{w}^\top \mathbf{w}} = \lambda$$

The variance of the projected data in an eigendirection  $\mathbf{w}$  is given by the corresponding eigenvalue!

The direction of maximal variance in the data is equal to the eigenvector having the largest eigenvalue.

### Recap: PCA

![Diagram illustrating the PCA transformation from an original data space to a component space.](b93cbfb52e37619e688175a6aad9edd9_img.jpg)

The figure illustrates the PCA transformation. On the left, the 'original data space' is a 3D plot with axes labeled 'Gene 1', 'Gene 2', and 'Gene 3'. It shows a cloud of data points (red crosses, green circles, blue stars, and purple squares) clustered along a diagonal plane. Two orthogonal vectors, PC 1 and PC 2, are shown as arrows originating from the center of the data cloud. An arrow labeled 'PCA' points to the right side, which is the 'component space'. This space is a 2D grid with axes labeled 'PC 1' and 'PC 2'. The data points are now projected onto this 2D plane, showing their coordinates relative to the principal components. The clusters are clearly separated along the PC 1 axis.

Diagram illustrating the PCA transformation from an original data space to a component space.

Now that we have  $W = [\mathbf{w}_1, \mathbf{w}_2, \dots, \mathbf{w}_k] \in \mathbb{R}^{D \times k}$ , we project each data point  $\mathbf{x}$  onto  $W$

$$H = \begin{bmatrix} \mathbf{w}_1^T \mathbf{x} \\ \vdots \\ \mathbf{w}_k^T \mathbf{x} \end{bmatrix} = \begin{bmatrix} \mathbf{w}_1^T \\ \vdots \\ \mathbf{w}_k^T \end{bmatrix} \mathbf{x} = W^T \cdot \mathbf{x}$$

### Recap: PCA ---

![A diagram illustrating the transformation of data from an original 3D space to a 2D component space using PCA. The original data space on the left shows a 3D plot of a curved, ribbon-like structure with a color gradient from blue at the top to red at the bottom. An arrow labeled 'PCA' points to the component space on the right, which shows a 2D projection of the same data. In the component space, the data points are scattered across a 2D plane, with colors ranging from blue to red, representing the principal components of the data.](4e0ade2f41b66d5602160da5cc978274_img.jpg)

original data space

PCA

component space

The figure illustrates the transformation of data from an original 3D space to a 2D component space using PCA. The original data space on the left shows a 3D plot of a curved, ribbon-like structure with a color gradient from blue at the top to red at the bottom. An arrow labeled 'PCA' points to the component space on the right, which shows a 2D projection of the same data. In the component space, the data points are scattered across a 2D plane, with colors ranging from blue to red, representing the principal components of the data.

A diagram illustrating the transformation of data from an original 3D space to a 2D component space using PCA. The original data space on the left shows a 3D plot of a curved, ribbon-like structure with a color gradient from blue at the top to red at the bottom. An arrow labeled 'PCA' points to the component space on the right, which shows a 2D projection of the same data. In the component space, the data points are scattered across a 2D plane, with colors ranging from blue to red, representing the principal components of the data.

[from Ornek]

### Recap: PCA ---

PCA is a linear dimensionality reduction technique

If data lies on a non-linear manifold, PCA may not be able to capture its structure.

Many non-linear dimension reduction techniques exist, e.g.,

- Kernel PCA
- ISOMAP
- Locally linear embedding
- Hessian eigenmaps
- Diffusion maps
- Maximum variance unfolding
- ...

### Recap: PCA ---

**Idea:** To make PCA non-linear, we *implicitly* map the data to a higher dimensional space and perform PCA there ("kernel trick").

Solving PCA via  $X^T X$  instead of  $XX^T$  is called **linear kernel PCA**

This eigendecomposition only depends on inner products:

$$(XX^T)_{ik} = \langle x_i, x_k \rangle$$

We can replace this with a kernel matrix

$$K(i, k) = \langle \Phi(x_i), \Phi(x_k) \rangle.$$

Several non-linear dimensionality reduction methods can be viewed as kernel PCA with kernels learned from the data (see Ham et al. 2003).

## Local Linear Embedding (LLE) ---

![Diagram illustrating the Local Linear Embedding (LLE) process. On the left, the 'original data space' shows a 3D manifold (a twisted ribbon) with data points colored by cluster (blue, green, yellow, red). An arrow labeled 'LLE' points to the 'component space' on the right, which shows the data points flattened into a 2D plane while maintaining their relative positions and colors.](2236272d3b3db6e6363337f5a8db72f6_img.jpg)

original data space

LLE

component space

Diagram illustrating the Local Linear Embedding (LLE) process. On the left, the 'original data space' shows a 3D manifold (a twisted ribbon) with data points colored by cluster (blue, green, yellow, red). An arrow labeled 'LLE' points to the 'component space' on the right, which shows the data points flattened into a 2D plane while maintaining their relative positions and colors.

**Idea:** Find a low-dimensional representation that preserves neighborhood relations.

[from Ornek]

### Local Linear Embedding (LLE)

**Fig. 2.** Steps of locally linear embedding: (1) Assign neighbors to each data point  $\vec{X}_i$  (for example by using the  $K$  nearest neighbors). (2) Compute the weights  $W_{ij}$  that best linearly reconstruct  $\vec{X}_i$  from its neighbors, solving the constrained least-squares problem in Eq. 1. (3) Compute the low-dimensional embedding vectors  $\vec{Y}_i$  best reconstructed by  $W_{ij}$ , minimizing Eq. 2 by finding the smallest eigenmodes of the sparse symmetric matrix in Eq. 3. Although the weights  $W_{ij}$  and vectors  $Y_i$  are computed by methods in linear algebra, the constraint that points are only reconstructed from neighbors can result in highly nonlinear embeddings.

![Diagram illustrating the three steps of Local Linear Embedding (LLE). Step 1: 'Select neighbors' shows a point X_i and its K nearest neighbors. Step 2: 'Reconstruct with linear weights' shows a point X_i being reconstructed from its neighbors X_j and X_k with weights W_ij and W_ik. Step 3: 'Map to embedded coordinates' shows the points X_i and X_j being mapped to a lower-dimensional space as Y_i and Y_j, maintaining the same linear reconstruction weights W_ij and W_ik.](4ee27dbf5ef12e7b58b0ef0937bc5a5e_img.jpg)

The diagram illustrates the three steps of Local Linear Embedding (LLE):

- 1 Select neighbors**: A point  $\vec{X}_i$  is shown with its  $K$  nearest neighbors.
- 2 Reconstruct with linear weights**: The point  $\vec{X}_i$  is reconstructed from its neighbors  $\vec{X}_j$  and  $\vec{X}_k$  using weights  $W_{ij}$  and  $W_{ik}$ .
- 3 Map to embedded coordinates**: The points  $\vec{X}_i$  and  $\vec{X}_j$  are mapped to a lower-dimensional space as  $\vec{Y}_i$  and  $\vec{Y}_j$ , maintaining the same linear reconstruction weights  $W_{ij}$  and  $W_{ik}$ .

Diagram illustrating the three steps of Local Linear Embedding (LLE). Step 1: 'Select neighbors' shows a point X\_i and its K nearest neighbors. Step 2: 'Reconstruct with linear weights' shows a point X\_i being reconstructed from its neighbors X\_j and X\_k with weights W\_ij and W\_ik. Step 3: 'Map to embedded coordinates' shows the points X\_i and X\_j being mapped to a lower-dimensional space as Y\_i and Y\_j, maintaining the same linear reconstruction weights W\_ij and W\_ik.

[from Roweis]

### Local Linear Embedding (LLE)

**Fig. 2.** Steps of locally linear embedding: (1) Assign neighbors to each data point  $\bar{X}_i$  (for example by using the  $K$  nearest neighbors). (2) Compute the weights  $W_{ij}$  that best lin-

![Diagram illustrating step 1 of LLE: Select neighbors. A 2D plot shows data points as circles. A central point is labeled X_i. A dashed arc indicates a neighborhood around it, with several points inside being its neighbors. A label '1 Select neighbors' is in the top right.](177e8bc1c595b7fe3461d9919f87e044_img.jpg)

Diagram illustrating step 1 of LLE: Select neighbors. A 2D plot shows data points as circles. A central point is labeled X\_i. A dashed arc indicates a neighborhood around it, with several points inside being its neighbors. A label '1 Select neighbors' is in the top right.

Extract local feature / local fit

Make sure that it is preserved in lower dimension

reconstructed by  $W_{ij}$ , minimizing Eq. 2 by finding the smallest eigenmodes of the sparse symmetric matrix in Eq. 3. Although the weights  $W_{ij}$  and vectors  $Y_i$  are computed by methods in linear algebra, the constraint that points are only reconstructed from neighbors can result in highly nonlinear embeddings.

![Diagram illustrating step 3 of LLE: Map to embedded coordinates. The top part shows the original 2D space with points and weights W_ik, W_ij. The bottom part shows the embedded 2D space with points Y_i, Y_k, Y_j and the same weights W_ik, W_ij connecting them. A label '3 Map to embedded coordinates' is in the bottom right.](239211fa511b4ffa685b54b5132ec927_img.jpg)

Diagram illustrating step 3 of LLE: Map to embedded coordinates. The top part shows the original 2D space with points and weights W\_ik, W\_ij. The bottom part shows the embedded 2D space with points Y\_i, Y\_k, Y\_j and the same weights W\_ik, W\_ij connecting them. A label '3 Map to embedded coordinates' is in the bottom right.

[from Roweis]

### Local Linear Embedding (LLE)

### LLE ALGORITHM

1. Compute the neighbors of each data point,  $\mathbf{x}_i$ .
2. Compute the weights  $w_{ij}$  that best reconstruct each data point  $\mathbf{x}_i$  from its neighbors, minimizing the cost in eq. (1) by constrained linear fits.
3. Compute the vectors  $\mathbf{y}_i$  best reconstructed by the weights  $w_{ij}$ , minimizing the quadratic form in eq. (2) by its bottom nonzero eigenvectors.

$$R(W) = \sum_{i=1}^n \left\| \mathbf{x}_i - \sum_{j \in N_i} w_{ij} \mathbf{x}_j \right\|^2 \quad \sum_{j \in N_i} w_{ij} = 1 \quad (1)$$

$$\Phi(Y) = \sum_{i=1}^n \left\| \mathbf{y}_i - \sum_{j \in N_i} w_{ij} \mathbf{y}_j \right\|^2 \quad (2)$$

### Local Linear Embedding (LLE)

1. Compute the neighborhood  $N_i$  of each data point  $\mathbf{x}_i$ .
2. Compute the reconstruction weights  $w_{ij}$  that best fit  $\mathbf{x}_i$  from its neighborhood  $N_i$ .
3. Compute the low-dimensional embedding  $\mathbf{y}_i$  by minimizing the reconstruction error, i.e., minimizing the quantity  $\sum_{i=1}^n \|\mathbf{x}_i - \sum_{j \in N_i} w_{ij} \mathbf{x}_j\|^2$ .

Reconstruction errors obey an important symmetry: for any particular data point, they are *invariant* to rotations, rescalings, and translations of that data point and its neighbors.

--> Reconstruction weights characterize intrinsic geometric properties of each neighborhood (independent of frame of reference).

st  $\mathbf{x}_i$  from  
near fits.  
minimizing  
ors.

$$R(W) = \sum_{i=1}^n \left\| \mathbf{x}_i - \sum_{j \in N_i} w_{ij} \mathbf{x}_j \right\|^2 \quad \sum_{j \in N_i} w_{ij} = 1 \quad (1)$$

$$\Phi(Y) = \sum_{i=1}^n \left\| \mathbf{y}_i - \sum_{j \in N_i} w_{ij} \mathbf{y}_j \right\|^2 \quad (2)$$

### Local Linear Embedding (LLE)

The reconstruction weights for each data point are computed from its local neighborhood - independent of the weights for other data points.

1. Compute the local neighborhood for each data point.
2. Compute the reconstruction weights  $w_{ij}$  that best fit  $\mathbf{x}_i$  from its neighborhood.
3. Compute the embedding coordinates  $\mathbf{y}_i$  by minimizing the reconstruction error, leveraging overlapping local information to discover global structure.

However, the embedding coordinates are computed by an  $N \times N$  eigensolver, coupling all data points. This is how the algorithm leverages overlapping local information to discover global structure.

$$R(W) = \sum_{i=1}^n \left\| \mathbf{x}_i - \sum_{j \in N_i} w_{ij} \mathbf{x}_j \right\|^2 \quad \sum_{j \in N_i} w_{ij} = 1 \quad (1)$$

$$\Phi(Y) = \sum_{i=1}^n \left\| \mathbf{y}_i - \sum_{j \in N_i} w_{ij} \mathbf{y}_j \right\|^2 \quad (2)$$

### Local Linear Embedding (LLE) ---

#### Step 2

$$R(W) = \sum_{i=1}^n \left\| \mathbf{x}_i - \sum_{j \in N_i} w_{ij} \mathbf{x}_j \right\|^2 = \sum_{i=1}^n R_i(\mathbf{x}_i, \mathbf{w}_i)$$

$$\text{subject to } \sum_{j \in N_i} w_{ij} = 1 \quad \forall i$$

Minimize using Lagrange multipliers:

$$g(W, \lambda_1, \dots, \lambda_n) = \sum_{i=1}^n g_i(\mathbf{w}_i, \lambda_i)$$

$$\text{with } g_i(\mathbf{w}_i, \lambda_i) = R_i(\mathbf{x}_i, \mathbf{w}_i) - \lambda_i (\mathbf{1}^\top \mathbf{w}_i - 1)$$

[derivation from Oldford]

### Local Linear Embedding (LLE) ---

$$R_i(\mathbf{x}_i, \mathbf{w}_i) = \|\mathbf{x}_i - \sum_{j \in N_i} w_{ij} \mathbf{x}_j\|^2 = \|\mathbf{x}_i - \mathbf{X}_i^T \mathbf{w}_i\|^2$$

$$\begin{aligned} R_i(\mathbf{x}_i, \mathbf{w}_i) &= (\mathbf{x}_i - \mathbf{X}_i^T \mathbf{w}_i)^T (\mathbf{x}_i - \mathbf{X}_i^T \mathbf{w}_i) \\ &= \mathbf{x}_i^T \mathbf{x}_i - \mathbf{x}_i^T \mathbf{X}_i^T \mathbf{w}_i - \mathbf{w}_i^T \mathbf{X}_i \mathbf{x}_i + \mathbf{w}_i^T \mathbf{X}_i \mathbf{X}_i^T \mathbf{w}_i \\ &= \mathbf{w}_i^T (1 \mathbf{x}_i^T \mathbf{x}_i 1^T - 1 \mathbf{x}_i^T \mathbf{X}_i^T - \mathbf{X}_i \mathbf{x}_i 1^T + \mathbf{X}_i \mathbf{X}_i^T) \mathbf{w}_i \\ &= \mathbf{w}_i^T C \mathbf{w}_i \end{aligned}$$

$C$  is a matrix of inner products with  $(j, k)$  element

$$c_{jk} = (\mathbf{x}_i - \mathbf{x}_j)^T (\mathbf{x}_i - \mathbf{x}_k) \text{ for } j, k \in N_i$$

[derivation from Oldford]

### Local Linear Embedding (LLE) ---

$$\frac{\partial g_i(\mathbf{w}_i, \lambda_i)}{\partial \mathbf{w}_i} = 2C\mathbf{w}_i - \lambda_i \mathbf{1}$$

which when set to zero yields

$$\mathbf{w}_i \propto C^{-1} \mathbf{1}$$

Together with the constraint that  $\mathbf{1}^T \mathbf{w}_i$ , this gives

$$\mathbf{w}_i = \frac{C^{-1} \mathbf{1}}{\mathbf{1}^T C^{-1} \mathbf{1}}$$

If the covariance matrix is singular or nearly singular

$$C_{new} = C + \frac{\Delta^2}{k} I_k$$

[derivation from Oldford]

### Local Linear Embedding (LLE) ---

#### Step 3

Find  $n \times p$  matrix  $Y = [\mathbf{y}_1 | \dots | \mathbf{y}_n]^T$  which minimizes

$$\Phi(Y) = \sum_{i=1}^n \|\mathbf{y}_i - \sum_{j \in N_i} w_{ij} \mathbf{y}_j\|^2$$

Let  $\mathbf{w}_i^T = (w_{i1}, w_{i2}, \dots, w_{in})$  where  $w_{ij} = 0$  when  $j \notin N_i$ .

$$\Phi(Y) = \sum_{i=1}^n \|\mathbf{y}_i - Y^T \mathbf{w}_i\|^2$$

[derivation from Oldford]

### Local Linear Embedding (LLE) ---

$$\begin{aligned}\Phi(Y) &= \sum_{i=1}^n (\mathbf{y}_i - Y^T \mathbf{w}_i)^T (\mathbf{y}_i - Y^T \mathbf{w}_i) \\&= \sum_{i=1}^n (\mathbf{y}_i^T \mathbf{y}_i - \mathbf{w}_i^T Y \mathbf{y}_i - \mathbf{y}_i^T Y^T \mathbf{w}_i + \mathbf{w}_i^T Y Y^T \mathbf{w}_i) \\&= \left(\sum_{i=1}^n \mathbf{y}_i^T \mathbf{y}_i\right) - \left(\sum_{i=1}^n \mathbf{w}_i^T Y \mathbf{y}_i\right) - \left(\sum_{i=1}^n \mathbf{y}_i^T Y^T \mathbf{w}_i\right) + \left(\sum_{i=1}^n \mathbf{w}_i^T Y Y^T \mathbf{w}_i\right)\end{aligned}$$

Each term in the sum is a quadratic form  $\sum_{i=1}^n \mathbf{a}_i^T M \mathbf{b}_i$

[derivation from Oldford]

### Local Linear Embedding (LLE) ---

So, for any matrices  $A = [\mathbf{a}_1 | \dots | \mathbf{a}_n]^T$  and  $B = [\mathbf{b}_1 | \dots | \mathbf{b}_n]^T$  whose  $n$  rows are the  $\mathbf{a}_i^T$ s and  $\mathbf{b}_i^T$ s, we have:

$$\sum_{i=1}^n \mathbf{a}_i^T M \mathbf{b}_i = \text{tr}(AMB^T)$$

So letting  $W = [\mathbf{w}_1 | \dots | \mathbf{w}_n]^T$ , we can now write

$$\begin{aligned}\Phi(Y) &= \sum_{i=1}^n (\mathbf{y}_i^T \mathbf{y}_i - \mathbf{w}_i^T Y \mathbf{y}_i - \mathbf{y}_i^T Y^T \mathbf{w}_i + \mathbf{w}_i^T Y Y^T \mathbf{w}_i) \\ &= \text{tr}(Y Y^T - W Y Y^T - Y Y^T W^T + W Y Y^T W^T) \\ &= \text{tr}\{(Y - W Y)(Y^T - Y^T W^T)\} \\ &= \text{tr}\{(I_n - W) Y Y^T (I_n - W)^T\} \\ &= \text{tr}\{(I_n - W)^T (I_n - W) Y Y^T\} \\ &= \text{tr}\{Y^T (I_n - W)^T (I_n - W) Y\}\end{aligned}$$

[derivation from Oldford]

### Local Linear Embedding (LLE)

$$\Phi(Y) = \text{tr}\{Y^T M Y\} = Y_1^T M Y_1 + \dots + Y_p^T M Y_p$$

with  $Y_i^T Y_j = 0 \text{ if } i \neq j, Y_i^T Y_i = 1$ , and  $\mathbf{1}_n^T Y_j = 0$ .

$$\begin{aligned} Y^T Y &= I_p \\ (I_n - W)(Y_j - a\mathbf{1}) &= (I_n - W)Y_j - \mathbf{0} \\ (I_n - W)\mathbf{1} &= \mathbf{0} \end{aligned}$$

The solution consists of the  $p$  eigenvectors of  $M$  orthogonal to  $\mathbf{1}$  corresponding to the smallest eigenvalues.

The columns of  $Y$  are these eigenvectors and the new locations (in  $p$  dimensions) are the corresponding rows  $y_1^T, \dots, y_n^T$ .

[derivation from Oldford]

### Local Linear Embedding (LLE) ---

### LLE ALGORITHM

1. Compute the neighbors of each data point,  $\mathbf{X}_i$ .
2. Compute the weights  $w_{ij}$  that best reconstruct each data point  $\mathbf{X}_i$  from its neighbors, minimizing the cost in eq. (1) by constrained linear fits.
3. Compute the vectors  $\mathbf{y}_i$  best reconstructed by the weights  $w_{ij}$ , minimizing the quadratic form in eq. (2) by its bottom nonzero eigenvectors.

Step 1:  $O(dn^2)$  (with kd-trees often  $O(n \log n)$ )

Step 2:  $O(dnk^3)$

Step 3:  $O(dn^2)$  (methods from sparse eigenproblems can reduce it further)

#### LLE from Pairwise Distances ---

LLE can be applied to user input in the form of pairwise distances. In this case, nearest neighbors are identified by the smallest non-zero elements of each row in the distance matrix.

To derive the reconstruction weights for each data point, we need to compute the local covariance matrix between its nearest neighbors.

$$c_{jk} = \frac{1}{2} (D_j + D_k - D_{jk} - D_0)$$

where  $D_{jk}$  denotes the squared distance between the  $j$ th and  $k$ th neighbors,  $D_\ell = \sum_z D_{\ell z}$  and  $D_0 = \sum_{jk} D_{jk}$ .

### Kernel View on LLE ---

Coordinates of the eigenvectors 2, ..., p+1 provide the LLE embedding (see Ham et al. 2003).

$$K := (\lambda_{max}I - M)$$

with

$$M := (I - W)(I - W^T)$$

with weight matrix  $W$  whose  $i$ th row contains the linear coefficients that sum to unity and optimally reconstruct  $x_i$  from its  $p$  nearest neighbors.

### Limitations of LLE ---

- Sensitivity to noise
- Sensitivity to non-uniform sampling of the manifold
- Does not provide a mapping (though one can be learned in a supervised fashion from the pairs  $\{X_i, Y_i\}$ )
- Quadratic complexity on the training set size
- Unlike ISOMAP, no robust method to compute the intrinsic dimensionality, and
- No robust method to define the neighborhood size  $K$

[from L26: Advanced dimensionality reduction]

## Applications

![Diagram illustrating the successful recovery of a manifold of known structure using LLE. The top part shows a 3D visualization of a manifold (a sphere with a hole) with red arrows indicating the mapping of corner faces. The bottom part shows a 2D visualization of the manifold (a square with a hole) with blue arrows indicating the mapping of corner faces. The middle part shows a sequence of grayscale images of a single face translated across a two-dimensional background of noise, with ellipses indicating intermediate images.](19f5ea8afbf380781eb0645831a88987_img.jpg)

The figure illustrates the successful recovery of a manifold of known structure using LLE. At the top, a 3D visualization shows a manifold (a sphere with a hole) with red arrows indicating the mapping of corner faces. At the bottom, a 2D visualization shows the manifold (a square with a hole) with blue arrows indicating the mapping of corner faces. In the middle, a sequence of grayscale images of a single face translated across a two-dimensional background of noise is shown, with ellipses indicating intermediate images. The mapping from the 3D manifold to the 2D manifold is shown by the blue arrows, which correctly identify the corner faces as the corners of the 2D embedding.

Diagram illustrating the successful recovery of a manifold of known structure using LLE. The top part shows a 3D visualization of a manifold (a sphere with a hole) with red arrows indicating the mapping of corner faces. The bottom part shows a 2D visualization of the manifold (a square with a hole) with blue arrows indicating the mapping of corner faces. The middle part shows a sequence of grayscale images of a single face translated across a two-dimensional background of noise, with ellipses indicating intermediate images.

Figure 5: Successful recovery of a manifold of known structure. Shown are the results of PCA (top) and LLE (bottom), applied to  $N=961$  grayscale images of a single face translated across a two dimensional background of noise. Such images lie on an intrinsically two dimensional manifold, but have an extrinsic dimensionality equal to the number of pixels in each image ( $D=3009$ ). Note how LLE (using  $K=4$  nearest neighbors) maps the images with corner faces to the corners of its two dimensional embedding ( $d=2$ ), while PCA fails to preserve the neighborhood structure of nearby images.

[from Roweis]

### Applications

![A scatter plot showing 17 face images mapped into a 2D embedding space using LLE. The points form a manifold with several branches. A solid line connects a sequence of points on the top-right branch, each accompanied by a small face image. Other face images are scattered throughout the plot, some near points and others along a horizontal line at the bottom.](1893e9dc091ea311057341f98b65310b_img.jpg)

A scatter plot representing the first two coordinates of an LLE embedding for 17 face images. The data points are black dots forming a complex, branching manifold. A solid line connects a series of points on the upper right branch, with small face images placed next to some of the points. Other face images are scattered throughout the plot, including a row of 17 small face images at the bottom.

A scatter plot showing 17 face images mapped into a 2D embedding space using LLE. The points form a manifold with several branches. A solid line connects a sequence of points on the top-right branch, each accompanied by a small face image. Other face images are scattered throughout the plot, some near points and others along a horizontal line at the bottom.

Fig. 3. Images of faces (17) mapped into the embedding space described by the first two coordinates of LLE. Representative faces are shown next to circled points in different parts of the space. The bottom images correspond to points along the top-right path (linked by solid line), illustrating one particular mode of variability in pose and expression.

[from Roweis]

### Applications

![A scatter plot showing high-resolution images of lips mapped into a 2D embedding space using LLE. The plot features a dense blue cluster of points on the left and a sparse, curved arrangement of red lip images on the right, representing different states of lip curvature. An inset in the bottom right shows a similar scatter plot for the entire dataset without the lip images.](b3459be722bb1ef785aa859e6f4ec7e4_img.jpg)

A scatter plot showing high-resolution images of lips mapped into a 2D embedding space using LLE. The plot features a dense blue cluster of points on the left and a sparse, curved arrangement of red lip images on the right, representing different states of lip curvature. An inset in the bottom right shows a similar scatter plot for the entire dataset without the lip images.

Figure 7: High resolution ( $D=65664$ ) images of lips, mapped into the embedding space discovered by the first two coordinates of LLE, using  $K=24$  nearest neighbors. Representative lips are shown at different points in the space. The inset shows the first two LLE coordinates for the entire data set ( $N=15960$ ) without any corresponding images.

[from Roweis]

### Applications

**Fig. 4.** Arranging words in a continuous semantic space. Each word was initially represented by a high-dimensional vector that counted the number of times it appeared in different encyclopedia articles. LLE was applied to these word-document count vectors (12), resulting in an embedding location for each word. Shown are words from two different bounded regions (A) and (B) of the embedding space discovered by LLE. Each panel shows a two-dimensional projection onto the third and fourth coordinates of LLE, in these two dimensions, the regions (A) and (B) are highly overlapped. The inset in (A) shows a three-dimensional projection onto the third, fourth, and fifth coordinates, revealing an extra dimension along which regions (A) and (B) are more separated. Words that lie in the intersection of both regions are capitalized.

![Figure 4: Two panels (A and B) showing word embeddings in a 2D projection of a 5D space. Panel A shows art-related words, Panel B shows political and military words. An inset in A shows a 3D view.](a844248c1fa0a79f187fc9aa111182f7_img.jpg)

**Panel A: Art and Culture Region**

- television, image, master
- film, academy, paintings, gallery, furniture, artists, decorative, artist, fine, painter, scene, portrait, styles, PAINTING, LANDSCAPE, FIGURES, pieces, design, FIGURE, garden, Florence, glass, objects, subject, design, classical, reflected, contemporary, london, paris, medieval, ages, ITALIAN, middle, ITALY
- tube, colors, light, sound
- radio

**Panel B: Politics and Military Region**

- LANDSCAPE, PAINTING, subjects, FIGURES, architectural, FIGURE, house, houses, law, election, congress, conference, constitution, president, justice, federal, representative, executive, ITALIAN, staff, parties, voters, weapons, majority, election, navy, defense, political, american, military, france, russia, united, britain, forces, government, front, french, world, allied, troops, japan, british, german, army, battle, air, nuclear, commander

**Intersection (Capitalized Words):** LANDSCAPE, PAINTING, subjects, FIGURES, architectural, FIGURE, house, houses

Figure 4: Two panels (A and B) showing word embeddings in a 2D projection of a 5D space. Panel A shows art-related words, Panel B shows political and military words. An inset in A shows a 3D view.

[from Roweis]

## Conclusion ---

LLE illustrates a general principle of manifold learning, elucidated by Tenenbaum et al., that overlapping local neighborhoods—collectively analyzed—can provide information about global geometry.

As more dimensions are added to the embedding space, the existing ones do not change.

A virtue of LLE is that it avoids the need to solve large dynamic programming problems.

Many more non-linear embedding techniques exist.

**Next lecture:** t-SNE