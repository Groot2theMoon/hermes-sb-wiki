---
source_url: ""
ingested: 2026-04-28
sha256: e5a5ad7e1fb1b6692a84f1d89dca4f9aa5bc5814d06be54201c1ed93311f5e76
---


# Mechanics of Layered Anisotropic Poroelastic Media with Applications to Effective Stress for Fluid Permeability

James G. Berryman<sup>1,\*</sup>

<sup>1</sup>*University of California, Lawrence Berkeley National Laboratory,  
One Cyclotron Road MS 90R1116, Berkeley, CA 94720, USA*

## Abstract

The mechanics of vertically layered porous media has some similarities to and some differences from the more typical layered analysis for purely elastic media. Assuming welded solid contact at the solid-solid interfaces implies the usual continuity conditions, which are continuity of the horizontal strain components and the vertical stress components. These conditions are valid for both elastic and poroelastic media. Differences arise through the conditions for the pore pressure and the increment of fluid content in the context of fluid-saturated porous media. The two distinct conditions most typically considered between any pair of contiguous layers are: (1) an undrained fluid condition at the interface, meaning that the increment of fluid content is zero (*i.e.*,  $\delta\zeta = 0$ ), or (2) fluid pressure continuity at the interface, implying that the change in fluid pressure is zero across the interface (*i.e.*,  $\delta p_f = 0$ ). Depending on the types of measurements being made on the system and the pertinent boundary conditions for these measurements, either (or neither) of these two conditions might be directly pertinent. But these conditions are sufficient nevertheless to be used as thought experiments to determine the expected values of all the poroelastic coefficients. For quasi-static mechanical changes over long time periods, we expect drained conditions to hold, so the pressure must then be continuous. For high frequency wave propagation, the fluid typically acts essentially as if it were undrained – or nearly so, with vanishing of the fluid increment at the boundaries being appropriate. The paper treats the poroelastic analysis of both these end-member cases in detail, and also develops the general equations for a variety of applications to heterogeneous porous media, including applications with mixed fluid-boundary conditions – since general layered and heterogeneous systems are expected to have potentially different boundary conditions in different (horizontal versus vertical) directions. Effective stress for the fluid permeability of such poroelastic systems is also treated, but limited to the permeabilities characteristic of granular media or tubular pore shapes for this initial treatment.

---

\*JGBerryman@LBL.GOV

## 1. Introduction

Poroelastic analysis [1-8] usually progresses from assumed knowledge of dry or drained porous media to the predicted behavior of fluid-saturated and undrained porous media. This class of problems is characterized by a single upscaling step, taking the homogeneous fluid and solid constituent properties and deducing the macroscopic behavior of such systems. In recent work [9], the author has shown in detail how the poroelastic coefficients are related to the microstructural constants of the solid constituents when the overall behavior varies from isotropic to orthotropic. The focus of the present work is on layered poroelastic materials, which are therefore heterogeneous at the mesoscale. Each layer is assumed to satisfy the assumptions of the class of problems considered in reference [9].

The main issue addressed here concerns how the interface boundary conditions between anisotropic porous layers should be treated. For very low frequency (say quasi-static) analysis, this issue is clear since then the boundary conditions must be drained conditions and therefore the fluid pressure is continuous across the boundary. However, for high frequency wave propagation, it is expected to be more appropriate to treat the system as locally undrained, since the pressure of the pore-fluid does not have time to equilibrate via the drainage mechanism, which can take much longer than is appropriate to these quasi-static analyses. The most accurate way to treat these situations is to consider the variables to be frequency dependent and complex. This approach has been taken for example by Pride *et al.* [10-12] for mixtures of isotropic poroelastic materials. But the problem becomes harder for the anisotropic case, as there are simple exact results for the two-isotropic-component case, but simple results are not available for the anisotropic problems. And more importantly, the interest in layered media is not just for two-component examples, but ultimately for multi-component layered media. So it is important to consider these cases separately, as is done here.

The analysis is restricted to anisotropic systems. The nature of the grains themselves composing the solid frame material will not be a focus of the present paper. This issue does matter, but it is most important for determining the relationship between the grain constants and the off-diagonal coefficients that are called the  $\beta$ 's in this formulation. These issues have been fully addressed in the earlier contribution of the author [9], and will therefore not be treated again in this paper. Our focus here is on heterogeneous poroelastic media when the

heterogeneity is well-represented via layered porous-medium modeling.

## 2. Basics of Anisotropic Poroelasticity

### 2.1 Orthotropic poroelasticity

If the overall porous medium is anisotropic either due to some preferential alignment of the constituent particles or due to externally imposed stress (such as a gravity field and weight of overburden, for example), we consider the orthorhombic anisotropic version of the poroelastic equations:

$$\begin{pmatrix} e_{11} \\ e_{22} \\ e_{33} \\ -\zeta \end{pmatrix} = \begin{pmatrix} s_{11} & s_{12} & s_{13} & -\beta_1 \\ s_{12} & s_{22} & s_{23} & -\beta_2 \\ s_{13} & s_{23} & s_{33} & -\beta_3 \\ -\beta_1 & -\beta_2 & -\beta_3 & \gamma \end{pmatrix} \begin{pmatrix} \sigma_{11} \\ \sigma_{22} \\ \sigma_{33} \\ -p_f \end{pmatrix}. \quad (1)$$

From here on throughout most of the paper, we drop the  $\delta$ 's from the stresses and strains, as this extra notation is truly redundant when they are all being treated as small (and therefore resulting in linear effects) as we do here, for small deviations from an initial rest state.

The  $e_{ii}$  (no summation over repeated indices) are strains in the  $i = 1, 2, 3$  directions. The  $\sigma_{ii}$  are the corresponding stresses, assumed to be positive in tension. The fluid pressure is  $p_f$ , which is positive in compression. The increment of fluid content is  $\zeta$ , and is often defined via:

$$\zeta \equiv \frac{\delta(\phi V) - \delta V_f}{V} \simeq \phi \left( \frac{\delta V_\phi}{V_\phi} - \frac{\delta V_f}{V_f} \right), \quad (2)$$

where  $V = V_\phi/\phi \simeq V_f/\phi$  is the pertinent local volume (within a layer in present circumstances) of the initially fully fluid-saturated porous layer at the first instant of consideration,  $V_\phi = \phi V$  is the corresponding pore volume, with  $\phi$  being the fluid-saturated porosity of the same volume.  $V_f$  is the volume occupied by the pore-fluid, so that  $V_f = \phi V$  before any new deformations begin. The  $\delta$ 's indicate small changes in the quantities immediately following them. For “drained” systems, there would ideally be a reservoir of the same fluid just outside the volume  $V$  that can either supply more fluid or absorb any excreted fluid as needed during the nonstationary phase of the poroelastic process. The amount of pore fluid (*i.e.*, the number of fluid molecules) can therefore either increase or decrease from that of the initial amount of pore fluid; at the same time, the pore volume can also be changing, but — in

general — not necessarily at exactly the same rate as the pore fluid itself. The one exception to these statements is when the surface pores of the layer volume  $V$  are sealed, in which case the layer is “undrained” and  $\zeta \equiv 0$ , identically. In such circumstances, it is still possible that both  $V_f$  and  $V_\phi = \phi V$  are changing; but, because of the imposed undrained boundary conditions, they are necessarily changing at the same rate. The drained compliances are  $s_{ij} = s_{ij}^d$ , with or without the  $d$  superscript.

Undrained compliances (not yet shown) are symbolized by  $s_{ij}^u$ .

Coefficients

$$\beta_i = s_{i1} + s_{i2} + s_{i3} - 1/3K_R^g, \quad (3)$$

where  $K_R^g$  is again the Reuss average modulus of the grains. The drained Reuss average bulk modulus is defined by

$$\frac{1}{K_R^d} = \sum_{ij=1,2,3} s_{ij}^d. \quad (4)$$

For the Reuss average [13] undrained bulk modulus  $K_R^u$ , we have drained compliances replaced by undrained compliances in a formula analogous to (4). A similar definition of the effective grain modulus  $K_R^g$  is:

$$\frac{1}{K_R^g} = \sum_{ij=1,2,3} s_{ij}^g, \quad (5)$$

with grain compliances replacing drained compliances as discussed earlier by Berryman [9]. The alternative Voigt [14] average (also see [15]) of the stiffnesses will play no role in the present work. And, finally,  $\gamma = \sum_{i=1,2,3} \beta_i / BK_R^d$ , where  $B$  is the second Skempton [16] coefficient, which will be defined carefully again later in our discussion.

The shear terms due to twisting motions (*i.e.*, strains  $e_{23}$ ,  $e_{31}$ ,  $e_{12}$  and stresses  $\sigma_{23}$ ,  $\sigma_{31}$ ,  $\sigma_{12}$ ) are excluded from this poroelastic discussion since they typically do not couple to the modes of interest for anisotropic systems having orthotropic symmetry, or any more symmetric system such as those being either transversely isotropic or isotropic. We have also assumed that we know the true axes of symmetry, and make use of them in our formulation of the problem. Note that the  $s_{ij}$ ’s are the elements of the compliance matrix  $\mathbf{S}$  and are all independent of the fluid, and therefore would be the same if the medium were treated as elastic (*i.e.*, by ignoring the fluid pressure, or assuming that the fluid saturant is air — or vacuum). In keeping with the earlier discussions, we typically call these compliances the drained compliances and the corresponding matrix the drained compliance matrix  $\mathbf{S}^d$ , since the fluids do not contribute to the stored mechanical energy if they are free to drain

into a surrounding reservoir containing the same type of fluid. In contrast, the undrained compliance matrix  $\mathbf{S}^u$  presupposes that the fluid is trapped (unable to drain from the system into an adjacent reservoir) and therefore contributes in a significant and measurable way to the compliance and stiffness ( $\mathbf{C}^u = [\mathbf{S}^u]^{-1}$ ), and also therefore to the stored mechanical energy of the undrained system.

Although the significance of the formula is somewhat different now, we find again that

$$\beta_1 + \beta_2 + \beta_3 = \frac{1}{K_R^d} - \frac{1}{K_R^g} = \frac{\alpha_R}{K_R^d} \quad (6)$$

if we also define (as we did for the isotropic case) a Reuss effective stress coefficient:

$$\alpha_R \equiv 1 - K_R^d/K_R^g. \quad (7)$$

Furthermore, we have

$$\gamma = \frac{\beta_1 + \beta_2 + \beta_3}{B} = \frac{\alpha_R}{K_R^d} + \phi \left( \frac{1}{K_f} - \frac{1}{K_R^\phi} \right), \quad (8)$$

since we have the rigorous result in this notation [3,16] that Skempton's  $B$  coefficient is given by

$$B \equiv \frac{1 - K_R^d/K_R^u}{1 - K_R^d/K_R^g} = \frac{\alpha_R/K_R^d}{\alpha_R/K_R^d + \phi(1/K_f - 1/K_R^\phi)}. \quad (9)$$

Note that both (8) and (9) contain dependence on the distinct pore bulk modulus  $K_R^\phi$  that comes into play when the pores are heterogeneous [3], regardless of whether the system is isotropic or anisotropic. We emphasize that all these formulas are rigorous statements based on the earlier anisotropic analyses. The appearance of both the Reuss average quantities  $K_R^d$  and  $\alpha_R$  is not an approximation, but merely a useful choice of notation.

### 2.2 Determining off-diagonal $\beta_i$ coefficients

We will now provide several results for the  $\beta_i$  coefficients, and then follow the results with a general proof of their correctness.

In many useful and important cases, the coefficients  $\beta_i$  are determined by

$$\beta_i = s_{i1}^d + s_{i2}^d + s_{i3}^d - \frac{1}{3K_R^g}. \quad (10)$$

Again,  $K_R^g$  is the Reuss average of the grain modulus, since the local grain modulus is not necessarily assumed uniform here as discussed previously. Equation (10) holds as written

for homogeneous grains, such that  $K_R^g = K^g$ . It also holds true for the case when  $K_R^g$  is determined instead [19] by

$$\frac{1}{K_R^g} \equiv \sum_{m=1,\dots,n} \frac{v_m}{K_m}, \quad (11)$$

where  $v_m$  is the volume fraction (out of all the solid material present, so that  $\sum_m v_m = 1$ ). However, when the grains themselves are anisotropic, we need to allow again for this possibility, and this can be accomplished by defining three directional grain bulk moduli determined by:

$$\frac{1}{3\overline{K}_i^g} \equiv s_{1i}^g + s_{i2}^g + s_{i3}^g = s_{1i}^g + s_{2i}^g + s_{3i}^g, \quad (12)$$

for  $i = 1, 2, 3$ . The second equality follows because the compliance matrix is always symmetric. We call these quantities in (12) the “partial grain-compliance sums,” and the  $\overline{K}_i^g$  are the directional grain bulk moduli. Note that the factors of three have again been correctly accounted for because

$$\sum_{i=1,2,3} \frac{1}{3\overline{K}_i^g} = \frac{1}{K_R^g}, \quad (13)$$

in agreement with (5).

We can also simplify and symmetrize our notation somewhat by introducing a similar concept for the drained constants, so that

$$\frac{1}{3\overline{K}_i^d} \equiv s_{1i}^d + s_{i2}^d + s_{i3}^d = s_{1i}^d + s_{2i}^d + s_{3i}^d, \quad (14)$$

for  $i = 1, 2, 3$ . Then, the formula for (10) is replaced by

$$\beta_i = \frac{1}{3\overline{K}_i^d} - \frac{1}{3\overline{K}_i^g}. \quad (15)$$

If the three contributions represented by (12) for  $i = 1, 2, 3$  happen to be equal, then clearly each equals one-third of the sum (13).

The preceding results are for perfectly aligned grains. If the grains are instead perfectly randomly oriented, then it is clear that the formulas in (10) hold as before, but now  $K_R^g$  is determined instead by (5).

All of these statements about the  $\beta_i$  are easily proven by considering the situation when  $\sigma_{11} = \sigma_{22} = \sigma_{33} = -p_c = -p_f$ . Because then, from (1), we have:

$$-e_{ii} = \frac{1}{3\overline{K}_i^d} p_c + \beta_i (-p_f) = (s_{1i}^g + s_{i2}^g + s_{i3}^g) p_f \equiv \frac{p_f}{3\overline{K}_i^g}, \quad (16)$$

in the most general of the three cases discussed, and holding true for each value of  $i = 1, 2, 3$ . This is a statement about the strain  $e_{ii}$  that would be observed in this situation, as it must be the same if these anisotropic (or inhomogeneous) grains were immersed in the fluid, while measurements were taken of the strains observed in each of the three directions  $i = 1, 2, 3$ , during variations of the fluid pressure  $p_f$ . We may consider this proof to be a thought experiment for determining these coefficients, in the same spirit as those proposed originally by Biot and Willis [2,17] for the isotropic and homogeneous case.

### 2.3 The $\beta_i$ coefficients and effective stress

Making use of our previous definitions, it is easy to see that the coefficients  $\beta_i$  are closely related to different sort of effective stress coefficient, for the individual principal strain coefficients:

$$e_{ii} = -\frac{1}{3K_i^d}(p_c - D_i p_f), \quad \text{for } i = 1, 2, 3, \quad (17)$$

where

$$D_i = 3\overline{K}_i^d \beta_i = 1 - \frac{\overline{K}_i^d}{K_i^g}, \quad \text{for } i = 1, 2, 3, \quad (18)$$

and  $-p_c = \sigma_{11} = \sigma_{22} = \sigma_{33}$  in the case of uniform applied confining pressure  $p_c$ . Then clearly, the  $D_i$ 's are completely analogous to the usual Biot (or Biot-Willis [2,17]) coefficient  $\alpha_R = 1 - K_R^d/K_R^g$  commonly defined for isotropic poroelasticity.

### 2.4 Coefficient $\gamma$

The relationship of coefficient  $\gamma$  to the other coefficients is easily established because we have already discussed the main issue, which involves determining the role of the various other constants contained in Skempton's coefficient  $B$  [16]. This result is

$$B = \left( \frac{1}{K_R^d} - \frac{1}{K_R^g} \right) \left[ \left( \frac{1}{K_R^d} - \frac{1}{K_R^g} \right) + \phi \left( \frac{1}{K_f} - \frac{1}{K_R^\phi} \right) \right]^{-1} \quad (19)$$

Again, from (1), we find that

$$-\zeta = 0 = -(\beta_1 + \beta_2 + \beta_3) \sigma_c - \gamma p_f, \quad (20)$$

for undrained boundary conditions. Thus, we find again that

$$\frac{p_f}{p_c} \equiv B = \frac{\beta_1 + \beta_2 + \beta_3}{\gamma}, \quad (21)$$

where  $p_c = -\sigma_c$  is the confining pressure. Thus, the scalar coefficient  $\gamma$  is determined immediately and given by

$$\gamma = \frac{\beta_1 + \beta_2 + \beta_3}{B} = \frac{\alpha_R/K_R^d}{B} = \alpha_R/K_R^d + \phi \left( \frac{1}{K_f} - \frac{1}{K_R^\phi} \right). \quad (22)$$

Alternatively, we could say that

$$B = \frac{\alpha_R}{\gamma K_R^d}. \quad (23)$$

We have now determined the physical/mechanical significance of all the coefficients in the poroelastic matrix (1). These results are as general as possible without considering poroelastic symmetries that have less than orthotropic symmetry, while also taking advantage of our assumption that we do typically know the three directions of the principal axes of symmetry.

### 2.5 Inverting poroelastic compliance

Being in compliance form, the matrix in (1) has extremely simple poroelastic behavior in the sense that all the fluid mechanical effects appear only in the single coefficient  $\gamma$ . We can simplify the notation a little more by lumping some coefficients together, combining the  $3 \times 3$  submatrix in the upper left corner of the matrix in (1) as **S**, and defining the column vector **b** by

$$\mathbf{b}^T \equiv (\beta_1, \beta_2, \beta_3). \quad (24)$$

The resulting  $4 \times 4$  matrix and its inverse are now related by:

$$\begin{pmatrix} \mathbf{S} & -\mathbf{b} \\ -\mathbf{b}^T & \gamma \end{pmatrix} = \begin{pmatrix} \mathbf{A} & \mathbf{q} \\ \mathbf{q}^T & z \end{pmatrix}^{-1}, \quad (25)$$

where the elements of the inverse matrix can be shown to be written in terms of drained stiffness matrix  $\mathbf{C}^d = \mathbf{C} = \mathbf{S}^{-1}$  by introducing three components: (a) scalar  $z = [\gamma - \mathbf{b}^T \mathbf{C} \mathbf{b}]^{-1}$ , (b) column vector  $\mathbf{q} = z \mathbf{C} \mathbf{b}$ , and (c) undrained  $3 \times 3$  stiffness matrix (*i.e.*, the pertinent one connecting the principal strains to principal stresses) is given by  $\mathbf{A} = \mathbf{C} + z \mathbf{C} \mathbf{b} \mathbf{b}^T \mathbf{C} = \mathbf{C}^d + z^{-1} \mathbf{q} \mathbf{q}^T \equiv \mathbf{C}^u$ , since  $\mathbf{C}^d$  is drained stiffness and  $\mathbf{A} = \mathbf{C}^u$  is clearly undrained stiffness by construction. This result is the same as that of Gassmann [1] for anisotropic porous media, although his results were presented in a form somewhat harder to scan than the form shown here.

Also, note the important fact that the observed decoupling of the fluid effects occurs only in the compliance form (1) of the equations, and never in the stiffness (inverse) form for the poroelasticity equations.

From these results, it is not hard to show that

$$\mathbf{S}^d = \mathbf{S}^u + \gamma^{-1} \mathbf{b} \mathbf{b}^T. \quad (26)$$

This result emphasizes the remarkably simple fact that the drained compliance matrix can be found directly from knowledge of the inverse of undrained stiffness, and the still unknown, but sometimes relatively easy to estimate, values of  $\gamma$ , together with the three distinct orthotropic  $\beta_i$  coefficients, for  $i = 1, 2, 3$ .

There are clearly many measurements required to determine all these various poroelastic coefficients. Furthermore, the strategy for finding the coefficients depends on available data sets, and whether the porous media of interest are constructed from a homogeneous or heterogeneous set of solid materials, and whether the individual grains are isotropic or anisotropic. It also makes some difference if the pores are round (for granular media) or flat (for fractured media). All these issues have been discussed previously at length, and this discussion will not be repeated here.

The remainder of the paper will concentrate on making use of the general poroelastic equations in situations where at least two and possibly many distinct layers of porous materials obeying these equations are under stress (either quasi-static or dynamic as would occur in a wave propagation scenario). As we will see, the layered poroelastic equations behave somewhat differently from layered elastic equations because there are two distinct additional boundary conditions (drained and undrained) that can occur depending on the details of the excitation itself.

## 3. Averaging Results for All Drained or All Undrained Boundary Conditions

The two most common boundary conditions to consider in poroelastic media are the drained and undrained conditions. Drained conditions imply that the fluid pressure change is zero while the increment of fluid content in the individual layers may be considered arbitrary. Of course, the total amount of fluid present needs to be properly conserved in the analysis we present, but the usual idea for drained conditions is that the poroelastic systems

is immersed in an infinite reservoir of fluid so that pore fluid is freely available to move in and out of the region of interest. For our present considerations, this situation implies that the layer increments  $\zeta$  can take arbitrary (small) values, but the fluid pressure is constrained to be a constant value  $p_f$  everywhere. So changes in  $p_f$  always vanish for drained conditions.

Undrained boundary conditions place the hard constraint on the fluid increment  $\zeta$ , requiring no flow at the boundaries, so  $\zeta = 0$  at all boundaries. These conditions ensure that the fluid pressure  $p_f$  does change, since as the boundaries move in or out the pressure on the confined fluid is increasing or decreasing.

Both of these conditions must be approximations to conditions in a generally realistic earth model. We can easily imagine situations where some boundaries between layers (the vertical direction) are plugged, so undrained boundary conditions  $\zeta_z \equiv 0$  might be correct while neighboring layers (horizontal direction) might be open to fluid flow (so  $\zeta_x$  and/or  $\zeta_y \neq 0$ ). We will consider these more general situations in the next section, but for now limit the analysis to that for either *all drained* conditions or *all undrained* conditions. All undrained conditions are also appropriate, as mentioned previously, regardless of the physical boundary conditions if the probe changing the physical variables is a passing high frequency acoustic or seismic wave train or pulse.

### 3.1 General analysis for layered poroelastic systems

We will now formulate the layered poroelastic earth problem in a way so that both of these standard boundary conditions can be imposed, as needed in any particular modeling problem.

Now we assume throughout the paper that the porous layers are stacked vertically (3- or  $z$ -axis) and for this geometry it is easy to see that the three horizontal strains  $e_{11}$ ,  $e_{22}$ , and  $e_{12}$  must be continuous if the layers are in solid-welded contact. Furthermore, the vertical stress  $\sigma_{33}$ , and rotational stresses involving the vertical direction  $\sigma_{13}$  and  $\sigma_{23}$  must also be continuous. These conditions follow from an assumption of welded contact between layers. If contact is not welded, then the system can have more complicated behaviors than we are considering here.

Appendix A summarizes the Backus [20] and/or Schoenberg-Muir [21] approach to elastic layer averaging. The method we present here is a slight generalization of this approach,

taking the presence of the fluid into account. For the drained situation, the influence of the fluid on the system mechanics is minimal (as we shall see). But we should nevertheless have this result available to compare it with the more interesting case of the undrained layers.

Although the shear moduli normally associated with the twisting shear components  $e_{23}$ ,  $e_{31}$ , and  $e_{12}$  usually do not interact with the pore-fluid itself in systems as symmetric or more symmetric than orthotropic, we nevertheless need to carry these terms along in the poroelastic formulation for layered systems because of possible boundary effects due to welded contact at interfaces. To accomplish this goal, we will generalize the form of equation (56) from the Appendix. In compliance form, the equations will relate the strains

$$E_T \equiv \begin{pmatrix} e_{11} \\ e_{22} \\ e_{12} \end{pmatrix}, \quad \text{and} \quad E_N \equiv \begin{pmatrix} e_{33} \\ e_{32} \\ e_{31} \end{pmatrix}, \quad (27)$$

and fluid increment  $\zeta$  to the stresses

$$\Pi_T \equiv \begin{pmatrix} \sigma_{11} \\ \sigma_{22} \\ \sigma_{12} \end{pmatrix}, \quad \text{and} \quad \Pi_N \equiv \begin{pmatrix} \sigma_{33} \\ \sigma_{32} \\ \sigma_{31} \end{pmatrix}, \quad (28)$$

and the fluid pressure change  $p_f$ .

The required general relationship is:

$$\begin{pmatrix} E_T \\ -\zeta \\ E_N \end{pmatrix} = \begin{pmatrix} \mathbf{S}_{TT} & -\mathbf{g}_{12} & \mathbf{S}_{TN} \\ -\mathbf{g}_{12}^T & \gamma & -\mathbf{g}_3^T \\ \mathbf{S}_{NT} & -\mathbf{g}_3 & \mathbf{S}_{NN} \end{pmatrix} \begin{pmatrix} \Pi_T \\ -p_f \\ \Pi_N \end{pmatrix}, \quad (29)$$

where, for example, in the orthotropic media considered here we have

$$\mathbf{S}_{TT} \equiv \begin{pmatrix} s_{11} & s_{12} & s_{16} \\ s_{21} & s_{22} & s_{26} \\ s_{61} & s_{62} & s_{66} \end{pmatrix} = \begin{pmatrix} s_{11} & s_{12} & \\ s_{21} & s_{22} & \\ & & s_{66} \end{pmatrix}, \quad (30)$$

$$\mathbf{S}_{NN} \equiv \begin{pmatrix} s_{33} & s_{34} & s_{35} \\ s_{43} & s_{44} & s_{45} \\ s_{53} & s_{54} & s_{55} \end{pmatrix} = \begin{pmatrix} s_{33} & & \\ & s_{44} & \\ & & s_{55} \end{pmatrix}, \quad (31)$$

and

$$\mathbf{S}_{NT} \equiv \begin{pmatrix} s_{31} & s_{32} & s_{36} \\ s_{41} & s_{42} & s_{46} \\ s_{51} & s_{52} & s_{56} \end{pmatrix} = \begin{pmatrix} s_{31} & s_{32} \\ 0 \\ 0 \end{pmatrix}, \quad (32)$$

with  $\mathbf{S}_{TN} = \mathbf{S}_{NT}^T$  (the  $T$  superscript indicates the matrix transpose). Here all these expressions for elastic compliance refer specifically to drained compliances  $s_{ij} = s_{ij}^d$ , for all  $i, j = 1, \dots, 6$  within each poroelastic anisotropic layer.

All the poroelastic contributions to (29) are determined by  $\gamma$ ,  $\mathbf{g}_{12}$ , and  $\mathbf{g}_3$ . The scalar  $\gamma$  within the  $7 \times 7$  matrix in (29) was defined earlier in (8), and is the only term in the  $7 \times 7$  matrix that includes fluid effects directly through  $K_f$ . The remaining pair of vectors contained within the  $7 \times 7$  matrix in (29) is defined by:

$$\mathbf{g}_{12}^T = (\beta_1, \beta_2, 0) \quad (33)$$

and

$$\mathbf{g}_3^T = (\beta_3, 0, 0), \quad (34)$$

where the  $\beta$ 's were defined previously following (1).

We now consider two examples of special uses of the general equation (29) for different choices of boundary conditions. These two physical circumstances covered in the cases considered are distinct end-members. For relatively high-frequency wave propagation, it is appropriate to consider that the fluids do not have time to equilibrate, and therefore fluid pressures can be different in distinct layers, while the fluid particles do not have time to move very far during wave passage time, so the fluid increment  $\zeta = 0$  essentially everywhere. This situation is called the “undrained” condition. An alternative condition is the fully drained condition, in which the fluid particles have as much time as they need to achieve fluid-pressure equilibration, so that  $p_f = \text{constant}$ . These two limiting situations are clearly connected physically via Darcy’s law, which provides the mechanism to move fluid particles, and ultimately to guarantee that the fluid pressure reaches an equilibrium state. Bringing Darcy’s law actively into play in the equations would result in Biot-style equations which are beyond our current scope. So we consider only the end-member conditions for our present contribution.

### 3.2 Drained scenario ( $p_f \equiv 0$ )

Now, recall that, in the drained scenario, changes in pore-fluid pressure are assumed to be zero (or at least negligibly small), so  $p_f \equiv 0$  in these equations. Accounting for this condition, the results should (and do) recover the Backus [20] and Schoenberg-Muir [21] results for the elastic parts of the system (found in Appendix A) exactly. Also, we find the additional (expected) result for the poroelastic case that the average fluid increment is:

$$\langle \zeta \rangle = \langle \beta_1 \sigma_{11} \rangle + \langle \beta_2 \sigma_{22} \rangle + \langle \beta_3 \rangle \sigma_{33}, \quad (35)$$

if  $\sigma_{33}$  is nearly constant. Or, if  $\sigma_{33}$  is not uniform from one layer to the next (as might happen due to weight of solid overburden pressure), then the third expression in (35) should be modified, by moving  $\sigma_{33}$  inside the averaging operator. So we have

$$\langle \zeta \rangle = \langle \beta_1 \sigma_{11} \rangle + \langle \beta_2 \sigma_{22} \rangle + \langle \beta_3 \sigma_{33} \rangle, \quad (36)$$

whenever  $\sigma_{33}$  taken to be constant is a poor approximation. The results shown in (35) and (36) are easy to reconcile with the definitions of the  $\beta$ 's, and the meaning of averaging operator  $\langle \cdot \rangle$  across all layers. When  $p_f$  vanishes everywhere, the final results for the averaging and the various stresses and strains are identical to the results in Appendix A. For the drained scenario, the only difference is the addition of equations (35) or (36).

### 3.3 Undrained scenario ( $\zeta \equiv 0$ )

Now consider that the fluid pressure might vary across the stack of layers (as should be expected to happen either because of hydrostatic overburden, or due to fluid injection or extraction at certain chosen depths). Then we can treat this case as well, assuming undrained circumstances, by averaging the fluid pressure itself via  $\langle p_f \rangle$ . In this case, some knowledge of the fluid-pressure distribution along the stack of layers would be required, as well as some information about whether the undrained condition applies at every interface, or just at some interfaces. Variations might occur if a sealing layer were present to close off flow at the top, or bottom. Both ends might be sealed for some range of porous layers forming a heterogeneous, layered anisotropic reservoir including cap rocks. For this undrained scenario, the fluid pressure in each undrained layer is free to vary compared to all the others; so there

is no constancy of  $p_f$  for this case. The averaging condition resulting from the formulation for such a reservoir according to (29) is:

$$\langle p_f \rangle = - \left\langle \frac{1}{\gamma} (\beta_1 \sigma_{11} + \beta_2 \sigma_{22}) \right\rangle + \left\langle \frac{\beta_3 \sigma_{33}}{\gamma} \right\rangle. \quad (37)$$

Proper choice of the range of depth for averaging will clearly depend on the details of each reservoir, and the type of physical probe being used. For example, either quarter- or half-wavelength for seismic waves, when used as the probe, would be typical choices of the averaging depth in this case.

While the preceding part of the averaging for undrained boundary conditions was straightforward, we still need to check what happens when averaging the remainder of the equations. We show the work in Appendix B leading to the general undrained result (75), but just quote the final answer here – being valid for each undrained layer in the overall system:

$$\begin{pmatrix} E_T \\ E_N \end{pmatrix} = \begin{pmatrix} \mathbf{S}_{TT}^u & \mathbf{S}_{TN}^u \\ \mathbf{S}_{NT}^u & \mathbf{S}_{NN}^u \end{pmatrix} \begin{pmatrix} \Pi_T \\ \Pi_N \end{pmatrix}, \quad (38)$$

where

$$\mathbf{S}_{TT}^u \equiv \begin{pmatrix} s_{11}^u & s_{12}^u & \\ s_{21}^u & s_{22}^u & \\ & & s_{66} \end{pmatrix}, \quad (39)$$

$$\mathbf{S}_{NN}^u \equiv \begin{pmatrix} s_{33}^u & & \\ & s_{44} & \\ & & s_{55} \end{pmatrix}, \quad (40)$$

and

$$\mathbf{S}_{NT}^u \equiv \begin{pmatrix} s_{31}^u & s_{32}^u & \\ 0 & & \\ & & 0 \end{pmatrix}, \quad (41)$$

while  $\mathbf{S}_{TN}^u = (\mathbf{S}_{NT}^u)^T$ . Once these definitions are used for the undrained matrices, the layer analysis for the system follows exactly the same steps as in Appendix A. Note that we arrived at these results in another (step-by-step) way in Appendix B in order to prove that this is the right answer for the undrained problem. Fortunately, the right answer is also the same as the intuitive answer.

## 4. Averaging Results for Mixed Fluid-Boundary Conditions

To make the poroelastic equations for layered systems as useful as possible, we need to introduce a more general concept of the increment of fluid content than has normally been used. Now we need to consider situations in which mixed fluid-boundary conditions apply, so that we might have “undrained” conditions in some directions (for example, perhaps  $\zeta_z = 0$  in the vertical direction) while we have other conditions that permit fluid to flow between cells (for example:  $\zeta_x \neq 0$  and/or  $\zeta_y \neq 0$  horizontally), which would then imply effective locally drained conditions in such directions. But, note that here is no presumption of  $\delta p_f = 0$  in any one cell under such mixed boundary conditions, since the presence of mixed boundaries implies that fluid trapping could then be happening over some complex set of connected cells, i.e. ones that communicate among themselves, but not with other cells. There might or might not be multiple sets of cells interconnected in ways to form other complicated groupings of undrained cells. We will term such groupings of cells (that together form an interconnected but overall undrained unit) “macro-undrained cell groupings.” For example, suppose that the pertinent boundary condition in the vertical direction is  $\zeta_z = 0$ , while flow is permitted between horizontal layers in the  $x$ -direction (so  $\zeta_x \neq 0$ ), but not in the  $y$ -direction (so  $\zeta_y = 0$  is again undrained in this direction).

Note, that for consistency and continuity, there must be corresponding boundary conditions between contiguous neighboring cells. Two neighbors that share a boundary must both have the same physical boundary condition at the shared boundary, so if cells  $c1$  and  $c2$  share an undrained boundary condition in the  $z$ -direction, then  $\zeta_z^{c1} = 0 = \zeta_z^{c2}$ . Likewise, two neighbors  $c3$  and  $c4$  that share a drained boundary condition in the  $x$ -direction must satisfy the continuity condition that  $\zeta_x^{c3}/2 = -\zeta_x^{c4}/2$ , since one-half of the fluid particles that move out of  $c3$  must be moving into cell  $c4$ , and the other half would simultaneously be moving into the neighboring cell on the opposite side that also has mutually drained boundary conditions.

This brief discussion shows that, although numerical implementation of the general method outlined is not out of the question, this proposed generalization of the poroelastic layer problem nevertheless quickly becomes too complicated for simple analysis. In particular, without placing some further restrictions on the classes of problems to be considered, we would have to deal with possible situations where, for example, we might have drained

conditions in the  $x$ -direction on the right-hand side, but undrained conditions on the left-hand side. Then, all the fluid movement along the  $x$ -direction would necessarily occur just in that one direction. Since the details then become very important and difficult to incorporate into a simple model, we will exclude such complicated types of problems from further consideration here. Instead we will assume for the sake of argument that all the boundary conditions in the  $x$ -direction are drained, and those in the  $z$ -direction are undrained, while those in the  $y$ -direction will be either all drained, or all undrained. This set of assumptions will give us two distinct scenarios, each of which permits flow of fluid along the  $x$ -axis, and no flow along the  $z$ -axis. When flow in the  $y$ -direction is constrained, we have a model that is similar to isolated tubes with fluid flowing along the length in the  $x$ -direction. When fluid flow in the  $y$ -direction is not constrained, we have a model with poroelastic horizontal planes, which can be viewed as fractured regions including asperities that determine the mechanical properties of the fracture itself..

For these more general situations, we need to reformulate the equations used for more typical situations (1), so that now we propose the modified equations:

$$\begin{pmatrix} e_{11} \\ e_{22} \\ e_{33} \\ -\zeta_x \\ -\zeta_y \\ -\zeta_z \end{pmatrix} = \begin{pmatrix} s_{11} & s_{12} & s_{13} & -\beta_1 \\ s_{12} & s_{22} & s_{23} & -\beta_2 \\ s_{13} & s_{23} & s_{33} & -\beta_3 \\ -\Delta_{11} & -\Delta_{12} & -\Delta_{13} & \gamma_1 \\ -\Delta_{21} & -\Delta_{22} & -\Delta_{23} & \gamma_2 \\ -\Delta_{31} & -\Delta_{32} & -\Delta_{33} & \gamma_3 \end{pmatrix} \begin{pmatrix} \sigma_{11} \\ \sigma_{22} \\ \sigma_{33} \\ -p_f \end{pmatrix}, \quad (42)$$

where

$$\Delta_{ij} = s_{ij} - 1/9K_R^g, \quad \text{for } i, j = 1, 2, 3, \quad (43)$$

and

$$\gamma_m = \frac{\Delta_{m1} + \Delta_{m2} + \Delta_{m3}}{B}, \quad \text{for } m = 1, 2, 3. \quad (44)$$

Note that the  $\Delta_{ij}$ 's are also symmetric in  $i$  and  $j$  subscripts, since the  $s_{ij}$ 's are symmetric. Clearly, we must in addition have the constraints on the totals  $\zeta = \zeta_x + \zeta_y + \zeta_z$ ,  $\gamma = \gamma_1 + \gamma_2 + \gamma_3$ , and  $\beta_m = \Delta_{1m} + \Delta_{2m} + \Delta_{3m}$  for  $m = 1, 2, 3$  in order to be consistent with the earlier formulations and results for the usual boundary conditions; and these facts are all easily verified.

Some further definitions that might be helpful later are:

$$Z = \begin{pmatrix} \zeta_x \\ \zeta_y \\ \zeta_z \end{pmatrix}, \quad (45)$$

$$\Gamma = \begin{pmatrix} \gamma_1 \\ \gamma_2 \\ \gamma_3 \end{pmatrix}, \quad (46)$$

$$\mathbf{G}_{12}^T = \begin{pmatrix} \Delta_{11} & \Delta_{12} & 0 \\ \Delta_{21} & \Delta_{22} & 0 \\ \Delta_{31} & \Delta_{32} & 0 \end{pmatrix}, \quad (47)$$

and

$$\mathbf{G}_3^T = \begin{pmatrix} \Delta_{13} & 0 & 0 \\ \Delta_{23} & 0 & 0 \\ \Delta_{33} & 0 & 0 \end{pmatrix}, \quad (48)$$

With these definitions, equation (29) can be updated and generalized to:

$$\begin{pmatrix} E_T \\ -Z \\ E_N \end{pmatrix} = \begin{pmatrix} \mathbf{S}_{TT} & -\mathbf{G}_{12} & \mathbf{S}_{TN} \\ -\mathbf{G}_{12}^T & \Gamma & -\mathbf{G}_3^T \\ \mathbf{S}_{NT} & -\mathbf{G}_3 & \mathbf{S}_{NN} \end{pmatrix} \begin{pmatrix} \Pi_T \\ -p_f \\ \Pi_N \end{pmatrix}. \quad (49)$$

We can now study many of the most interesting problems involving fluid injection into complex heterogeneous, layered porous systems, with mixed boundary conditions.

## 5. Application to Effective Stress for Fluid Permeability of Granular Systems or Tubular Pores

Following Reference [24], we know that Darcy's constant  $k$  for the fluid permeability has dimensions of length squared, so a uniform shrinking or swelling of an isotropic porous medium changes the value of the isotropic permeability by a factor proportional to  $V^{2/3}$  (volume to the two-thirds power, since volume has dimensions of length cubed). For anisotropic permeability of the orthotropic porous media under consideration, we need to make some assumptions about the strain dependence of the principal permeability components:  $k_{11}$ ,

$k_{22}$ , and  $k_{33}$ . First we assume that these three components are in fact the eigenvalues of the permeability tensor, and that the axes are aligned with axes of the orthotropic system itself. These assumptions can be modified as needed in later discussions, but for first considerations, they should be adequate for our purposes.

Many models of fluid permeability are in use, including those in References [24-27]. We shall make use of the formula (and analogous ones for directions 2 and 3):

$$k_{11} = \frac{\phi_1^2}{2s_1^2 F_1}, \quad (50)$$

where  $\phi_1$  is an apparent (averaged over the volume) porosity as seen in the  $x_1$ -direction. That is to say, the porous surface area per unit surface area may be found by viewing a cross-section of the material that is orthogonal to the  $x_1$ -direction. Similarly,  $s_1$  is the apparent surface area per unit volume (also averaged over the volume), again for pores when viewed in cross sections. Both of these values can be determined to high accuracy by the use of digital image processing methods [28] on cross-sections of rocks. The remaining term is the pertinent formation factor  $F_1$ . This value is not so easy to determine from images, but can also be estimated using one of the forms of Archie's law [29], such as

$$F_1 = \phi_1^{-m_1}, \quad (51)$$

where  $m_1$  is an appropriate Archie cementation exponent associated with the  $x_1$ -direction. Typical values of  $m_1$  lie in the range  $1 < m_1 \leq 2$  [24].

If the composite material model we are constructing here contains several significantly different types of poroelastic materials, then we may also need to consider additional formation factors associated with the composite structure itself, as was done in Reference [24] for two-component porous media. We will ignore this issue for now, as the layer structure being considered suggests that, for many cases of interest, the pertinent distributional formation factors could be close unity. If this is not true in a particular application, then the methods developed in [28] can be generalized fairly easily to account such additional complications. For now, we assume these particular effects are not of primary importance.

There is also potential for mismatching/offsetting of pores at the boundaries between layers, and these effects can also reduce the effective overall permeabilities of these systems. But such effects are again fairly easy to take into account when it is known that they are present.

Now it is clear that the pertinent porosities and formation factors (also related to the same porosity values) are unitless measures of areas perpendicular to the three main flow directions. That means the strains that need to be considered are also the ones perpendicular to those directions. So for example, we should have

$$\begin{aligned} k_{11} &= \frac{\phi^{2+m_1}}{2[s_{11}^{(0)}]^2} (1 + e_{22}) (1 + e_{33}), \\ k_{22} &= \frac{\phi^{2+m_2}}{2[s_{22}^{(0)}]^2} (1 + e_{33}) (1 + e_{11}), \\ k_{33} &= \frac{\phi^{2+m_3}}{2[s_{33}^{(0)}]^2} (1 + e_{11}) (1 + e_{22}), \end{aligned} \quad (52)$$

for the diagonal permeabilities of such porous systems. Motivation for this statement involves an equivalent result for the orthotropic/anisotropic system of the form  $s^{-2} \propto V^{2/3}$  for the specific surface area dependence on volume in the isotropic case [24].

Our result is that

$$\frac{\delta k_{11}}{k_{11}} = (2 + m_1) \frac{\delta \phi}{\phi} + \delta e_{22} + \delta e_{33} = (2 + m_1) \frac{\delta \phi}{\phi} + \delta e - \delta e_{11}. \quad (53)$$

The  $\delta$ 's are shown explicitly to emphasize that these are all presumed to be relatively small changes in the respective quantities. The second equality follows from the definition of total strain  $e = e_{11} + e_{22} + e_{33}$ , and emphasizes a general symmetry of the dependencies: the permeability depends explicitly on the strain in the directions perpendicular to the flow. So  $k_{11}$  depends on the total strain minus the strain in the  $x_1$ -direction of flow, and similarly for the other two permeability eigenvalues.

## 6. Discussion

## 7. Summary and Conclusions

## Acknowledgments

Work performed under the auspices of the U.S. Department of Energy, at the Lawrence Berkeley National Laboratory under Contract No. DE-AC02-05CH11231. Support was provided specifically by the Geosciences Research Program of the DOE Office of Basic Energy Sciences, Division of Chemical Sciences, Geosciences and Biosciences.

## APPENDIX A: THE SCHOENBERG-MUIR METHOD

The quasi-static elasticity equations are often written in compliance form using the Voigt  $6 \times 6$  matrix notation as:

$$\begin{pmatrix} e_{11} \\ e_{22} \\ e_{33} \\ e_{23} \\ e_{31} \\ e_{12} \end{pmatrix} = \begin{pmatrix} s_{11} & s_{12} & s_{13} & s_{14} & s_{15} & s_{16} \\ s_{21} & s_{22} & s_{23} & s_{24} & s_{25} & s_{26} \\ s_{31} & s_{32} & s_{33} & s_{34} & s_{35} & s_{36} \\ s_{41} & s_{42} & s_{43} & s_{44} & s_{45} & s_{46} \\ s_{51} & s_{52} & s_{53} & s_{54} & s_{55} & s_{56} \\ s_{61} & s_{62} & s_{63} & s_{64} & s_{65} & s_{66} \end{pmatrix} \begin{pmatrix} \sigma_{11} \\ \sigma_{22} \\ \sigma_{33} \\ \sigma_{23} \\ \sigma_{31} \\ \sigma_{12} \end{pmatrix} \equiv \mathbf{S} \begin{pmatrix} \sigma_{11} \\ \sigma_{22} \\ \sigma_{33} \\ \sigma_{23} \\ \sigma_{31} \\ \sigma_{12} \end{pmatrix}, \quad (54)$$

where  $\mathbf{S}$  is the symmetric  $6 \times 6$  compliance matrix. The numbers 1,2,3 always indicate Cartesian axes (say,  $x,y,z$  respectively). The  $z$ -direction is usually chosen as the layering direction, which could be oriented any direction in the earth. But, in many geological and geophysical applications, the 3-axis (or  $z$ -axis) is also taken to be the vertical direction, and we conform to this convention here. The principal stresses are  $\sigma_{11}$ ,  $\sigma_{22}$ ,  $\sigma_{33}$ , in the directions 1,2,3, respectively. Similarly, the principal strains are  $e_{11}$ ,  $e_{22}$ ,  $e_{33}$ . The stresses  $\sigma_{23}$ ,  $\sigma_{31}$ ,  $\sigma_{12}$  are the torsional shear stresses, associated with rotation-based strains around the 1, 2, or 3 axes, respectively. The corresponding torsional strains are  $e_{23}$ ,  $e_{31}$ , and  $e_{12}$ , where the torsional motion is again a rotational straining motion around the 1, 2, or 3 axis. The compliance matrix is symmetric, so  $s_{ij} = s_{ji}$ , and this fact could have been used when displaying the matrix. The axis pairs in the subscripts 11, 22, 33, 23, 31, and 12, are often labelled (again following the conventions of Voigt) as 1,2,3,4,5,6, respectively.

The important contribution made by Backus [20] (also see Postma [22]) is the observation that, in a horizontally layered system, there are certain strains  $e_{ij}$  and stresses  $\sigma_{ij}$  that are necessarily continuous across boundaries between layers, while the others are not necessarily continuous. We have been implicitly (and now explicitly by calling this fact out) assuming that the interfaces between layers are in welded contact, which means practically that the in-plane strains are always continuous: so if axis 3 (or  $z$ ) is the symmetry axis (as is most often chosen for our layering problem), we have  $e_{11}$ ,  $e_{12} = e_{21}$ , and  $e_{22}$  are all continuous. Similarly, in welded contact, we must have continuity of the all the stresses involving the 3 (or  $z$ ) direction: so  $\sigma_{33}$ ,  $\sigma_{13} = \sigma_{31}$ , and  $\sigma_{23} = \sigma_{32}$  must all be continuous.

Then, following Backus [20] and/or Schoenberg and Muir [21] but — for present purposes

considering instead the compliance (inverse of stiffness) matrix — we have rearranged the statement of the problem so that:

$$\begin{pmatrix} e_{11} \\ e_{22} \\ e_{12} \\ e_{33} \\ e_{32} \\ e_{31} \end{pmatrix} = \begin{pmatrix} s_{11} & s_{12} & s_{16} & s_{13} & s_{14} & s_{15} \\ s_{21} & s_{22} & s_{26} & s_{23} & s_{24} & s_{25} \\ s_{61} & s_{62} & s_{66} & s_{63} & s_{64} & s_{65} \\ s_{31} & s_{32} & s_{36} & s_{33} & s_{34} & s_{35} \\ s_{41} & s_{42} & s_{46} & s_{43} & s_{44} & s_{45} \\ s_{51} & s_{52} & s_{56} & s_{53} & s_{54} & s_{55} \end{pmatrix} \begin{pmatrix} \sigma_{11} \\ \sigma_{22} \\ \sigma_{12} \\ \sigma_{33} \\ \sigma_{32} \\ \sigma_{31} \end{pmatrix}. \quad (55)$$

Note that this equation, although similar to (54) is quite different because of the rearrangement of the matrix elements and the reordering of the strains and stresses. The expression in (55) is general for all elastic media. In the main text we restrict our discussion to orthotropic media. Assuming then that we are using the correct axes as the symmetry axes in the presentation, all off-diagonal compliances having subscripts 4, 5, or 6 in (54) vanish identically. The diagonal shear compliances  $s_{44}$ , etc., generally do not vanish however.

Expression of can be made more compact by writing it as:

$$\begin{pmatrix} E_T \\ E_N \end{pmatrix} = \begin{pmatrix} \mathbf{S}_{TT} & \mathbf{S}_{TN} \\ \mathbf{S}_{NT} & \mathbf{S}_{NN} \end{pmatrix} \begin{pmatrix} \Pi_T \\ \Pi_N \end{pmatrix}, \quad (56)$$

where

$$\mathbf{S}_{TT} \equiv \begin{pmatrix} s_{11} & s_{12} & s_{16} \\ s_{21} & s_{22} & s_{26} \\ s_{61} & s_{62} & s_{66} \end{pmatrix} = \begin{pmatrix} s_{11} & s_{12} & \\ s_{21} & s_{22} & \\ & & s_{66} \end{pmatrix}, \quad (57)$$

$$\mathbf{S}_{NN} \equiv \begin{pmatrix} s_{33} & s_{34} & s_{35} \\ s_{43} & s_{44} & s_{45} \\ s_{53} & s_{54} & s_{55} \end{pmatrix} = \begin{pmatrix} s_{33} & & \\ & s_{44} & \\ & & s_{55} \end{pmatrix}, \quad (58)$$

and

$$\mathbf{S}_{NT} \equiv \begin{pmatrix} s_{31} & s_{32} & s_{36} \\ s_{41} & s_{42} & s_{46} \\ s_{51} & s_{52} & s_{56} \end{pmatrix} = \begin{pmatrix} s_{31} & s_{32} & \\ & 0 & \\ & & 0 \end{pmatrix}, \quad (59)$$

with  $\mathbf{S}_{TN} = \mathbf{S}_{NT}^T$  (with  $T$  superscript indicating the matrix transpose). Also we have

$$E_T \equiv \begin{pmatrix} e_{11} \\ e_{22} \\ e_{12} \end{pmatrix}, \quad \text{and} \quad E_N \equiv \begin{pmatrix} e_{33} \\ e_{32} \\ e_{31} \end{pmatrix}, \quad (60)$$

and

$$\Pi_T \equiv \begin{pmatrix} \sigma_{11} \\ \sigma_{22} \\ \sigma_{12} \end{pmatrix}, \quad \text{and} \quad \Pi_N \equiv \begin{pmatrix} \sigma_{33} \\ \sigma_{32} \\ \sigma_{31} \end{pmatrix}. \quad (61)$$

It is important to distinguish between “slow” and “fast” variables in this analysis, since this distinction makes it clear when and how averaging should be performed. The “slow” variables, *i.e.*, those that are continuous across the (here assumed horizontal) boundaries and also essentially constant for the present quasi-static application, are those contained in  $E_T$  and  $\Pi_N$ . So, after averaging  $\langle \cdot \rangle$  along the layering direction, we have:

$$\begin{pmatrix} E_T \\ \langle E_N \rangle \end{pmatrix} = \begin{pmatrix} \mathbf{S}_{TT}^* & \mathbf{S}_{TN}^* \\ \mathbf{S}_{NT}^* & \mathbf{S}_{NN}^* \end{pmatrix} \begin{pmatrix} \langle \Pi_T \rangle \\ \Pi_N \end{pmatrix}, \quad (62)$$

where  $\mathbf{S}_{TN}^* = (\mathbf{S}_{NT}^*)^T$ , and all the starred quantities are the *nontrivial* average compliances we seek. They are defined in terms of layer average quantities where the symbol  $\langle \cdot \rangle$  indicates a simple volume average of all the layers. By this notation we mean that a quantity  $Q$  that takes on different values in different layers has the layer average  $\langle Q \rangle \equiv x_a Q_a + x_b Q_b + \dots$ . The definition is general and applies to an arbitrary number of different layers where the fraction of the total volume occupied by layer  $a$  is  $x_a$ , etc. Total fractional volume is  $x_a + x_b + \dots \equiv 1$ .

Of the three final results, the two easiest ones to compute are:

$$\mathbf{S}_{TT}^* = \langle \mathbf{S}_{TT}^{-1} \rangle^{-1}, \quad (63)$$

$$\mathbf{S}_{TN}^* = (\mathbf{S}_{NT}^*)^T = \langle \mathbf{S}_{TT}^{-1} \rangle^{-1} \langle \mathbf{S}_{TT}^{-1} \mathbf{S}_{TN} \rangle = \mathbf{S}_{TT}^* \langle \mathbf{S}_{TT}^{-1} \mathbf{S}_{TN} \rangle, \quad (64)$$

where  $\langle \cdot \rangle$  is the layer average of some quantity. These results follow from this equation:

$$\langle \mathbf{S}_{TT}^{-1} \rangle E_T = \langle \Pi_T \rangle + \langle \mathbf{S}_{TT}^{-1} \mathbf{S}_{TN} \rangle \Pi_N, \quad (65)$$

which followed immediately from the formula

$$E_T = \mathbf{S}_{TT} \Pi_T + \mathbf{S}_{TN} \Pi_N \quad (66)$$

multiplying through first by the inverse of  $\mathbf{S}_{TT}$ , and then performing the layer average. [Note that  $\mathbf{S}_{TT}$  and  $\mathbf{S}_{NN}$  are both normally square and invertible matrices, whereas for most systems the off-diagonal matrix  $\mathbf{S}_{NT}$  is not invertible. But, this fact does not cause problems in the analysis, because we do not need to invert  $\mathbf{S}_{NT}$  in order to solve the averaging problem at hand.] These averages are meaningful because when the matrix equations presented are multiplied out, we never have any cross products of two quantities that are both unknown. [From this view point, Eq. (65) is an equation for  $\langle \Pi_T \rangle$ , just as the unaveraged version of (65) is an equation for  $\Pi_T$  in each layer.] So simple layer averaging suffices (thereby providing the main motivation and value of this method). Multiplying (65) through by  $\langle \mathbf{S}_{TT}^{-1} \rangle^{-1}$  then gives the results (63) and (64).

The remaining result is more tedious to compute, since it requires several intermediate steps in its derivation. But the final result is given by the formula:

$$\mathbf{S}_{NN}^* = \langle \mathbf{S}_{NN} \rangle - \langle \mathbf{S}_{NT} \mathbf{S}_{TT}^{-1} \mathbf{S}_{TN} \rangle + \mathbf{S}_{NT}^* (\mathbf{S}_{TT}^*)^{-1} \mathbf{S}_{TN}^*. \quad (67)$$

To provide some clues to the derivation, again consider:

$$\Pi_T = \mathbf{S}_{TT}^{-1} E_T - \mathbf{S}_{TT}^{-1} \mathbf{S}_{TN} \Pi_N, \quad (68)$$

which is just a rearrangement of (66). The point is that  $\langle \Pi_T \rangle$  is then given immediately in terms of the quantities  $E_T$  and  $\Pi_N$ , which are both “slow” variables and therefore essentially constant. An intermediate result that helps to explain the form of this relation (67) is:

$$\mathbf{S}_{NT}^* (\mathbf{S}_{TT}^*)^{-1} \mathbf{S}_{TN}^* = \langle \mathbf{S}_{NT} \mathbf{S}_{TT}^{-1} \rangle \langle \mathbf{S}_{TT}^{-1} \rangle^{-1} \langle \mathbf{S}_{TT}^{-1} \mathbf{S}_{TN} \rangle = \langle \mathbf{S}_{NT} \mathbf{S}_{TT}^{-1} \rangle \mathbf{S}_{TN}^*. \quad (69)$$

Substituting for  $\Pi_T$  from (68) into

$$E_N = \mathbf{S}_{NT} \Pi_T + \mathbf{S}_{NN} \Pi_N \quad (70)$$

and then averaging, we find that

$$\langle E_N \rangle = \langle \mathbf{S}_{NT} \mathbf{S}_{TT}^{-1} \rangle E_T + \langle \mathbf{S}_{NN} - \mathbf{S}_{NT} \mathbf{S}_{TT}^{-1} \mathbf{S}_{TN} \rangle \Pi_N, \quad (71)$$

an expression completely determining the remaining coefficients. After some more algebra, the formula giving the final result is:

$$\begin{aligned} \langle E_N \rangle &= \langle \mathbf{S}_{NT} \mathbf{S}_{TT}^{-1} \rangle \langle \mathbf{S}_{TT}^{-1} \rangle^{-1} [\langle \Pi_T \rangle + \langle \mathbf{S}_{TT}^{-1} \mathbf{S}_{TN} \rangle \Pi_N] \\ &\quad + [\langle \mathbf{S}_{NN} \rangle - \langle \mathbf{S}_{NT} \mathbf{S}_{TT}^{-1} \mathbf{S}_{TN} \rangle] \Pi_N \\ &= \mathbf{S}_{NT}^* \langle \Pi_T \rangle + \mathbf{S}_{NN}^* \Pi_N. \end{aligned} \quad (72)$$

Equation (72) contains all the information needed to produce the third and final result found in (67).

Another check on these formulas is to compare them directly to those found by Schoenberg and Muir [21]. However, direct comparison is not so easy, since their analysis focuses on the stiffness version of the equations. Our treatment makes use of the compliance version instead. Since the symmetries of the two forms of the equations nevertheless are nearly identical, cross-checks and comparisons will be left to the interested reader.

## APPENDIX B: POROELASTIC FORMULAS FOR UNDRAINED BOUNDARY CONDITIONS IN LAYERED SYSTEMS

Using equation (29) as our starting point, we now consider the boundary condition  $\zeta = 0$  for undrained layers (meaning that the fluid is actually physically trapped in the layer, or the physical process is so fast – such as high frequency wave propagation – that the fluid inertia prevents rapid movement of fluid particles over non-infinitesimal distances). Depending on the application scenario, this boundary condition might be applied to all layers, or only to just one or a few layers.

We consider first a single layer having the undrained boundary condition. For this case, the condition from Eq. (29) becomes

$$0 = \mathbf{g}_{12}^T \Pi_T + \gamma p_f + \mathbf{g}_3^T \Pi_N, \quad (73)$$

within the layer. Next, the equation can be solved to express the fluid pressure  $p_f$  strain dependence in each undrained layer (the layer labels are suppressed here for simplicity) as

$$p_f = -\frac{1}{\gamma} (\mathbf{g}_{12}^T \Pi_T + \mathbf{g}_3^T \Pi_N). \quad (74)$$

Then, substituting this condition back into the expressions for  $E_T$  and  $E_N$  from (29), we find that

$$\begin{pmatrix} E_T \\ E_N \end{pmatrix} = \begin{pmatrix} \mathbf{S}_{TT} - \gamma^{-1} \mathbf{g}_{12} \mathbf{g}_{12}^T & \mathbf{S}_{TN} - \gamma^{-1} \mathbf{g}_{12} \mathbf{g}_3^T \\ \mathbf{S}_{NT} - \gamma^{-1} \mathbf{g}_3 \mathbf{g}_{12}^T & \mathbf{S}_{NN} - \gamma^{-1} \mathbf{g}_3 \mathbf{g}_3^T \end{pmatrix} \begin{pmatrix} \Pi_T \\ \Pi_N \end{pmatrix}. \quad (75)$$

To understand the significance of (75), we next find it is straightforward to show that each of these composite matrix elements corresponds exactly to the undrained version of the Schoenberg-Muir matrices. So that,

$$\mathbf{S}_{TT}^u \equiv \mathbf{S}_{TT} - \gamma^{-1} \mathbf{g}_{12} \mathbf{g}_{12}^T, \quad (76)$$

$$\mathbf{S}_{NN}^u \equiv \mathbf{S}_{NN} - \gamma^{-1} \mathbf{g}_3 \mathbf{g}_3^T, \quad (77)$$

and

$$\mathbf{S}_{TN}^u \equiv \mathbf{S}_{TN} - \gamma^{-1} \mathbf{g}_{12} \mathbf{g}_3^T = (\mathbf{S}_{NT}^u)^T. \quad (78)$$

All these expressions follow directly from the form of (75).

Thus, we arrive at a result that might have been anticipated, which is that the undrained layers respond according to the usual undrained conditions in each individual layer. The part of the result that is new concerns the forms of the undrained matrices  $\mathbf{S}_{TT}^u$ ,  $\mathbf{S}_{NT}^u = (\mathbf{S}_{TN}^u)^T$ , and  $\mathbf{S}_{NN}^u$ , in the now modified Schoenberg-Muir formalism.

This analogy can be pushed somewhat further to include the effective values for the undrained moduli  $\mathbf{S}_{TT}^u$ ,  $\mathbf{S}_{NT}^u = (\mathbf{S}_{TN}^u)^T$ , and  $\mathbf{S}_{NN}^u$ , with formulas entirely analogous to (63), (64), and (67), and undrained constants replacing drained constants everywhere. Since there is nothing subtle about this step, we leave these details to the interested reader.

## APPENDIX C: EFFECTIVE STRESS FOR PERMEABILITY OF ISOTROPIC POROELASTIC SYSTEMS WITH GRANULAR STRUCTURE AND/OR TUBULAR PORES

Berryman [24] shows that the effective stress response of fluid permeability  $k$  in isotropic poroelastic systems, having either granular structure or tubular pores, is given by:

$$\frac{\delta k}{k} = - \left[ \frac{2}{3} + n \left( \frac{\alpha_R - \phi}{\phi} \right) \right] \frac{1}{K_R^d} (\delta p_c - \kappa \delta p_f), \quad (79)$$

where the pertinent effective stress coefficient is

$$\kappa = 1 - \frac{2\phi(1 - \alpha_R)}{2\phi + 3n(\alpha_R - \phi)}. \quad (80)$$

The numerical constant  $n$  is model dependent, but often has a value  $n \simeq 4$ . The porosity is  $\phi$ . The poroelastic factor  $\alpha_R = 1 - K_R^d/K_R^g$  is the usual Biot or Biot-Willis coefficient [2]. The subscripts  $R$  are redundant in these expressions, since Reuss and Voigt averages are the same for isotropic systems; but we show them here nevertheless to emphasize their connection to results in the anisotropic problem. Also note that  $(\alpha_R - \phi) \geq 0$  in general. The result (80) follows from the commonly used formula for isotropic permeability in this class of systems in terms of porosity  $\phi$ , specific surface area  $s$ , and formation factor  $F$ , which

is given by

$$k \simeq \frac{\phi^2}{2s^2 F}, \quad (81)$$

and which formula is consistent with the work of many researchers, including Paterson [25] and Walsh and Brace [26]. The formation factor is often estimated in the form  $F \simeq \phi^{-m}$ , in which case the constant  $n \simeq 2 + m$ . Since  $k$  has the dimensions of length squared, it scales with volume  $V$  like  $V^{2/3}$

A useful approximation [30-35] to  $K_R^d$  for isotropic systems composed of a single isotropic grain-type having bulk modulus  $K_R^g$  and shear modulus  $\mu^g$  is:

$$K_R^d \simeq \frac{(1 - \phi)K_R^g}{1 + 3K_R^g\phi/4\mu^g} \simeq \frac{(1 - \phi)K_R^g}{1 + c\phi}, \quad (82)$$

where the dimensionless factor  $c \simeq 3K_R^g/4\mu^g$  is called a consolidation parameter; in the absence of definitive information concerning elastic frame constants,  $c$  can also be used as a fitting parameter. A typical range of values for this parameter is  $2 \leq c \leq 20$  for sandstones. Lower values of  $c$  correspond to stronger states of consolidation, while higher values correspond to weaker states of consolidation.

Substituting this expression (82) into the formula for the effective stress coefficient  $\kappa$ , we find:

$$\kappa \simeq 1 - \frac{1 - \phi}{1 + c[(3n/2)(1 - \phi) + \phi]}. \quad (83)$$

## REFERENCES

- [1] F. Gassmann, “Über die Elastizität poröser Medien,” *Vierteljahrsschrift der Naturforschenden Gesellschaft in Zürich* **96** (1951) 1–23.
- [2] M. A. Biot, D. G. Willis, The elastic coefficients of the theory of consolidation, *Journal of Applied Mechanics* **24** (1957) 594–601.
- [3] R. J. S. Brown, J. Korringa, On the dependence of the elastic properties of a porous rock on the compressibility of the pore fluid, *Geophysics* **40** (1975) 608–616.
- [4] J. R. Rice, M. P. Cleary, Some basic stress diffusion solutions for fluid-saturated elastic porous media with compressible constituents, *Reviews of Geophysics and Space Physics* **14** (1976) 227–241.

- [5] L. Thigpen, J. G. Berryman, Mechanics of porous elastic materials containing multiphase fluid, *International Journal of Engineering Science* **23** (1985) 1203.
- [6] R. W. Zimmerman, Compressibility of Sandstones, Elsevier, Amsterdam, 1991, Chapter 6.
- [7] A. H.-D. Cheng, Material coefficients of anisotropic poroelasticity, *International Journal of Rock Mechanics* **34** (1997) 199–205.
- [8] H. F. Wang, Theory of Linear Poroelasticity with Applications to Geomechanics and Hydrogeology, Princeton University Press, Princeton, NJ, 2000.
- [9] J. G. Berryman, Poroelastic measurement schemes resulting in complete data sets for granular and other anisotropic porous media, *International Journal of Engineering Science* **48** (2010) 446–459.
- [10] S. R. Pride and J. G. Berryman, Linear dynamics of double-porosity dual-permeability materials. I. Governing equations and acoustic attenuation,” *Physical Review E* **68** (2003) 036693.
- [11] S. R. Pride and J. G. Berryman, Linear dynamics of double-porosity dual-permeability materials. II. Fluid transport equations,” *Physical Review E* **68** (2003) 036694.
- [12] S. R. Pride, J. G. Berryman, and J. M. Harris, Seismic attenuation due to wave-induced flow, *Journal of Geophysical Research* **109** (2004) B01201.
- [13] A. Reuss, “Berechnung der Fließgrenze von Mischkristallen,” *Z. Angew. Math. Mech.* **9** (1929) 55.
- [14] W. Voigt, *Lehrbuch der Kristallphysik*, Teubner, Leipzig, 1928, p. 962.
- [15] R. Hill, The elastic behaviour of crystalline aggregate, *Proceedings of the Physical Society of London* **A65** (1952) 349–354.
- [16] A. W. Skempton, The pore-pressure coefficients *A* and *B*, *Géotechnique* **4** (1954) 143–147.
- [17] R. D. Stoll, Acoustic waves in saturated sediments, in *Physics of Sound in Marine Sediments*, edited by L. Hampton, Plenum, New York, 1974, pp. 19–39.

- [18] J. G. Berryman, Transversely isotropic poroelasticity arising from thin isotropic layers, in *Mathematics of Multiscale Materials*, edited by K. M. Golden, G. R. Grimmett, R. D. James, G. W. Milton, and P. N. Sen, Springer, New York, 1998, pp. 37–50.
- [19] A. W. Wood, *A Textbook of Sound*, Bell, London, 1955, p. 360.
- [20] G. E. Backus, Long-wave elastic anisotropy produced by horizontal layering, *Journal of Geophysical Research* **67** (1962) 4427–4440.
- [21] M. Schoenberg and F. Muir, A calculus for finely layered anisotropic media, *Geophysics* **54** (1989) 581–589.
- [22] G. W. Postma, Wave propagation in a stratified medium, *Geophysics* **20** (1955) 780–806.
- [23] M. A. Biot, Mechanics of deformation and acoustic propagation in porous media, *J. Appl. Phys.* **33** (1962) 1482–1498.
- [24] J. G. Berryman, Effective stress for transport properties of inhomogeneous porous rock, *J. Geophys. Res.* **97** (1992) 17409–17424.
- [25] M. S. Paterson, The equivalent channel model for permeability and resistivity in fluid-saturated rocks – A reappraisal, *Mech. Mater.* **2** (1983) 345–352.
- [26] J. B. Walsh and W. F. Brace, The effect of pressure on porosity and the transport properties of rocks, *J. Geophys. Res.* **89** (1984) 9425–9431.
- [27] N. S. Martys, S. Torquato, and D. P. Bentz, Universal scaling of fluid permeability for sphere packings, *Phys. Rev. E* **50** (1994) 402–408.
- [28] J. G. Berryman, Measurement of spatial correlation functions using image processing techniques, *J. Appl. Phys.* **57** (1985) 2374–2384.
- [29] G. E. Archie, The electrical resistivity log as an aid in determining some reservoir characteristics, *Trans. Am. Inst. Min. Metall. Pet. Eng.* **146** (1942) 54–62.
- [30] D. P. Hasselman, On the porosity dependence of mechanical strength of brittle polycrystalline refractory materials, *J. Am. Ceram. Soc.* **45** (1962) 452–453.
- [31] Z. Hashin, Elastic moduli of heterogeneous materials, *J. Appl. Mech.* **29** (1962) 143–150.

- [32] J. Korringa, R. J. S. Brown, D. D. Thompson, and R. J. Runge, Self-consistent imbedding and the ellipsoidal model for porous rocks, *J. Geophys. Res.* **84** (1979) 5591–5598.
- [33] S. R. Pride, E. Tromeur, and J. G. Berryman, Biot slow-wave effects in stratified rock, *Geophysics* **67** (2002) 271–281.
- [34] S. R. Pride, Relationships between seismic and hydrological properties, in *Hydrogeophysics*, edited by Y. Rubin and S. S. Hubbard, Springer (2005) pp. 253–290.
- [35] X.-S. Wang, X.-W. Jiang, L. Wan, G. Song, and Q. Xia, Evaluation of depth-dependent porosity and bulk modulus of a shear using permeability-depth trends, *Int. J. Rock Mech. Min. Sci.* **46** (2009) 1175–1181.
- [36] S. P. Neuman, Trends, prospects, and challenges in quantifying flow and transport through fractured rocks, *Hydrogeol. J.* **13** (2005) 124–147.
- [37] L. J. Pyrak-Nolte and J. P. Morris, Single fractures under normal stress: The relation between fracture specific stiffness and fluid flow, *Int. J. Rock Mech. Min. Sci.* **37** (2000) 245–262.
- [38] S.-H. Ji, K.-K. Lee, and Y.-C. Park, Effects of correlation length on the hydraulic parameters of a fracture network, *Transport in Porous Media* **55** (2004) 153–168.
- [39] X.-W. Jiang, L. Wan, X.-S. Wang, S.-H. Liang, and B. X. Hu, Estimation of fracture normal stiffness using a transmissivity-depth correlation, *Int. J. Rock Mech. Min. Sci.* **46** (2009) 51–58.
- [40] H. H. Liu and J. Rutqvist, A new coal-permeability model: Internal swelling stress and fracture-matrix interaction, *Transport in Porous Media* **82** (2010) 157–171.
- [41] H. H. Liu, J. Rutqvist, and J. G. Berryman, On the relationship between stress and elastic strain for porous and fractured rock, *Int. J. Rock Mech. Min. Sci.* **46** (2009) 792–802.
- [42] T. M. Daley, M. A. Schoenberg, J. Rutqvist, and K. T. Nihei, Fractured reservoirs: An analysis of coupled elastodynamic and permeability changes from pore-pressure variation, *Geophysics* **71** (2006) O33–O41.

- [43] Y. J. Masson, S. R. Pride, and K. T. Nihei, Finite difference modeling of Biot's poroelastic equations at seismic frequencies, *J. Geophys. Res.* **111** (2006) B10305.
- [44] Y. J. Masson and S. R. Pride, Poroelastic finite difference modeling of seismic attenuation and dispersion due to mesoscopic-scale heterogeneity, *J. Geophys. Res.* **112** (2007) B03204.
- [45] M. Schoenberg, Layered permeable systems, *Geophys. Prospecting* **39** (1991) 219–240.
- [46] H. Deresiewicz and R. Skalak, On uniqueness in dynamic poroelasticity, *Bull. Seismolog. Soc. Am.* **53** (1963) 783–788.