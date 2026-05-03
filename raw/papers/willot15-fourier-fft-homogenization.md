---
title: "Fourier-based schemes for computing the mechanical response of composites with accurate local fields"
arxiv: "1412.8398"
authors: ["François Willot"]
year: 2015
source: paper
ingested: 2026-05-03
sha256: 70535dc6a866686cbcbe799c1452777d93b7a46b6a8b17b1727e4f8a973340b7
conversion: pymupdf4llm
---

# Fourier-based schemes for computing the mechanical response of composites with accurate local fields 

## Franc¸ois Willot 

_Mines ParisTech, PSL Research University, Centre for Mathematical Morphology, 35, rue St Honor´e, 77300 Fontainebleau, France_ 

## **Abstract** 

We modify the Green operator involved in Fourier-based computational schemes in elasticity, in 2D and 3D. The new operator is derived by expressing continuum mechanics in terms of centered differences on a rotated grid. Use of the modified Green operator leads, in all systems investigated, to more accurate strain and stress fields than using the discretizations proposed by Moulinec and Suquet (1994) or Willot and Pellegrini (2008). Moreover, we compared the convergence rates of the “direct” and “accelerated” FFT schemes with the different discretizations. The discretization method proposed in this work allows for much faster FFT schemes with respect to two criteria: stress equilibrium and effective elastic moduli. 

_Keywords:_ FFT methods, Homogenization, Heterogeneous media, Linear elasticity, Computational mechanics, Spectral methods 

## **1. Introduction** 

Fourier-based algorithms, or “FFT” methods for short, are an efficient approach for computing the mechanical response of composites. Initially restricted to linear-elastic media, FFT tools are nowadays employed to treat more involved problems, ranging from viscoplasticity [1] to crack propagation [2]. In FFT methods, the microstructure is defined by 2D or 3D images and the local stress and strain tensors are computed along each pixel or “voxel” in the image. Coupled with automatic or semi-automatic image segmentation techniques [3], this allows for the computation of the mechanical response of a material directly from 

> _Email address:_ `francois.willot@ensmp.fr` (Franc¸ois Willot) Tel.: +33 1 64 69 48 07. 

_Preprint submitted to CRAS_ 

_December 30, 2014_ 

experimental acquisitions, like focused ion beam or 3D microtomography techniques [4]. The latter often deliver images containing billions of voxels, for which FFT methods are efficient [5, 6]. This allows one to take into account representative volume elements of materials which are multiscale by nature such as concrete or mortar [7]. From a practical viewpoint, the simplicity of FFT methods is attractive to researchers and engineers who need not be experts in the underlying numerical methods to use them. Nowadays, FFT tools are available not only as academic or free softwares [8, 9] but also as commercial ones [10]. 

In the past years, progress has been made in the understanding of FFT algorithms. Vondˇrejc and co-workers have recently shown that the original method of Moulinec and Suquet [11] corresponds, under one technical assumption, to a particular choice of approximation space and optimization method [12] (see also [13]). This property allows one to derive other FFT schemes that use standard optimization algorithms, such as the conjugate gradient method. In this regard, making use of variational formulations, efficient numerical methods have been proposed that combine FFTs with an underlying gradient descent algorithm [14, 15]. 

Different approximation spaces or discretization methods have also been proposed, where, contrary to the original scheme, the fields are not trigonometric polynomials anymore. Brisard and Dormieux introduced “energy-based” FFT schemes that rely on Galerkin approximations of Hashin and Shtrikman’s variational principle [15, 13] and derived modified Green operators consistent with the new formulation. They obtained improved convergence properties and local fields devoid of the spurious oscillations observed in the original FFT scheme [13, 16]. In the context of conductivity, accurate local fields and improved convergence rates have also been obtained from modified Green operators based on finitedifferences [17]. These results follow earlier works where continuum mechanics are expressed by centered [18, 19] or “forward and backward” finite differences [20]. 

This work focuses on the effect of discretization in FFT methods. It is organized as follows. We first recall the equations of elasticity in the continuum (Sec. 2). We give the Lippmann-Schwinger equations and the “direct” and “accelerated” FFT schemes in Sec. (3). In Sec. (4), a general formulation of the Green operator is derived that incorporates methods in [20], and a new discretization scheme is proposed. The accuracy of the local stress and strain fields are examined in Sec. (5) whereas the convergence rates of the various FFT methods are investigated in Sec. (6). We conclude in Sec. (7). 

2 

## **2. Microstructure and material elastic response** 

We are concerned with solving the equations of linear elasticity in a square or cubic domain Ω= [−1/2; 1/2] _[d]_ in dimension _d_ ( _d_ = 2 or 3): 

**==> picture [377 x 29] intentionally omitted <==**

where ε( _**x**_ ) is the strain field, σ( _**x**_ ) the stress field, _**u**_ ( _**x**_ ) the displacement vector field, C( _**x**_ ) the local elasticity tensor and _**x**_ is a point in Ω. Tensorial components refer to a system of Cartesian coordinates ( **e** 1; **e** 2) in 2D and ( **e** 1; **e** 2; **e** 3) in 3D. The material has an isotropic local elastic response that reads: 

**==> picture [296 x 12] intentionally omitted <==**

where δ is the Kronecker symbol and λ( _**x**_ ) and µ( _**x**_ ) are constant-per-phase Lam´e’s first and second coefficients. The local bulk modulus κ = λ+(2/ _d_ )µ and the elastic moduli take on values: 

**==> picture [176 x 12] intentionally omitted <==**

in phase α. For simplicity, we restrict ourselves to binary media and, by convention, α = 1 is the matrix and α = 2 the inclusions. Hereafter, we fix Poisson’s ratios in each phase to ν[1] = ν[2] = 0.25 so that, in 3D and 2D [21], we have µ[α] /κ[α] = 0.6. The contrast of properties χ reads: 

**==> picture [241 x 29] intentionally omitted <==**

where 0 ≤ χ ≤∞. In the matrix, we also fix κ[1] = 1 ( _d_ = 2 or 3), µ[1] = 0.6 ( _d_ = 2 or 3), λ[1] = 0.4 ( _d_ = 2), λ[1] = 0.6 ( _d_ = 3), so that the local properties of the material are parametrized by one unique variable, the contrast of properties χ. In 3D, the Young modulus is _E_[1] = 3/2 in the matrix and _E_[2] = 3χ/2 in the inclusion. The medium is porous when χ = 0 and rigidly-reinforced when χ = ∞. 

Periodic boundary conditions are applied with the material subjected to an overall strain loading ε: 

**==> picture [306 x 13] intentionally omitted <==**

where _**n**_ is the normal at the boundary ∂Ω of the domain Ω, oriented outward, −# denotes anti-periodicity and ⟨·⟩ denotes the spatial mean over Ω. The resulting effective elastic tensor C[�] is computed from: 

**==> picture [240 x 16] intentionally omitted <==**

3 

## **3. Lippmann-Schwinger equation and FFT methods** 

Fourier methods are by principle based on the Lippmann-Schwinger equations. The latter follow from (1) and (4) as [22]: 

**==> picture [375 x 28] intentionally omitted <==**

where we have introduced a homogeneous “reference” elasticity tensor C[0] and its associated polarization field τ and Green operator G. In the above we assume ⟨G⟩ = 0 so that ε = ⟨ε( _**x**_ )⟩ holds. The Green operator has, in the Fourier domain, the closed form [23]: 

**==> picture [280 x 26] intentionally omitted <==**

where _**q**_ � 0 are the Fourier wave vectors and the subscript sym indicates minor symmetrization with respect to the variables ( _i_ , _j_ ) and ( _k_ , _l_ ). Hereafter, we assume that C[0] is a symmetric, positive-definite, isotropic tensor defined by its bulk (κ[0] ) and shear (µ[0] ) moduli, or Lam´e coefficient (λ[0] ). Accordingly, when _**q**_ � 0, the Green operator G is also symmetric definite and we have: 

**==> picture [311 x 32] intentionally omitted <==**

The “direct scheme” [11] consists in applying Eqs. (6) iteratively as: 

**==> picture [321 x 14] intentionally omitted <==**

In Moulinec and Suquet’s method, the convolution product (∗) above is computed as an algebraic product in the Fourier domain, making use of (8). Discrete Fourier transforms are used to switch between the space Ω and Fourier domain F . This amounts to representing the strain field as a trigonometric polynomial [12] of the form: 

**==> picture [252 x 33] intentionally omitted <==**

where ε( _**q**_ ) is the discrete Fourier transform of ε( _**x**_ ). Accordingly: 

**==> picture [246 x 27] intentionally omitted <==**

4 

Similar forms are used for the stress and displacement fields. In practice, the domain Ω is discretized on a square or cubic grid of _L[d]_ voxels and the operator G( _**q**_ ) in (7) is evaluated along equispaced Fourier modes: 

**==> picture [342 x 30] intentionally omitted <==**

As noted in [24], when _L_ is even, the relation: 

**==> picture [233 x 12] intentionally omitted <==**

where G( _**q**_ )[∗] is the complex conjugate of G( _**q**_ ), is not verified when one of the components of _**q**_ is equal to the highest frequency _qi_ = π (i.e. _mi_ = _L_ /2). As a consequence, the backward Fourier transform of G( _**q**_ )τ( _**q**_ ) used to compute the strain field has non-zero imaginary part even if τ( _**x**_ ) is purely real. To fix this problem, we follow [24] and set: 

**==> picture [293 x 20] intentionally omitted <==**

This choice enforces σ( _**q**_ ) = 0 at the concerned Fourier modes. In doing so, the strain field ε in (10) is not strictly-speaking irrotational, because of the lack of constraint at high Fourier modes for the strain field. We briefly mention another option that we explored in this work. It consists in forcing the symmetry by replacing G( _**q**_ ) with: 

**==> picture [233 x 26] intentionally omitted <==**

when one of the components of _**q**_ equals π, which enforces ε( _**q**_ ) = 0 at the highest modes. Numerical experiments indicate that the choice for G( _**q**_ ) at the highest frequencies has little influence on the convergence rate, except at small resolution. When _L_ < 128 pixels, faster convergence was achieved with the choice G( _**q**_ ) = C[0][�][−][1] . Furthermore, in the 2D example studied in this work, the choice G( _**q**_ ) = � C[0][�][−][1] led to smaller oscillations, consistently with observations in [24]. The use � of (15) was therefore not pursued further. We emphasize that, when _L_ is odd, this discrepancy disappears and no special treatment is needed. 

Refined FFT algorithms have been introduced to overcome the slow convergence rate of the direct scheme, observed for highly-contrasted composites, most notably the “accelerated scheme” [25] and “augmented Lagrangian” [26] methods. In this work, we use the extension of the accelerated scheme to elasticity [26, 27]: 

**==> picture [348 x 45] intentionally omitted <==**

The convergence rates of the accelerated and direct schemes depend on the choice of the reference tensor C[0] . For the accelerated scheme the optimal choice is [25, 27]: 

**==> picture [267 x 16] intentionally omitted <==**

For the direct scheme, upper bounds on the eigenvalues of the Green operator suggest the choice [27]: 

**==> picture [288 x 18] intentionally omitted <==**

with β = 1/2. 

## **4. Discretization and approximation space** 

In this section, we derive the expression of a modified Green operator G[′] that replaces G defined in (8) and (12). We give it in a form that includes previouslyproposed modified operators [20] and also introduce a new one. 

## _4.1. Two dimensions_ 

In the following, we assume that the strain and stress fields are defined on a grid of points in 2D, one per pixel. Eqs. (10) and (11) are used to apply discrete Fourier transforms, but we do not postulate a representation in the continuum anymore. The equilibrium and strain admissibility conditions (1) are approximated by means of finite differences on which we apply the discrete transforms (10) and (11). In [20], this results in the following form: 

**==> picture [340 x 18] intentionally omitted <==**

where _**k**_ and _**k**_[∗] represent “discrete” gradient and divergence operators, respectively. In the centered scheme, one takes _**k**_ equal to: 

**==> picture [237 x 15] intentionally omitted <==**

whereas in scheme [20], one chooses, for _**k**_ : 

**==> picture [235 x 15] intentionally omitted <==**

These expressions correspond, respectively, to the centered scheme: 

**==> picture [383 x 26] intentionally omitted <==**

6 

and to the forward-and-backward di erence scheme: 

∂ _j_ σ _ij_ ( _**x**_ ) ≈ σ _ij_ ( _**x**_ ) − σ _i j_ ( _**x**_ − e _j_ ), ∂ _jui_ ( _**x**_ ) ≈ _ui_ ( _**x**_ + e _j_ ) − _ui_ ( _**x**_ ). (23) Using (19), the resulting Green operator reads: 

**==> picture [309 x 26] intentionally omitted <==**

which is homogeneous in _**k**_ , so that, with _ri_ = _ki_ /| _**k**_ |: 

**==> picture [375 x 49] intentionally omitted <==**

where Re(·) denotes the real part of the enclosed quantity. The denominator on the right-hand side is strictly positive due to the triangle inequality. Hereafter, the operator G[′] is denoted by G[C] when _**k**_ = _**k**_[C] and by G[W] when _**k**_ = _**k**_[W] . Note that the operator G in (8) is recovered from (25) by setting _ki_ ( _**q**_ ) = i _qi_ . Now the Green operator G[′] is complex and follows the minor and major symmetries: 

**==> picture [333 x 19] intentionally omitted <==**

Furthermore we have: 

**==> picture [248 x 14] intentionally omitted <==**

for the schemes (22) and (23), including when _qi_ = π and when _L_ is even, because _ki[C]_[,] _[W]_ is real at the frequency _qi_ = π. Therefore, the fix (14) in Sec. (3) is not necessary. However, a problem of a different nature arises when using the centered scheme (20) when _L_ is even. Eq. (25) does not define the Green operator G[C] at the three frequencies _**q**_ = (π; 0), (0; π) and (π; π), for which _**k**_[C] ( _**q**_ ) = 0. This is because the second equation in (22) has in general non-unique solutions for the displacement field _**u**_ ( _**x**_ ). Indeed, when _L_ is even, the displacement is defined up to a linear combination of 2-voxels periodic fields. They are given by the following 8 independent fields: 

**==> picture [384 x 35] intentionally omitted <==**

The operator G[C] remains finite when _**q**_ approaches one of the modes (π; 0), (0; π) or (π; π), but can not be continuously extended at these modes. To fix this problem, we set, for the centered scheme: 

**==> picture [340 x 17] intentionally omitted <==**

7 

which enforces ε( _**q**_ ) = 0 at the highest frequencies. The strain field ε( _**x**_ ) is accordingly admissible, and the stress field σ( _**x**_ ) is divergence-free, in the sense of (22). We explored the alternate choice G[C] ( _**q**_ ) = C[0][�][−][1] in (29). Almost identical conver� gence rates and oscillations were observed for the two options, however the choice G[C] ( _**q**_ ) = C[0][�][−][1] does not produce an irrotational strain field and is not considered � further. We emphasize that no special treatment is required for the operator G[W] at high frequencies since _**k**_[W] � 0 when _**q**_ � 0. 

By substituting G with G[C] or G[W] in (9) and (16), we derive “direct” and “accelerated” schemes that solve (22) or (23). In the limit of very fine resolution, we have G[C,W] ( _**q**_ ) ≈ G( _**q**_ ) when _**q**_ → 0, which guarantees that the strain and stress fields do not depend on the employed discretization. This property holds for any choice of _**k**_ such as _**k**_ ∼ i _**q**_ when _**q**_ → 0. 

On the one hand, derivatives are estimated more locally in the forward-andbackward scheme (21) than in the centered scheme (20), which is important along interfaces. On the other hand, the forward-and-backward scheme does not treat symmetrically the two angle bisectors **e** 1 + **e** 2 and **e** 1 − **e** 2 [20]. In a domain containing a single centered disc, the scheme produces fields that break the axial symmetries of the problem. In fact, the discretization (23) is actually one of four possible choices, all of them breaking the symmetries. Attempts to force the symmetry by averaging over the four Green operators or over the fields themselves, as proposed in [20], are not explored in this work. The fomer method indeed leads to less accurate “diffuse” local fields. The latter necessitates to run four different computations, in 2D, instead of one, which is cumbersome. 

In the rest of this section, we derive a discrete scheme in 2D different from (22) and (23). In this scheme, the displacement field is evaluated at the 4 corners of the pixels and the strain and stress fields are evaluated at the centers of the pixels. We first express these fields in the 45[o] -rotated basis: 

**==> picture [269 x 27] intentionally omitted <==**

by: 

**==> picture [374 x 29] intentionally omitted <==**

where uppercase indices refer to components in the rotated grid. We discretize (1) 

8 

**==> picture [112 x 110] intentionally omitted <==**

Figure 1: A pixel with edges parallel to the Cartesian axis ( **e** 1; **e** 2). Superimposed: 45[o] -rotated basis ( **f** 1; **f** 2). The strain and stress fields are evaluated at the pixel center _**x**_ (square). The displacement and the divergence of the stress field lie along the pixel corners (disks). 

in the rotated basis by the centered differences (see Fig. 1): 

**==> picture [362 x 56] intentionally omitted <==**

where _**x**_ lie at the centers of the pixels and _**x**_ ± **f** _I_ / √2 lie at the corners. Expressing back (32) in the original Cartesian grid ( **e** 1; **e** 2) and applying the backward discrete Fourier transform (10) we arrive again at (19) with the following expression for _**k**_ : 

**==> picture [286 x 26] intentionally omitted <==**

We denote by G[R] the corresponding Green operator, derived by substituting _**k**_ = _**k**_[R] in (25). The operator G[R] is real and also verifies: 

**==> picture [237 x 13] intentionally omitted <==**

However, when _L_ is even, _**k**_[R] = 0 when _**q**_ = (π; π) and G[R] is not defined by (25) at this frequency. Again, this is because (32c) gives the displacement field up to linear combinations of the 4 independent fields _v_[1] 1[,] ,[4] 2[(see 28).][Accordingly we set:] 

**==> picture [319 x 14] intentionally omitted <==**

which enforces strain compatibility and stress equilibrium, in the sense of (32). 

9 

## _4.2. Three dimensions_ 

We follow the same methodology in 3D. The equilibrium and strain admissibility conditions (19) are unchanged, as well as the expression for the vectors _**k**_[C,W] in (20) and (21) resulting from (22) and (23). In 3D, we also extend (33) as: 

**==> picture [309 x 26] intentionally omitted <==**

for the rotated scheme. The strain and stress fields are now evaluated at the centers of the voxels and the displacement field at their corners. Derivatives of the displacement are estimated by differences at opposite corners. For the strain components ε11 and ε12: 

**==> picture [367 x 107] intentionally omitted <==**

where _**x**_ lie at the center of a voxel. The expression for the strain component ε22 (resp. ε33) is obtained after exchanging the indicia 1 and 2 (resp. 1 and 3) in (37a). The component ε23 (resp. ε13) is derived from (37b) by exchanging the indicia 3 and 1 (resp. 3 and 2). Stress divergence is discretized in a similar manner. Its first component reads: 

**==> picture [368 x 92] intentionally omitted <==**

where _**x**_ lie at one of the _edges_ of a voxel. The components ∂ _i_ σ _i_ 2 and ∂ _i_ σ _i_ 3 are obtained from (38) by circular permutations of the indicia 1, 2 and 3. We note that (37) and (38) are the natural generalization of (32) to _d_ = 3, expressed in the Cartesian basis ( **e** 1; **e** 2; **e** 3). 

10 

In 3D, Eq. (24) yields, for the Green operator: 

**==> picture [389 x 64] intentionally omitted <==**

where again _ri_ = _ki_ /| _**k**_ | and _**s**_ is the symmetric second-order tensor: 

**==> picture [343 x 16] intentionally omitted <==**

with Im(·) the imaginary part of the enclosed complex quantity. Like in 2D, the operator G[′] follows minor and major symmetries (26). 

Again, the operators G[C] , G[W] and G[R] are derived using the expression for G[′] in (39) with _**k**_ = _**k**_[C] , _**k**_[W] and _**k**_[R] , respectively. The symmetries (27) and (34) are verified in 3D as well. But again, a special treatment is needed for G[C] and G[R] when _L_ is even, at the modes _**q**_ for which _**k**_[C,R] ( _**q**_ ) = 0. Like in 2D, the displacement is undefined at these frequencies and the Fourier coefficients of the strain field are zero and so we set G[C,R] = 0 at these frequencies. More precisely, we apply (29) when _d_ = 3 and, for the rotated scheme: 

**==> picture [344 x 15] intentionally omitted <==**

The operators G[C] , G[W] and G[R] are, in 2D and 3D, periodic functions where, contrary to G, high frequencies are cut. Accordingly, we expect faster convergence rates for schemes using operators derived from finite differences and more exact local fields, as was previously observed in the conductivity problem [17]. We also expect higher accuracy for the local fields when employing G[R] rather than the other discrete operators G[W] and G[C] . First, the operator G[R] is based on centered differences which are more precise than forward and backward differences, used in G[W] . Second, derivatives are evaluated more locally when using G[R] rather than G[C] . Indeed, the latter are computed at points separated by 2 voxels for G[C] instead of √2 (in 2D) or √3 voxels (in 3D) for G[R] . 

The above considerations guided the choice for the discretization schemes (37) and (38), leading to _**k**_[R] and G[R] . Clearly, many other choices are possible, and Eq. (39) gives a general class of Green operators based on finite-differences. The latter depend on the choice for the complex vector _**k**_ . However, a systematic investigation of such discrete schemes is beyond the present study. 

In the the rest of this study, we estimate the accuracy of the local fields and of the effective properties predicted by the various schemes, as well as their convergence rates. We denote by DS and AS the direct and accelerated schemes defined 

11 

by (9) and (16) respectively, when G is used. We denote by _DS_ C, _DS_ W, _DS_ R and _AS_ C, _AS_ W and _AS_ R, the same algorithms obtained by substituting G with G[C,W,R] respectively. We emphasize that, for a given Green operator, the direct and accelerated schemes produce the same strain and stress fields, up to round-off errors. 

## **5. Local strain and stress fields accuracy** 

## _5.1. Two-dimensions_ 

Hereafter we consider the 2D ‘four-cell’ microstructure, where the periodic domain Ω is divided into 4 identical squares of surface fraction 25%. Its nontrivial solution with singular fields at the corners makes it a good benchmark for numerical schemes. Furthermore, the microstructure is discretized exactly at any resolution, provided _L_ is even. In the following, we make use of a simplified version of the four-cell microstructure made of a single quasi-rigid square inclusion embedded in a matrix (Fig. 2). We set the contrast to χ = 10[3] . The material is subjected to the macroscopic strain loading: 

**==> picture [253 x 25] intentionally omitted <==**

We determine the strain and stress fields predicted by FFT schemes when using the Green operators G or G[C,W,R] . The fields are computed using the accelerated scheme (16) at discretizations _L_ = 512, 1024 and 2048. Iterations are stopped when the strain and stress fields maximum variation over two iterations in any pixel is less than 2 10[−][13] . These variations are the effect of round-off errors in double precision floating point numbers. These computations allow us to compare the effect of the discretization, independently of the algorithm used for convergence. 

We focus on the stress component σ12( _**x**_ ) parallel to the applied loading in a small region [−0.04; 0.04][2] around the corner of the inclusion (Fig. 3). At low resolution _L_ = 512, numerical methods predict values as large as 10.1 in a few pixels, because of the singularity of the stress field at the corner. To highlight the field patterns, we threshold out the values above 3.5, which amount to 0.24% of the pixels. Using the same color scale for all images, the smallest stress value, equal to 1.5, is shown in dark blue whereas the highest, equal to 3.5, is in dark red. Green, yellow and orange lie in-between. 

As expected, in the limit of very fine resolution, all methods tend to the same local stress field, as shown by the similar field maps obtained at resolution _L_ = 2048. However, use of the Green operator G leads to spurious oscillations along the interfaces of the inclusion, up to resolutions as big as 2048[2] pixels, a side-effect 

12 

**==> picture [114 x 118] intentionally omitted <==**

**----- Start of picture text -----**<br>
μ [1] , κ [1] μ [2] , κ [2]<br>0 e<br>2<br>e<br>1<br>**----- End of picture text -----**<br>


Figure 2: Elementary periodic domain Ω= [1/2; 1/2][2] containing a square inclusion with elastic moduli µ[2] , κ[2] (top-left, shown in white) embedded in a matrix (shown in gray) with elastic moduli µ[1] , κ[1] . 

noticed in [17] in conductivity. The oscillations do not disappear after computing local averages of the fields (not shown). 

Strong oscillations are produced by schemes using G[C] as well, not only in the quasi-rigid inclusion, but also in the matrix. We observe checkerboard patterns in the former, and vertical and horizontal alignments in the latter, at resolution 1024[2] . These oscillations are greatly reduced by the use of G[W] . Still, due to the non-symmetric nature of G[W] , the stress is not correctly estimated along a line of width 1 pixel oriented upward from the inclusion corner. Similar patterns are observed, in other directions, along the three other corners of the inclusion (not shown). These issues are solved when using G[R] which produces a stress field that respects the symmetries of the problem. Furthermore, use of G[R] greatly reduces oscillations compared to G and G[C] . 

## _5.2. Three-dimensions_ 

In this section, we consider a 3D material analogous to the four-cell microstructure in 2D. We divide the periodic domain into 8 identical cubes of volume fraction 12.5%. One is the inclusion, the other 7 are the matrix. To highlight the symmetries of the problem, we assume the inclusion is centered in the domain Ω and contained in the region [−1/4; 1/4][3] . Again, we apply a macroscopic strain loading of the form (42). The inclusion is quasi-rigid compared to the matrix with contrast of properties χ = 10[3] . We compute the strain and stress fields predicted by each Green operator using the accelerated scheme. As in Sec. (5.1) we let the iterations converge up to round-off errors in double precision. 

A 2D section of the stress component σ12( _**x**_ ) is represented in Fig. (4). The 

13 

**==> picture [386 x 480] intentionally omitted <==**

**----- Start of picture text -----**<br>
L  = 512 L  = 1024 L  = 2048<br>G<br>G [C]<br>G [W]<br>G [R]<br>**----- End of picture text -----**<br>


Figure 3: Stress component σ12( _**x**_ ) predicted by the various FFT schemes at the three resolutions _L_ = 512, 1024 and 2048 (left to right) in the region [−0.04; 0.04][2] . The center of the region is the bottom-left corner of the square inclusion in Fig. (2). 

14 

section is a cut parallel to one of the faces of the inclusion, normal to **e** 3, of equation _x_ 3 = −0.2461. The section intersects the inclusion, but is very close to the interface with the matrix. Again, to highlight the field patterns, we threshold out values of the field greater than 8.5, this time less than 0.04% of the voxels, and represent all field using the same color scale. 

At high resolution _L_ = 1024, the fields resulting from the use of G and G[C,W,R] are close to one another. However, stress patterns near the corners of the inclusion are less pronounced with G than with the other methods. At smaller resolutions _L_ = 256 and _L_ = 512, the stress fields predicted by G are notably different from the others, suggesting slower size-convergence with this operator. Furthermore, the field maps computed at resolution _L_ = 512 confirms the results obtained in 2D: strong oscillations are observed inside the inclusion when using G and G[C] . The two methods produce artificial patterns directed vertically and horizontally, close to the interface. Conversely, the fields produced by G[W] and G[R] have the smallest oscillations, but that of G[W] are not symmetric. When _L_ = 256, indeed, the stress field near the top-left corner of the inclusion stands out from that in the other corners. This effect only slowly disappears when _L_ is increased. The solution resulting from the use of G[R] does not suffer from this problem. As in 2D, it produces symmetric fields. Furthermore, the latter are close to one another at all resolutions and contain almost no oscillations. 

## _5.3. Periodic array of spheres_ 

Contrary to the previous sections, we now consider a microstructure without singularities (edges or corners) and focus on the effect of the Green operator discretization on the effective elastic properties. In the rest of this section, the elementary domain Ω contains one spherical inclusion of volume fraction 20%, so that the material is a periodic array of spheres. The spheres are very soft with contrast of properties χ = 10[−][4] . We compute the effective elastic modulus _C_[�] 11,11 produced by either G or G[C,W,R] at increasing resolutions _L_ = 32, 64, 128, 256 and 512. Again, we use the accelerated scheme and iterations are stopped when the stress field maximum variation over two iterations in any pixel is less than 2 10[−][10] . Results are shown in Fig. (5) and are compared with the analytical estimate in [28]. When the resolution increases, the effective elastic modulus _C_[�] 11,11 increases up to a limit value that we estimate to about 1.208 ± 0.001, for all schemes. As observed in other studies [5], very large systems are needed to compute this estimate at a high precision. 

This is especially true of the Green operator G which has the slowest convergence with respect to the system size. At fixed resolution, the error on the pre- 

15 

**==> picture [386 x 480] intentionally omitted <==**

**----- Start of picture text -----**<br>
L  = 256 L  = 512 L  = 1024<br>G<br>G [C]<br>G [W]<br>G [R]<br>**----- End of picture text -----**<br>


Figure 4: 2D section of the stress component σ12( _**x**_ ) along the plane _x_ 3 = −0.2461 predicted by the various FFT schemes at the three resolutions _L_ = 256, _L_ = 512 and _L_ = 1024 (left to right). The section is parallel to one of the faces of the inclusion and close to the interface with the matrix. 

16 

**==> picture [256 x 196] intentionally omitted <==**

**----- Start of picture text -----**<br>
~<br>C<br>11,11<br>Cohen (2004)<br>1.21<br>L= ∞ (estimate)<br>1.2<br>1.19<br>1.18<br>1.17<br>Sphere 20%,  [   =10][− 4]<br>1.16<br>32 64 128 256 512 L<br>**----- End of picture text -----**<br>


Figure 5: Apparent elastic modulus _C_[�] 11,11 estimated by FFT methods using the Green operators G and G[C,W,R] (black and red), at increasing resolution _L_ . Orange: estimate in [28]; violet: estimate of the asymptotic effective modulus _C_[�] 11,11 using FFT data. 

dictions given by G is about 2 times larger than the one provided by G[R] , which, among all methods, gives the best estimate. The operators G[C] and G[W] stand inbetween. This is another indication of the benefits of the operator G[R] . 

## **6. Convergence rate** 

## _6.1. Convergence rate with respect to stress equilibrium_ 

In this section, we estimate the rates of convergence of the direct and accelerated schemes DS, DSC,W,R, AS and ASC,W,R, that use the various Green operators. All schemes enforce stress equilibrium at convergence only, therefore we follow [27] and consider a criterion based on the _L_[2] -norm: 

**==> picture [384 x 42] intentionally omitted <==**

where η ≪ 1 is the precision and the normalizing factor ||⟨σ⟩|| is the Frobenius norm: 

**==> picture [107 x 29] intentionally omitted <==**

17 

In (43) we set _**k**_ = _**k**_[C,W,R] for the schemes using G[C,W,R] and _**k**_ = i _**q**_ when using the Green operator G, so that _**k**_ · σ( _**q**_ ) is the divergence of the stress field in the Fourier domain, estimated according to the various discretization schemes. 

We now estimate the convergence rates on a random microstructure. In the following, the domain Ω is a (periodized) Boolean model of spheres of resolution _L_ = 64 and volume fraction 17%, below the percolation threshold of the spheres — of about 29% [29]. To obtain meaningful comparisons, we use the same randomly-generated microstructure for all schemes. This particular configuration contains 743 spheres of diameter 5 voxels, about 13 times smaller than the size of Ω. 

Taking ν[0] = ν[1] = ν[2] = 0.25 for the reference Poisson ratio, we compute numerically the number of iterations _N_ ( _E_[0] ) required to reach the precision η ≤ 10[−][8] , for varying reference Young moduli _E_[0] , in the range 0 < _E_[0] < 1. We consider the Boolean model of spheres with contrast χ = 10[−][5] and the various accelerated schemes AS and ASC,W,R (Fig. 6). Within the range 0 < _E_[0] ≲ 0.03, the number of iterations _N_ ( _E_[0] ) is about the same for all accelerated schemes. When _E_[0] > 0.03, however, _N_ ( _E_[0] ) is a strongly increasing function of _E_[0] for scheme AS, contrary to the other schemes ASC,W,R. For the latter, _N_ ( _E_[0] ) decreases with _E_[0] up to a local minimum, beyond which variations are much less sensitive to _E_[0] . One unique local minimum around _E_[0] ≈ 0.09 is found for scheme ASR, whereas the schemes ASW and ASC exhibit two local minima. 

The effect of the Poisson ratio is also investigated numerically. We let ν[0] = 0.25 ± 0.01 and 0.25 ± 0.05 for various values of _E_[0] with χ = 10[−][5] and observe a strong increase of the number of iterations _N_ ( _E_[0] ), for the schemes AS and ASC,W,R. The same behavior is observed for the direct scheme DS and DSC,W,R with χ = 10[−][2] . Therefore, in the following, we fix the Poisson ratio to ν[0] = 0.25 for the reference tensor, for all schemes and all contrast of properties χ. This leaves one parameter, _E_[0] , to optimize on. We use the gradient descent method to determine a local minimum of _N_ ( _E_[0] ) for arbitrary contrast and scheme DS, DSC,W,R, AS and ASC,W,R. As above, _N_ ( _E_[0] ) is the number of iterations necessary to reach η ≤ 10[−][8] . We choose _E_[0] = 0.51( _E_[1] + _E_[2] ) for schemes DS, DSC,W,R and _E_[0] = √ _E_[1] _E_[2] for schemes AS and ASC,W,R as initial guess for _E_[0] , suggested by (18) and (17). At each step, we determine if _E_[0] is to be increased or decreased, by comparing _N_ ( _E_[0] ) with _N_ ( _E_[0] +δ _E_[0] ) where δ _E_[0] = 0.01 _E_[0] . It frequently happens that _N_ ( _E_[0] ) = _N_ ( _E_[0] + δ _E_[0] ). In that case, we compare the values of the precision η after _N_ ( _E_[0] ) iterations and follow the direction that minimizes η. Iterations are stopped whenever _N_ ( _E_[0] ) is unchanged after two descent steps. 

18 

**==> picture [256 x 195] intentionally omitted <==**

**----- Start of picture text -----**<br>
0<br>N(E )<br>-5<br>1200 χ =10<br>AS<br>AS<br>1000 C<br>AS<br>W<br>800 ASR<br>600<br>400<br>200<br>0<br>0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0<br>E<br>**----- End of picture text -----**<br>


Figure 6: Number of iterations _N_ ( _E_[0] ) required to achieve convergence, as a function of the reference Young modulus _E_[0] , for the accelerated schemes AS and ASC,W,R using various Green operators. Convergence is achieved when the precision η = 10[−][8] is reached. The microsctructure is a Boolean model of quasi-porous spheres with χ = 10[−][5] . 

The gradient descent method determines a local minimum rather than the global minimum, which is sub-optimal. To check the validity of the results, further numerical investigations are carried out for χ = 10[−][2] , 10[2] and schemes DS and DSC,W,R. The method predicts the global minimum in these cases. This also holds for schemes AS and ASW,R with χ = 10[−][5] , 10[5] , but not for scheme _AS_ C with χ = 10[−][5] . However, in this case the number of iterations _N_ ( _E_[0] ) are very similar at the two local minima, as shown in Fig. (6). In the following, the results given by the gradient descent method are used as-is. 

Results for the optimal reference _E_[0] are indicated in Fig. (7). For the direct scheme, the optimal reference follows (18) with 0.5003 ≤ β ≤ 0.509, independently of the Green operator used. Values of β smaller than 1/2 lead to nonconverging schemes. For the accelerated schemes, the situation is less simple, and differs depending on the Green operator in use. For the scheme AS with Green operator G, the choice (17) is optimal except in the region χ ≤ 10[−][3] where the value of _E_[0] tend to a small constant of about 0.01. Similar behavior is found for the schemes ASC,R for which: 

**==> picture [231 x 15] intentionally omitted <==**

19 

with _E_ 1[0][=][0][.][07][for] _[AS]_[ C][and] _[E]_ 1[0][=][0][.][12][for] _[AS]_[ R][.][Similar][behavior][has][been] observed numerically in [17], in the context of conductivity. For the scheme _AS_ W that uses G[W] , the optimal choice for _E_[0] follows the same pattern as above with _E_[0][0][.][7 except in the region 10][−][4][≤][χ][≤][10][−][1][.][This behavior is an e][ff][ect of the] 1[=] presence of two local minima, similar to that shown in Fig. (6) for χ = 10[−][5] . 

Convergence rates, computed with optimized reference, are represented in Fig. (8) as a function of the contrast, in log-log scale. Results for χ = 0 (strictly porous media) have been included in the same graph (left point). As is wellestablished [26, 30], the number of iterations in the direct scheme DS scales as χ when χ ≫ 1 and 1/χ when χ ≪ 1. For the accelerated scheme AS, the number of iterations is smaller and follows[√] χ when χ ≫ 1 and 1/[√] χ when χ ≪ 1, with one exception. At very high contrast of properties χ < 10[−][6] , including at χ = 0, convergence is reached after a finite number of iterations, about 1, 300. This particular behavior is presumably sensitive to the value choosen for the requested precision η = 10[−][8] . 

When χ < 1, the schemes DSC,W,R and ASC,W,R, that use G[C,W,R] , converge after a number of iterations not exceeding 430. As shown in Fig. (8), the number of iterations is nearly constant in the range 0 ≤ χ ≤ 10[−][5] . As expected, the accelerated schemes ASC,W,R are faster than the direct schemes DSC,W,R, with scheme ASR proving the fastest. With this scheme and when χ < 1, the number of iterations is at most 168. Again, these results are qualitatively similar with that given in [17] in the context of conductivity. 

For rigidly-reinforced media (χ > 1), the number of iterations of schemes DSC,W,R and ASC,W,R follow the same powerlaw behaviors, with respect to χ, as that of DS or AS. In all considered schemes, the number of iterations continuously increases with the contrast. Differences are observed between the various accelerated schemes AS and ASC,W,R, with ASR the fastest. The use of Green operators associated to the problem for the strain field, as undertaken here, results in convergence properties that are worse in the region χ > 1 than when χ < 1. In this respect, benefits are to be expected from the use of dual Green operators [17], associated to the problem for the stress fields. 

## _6.2. Convergence rate with respect to the e_ ff _ective elastic moduli_ 

In this section, we focus on the accelerated schemes AS and ASC,W,R and examine the rate of convergence of the various schemes with respect to the effective elastic moduli. We consider the same Boolean microstructure as given in Sec. (6) but discretized on higher resolution grids of 256[3] and 512[3] voxels. The volume fraction of the spheres are respectively 16.82% and 16.85%. For simplicity, the 

20 

**==> picture [256 x 198] intentionally omitted <==**

**----- Start of picture text -----**<br>
E<br>0<br>3<br>10 DS<br>DS<br>C<br>2 DS<br>10 W<br>DS<br>R<br>10 AS<br>AS<br>C<br>AS<br>1 W<br>AS<br>R<br>-1<br>10<br>-2<br>10<br>-6 -4 -2 2 4 6<br>0 10 10 10 1 10 10  10 χ<br>**----- End of picture text -----**<br>


Figure 7: Optimal reference Young modulus _E_[0] as a function of the contrast of properties χ, for the various FFT methods, in log-log scale. Direct schemes: black and red (nearly superimposed to one another); accelerated schemes: blue and green. Results for a porous material (χ = 0) are indicated at the left of the graph. The material is a Boolean model of spheres with volume fraction 17%. 

21 

**==> picture [256 x 186] intentionally omitted <==**

**----- Start of picture text -----**<br>
iterations<br>DS<br>1024<br>DS<br>C<br>DS<br>256 W<br>DS<br>R<br>AS<br>64 AS<br>C<br>AS<br>W<br>16 AS<br>R<br>4<br>1<br>-6 -4 -2 2 4 6<br>0 10 10 10 1 10 10 10 χ<br>**----- End of picture text -----**<br>


Figure 8: Number of iterations as a function of the contrast of properties χ, for the various FFT methods, in log-log scale. Direct schemes: black and red; accelerated schemes: blue and green. Results for a porous material (χ = 0) are indicated at the left of the graph. The material is a Boolean model of spheres with volume fraction 17%. 

contrast of properties take on two values χ = 10[−][4] and χ = 10[4] , so that the spheres are quasi-porous or quasi-rigid. 

We perform iterations of the schemes AS and ASC,W,R using the optimized reference moduli found in the previous section, on the lower resolution grid. We apply the macroscopic strain loading: 

**==> picture [56 x 12] intentionally omitted <==**

At each iteration and for each scheme, we compute the elastic modulus _C_[�] 11,11, derived from the mean ⟨σ11⟩ of the stress component σ11. The convergence rate toward the elastic modulus is represented in Fig. (9) for quasi-porous spheres with _L_ = 512 and in Fig. (10) for quasi-rigid spheres with _L_ = 256. In Fig. (9), for the sake of clarity, the elastic moduli are represented by symbols once every 5 iterations, except for the first five iterations of the scheme ASR which are all represented. Dotted lines are guide to the eyes. In the porous case, much better convergence is obtained with scheme ASR than with schemes AS and ASC,W, as shown in Fig. (9). The estimate for _C_[�] 11,11 predicted by AS and ASC,W present strong oscillations that are much reduced with ASR. After about 7 iterations, the estimate given by ASR is valid to a relative precision of 10[−][2] . To achieve the same precision, more than 50 iterations are needed for schemes AS and ASC,W. 

22 

**==> picture [256 x 197] intentionally omitted <==**

**----- Start of picture text -----**<br>
~<br>C<br>11,11<br>−4<br>L=512,  χ=10<br>1.4<br>HS<br>1.2<br>1 AS<br>AS<br>C<br>AS<br>0.8 W<br>AS<br>R<br>0 10 20 30 40 50 60 70 80 90<br>iterations<br>**----- End of picture text -----**<br>


Figure 9: Estimate of the elastic modulus _C_[�] 11,11 as a function of the number iterations performed, for a 3D Boolean model of quasi-porous spheres. Black symbols: accelerated schemes AS, ASC, ASW; red: scheme ASR (orange: Hashin and Shtrikman upper bound). 

The situation is notably different for quasi-rigid spheres (Fig. 10). For all schemes, a much higher number of iterations is required to determine the elastic modulus _C_[�] 11,11 with a precision of 10[−][2] . The slower convergence rate follows that observed in Sec. (6), where convergence is much poorer for χ > 1 than for χ < 1, and where ASR is less advantageous compared to the other schemes . Nevertheless, in this case also, as shown in Fig. (10), smaller oscillations are observed in the estimate for _C_[�] 11,11 when using ASR rather than schemes AS or ASC,W. 

## **7. Conclusion** 

In this work, a novel discretization method has been proposed in 2D and 3D for use in Fourier-based schemes. The core of the proposed scheme is a simple modification of the Green operator in the Fourier domain. The results obtained confirm those achieved in the context of conductivity [17]. Compared to schemes using trigonometric polynomials as approximation space, or to other finite-differences methods, superior convergence rates have been observed in terms of local stress equilibrium, but also in terms of effective properties. More importantly, the solution for the local fields, predicted by the new discretization scheme is found to be 

23 

**==> picture [256 x 196] intentionally omitted <==**

**----- Start of picture text -----**<br>
 ~<br>C<br>11,11<br>3.6 AS<br>AS<br>C<br>AS<br>3.4 W<br>AS<br>R<br>3.2<br>3<br>2.8<br>4<br>L=256,  χ=10<br>40 60 80 100 120 140<br>iterations<br>**----- End of picture text -----**<br>


Figure 10: Estimate of the elastic modulus _C_[�] 11,11 as a function of the number iterations performed, for a 3D Boolean model of quasi-rigid spheres. Black lines: accelerated schemes AS, ASC, ASW; red: scheme ASR. 

more accurate than that of other methods, especially at the vicinity of interfaces. This property is important when applying FFT methods to solve more complex problems like large strain deformation [31]. The new method also provides better estimates for the effective elastic moduli. Furthermore, its estimates does not depend on the reference medium, because the scheme is based on a finite-differences discretization of continuum mechanics. Although not explored in this work, the modified Green operator can be used with most other FFT iterative solvers, like the “augmented Lagrangian” [32] or with FFT algorithms that are less sensitive to the reference [14, 15], leading to the same local fields. 

## **Acknowledgements** 

The author thanks Carnot M.I.N.E.S for support through grant 20531. 

## **References** 

- [1] S.-B. Lee, R. A. Lebensohn, and A. D. Rollett. Modeling the viscoplastic micromechanical response of two-phase materials using fast fourier transforms. _International Journal of Plasticity_ , 27(5):707–727, 2011. 

24 

- [2] J. Li, S. Meng, X. Tian, F. Song, and C. Jiang. A non-local fracture model for composite laminates and numerical simulations by using the fft method. _Composites Part B: Engineering_ , 43(3):961–971, 2011. 

- [3] M. Faessel and D. Jeulin. Segmentation of 3D microtomographic images of granular materials with the stochastic watershed. _Journal of Microscopy_ , 239(1):17–31, 2010. 

- [4] F. Willot, L. Gillibert, and D. Jeulin. Microstructure-induced hotspots in the thermal and elastic responses of granular media. _International Journal of Solids and Structures_ , 50(10):1699–1709, 2013. 

- [5] C. F. Dunant, B. Bary, A. B. Giorla, C. Pniguel, J. Sanahuja, C. Toulemonde, A. B. Tran, F. Willot, and J. Yvonnet. A critical comparison of several numerical methods for computing effective properties of highly heterogeneous materials. _Advances in Engineering Software_ , 58:1–12, 2013. 

- [6] F. Willot and D. Jeulin. Elastic and electrical behavior of some random multiscale highly-contrasted composites. _International Journal for Multiscale Computational Enginneering: special issue on Multiscale modeling and uncertainty quantification of heterogeneous materials_ , 9(3):305–326, 2011. 

- [7] J. Escoda, F. Willot, D. Jeulin, J. Sanahuja, and C. Toulemonde. Estimation of local stresses and elastic properties of a mortar sample by FFT computation of fields on a 3D image. _Cement and Concrete Research_ , 41(5):542– 556, 2011. 

- [8] Morphhom software, `http://cmm.ensmp.fr/morphhom` , accessed October 4, 2014. 

- [9] CraFT software, `http://craft.lma.cnrs-mrs.fr` , accessed October 4, 2014. 

- [10] GeoDict software, `http://www.geodict.de` , accessed October 4, 2014. 

- [11] H. Moulinec and P. Suquet. A fast numerical method for computing the linear and non linear mechanical properties of the composites. _Comptes rendus de l’Academie des sciences, S´erie II_ , 318(11):1417–1423, 1994. 

- [12] J. Vondˇrejc, J. Zeman, and I. Marek. An FFT-based Galerkin method for homogenization of periodic media. _Computers_ & _Mathematics with Applications_ , 68(3):156–173, 2014. 

25 

- [13] S. Brisard and L. Dormieux. Combining Galerkin approximation techniques with the principle of Hashin and Shtrikman to derive a new FFT-based numerical method for the homogenization of composites. _Computational Methods for Applied Mechanical Engineering_ , 217(220):197–212, 2012. 

- [14] J. Zeman, J. Vodrejc, J. Novak, and I. Marek. Accelerating a FFT-based solver for numerical homogenization of a periodic media by conjugate gradients. _Journal of Computational Physics_ , 229(21):8065–8071, 2010. 

- [15] S. Brisard and L. Dormieux. FFT-based methods for the mechanics of composites: A general variational framework. _Computational Materials Science_ , 49(3):663–671, 2010. 

- [16] S. Brisard and F. Legoll. Periodic homogenization using the lippmann– schwinger formalism, 2014. `http://arxiv.org/abs/1411.0330` . 

- [17] F. Willot, B. Abdallah, and Y.-P. Pellegrini. Fourier-based schemes with modified green operator for computing the electrical response of heterogeneous media with accurate local fields. _International Journal for Numerical Methods in Engineering_ , 98(7):518–533, 2014. 

- [18] W. H. M¨uller. Mathematical vs. experimental stress analysis of inhomogeneities in solids. _Journal de Physique_ , 6(C1):139–148, 1996. 

- [19] C.M. Brown, W. Dreyer, and W.H. M¨uller. Discrete fourier transforms and their application to stress–strain problems in composite mechanics: a convergence study. _Proceedings of the Royal Society of London. Series A: Mathematical, Physical and Engineering Sciences_ , 458:1967–1987, 2002. 

- [20] F. Willot and Y.-P. Pellegrini. Fast Fourier transform computations and build-up of plastic deformation in 2D, elastic-perfectly plastic, pixelwisedisordered porous media. In _D. Jeulin, S. Forest (eds), “Continuum Models and Discrete Systems CMDS 11”_ , pages 443–449, Paris, 2008. Ecole[´] des Mines. 

- [21] M. F. Thorpe and P. N. Sen. Elastic moduli of two-dimensional composite continua with elliptic inclusions. _Journal of the Acoustical Society of America_ , 77(5):1674–1680, 1985. 

- [22] G. W. Milton. _The Theory of Composites_ . Cambridge Univ. Press, Cambridge, 2002. 

26 

- [23] S. Kanaun and V. Levin. _Self-consistent methods for composites_ . Springer, Dordrecht, The Netherlands, 2008. 

- [24] H. Moulinec and P. Suquet. A numerical method for computing the overall response of nonlinear composites with complex microstructure. _Computer Methods in Applied Mechanics and Engineering_ , 157(1):69–94, 1998. 

- [25] D. J. Eyre and G. W Milton. A fast numerical scheme for computing the response of composites using grid refinement. _The European Physical Journal Applied Physics_ , 6(1):41–47, 1999. 

- [26] J.-C. Michel, H. Moulinec, and P. Suquet. A computational scheme for linear and non-linear composites with arbitrary phase contrast. _International Journal for Numerical Methods in Engineering_ , 52(1-2):139–160, 2001. 

- [27] H. Moulinec and F. Silva. Comparison of three accelerated FFT-based schemes for computing the mechanical response of composite materials. _International Journal for Numerical Methods in Engineering_ , 97(13):960– 985, 2014. 

- [28] I. Cohen. Simple algebraic approximations for the effective elastic moduli of cubic arrays of spheres. _Journal of the Mechanics and physics of Solids_ , 52(9):2167–2183, 2004. 

- [29] F. Willot and D. Jeulin. Elastic behavior of composites containing boolean random sets of inhomogeneities. _International Journal of Engineering Science_ , 47(2):313–324, 2009. 

- [30] H. Moulinec and P. Suquet. Comparison of FFT-based methods for computing the response of composites with highly contrasted mechanical properties. _Physica B: Condensed Matter_ , 338(1–4):58–60, 2003. 

- [31] N. Lahellec, J.-C. Michel, H. Moulinec, and P. Suquet. Analysis of inhomogeneous materials at large strains using fast fourier transforms. In _Proc. IUTAM Symposium on Computational Mechanics of Solid Materials at Large Strains_ , pages 247–258. Kluwer Academic Publishers, 2001. 

- [32] J.-C. Michel, H. Moulinec, and P. Suquet. A computational method based on augmented lagrangians and fast fourier transforms for composites with high contrast. _Computer Modelling in Engineering_ & _Sciences_ , 1(2):79–88, 2000. 

27 

