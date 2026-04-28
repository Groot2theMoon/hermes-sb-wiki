---
title: "ML2 - Lecture 02"
source: lecture
ingested: 2026-04-28
sha256: 2321756079d440d751857d474f1b2c39c17d277c1c352d454366ffcd465e5e64
---



# Dimension Reduction & Visualization

MDS, Isomap, SNE, t-SNE, Non-Metricity, Multiple t-SNE

---

![Logo of the Technical University of Berlin (TU Berlin), featuring a stylized red 'TU' and the word 'berlin' in white on a red background.](30a26f2d17ca95672702bf50fb4f0242_img.jpg)

Logo of the Technical University of Berlin (TU Berlin), featuring a stylized red 'TU' and the word 'berlin' in white on a red background.

![A 2D visualization of a high-dimensional dataset using a dimension reduction technique, showing a complex landscape with multiple peaks and valleys represented by different colors (blue, green, yellow, red).](21ac95be2778732e577d82233d5ee6ab_img.jpg)

A 2D visualization of a high-dimensional dataset using a dimension reduction technique, showing a complex landscape with multiple peaks and valleys represented by different colors (blue, green, yellow, red).

![Logo of Korea University, featuring a shield with a tiger and the text 'KOREA UNIVERSITY' and '1905'.](5fb340ad68b0c71df0b56698b137e35b_img.jpg)

Logo of Korea University, featuring a shield with a tiger and the text 'KOREA UNIVERSITY' and '1905'.

## Linear methods of reducing dimensionality ---

- PCA finds the directions that have the most variance.
  - By representing where each datapoint is along these axes, we minimize the squared reconstruction error.
  - Linear autoencoders are equivalent to PCA
- Multi-Dimensional Scaling arranges the low-dimensional points so as to minimize the discrepancy between the pairwise distances in the original space and the pairwise distances in the low-D space.

![Heatmap visualization](505116873ad67b610dfceb37016d04a3_img.jpg)

Heatmap visualization

### Metric Multi-Dimensional Scaling ---

- Find low dimensional representatives,  $y$ , for the high-dimensional data-points,  $x$ , that preserve pairwise distances as well as possible.
- An obvious approach is to start with random vectors for the  $y$ 's and then perform steepest descent by following the gradient of the cost function.
- Since we are minimizing squared errors, maybe this has something to do with PCA?
  - If so, we don't need an iterative method to find the best embedding.

$$Cost = \sum_{i < j} (d_{ij} - \hat{d}_{ij})^2$$

$$d_{ij} = \|x_i - x_j\|^2$$

$$\hat{d}_{ij} = \|y_i - y_j\|^2$$

![Heatmap visualization](9455ca65b9fc488df790769b0122628e_img.jpg)

Heatmap visualization

## Converting metric MDS to PCA ---

- If the data-points all lie on a hyperplane, their pairwise distances are perfectly preserved by projecting the high-dimensional coordinates onto the hyperplane.
  - So in that particular case, PCA is the right solution.
- If we “double-center” the data, metric MDS is equivalent to PCA.
  - Double centering means making the mean value of every row and column be zero.
  - But double centering can introduce spurious structure.

![Heatmap visualization](f961cbef0f8217e216b553bed270315b_img.jpg)

Heatmap visualization

## Other non-linear methods of reducing dimensionality

- Non-linear autoencoders with extra layers are much more powerful than PCA but they can be slow to optimize and they get different, locally optimal solutions each time.
- **Multi-Dimensional Scaling** can be made non-linear by putting more importance on the small distances. A popular version is the Sammon mapping:

$$Cost = \sum_{ij} \left( \frac{\begin{array}{c} \text{high-D} \\ \text{distance} \\ \downarrow \\ \|\mathbf{x}_i - \mathbf{x}_j\| \end{array} - \begin{array}{c} \text{low-D} \\ \text{distance} \\ \downarrow \\ \|\mathbf{y}_i - \mathbf{y}_j\| \end{array}}{\|\mathbf{x}_i - \mathbf{x}_j\|} \right)^2$$

- Non-linear MDS is also slow to optimize and also gets stuck in different local optima each time.

[From Hinton]

### IsoMap: Local MDS without local optima

- Instead of only modeling local distances, we can try to measure the distances along the manifold and then model these intrinsic distances.
  - The main problem is to find a robust way of measuring distances along the manifold.
  - If we can measure manifold distances, the global optimisation is easy: It's just global MDS (i.e. PCA)

If we measure distances along the manifold,  
 $d(1,6) > d(1,4)$

![A 2D scatter plot showing six points labeled 1 through 6. Points 1 and 2 are red, 3 and 4 are green, and 5 and 6 are blue. Point 1 is at the top right, point 2 is to its left, point 3 is below point 2, point 4 is below point 3, point 5 is to the right of point 4, and point 6 is to the right of point 5. The points are arranged in a roughly circular fashion, suggesting a manifold structure.](46f43cb4ffd47565e7c0ca306d461435_img.jpg)

2-D

A 2D scatter plot showing six points labeled 1 through 6. Points 1 and 2 are red, 3 and 4 are green, and 5 and 6 are blue. Point 1 is at the top right, point 2 is to its left, point 3 is below point 2, point 4 is below point 3, point 5 is to the right of point 4, and point 6 is to the right of point 5. The points are arranged in a roughly circular fashion, suggesting a manifold structure.

![A 1D scatter plot showing the same six points from the 2D plot, but now arranged in a single horizontal line. From left to right, the points are: blue (5), blue (6), green (3), green (4), red (2), and red (1). This illustrates the result of a global MDS or PCA projection.](ac99eff233b8fe51d30f499e7413c345_img.jpg)

1-D

A 1D scatter plot showing the same six points from the 2D plot, but now arranged in a single horizontal line. From left to right, the points are: blue (5), blue (6), green (3), green (4), red (2), and red (1). This illustrates the result of a global MDS or PCA projection.

[From Hinton]

### How Isomap measures intrinsic distances ---

- Connect each datapoint to its  $K$  nearest neighbors in the high-dimensional space.
- Put the true Euclidean distance on each of these links.
- Then approximate the manifold distance between any pair of points as the shortest path in this “neighborhood graph”.

![A diagram illustrating a neighborhood graph on a manifold. The graph consists of black nodes (datapoints) and black edges (links between neighbors). A specific path between two nodes, labeled A and B, is highlighted in red. Node A is at the top right, and node B is below it. The red path follows the manifold's surface, while a direct black line would cut across the manifold's interior.](a738993919a50143787084ee7ce6e2f2_img.jpg)

A diagram illustrating a neighborhood graph on a manifold. The graph consists of black nodes (datapoints) and black edges (links between neighbors). A specific path between two nodes, labeled A and B, is highlighted in red. Node A is at the top right, and node B is below it. The red path follows the manifold's surface, while a direct black line would cut across the manifold's interior.

### Using Isomap to discover the intrinsic manifold in a set of face images

![A 3x4 grid of 12 grayscale face images showing different poses and lighting conditions. Each image is accompanied by a small circular icon with a clockwise arrow. The images are surrounded by numerous small black dots representing data points in a high-dimensional space, which are being mapped onto a 2D surface (the manifold) using Isomap.](3121afa7ca030b22ee0345864ca6f38b_img.jpg)

The figure illustrates the result of using Isomap to discover the intrinsic manifold of a set of face images. It shows a 3x4 grid of 12 grayscale face images, each representing a different pose or lighting condition. Each image is accompanied by a small circular icon with a clockwise arrow. The images are surrounded by numerous small black dots representing data points in a high-dimensional space, which are being mapped onto a 2D surface (the manifold) using Isomap. The dots are clustered around each image, indicating the local neighborhood of each data point in the high-dimensional space.

A 3x4 grid of 12 grayscale face images showing different poses and lighting conditions. Each image is accompanied by a small circular icon with a clockwise arrow. The images are surrounded by numerous small black dots representing data points in a high-dimensional space, which are being mapped onto a 2D surface (the manifold) using Isomap.

[From Hinton]

![A 2x5 grid of face images showing linear interpolation between two faces. The top row shows a gradual morph from a man's face to a woman's face. The bottom row shows a similar morph, but the middle images appear blurry and lack fine detail. A 2x5 grid of hand images showing linear interpolation between two hands. The top row shows a morph from a clenched fist to an open hand. The bottom row shows a morph from an open hand to a different open hand pose, with the middle images appearing distorted and blurry. A 2x5 grid of handwritten digits. The top row shows a morph from a '2' to a '9', with the middle images being unrecognizable scribbles. The bottom row shows a morph from a '2' to another '2', where the middle images remain clearly recognizable as '2's.](fd955384881fd240be5518d3050588d9_img.jpg)

**A**

**B**

**C**

A 2x5 grid of face images showing linear interpolation between two faces. The top row shows a gradual morph from a man's face to a woman's face. The bottom row shows a similar morph, but the middle images appear blurry and lack fine detail. A 2x5 grid of hand images showing linear interpolation between two hands. The top row shows a morph from a clenched fist to an open hand. The bottom row shows a morph from an open hand to a different open hand pose, with the middle images appearing distorted and blurry. A 2x5 grid of handwritten digits. The top row shows a morph from a '2' to a '9', with the middle images being unrecognizable scribbles. The bottom row shows a morph from a '2' to another '2', where the middle images remain clearly recognizable as '2's.

Linear methods cannot interpolate properly between the leftmost and rightmost images in each row.

This is because the interpolated images are NOT averages of the images at the two ends.

Isomap does not interpolate properly either because it can only use examples from the training set. It cannot create new images.

But it is better than linear methods.

[From Hinton]

- Represents similarities between objects by measuring densities under Gaussians:

![Diagram illustrating stochastic neighbor selection. A square box contains several black dots representing data points. One dot is labeled x_i. A circle is drawn around x_i, encompassing several other dots. Two dots inside the circle are labeled x_j and x_l. Other dots outside the circle are also present, illustrating the selection of stochastic neighbors based on density.](7801d00a216dc4dc8a7d210dcb5fe3c5_img.jpg)

Diagram illustrating stochastic neighbor selection. A square box contains several black dots representing data points. One dot is labeled x\_i. A circle is drawn around x\_i, encompassing several other dots. Two dots inside the circle are labeled x\_j and x\_l. Other dots outside the circle are also present, illustrating the selection of stochastic neighbors based on density.

$$p_{ij} = \frac{\exp(-\|x_i - x_j\|^2/2\sigma^2)}{\sum_{k \neq l} \exp(-\|x_k - x_l\|^2/2\sigma^2)}$$

- This is so-called *stochastic neighbor selection*\*

\* If we are lucky, our data already has the form of  $p_{ij}$ 's!

- Defines similar probabilities in the map:

$$q_{ij} = \frac{\exp(-\|y_i - y_j\|^2)}{\sum_{k \neq l} \exp(-\|y_k - y_l\|^2)}$$

- Minimizes the KL divergence between the distributions in the high-dimensional space and the map:

$$KL(P||Q) = \sum_i \sum_j p_{ij} \log \frac{p_{ij}}{q_{ij}}$$

![Heatmap visualization](b712e7522f1bb7135730c7d1abb46d43_img.jpg)

Heatmap visualization

### SNE optimization ---

$$C = \sum_i KL(P_i || Q_i) = \sum_i \sum_j p_{j|i} \log \frac{p_{j|i}}{q_{j|i}},$$

$$\frac{\delta C}{\delta y_i} = 2 \sum_j (p_{j|i} - q_{j|i} + p_{i|j} - q_{i|j})(y_i - y_j).$$

$$\mathcal{Y}^{(t)} = \mathcal{Y}^{(t-1)} + \eta \frac{\delta C}{\delta \mathcal{Y}} + \alpha(t) (\mathcal{Y}^{(t-1)} - \mathcal{Y}^{(t-2)}),$$

Physically, the gradient may be interpreted as the resultant force created by a set of springs between the map point  $y_i$  and all other map points  $y_j$ . All springs exert a force along the direction  $(y_i - y_j)$ . The spring between  $y_i$  and  $y_j$  repels or attracts the map points depending on whether the distance between the two in the map is too small or too large to represent the similarities between the two high-dimensional datapoints. The force exerted by the spring between  $y_i$  and  $y_j$  is proportional to its length, and also proportional to its stiffness, which is the mismatch  $(p_{j|i} - q_{j|i} + p_{i|j} - q_{i|j})$  between the pairwise similarities of the data points and the map points.

### Crowding Problem ---

- Suppose we have datapoints that are sampled uniformly from a hypercube
- Also suppose we perfectly modeled the local structure of this data in the map (which is usually impossible)
- Result: dissimilar points have to be modeled as **too far apart** in the map
- Resulting forces ‘crush together’ the map

![Small visualization showing a 2D map with a color gradient (red to blue) and a circular highlight, illustrating the crowding problem.](98ee20ceb85cd84e2415b20b1eda1bcf_img.jpg)

Small visualization showing a 2D map with a color gradient (red to blue) and a circular highlight, illustrating the crowding problem.

- Uses a heavy-tailed distribution in the map

$$q_{ij} = \frac{(1 + \|y_i - y_j\|^2)^{-1}}{\sum_{k \neq l} (1 + \|y_k - y_l\|^2)^{-1}}$$

- As a result, dissimilar objects are allowed to be modeled too far apart
- This eliminates the crowding problem!

![Heatmap visualization](bafe3c344aef7f6f79dab49c9eca89a9_img.jpg)

Heatmap visualization

#### Algorithm ---

#### --- Algorithm 1: Simple version of t-Distributed Stochastic Neighbor Embedding. ---

**Data:** data set  $\mathcal{X} = \{x_1, x_2, \dots, x_n\}$ ,

cost function parameters: perplexity  $Perp$ ,

optimization parameters: number of iterations  $T$ , learning rate  $\eta$ , momentum  $\alpha(t)$ .

**Result:** low-dimensional data representation  $\mathcal{Y}^{(T)} = \{y_1, y_2, \dots, y_n\}$ .

**begin**

compute pairwise affinities  $p_{j|i}$  with perplexity  $Perp$  (using Equation 1)

set  $p_{ij} = \frac{p_{j|i} + p_{i|j}}{2n}$

sample initial solution  $\mathcal{Y}^{(0)} = \{y_1, y_2, \dots, y_n\}$  from  $\mathcal{N}(0, 10^{-4}I)$

**for**  $t=1$  **to**  $T$  **do**

compute low-dimensional affinities  $q_{ij}$  (using Equation 4)

compute gradient  $\frac{\partial C}{\partial \mathcal{Y}}$  (using Equation 5)

set  $\mathcal{Y}^{(t)} = \mathcal{Y}^{(t-1)} + \eta \frac{\partial C}{\partial \mathcal{Y}} + \alpha(t) (\mathcal{Y}^{(t-1)} - \mathcal{Y}^{(t-2)})$

**end**

**end**

![Heatmap visualization](d29d72755dd131d215d854aaf90fea3e_img.jpg)

Heatmap visualization

## Experiment ---

- MNIST dataset (10 classes, 70,000 images)

3 6 8 1 7 9 6 6 9 1  
6 7 5 7 8 6 3 4 8 5  
2 1 7 9 7 1 2 8 4 5  
4 8 1 9 0 1 8 8 9 4  
7 6 1 8 6 4 1 5 6 0  
7 5 9 2 6 5 8 1 9 7  
2 2 2 2 2 3 4 4 8 0  
0 2 3 8 0 7 3 8 5 7  
0 1 4 6 4 6 0 2 4 3  
7 1 2 8 7 6 9 8 6 1

![Logo of the Technical University of Berlin (TU Berlin), featuring a stylized 'TU' in red and black, with a small colorful graphic to the right.](e95f47f7a4c01c8889d6d46919b4c73d_img.jpg)

Logo of the Technical University of Berlin (TU Berlin), featuring a stylized 'TU' in red and black, with a small colorful graphic to the right.

### PCA

![PCA scatter plot of handwritten digits 0-9.](af06598cfb31b517e79b50d74f72a0ca_img.jpg)

A scatter plot illustrating the results of Principal Component Analysis (PCA) on a dataset of handwritten digits (0-9). The plot shows the data points clustered in a 2D space, with a legend on the left indicating the color mapping for each digit. The clusters are roughly: 0 (red, left), 1 (orange, right), 2 (yellow, bottom), 3 (green, bottom-left), 4 (light green, bottom-center), 5 (cyan, bottom-center), 6 (blue, top-center), 7 (dark blue, top-center), 8 (purple, top-center), and 9 (pink, top-center). The digits 2-9 are more densely packed and overlap significantly, while digits 0 and 1 are more distinct.

[From vd Maaten]

PCA scatter plot of handwritten digits 0-9.

### LLE ---

![A scatter plot illustrating the Locally Linear Embedding (LLE) algorithm. The plot shows 10 classes of data points (0-9) in a 2D space. The points are colored according to their class: 0 (red), 1 (orange), 2 (yellow), 3 (green), 4 (light green), 5 (cyan), 6 (blue), 7 (dark blue), 8 (purple), and 9 (pink). The data is arranged in a complex, non-linear structure. A legend on the left side of the plot identifies the classes. The caption at the bottom reads '[From vd Maaten]'.](8ccbc9fa77bf60ba0ca0b79dec8681b8_img.jpg)

A scatter plot illustrating the Locally Linear Embedding (LLE) algorithm. The plot shows 10 classes of data points (0-9) in a 2D space. The points are colored according to their class: 0 (red), 1 (orange), 2 (yellow), 3 (green), 4 (light green), 5 (cyan), 6 (blue), 7 (dark blue), 8 (purple), and 9 (pink). The data is arranged in a complex, non-linear structure. A legend on the left side of the plot identifies the classes. The caption at the bottom reads '[From vd Maaten]'.

A scatter plot illustrating the Locally Linear Embedding (LLE) algorithm. The plot shows 10 classes of data points (0-9) in a 2D space. The points are colored according to their class: 0 (red), 1 (orange), 2 (yellow), 3 (green), 4 (light green), 5 (cyan), 6 (blue), 7 (dark blue), 8 (purple), and 9 (pink). The data is arranged in a complex, non-linear structure. A legend on the left side of the plot identifies the classes. The caption at the bottom reads '[From vd Maaten]'.

### t-SNE ---

![t-SNE visualization of handwritten digits 0-9.](3ae74a33759ae31781f484406db4feed_img.jpg)

A t-SNE visualization showing the distribution of handwritten digits (0-9) in a 2D space. The digits are clustered into distinct groups, illustrating the result of the dimensionality reduction. A legend on the right side of the plot maps colors to digit classes: 0 (red), 1 (orange), 2 (yellow), 3 (green), 4 (light green), 5 (cyan), 6 (blue), 7 (dark blue), 8 (purple), and 9 (pink). The clusters are arranged as follows: 0 is at the top; 1 is at the top right; 2 is at the middle right; 3 is at the top left; 4 is at the middle left; 5 is at the bottom left; 6 is at the bottom right; 7 is at the bottom right, below 6; 8 is at the bottom center; and 9 is at the bottom center, below 8. The text "[From vd Maaten]" is visible in the bottom left corner.

t-SNE visualization of handwritten digits 0-9.

![A scatter plot showing data points clustered into several distinct groups. An inset in the bottom right corner shows the same data points with each cluster colored differently (green, pink, purple, blue, cyan, magenta, orange, red, yellow) to illustrate the result of a clustering algorithm.](3102c32204f998dba666e1e915d5babf_img.jpg)

The figure displays a scatter plot of data points that are naturally grouped into several distinct clusters. The main plot shows all points in black. An inset in the bottom right corner shows the same data points, but each cluster is colored differently (green, pink, purple, blue, cyan, magenta, orange, red, yellow), demonstrating the output of a clustering algorithm that successfully identifies the inherent groupings.

A scatter plot showing data points clustered into several distinct groups. An inset in the bottom right corner shows the same data points with each cluster colored differently (green, pink, purple, blue, cyan, magenta, orange, red, yellow) to illustrate the result of a clustering algorithm.

[From vd Maaten]

![A collection of scatter plots showing various data distributions, including clusters, linear trends, and concentric rings. An inset in the bottom right shows a multi-colored version of one of the plots.](5ed9189841659dfb01f809b8e3b21f74_img.jpg)

This figure displays a variety of scatter plots illustrating different data distributions and clustering challenges:

- Top:** Two distinct, roughly elliptical clusters of points.
- Middle:** A series of plots showing more complex distributions, including multiple overlapping clusters and elongated, linear-like structures.
- Bottom Left:** A plot featuring concentric rings of data points, a classic challenge for clustering algorithms.
- Bottom Center:** A single, dense, roughly elliptical cluster.
- Bottom Right (Inset):** A colored version of a scatter plot showing several overlapping, elongated clusters in various colors (green, pink, blue, cyan, purple, orange, red, yellow).

A collection of scatter plots showing various data distributions, including clusters, linear trends, and concentric rings. An inset in the bottom right shows a multi-colored version of one of the plots.

[From vd Maaten]

![A collage of five scatter plots illustrating different data distributions and clustering methods. The top-left plot shows a single large cluster of points. The top-right plot shows a ring-shaped distribution of points. The bottom-left plot shows a large cluster of points with a smaller, distinct cluster of points inside it. The bottom-middle plot shows two separate clusters of points. The bottom-right plot shows a 2D scatter plot with points colored by cluster membership, showing several distinct clusters.](60e9207be66a64332619bb4b667fe67b_img.jpg)

[From vd Maaten]

A collage of five scatter plots illustrating different data distributions and clustering methods. The top-left plot shows a single large cluster of points. The top-right plot shows a ring-shaped distribution of points. The bottom-left plot shows a large cluster of points with a smaller, distinct cluster of points inside it. The bottom-middle plot shows two separate clusters of points. The bottom-right plot shows a 2D scatter plot with points colored by cluster membership, showing several distinct clusters.

![Visualization by t-SNE showing handwritten digits 0-9 in a 2D space. The digits are clustered into distinct groups: black digits (0, 4, 5, 6, 8, 9) are at the top and bottom, while colored digits (1: red, 2: blue, 3: green, 7: orange, 2: pink, 9: yellow) are on the left and right sides.](0f79a59f3766fc341ff688a23692c1d9_img.jpg)

Visualization by t-SNE showing handwritten digits 0-9 in a 2D space. The digits are clustered into distinct groups: black digits (0, 4, 5, 6, 8, 9) are at the top and bottom, while colored digits (1: red, 2: blue, 3: green, 7: orange, 2: pink, 9: yellow) are on the left and right sides.

(a) Visualization by t-SNE.

![Visualization by Sammon mapping showing handwritten digits 0-9 in a 2D space. The digits are more spread out than in the t-SNE visualization, with some clusters overlapping. The same color scheme for digits is used: black (0, 4, 5, 6, 8, 9), red (1), blue (2), green (3), orange (7), pink (2), and yellow (9).](9b5411fa2d169b66f6185fbf67b49766_img.jpg)

Visualization by Sammon mapping showing handwritten digits 0-9 in a 2D space. The digits are more spread out than in the t-SNE visualization, with some clusters overlapping. The same color scheme for digits is used: black (0, 4, 5, 6, 8, 9), red (1), blue (2), green (3), orange (7), pink (2), and yellow (9).

(b) Visualization by Sammon mapping.

![Visualization by Isomap showing handwritten digits 0-9 in a 2D space. The digits are arranged in a circular fashion: black digits (0, 4, 5, 6, 8, 9) are on the right side, and colored digits (1: red, 2: blue, 3: green, 7: orange, 2: pink, 9: yellow) are on the left side.](50fecd0e7c9bf4ebf321d8367d42cc94_img.jpg)

Visualization by Isomap showing handwritten digits 0-9 in a 2D space. The digits are arranged in a circular fashion: black digits (0, 4, 5, 6, 8, 9) are on the right side, and colored digits (1: red, 2: blue, 3: green, 7: orange, 2: pink, 9: yellow) are on the left side.

(c) Visualization by Isomap.

![Visualization by LLE showing handwritten digits 0-9 in a 2D space. The digits are clustered into distinct groups, similar to the t-SNE visualization. The same color scheme for digits is used: black (0, 4, 5, 6, 8, 9), red (1), blue (2), green (3), orange (7), pink (2), and yellow (9).](65a9654ccb3d0d452378b0f4c0c392f7_img.jpg)

Visualization by LLE showing handwritten digits 0-9 in a 2D space. The digits are clustered into distinct groups, similar to the t-SNE visualization. The same color scheme for digits is used: black (0, 4, 5, 6, 8, 9), red (1), blue (2), green (3), orange (7), pink (2), and yellow (9).

(d) Visualization by LLE.

[From vd Maaten]

### COIL-20 ---

![A 2D scatter plot visualization of the COIL-20 dataset, showing various objects clustered by color and shape.](df0685d2d1176d617ed1e642de4e5425_img.jpg)

A 2D scatter plot visualization of the COIL-20 dataset. The plot shows various objects, including cups, bowls, and other items, clustered into distinct groups based on their visual features. The clusters are color-coded: black (top center, bottom center, right), pink (left, top left, top right), red (center), blue (center, bottom left), and orange (center). Some points are marked with small crosses or arrows, indicating specific data points or transitions. The overall layout suggests a dimensionality reduction technique, likely t-SNE, used to visualize high-dimensional data in a 2D space.

A 2D scatter plot visualization of the COIL-20 dataset, showing various objects clustered by color and shape.

[From vd Maaten]

### 20-Newsgroups ---

![A scatter plot showing 20 clusters of data points, each representing a different newsgroup. The clusters are color-coded and labeled 1 through 20 in the legend. The axes range from -150 to 150 on both the x and y dimensions.](1d3994bfe548ae7545d57df703e32a02_img.jpg)

A scatter plot showing 20 clusters of data points, each representing a different newsgroup. The clusters are color-coded and labeled 1 through 20 in the legend. The axes range from -150 to 150 on both the x and y dimensions. The clusters are distributed across the plot, with some overlapping. The legend on the right side of the plot lists the 20 newsgroups and their corresponding colors and markers.

| Cluster | Color | Marker   |
|---------|-------|----------|
| 1       | Blue  | Circle   |
| 2       | Green | Circle   |
| 3       | Red   | Circle   |
| 4       | Blue  | Circle   |
| 5       | Red   | Triangle |
| 6       | Green | Circle   |
| 7       | Blue  | Circle   |
| 8       | Red   | Circle   |
| 9       | Green | Circle   |
| 10      | Blue  | Triangle |
| 11      | Red   | Circle   |
| 12      | Blue  | Circle   |
| 13      | Red   | Circle   |
| 14      | Green | Circle   |
| 15      | Blue  | Triangle |
| 16      | Red   | Circle   |
| 17      | Blue  | Circle   |
| 18      | Green | Circle   |
| 19      | Red   | Circle   |
| 20      | Blue  | Triangle |

A scatter plot showing 20 clusters of data points, each representing a different newsgroup. The clusters are color-coded and labeled 1 through 20 in the legend. The axes range from -150 to 150 on both the x and y dimensions.

[From vd Maaten]

\* Based on discLDA features (by Simon Lacoste-Julien).

## Analyzing Non-Euclidean Pairwise Data

Julian Laub<sup>1</sup> & Klaus-Robert Müller<sup>1,2</sup>

![Heatmap visualization](004a497465710d16d63f436bb330fb42_img.jpg)

Heatmap visualization

### Pairwise Similarity Data ---

1. Pairwise data occur in many fields: genomics, text mining, cognitive psychology, social sciences...
2. Pairwise data can be represented as undirected graphs, as tables (“matrices”) or as checkerboard patterns.
3. For a mathematical treatment, pairwise proximity data will be represented as a similarity matrix  $S = (s_{ij})$ ,  $s_{ij} \in \mathbb{R}$ , or a dissimilarity matrix  $D = (d_{ij})$ ,  $d_{ij} \in \mathbb{R}$ .
4. There are no formalized mathematical requirements on  $S$  or  $D$ . They may be very general and very hard to interpret.

![Heatmap visualization](6e5a85131eedf6b98db62877ee64506e_img.jpg)

Heatmap visualization

### Pairwise Data

#### Pairwise Data: Overview

![A figure showing three representations of pairwise data: a graph, a table, and a checkerboard pattern. The graph on the left shows five nodes (A, B, C, D, E) with weighted edges. The table in the middle shows a 5x5 matrix of these weights. The checkerboard pattern on the right is a visual representation of the matrix using grayscale colors.](abc0eb594f9d2c0daa0e60df05f2a666_img.jpg)

The figure illustrates three common ways to represent pairwise data between five elements (A, B, C, D, E):

- Graph (left):** A complete graph where nodes are arranged in a circle. Edges are labeled with their weights: A-B=10, A-C=7, A-D=9.5, A-E=14, B-C=5.5, B-D=9.9, B-E=5.4, C-D=4.4, C-E=7.2, D-E=9.2.
- Table (middle):** A symmetric matrix showing the pairwise distances between elements A, B, C, D, and E. The diagonal elements are 0.
- Checkerboard pattern (right):** A visual representation of the matrix where grayscale intensity corresponds to the distance value. Darker shades represent smaller distances, and lighter shades represent larger distances.

|   | A   | B   | C   | D   | E   |
|---|-----|-----|-----|-----|-----|
| A | 0   | 10  | 7   | 9.5 | 14  |
| B | 10  | 0   | 5.5 | 9.9 | 5.4 |
| C | 7   | 5.5 | 0   | 4.4 | 7.2 |
| D | 9.5 | 9.9 | 4.4 | 0   | 9.2 |
| E | 14  | 5.4 | 7.2 | 9.2 | 0   |

A figure showing three representations of pairwise data: a graph, a table, and a checkerboard pattern. The graph on the left shows five nodes (A, B, C, D, E) with weighted edges. The table in the middle shows a 5x5 matrix of these weights. The checkerboard pattern on the right is a visual representation of the matrix using grayscale colors.

Representation of pairwise data as a graph (left), a table (middle) or a checkerboard pattern (right).

#### Pairwise Data: metric violations ---

#### 1. Overview:

![A hierarchical diagram showing the classification of pairwise data. At the top is 'some D'. Below it are 'non-metric' and 'metric'. Below 'metric' are 'Euclidean' and 'other metric'. A curved arrow with a question mark points from 'Euclidean' to 'non-metric'.](dcb5711d118ae6753b0e12f86eda37db_img.jpg)

```
graph TD; someD((some D)) --> nonMetric((non-metric)); someD --> metric((metric)); metric --> Euclidean((Euclidean)); metric --> otherMetric((other metric)); Euclidean --> nonMetric; style someD fill:#fff,stroke:#000; style nonMetric fill:#fff,stroke:#000; style metric fill:#fff,stroke:#000; style Euclidean fill:#fff,stroke:#000; style otherMetric fill:#fff,stroke:#000;
```

A hierarchical diagram showing the classification of pairwise data. At the top is 'some D'. Below it are 'non-metric' and 'metric'. Below 'metric' are 'Euclidean' and 'other metric'. A curved arrow with a question mark points from 'Euclidean' to 'non-metric'.

#### 2. Example of metric violations:

- Noisy measurements.
- Intrinsic non-metricity in human similarity judgments, text-mining

#### 3. Non-metric pairwise data *cannot* be represented isometrically as vectors, even in high dimensions.

### Pairwise Data: metric violations ---

1. Let  $D = (d_{ij})$  be a dissimilarity matrix.  $D$  is called *metric* if the  $d_{ij}$ 's satisfy the following conditions:
  - (a)  $d_{ij} \geq 0 \forall i, j$ ,
  - (b)  $d_{ij} = 0$  iff  $i = j$ ,
  - (c)  $d_{ij} = d_{ji} \forall i, j$  and
  - (d)  $d_{ij} \leq d_{ik} + d_{ik} \forall i, j, k$ .
2. A dissimilarity matrix  $D = (d_{ij})$  is called *squared Euclidean* if and only if there exist vectors  $x_1, x_2, \dots, x_n \in \mathbb{R}^p$  such that  $d_{ij} = \|x_i - x_j\|_2^2$ , where  $\|\cdot\|_2$  denotes Euclidean norm.

![Heatmap visualization](20e597e389dfd8d131e05ad6e1617dcd_img.jpg)

Heatmap visualization

### Visualizing Metric Violations ---

1. Metric violations translate into indefinite pseudo-covariance matrices.
2. Algorithm:

$$D \xrightarrow{C = -\frac{1}{2}QDQ} C \text{ with } p \text{ positive and } q \text{ negative eigenvalues}$$

$$C \xrightarrow{\text{spectral decomposition}} V\Lambda V^T = V|\Lambda|^{\frac{1}{2}} M |\Lambda|^{\frac{1}{2}} V^T$$

$$X^* = |\Lambda|^{1/2} V^T$$

$$\text{where } Q = \left(I - \frac{1}{n}ee^t\right) \text{ and } M = \begin{pmatrix} I_{p \times p} & & \\ & -I_{q \times q} & \\ & & 0_{k \times k} \end{pmatrix}$$

3. Project onto  $\{v_1, v_2\}$ .
4. Project onto  $\{v_n, v_{n-1}\}$ .

![Heatmap visualization showing a 2D plot with concentric elliptical contours, likely representing a metric violation or distance function.](fbfbd4dd5363c5bd548a8e871d0fce40_img.jpg)

Heatmap visualization showing a 2D plot with concentric elliptical contours, likely representing a metric violation or distance function.

### Metric Violations Summary

![A diagram illustrating the process of metric violations summary, showing the flow from pairwise comparisons to dissimilarity matrices, then to an embedding procedure using a matrix C, and finally to projections onto different components like size and color.](b3459be722bb1ef785aa859e6f4ec7e4_img.jpg)

The diagram illustrates the process of metric violations summary:

- Input:** A set of objects (represented by green and red spheres) with a central question mark, indicating pairwise comparisons.
- Pairwise comparison by some algorithm:** This leads to a similarity matrix  $S$  or a dissimilarity matrix  $D$ .
- Define dissimilarity:** The dissimilarity matrix  $D$  is defined as  $D = 1 - S$  or  $d_{ij} = -\log(s_{ij})$ .
- Embedding procedure:** This leads to a matrix  $C = -\frac{1}{2}QDQ$ .
- Spectrum of  $C$ :** This leads to a plot of Eigenvalues versus the Index of ordered ev's.
- Projection:** This leads to a plot of the Second component versus the First component: Size.
- Projection via shift or Pseudo-Euclidian space:** This leads to a plot of the Last component: color versus the Second last component.

A diagram illustrating the process of metric violations summary, showing the flow from pairwise comparisons to dissimilarity matrices, then to an embedding procedure using a matrix C, and finally to projections onto different components like size and color.

### Feature Discovery: Examples ---

1. **USPS handwritten digits.** The similarity matrix is obtained from binary image matching on the digits 0 and 7 of the USPS data set.

![A 10x10 grid of handwritten digits from the USPS dataset, showing clusters of '0's and '7's.](82c2ebb7e3c8b55a525d6b91748243f4_img.jpg)

A 10x10 grid of handwritten digits from the USPS dataset. The digits are arranged in a grid where similar digits are clustered together. The top-left 5x5 area contains mostly '0's, while the bottom-right 5x5 area contains mostly '7's. There is a transition region in the middle where both '0's and '7's are mixed. Some digits are solid black, while others are white with a black outline, representing different binary thresholdings or variations in the original handwriting.

A 10x10 grid of handwritten digits from the USPS dataset, showing clusters of '0's and '7's.

2. Binary image matching:

$$s_{rs} = \frac{a}{\min(a + b, a + c)}. \quad (1)$$

### Feature Discovery: Examples

1. Projection onto the positive and projection onto the negative eigenspaces yield results different in nature.

![A scatter plot showing handwritten digits (0-9) in a 2D space defined by 'First component: shape' (x-axis) and 'Second component' (y-axis). The digits are clustered into two main groups: '0' and 'D' on the right, and '1', '7', and '2' on the left. An inset graph in the top-left corner shows a curve with a sharp vertical asymptote, representing a metric or distance function.](fae82236e4211f753df5789eb276d3a4_img.jpg)

The figure displays a scatter plot of handwritten digits from 0 to 9, projected onto the first two principal components. The x-axis is labeled 'First component: shape' and the y-axis is labeled 'Second component'. The digits are clustered into two main groups: '0' and 'D' on the right, and '1', '7', and '2' on the left. An inset graph in the top-left corner shows a curve with a sharp vertical asymptote, representing a metric or distance function.

A scatter plot showing handwritten digits (0-9) in a 2D space defined by 'First component: shape' (x-axis) and 'Second component' (y-axis). The digits are clustered into two main groups: '0' and 'D' on the right, and '1', '7', and '2' on the left. An inset graph in the top-left corner shows a curve with a sharp vertical asymptote, representing a metric or distance function.

Figure 2: Information coded by metricity.

### Feature Discovery: Examples

1. Projection onto the positive and projection onto the negative eigenspaces yield results different in nature.

![A scatter plot showing handwritten digits 0 and 7. The vertical axis is labeled 'Last component: stroke weight' and the horizontal axis is labeled 'Second last component'. The digits are clustered into two distinct groups: '0's are on the left and '7's are on the right. An inset graph in the top-left corner shows a curve that starts at the origin and increases rapidly, representing a metric violation function.](03498c9b76f980b32f2dfbb7c2e539d2_img.jpg)

A scatter plot showing handwritten digits 0 and 7. The vertical axis is labeled 'Last component: stroke weight' and the horizontal axis is labeled 'Second last component'. The digits are clustered into two distinct groups: '0's are on the left and '7's are on the right. An inset graph in the top-left corner shows a curve that starts at the origin and increases rapidly, representing a metric violation function.

Figure 3: Information coded by metric violations.

- We are interested in the semantic structure of nouns and adjectives from different text sources.
- A subset of 120 nouns and adjectives has been selected, containing both very specific and very general terms out of two topically unrelated sources: Grimm's Fairy Tales<sup>a</sup>, and popular science articles about space exploration<sup>b</sup>.
- Both sources contributed 60 documents containing roughly between 500 and 1500 words each.
- For  $p$  documents and a choice of  $n$  keywords construct the contingency table, by simply indicating whether word  $i$  ( $1 \leq i \leq n$ ) appears in document  $k$  ( $1 \leq k \leq p$ ) or not.

<sup>a</sup>Project Gutenberg <http://promo.net/pg/>

<sup>b</sup>Science at Nasa articles [http://science.nasa.gov/headlines/news\\_archive](http://science.nasa.gov/headlines/news_archive).

![TU Berlin logo](3fe839e8110987c60318d18e542f4a10_img.jpg)

The logo of the Technical University of Berlin (TU Berlin), featuring a stylized 'TU' in red and black with 'berlin' in smaller text.

TU Berlin logo

- 
- This yields an  $p \times n$  boolean matrix  $X$ , with  $X_{ki} = 1$  if word  $i$  appears in document  $k$  and 0 else. Let  $X_i$  denote the  $i$ th column of  $X$  (associated to word  $i$ ).

- *Keyword Semantic Proximity:*

$$\begin{aligned}s_{ij} &= \frac{\#\{\text{documents where word } i \text{ and word } j \text{ appear}\}}{\#\{\text{documents where word } i \text{ or word } j \text{ appear}\}} \\ &= \frac{\sum_{X_i+X_j=2} 1}{\sum_{X_i=1} 1 + \sum_{X_j=1} 1 - \sum_{X_i+X_j=2} 1}\end{aligned}$$

- From this similarity measure, we obtain a dissimilarity matrix via, e.g.  
 $d_{ij} = -\log(s_{ij})$ .

![Heatmap visualization](fd38170a3981416226ab91f7437ba821_img.jpg)

Heatmap visualization

![A 2D scatter plot showing word embeddings in a semantic context. The x-axis is labeled 'First component: semantic context' and the y-axis is labeled 'Second component'. The plot contains various words grouped into clusters. A small inset graph in the top-left corner shows a curve that rises sharply. Dashed lines connect some clusters to a central point labeled 'earth'.](f899c67120dc04a5e5a5c2d94461a077_img.jpg)

The figure displays a 2D scatter plot of word embeddings. The horizontal axis is labeled "First component: semantic context" and the vertical axis is labeled "Second component". An inset graph in the top-left corner shows a curve that starts near the origin and rises sharply as it moves to the right.

Words are clustered into several groups, some of which are enclosed in boxes or connected by dashed lines to a central point labeled "earth".

- Top right cluster:** woodman, thieves, pig, wolf, cottage.
- Upper middle cluster (boxed):** work, around, place, air, country, hand, way, home, day, hum, people, thing, sun, head, world, night.
- Middle cluster (boxed):** energy, space, radiation, environment, gravity, rock, scientist.
- Lower middle cluster (boxed):** system, planet, science, moon, scientists, astronauts, constellation.
- Left side (connected to earth):** nuclear, hydrogen, propulsion, exploration, computer, temperature, robot, country, atoms, static, physics, research, data, satellite, comet, telescope, image, meteor.
- Center (connected to earth):** body, piece, money, hands, house, man, death, door, poor, wood, cat, fox, servant, handsome, witch, castle, kingdom, palace, queen, courtyard, youth, pearl, huntsman, forest, young, beautiful, morning, pope, church, raven, handsome, robin, wood, axles, dragon, talers, window, dwarf, soldier, tail, bed, years, fire, frog, water, lie, face, tree.
- Bottom area:** news, end, land, life.

A 2D scatter plot showing word embeddings in a semantic context. The x-axis is labeled 'First component: semantic context' and the y-axis is labeled 'Second component'. The plot contains various words grouped into clusters. A small inset graph in the top-left corner shows a curve that rises sharply. Dashed lines connect some clusters to a central point labeled 'earth'.

![A small square image showing a colorful heatmap or density plot with concentric-like patterns in red, yellow, and blue.](e714d8aca168c4854edebc4a4f2e9bd1_img.jpg)

A small square image showing a colorful heatmap or density plot with concentric-like patterns in red, yellow, and blue.

![A 2D scatter plot showing word embeddings for the last and second last components. The y-axis is labeled 'Last component: specificity' and the x-axis is labeled 'Second last component'. An inset graph in the top right shows a cumulative distribution function (CDF) curve.](bd4a5cf22b8d8060c4bf3577beb30df8_img.jpg)

The figure displays a scatter plot of word embeddings, where the vertical axis represents the 'Last component: specificity' and the horizontal axis represents the 'Second last component'. An inset graph in the top right corner shows a cumulative distribution function (CDF) curve, likely representing the distribution of specificity values.

Words are plotted based on their coordinates in this 2D space. Words with high specificity (high y-value) include 'dwarfe', 'solidier', 'dragon', 'humanian', 'zoub', 'rubber', 'foe', 'raver', 'shepherd', 'pink', 'sword', 'witch', 'spelling', 'woodman', 'science', 'astronome', 'solar', 'pilot', 'research', 'tribe', 'gravi', 'consol', 'fortune', 'station', 'pope', 'astronomer', 'kingdom', 'cut', 'radio', 'telescope', 'astronomer', 'energy', 'shuttle', 'space', 'temperature', 'pollen', 'dandelion', 'cotton', 'sun', 'candle', 'nuclear', 'robot', 'mancer', 'surv', 'explorati', 'telescope', 'drink', 'castle', 'nuclear', 'robot', 'wood', 'forwi', 'round', 'rocke', 'engin', 'poor', 'bed', 'door', 'deat', 'beautiful', 'table', 'money', 'piece', 'body', 'sound', 'fire', 'hands', 'face', 'try', 'young', 'window', 'house', 'man', 'open', 'morning', 'air', 'warm', 'light', 'world', 'people', 'change', 'space', 'earth', 'land', 'frog', 'grandmother', 'town', 'space'.

A 2D scatter plot showing word embeddings for the last and second last components. The y-axis is labeled 'Last component: specificity' and the x-axis is labeled 'Second last component'. An inset graph in the top right shows a cumulative distribution function (CDF) curve.

![A small heatmap or density plot showing a concentration of values, likely related to the word embeddings.](16c69c0dacd3c57ae91acd114e5f5bd2_img.jpg)

A small heatmap or density plot showing a concentration of values, likely related to the word embeddings.

## Conclusion: non-metricity in general ---

**Julian Laub, Klaus-Robert Müller** Feature Discovery in Non-Metric Pairwise Data, JMLR ; 5(Jul):801--818, 2004

1. The current paradigm is wrong/incomplete.
2. Metric violations *can* carry relevant information.
3. A complete data exploratory research must specifically study this information.

![Heatmap visualization](7cb2bb7f9f6fd8be2dc5679e7053ae04_img.jpg)

Heatmap visualization

### Non-Metric Similarities: continued ---

- Cannot be modeled faithfully in a metric map
- Metric space has three limitations:
  - Cannot model intransitive similarities
  - Cannot model objects with high centrality
  - Cannot model asymmetric similarities
- Lead Tversky (among others) to reject MDS as a model for semantic representation

- Circumvents limitations of most MDS variants by constructing multiple maps instead of a single map:
  - Each object has a point in all maps
  - Each point has a weight in each map
  - The weights sum up to 1 for an object
- Addresses all three limitations!

![Small visualization showing a 2D plot with a color gradient and a circular highlight, likely representing a t-SNE map.](0892c0cb3b8502a44c4fe4e786be912a_img.jpg)

Small visualization showing a 2D plot with a color gradient and a circular highlight, likely representing a t-SNE map.

## Multiple Maps t-SNE ---

- The input is a collection of  $p_{j|i}$ 's
- The similarity between  $i$  and  $j$  under the model is given by  $q_{j|i}$ :

$$q_{j|i} = \frac{\sum_m \pi_i^{(m)} \pi_j^{(m)} (1 + \|y_i^{(m)} - y_j^{(m)}\|^2)^{-1}}{\sum_{m'} \sum_{i \neq k} \pi_i^{(m')} \pi_k^{(m')} (1 + \|y_i^{(m')} - y_k^{(m')}\|^2)^{-1}}$$

- Minimize the sum of KL divergences:

$$\sum_i KL(P_i \| Q_i) = \sum_i \sum_{j \neq i} p_{j|i} \log \frac{p_{j|i}}{q_{j|i}}$$

Intransitive similarities:

![Diagram illustrating intransitive similarities with two maps.](b05bae46f7079e5c9b1da38adb2319e8_img.jpg)

Diagram illustrating intransitive similarities. It consists of two square boxes labeled "Map 1" and "Map 2".

Map 1 contains two nodes: a circle with "1" and "A" and a circle with "1/2" and "C".

Map 2 contains two nodes: a circle with "1" and "B" and a circle with "1/2" and "C".

Diagram illustrating intransitive similarities with two maps.

High centrality:

![Diagram illustrating high centrality with two maps.](32ff77da4286b58c4778033acaa10836_img.jpg)

Diagram illustrating high centrality. It consists of two square boxes labeled "Map 1" and "Map 2".

Map 1 contains four nodes: three circles with "1" (top-left, top-right, bottom) and one circle with "1/2" and "A" in the center.

Map 2 contains four nodes: three circles with "1" (top-left, top-right, bottom) and one circle with "1/2" and "A" in the center.

Diagram illustrating high centrality with two maps.

Asymmetries:

![Diagram illustrating asymmetries with two maps.](0c80c383f76034e117adf5e5eaadaaf3_img.jpg)

Diagram illustrating asymmetries. It consists of two square boxes labeled "Map 1" and "Map 2".

Map 1 contains two nodes: a circle with "1" and "North-Korea" and a circle with "1/2" and "China".

Map 2 contains three nodes: a cloud labeled "Other countries" at the top, a circle with "1/2" and "China" in the center, and a cloud labeled "Other countries" at the bottom.

Diagram illustrating asymmetries with two maps.

[From vd Maaten]

### Multiple Maps t-SNE

![A t-SNE visualization showing multiple word maps clustered together. The maps include clusters for Royalty (PRINCE, QUEEN, KING), Gates (DOOR, HANDLE, KNOB), Nature/Environment (OZONE, SURROUNDINGS), Food/Animals (POPEYE, SPINACH, BEETLE), and Distance (FAR, AWAY, BEYOND).](f2c40bfbb63eaf7fd84888bdbf1a0a51_img.jpg)

This figure displays a t-SNE visualization of multiple word maps, showing clusters of related terms in a 2D space. The clusters are as follows:

- Top (Ozone/Environment):** OZONE, LAYER, DEPLETION, SURROUNDINGS, ENVIRONMENT, SURROUNDING.
- Upper Middle (Interest):** INTEREST, WELL-BEING.
- Top Right (Popeye/Food):** POPEYE, SPINACH, CARTOON.
- Far Right (Pickle/Beetle):** DILL, PICKLE, PICKLES, JUICE, BEETLE.
- Right (Stalk/Scarecrow):** STALK, CORN, SCARECROW.
- Below Right (Heap/Harvest):** SOW, HEAP, HARVEST.
- Bottom Right (Lightning):** LIGHTNING, BOLT.
- Bottom (Distance):** DISTANT, FAR, AWAY, DISTANCE, BEYOND, FURTHER.
- Bottom Center (Gate/Door):** HINGE, KNOCK, DOOR, HANDLE, KNOB, THRESHOLD, ENTRANCE, DOORWAY, LATCH, KEY, KEYS, LOCK, COMBINATION, FENCE, GATE.
- Center (Ring/Long):** RING, LONG, TURN, VEER, CLOSED, MINDED, OPEN, VACANCY, CLOSE, SHUT, INTIMATE, LOCAL.
- Left (Royalty):** PRINCE, PRINCESS, ROYALTY, QUEEN, KING, ENGLAND, ROYAL, CROWN, THRONE, MONARCHY, MONARCH, RULER, DICTATOR, EMPEROR.
- Far Left (Moat/Castle):** MOAT, CASTLE, PALACE, KINGDOM, ROMAN, EMPIRE.
- Bottom Left (Hallway):** PASSAGE, HALLWAY, HALLO, BREEZEWAY, CORRIDOR.
- Bottom Left (Close/Open):** CLOSING, OPENING.

A t-SNE visualization showing multiple word maps clustered together. The maps include clusters for Royalty (PRINCE, QUEEN, KING), Gates (DOOR, HANDLE, KNOB), Nature/Environment (OZONE, SURROUNDINGS), Food/Animals (POPEYE, SPINACH, BEETLE), and Distance (FAR, AWAY, BEYOND).

[From vd Maaten]

![A scatter plot showing word embeddings for various categories. The plot includes clusters for sports, games, clothing, and abstract concepts. Words are represented by blue circles of varying sizes, with some words in bold.](7e97a53863a8df3ff6b3eac89564ee58_img.jpg)

This scatter plot displays word embeddings, likely from a vector space model, showing relationships between different categories of words. The words are clustered into several groups:

- Sports and Games:**
  - Top center: SITE, LOCATION, AREA, PLACE, WHERE, PUT, SET, POSITION, STATUS.
  - Center: ARENA, JOCK, SPORTS, STADIUM, ATHLETIC, TOUCHDOWN, OLYMPICS, OFFICIAL, TACKLE, FOOTBALL, ATHLETE, REFEREE, CHEERLEADER, VOLLEYBALL, SOCCER, BASKETBALL, MONOPOLY, DICE, LEOPARDY, CLUE, COACH, PLAYER, SPORT, TEAM, OPPONENT, UMPIRE, SOFTBALL, SQUAD, SERIES, BASE, BAT, BASEBALL, IVY LEAGUE, PITCH, PITCHER, CATCHER.
  - Right: CHARGE, DECK, CREDIT, CARD, POKER, ACE, KINGS, QUEENS, JACKS, DEAL, RUMM, SPADE, JOKER, PLAYING.
- Clothing and Fashion:**
  - Bottom right: FANCY, LACE, FRILL, GOWN, DRESS, SKIRT, HEM, SEAM, CREASE, POLYESTER, SLACKS, JEANS, DENIM, WAIST, HIP, SASH, FASTEN, LOOSEN, BUCKLE, BELT, BRA, STRAP, LEATHER, TUXEDO, PROM, FORMAL, CASUAL, PATTERN, PLAID, COLLAR, STARCH, WEAR, SHIRT, BLOUSE, SLEEVE, BUTTON, CUFF, PANTS, TROUSERS, ZIPPER, POCKET.
  - Top right: SHOELACE, VEST, SUIT, TIE, JACKET, SWEATER, LAPEL.
- Abstract and Other Concepts:**
  - Top left: MONUMENT, STATUE, LIBERTY, FREEDOM.
  - Left: OVERWHELM, EXCITEMENT, STRESS, WORRY, ANXIETY, POPULAR, FAMOUS.
  - Far left: MODERN, CONTEMPORARY.
  - Center left: DEFENSE, OFFENSE.
  - Bottom center: BANG, CHEST.

A scatter plot showing word embeddings for various categories. The plot includes clusters for sports, games, clothing, and abstract concepts. Words are represented by blue circles of varying sizes, with some words in bold.

[From vd Maaten]

![A word cloud visualization showing clusters of related words. The clusters include: KNITTING, GRANDMA, GRANDPA, GRANDPARENTS; STALE, FRESH, ELDERS, RESPECT, ANCESTOR, WISE, UNUSUAL, WALKER, TARNISH, OLD, NEW, MODERN, YOUNG, RUST, WORN, FEEBLE, ANTIQUE, BALD, WRINKLE, YOUTH, ANCIENT, DINO SAUR, FOSSIL, AGE, YEARS; PUBERTY, GROWN, ADULT, IMMATURE, MATURE, RESPONSIBILITY, GROWTH, GROW, DEVELOP; PLAY DOUGH, CHILDREN, TRICYCLE, KIDS, ADULTS, PARENTS, GROWN-UPS; EGYPT; SLIME, GOO, DISGUSTING, VULGAR, NASTY, DISGUST, SLUG, MAGGOT, WORMS, SLIMY, GROSS, YUCK, REPULSIVE; ADORABLE, CUTE, HANDSOME, UGLY, ATTRACTIVE, BEAUTIFUL, SEXY, MODEL, GODDESS, GORGEOUS, PINK, BEAUTY, CHEERLEADER, BEAST, GUY, GAL, BOY, BUGLE, SCOUT, WART, MOLE, APPEARANCE, LOOKS; SACK, KNAPSACK, CARRY, BAG, LUNCH, GLAD, TOTE; UNSURE, SURE, POSITIVE, CONFIDENT, CERTAIN, DEODORANT; BOUNDARY, BORDER, LINE, TANGENT, ERECT, CURVE, STRAIGHT, CROOKED, UNEVEN, BENT, CURVED; DEVICE, INSTRUCTIONS, DIRECTIONS, FOLLOW, INSTRUCTION, RULES, PROCEDURE, OBEY, RESTRICTION, LAW, PRINCIPLE, POLICY, INSURANCE; CONSTITUTION, AMERICA, FREEDOM, USA, REPUBLICAN, DEMOCRACY, OLIGARCHY, MONARCHY, ANARCHY, FEDERAL, BUREAU, GOVERNMENT, OFFICIAL, PRESIDENT, POLITICS, MAYOR, GOVERNOR, SENATOR, POLITICIAN, CORRUPT, LAWS, LEGISLATURE, CONGRESS, SENATE.](25fab88fda841d5eec316c440656187e_img.jpg)

A word cloud visualization showing clusters of related words. The clusters include: KNITTING, GRANDMA, GRANDPA, GRANDPARENTS; STALE, FRESH, ELDERS, RESPECT, ANCESTOR, WISE, UNUSUAL, WALKER, TARNISH, OLD, NEW, MODERN, YOUNG, RUST, WORN, FEEBLE, ANTIQUE, BALD, WRINKLE, YOUTH, ANCIENT, DINO SAUR, FOSSIL, AGE, YEARS; PUBERTY, GROWN, ADULT, IMMATURE, MATURE, RESPONSIBILITY, GROWTH, GROW, DEVELOP; PLAY DOUGH, CHILDREN, TRICYCLE, KIDS, ADULTS, PARENTS, GROWN-UPS; EGYPT; SLIME, GOO, DISGUSTING, VULGAR, NASTY, DISGUST, SLUG, MAGGOT, WORMS, SLIMY, GROSS, YUCK, REPULSIVE; ADORABLE, CUTE, HANDSOME, UGLY, ATTRACTIVE, BEAUTIFUL, SEXY, MODEL, GODDESS, GORGEOUS, PINK, BEAUTY, CHEERLEADER, BEAST, GUY, GAL, BOY, BUGLE, SCOUT, WART, MOLE, APPEARANCE, LOOKS; SACK, KNAPSACK, CARRY, BAG, LUNCH, GLAD, TOTE; UNSURE, SURE, POSITIVE, CONFIDENT, CERTAIN, DEODORANT; BOUNDARY, BORDER, LINE, TANGENT, ERECT, CURVE, STRAIGHT, CROOKED, UNEVEN, BENT, CURVED; DEVICE, INSTRUCTIONS, DIRECTIONS, FOLLOW, INSTRUCTION, RULES, PROCEDURE, OBEY, RESTRICTION, LAW, PRINCIPLE, POLICY, INSURANCE; CONSTITUTION, AMERICA, FREEDOM, USA, REPUBLICAN, DEMOCRACY, OLIGARCHY, MONARCHY, ANARCHY, FEDERAL, BUREAU, GOVERNMENT, OFFICIAL, PRESIDENT, POLITICS, MAYOR, GOVERNOR, SENATOR, POLITICIAN, CORRUPT, LAWS, LEGISLATURE, CONGRESS, SENATE.

[From vd Maaten]

## Modeling NIPS Authors ---

- Gather the authors of all papers of NIPS volume 1-20
- Remove all authors with only one paper and authors without co-authors
- Compute  $p_{j|i}$  as the probability that  $j$  is author of a paper of which  $i$  is an author
- The similarities are likely to be intransitive and asymmetric: use multiple maps t-SNE!

![Heatmap visualization](70ececdbb871824c3e57cace6262c4d6_img.jpg)

Heatmap visualization

#### Map 1

![A word cloud visualization showing the distribution of names. The size of each name corresponds to its frequency or weight in the dataset. The names are scattered across the plot area, with some clusters being more dense than others.](5148ae85e7c243139ae6b37e24f01940_img.jpg)

This word cloud visualization displays the distribution of names based on their relative frequency or weight. The names are represented by circles of varying sizes, where larger circles indicate higher values. The names are scattered across the plot area, with some clusters being more dense than others. Notable clusters include a group of names in the upper right (Lange, Roth, Buhmann, Fischer, Anderson), a group in the center (Muller, Blankertz, Curio), and a group in the lower right (Tresp, Neuncier, Zimmermann). Other individual names like Touretzky, Schmidthuber, and DeFreitas are also visible.

A word cloud visualization showing the distribution of names. The size of each name corresponds to its frequency or weight in the dataset. The names are scattered across the plot area, with some clusters being more dense than others.

![Logo of the Technical University of Berlin (TU Berlin), featuring a stylized red 'TU' and the word 'berlin' in white on a red background.](c436e079f79bca972b79ed4b3e4613ea_img.jpg)

Logo of the Technical University of Berlin (TU Berlin), featuring a stylized red 'TU' and the word 'berlin' in white on a red background.

![A contour plot showing a local minimum at the center, surrounded by concentric elliptical contours. The plot is colored with a gradient from blue at the minimum to red and yellow at higher values.](4ba0c02941829d6ece2e065f08a4e575_img.jpg)

A contour plot showing a local minimum at the center, surrounded by concentric elliptical contours. The plot is colored with a gradient from blue at the minimum to red and yellow at higher values.

[From vd Maaten]

#### Map 3

![A complex network graph showing relationships between numerous nodes, each labeled with a name. The nodes are represented by small circles, and the connections are represented by lines. The layout is a force-directed clustering, with nodes grouped into several dense clusters. The names are distributed across the graph, with some being more central than others. The overall structure suggests a complex web of relationships, possibly representing a social network, a biological system, or a knowledge graph.](8ed84fe370c3350b72cbb13d1b3a7b15_img.jpg)

The figure is a force-directed graph visualization showing a large number of nodes, each labeled with a name. The nodes are represented by small circles, and the connections are represented by lines. The layout is a force-directed clustering, with nodes grouped into several dense clusters. The names are distributed across the graph, with some being more central than others. The overall structure suggests a complex web of relationships, possibly representing a social network, a biological system, or a knowledge graph.

Key clusters and nodes include:

- Top-left cluster:** Heskies, Long, Servidio, Wegerinck, Lexink, Roth, Kappen, Skaggs, McNaughton, Orr, Leen, Kamblatt, Archer, Kuo, Principe, DeVries.
- Top-center cluster:** Nix, Weigend, Huberman, Rumelhart, Keeler, Pitman, Marion, Rashid, Rosen, Johnson, Abrash, Franco, Beek, Wawrzyniek, Suarez, Hayashi.
- Upper-middle cluster:** Cohen, Morgan, Rinaldi, Beek, Wawrzyniek, Johnson, Abrash, Franco, Rosen, Nix, Weigend, Huberman, Rumelhart, Keeler, Pitman, Marion, Rashid.
- Center cluster:** Lee, Ram, Weiss, Seung, Koller, Zemel, Douglas, Wang, Harris, Zemel, Koller, Jaakkola, Ratsch, Mika, Globerson, Muller, Rowels, Smola, Teo, Langford, Le Chapelle, Poggio, Resenflizer, Warmuth, Mathieson, Smith, Tarassenko, Brownlow, Hamilton, Churcher, Reekie, Han, Auer, Orther, Pontil, Argryriou, Ying, Micchelli, Herbster, Freund, Dasgupta, Chatchuri, Montealeoni, Alon, Hopfield, Zomer, Zomet, Levitt, Flash, Yanover, Tipping, Jabir, Coggins, Mead, Hasler, Minch, Diorio, Bridges, Figueroa, Hsu.
- Lower-left cluster:** Baum, Grossman, Lapades, Farber, Wu, Darken, Utans, Kambhatla, Archer, Schottky, Ruderman, Niebur, Schuster, Kammen, Softky, Bousquet, Wagerinck, Lexink, Roth, Kappen, Skaggs, McNaughton, Orr, Leen, Kamblatt, Archer, Kuo, Principe, DeVries.
- Lower-center cluster:** Seeger, Macke, Gerwinn, Bethge, Berens, Okada, Miyawaki, Luxburg, Maier, Hein, Kim, Steinke, Hertzmann, Wang, Choi, Young, Zhang, Li, Lee, Spence, Saida, Parra, Gentile, Cesa-Bianchi, Conconi, Westervelt, Marcus, Peterson, Pearson, Gelfand, Taylor, Goodwin, Vidal, Rotter, Wolf, Watanabe, Keesing, Stork, Sperduti, Kailath, Hassibi, Berens, Seeger, Macke, Gerwinn, Bethge.
- Bottom-right cluster:** Gentile, Cesa-Bianchi, Conconi, Westervelt, Marcus, Peterson, Pearson, Gelfand, Taylor, Goodwin, Vidal, Rotter, Wolf, Watanabe, Keesing, Stork, Sperduti, Kailath, Hassibi, Berens, Seeger, Macke, Gerwinn, Bethge.

A complex network graph showing relationships between numerous nodes, each labeled with a name. The nodes are represented by small circles, and the connections are represented by lines. The layout is a force-directed clustering, with nodes grouped into several dense clusters. The names are distributed across the graph, with some being more central than others. The overall structure suggests a complex web of relationships, possibly representing a social network, a biological system, or a knowledge graph.

![A small square image showing a colorful heatmap or density plot, likely representing a data visualization related to the network graph.](1a71c1fcfe031ac87d6458c6b5062bf1_img.jpg)

A small square image showing a colorful heatmap or density plot, likely representing a data visualization related to the network graph.

## Quote ---

From vd Maaten & Hinton Machine Learning 2012

to collaborators from UC Irvine (where he is currently a professor) in map 2. As a second example, Martin Wainwright has collaborated extensively with both Eero Simoncelli and Michael Jordan, but on different topics and at different times. He appears with Simoncelli in map 3 and with Jordan in map 4 thus allowing their representations to remain far apart. As a third example, Klaus-Robert Müller's collaborations until 2000 (with, among others, Alex Smola and Gunnar Rätsch) are visualized in map 3, whereas his collaborations after 2000 (for instance, with Benjamin Blankertz) are shown in map 1.

Figure 5 shows the neighborhood preservation ratio obtained by aspect maps and multiple maps t-SNE for increasing numbers of maps. The results presented in the figure are in

![Heatmap visualization](4134b40f9161ec8fcd3c28bdb48f80b0_img.jpg)

Heatmap visualization

## Refs ---

- Google: t-SNE (van der Maaten)
  - vd Maaten & Hinton Machine Learning 2012
  - Laub & Müller JMLR 2004
  - Slides on SNE & MDS adapted from Hinton and vd Maaten
- 
- L.J.P. van der Maaten and G.E. Hinton. *Visualizing Data using t-SNE*. Journal of Machine Learning Research 9(Nov):2579-2605, 2008.
  - L.J.P. van der Maaten and G.E. Hinton. *Visualizing Similarities with Multiple Maps*.

![Heatmap visualization](fd8369b549b3d1a5c848cbd83659cae9_img.jpg)

A small square image showing a 2D heatmap or density plot with concentric elliptical contours in shades of red, yellow, and green, representing a similarity matrix or data distribution.

Heatmap visualization