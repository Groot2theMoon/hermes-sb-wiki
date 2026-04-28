---
source_url: ""
ingested: 2026-04-28
sha256: 5b2004a7343994a49ffd03bf8530c2d6ce7b54eda66c57bdbe4dc42b77732c65
---


# Interface conditions for Biot's equations of poroelasticity

Boris Gurevich

*The Geophysical Institute of Israel, P.O. Box 2286, Holon 58122, Israel*

Michael Schoenberg

*Schlumberger-Doll Research, Old Quarry Road, Ridgefield, Connecticut 06877-4108*

(Received 27 February 1997; accepted for publication 15 February 1999)

Interface conditions at a boundary between two porous media are derived directly from Biot's equations of poroelasticity by replacing the discontinuity surface with a thin transition layer, in which the properties of the medium change rapidly yet continuously, and then taking the limit as the thickness of the transition layer approaches zero. The interface conditions obtained in this way, the well known "open-pore" conditions, are shown to be the only ones that are fully consistent with the validity of Biot's equations throughout the poroelastic continuum, including surfaces across which the medium properties are discontinuous. But partially blocked or completely impermeable interfaces exist; these may be looked upon as the case of a thin layer with its permeability taken to be proportional to the layer thickness, again in the limit as layer thickness approaches zero. This approach can serve as a simple recipe for modeling such an interface in any heterogeneous numerical scheme for poroelastic media. © 1999 Acoustical Society of America.

[S0001-4966(99)03605-X]

PACS numbers: 43.20.Gp [DEC]

## INTRODUCTION

The linear mechanics of porous elastic solids saturated with compressible viscous fluids is described by Biot's equations of poroelasticity.<sup>1-3</sup> To be used for piecewise homogeneous media, these equations must be complemented by interface conditions which relate the field variables on both sides of a surface of discontinuity in the material properties which are involved in the coefficients appearing in Biot's equations.

Such conditions were suggested by Deresiewicz and Skalak;<sup>4</sup> they require the continuity across an interface of the total (normal and tangential) stress traction, of the fluid pressure  $p$  (for the case when the two media are in perfect hydraulic contact), of the solid particle velocity  $v$ , and of the normal component of the relative fluid velocity. The relative flow  $\mathbf{w}$  of the fluid relative to the solid is defined as

$$\mathbf{w} = \phi(\mathbf{V} - \mathbf{v}), \quad (1)$$

where  $\mathbf{V}$  is the fluid particle velocity and  $\phi$  is the porosity.

When the hydraulic contact between two porous materials is imperfect, the condition for the jump in pressure  $p$  may be written

$$-(p^+ - p^-) = \frac{1}{\beta_s} w_n, \quad (2)$$

where  $\beta_s$  is sometimes called interface hydraulic permeability and subscript  $n$  denotes the component normal to the interface. For perfect hydraulic contact,  $\beta_s = \infty$  and  $p^+ = p^-$ , i.e.,  $p$  is continuous. On the other hand, for no hydraulic contact across the interface,  $\beta_s = 0$  and condition (2) reduces to  $w_n = 0$ , implying no motion of the fluid relative to the solid.

The interface conditions of Deresiewicz and Skalak are now widely used in modeling wave propagation in layered

poroelastic media, porous media with inclusions, and other kinds of piecewise homogeneous porous materials.<sup>5-8</sup>

Bourbié *et al.*<sup>5</sup> have given a proof of these conditions on the basis of Hamilton's principle. For some situations the boundary conditions of Deresiewicz and Skalak have been confirmed experimentally.<sup>9,10</sup> However, some issues related to the interface conditions in porous media are still under discussion. In particular, this relates to the value of the interface permeability  $\beta_s$ , which has to be assigned for every interface in the medium. Furthermore, the newly developed algorithms for numerical simulation of elastic wave propagation in poroelastic media<sup>11,12</sup> use so-called heterogeneous numerical schemes, which are applicable to porous media with spatially variable coefficients. For piecewise homogeneous media these schemes assume no explicit conditions at a surface of discontinuity. Then, the question arises, which boundary conditions are implied (or simulated) by these algorithms.<sup>13</sup> Moreover, de la Cruz and Spanos<sup>14</sup> have expressed doubts about the physical validity of the boundary conditions of Deresiewicz and Skalak, and proposed altogether different boundary conditions for porous media; see also Ref. 15. Their concern, if justified, could throw into doubt all the theoretical and numerical results based on the interface conditions of Deresiewicz and Skalak, and thus needs to be addressed.

On the other hand, it has long been known in mathematical physics that interface conditions at an internal discontinuity in a medium described by a linear system of partial differential equations can be derived from those equations if they are written for a general inhomogeneous medium. For Maxwell's equations, for example, this method is discussed in great detail in The Feynman Lectures on Physics.<sup>16</sup> As noted once by S. L. Lopatnikov,<sup>17</sup> this method may be applied to Biot's equations of poroelasticity to derive the interface conditions consistent with these equations.

This note employs the idea of using the equations for a general inhomogeneous medium to end the controversy over interface conditions in porous media. Biot's equations are assumed to hold not only in continuous regions, but also at a discontinuity. By replacing the discontinuity surface with a thin transition layer, in which the properties of the medium change rapidly yet continuously, we arrive at interface conditions that are identical to the open-pore conditions of Deresiewicz and Skalak. We then consider a closed or partially open interface, and show that such an interface may be looked upon as the limiting case of a thin layer, as layer thickness approaches zero, with permeability proportional to the layer thickness.

## I. INTERFACE CONDITIONS AT A DISCONTINUITY SURFACE

The linear dynamics of an inhomogeneous porous medium of porosity  $\phi$  saturated with a viscous fluid of density  $\rho_f$  and viscosity  $\eta$  can be described by Biot's equations of poroelasticity,<sup>3</sup> which, in Cartesian coordinates  $x_i$ ,  $i = 1, 2, 3$  with summation implied by repeated indices and with the time derivative of function  $f$  denoted by  $\dot{f}$ , have the form

$$\frac{\partial \tau_{ij}}{\partial x_j} = (\rho \dot{u}_i + \rho_f \dot{w}_i), \quad (3)$$

$$-\frac{\partial p}{\partial x_i} = \frac{\eta}{\kappa} \dot{F} w_i + (\rho \dot{u}_i + m \dot{w}_i), \quad (4)$$

where the field variables are the  $\tau_{ij}$  which are the components of total stress in the porous saturated medium,  $p$  which is fluid pressure, and  $u_i$  and  $w_i$  which are components of particle velocity  $\mathbf{v}$  and relative fluid velocity  $\mathbf{w}$ , respectively; see Eq. (1). As for material parameters,  $\rho$  is bulk density of the saturated rock,

$$\rho = (1 - \phi) \rho_s + \phi \rho_f, \quad (5)$$

where  $\rho_s$  is the density of the solid grain material, and

$$m = \frac{\rho_f \alpha}{\phi}, \quad (6)$$

with  $\alpha$  denoting the tortuosity coefficient, a dimensionless number. Low frequency permeability is given by  $\kappa$ , and the operator  $\dot{F}$  is a linear integral convolution operator with respect to time, which in the Fourier transform domain becomes a frequency dependent multiplier  $F(\omega)$ , implying frequency dependent permeability  $\tilde{\kappa}(\omega) = \kappa/F(\omega)$  (so-called dynamic permeability<sup>2,18</sup>). This operator is defined so that its transform approaches unity as frequency becomes very low. At higher frequencies this operator accounts for the deviation of the fluid flow in pores from the Poiseuille flow. Note that all material properties, including the operator  $\dot{F}$ , are in general functions of position.

The total stresses and fluid pressure are linearly related to solid and fluid velocity derivatives by

![Figure 1: A graph showing the behavior of a parameter (e.g., porosity phi) across a transition region around a discontinuity. The vertical axis is labeled f+ and f-. The horizontal axis is labeled x1 and has tick marks at -d/2, 0, and d/2. The curve starts at f- for x1 < -d/2, rises smoothly through the transition region between -d/2 and d/2, and levels off at f+ for x1 > d/2.](3910648e3591af72a40473bb403cbe2d_img.jpg)

Figure 1: A graph showing the behavior of a parameter (e.g., porosity phi) across a transition region around a discontinuity. The vertical axis is labeled f+ and f-. The horizontal axis is labeled x1 and has tick marks at -d/2, 0, and d/2. The curve starts at f- for x1 < -d/2, rises smoothly through the transition region between -d/2 and d/2, and levels off at f+ for x1 > d/2.

FIG. 1. Behavior of a parameter of the porous medium, say, porosity  $\phi$ , across the transition region around the discontinuity.

$$\dot{\tau}_{ij} = \mu \left( \frac{\partial v_i}{\partial x_j} + \frac{\partial v_j}{\partial x_i} \right) + \delta_{ij} \left[ \lambda_c \frac{\partial v_k}{\partial x_k} + \left( 1 - \frac{K}{K_s} \right) M \frac{\partial w_k}{\partial x_k} \right], \quad (7)$$

$$-\dot{p} = \left( 1 - \frac{K}{K_s} \right) M \frac{\partial v_k}{\partial x_k} + M \frac{\partial w_k}{\partial x_k}, \quad (8)$$

where  $\lambda_c$  and  $\mu$  are Lamé constants of the saturated rock,  $K$  and  $K_s$  are bulk moduli of the dry (empty) solid matrix and solid grain material, respectively;  $M$  is the "pore space modulus," defined by

$$\frac{1}{M} = \frac{\phi}{K_f} + \frac{(1 - \phi - K/K_s)}{K_s}, \quad (9)$$

with  $K_f$  the fluid bulk modulus. In Eq. (7),  $\delta_{ij}$  is the Kronecker symbol. Equations (3), (4), (7), and (8) form a system of 13 partial differential equations for 13 unknown functions: 6 independent components  $\tau_{ij}$  of the total stress, fluid pressure  $p$ , 3 components of the solid velocity  $v_i$ , and 3 components of the relative fluid velocity  $w_i$ .

Now, assume that in the porous medium there is a discontinuity surface, across which the properties of the medium undergo a jump. Let  $P$  be a point on the discontinuity surface, and assume that this surface is smooth in the vicinity of  $P$ . Consider a Cartesian coordinate system with its origin at point  $P$  and its  $x_1$  axis normal to the discontinuity surface, and with values on the positive side denoted by superscript "+" and on the negative side, with a superscript "-". We wish to obtain relationships between the limiting values of the field variables (stresses, pressure, and velocities) as  $x_1 \rightarrow 0$  through negative and positive values of the  $x_1$  coordinate. These relationships will be seen to derive from the requirement that Biot's equations are valid throughout the medium including the discontinuity (and hence, at point  $P$  as well).

Following the procedure described in Ref. 16, we replace the discontinuity by a thin transition layer of the thickness  $d$ , in which the Biot's coefficients, including porosity, change rapidly but smoothly, as shown in Fig. 1. The thickness  $d$  is taken small enough to ensure that the derivatives with respect to  $x_1$  of the Biot's coefficients in the layer are much larger than the derivatives with respect to  $x_2$ ,  $x_3$ , and also much larger than any spatial derivatives in the regions of continuity of the coefficients. Thus terms containing derivatives with respect to  $x_1$  are the terms of interest. Note that of the 13 scalar equations corresponding to Eqs. (3), (4), (7), and (8), 10 of them have terms containing a derivative with respect to  $x_1$ . As  $d \rightarrow 0$ , all terms that do not contain a

derivative with respect to  $x_1$  are bounded in the  $d$ -vicinity of  $P$ , and we can write these ten equations in the form

$$\frac{\partial \tau_{11}}{\partial x_1} = \mathcal{O}(1), \quad (10)$$

$$- \frac{\partial p}{\partial x_1} = \mathcal{O}(1), \quad (11)$$

$$\mu \frac{\partial v_i}{\partial x_1} + \delta_{i1} \left[ (\lambda_c + \mu) \frac{\partial v_1}{\partial x_1} + \left( 1 - \frac{K}{K_s} \right) M \frac{\partial w_1}{\partial x_1} \right] = \mathcal{O}(1), \quad (12)$$

$$\lambda_c \frac{\partial v_1}{\partial x_1} + \left( 1 - \frac{K}{K_s} \right) M \frac{\partial w_1}{\partial x_1} = \mathcal{O}(1), \quad (13)$$

$$\left( 1 - \frac{K}{K_s} \right) M \frac{\partial v_1}{\partial x_1} + M \frac{\partial w_1}{\partial x_1} = \mathcal{O}(1). \quad (14)$$

Note this is actually a set of 9 scalar equations since Eq. (13) comes from Eq. (7) as  $d \rightarrow 0$  for both  $ij$  set to 22 and to 33. Equations (12), (13), and (14) can be satisfied if and only if

$$\frac{\partial v_i}{\partial x_1} = \mathcal{O}(1), \quad (15)$$

$$\frac{\partial w_1}{\partial x_1} = \mathcal{O}(1). \quad (16)$$

Now by replacing each derivative of the form  $\partial f / \partial x_1$  with the corresponding finite difference  $(f^+ - f^-)/d$ , multiplying both sides of each of the Eqs. (10), (11), (15), and (16) by  $d$ , and taking the limit as  $d \rightarrow 0$ , we obtain,

$$\tau_{i1}^+ - \tau_{i1}^- = 0, \quad (17)$$

$$p^+ - p^- = 0, \quad (18)$$

$$v_i^+ - v_i^- = 0, \quad (19)$$

$$w_1^+ - w_1^- = 0, \quad (20)$$

a set of eight independent interface conditions. Recalling that subscript 1 refers to the normal component of the field variables, we conclude that the interface conditions require the continuity, across the interface, of (1) normal and tangential components of the total stress traction acting on the interface, (2) fluid pressure, (3) the solid velocity vector, and (4) the normal component of the relative fluid velocity vector. These conditions follow directly from Biot's equations if the latter are satisfied at the discontinuity.

Comparing these boundary conditions with those of Deresiewicz and Skalak mentioned in the Introduction, we immediately see that interface conditions (17)–(20) are identical to a particular case of the standard conditions of Deresiewicz and Skalak, the open-pore conditions, namely Eq. (2) with interface permeability  $\beta_s \rightarrow \infty$ . In other words, out of the choice allowed by the standard conditions of Deresiewicz and Skalak, only the open-pore conditions are consistent with Biot's equations, if the latter are to be valid throughout the poroelastic continuum, including surfaces across which the medium properties are discontinuous. These are the interface conditions that must be used in any

![Figure 2: Diagram of an interface between two porous media. The diagram shows three cases: (a) open interface where the solid phases are continuous across the boundary; (b) partially open interface where there is a gap in the solid phases; (c) closed interface where the solid phases are separated by a gap. A legend indicates that hatched areas represent the solid phase and white areas represent the liquid phase. Labels 'Medium 1', 'Interface', and 'Medium 2' are present on the right side of the diagram.](893055d6397c2123fffe8d17a6f4c23f_img.jpg)

Figure 2: Diagram of an interface between two porous media. The diagram shows three cases: (a) open interface where the solid phases are continuous across the boundary; (b) partially open interface where there is a gap in the solid phases; (c) closed interface where the solid phases are separated by a gap. A legend indicates that hatched areas represent the solid phase and white areas represent the liquid phase. Labels 'Medium 1', 'Interface', and 'Medium 2' are present on the right side of the diagram.

FIG. 2. Diagram of an interface between two porous media on a microscopic scale: (a) open interface ( $\beta_s = \infty$ ); (b) partially open interface ( $0 < \beta_s < \infty$ ); (c) closed interface ( $\beta_s = 0$ ) (after Deresiewicz and Skalak, Ref. 4).

numerical modeling scheme, if that scheme is to properly handle Biot's equations when the porous medium is piecewise continuous.

We emphasize that, in line with Biot theory the above derivation of the interface conditions has been carried out exclusively from the macroscopic standpoint, without considering microscopic details of the interface.

## II. CLOSED AND PARTIALLY OPEN INTERFACES

The result of the previous section that the only interface conditions consistent with Biot theory are the open-pore conditions may seem unphysical, since in a real medium one can always imagine an impermeable, or partially permeable contact between two permeable media.<sup>9</sup> Folklore has it that, if one looks at an interface from the microscopic standpoint, such a situation may occur if the cross sections of pores of two media do not match at the interface, as shown in Fig. 2. This, however, seems a highly unlikely scenario for a natural interface, based on preliminary experiments carried out by Rasolofosaon and Schoenberg in 1996. Their results showed that the presence of a fracture in a piece of sandstone did not change the decrease of the rock's permeability normal to the fracture whether the two pieces of the rock were held together such that the two pieces "fit" one another at the fracture surface, or whether one piece of the rock was offset slightly relative to the other piece such that the two pieces did not fit at the fracture surface.

A more likely scenario for partial or total blockage of flow across a fracture is one in which clays, muds, or ground up grain materials clog the pores in the vicinity of the interface or fracture surface.

At this point the question arises as to how partially open or closed interfaces can be handled in the context of Biot theory. Following an approach used in Ref. 19, we can solve this problem by replacing the interface with a thin poroelastic layer of thickness  $d$ , and letting its permeability to viscosity ratio  $\kappa/\eta$  be proportional to the thickness  $d$ , i.e.,

$$\frac{\kappa}{\eta} \equiv \beta d, \quad (21)$$

keeping in mind that open pore conditions of *perfect hydraulic contact* must hold on both sides of the layer. Then Eq. (4) becomes

$$-\frac{\partial p}{\partial x_i} = \frac{1}{\beta d} \hat{F} w_i + (p_j \dot{u}_i + m \dot{w}_i). \quad (22)$$

After replacement of  $\partial p / \partial x_i$  with its finite difference approximation  $(p^+ - p^-)/d$  and the multiplication of both sides of the equation by  $d$ , taking the limit as  $d \rightarrow 0$  yields

$$-(p^+ - p^-) = \frac{1}{\beta} \hat{F} w_1. \quad (23)$$

Comparing this result with Eq. (2) we see that a layer of small thickness  $d$  with low permeability  $\kappa = \beta \eta d$  and operator  $\hat{F}$  is equivalent to an interface with a finite frequency dependent interface permeability. In the time domain, one over the interface permeability is an integral operator, such that

$$\frac{1}{\beta_s} = \frac{\hat{F}}{\beta}. \quad (24)$$

At low frequencies  $\hat{F} \approx 1$ , and hence  $\beta_s \approx \beta$ . However, at higher frequencies, the interface permeability operator  $\hat{F}$  becomes, in the frequency domain, simply multiplication by  $\hat{F}(\omega)$ , the Fourier transform of the kernel function of  $\hat{F}$ . This means that the interface permeability to be used in the interface condition must involve the limiting value (as  $d \rightarrow 0$ ) of the frequency dependent permeability  $\tilde{\kappa}(\omega) = \kappa/F(\omega)$  of the inserted layer, rather than its quasi-static permeability  $\kappa$ <sup>18</sup>

$$\frac{1}{\beta_s} = \frac{F(\omega)}{\beta} = \lim_{d \rightarrow 0} \frac{F(\omega) \eta d}{\kappa} = \lim_{d \rightarrow 0} \frac{\eta d}{\tilde{\kappa}}, \quad (25)$$

proving the intuitive surmise of Rosenbaum<sup>20</sup> that the interface permeability as defined by Deresiewicz and Skalak<sup>4</sup> might be frequency dependent.

Equation (24) provides a simple recipe for numerical modeling algorithms. An interface with frequency independent inverse permeability  $1/\beta_s$  can be simulated by a layer of small thickness  $d$  and inverse permeability

$$1/\kappa = 1/\beta_s \eta d. \quad (26)$$

An impermeable interface, instead of being simulated by letting  $w_i = 0$  on the interface, can be modeled by a thin layer of small  $\beta$ , small enough so that the length corresponding to a typical background permeability to viscosity ratio divided by  $\beta$  is  $\gg$  than layer thickness  $d$ . Clearly, an interface with frequency dependent inverse permeability can be modeled in similar fashion by the inclusion of  $\hat{F}$  in the time domain or  $F(\omega)$  in the frequency domain.

One can also observe that the permeability of the transition layer that simulates a partially impermeable interface depends not only on the interface permeability, but also on the fluid viscosity. This fact may look suspicious, since permeability is a property of the solid frame, and must not be affected by fluid properties. To explain this, one needs to recall the definition of interface permeability, Eq. (2). Indeed, Eq. (2) is nothing more than a form of the quasi-static Darcy law, which, for a homogeneous medium with a rigid frame is usually written as

$$V = -\frac{\kappa}{\eta} \nabla p, \quad (27)$$

where  $V$  denotes fluid particle velocity. Comparing Eq. (27) with (2) one can conclude that the interface permeability is not a purely geometrical characteristic of the interface, but is inversely proportional to the fluid viscosity. This shows that in the right-hand side of Eq. (26) the fluid viscosity cancels out and hence the permeability of the transition layer is in fact independent of fluid properties.

## III. CONCLUSIONS

Interface conditions at a boundary between two porous media have been derived directly from Biot's equations of poroelasticity. These conditions are identical to a particular variant of the class of interface conditions of Deresiewicz and Skalak, namely to the open-pore conditions. In other words, we have proved that only the open-pore interface conditions are fully consistent with the validity of Biot's equations of poroelasticity at the interface. These are the conditions that should be expected to hold in any heterogeneous numerical modeling scheme, if that scheme is to properly handle Biot's equations in an inhomogeneous poroelastic continuum.

Interface conditions for closed or partially open interfaces may also be used, whether the interface is along a surface of discontinuity or not. Such conditions violate Biot's equations at the interface, but we have shown that a partially open or impermeable interface may be looked upon as a limiting case of a thin layer with small permeability proportional to the layer thickness, where the open-pore conditions do apply on both sides of this thin layer. This can serve as a simple recipe for modeling such an interface in any heterogeneous numerical scheme for poroelastic media. Further experimental and numerical studies are needed to analyze the importance of fully or partially impermeable interfaces in different porous materials.

## ACKNOWLEDGMENTS

The work of Boris Gurevich was carried out under a project supported by the Earth Science Research Administration of the Israel Ministry of Infrastructure. Boris Gurevich also thanks S. L. Lopatnikov of Moscow University for productive discussions. Michael Schoenberg would like to express appreciation to Patrick Rasolofosaon of IFP for being his host for two weeks of discussion and experiments in Paris during summer 1996.

<sup>1</sup> M. A. Biot, "Theory of propagation of elastic waves in a fluid-saturated porous solid. I. Low-frequency range," *J. Acoust. Soc. Am.* **28**, 168–178 (1956).

<sup>2</sup> M. A. Biot, "Theory of propagation of elastic waves in a fluid-saturated porous solid. II. Higher frequency range," *J. Acoust. Soc. Am.* **28**, 179–191 (1956).

<sup>3</sup> M. A. Biot, "Mechanics of deformation and acoustic propagation in porous media," *J. Appl. Phys.* **33**, 1482–1498 (1962).

<sup>4</sup> H. Deresiewicz and R. Skalak, "On uniqueness in dynamic poroelasticity," *Bull. Seismol. Soc. Am.* **53**, 783–788 (1963).

<sup>5</sup> T. Bourbié, O. Coussy, and B. Zinszner, *Acoustics of Porous Media* (Technip, Paris, 1987).

- <sup>6</sup>J.-F. Allard, R. Bourdier, and C. Depollier, "Biot waves in layered media," *J. Appl. Phys.* **60**, 1926–1929 (1986).
- <sup>7</sup>J. G. Berryman, "Scattering by a spherical inhomogeneity in a fluid-saturated porous medium," *J. Math. Phys.* **26**, 1408–1419 (1985).
- <sup>8</sup>B. Gurevich, A. P. Sadovnichaja, S. L. Lopatnikov, and S. A. Shapiro, "The Born approximation in the problem of elastic wave scattering by a spherical inhomogeneity in a fluid-saturated porous medium," *Appl. Phys. Lett.* **61**, 1275–1277 (1992).
- <sup>9</sup>P. N. J. Rasolofosaon, "Importance of the interface hydraulic condition on the generation of second bulk compressional wave in porous media" *Appl. Phys. Lett.* **52**, 780–782 (1988).
- <sup>10</sup>B. Gurevich, "Numerical simulation of ultrasonic experiments on poroelastic samples," European Association of Geoscientists and Engineers, Extended Abstracts, Paper C032 (1996).
- <sup>11</sup>N. Dai, A. Vafidis, and E. R. Kanasewich, "Wave propagation in heterogeneous, porous media: A velocity-stress, finite difference method" *Geophysics* **60**, 327–340 (1995).
- <sup>12</sup>J. M. Carcione, "Full frequency-range transient solution for compressional waves in a fluid-saturated viscoacoustic porous medium," *Geophys. Prosp.* **44**, 99–129 (1996).
- <sup>13</sup>G. Guirgoa-Goode and J. M. Carcione, "Heterogeneous modelling behaviour at an interface in porous media," European Association of Geoscientists and Engineers, Extended Abstracts, Paper C005 (1996).
- <sup>14</sup>V. de la Cruz and T. J. T. Spanos, "Seismic boundary conditions for porous media," *J. Geophys. Res.* **B 94**, 3025–3029 (1989).
- <sup>15</sup>B. Gurevich, "Discussion of 'Reflection and transmission of seismic waves at the boundaries of porous media,' by V. de la Cruz, J. Hube, and T. J. T. Spanos (Wave Motion **16**, 323–338, 1992) with reply by the authors, Wave Motion **18**, 303–304 (1993).
- <sup>16</sup>R. P. Feynman, R. B. Leighton, and M. Sands, *The Feynman Lectures on Physics, Vol. 2* (Addison–Wesley, Reading, MA, 1964).
- <sup>17</sup>S. L. Lopatnikov, personal communication (1985).
- <sup>18</sup>D. L. Johnson, J. Koplik, and R. Dashen, "Theory of dynamic permeability and tortuosity in fluid-saturated porous media," *J. Fluid Mech.* **176**, 379–402 (1987).
- <sup>19</sup>M. Schoenberg, "Elastic wave behavior across linear slip interfaces," *J. Acoust. Soc. Am.* **68**, 1516–1521 (1980).
- <sup>20</sup>J. H. Rosenbaum, "Synthetic microseismograms: Logging in porous formations," *Geophysics* **39**, 14–32 (1974).