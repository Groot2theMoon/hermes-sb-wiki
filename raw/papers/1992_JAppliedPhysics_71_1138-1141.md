---
source_url: ""
ingested: 2026-04-28
sha256: 20163f932b68da33073534827c479cd773a3fc0a3d362eeb1ff7730309312dab
---


# On the correspondence between poroelasticity and thermoelasticity

Andrew Norris

Department of Mechanical and Aerospace Engineering, Rutgers University, Piscataway,

New Jersey 08855-0909

(Received 12 August 1991; accepted for publication 28 October 1991)

An interesting and useful analogy can be drawn between the equations of static poroelasticity and the equations of thermoelasticity including entropy. The correspondence is of practical use in determining the effective parameters in an inhomogeneous poroelastic medium using known results from the literature on the effective thermal expansion coefficient and the effective heat capacity of a disordered thermoelastic continuum.

## I. INTRODUCTION

The similarity between the equations of poroelasticity for a fluid saturated porous medium and the equations of thermoelasticity has been noted many times in the literature. Indeed, Biot was intimately aware of the connection having made fundamental contributions in both fields; in particular he is credited with the first consistent development of a dynamic theory of poroelasticity (see Ref. 1 for a review). The correspondence between the theories is particularly useful in that there appears to be a more substantial literature on problems in thermoelasticity, and many of the available results can be directly translated into the realm of poroelasticity. For instance, Bonnet<sup>2</sup> used the equivalence to draw upon known results in the thermoelastic literature to obtain explicit and simple expressions for the fundamental point source solution in two-dimensional (2D) and 3D dynamic poroelasticity. More recently, Berryman and Milton<sup>3</sup> noted that the question of determining one of the coupling parameters in the poroelastic constitutive equations for a composite medium is completely analogous to the problem of finding the coefficient of thermal expansion in a composite material, for which there are several applicable results already known. The relation between solutions of either theory is also discussed by Chandrasekharajah and Cowin.<sup>4</sup>

The connection between the parameters in the static equations of the two theories is explored in this paper. By considering the theory of thermoelasticity which includes entropy as a field variable it is possible to make a complete correspondence between the theories. The equivalence means that results for the effective heat capacity of a composite material have direct implications for one of the moduli in the Biot theory, namely  $M$ . This connection completes the correspondence noted by Berryman and Milton.<sup>3</sup>

## II. THE EQUATIONS OF STATIC POROELASTICITY

We shall follow the notation of Biot from his 1962 paper<sup>1</sup> because, although it is not his first work in the area by any means, it does provide a concise review of the theory for both static and dynamic deformation, although dynamic effects are not considered here. The fundamental field variables for static deformation are the bulk stress  $\tau$ , the bulk strain  $e$ , the pore-fluid pressure  $p$ , and the pore strain parameter  $\zeta$ . The bulk stress and strain are both

symmetric second order tensors, and the strain may be identified as the symmetric part of the tensor of displacement gradients,  $e = \frac{1}{2}[\nabla u + (\nabla u)^T]$ , where  $u$  is the bulk displacement vector. The pore strain may be identified as  $\zeta = -\text{div}\phi(\mathbf{U} - \mathbf{u})$ , where  $\mathbf{U}$  is the pore fluid displacement vector and  $\phi$  is the volume fraction occupied by the pore space, or porosity. We will not use the displacement vectors further, concentrating instead on the relations between stress and strain. The static equilibrium conditions for a given material are

$$\text{div } \tau = 0, \quad p = \text{constant}. \quad (1)$$

These equations are satisfied throughout the sample, subject to prescribed values of traction or displacement on the boundary. The magnitude of the uniform pressure within the sample depends upon its imposed value at the boundary.

The constitutive relations are

$$\tau = C_e e - \alpha M \zeta \mathbf{I}, \quad p = -\alpha M e + M \zeta. \quad (2)$$

Here  $e = \text{tr } e$  and  $\mathbf{I}$  is the second order identity tensor. The fourth order tensor  $C_e$  represents the elastic moduli of the saturated or confined material, and are related to the corresponding moduli of the unconfined sample, i.e., the *frame* moduli  $C$ , by  $C_e = C + \alpha^2 M \mathbf{I} \otimes \mathbf{I}$ . We assume for simplicity that the elastic moduli  $C$  of the frame are isotropic with bulk modulus  $K$  and shear modulus  $\mu$ . It is also assumed that the interaction between the pore parameters and the bulk variables in (2) is isotropic and defined by the scalar  $\alpha M$ . One could generalize this to allow for the possibility of anisotropic interaction, in which case the isotropic second-order tensor  $\alpha M \mathbf{I}$  is replaced by a symmetric second-order tensor with three principal directions and three associated scalars instead of the single  $\alpha M$ .

Both  $\alpha$  and  $M$  can be related to microstructural moduli.<sup>1</sup> If there is only one type of grain present, with bulk modulus  $K_g$ , then

$$\alpha = 1 - \frac{K}{K_g}, \quad \frac{1}{M} = \frac{\phi}{K_f} + \frac{\alpha - \phi}{K_g}, \quad (3)$$

where  $K_f$  is the bulk modulus of the fluid occupying the pore space. We note the inequalities for an isotropic medium,  $K < K_g$  and  $\phi < \alpha < 1$ ,<sup>5</sup> the latter of which follows from (3) and the requirement that  $M$  be non-negative for all physically permissible values of the fluid compressibil-

ity. When there is more than one type of granular material it is still possible to define a modulus analogous to  $K_\sigma$ , see Refs. 3 and 6 for details.

The fundamental variables in (2) are taken to be the strains  $\mathbf{e}$  and  $\zeta$ . Alternatively, we may consider  $\mathbf{e}$  and  $p$  as the fundamental variables by rewriting (2) as

$$\tau = C\mathbf{e} - \alpha p \mathbf{I}, \quad \zeta = \frac{1}{M} p + \alpha e. \quad (4)$$

Define  $\mathbf{S}$  as the fourth-order compliance tensor for the frame, such that  $\mathbf{CS} = \mathbf{SC} = \mathbf{I}^{(4)}$ , where  $\mathbf{I}^{(4)}$  is the fourth-order identity tensor. It is then possible to rewrite the constitutive relations in yet another form, this time emphasizing the stress variables as fundamental. For the isotropic frame, this becomes

$$\mathbf{e} = \mathbf{S}\tau + \frac{\alpha}{3K} p \mathbf{I}, \quad \zeta = \left( \frac{1}{M} + \frac{\alpha^2}{K} \right) p + \frac{\alpha}{3K} \text{tr } \tau. \quad (5)$$

## III. THE EQUATIONS OF STATIC THERMOELASTICITY

The basic variables are in many ways similar to those of a fluid saturated porous medium. We use the same parameters to represent the bulk stress and strain,  $\tau$  and  $\mathbf{e}$ . The variables associated with thermal effects are the temperature deviation,  $\theta$ , and the entropy per unit volume,  $s$ . All variables, whether poroelastic or thermoelastic, are defined relative to their ambient values, and would be zero in the absence of some exterior motivating forces. The equilibrium conditions are analogous to (1),

$$\text{div } \tau = 0, \quad \theta = \text{constant}, \quad (6)$$

where the constant value of temperature is defined by its prescribed value on the boundary.

The simplest form of the constitutive relations are<sup>7-9</sup>

$$\mathbf{e} = \mathbf{S}\tau + \beta\theta, \quad s = c_p\theta + \text{tr } \beta\tau. \quad (7)$$

Here,  $\beta$  is the symmetric second-order tensor of thermal expansion coefficients. The heat capacity per unit volume at constant stress is  $\theta_0 c_p$ , where  $\theta_0$  is the ambient absolute temperature. The tensor  $\mathbf{S}$  is now the tensor of isothermal compliances, with inverse  $\mathbf{C}$ .

It is clear that the constitutive relations (5) and (7) are identical in form if we make the correspondence  $p$ ,  $\zeta \leftrightarrow \theta$ ,  $s$ . The thermoelastic relations corresponding to the other representations, (2) and (4) can be obtained by rearranging (7). Choosing  $\mathbf{e}$  and  $\theta$  as the fundamental variables, we have

$$\tau = C\mathbf{e} - c_p\theta, \quad s = c_p\theta + c_t \text{tr } \tau e. \quad (8)$$

The heat capacity per unit volume at constant strain is  $\theta_0 c_w$  and is related to the heat capacity at constant stress by  $c_w = c_p - \text{tr } \beta(C\beta)$ . The symmetric second-order tensor  $\gamma$  is  $\gamma = 1/(c_p) C\beta$ . Equation (8) should be compared with (4). The thermoelastic constitutive relations analogous to (2) are obtained by treating  $\mathbf{e}$  and  $s$  as the fundamental variables,

$$\tau = C_s \mathbf{e} - \gamma s, \quad \theta = -\text{tr } \gamma e + \frac{1}{c_p} s, \quad (9)$$

where  $C_s = C + c_p \gamma \otimes \gamma$  is the tensor of isentropic stiffness.

## IV. THE CORRESPONDENCE

Comparing (1) with (6), (2) with (9), (4) with (8), and (5) with (7), we can clearly see that the two physical theories are in complete correspondence if we make the identifications between variables and material parameters as follows:

Thermoelastic      Poroelastic

|                                |                                    |
|--------------------------------|------------------------------------|
| $\tau, \mathbf{e}, \mathbf{C}$ | $\tau, \mathbf{e}, \mathbf{C}_s$   |
| $\theta$                       | $p$                                |
| $s$                            | $\zeta$                            |
| $c_p$                          | $\frac{1}{M}$                      |
| $c_p$                          | $\frac{1}{M} + \frac{\alpha^2}{K}$ |
| $\beta$                        | $\frac{\alpha}{3K} \mathbf{I}$     |
| $\gamma$                       | $\alpha M \mathbf{I}$              |
| $C_s$                          | $C_c$                              |

The case most directly analogous to the poroelastic situation is one in which the coefficients of thermal expansion are identical, so that the tensor of expansion coefficients is isotropic with  $\beta = \beta \mathbf{I}$ , for which

$$c_p - c_w = 9K\beta^2. \quad (10)$$

The confined or saturated bulk modulus  $K_c$  corresponds to the isentropic or adiabatic modulus  $K_s$ , and conversely the frame modulus of the porous medium corresponds to the isothermal modulus of the thermoelastic medium. The ratios formed from the two pairs of bulk moduli follow from the table above and previously mentioned identities as

$$\frac{K_c}{K} = 1 + \frac{\alpha^2 M}{K}, \quad \frac{K_s}{K} = \frac{c_p}{c_w}. \quad (11)$$

The first of these identities is associated with Gassmann<sup>10</sup> and the second is a well known result in the thermodynamics of solids and gases.

## V. INHOMOGENEOUS POROUS MEDIA

Consider a porous medium for which the material parameters vary from point to point, where a "point" means a volume large enough relative to the pore length scale that the continuum theory of poroelasticity applies. Thus, the material parameters  $C$ ,  $\alpha$ , and  $M$  are functions of position. The spatial nonuniformity may result from variation of any or all of the secondary parameters  $\phi$ ,  $K_s$ , and  $K_p$ , or it may result from a nonuniform microstructure which causes  $K$  to vary even as  $\phi$  and  $K_s$  remain relatively fixed. For instance, the intergranular contact in sandstones may deteriorate with age resulting in a "softer" frame, although the

porosity and the grains themselves are unchanged. A fairly common situation, but one of significant importance, is that in which the frame parameters are constant but the fluid compressibility varies significantly, as for instance, when the frame is saturated with both water and gas. The large disparity in the two compressibilities can lead to an enormous range in the value of  $M$ , especially if the frame is relatively "stiff."

In any event, one can define an effective poroelastic medium such that the effective medium is characterized by the macroscopic material parameters  $C^*$ ,  $\alpha^*$ , and  $M^*$ . These may be defined by the macroscopic response of a sample subject to different boundary conditions. Thus, the frame modulus  $K^*$  follows by applying a confining pressure while the fluid is permitted to drain. The effective confined or saturated bulk modulus, which follows from the Gassmann identity (11),

$$K_c^* = K^* + \alpha^{*2} M^*, \quad (12)$$

may be measured by sealing the boundary pores. The parameter  $\alpha^*$  could be determined from the change in volume for a given applied pore pressure. In each separate *gedanken* experiment the equilibrium conditions (1) must be satisfied everywhere.

In general, the effective medium can only be defined if the length scales of the external forcing far exceed the length scales of the spatial inhomogeneity. An important and highly practical example is the propagation of compressional seismic waves through fluid-saturated porous rock. Typically, the wavelength is on the order of tens or hundreds of meters. The relevant modulus for the compressional wave speed in an effectively isotropic medium is  $K_c^* + 4\mu^*$ , where  $\mu^*$  is the effective shear modulus.

Effective parameters,  $K^*$ ,  $K_c^*$ ,  $\beta^*$ , etc., may also be defined for an inhomogeneous thermoelastic medium in the same manner. In this case the equilibrium conditions (6) must hold at every point. The correspondence between the two theories implies that the effective properties of the porous medium are related in the same manner as before to the effective thermoelastic properties. This connection can be used to advantage in predicting the effective properties of porous media. In a recent paper, Berryman and Milton<sup>3</sup> showed that the value of  $\alpha^*$  can be simply related to the effective frame bulk modulus  $K^*$  in an isotropic two-phase medium. They first derived this result within the context of poroelasticity without reference to thermoelasticity, and then pointed out the analogy between  $(\alpha/3K)$  and the thermal expansion coefficient  $\beta$ , and the fact that results are known concerning the effective thermal expansion coefficient in terms of the effective bulk modulus.<sup>11-13</sup> Berryman and Milton also derived an expression for  $M^*$  from the equations of poroelasticity for an inhomogeneous medium, and they remarked that "nothing comparable appears likely in the equations for thermoelasticity". However, it follows from the intimate correspondence that we have delineated between the thermoelastic parameters and those of poroelasticity that the question of determining  $\alpha^*$  and  $M^*$  is directly related to that of finding  $\beta^*$  and  $c_p^*$  in an

inhomogeneous thermoelastic medium. The two pertinent correspondences are

$$\beta \leftrightarrow \frac{\alpha}{3K}, \quad c_v \leftrightarrow \frac{1}{M}. \quad (13)$$

Specifically, we can make use of any existing results for the effective thermal expansion coefficient  $\beta^*$  in order to find  $\alpha^*$ , and in the same manner results for  $c_p^*$  are directly applicable to  $M^*$ .

It turns out that there already exists a fairly large literature on the effective thermoelastic behavior of composite materials,<sup>11-13</sup> a good review of which may be found in Christensen's book.<sup>7</sup> In particular, results are available on both  $\beta^*$  and  $c_p^*$  for macroscopically isotropic two-component media. Denoting the two phases by suffices 1 and 2, the effective thermal expansion coefficient is related to the effective bulk modulus by the well-known identity<sup>3,7,11</sup>

$$\beta^* - \langle \beta \rangle = \left[ (\beta_1 - \beta_2) / \left( \frac{1}{K_1} - \frac{1}{K_2} \right) \right] \left( \frac{1}{K^*} - \frac{1}{K} \right), \quad (14)$$

where  $\langle \rangle$  denotes the spatial average. The effective heat capacity at constant strain follows from Rosen and Hashin<sup>13</sup> and Christensen<sup>7</sup> as

$$c_p^* - \langle c_p \rangle = 9 \left[ (\beta_1 - \beta_2) / \left( \frac{1}{K_1} - \frac{1}{K_2} \right) \right] (\beta^* - \langle \beta \rangle). \quad (15)$$

Relation (10) between the heat capacities then implies that the effective heat capacity at constant strain is given by

$$\frac{1}{9} (c_v^* - \langle c_v \rangle) = \left[ (\beta_1 - \beta_2) / \left( \frac{1}{K_1} - \frac{1}{K_2} \right) \right] \times (\beta^* - \langle \beta \rangle) - K^* \beta^{*2} + \langle K \beta^2 \rangle. \quad (16)$$

Substituting from (13) into (14) and (16) yields the exact results for the effective poroelastic parameters

$$\alpha^* - \langle \alpha \rangle = \left( \frac{\alpha_1 - \alpha_2}{K_1 - K_2} \right) (K^* - \langle K \rangle), \quad (17)$$

$$\frac{1}{M^*} - \frac{1}{M} = - \left( \frac{\alpha_1 - \alpha_2}{K_1 - K_2} \right) (\alpha^* - \langle \alpha \rangle).$$

The first identity in (17) agrees with Eq. (27) of Berryman and Milton,<sup>3</sup> while their equation (45) is exactly the same as the second identity of (17). We note that it is possible to define effective microstructural parameters for an inhomogeneous poroelastic medium<sup>3,6</sup> that are analogous to the grain modulus  $K_g$  of a uniform medium, for instance. The values of these moduli for the inhomogeneous medium may be determined from the effective parameters  $\alpha$  and  $M$ . Details of the procedure may be gleaned from Ref. 3.

Finally, we note some consequences of (17). It is well known that  $K^* < \langle K \rangle$  for any inhomogeneous isotropic solid<sup>7</sup> and therefore it follows from (17) that

$$M^* < \frac{1}{M}, \quad (18)$$

with equality if and only if  $\alpha_1 = \alpha_2$ . The effective confined bulk modulus follows from (12) and (17) as

$$K_c^* = K^* + \frac{[\langle \alpha \rangle (K_1 - K_2) - (\langle K \rangle - K^*) (\alpha_1 - \alpha_2)]^2}{\frac{1}{\langle M \rangle} (K_1 - K_2)^2 + (\langle K \rangle - K^*) (\alpha_1 - \alpha_2)^2}. \quad (19)$$

Note that  $M$  enters only through its harmonic average. The explicit relation (19) has two simpler limits

$$K_c^* = \begin{cases} K^* + \alpha^2 \left[ \frac{1}{\langle M \rangle} \right]^{-1}, & \alpha_1 = \alpha_2 (= \alpha), \\ K + \langle \alpha \rangle^2 \left[ \frac{1}{\langle M \rangle} \right] + S_0 (\langle \alpha^2 \rangle - \langle \alpha \rangle^2)^{-1}, & K_1 = K_2 (= K). \end{cases} \quad (20)$$

where

$$S_0 = \lim_{|K_1 - K_2| \rightarrow 0} \frac{\langle K \rangle - K^*}{\langle K^2 \rangle - \langle K \rangle^2}. \quad (21)$$

Both limits include the case of a uniform frame,  $\alpha_1 = \alpha_2$  and  $K_1 = K_2$ . The second limit is, on the face of it, quite interesting because it says that the saturated response depends upon the elastic moduli in a nontrivial way even though the moduli are uniform. The analogous situation in thermoelasticity is when the expansion coefficient varies from point to point while the elastic moduli are constant. The effective expansion coefficient is then simply the average, but the effective heat capacity depends upon the particular spatial distribution of  $\beta$ . One situation for which the compliance  $S_0$  may be explicitly calculated is when the shear moduli of the two phases are equal. In this case, as noted by Berryman and Milton,<sup>3</sup> the effective bulk modulus  $K^*$  can be determined precisely for any  $K(\mathbf{x})$  by using the identity due to Hill,<sup>14</sup>  $K^* + \frac{4}{3}\mu = (\langle (K + \frac{4}{3}\mu)^{-1} \rangle)^{-1}$ . Applying this to (21), we find  $S_0 = (K + \frac{4}{3}\mu)^{-1}$ .

## VI. CONCLUSION

Comparison of the static constitutive relations of poroelasticity and thermoelasticity shows they are formally the same if we identify pore fluid pressure with temperature,

and the relative fluid compression,  $\zeta$ , with entropy. Similarly, the dry frame elastic moduli of a porous medium are related to the isothermal moduli of the thermoelastic medium, and the saturated or confined moduli correspond to the isentropic elastic response. The issue of estimating the effective parameters of an inhomogeneous porous medium can thus be immediately translated into the analogous problem for the thermoelastic medium. The problem of finding the frame or isothermal moduli is the same for both, and the remaining macroscopic material parameters can be related to the effective thermal expansion coefficients and the effective heat capacity for the thermoelastic solid. Simple, explicit formulae exist for these quantities in a two component isotropic medium, leading to the relations previously found by Berryman and Milton<sup>3</sup> by a somewhat more complicated method. Other results in the literature for transversely isotropic thermoelastic materials, for instance Ref. 7, could be readily transferred to the poroelastic problem.

## ACKNOWLEDGMENTS

This work was completed while the author was a visitor at Schlumberger-Doll Research Laboratories, Ridgefield, CT. The assistance of David Johnson of SDR is gratefully acknowledged.

<sup>1</sup>M. A. Biot, *J. Appl. Phys.* **33**, 1482 (1962).

<sup>2</sup>G. Bonnet, *J. Acoust. Soc. Am.* **82**, 1758 (1987).

<sup>3</sup>J. G. Berryman and G. Milton, *Geophysics* (to be published).

<sup>4</sup>D. S. Chandrasekharaiah and S. C. Cowin, *J. Elasticity* **21**, 121 (1989).

<sup>5</sup>R. W. Zimmerman, W. H. Somerton, and M. S. King, *J. Geophys. Res.* **91**, 12765 (1986).

<sup>6</sup>R. J. S. Brown and J. Korringa, *Geophysics* **40**, 608 (1975).

<sup>7</sup>R. M. Christensen, *Mechanics of Composite Materials* (Wiley, New York, 1979).

<sup>8</sup>W. Nowacki, *Dynamic Problems in Thermoelasticity* (Noordhoff, Leyden, 1975).

<sup>9</sup>D. S. Chandrasekharaiah, *Appl. Mech. Rev.* **39**, 355 (1986).

<sup>10</sup>F. Gassmann, *Vierteljahrsschr. Naturforsch. Ges. Zurich* **96**, 1 (1951).

<sup>11</sup>J. L. Cribb, *Nature* **220**, 576 (1968).

<sup>12</sup>V. M. Levin, *Mech. Solids* **2**, 58 (1967).

<sup>13</sup>B. W. Rosen and Z. Hashin, *Int. J. Eng. Sci.* **8**, 157 (1970).

<sup>14</sup>R. Hill, *J. Mech. Phys. Solids* **32**, 149 (1963).