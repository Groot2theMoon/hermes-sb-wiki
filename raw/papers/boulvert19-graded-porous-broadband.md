---
title: "Optimally graded porous material for broadband perfect absorption of sound"
authors: ["Jean Boulvert, Théo Cavalieri, Josué Costa-Baptista, Logan Schwan, Vicente Romero-García, Gwenael Gabard, Edith Roland Fotsing, Annie Ross, Jacky Mardjono, Jean-Philippe Groby"]
year: 2019
source: paper
journal: "HAL: hal-02366295 — J. Sound Vib. (2020)"
ingested: 2026-05-05
sha256: b2cbfabfac7a0d3c2d6ed82cf3a3f2daa72674f0168d47c56875f13a0fb87ff6
conversion: pymupdf4llm
---

**==> picture [242 x 136] intentionally omitted <==**

## **Optimally graded porous material for broadband perfect absorption of sound** 

Jean Boulvert, Théo Cavalieri, Josué Costa-Baptista, Logan Schwan, Vicente Romero-García, Gwenael Gabard, Edith Roland Fotsing, Annie Ross, Jacky Mardjono, Jean-Philippe Groby 

**==> picture [8 x 10] intentionally omitted <==**

## **To cite this version:** 

Jean Boulvert, Théo Cavalieri, Josué Costa-Baptista, Logan Schwan, Vicente Romero-García, et al.. Optimally graded porous material for broadband perfect absorption of sound. Journal of Applied Physics, 2019, 126 (17), pp.175101. ⟨10.1063/1.5119715⟩. ⟨hal-02366295⟩ 

## **HAL Id: hal-02366295 https://hal.science/hal-02366295v1** 

Submitted on 15 Nov 2019 

**HAL** is a multi-disciplinary open access archive for the deposit and dissemination of scientific research documents, whether they are published or not. The documents may come from teaching and research institutions in France or abroad, or from public or private research centers. 

L’archive ouverte pluridisciplinaire **HAL** , est destinée au dépôt et à la diffusion de documents scientifiques de niveau recherche, publiés ou non, émanant des établissements d’enseignement et de recherche français ou étrangers, des laboratoires publics ou privés. 

**==> picture [49 x 19] intentionally omitted <==**

HAL Authorization 

JAP19-AR-03524 

Optimally graded porous material for broadband perfect absorption of sound Jean Boulvert,[1, 2, 3,][ a)] Théo Cavalieri,[2, 3] Josué Costa-Baptista,[1] Logan Schwan,[2] Vicente Romero-García,[2] Gwénaël Gabard,[2] Edith Roland Fotsing,[1] Annie Ross,[1,][ b)] Jacky Mardjono,[3,][ c)] and Jean-Philippe Groby[2,][ d)] 

> 1) _Laboratoire d’Analyse Vibratoire et Acoustique, LAVA, Mechanical engineering, Polytechnique Montréal, Montréal, Québec, Canada_ 

> 2) _Laboratoire d’Acoustique de l’Université du Mans, LAUM - UMR CNRS 6613, Le Mans Université, Avenue Olivier Messiaen, 72085 Le Mans Cedex 9, France_ 

> 3) _Safran Aircraft Engines, Villaroche, Rond Point René Ravaud - Réau, 77550 Moisy-Cramayel Cedex, France_ 

(Dated: 17 September 2019) 

This article presents a numerical optimization procedure of continuous gradient porous layer properties to achieve perfect absorption under normal incidence. This design tool is applied on a graded porous medium composed of a periodic arrangement of ordered unit cells allowing to link the effective acoustic properties to its geometry. The best microgeometry continuous gradient providing the optimal acoustic reflection and/or transmission is designed via a nonlinear conjugate gradient algorithm. The acoustic performances of the so-designed continuous graded material are discussed with respect to the optimized homogeneous, i.e. non-graded, and monotonically graded material. The numerical results show a shifting of the perfect absorption peak to lower frequencies or a widening of the perfect absorption frequency range for graded materials when compared to uniform ones. The results are validated experimentally on 3D-printed samples therefore confirming the relevance of such gradient along with the efficiency of the control of the entire design process. 

> a)jean.boulvert@univ-lemans.fr; 

> b)annie.ross@polymtl.ca 

> c)jacky.mardjono@safrangroup.com 

> d)jean-philippe.groby@univ-lemans.fr 

1 

## **I. INTRODUCTION** 

Homogeneous open-cell porous materials are widely used as acoustic treatments. Their behavior is well described by propagation models and their efficiency to operate as broadband acoustic absorbers has been theoretically, numerically and experimentally shown for a long time. Nevertheless, they suffer from a lack of efficiency in the low frequency regime, because of their intrinsic loss mechanisms. Moreover, perfect absorption is usually achieved at a single frequency and the absorption curve presents ripples in frequency. Increasing homogeneous layer thickness is a common way to overcome this issue in order to absorb lower frequency noise. However, perfect absorption depends on the visco/inertial transition frequency[1] , therefore limiting the lowest possible perfect absorption frequency and the thickness of efficient treatments. In addition, thick and thus heavy treatments are unrealistic for many practical applications. Double-porosity media[2] , metasurfaces[3,4] and acoustic metamaterials[5] are nowadays considered as efficient ways to increase the low frequency attenuation/absorption. Another way consists in introducing a gradient of properties through the thickness. A correct design of such a gradient can enhance the layer absorption over a given frequency range[6–8] . The optimal gradient is commonly described as a monotonic increase of the air flow resistivity or decrease of the porosity of the structure through the thickness, leading to an expected continuous in frequency impedance matching at the air-porous interface. Actually, such gradient improves absorption in the mid and high-frequency ranges but not in the low frequency one. Moreover, non-monotonic gradient can lead to better performances[9] but are still misunderstood. 

Functionally graded materials are used in many other engineering fields, mainly in mechanics, and can be precisely manufactured with various techniques[10] . For instance Han _et al._ manufactured a continuously graded bone implant by selective laser melting[11] . Yet, conventional porous manufacturing processes allow to produce graded materials, e.g. graded foams[7] or felts[8] , but the control of the gradient is relatively low and therefore inaccurate for precise design. Moreover, large samples are often macroscopically inhomogeneous. No continuously graded porous acoustic treatments have yet been optimized and precisely manufactured to the author’s knowledge. Fortunately, recent improvements in additive manufacturing have allowed the production of efficient acoustic treatments such as helical metametarials[12,13] , slow-sound based metamaterials[6,14] and porous open-cells materials[15] . This technology enables an efficient control of the micro-structure 

2 

design, because the pore shapes and dimensions can be simply adjusted for the target macroscopic properties. Acoustic multilayer treatments have been manufactured by means of 3D printing such as an assembly of four layers composed of 1 mm thick micro-lattices[16] , a superposition of microperforated panels[17] or a micro-perforated panel backed by a conventional felt and plenum[18] as well as a superposition of two micro-lattices layers and a flexible membrane[19] . However, these acoustic treatments consist of a small fixed number of discrete layers and were not optimized. 

The aim of this article is to propose a numerical optimization procedure to design continuously graded porous acoustic materials achieving broadband perfect absorption at normal incidence. The graded properties can be directly linked to the micro-geometry or the manufacturing process of the treatment. As an example, the procedure is applied to a periodic 3D printable micro-lattice porous material, which micro-structure is easily tuned allowing a physical understanding of the gradient shape as well as to experimentally validate the whole process. The optimized gradients are compared to optimized homogeneous and optimized monotonic gradient layers in order to highlight the importance of such unconstrained gradient. This optimization procedure can also be applied to any stochastic treatments manufactured by conventional process. 

The gradient optimization method is widely inspired from Ref. [20], where the characterization problem of graded porous parameter profiles was tackled by means of a conjugate gradient algorithm and the prior knowledge of the sample reflection and transmission coefficients. The present work adapts the proposed methodology to reflection and/or transmission optimization. This work distinguishes from previous one by the optimization objective, the focus on tangible variables and the additive manufacturing proof of concept. It also differs from multilayer optimizations[6,8,21] where a finite number of layers is fixed before the optimization. The article is organized as follows: first the optimization procedure is introduced in Section II. The acoustic behavior of graded porous material is recalled and gradient optimization methods are detailed. Then, the optimized graded profiles and resulting absorption coefficients are presented and discussed in Section III. After a discussion of the optimizations, an experimental validation is carried out in Section IV. 

3 

## **II. OPTIMIZATION PROCEDURE** 

## **A. Description of the problem** 

The problem is depicted on Fig. 1. The porous layer is assumed of infinite lateral extent along the Cartesian **y** and **z** directions and is _L_ -thick in the **x** direction. The normal incident plane wave is invariant in the (O, **y** , **z** ) plane and propagates trough the positive **x** direction. The inhomogeneity of the layer occurs in the **x** direction. Thus, as the acoustic excitation is a normal plane wave, the problem only depends on the _x_ coordinate and so becomes unidimensional. The surrounding and saturating fluid is air and the porous layer can possibly be rigidly backed. The interfaces of the porous layer are flat and parallel and are designated respectively by Γ0 and Γ _L_ at _x_ = 0 and _x_ = _L_ . The air medium is denoted by the superscript _a_ . The two semi-infinite air domains are subsequently denoted by _a[i]_ and _a[t]_ to differentiate the upstream and downstream sides in the transmission case. 

The analysis is performed in the linear harmonic regime at the circular frequency _ω_ with the implicit time dependence _e_[i] _[ω][t]_ . The normal incident plane wave is expressed as _p[i]_ = _e[−]_[i] _[k][a][x]_ , such that the pressure field in _a[i]_ reads as _p[a][i]_ = _e[−]_[i] _[k][a][x]_ + _Re_[i] _[k][a][x]_ , wherein _k[a]_ is the incident wavenumber and _R_ is the reflection coefficient. If the layer is not rigidly backed, the transmitted wave takes the form _p[a][t]_ = _p[t]_ = _T e[−]_[i] _[k][a][x]_ , where _T_ is the transmission coefficient. 

**==> picture [18 x 97] intentionally omitted <==**

**==> picture [51 x 48] intentionally omitted <==**

**==> picture [74 x 70] intentionally omitted <==**

FIG. 1. x-graded porous slab. _p[i]_ is the incident wave, _p[r]_ is the reflected wave, and _p[t]_ is the transmitted wave. The incident wave is aligned with **x** . 

4 

## **B. Geometry driven equivalent fluid model** 

The porous medium is modeled as an equivalent fluid medium[1] . Its acoustic properties are governed by its micro-structure conditioned by the manufacturing possibilities. 

## _**1. Rigid frame and equivalent fluid approximations**_ 

The acoustic energy penetrating the porous medium is mainly dissipated through the interaction between the frame and the air saturating the pores, resulting in viscous and thermal losses. If the skeleton is sufficiently rigid, it can be assumed motionless. The porous medium can thus be considered as an equivalent fluid[1] . The considered equivalent fluid is isotropic but the theory can simply be extended to anisotropic ones. The viscous and thermal losses in the pores are respectively accounted for in the equivalent density _ρ_ ( _x, ω_ ) and in the equivalent bulk modulus _K_ ( _x, ω_ ). These quantities are complex, frequency and _x_ dependent in this study. They can be approximated by analytic, empirical or semi-phenomenological models[1] . The semi-phenomenological JohnsonChampoux-Allard-Lafarge (JCAL) model[22–24] is considered here and accounts for complicated pore morphologies by means of six parameters. According to this model, the equivalent density can be written as 

**==> picture [292 x 29] intentionally omitted <==**

where _ρ[a]_ is the density of the saturating fluid, i.e. the air medium in the present case, _φ_ ( _x_ ) the open porosity profile, and _α_ ( _x, ω_ ) the dynamic tortuosity profile. The equivalent bulk modulus can be written as 

**==> picture [321 x 32] intentionally omitted <==**

where _P_ 0 is the static pressure, _γ_ the specific heat ratio and _α[′]_ ( _x, ω_ ) the thermal tortuosity profile. The Johnson _et al._ model defines the dynamic tortuosity as[22] 

**==> picture [369 x 37] intentionally omitted <==**

where _ν_ = _η/ρ[a]_ is the kinematic viscosity of the saturating fluid, _η_ is the dynamic viscosity, and _α_ ∞( _x_ ), Λ( _x_ ) and _q_ 0( _x_ ) are the high frequency limit of the tortuosity, the viscous characteristic length and the viscous static permeability profiles of the porous medium, respectively. 

5 

The Champoux-Allard-Lafarge model further defines the thermal tortuosity as[23,24] 

**==> picture [354 x 37] intentionally omitted <==**

where _ν[′]_ = _ν/Pr_ , _Pr_ is the Prandtl number, and Λ _[′]_ ( _x_ ) and _q[′]_ 0[(] _[x]_[)][are][the][thermal][characteristic] length and the static thermal permeability profiles respectively. Therefore, a graded porous material along the thickness is that of thickness dependent porosity _φ_ ( _x_ ), high frequency limit of the tortuosity _α_ ∞( _x_ ), viscous characteristic length Λ( _x_ ) viscous static permeability _q_ 0( _x_ ), thermal characteristic length Λ _[′]_ ( _x_ ) and static thermal permeability _q[′]_ 0[(] _[x]_[)][.] 

## _**2. Equivalent fluid description: two-scale asymptotic method**_ 

When the micro-structure of the considered rigid frame material is known, the six JCAL parameters can be directly derived[25] and computed by means of Finite Element Method (FEM)[26] . The two-scale asymptotic method can be applied to periodic or stochastic media, providing a representative elementary volume (REV) which dimensions are largely smaller than the acoustic wavelength. The REV of heterogeneous media must contain a large number of heterogenities to be representative of the heterogeneity. If the medium is periodic, the REV reduces to the unit cell corresponding to the periodic unitary pattern. In case of graded media, it also requires that the characteristic size of the REV is much smaller than the geometric variation, so that the assumption of local periodicity of both material and fields still holds[25] . The method consists in the application of a two-scale asymptotic homogenization to governing fundamental equations. The JCAL parameters are then calculated by integrating the computed fields. This method is detailed in Appendix A for anisotropic media. Such numerical description of the optimized porous medium suits well to the understanding of the graded profiles because it focuses on the micro-geometry. Therefore, a graded porous material through the thickness is that of thickness dependent micro-geometry. 

## _**3. Geometry driven parameters and data-basis generation**_ 

The six JCAL parameters are computed for a discrete set of variables defining the porous medium architecture. 

6 

When the medium can be numerically described, the variables defining the porous medium architecture are purely geometric (pore size, pore shape...) and the material can be digitally manufactured. In other words, the JCAL parameters dependence is numerically obtained from a parametric representative elementary volume. 

In contrast, when the porous material is manufactured by a technique that does not give access to a precise micro-structure description, the variables defining the porous medium architecture are those of the manufacturing process (compaction rate for felts, filling factor for additive manufacturing...). Then, the JCAL data basis can be generated from experimental direct[1,27] or inverse[28] characterization of several homogeneous samples. 

To sum up, the acoustic behavior of a porous medium is driven by its micro-structure. If a precise description of the latter is within easy reach, the JCAL dependence on the micro-structure is digitally computed by means of two-scale asymptotic method and FEM. On the contrary, if a precise description is out of reach, the JCAL dependence is computed by experimental inverse characterization. 

In any case, the JCAL parameters are computed for a discrete set of micro-structural or manufacturing variables defining the porous medium architecture. Each JCAL parameter dependence is then obtained by interpolating a continuous and smooth function from the discrete set of computed values, thus forming a data-basis for the optimization procedure. 

The variables defining the microstructure of the porous medium will be the subject of the gradient optimization. 

## **C. Acoustic waves propagation in graded porous material** 

Once the JCAL parameters are linked to the architecture variables, the acoustic behavior of the graded material can be evaluated. For clarity of the presentation, the ( _x, ω_ ) dependence of _ρ_ and _K_ are dropped in the following. 

7 

## _**1. Equations of macroscopically inhomogeneous porous material under the rigid frame approximation**_ 

Using the alternative Biot’s formulation[29] , De Ryck _et al._ derived the equations of motion in a macroscopically inhomogeneous porous material under the rigid frame approximation[30] . Under normal incidence they take the usual form in the frequency domain: 

**==> picture [270 x 27] intentionally omitted <==**

**==> picture [269 x 26] intentionally omitted <==**

where _p_ is the fluid pressure in the material pores and _V_ the normal equivalent velocity component for the oscillatory fluid flow in the interconnected pores. In the general case, the medium is considered anisotropic, as shown in Appendix A, with _ρ_ being a tensor and _K_ a scalar. Here, the focus is put on the properties of the system along the normal incidence direction. 

## _**2. State vector formalism**_ 

The problem being unidimensional, Eqs. (5, 6) can be directly cast in a first order differential matrix system from: 

**==> picture [282 x 26] intentionally omitted <==**

wherein **W** is the column state vector ( _p,V_ )[⊺] and 

**==> picture [297 x 51] intentionally omitted <==**

Eq. (7) can be directly solved via Peano Baker series[31] . Nevertheless, the Transfer Green Functions formalism is preferred because it directly provides the analytical gradient of the cost function that will be used in the optimization procedure. 

## _**3. Wave Splitting and Transfer Green Functions formalism**_ 

The pressure and velocity fields can be decomposed in a forward, _p_[+] , and a backward propagating waves, _p[−]_ . By analogy with electromagnetism, where the medium is surrounded by vacuum, 

8 

a "vacuum wave splitting" formulation is employed[30] . The pressure field is expressed in the surrounding fluid, i.e. in the air, and reads 

**==> picture [280 x 25] intentionally omitted <==**

wherein _Z[a]_ is the impedance of the air. This transformation is used to solve the problem, because ( _p,V_ )[⊺] = ( _p_[[] _[a]_[]] _,V_[[] _[a]_[]] )[⊺] at the interface Γ0 (see Fig. 1). Eq. (7) becomes: 

**==> picture [468 x 83] intentionally omitted <==**

The two transfer Green’s Functions, _G_[+] and _G[−]_ , are now defined as follows: 

**==> picture [287 x 15] intentionally omitted <==**

By introducing Eq. (11) in Eq. (10), the first order differential system to solve now reads as: 

**==> picture [335 x 45] intentionally omitted <==**

These two transmission Green’s functions are related to the space dependent reflection _R_ ( _x_ ) = _p[−]_ ( _x_ ) _/p_[+] ( _x_ ) and transmission _T_ ( _x_ ) = _p_[+] ( _L_[+] ) _/p_[+] ( _x_ ) coefficients along the layer thickness via 

**==> picture [271 x 29] intentionally omitted <==**

**==> picture [271 x 29] intentionally omitted <==**

The reflection and transmission coefficients of the whole porous layer are thus _R_ = _R_ (0) and the transmission coefficient is _T_ = _T_ (0). The solution of Eq. (12) is found by integrating from _x_ = _L_ where the boundary conditions are known, to _x_ = 0 using an iterative method such as the fourth order Runge-Kutta scheme. 

When the porous layer is surrounded by air, the boundary conditions at _x_ = _L_ are _R_ ( _L_ ) = 0 and _T_ ( _L_ ) = 1, which translates in the form: 

**==> picture [271 x 44] intentionally omitted <==**

9 

In the opposite, when the porous layer is rigidly backed at _x_ = _L_ , the only boundary condition is _R_ ( _L_ ) = 1, which translates in the form: 

**==> picture [263 x 30] intentionally omitted <==**

## **D. Unconstrained gradient optimization: Nonlinear conjugate gradient algorithm** 

The objective of the gradient optimization is to bring the reflection and/or transmission coefficients of the porous layer as close as possible to objective values by tuning a micro-structure or manufacturing parameters. The cost function _J_ to be minimized reads as: 

**==> picture [349 x 44] intentionally omitted <==**

where _Rob j_ ( _ω_ ) and _Tobj_ ( _ω_ ) are the objective reflection and transmission coefficients, _W_ ( _ω_ ) is a frequency weighting function used to favor targeted frequency ranges, and vector **q** ( _x_ ) is the micro-structure or manufacturing parameters profiles varying along the layer thickness _x_ = [0; _L_ ] and being the subject of the optimization. The goal can be to mimic the reference behavior, e.g. inverse characterization, or to optimize the absorption of the graded porous layer, e.g. when _Rob j_ ( _ω_ ) and _Tobj_ ( _ω_ ) are set to zero. 

In this study, the absorption coefficient _A_ = 1 _−|R|_[2] of rigidly backed layer is maximized. The maximum absorption coefficient is 1 which means that perfect absorption is achieved. The objective reflection coefficient is thus zero, while no transmission is present. The optimization algorithm is detailed for the generic case. 

The nonlinear conjugate gradient method[32] is a generalization of the conjugate gradient method[33] , that can minimize any continuous function as long as the gradient of which can be computed. The convergence to the global minimum is not ensured if the minimized function possesses local minima. This iterative algorithm steps are reminded in Appendix B. It consists in computing a search direction that will be added multiple times to minimized function. If there is an analytic expression of the JCAL parameters variation with respect to the graded optimized parameter, then the search direction also has an analytic form. 

10 

## **E. Constraint to be monotonic gradient optimization** 

As detailed in the Introduction, it is of interest to compare the absorption of an optimally graded porous layer to the one of an optimally graded layer which porosity or permeability is decreasing through the material thickness. Thus, a constraint gradient optimization algorithm is proposed. Its aim is to minimize the cost function defined by Eq. (17) by tuning a monotonically varying manufacturing or micro-geometric gradient. For more clarity, only one parameter _q_ is optimized by this algorithm. The profile of _q_ ( _x_ ) is obtained by interpolating a continuous function from a discrete set of _N_ equally spaced points _qn_ = _q_ ( _xn_ ) where _x_ 0 = 0 and _xN_ = _L_ . A Shape-Preserving Piecewise Cubic Interpolation (Matlab, _pchip_ ) is used. The interpolated function is _C_[1] (its first derivative exists and is continuous), and respects the shape of the data. In this way, if _qn_ +1 _< qn ∀n ∈_ [0 _, N_ ], then _q_ ( _x_ ) is monotonically decreasing. The values of _qn_ are optimized by means of a Nelder-Mead algorithm minimizing the cost function _J_ and satisfying the condition _qn_ +1 _< qn ∀n ∈_ [0 _, N_ ]. 

## **III. NUMERCIAL RESULTS** 

The reflection coefficient possesses pairs of poles/zeros, the location of the which in the complex frequency plane _f_[˜] = Re( _f_[˜] ) + i Im( _f_[˜] )[14,34] represents the system modes and their associated leakages. In the absence of losses, the zeros and poles are perfectly symmetric with respect to the real frequency axis. Both are shifted towards the negative imaginary frequency half-space when losses are added according to the chosen time Fourier convention. Perfect absorption, i.e. _A_ = 1 _−|R|_[2] = 1, is achieved when the added losses perfectly compensates the leakage of the structure, leading to the critical coupling condition. In this respect, 20log( _|R_ ( _f_[˜] ) _|_ ) is also plotted in the complex frequency plane to complement the analysis of the absorption coefficient. In the following, the _n_[th] zero of the reflection coefficient corresponding to the _n_[th] maximum of the absorption coefficient is noted _fn−_ 1. The so-called fundamental quarter-wavelength resonance is thus _f_ 0. 

11 

## **A. Considered periodic porous medium: micro-lattice porous medium** 

As an example, the optimization procedure is applied to the idealized micro-lattice graded porous layer depicted in Fig. 2. The micro-lattice is composed of a superposition of perfectly cylindrical parallel rods orthogonally alternating in the plane ( _O,_ **y1** _,_ **z1** ). Thus, the medium is structured and periodic. Then, the REV reduces to the unit-cell consisting of the junction of two orthogonal rods as highlighted in Fig. 2. The unit cell is described by two micro-structural parameters: the rod diameter _D_ , that also fixes the unit-cell thickness, and the spacing between two adjacent rods. Other equivalent parameters are the rod diameter _D_ and the dimensionless rod step _S_ . The latter is the spacing between two adjacent rods normalized by the rod diameter, e.g. a step _S_ = 1 implies the rods are in contact and a step _S_ = 2 implies the two rods centers are distant from 2 _D_ . The pore size _H_ is defined here as the minimum distance between two adjacent rods. It is a function of _S_ and _D_ and is expressed as 

**==> picture [269 x 13] intentionally omitted <==**

All the JCAL parameters of the unit cell depend on _S_ while the characteristic lengths and permeabilities also depend on _D_ . For a given _S_ , the characteristic lengths are proportional to _D_ and the permeabilities are proportional to _D_[2] (see Appendix A). The porosity has a remarkably simple expression which is 

**==> picture [274 x 13] intentionally omitted <==**

The minimum porosity is equal to _≈_ 0 _._ 21 when the rods are touching each other. 

This material would be described as "quasi-isotropic" in composite science, because its inplane properties are identical but different from the out-of-plane ones. Therefore, the micro-lattice material is anisotropic and its properties in the principal directions can be evaluated following the method described in Ref. [35]. Nevertheless, the material principal directions fit the layer axes and rods are aligned in the plane of the layer. Only the out-of-plane properties are then considered in the present article, because of the normal incidence excitation. The analysis of the anisotropic features of the present micro-lattice graded layer is out of the scope of the present article. The layer is thus considered isotropic in the following. 

The micro-structure gradients are derived from a through-the-thickness variation of _S_ , _D_ or 

12 

**==> picture [197 x 154] intentionally omitted <==**

FIG. 2. Diagram of the porous material micro-structure. The box delimits a unit cell. The main axis of the porous material ( _O,_ **x1** ) is aligned with the axis of the slab ( _O,_ **x** ). The acoustic wave propagates along **x** = **x1** . 

both. The rod diameter _D_ is bounded between _Dmin_ = 100 _µ_ m and _Dmax_ = 1000 _µ_ m. The dimensionless rod step _S_ is bounded between _Smin_ = 1 _._ 2 and _Smax_ = 25. The porosity is then bounded between _φmin_ = 0 _._ 35 and _φmax_ = 0 _._ 97 while the pore size is bounded between 20 _µ_ m and 24 mm. 

## **B. Numerical settings** 

Both unconstrained and constraint to be monotonic gradient optimizations are numerically implemented. Continuous functions must be discretized. The micro-geometric profiles are defined by 100 points. The considered graded layers are 30 mm thick leading to a discretization step of 300 _µ_ m. Concerning the conjugate gradient, the number of iterations is set to 20 and the number of iterations of the line search is set to 15. These settings are found to be a good balance between computation time and convergence. The frequencies of interest are linearly spaced. The frequency weighting function _W_ is a pass-band function, its lower boundary _Wlb_ and higher boundary _Whb_ depend on the optimization case. W is equal to 1 in the interval 2 _π ×_ [ _Wlb,Whb_ ] and 0 elsewhere while 0 _< Wlb < Whb_ . 

## **C. Homogeneous material acoustic behavior** 

Before investigating the optimal graded micro-lattice acoustic behavior, the one of an homogeneous micro-lattice is first analyzed. Rod diameter _D_ and rod step _S_ are constant along the 

13 

**==> picture [220 x 182] intentionally omitted <==**

**----- Start of picture text -----**<br>
Frequency (Hz)<br>0 2400 5000 10000 15000 20000<br>1<br>0.8<br>0.6<br>0.4<br>0.2 D = 400 µm, S = 1.44, H = 176 µm, = 0.45, q0 = 9.2e [−10] m²<br>D = 100 µm, S = 2.75, H = 175 µm , = 0.71, q0 = 8.2e [−10] m²<br>0<br>1000<br>−50 0 30<br>500<br>0<br>−500<br>−1000<br>Absorption coefficient<br>Imaginary Frequency (Hz)<br>**----- End of picture text -----**<br>


FIG. 3. (color online) (a) Hard-backed absorption coefficients of a 30 mm thick homogeneous porous layers: 100 _µ_ m rod diameter (solid line) and 400 _µ_ m rod diameter (dashed line), both structures critically coupled at _f_ 0. (b) Representation of 20log( _|R|_ ) in the complex frequency plane of 30 mm thick porous slab, 100 _µ_ m rod diameter. 

thickness of homogeneous material. Fig. 3(a) shows the absorption coefficient of two optimized 30 mm-thick homogeneous micro-lattice porous layers with the rod diameter of _D_ = 100 _µ_ m and _D_ = 400 _µ_ m, respectively. Both layers are critically coupled at their respective fundamental quarter-wavelength frequencies. Absorption peaks are wider in the case of 100 _µ_ m than in the case of 400 _µ_ m rod diameter, while _f_ 0 is slightly higher. 

Cai _et al._[36] suggested that, for an open porosity material having circular pores, the perfect absorption is obtained when the pore radius equals the viscous boundary layer thickness. The latter is linked to the visco/interial transition frequency, for highly porous materials, as also noted by Jimenez _et al._[6] . In our case, the porosity is usually low ( _φ <_ 0 _._ 9) and the perfect absorption is achieved for a pore size _H_ for any rod diameter, see Fig. 3(a). 

Moreover, the viscous permeability decreases with the pore step _S_ (governing _φ_ and _H_ , see Eqs. (18, 19)) and increases with the rod diameter _D_ (governing _H_ , see Eq. (18)). The lower the pore step _S_ is and the lower the rod diameter _D_ is, the lower the viscous permeability is. In other words, both decreasing the pore step and the rod diameter increases the resistivity (∝ 1 _/q_ 0). When perfect absorption must be attained at _f_ 0, an higher rod diameter is compensated by a lower rod 

14 

step keeping the pore size constant but strongly lowering the porosity and slightly increasing the viscous permeability. The visco/inertial transition frequency of the material is decreased. Similarly, decreasing the rod diameter while keeping perfect absorption at _f_ 0 shifts up the position of the poles in the absence of loss, thus decreasing the associated quality factor. Thus, the perfect absorption peaks are wider, but higher in frequency when the rod diameter is small and the rod step is optimized, as shown in Fig. 3(a). The reflection coefficient in case of 100 _µ_ m rod diameter is plotted in the complex frequency plane Fig. 3(b). At _f_ 0, the zero of the reflection coefficient is exactly located on the real frequency axis, confirming the perfect absorption. For this sample, only one zero can be located on the real frequency axis at a time, i.e. perfect absorption can only be achieved at a single frequency. The losses of the following zeros are too large. 

The 30 mm thick homogeneous layer, with a rod diameter of 100 _µ_ m (Fig. 3), is taken as a reference. The perfect absorption peak frequency appears at _f_ 0 _[re f]_ = 2400 Hz. Three designs are described in the following sections corresponding to three different goals: lowering _f_ 0, enhancement in the mid-frequency range of the absorption, and the broadband absorption for the same layer thickness. 

## **D. First perfect absorption frequency lowering** 

The goal of this optimization is to lower the frequency of perfect absorption _f_ 0 without changing the layer thickness, i.e. _L_ = 30 mm by introducing a gradient of _D_ ( _x_ ) and _S_ ( _x_ ). Achieving perfect absorption at lower frequency for the same dimension is of particular interest because this is impossible with an homogeneous porous material and because of increasing space constraints in practical applications. Subsequently, a set of _Wlb_ and _Whb_ is chosen in such way that _f_ 0 is as small as possible and _A_ ( _f_ 0) _>_ 0 _._ 995. 

On the one hand, the monotonically decreasing gradient of _S_ (and thus of _φ_ and _H_ ) or of _D_ (and thus of _H_ ) do not allow to reduce _f_ 0 with respect to _f_ 0 _[re f]_ . On the other hand, the lowest _f_ 0 presenting perfect absorption that we could obtain by means of _W_ ( _ω_ ) = 2 _π_ [1300 _,_ 1700] Hz with an unconstrained graded layer is 1630 Hz. Figure 4(a) depicts the absorption coefficient of the reference 30 mm-thick homogeneous micro-lattice porous layer, of the optimized unconstrained graded porous layer of the identical thickness and of an optimized 43.5 mm-thick homogeneous 

15 

**==> picture [242 x 340] intentionally omitted <==**

**----- Start of picture text -----**<br>
Frequency (Hz)<br>0 1630 2400 5000 10000<br>1<br>0.8<br>0.6<br>0.4<br>Homogeneous, L = 30 mm<br>0.2 Homogeneous, L = 43.5 mm<br>Unconstrained gradient, L = 30 mm<br>0<br>1000<br>500<br>0<br>−500 −50 0 30<br>−1000<br>1000<br>4.7<br>4.2<br>750<br>3.7<br>3.2<br>500<br>Homogeneous, Rod step 2.7<br>Homogeneous, Rod diameter 2.2<br>250 Unconstrained gradient, Rod step 1.7<br>Unconstrained gradient, Rod diameter<br>100 1.2<br>0 5 10 15 20 25 30<br>Thickness (mm)<br>Absorption coefficient<br>Imaginary Frequency (Hz)<br>Rod step<br>Rod diameter (µm)<br>**----- End of picture text -----**<br>


FIG. 4. (color online) (a) Hard-backed absorption coefficients of optimized homogeneous 100 _µ_ m rod diameter 30 mm thick slab (solid line), homogeneous 100 _µ_ m rod diameter 43 _._ 5 mm thick slab (dot-dashed line), and of graded 30 mm thick slab (dashed line). (b) Representation of 20log( _|R|_ ) in the complex frequency plane of free gradient optimized, 30 mm thick porous slab, 100 _µ_ m rod diameter. (c) Homogeneous (solid lines) and free gradient optimized (dashed lines) profiles of rod diameter (blue) and rod step (green) reducing _f_ 0. _W_ ( _ω_ ) = 2 _π_ [1300;1700] Hz. 

layer possessing perfect absorption at _f_ 0 =1630 Hz. The unconstrained optimized profiles of _D_ ( _x_ ) and _S_ ( _x_ ) are provided Fig. 4(c). The thickness of the graded layer equals _λ /_ 7 _._ 1 at _f_ 0, where _λ_ is the corresponding wavelength in air. Other frequency weighting functions can lead to very similar results. The absorption peak appears at a much lower frequency, but the peak is thinner and the average absorption at high frequency is degraded. Nevertheless, this result should be mitigated at first glance by the fact that the optimization algorithm has no control outside [ _Wlb,Whb_ ]. This is testified by the complex frequency analysis of the corresponding reflection coefficient plotted in Fig. 4(b). 

16 

The optimized profiles depicted in Fig. 4(c) present a very low rod step zone manifested at the air-layer interface and a high rod step close to the rigid backing. The high rod diameter at the air-layer interface tempers the effect of very low rod step on the pore size, see Eqs. (18, 19), and thus allows a low porosity while preventing the viscous permeability from falling. A continuous transition between both profiles is noticed. In other words, the optimal profile consists in a very low porosity and medium pore size layer with a plenum, enabling to control the resonance frequency of the layer. Inside the low porosity zone, _S_ ( _x_ ) = _Smin_ = 1 _._ 2, i.e. _φ_ ( _x_ ) = _φmin_ = 0 _._ 34 and _H_ ( _x_ ) _≈_ 180 _µ_ m while inside the permeable zone, _D_ ( _x_ ) = _Dmin_ =100 _µ_ m, _φ_ ( _x_ ) _∈_ [0.72; 0.82] and _H_ ( _x_ ) _∈_ [180;350] _µ_ m. The optimization bounds are thus reached and it would be expected to reach lower _f_ 0 by enlarging the variation ranges, therefore increasing the porosity drop between the two zones. 

## **E. Medium frequencies optimization** 

This optimization aims at increasing the absorption coefficient between the first ( _f_ 0) and second ( _f_ 1) absorption maxima while keeping _f_ 0 as low as possible. These two objectives being contradictory, _W_ ( _ω_ ) = 2 _π_ [2000 _,_ 3200] Hz leads to good balance. 

The monotonically decreasing gradient of S, with rod diameter set to 100 _µ_ m, improves the absorption over the frequency range of interest by shifting _f_ 0 up to 2600 Hz and downshifting _f_ 1, while widening the absorption peaks, as shown in Fig. 5(a). Perfect absorption is achieved at _f_ 0. The optimized rod step profile is presented in Fig. 5(c). The rod step decreases monotonically, but with small variation. For an easier comparison, only the rod step profile is optimized in case of the unconstrained gradient, the rod diameter being set to 100 _µ_ m. The effect of the free gradient is more pronounced than that of constraint gradient: _f_ 0 is still equal to 2600 Hz while _f_ 1 is shifted down, as depicted in Fig. 5(a). The absorption peak widths are fairly similar to the monotonic gradient optimized ones, see Fig. 5(a). As a result, absorption between _f_ 0 and _f_ 1 is higher than the absorption with monotonic gradient optimization. The corresponding optimized profile is a succession of relatively closely grouped and distant rods. The variation of rod step is greatly inferior than the one presented in Fig. 4(c). Still, it enables the control of the frequency of the first two quarter-wavelength resonances. A combined variation of the rod diameter and rod step further increases the absorption. The rod step profile is very similar to one presented in Fig. 5(c). The 

17 

**==> picture [242 x 338] intentionally omitted <==**

**----- Start of picture text -----**<br>
Frequency (Hz)<br>0 2400 5000 10000 15000 20000<br>1,0<br>0,8 10 2400 5000 10000 15000 20000<br>0,6 0.95<br>0,4 0.9<br>0,2 0.85<br>Homogeneous<br>Monotonic gradient Unconstrained gradient<br>0<br>1000<br>500<br>0<br>−500 −50 0 30<br>−1000<br>4.7 Homogeneous<br>4.2 Monotonic gradient<br>3.7 Unconstrained gradient<br>3.2<br>2.7<br>2.2<br>1.7<br>1.2<br>0 5 10 15 20 25 30<br>Thickness (mm)<br>Absorption coefficient<br>Imaginary Frequency (Hz)<br>Rod step<br>**----- End of picture text -----**<br>


FIG. 5. (color online) (a) Hard-backed absorption coefficients of optimized 30 mm thick slabs, 100 _µ_ m rod diameter with homogeneous rod step (solid line), monotonically graded rod step (doted line) and free graded rod step (dash-doted line). (b) Representation of 20log( _|R|_ ) in the complex frequency plane of 30 mm thick, 100 _µ_ m rod diameter, free graded rod step, porous slab. (c) Optimized graded profiles of rod step: monotonic (dash-doted line) and free gradient (dashed line), _D_ = 100 _µ_ m. _W_ ( _ω_ ) = 2 _π_ [2000;3200] Hz. 

diameter profile follows an inverse trend than the rod step: rod diameter is high when rod step is low and vice versa. This two-parameter gradient shifts _f_ 1 to a lower frequency. 

## **F. High frequencies optimization** 

Now the maximization of the absorption coefficient over the [3000;20000] Hz frequency range is analyzed. The choice of _W_ ( _ω_ ) = 2 _π_ [3000;20000] Hz allows to keep a perfect absorption at _f_ 0. The absorption coefficient of the monotonic rod step gradient layer is higher than 0.99 between 3600 Hz and 30000 Hz and also almost higher than 0.997 over the whole optimized frequency 

18 

range as shown in Fig. 6(a). The four absorption peaks appearing at _fn_ , _n_ = 0 _,...,_ 3, are shifted up in comparison to _fn[ref]_ and gathered between 3000 and 20000 Hz. Moreover, an absorption drop to 0.993 is observed between _f_ 0 and _f_ 1. The rod step bell-mouth shape profile, see Fig. 6(c), begins by the maximum authorized value _Smax_ . The resulting porosity profile is almost linearly decreasing. In other words, the profile presents an impedance matching. Similarly to the previous section, only the rod step profile is optimized in case of the unconstrained gradient and the rod diameter is again fixed at 100 _µ_ m. The absorption coefficient is depicted Fig. 6(a). It is higher than 0.99 between 3600 and 20000 Hz and higher than 0.997 between 3900 and 19500 Hz. This improvement is possible by gathering five absorption maxima between _Wlb_ and _Whb_ , as can be seen from the complex frequency analysis of the reflection coefficient depicted in Fig. 6(b). Homogeneous and graded materials with monotonically decreasing rod step only gather four absorption maxima. Furthermore, the absorption drops after _Whb_ is explained by the downwards shifting of _f_ 5. The rod step profile, Fig. 6(c), consists of 5 alternating relatively closely grouped and distant rods, enabling to gather 5 modes and therefore 5 zeros of the reflection coefficient in the optimization frequency range. The ripples are almost removed and the absorption coefficient is almost flat over the whole frequency range of optimization. 

## **IV. INTERPRETATION** 

Regardless of the optimization frequency range, an optimized unconstrained through the thickness gradient enhances the absorption properties of the material in comparison to the optimized homogeneous layer or optimized monotonic graded layer with identical thickness. Nevertheless, the previous results require comments. First, the downshifting of the first perfect absorption peak with identical thickness is necessarily accompanied by a decrease of the absorption efficiency at higher frequencies. Second, the enhancement of the absorption coefficient over a specific frequency range is always achieved at the expenses of the absorption properties outside this range. Third, broadband perfect absorption is possible if the first perfect absorption peak frequency is higher than that of the homogeneous layer. Fourth, the optimal profile is an alternating distribution of relatively closely grouped and distant rods rather than a monotonic gradient. It leads to an alternating distribution of contrasted porosity layers. This counterintuitive result is explained by the fact that the alternation enables the creation and a better control of resonances. At lower frequencies, a resonance possesses a large quality factor, thus providing thin absorption peak. A low 

19 

**==> picture [201 x 287] intentionally omitted <==**

**----- Start of picture text -----**<br>
Frequency (Hz)<br>0 2400 5000 10000 15000 20000 25000 30000<br>1<br>0.8 10 2400 5000 10000 15000 20000 25000 30000<br>0.6 0.998<br>0.996<br>0.4<br>0.994<br>0.2 0.992<br>Homogeneous<br>Monotonic gradient Unconstrained gradient<br>0<br>1000<br>500<br>0<br>−500 −50 0 30<br>−1000<br>25 4.7<br>4<br>21.2<br>2.7<br>16.2<br>11.2 1.20 5 10 15 20 25 30<br>Homogeneous<br>6.2 Monotonic gradient<br>Unconstrained gradient<br>1.2<br>0 5 10 15 20 25 30<br>Thickness (mm)<br>Absorption coefficient<br>Imaginary Frequency (Hz)<br>Rod step<br>**----- End of picture text -----**<br>


FIG. 6. (color online) (a)Hard-backed absorption coefficients of optimized 30 mm thick slabs, 100 _µ_ m rod diameter with homogeneous rod step (solid line), monotonically graded rod step (doted line) and free graded rod step (dashed line). (b) Representation of 20log( _|R|_ ) in the complex frequency plane of 30 mm thick, 100 _µ_ m rod diameter, free graded rod step, porous slab. (c) Optimized graded profiles of rod step: monotonic (dash-doted line) and free gradient (dashed line), _D_ = 100 _µ_ m. _W_ ( _ω_ ) = 2 _π_ [3000;20000] Hz. 

porosity - medium pore size layer placed in front of a plenum only possesses a single resonance at low frequency. For broadband absorption, the alternation leads to an increase of the density of states over the optimization frequency range, creating a larger number of reflection coefficient zeros located in the targeted frequency range. The absorption coefficient can therefore be almost flat over a wide frequency range. Nevertheless, this result might be tempered by the fact that the tuning of these modes are constrained by the thickness of the layer thus preventing a full control of their frequency position. 

## **V. EXPERIMENTAL VALIDATION** 

The optimization process is experimentally validated on samples fabricated by Fused Deposition Modeling (FDM) Pro2 printer supplied by RAISE3D. The slicer software is Simplify3D. The 

20 

cylindrical samples have a diameter and a thickness of 30 mm as depicted in Fig. 7. The extruded material is polylactic acid (PLA). The printer’s nozzle is 400 _µ_ m in diameter. The targeted geometry is similar to the one described in Fig. 7. However, the orthogonal rods layers are interlocked: the distance separating two layers oriented in the same direction is 1 _._ 5 _D_ instead of 2 _D_ . Moreover the rods are not perfectly cylindrical and their surface is scarred. Their diameter is close to the nozzle diameter. FDM and Simplify3D do not allow a direct control of the micro-lattice rods spacing. The manufacturing variable is the "infill factor" percentage which is inversely proportional to the spacing between two adjacent rods and can only take integer values. In this way, a graded manufacturing variable is optimized. The gradient is obtained by tuning the infill factor varying between 10 and 70 % which corresponds to a porosity of 0.90 and 0.33 respectively. A combined variation of the rod diameter and spacing would require a multi-nozzles printer or using another manufacturing process. Finally, a 800 _µ_ m thick solid layer surrounds the porous micro-lattice. Its effect is accounted for by multiplying the density and bulk modulus of the equivalent fluid by the surface of the sample divided by the surface of its porous portion[1] . The acoustic parameters are measured using a 30 mm diameter impedance tube, with a cut-off frequency of 6750 Hz. The absorption coefficient is measured using the two microphones with hard backing configuration. The measurements are preformed between 500 Hz and 6000 Hz. Because of the printing inherent defects, the JCAL parameters dependence on the infill factor were obtained by inverse characterization of a set of eight homogeneous samples followed by an interpolation over the infill factor scope[37] . The JCAL parameters of the characterized samples along with their interpolation (infill factor _∈_ [10;70]%), are presented in Appendix C. 

A continuous gradient, where each layer would have a different infill factor cannot be manufactured straightforwardly. Instead, a 10-layer material was printed. This number of layers is more than sufficient to accurately discretize the continuous profile. The optimized continuous profile was thus discretized in 10 layers of identical thickness. First, the infill factor of each layer equaled the mean infill factor of the continuous profile within the layer width. Then, a NelderMead algorithm adjusted the infill factor of each layer. To do so, the algorithm minimized the cost function given by Eq. (17) where _R_ ( _ω_ ) is the multilayer reflection coefficient and _Rob j_ ( _ω_ ) is the continuous profile reflection coefficient, both of them numerically computed. 

Two optimizations are carried out by the unconstrained gradient algorithm. The first one con- 

21 

**==> picture [228 x 231] intentionally omitted <==**

**----- Start of picture text -----**<br>
D30 mm<br>a) b)<br>c) d)<br>30 mm<br>**----- End of picture text -----**<br>


FIG. 7. (a), (b) Homogeneous samples. (c) Graded sample top view. (d) Graded sample bottom view. 

**==> picture [242 x 251] intentionally omitted <==**

**----- Start of picture text -----**<br>
Continuous, front Continuous, back<br>1<br>MultiLayer, front MultiLayer, back<br>Measure, front Measure, back<br>Measure, homogeneous<br>0.8<br>0.6<br>0.4<br>0.2<br>0<br>1000 2000 3000 4000 5000 6000<br>Frequency (Hz)<br>1<br>0.8<br>Homogeneous<br>Continuous<br>0.6<br>Multilayer<br>0.4<br>0.2<br>0 5 10 15 20 25 30<br>Thickness (mm)<br>Absorption coefficient<br>Porosity<br>**----- End of picture text -----**<br>


FIG. 8. (color online) (a) Rigid-backing absorption coefficients of optimized manufactured 30 mm thick slabs, numerically computed from the continuous profile (green lines), from the multilayered profile (blue lines), and measured (red lines), in direct (solid lines) and reverse (dashed lines) orientations. (b) Porosity profiles resulting from the infill factor profiles optimized by unconstrained gradient, continuous (green line) and discretized in ten layers (blue line). _W_ = [1600;1700] Hz. 

22 

**==> picture [242 x 238] intentionally omitted <==**

**----- Start of picture text -----**<br>
1<br>0.8<br>0.6<br>0.4<br>Continuous, front Continuous, back<br>0.2 MultiLayer, front MultiLayer, back<br>Measure, front Measure, back<br>Measure, homogeneous<br>0<br>1000 2000 3000 4000 5000 6000<br>Frequency (Hz)<br>1<br>Homogeneous<br>0.8 Continuous<br>Multilayer<br>0.6<br>0.4<br>0.2<br>0 5 10 15 20 25 30<br>Thickness (mm)<br>Absorption coefficient<br>Porosity<br>**----- End of picture text -----**<br>


FIG. 9. (color online) (a) Rigid-backing absorption coefficients of optimized manufactured 30 mm thick slabs, numerically computed from the continuous profile (green lines), from the multilayered profile (blue lines), and measured (red lines), in direct (solid lines) and reverse (dashed lines) orientations. (b) Porosity profiles resulting from the infill factor profiles optimized by unconstrained gradient, continuous (green line) and discretized in ten layers (blue line). _W_ = [2500;5500] Hz. 

siders _W_ ( _ω_ ) = 2 _π_ [1600;1700] Hz in order to reduce _f_ 0 with respect to _f_ 0 _[re f]_ . The second one considers _W_ ( _ω_ ) = 2 _π_ [2500;5500] Hz so that the absorption is higher between _f_ 0 _[re f]_ and _f_ 1 _[re f]_ . Figures 8(a) and 9(a) depict the absorption coefficient of the homogeneous materials, critically coupled at _f_ 0 _[ref]_ (TR = 55%, i.e. _φ_ = 0.47) along with the simulated and measured absorption coefficient, in both orientations, of the optimized graded materials. Figures 8(b) and 9(b) provide the corresponding continuous porosity profiles resulting from the continuously optimized infill factor profiles and their discretizations. The absorption coefficients are optimized considering the "front" orientation which corresponds to an incident wave propagating through the porosity profile from left (Thickness = 0 mm) to right (Thickness = 30 mm). The absorption coefficients are also presented considering the "back" orientation. In this configuration, the incident wave propagates from Thickness = 30 mm to Thickness = 0 mm. 

For both optimizations, the continuous and multilayerd profiles lead to numerically very close 

23 

absorption coefficients, in both orientations, meaning that the discretization procedure is efficient. The _W_ ( _ω_ ) = 2 _π_ [1600;1700] Hz optimization resulting profile is consistent with the purely numerical one of Fig. 4(c). In both cases, the targeted frequency range is lower than _f_ 0 _[re f]_ and the spacing between adjacent rods (∝ _S_ and ∝ _φ_ ) increases along the material thickness. The measured and simulated absorption coefficients are almost superimposed in the "front" orientation, with a measured perfect absorption ( _A_ = 0 _._ 997) at _f_ 0 = 1650 Hz ( _λ /_ 7 _._ 1). The correlation in the reverse ("back") orientation is lower. The first micro-lattice layer of the 3D printed samples is always more resistive than expected, resulting in a difficult control of the gradient in the "back" orientation. The medium frequencies optimization, defined by _W_ ( _ω_ ) = 2 _π_ [2500;5500] Hz creates a profile characterized by four zones alternating relatively closely grouped and distant rods, leading to low and high porosity. This profile is also consistent with the one depicted in Fig. 5(c). Moreover, there is a very good correlation between the simulated and the measured absorption coefficients, in both orientations, resulting in an absorption higher than 0.960 between 2630 and 5390 Hz, in the "front" orientation. The absorption reaches 0.994 and 0.979 at _f_ 0 and _f_ 1 respectively. 

## **VI. CONCLUSION** 

This work reports theoretical and experimental results for the continuous manufacturing gradient optimization of a porous layer at normal incidence. The detailed gradient optimization algorithm, adapted from an inverse characterization method, can be applied to multiple manufacturing parameters of structured periodic or stochastic media, as long as the variation of the JCAL parameters with respect to the optimized graded parameters is known. 

As an example, it has been applied to rigid backing absorption optimization. The optimizations showed significant improvement of the absorption coefficient in comparison with optimized homogeneous and monotonically graded materials. On the one hand, lowering the first perfect absorption frequency requires low porosity of the material at the air-porous interface followed by an increase. This leads to an important reduction of the absorption in the medium and high frequencies. On the other hand, increasing the absorption in the medium and high frequencies requires a porosity decrease through the thickness. It results in a shift towards high frequencies of the first maximum of absorption. The monotonic gradient widens the maxima of absorption and increases it closer to unity. The free gradient follows the same trend but adds a sequence of lower and higher porosity to the profile. The number of sequences is equal to the number of absorption 

24 

maxima tuned to increase the absorption in the frequency range of interest. This results in an even higher absorption than monotonic gradient. 

Finally, experimental testing demonstrated the relevance of such gradient. 

## **ACKNOWLEDGMENTS** 

The authors acknowledge Safran Aircraft Engines, the Natural Sciences and Engineering Research Council of Canada (NSERC) for supporting and funding this research. They acknowledge financial support from ANR industrial chair MACIA (ANR-16-CHIN-0002). 

## **Appendix A: Two-scale asymptotic homogenization procedure**[25] 

## _Homogenizability conditions_ 

A representative elementary volume (REV) is defined. It is the unit cell for periodic media (Fig. 2). Then, a characteristic dimension of the REV is selected: _lc_ = _D_ while the characteristic macroscopic dimension is set as _Lc_ = 1m. Separation of scale requires that: 

**==> picture [264 x 27] intentionally omitted <==**

For this reason, the considered micro rods cannot be higher than some millimeters. 

## _Double spatial variable_ 

Two dimensionless variables are introduced. The macroscopic space variable **x** _[∗]_ = **X** _/Lc_ and the microscopic variable **y** _[∗]_ = **X** _/lc_ , where **X** is the actual space variable. The derivation operation is now written as 

**==> picture [286 x 28] intentionally omitted <==**

## _Asymptotic expansion_ 

In order to separate the phenomena happening at the microscopic scale from the ones happening at the macroscopic scale, physical variables are substituted by their asymptotic expansions at multiple scales in powers of _ε_ . A given field _ψ_ is expressed as 

**==> picture [307 x 30] intentionally omitted <==**

25 

## _Governing equations and JCAL parameters_ 

The governing equations two-scale asymptotic formulations and the retrieved JCAL parameters are given in Appendix. 

## _REV characteristic dimension_ 

Applying an homothetic transformation to the medium micro-structure, and thus to the REV, has an analytic simple effect on the medium JCAL parameters. Turning _lc_[(][1][)] into _lc_[(][2][)] multiplies the 2 viscous and thermal lengths by _lc_[(][2][)] _[/][l] c_[(][1][)] and the viscous and thermal permeabilities by _lc_[(][2][)] _[/][l] c_[(][1][)] . � � 

## _JCAL parameters_ 

The homogenization procedure is applied to three fundamental equations: the mass conservation, the heat diffusion and the momentum conservation of the saturating fluid of the REV. Ideal gas assumption, Fourier’s law, definition of the stress tensor and Navier’s equation support the equations solving. An identification in terms of power of _ε_ and taking the limit in _ω →_ ∞ or _ω →_ 0 lead to the equations of interest. 

The equations are given in the generic case of anisotropic porous material for which the tortuosity, viscous characteristic length and viscous permeability are diagonal tensors. 

The thermal problem equation, taking the limit in _ω →_ 0, reads 

**==> picture [292 x 66] intentionally omitted <==**

where Γ _fs_ is the fluid solid interface, Ω the REV and **ej** the unitary vector in the REV main direction _j_ . 

In the following equations, **k** and _ξ_ play the role of the velocity field and its associated pressure 

26 

field, respectively. The visco-inertial problem, taking the limit in _ω →_ 0, becomes 

**==> picture [320 x 102] intentionally omitted <==**

where _⟨·⟩_ Ω is the REV averaging. 

The visco-inertial problem, taking the limit in _ω →_ ∞, becomes 

**==> picture [303 x 103] intentionally omitted <==**

The JCAL parameters are obtained by integrating, over the fluid domain Ω _f_ or fluid-solid interface Γ _fs_ , the solution fields of these equations. They are expressed as 

**==> picture [290 x 33] intentionally omitted <==**

**==> picture [314 x 15] intentionally omitted <==**

**==> picture [306 x 36] intentionally omitted <==**

**==> picture [293 x 35] intentionally omitted <==**

**==> picture [309 x 17] intentionally omitted <==**

**==> picture [293 x 36] intentionally omitted <==**

In case of isotropic media, the JCAL parameters are not direction dependent: their projection over each space direction is identical. In normal incidence along **x** , only the **ex** projection matters and appears in the propagation equations. 

27 

## **Appendix B: Conjugate Gradient method** 

## **1. Conjugate gradient algorithm** 

## **Step 0: Initial guess** 

**q**[(][0][)] ( _x_ ) = _cte ∀x ∈_ [0; _L_ ]. 

## **Step 1: First search direction** 

Set _i_ = 0. Then, compute _R_ ( _x_ ) and _T_ ( _x_ ) _∀ x ∈_ [0; _L_ ] by means of Eqs. (13, 14) and considering the Γ _L_ BC(s). Compute the gradient of the cost function: 

**==> picture [321 x 38] intentionally omitted <==**

Set **D**[(][0][)] = **G** ( **q**[(][0][)] ) wherein **D**[(] _[i]_[)] is the search direction of iteration _i_ . 

## **Step 2: Line search** 

Compute the positive and real valued _λi_ the size of which equals the one of **q** , such that: 

**==> picture [338 x 24] intentionally omitted <==**

The step size is obtained by an iterative method. If _p_ depends on a one parameter vector, the Golden-section search technique (Jack Kiefer, 1953) is used to find the optimal step size. Otherwise, the Nelder-Mead method is applied. This last method is an heuristic one but is fast and reliable when only a few parameters are optimized. 

## **Step 3: Update q** 

**==> picture [308 x 15] intentionally omitted <==**

## **Step 4: New search direction** 

**==> picture [294 x 16] intentionally omitted <==**

**==> picture [294 x 15] intentionally omitted <==**

_βi_ can be computed by the Polak-Ribiere formula with an automatic reset: 

**==> picture [342 x 37] intentionally omitted <==**

28 

If _i_ is higher than the maximum number of iterations then the algorithm stops. Otherwise _i_ = _i_ + 1 and loops to **Step 2** . 

## **2. Gradient of the cost function** 

This section shows the details of the computation of the gradient of the cost function leading to the search direction (Eq. B1). 

The infinitesimal variation of _R_ ( _x, ω,_ **q** ) and _T_ ( _x, ω,_ **q** ) are _δ R_ ( _x, ω,_ **q** ) = _R_ ( _x, ω,_ **q** + _δ_ **q** ) _− R_ ( _x, ω,_ **q** ) and _δ T_ ( _x, ω,_ **q** ) = _T_ ( _x, ω,_ **q** + _δ_ **q** ) _− T_ ( _x, ω,_ **q** ) respectively, resulting of a small perturbation _δ_ **q** of the micro-geometry parameters: 

**==> picture [284 x 13] intentionally omitted <==**

**==> picture [285 x 13] intentionally omitted <==**

either if the sample is rigidly backed or not because the boundary condition (surface impedance) does not depend on the material properties. From Eqs. (11, 13 and 14), the following equations are derived: 

**==> picture [301 x 26] intentionally omitted <==**

**==> picture [301 x 26] intentionally omitted <==**

Perturbing Eqs. (B9, B10) by _δ_ **q** leads to 

**==> picture [358 x 27] intentionally omitted <==**

**==> picture [358 x 26] intentionally omitted <==**

wherein 

**==> picture [314 x 25] intentionally omitted <==**

The total derivative of the equivalent fluid density and bulk modulus are expressed by the addition 

29 

of their partial derivatives 

**==> picture [292 x 68] intentionally omitted <==**

If there is no explicit formulation of the partial derivatives, they are then computed by the derivative 

**==> picture [305 x 27] intentionally omitted <==**

This is the case of the partial derivative with respect to _φ_ . Although it appears in the expression of _ρeq_ and _Keq_ , the other JCAL parameters also depend in a non-analytically way on _φ_ . On the contrary, the JCAL dependence on _D_ is fully analytic. 

The variation of the cost function perturbated by _δ_ **q** takes the form[38] 

**==> picture [367 x 23] intentionally omitted <==**

wherein, setting _[∗]_ as the complex conjugate notation, 

**==> picture [328 x 14] intentionally omitted <==**

**==> picture [328 x 14] intentionally omitted <==**

The following integration is obtained considering the boundary condition Eq. (B7): 

**==> picture [348 x 45] intentionally omitted <==**

The right term of this equation is included in Eq. (B17). The left term’s integrand can be written from Eqs. (B9, B10): 

**==> picture [345 x 98] intentionally omitted <==**

_uR_ ( _x, ω_ ) and _uT_ ( _x, ω_ ) are arbitrary function chosen such that the _δ R_ and _δ T_ dependencies are eliminated. In order to do this, they must satisfy 

**==> picture [355 x 45] intentionally omitted <==**

30 

Equations (B21, B22) reduce to 

**==> picture [331 x 27] intentionally omitted <==**

**==> picture [331 x 26] intentionally omitted <==**

A new expression of the variation of the cost function is then obtained by combining Eqs. (B17,B20,B24,B25): 

**==> picture [352 x 48] intentionally omitted <==**

This variation can also be simply expressed as 

**==> picture [298 x 31] intentionally omitted <==**

The identification of Eq. (B26) with Eq. (B27) and replacing the derivatives by their expression, leads to 

**==> picture [501 x 37] intentionally omitted <==**

## **Appendix C: JCAL experimental parametric model** 

The "infill factor" is the manufacturing variable controlling the spacing between two adjacent rods. The JCAL parameters of eight homogeneous samples, which infill factor is comprised between 10 and 70 %, are retrieved by means of inverse characterization[28] . The manufacturing repeatability is very high which allows to consider a single sample per tested infill factor. Finally, a numerical parametric JCAL model is obtained by interpolating over the values. It is worth noticing that the interpolation functions must be continuous and monotonic. Figure 10 presents the JCAL parameters of the homogeneous samples obtained by inverse characterization and the considered interpolated parametric functions. 

## **REFERENCES** 

> 1J.-F. Allard and N. Atalla, _Propagation of sound in porous media: modelling sound absorbing materials_ , 2nd ed. (Wiley, Hoboken, N.J, 2009). 

31 

**==> picture [398 x 361] intentionally omitted <==**

**----- Start of picture text -----**<br>
1.5<br>0.9<br>Fitted parametric model<br>0.8 Considered value 1.4<br>Excluded value<br>0.7<br>1.3<br>0.6<br>1.2<br>0.5<br>1.1<br>0.4<br>1<br>20 40 60 20 40 60<br>Infill Factor (%) Infill Factor (%)<br>−3 −3<br>x 10<br>1.5  [x 10]<br>1<br>1<br>0.5<br>0.5<br>0 0<br>20 40 60 20 40 60<br>Infill Factor (%) Infill Factor (%)<br>−7 −7<br>x 10 x 10<br>2 2<br>1.5 1.5<br>1 1<br>0.5 0.5<br>0 0<br>20 40 60 20 40 60<br>Infill Factor (%) Infill Factor (%)<br>∞<br>φ α<br> (m) ’ (m)<br>Λ Λ<br>) )<br>2 (mq0 2’ (mq0<br>**----- End of picture text -----**<br>


FIG. 10. JCAL parametric model, obtained by inverse characterization of homogeneous samples. 

- 2X. Olny and C. Boutin, “Acoustic wave propagation in double porosity media,” The Journal of the Acoustical Society of America **114** , 73–89 (2003). 

- 3C. Lagarrigue, J. P. Groby, V. Tournat, O. Dazel, and O. Umnova, “Absorption of sound by porous layers with embedded periodic arrays of resonant inclusions,” The Journal of the Acoustical Society of America **134** , 4670–4680 (2013). 

- 4J.-P. Groby, C. Lagarrigue, B. Brouard, O. Dazel, V. Tournat, and B. Nennig, “Enhancing the absorption properties of acoustic porous plates by periodically embedding Helmholtz resonators,” The Journal of the Acoustical Society of America **137** , 273–280 (2015). 

- 5Y. Aurégan, M. Farooqui, and J.-P. Groby, “Low frequency sound attenuation in a flow duct using a thin slow sound material,” The Journal of the Acoustical Society of America **139** , EL149– EL153 (2016). 

32 

- 6N. Jiménez, V. Romero-García, and J.-P. Groby, “Perfect Absorption of Sound by RigidlyBacked High-Porous Materials,” Acta Acustica united with Acustica , 396–409 (2018). 

- 7S. Mahasaranon, K. V. Horoshenkov, A. Khan, and H. Benkreira, “The effect of continuous pore stratification on the acoustic absorption in open cell foams,” Journal of Applied Physics **111** , 084901 (2012). 

- 8J. Zhu, J. Sun, H. Tang, J. Wang, Q. Ao, T. Bao, and W. Song, “Gradient-structural optimization of metal fiber porous materials for sound absorption,” Powder Technology **301** , 1235–1241 (2016). 

- 9W. Chen, S. Liu, L. Tong, and S. Li, “Design of multi-layered porous fibrous metals for optimal sound absorption in the low frequency range,” Theoretical and Applied Mechanics Letters **6** , 42–48 (2016). 

- 10M. Naebe and K. Shirvanimoghaddam, “Functionally graded materials: A review of fabrication and properties,” Applied Materials Today **5** , 223–245 (2016). 

- 11C. Han, Y. Li, Q. Wang, S. Wen, Q. Wei, C. Yan, L. Hao, J. Liu, and Y. Shi, “Continuous functionally graded porous titanium scaffolds manufactured by selective laser melting for bone implants,” Journal of the Mechanical Behavior of Biomedical Materials **80** , 119–127 (2018). 

- 12X. Cai, Q. Guo, G. Hu, and J. Yang, “Ultrathin low-frequency sound absorbing panels based on coplanar spiral tubes or coplanar Helmholtz resonators,” Applied Physics Letters **105** , 121901 (2014). 

- 13D. C. Akiwate, M. D. Date, B. Venkatesham, and S. Suryakumar, “Acoustic properties of additive manufactured narrow tube periodic structures,” Applied Acoustics **136** , 123–131 (2018). 

- 14J.-P. Groby, R. Pommier, and Y. Aurégan, “Use of slow sound to design perfect and broadband passive sound absorbing materials,” The Journal of the Acoustical Society of America **139** , 1660–1671 (2016). 

- 15E. R. Fotsing, A. Dubourg, A. Ross, and J. Mardjono, “Acoustic properties of periodic microstructures obtained by additive manufacturing,” Applied Acoustics **148** , 322–331 (2019). 

- 16M. D. Guild, V. M. García-Chocano, W. Kan, and J. Sánchez-Dehesa, “Acoustic metamaterial absorbers based on multilayered sonic crystals,” Journal of Applied Physics **117** , 114902 (2015). 

- 17Yang, Wenjing, Yuan, Shangqin, Chua, Chee Kai, and Zhou, Kun, “Wideband sound absorption of 3d printed multi-layer,” (2018). 

- 18Z. Liu, J. Zhan, M. Fard, and J. L. Davy, “Acoustic properties of multilayer sound absorbers with a 3d printed micro-perforated panel,” Applied Acoustics **121** , 25–32 (2017). 

33 

- 19M. D. Guild, M. Rothko, C. F. Sieck, C. Rohde, and G. Orris, “3d printed sound absorbers using functionally-graded sonic crystals,” The Journal of the Acoustical Society of America **143** , 1714–1714 (2018). 

- 20L. De Ryck, W. Lauriks, P. Leclaire, J.-P. Groby, A. Wirgin, and C. Depollier, “Reconstruction of material properties profiles in one-dimensional macroscopically inhomogeneous rigid frame porous media in the frequency domain,” Journal of the Acoustical Society of America (2008), 10.1121/1.2959734. 

- 21J. S. Lee, E. I. Kim, Y. Y. Kim, J. S. Kim, and Y. J. Kang, “Optimal poroelastic layer sequencing for sound transmission loss maximization by topology optimization method,” The Journal of the Acoustical Society of America **122** , 2097–2106 (2007). 

- 22D. L. Johnson, J. Koplik, and R. Dashen, “Theory of dynamic permeability and tortuosity in fluid-saturated porous media,” Journal of Fluid Mechanics **176** , 379–402 (1987). 

- 23D. Lafarge, P. Lemarinier, J. Allard, and V. Tarnow, “Dynamic compressibility of air in porous structures at audible frequencies,” J. Acoust. Soc. Am. **102** , 1995–2006 (1997). 

- 24Y. Champoux and J. Allard, “Dynamic tortuosity and bulk modulus in air-saturated porous media,” Journal of Applied Physics **70** , 1975–1979 (1991). 

- 25J.-L. Auriault, C. Boutin, and C. Geindreau, _Homogenization of coupled phenomena in heterogenous media_ (2009) oCLC: 733729827. 

- 26C.-Y. Lee, M. J. Leamy, and J. H. Nadler, “Numerical Calculation of Effective Density and Compressibility Tensors in Periodic Porous Media: A Multi-Scale Asymptotic Method,” (2008). 

- 27K. V. Horoshenkov, “A Review of Acoustical Methods for Porous Material Characterisation,” The International Journal of Acoustics and Vibration **22** (2017). 

- 28M. Niskanen, J.-P. Groby, A. Duclos, O. Dazel, J. C. Le Roux, N. Poulain, T. Huttunen, and T. Lahivaara, “Deterministic and statistical characterization of rigid frame porous materials from impedance tube measurements,” The Journal of the Acoustical Society of America **142** , 2407– 2418 (2017). 

- 29M. A. Biot, “Mechanics of Deformation and Acoustic Propagation in Porous Media,” Journal of Applied Physics **33** , 1482–1498 (1962). 

- 30L. De Ryck, W. Lauriks, Z. E. A. Fellah, A. Wirgin, J. P. Groby, P. Leclaire, and C. Depollier, “Acoustic wave propagation and internal fields in rigid frame macroscopically inhomogeneous porous media,” Journal of Applied Physics **102** , 024910 (2007). 

- 31M. Baake and U. Schlaegel, “The Peano-Baker series,” arXiv:1011.1775 [math] (2010). 

34 

- 32R. Fletcher, “Function minimization by conjugate gradients,” The Computer Journal **7** , 149–154 (1964). 

- 33M. R. Hestenes and E. Stiefel, “Methods of Conjugate Gradients for Solving Linear Systems,” Journal of Research of the National Bureau of Standards **49** , 28 (1952). 

- 34V. Romero-García, G. Theocharis, O. Richoux, and V. Pagneux, “Use of complex frequency plane to design broadband and sub-wavelength absorbers,” The Journal of the Acoustical Society of America **139** , 3395–3403 (2016). 

- 35A. Terroir, L. Schwan, T. Cavalieri, V. Romero-García, G. Gabard, and J.-P. Groby, “General method to retrieve all effective acoustic properties of fully-anisotropic fluid materials in three dimensional space,” Journal of Applied Physics **125** , 025114 (2019), arXiv: 1810.03603. 

- 36X. Cai, J. Yang, and G. Hu, “Optimization on microlattice materials for sound absorption by an integrated transfer matrix method,” The Journal of the Acoustical Society of America **137** , EL334–EL339 (2015). 

- 37J. Boulvert, J. Costa-Baptista, T. Cavalieri, M. Perna, E. R. Fotsing, V. Romero-García, G. Gabard, A. Ross, J. Mardjono, and J.-P. Groby, “Acoustic modeling of micro-lattices obtained by additive manufacturing,” (2019), working paper or preprint. 

- 38M. Norgren and S. He, “An optimization approach to the frequency-domain inverse problem for a nonuniform LCRG transmission line,” Microwave Theory and Techniques, IEEE Transactions on **44** , 1503–1507 (1996). 

35