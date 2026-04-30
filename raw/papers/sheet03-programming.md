

---
source_url: tu-berlin-ml2-2023
ingested: 2026-05-01
sha256: b6c0a1cf5d90e6414e5882ff67fc87bb09600f85b9a7dae0a47358e8846f7270
---

# Canonical Correlation Analysis

In this exercise, we consider canonical correlation analysis (CCA) on two simple problems, one in low dimensions and one in high dimensions. The goal is to implement the primal and dual versions of CCA to handle these two different cases. The first dataset consists of two trajectories in two dimensions. The dataset is extracted and plotted below. The first data points are shown in dark blue, and the last ones are shown in yellow.

```
In [1]: import numpy
import matplotlib
%matplotlib inline
from matplotlib import pyplot as plt
import utils

X,Y = utils.getData()
p1,p2 = utils.plotdata(X,Y)
```

![Two side-by-side scatter plots showing two trajectories in 2D space. The left plot shows a complex, overlapping trajectory with dark blue and yellow points. The right plot shows a simpler, non-overlapping trajectory with dark blue and yellow points.](2cb4ae7af8981b4179851b065f41dab8_img.jpg)

The figure consists of two side-by-side scatter plots. Both plots have x and y axes ranging from -3 to 3. The left plot shows two overlapping trajectories: one in dark blue and one in yellow. The dark blue trajectory forms a loop that crosses itself, while the yellow trajectory is more irregular. The right plot shows two distinct trajectories: a dark blue spiral starting from the center and winding outwards, and a yellow spiral that is more loosely wound and positioned to the left of the blue one.

Two side-by-side scatter plots showing two trajectories in 2D space. The left plot shows a complex, overlapping trajectory with dark blue and yellow points. The right plot shows a simpler, non-overlapping trajectory with dark blue and yellow points.

For these two trajectories, that can be understood as two different modalities of the same data, we would like determine under which projections they appear maximally correlated.

## Implementing Primal CCA

As stated in the lecture, the CCA problem in its primal form consists of maximizing the cross-correlation objective:

$$J(w_x, w_y) = w_x^\top C_{xy} w_y$$

subject to autocorrelation constraints  $w_x^\top C_{xx} w_x = 1$  and  $w_y^\top C_{yy} w_y = 1$ . Using the method of Lagrange multipliers, this optimization problem can be reduced to finding the first eigenvector of the generalized eigenvalue problem:

$$\begin{bmatrix} 0 & C_{xy} \\ C_{yx} & 0 \end{bmatrix} \begin{bmatrix} w_x \\ w_y \end{bmatrix} = \lambda \begin{bmatrix} C_{xx} & 0 \\ 0 & C_{yy} \end{bmatrix} \begin{bmatrix} w_x \\ w_y \end{bmatrix}$$

Your first task is to write a function that solves the CCA problem in the primal (i.e. that solves the generalized eigenvalue problem above). The function you need to implement receives two matrices `X` and `Y` of size `N × d1` and `N × d2` respectively. It returns two vectors of size `d1` and `d2` corresponding to the projections associated to the modalities `X` and `Y`. (Hint: Note that the data matrices `X` and `Y` have not been centered yet.)

```
In [2]: import numpy

def CCAprimal(X,Y):

    ## -----
    ## TODO: replace by your solution
    ## -----
    import solutions
    wx,wy = solutions.CCAprimal(X,Y)
    ## -----

    return wx,wy
```

The function can now be called with our dataset. The learned projection vectors  $w_x$  and  $w_y$  are plotted as red arrows.

```
In [3]: wx,wy = CCAprimal(X,Y)

p1,p2 = utils.plotdata(X,Y)
p1.arrow(0,0,1*wx[0],1*wx[1],color='red',width=0.1)
p2.arrow(0,0,1*wy[0],1*wy[1],color='red',width=0.1)
plt.show()
```

![Two side-by-side scatter plots showing data points and learned projection vectors. The left plot shows a spiral of green and yellow points with a red arrow pointing downwards, representing the projection vector w_x. The right plot shows a spiral of green and yellow points with a red arrow pointing to the left, representing the projection vector w_y.](131b27192f21ffa3869d8686b7a67448_img.jpg)

The figure consists of two side-by-side scatter plots. Both plots have x and y axes ranging from -3 to 3. The left plot shows a spiral of data points, with green points forming the outer part and yellow points forming the inner part. A red arrow points downwards from the origin, representing the learned projection vector  $w_x$ . The right plot shows the same spiral of data points. A red arrow points to the left from the origin, representing the learned projection vector  $w_y$ .

Two side-by-side scatter plots showing data points and learned projection vectors. The left plot shows a spiral of green and yellow points with a red arrow pointing downwards, representing the projection vector w\_x. The right plot shows a spiral of green and yellow points with a red arrow pointing to the left, representing the projection vector w\_y.

In each modality, the arrow points in a specific direction (note that the optimal CCA directions are defined up to a sign flip of both  $w_x$  and  $w_y$ ). Furthermore, we can verify CCA has learned a meaningful solution by projecting the data on it.

```
In [4]: plt.figure(figsize=(6,2))
plt.plot(numpy.dot(X,wx))
plt.plot(numpy.dot(Y,wy))
plt.show()
```

![A line plot showing two correlated signals, wx and wy, over an index range from 0 to 100. The x-axis is labeled from 0 to 100 in increments of 20. The y-axis is labeled from -1 to 2 in increments of 1. The orange curve (wx) starts at approximately 0.4, dips to 0 at x=15, peaks at 1.2 at x=35, dips to -0.5 at x=60, peaks at 1.8 at x=85, and ends at -0.2 at x=100. The blue curve (wy) starts at 0, dips to -0.5 at x=15, peaks at 0.8 at x=35, dips to -1.2 at x=60, peaks at 1.2 at x=85, and ends at -1.2 at x=100. The two curves follow a very similar pattern of peaks and troughs, indicating high correlation.](3cab54230d8ae3b786ddda81346602cc_img.jpg)

A line plot showing two correlated signals, wx and wy, over an index range from 0 to 100. The x-axis is labeled from 0 to 100 in increments of 20. The y-axis is labeled from -1 to 2 in increments of 1. The orange curve (wx) starts at approximately 0.4, dips to 0 at x=15, peaks at 1.2 at x=35, dips to -0.5 at x=60, peaks at 1.8 at x=85, and ends at -0.2 at x=100. The blue curve (wy) starts at 0, dips to -0.5 at x=15, peaks at 0.8 at x=35, dips to -1.2 at x=60, peaks at 1.2 at x=85, and ends at -1.2 at x=100. The two curves follow a very similar pattern of peaks and troughs, indicating high correlation.

Clearly, the data is correlated in the projected space.

## Implementing Dual CCA

In the second part of the exercise, we consider the case where the data is high dimensional (with  $d \gg N$ ). Such high-dimensionality occurs for example, when input data are images. We consider the scenario where sources emit spatially, and two (noisy) receivers measure the spatial field at different locations. We would like to identify signal that is common to the two measured locations, e.g. a given source emitting at a given frequency. We first load the data and show one example.

```
In [5]: X,Y = utils.getHDdata()

utils.plotHDdata(X[0],Y[0])
plt.show()
```

![Two side-by-side grayscale images, X[0] and Y[0], representing high-dimensional data points. Both images show a noisy, textured pattern. The left image (X[0]) has a slightly more pronounced circular feature in the center-left. The right image (Y[0]) appears more uniformly noisy. Both images have axes ranging from 0 to 80 on the y-axis and 0 to 50 on the x-axis.](87658d45f2d2f009cbb9cd1079519cb5_img.jpg)

Two side-by-side grayscale images, X[0] and Y[0], representing high-dimensional data points. Both images show a noisy, textured pattern. The left image (X[0]) has a slightly more pronounced circular feature in the center-left. The right image (Y[0]) appears more uniformly noisy. Both images have axes ranging from 0 to 80 on the y-axis and 0 to 50 on the x-axis.

Several sources can be perceived, however, there is a significant level of noise. Here again, we will use CCA to find subspaces where the two modalities are maximally correlated. In this example, because there are many more dimensions than there are data points, it is more advantageous to solve CCA in the dual. Your task is to implement a CCA dual solver that receives two data matrices of size  $N \times d_1$  and

$N \times d2$  respectively as input, and returns the associate CCA directions (two vectors of respective sizes  $d1$  and  $d2$  ).

```
In [6]: def CCADual(X,Y):  
    ## -----  
    ## TODO: replace by your solution  
    ## -----  
    import solutions  
    wx,wy = solutions.CCADual(X,Y)  
    ## -----  
  
    return wx,wy
```

We now call the function we have implemented with a training sequence of 100 pairs of images. Because the returned solution is of same dimensions as the inputs, it can be rendered in a similar fashion.

```
In [7]: wx,wy = CCADual(X[:100],Y[:100])  
  
utils.plotHDdata(wx,wy)  
plt.show()
```

![Two side-by-side plots showing the spatial filters wx and wy. Both plots display a 2D intensity map with a central point source emitting concentric rings. The left plot (wx) shows a more pronounced central source compared to the right plot (wy). Both plots have axes ranging from 0 to 100.](b7251436a2a3c0d1c00c3e935df2a8f5_img.jpg)

Two side-by-side plots showing the spatial filters wx and wy. Both plots display a 2D intensity map with a central point source emitting concentric rings. The left plot (wx) shows a more pronounced central source compared to the right plot (wy). Both plots have axes ranging from 0 to 100.

Here, we can clearly see a common factor that has been extracted between the two fields, specifically a point source emitting at a particular frequency. A test sequence of 100 pairs of images can now be projected on these two filters:

```
In [8]: plt.figure(figsize=(6,2))  
plt.plot(numpy.dot(X[100:],wx))  
plt.plot(numpy.dot(Y[100:],wy))  
plt.show()
```

![A line plot showing the projection of a test sequence of 100 pairs of images onto the filters wx and wy. The x-axis represents the index of the image pair (0 to 100), and the y-axis represents the projection value (ranging from -0.05 to 0.05). Two oscillating lines, one blue (wx) and one orange (wy), are plotted. The lines are highly correlated, showing a periodic oscillation with a frequency of approximately 10 cycles over the 100 image pairs.](a30a7877bf2f45b837a9382e22067ad0_img.jpg)

A line plot showing the projection of a test sequence of 100 pairs of images onto the filters wx and wy. The x-axis represents the index of the image pair (0 to 100), and the y-axis represents the projection value (ranging from -0.05 to 0.05). Two oscillating lines, one blue (wx) and one orange (wy), are plotted. The lines are highly correlated, showing a periodic oscillation with a frequency of approximately 10 cycles over the 100 image pairs.

Clearly the two projected signals are correlated and the input noise has been strongly reduced.