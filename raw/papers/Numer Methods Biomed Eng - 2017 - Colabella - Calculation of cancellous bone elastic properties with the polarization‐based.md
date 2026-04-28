

# Calculation of cancellous bone elastic properties with the polarization-based FFT iterative scheme

Lucas Colabella<sup>1</sup> ![ORCID icon](003082e50e3009141f59bd5df831749f_img.jpg) | Ariel Alejandro Ibarra Pino<sup>1,3</sup> | Josefina Ballarre<sup>1</sup> | Piotr Kowalczyk<sup>2</sup> | Adrián Pablo Cisilino<sup>1</sup>

<sup>1</sup> INTEMA-School of Engineering, CONICET-National University of Mar del Plata, Av. Juan B. Justo 4302, Mar del Plata B7608FDQ, Argentina

<sup>2</sup> Institute of Fundamental Technological Research, Polish Academy of Sciences, Pawinskiego 5B02-106 Warsaw, Poland

<sup>3</sup> Department of Aerospace Engineering and Mechanics, University of Minnesota, Minneapolis, MN 55455, USA

## Correspondence

Lucas Colabella, INTEMA-School of Engineering, CONICET-National University of Mar del Plata, Av. Juan B. Justo 4302, Mar del Plata B7608FDQ, Argentina.  
Email: lcolabella@fi.mdp.edu.ar

## Funding information

Agencia Nacional de Promoción Científica de la República Argentina; National University of Mar del Plata, Grant/Award Number: PIRSES-GA2009\_246977; European Union, Grant/Award Number: Marie Curie Actions FP7-PEOPLE-2009-IRSES

## Abstract

The Fast Fourier Transform-based method, originally introduced by Moulinec and Suquet in 1994 has gained popularity for computing homogenized properties of composites. In this work, the method is used for the computational homogenization of the elastic properties of cancellous bone. To the authors' knowledge, this is the first study where the Fast Fourier Transform scheme is applied to bone mechanics. The performance of the method is analyzed for artificial and natural bone samples of 2 species: bovine femoral heads and implanted femurs of Hokkaido rats. Model geometries are constructed using data from X-ray tomographies, and the bone tissue elastic properties are measured using microindentation and nanoindentation tests. Computed results are in excellent agreement with those available in the literature. The study shows the suitability of the method to accurately estimate the fully anisotropic elastic response of cancellous bone. Guidelines are provided for the construction of the models and the setting of the algorithm.

## KEYWORDS

accelerated FFT method, cancellous bone, homogenized elastic properties

## 1 | INTRODUCTION

Bones are hierarchical bio-composite materials with complex multiscale structural geometry.<sup>1</sup> Bone tissue is arranged either in a compact pattern (cortical bone) or a spongy pattern (cancellous bone). The cancellous structure is organized into a 3-dimensional lattice of bony processes, called trabeculae, arranged along lines of stress. The trabeculae consist of a nanometric extracellular matrix that incorporates hydroxyapatite, the bone mineral that gives bones their rigidity; and collagen, an elastic protein, which improves fracture resistance. Cancellous bone, also called trabecular bone, is found at the ends of long bones, proximal to joints and within the interior of vertebrae.<sup>2</sup>

Advancements in 3D imaging technology and computational power have enhanced the classical methods to evaluate

the mechanical properties of cancellous bone, which are relevant to assess the risk of osteoporotic fracture.<sup>3,4</sup> High-resolution finite element (FE) models are constructed from bone microarchitectures that are digitized by using micro-Computed Tomography (micro-CT) and in vivo high-resolution peripheral quantitative CT scanners. Finite element analysis (FEA) are used to compute bone effective elastic properties,<sup>5-8</sup> to predict bone strength<sup>9</sup> and as part of sophisticated multiscale analysis.<sup>10,11</sup> These models assign the trabeculae the mechanical properties of the mineral matrix, which is assumed linear elastic, and it is experimentally characterized via microindentation and nanoindentation tests.<sup>12,13</sup> More elaborated nonlinear material behaviors are also available, eg, Schwiedrzik et al<sup>14</sup> introduced a cohesive-frictional model to capture the effects leading to cancellous

bone failure. There are also models that account for the presence of the interstitial fluids in cancellous microstructure to assess viscous effects<sup>15,16</sup> and bone permeability.<sup>17</sup>

Another approach consists in the use of equivalent artificial cancellous microstructures.<sup>18,19</sup> This method has been widely accepted empirically since trabecular microstructures approximately resemble a few typical patterns consisting of 3-dimensional interconnected bars and/or plates. Artificial bone microstructures are typically described by a reduced number of geometrical parameters, what makes them practical to deal with qualitative studies of bone morphometry<sup>20</sup> and simulations of bone remodeling processes.<sup>21,22</sup> Such equivalent microstructural models are typically designed and analyzed using FEA.

A Fast Fourier Transform (FFT)-based method, originally introduced by Moulinec and Suquet,<sup>23</sup> has gained popularity for computing the homogenized properties of composites. The method is based on solving the Lippmann-Schwinger equation iteratively making use of the Green operator associated to a reference linear material. The FFT method has found applications in linear elasticity,<sup>24</sup> thermoelasticity,<sup>25</sup> thermo-plasticity,<sup>26</sup> residual stresses<sup>27</sup> as well as in thermal,<sup>28</sup> electrical,<sup>29,30</sup> coupled thermo-magneto-electro-elastic,<sup>31</sup> optical materials,<sup>32</sup> and Stokes flow in porous solids.<sup>33</sup> The method avoids meshing, and it can cope with arbitrarily complex microstructures that are supplied as segmented images of real materials. Its implementation is easily parallelizable, and it can take full advantage of graphical processing unit hardware to accelerate FFT computations.

The FFT reduces the equilibrium problem of the composite with periodic boundary conditions to the iterative resolution of the Lippmann-Schwinger equation, which involves the Green operator associated to a reference linear elastic material. Several variants have been proposed to increase the convergence rate of the initial scheme proposed by Moulinec and Suquet,<sup>34</sup> which presents some limitations when the phases of the composite have high contrasts of properties. Among others, the schemes by Eyre and Milton,<sup>35</sup> the augmented Lagrangian due to Michel et al<sup>36</sup> and the polarization-based scheme by Monchiet and Bonnet<sup>37</sup> can be named. In a recent work, Moulinec and Silva<sup>38</sup> have shown that the schemes by Eyre and Milton<sup>35</sup> and by Michel et al<sup>36,39</sup> reduce to particular cases of the Monchiet and Bonnet<sup>37</sup> scheme by setting the algorithm parameters appropriately. Moulinec and Silva<sup>38</sup> have also demonstrated that, for finite contrast between the phases, there are optimal choices of the algorithm parameters and the reference medium that maximize the rate of convergence of the scheme by Eyre and Milton.<sup>35</sup> Unfortunately, Moulinec and Silva<sup>38</sup> could not demonstrate the convergence of the method for the case of microstructures with voids and rigid inclusions, ie, microstructures with infinite contrast. On the other hand, Michel et al<sup>36,39</sup> and Bilger et al<sup>40</sup> used the

augmented Lagrangian scheme to perform analyses for materials with voids and rigid inclusions that did converge, at least for the prescribed tolerance they used.

In the present work, we use the FFT method to compute the homogenized anisotropic elastic properties of trabecular bone. To the authors' knowledge, this is the first study where the FFT scheme is applied to bone mechanics. The performance of the method is investigated for natural and artificial bone microstructures. The application to natural bone includes the analysis of 2 animal specimens, bovine femoral heads and implanted femurs of adult Hokkaido rats, while the artificial microstructures are the repeatable parameterized cellular material introduced by Kowalczyk.<sup>41</sup>

## 2 | CANCELLOUS BONE

A typical cancellous bone microstructure is depicted in Figure 1. The cancellous microarchitecture is generally characterized in terms of the solid volume fraction,  $\phi$ , the trabecular thickness,  $t$ , and the trabecular spacing,  $s$ , see Figure 1B. Bone tissue mechanical properties and trabecular architecture are the main factors that determine the mechanical properties of cancellous bone, which show a high dependency on species, anatomic site, age, and size of the sample.<sup>42</sup> The minuscule dimensions of the trabeculae (of order from tens to a cent of microns) make of tissue-level mechanical characterization a difficult task. In recent years, nanoindentation has provided the means for the direct measurement of the elastic properties of trabecular bone tissue (a complete review of the available techniques, many of them indirect, can be found in a recent paper by Oftadeh et al<sup>43</sup>). By means of high-resolution nanoindentation, Brennan et al<sup>44</sup> studied the variations in the properties of the tissue within a single trabecula; they found that Young modulus and hardness increase towards the core of the trabeculae. Although these findings, the inhomogeneity and anisotropy of the mechanical properties in bone tissue have a minor impact on the apparent properties of cancellous bone. Consequently, it can be modeled as an isotropic material.<sup>45</sup>

Different experiments have shown that linear elasticity can predict the behavior of cancellous bone.<sup>46</sup> Cowin<sup>47</sup> states that infinitesimal strain theory is adequate for studying the mechanical response of bone providing that strains remain within the physiological range. Therefore, we can safely assume a linear-elastic response at the microscale and, consequently, at higher scales. Therefore, the relationship between the stress  $\sigma$  and strain  $\epsilon$  tensors at the macroscale is given in terms of the fourth-order homogenized stiffness tensor  $\mathbb{C}$  such that

$$\sigma = \mathbb{C} \epsilon. \quad (1)$$

The trabecular architecture determines the elastic anisotropy of  $\mathbb{C}$ , which in its most general form is defined in terms

![Figure 1: (A) Macroscopic view of a human femur head with a coordinate system (x1, x2, x3) and characteristic length L. (B) Microscopic view of the cancellous bone microstructure with a coordinate system (y1, y2, y3) and characteristic lengths s, t, and l.](7e2f2d03a5dda38b038fd4884629a2b4_img.jpg)

Figure 1 consists of two parts. Part (A) shows a macroscopic view of a human femur head with a coordinate system (x1, x2, x3) and a characteristic length L. Part (B) shows a microscopic view of the cancellous bone microstructure with a coordinate system (y1, y2, y3) and characteristic lengths s, t, and l.

Figure 1: (A) Macroscopic view of a human femur head with a coordinate system (x1, x2, x3) and characteristic length L. (B) Microscopic view of the cancellous bone microstructure with a coordinate system (y1, y2, y3) and characteristic lengths s, t, and l.

**FIGURE 1** A, macroscopic (continuum level) and B, representative sample of the cancellous bone microstructure with their corresponding characteristic lengths

of 21 independent constants. However, Yang et al<sup>48</sup> demonstrated that cancellous bone has elastic orthotropic symmetry with a 95% confidence level for a set of 141 human specimens. Hence, only 9 independent components are required to fully describe the elastic behavior of the structure.

### 2.1 | Artificial samples

The geometries for the artificial samples are from the work by Kowalczyk,<sup>41</sup> which introduces the repeatable parameterized cellular material in Figure 2A that mimics the elastic response of cancellous bone. The repeatable geometry is described in terms of 4 parameters:  $t_c$ ,  $t_h$  and  $t_v$ , which define proportions between trabecular plate widths and thicknesses to produce transversely isotropic microstructures in the  $y_1 - y_2$  plane; and  $t_c$ , which scales the geometry in the  $y_1$  direction to produce fully orthotropic microstructures. To produce feasible geometries, the parameters must comply with the restrictions  $t_c \leq t_h$  and  $t_c \leq t_v$ . Parameter values can be set to produce microstructures with solid volume fractions in the range  $0.01 < \phi < 0.99$ . The geometry in Figure 2A can be conveniently arranged to produce the hexahedral repeatable unit cells, as the one depicted in Figure 2B.

Five microstructures are considered in this work. They were selected to have solid volume fractions and geometrical parameters that cover the ranges reported by van Rietbergen and Huiskes<sup>49</sup> and Kabel et al<sup>50</sup> for cancellous bone. Their data are reported in Table 1.

Sample geometries were sliced to produce stacks of 2-dimensional binary images that mimic micro-CT scans. These 2-dimensional images were used for geometrical analyses using the software BoneJ.<sup>51</sup> Table 1 reports the

results for the volume fraction, the trabecular thickness and spacing, and the normalized trabecular thickness.

### 2.2 | Natural samples

Four natural cancellous bone specimens are studied, which are labeled as N1, N2, N3, and N4 (Figure 3). Specimens N1 and N2 are from bovine femoral heads. Ibarra Pino<sup>52</sup> produced specimen N1 at INTEMA, while the School of Engineering of São Carlos of the University of São Paulo kindly provided the CT data of N2.<sup>53</sup> Specimens N3 and N4, which were also produced at INTEMA,<sup>54,55</sup> are from femurs of adult Hokkaido rats with coated stainless steel implants. Implantation times of N3 and N4 were 4 and 8 weeks, respectively. Therefore, the bone maturity of N3 is thought to be less than that of N4.

Specimens produced at INTEMA were prepared according to the following procedure. They were cleaned from surrounding soft tissues and fixed in neutral 10 wt% formaldehyde for at least 24 hours (10 days in the case of N1 sample). Afterwards, they were dehydrated in a series of acetone-water mixtures followed by a methacrylate solution, and finally embedded in a methyl methacrylate (PMMA) solution and polymerized. Five-millimeter thick samples were cut from the PMMA embedded blocks for micro-CT and nanoindentation studies. Cuts were made with a low-speed diamond blade saw (Buehler GmbH) cooled with water. The samples used for nanoindentation were further polished with 600 to 2000 water-lubricated grid paper and then fine polished with 0.3-μm alumina powder using an automatic grinding and polishing machine (Logitech, UK). Care was taken to keep the samples surface free from scratches as much as possible.

![Figure 2: A, a repeatable structural cell by Kowalczyk (2006); B, associated repeatable cubic cell used for the numerical models. Part A shows a 3D model of a structural cell with dimensions t_h, t_c, t_r, and t_e (unit). Part B shows a 3D model of a cubic cell with dimensions t_h, t_c, and t_r.](16d86083b7ebdc40c0647a1d3d46ace7_img.jpg)

Figure 2: A, a repeatable structural cell by Kowalczyk (2006); B, associated repeatable cubic cell used for the numerical models. Part A shows a 3D model of a structural cell with dimensions t\_h, t\_c, t\_r, and t\_e (unit). Part B shows a 3D model of a cubic cell with dimensions t\_h, t\_c, and t\_r.

**FIGURE 2** A, a repeatable structural cell by Kowalczyk (2006); B, associated repeatable cubic cell used for the numerical models ( $t_c=0.15$ ,  $t_h=0.35$ ,  $t_v=0.55$ , and  $t_e=1$ )

Samples were X-ray scanned using a SkyScan 1172 (Bruker microCT, Belgium). The data of the in-plane pixel sizes are reported in Table 2. Slice thicknesses (out-of-plane) were set to be the same as the in-plane pixel size. The CT images were processed with BoneJ<sup>51</sup> to obtain geometrical data over the regions of interest shown in Figure 3. The results for solid volume fractions, trabecular thicknesses, and trabecular spacing are shown in Table 2.

The elastic moduli of the trabecular tissues were measured via microindentation and nanoindentation tests using the method due to Oliver and Pharr.<sup>56</sup> Sample N1 was microindented in a TI 900 Triboindenter (Hysitron, Minnesota) using a Vickers diamond indenter. The maximum indentation load was set to 1500 mN, which was held constant for 45 seconds to minimize creep effects. The loading and unloading rates were set to 200 mN/s and 100 mN/s,

respectively. Reported results are the average of eight indentations. Sample N2 was not available for indentation, so it was assumed to have the same properties of N1. Rat specimens (samples N3 and N4) were nanoindented using a Berkovich diamond indenter. The maximum load was set to 1 mN and it was held constant for 30 seconds. Loading and unloading rates were set both equal to 0.1 mN/s. Grids of  $3 \times 3$  indentations separated by 5  $\mu\text{m}$  were performed on each specimen and the results averaged. The results for the material hardness and Young modulus are summarized in Table 3. A Poisson ratio  $\nu=0.3$  was assumed for all samples.

Data in Table 2 show that N3 and N4 do not exhibit small differences between their trabecular thickness and spacing. The differences in hardness and elastic modulus in Table 3 are 22% and 14%, respectively, but their standard deviations

**TABLE 1** Geometrical data of the artificial samples. Note that all dimensions are normalized with respect to the unit length in Figure 2A

| Sample | Volume Fraction, $\phi$ | $t_c$ | $t_h$ | $t_r$ | $t_e$ | Trabecular Thickness, $t$ | Trabecular Spacing, $s$ | Normalized Trabecular Thickness, $t/(t+s)$ |
|--------|-------------------------|-------|-------|-------|-------|---------------------------|-------------------------|--------------------------------------------|
| A1     | 0.07                    | 0.05  | 0.55  | 0.15  | 0.60  | 0.22                      | 3.06                    | 0.07                                       |
| A2     | 0.12                    | 0.10  | 0.10  | 0.35  | 1.20  | 0.27                      | 1.98                    | 0.12                                       |
| A3     | 0.28                    | 0.15  | 0.35  | 0.55  | 1.00  | 0.49                      | 1.91                    | 0.20                                       |
| A4     | 0.35                    | 0.25  | 0.30  | 0.50  | 1.20  | 0.74                      | 1.57                    | 0.32                                       |
| A5     | 0.50                    | 0.25  | 0.95  | 0.50  | 1.00  | 0.87                      | 1.40                    | 0.38                                       |

![Figure 3: Segmented CT scans of natural samples. (A) N1: Bovine femoral head, rectangular ROI. (B) N2: Bovine femoral head, circular ROI. (C) N3: Femur of Hokkaido rat, rectangular ROI with red arrows pointing to growth plates. (D) N4: Femur of Hokkaido rat, rectangular ROI with red arrows pointing to growth plates. All images show a complex porous trabecular structure. Scale bars in the bottom right of each image represent 100 μm.](7a3561af571faf036baa93f5f4b1bdb9_img.jpg)

Figure 3: Segmented CT scans of natural samples. (A) N1: Bovine femoral head, rectangular ROI. (B) N2: Bovine femoral head, circular ROI. (C) N3: Femur of Hokkaido rat, rectangular ROI with red arrows pointing to growth plates. (D) N4: Femur of Hokkaido rat, rectangular ROI with red arrows pointing to growth plates. All images show a complex porous trabecular structure. Scale bars in the bottom right of each image represent 100 μm.

**FIGURE 3** Segmented CT scans of the natural samples. A and B: bovine femoral heads, C and D: femurs of Hokkaido rats. Boxes indicate the ROIs. Reference lengths are 100  $\mu\text{m}$  long in all figures. Red arrows in C and D indicate growth plates

**TABLE 2** Geometrical data of the natural samples

| Sample | ROI Dimensions              | Pixel Size        | Solid Volume     | Trabecular                       | Trabecular Spacing,   | Normalized Trabecular |
|--------|-----------------------------|-------------------|------------------|----------------------------------|-----------------------|-----------------------|
|        | [mm]                        | [ $\mu\text{m}$ ] | Fraction, $\phi$ | Thickness, $t$ [ $\mu\text{m}$ ] | $s$ [ $\mu\text{m}$ ] | Thickness $t/(t+s)$   |
| N1     | $4.1 \times 6.5 \times 5.6$ | 5.96              | 0.39             | 200                              | 443                   | 0.31                  |
| N2     | $6.6 \times 6.6 \times 6.2$ | 6.62              | 0.51             | 315                              | 523                   | 0.38                  |
| N3     | $2.6 \times 3.5 \times 2.6$ | 8.70              | 0.27             | 150                              | 376                   | 0.29                  |
| N4     | $2.6 \times 2.6 \times 2.6$ | 8.70              | 0.30             | 152                              | 390                   | 0.28                  |

Abbreviation: ROI, regions of interest.

overlap. Differences can be attributed to natural variability among specimens and the different degrees of bone maturity. Since the implantation time of sample N4 is twice as long as that of N3, the higher solid volume fraction of the first one might be also a result of a longer maturity time during which the rate of tissue deposition is larger than the rate of resorption.<sup>54,57</sup> The data for the elastic modulus were averaged, and a single value was used for the numerical

homogenization analyses of both samples in the following sections.

## 3 | COMPUTATIONAL HOMOGENIZATION

The computational homogenization analysis uses the asymptotic method as reported by Hollister and Kikuchi.<sup>58</sup>

**TABLE 3** Hardness and elastic modulus obtained by microindentation and nanoindentation

| Sample           | Hardness [GPa] | Elastic modulus [GPa] |
|------------------|----------------|-----------------------|
| N1: Bovine bone  | 0.39 ± 0.02    | 7.93 ± 0.86           |
| N3: Rat bone     | 0.94 ± 0.22    | 26.59 ± 3.05          |
| N4: Rat bone     | 0.73 ± 0.19    | 23.28 ± 4.00          |
| Rat bone average | 0.85 ± 0.22    | 25.21 ± 3.64          |

The method considers 3 scales: the macroscale or continuum level where homogenized properties are valid, the scale of the sample used for computing such properties, and the microscale or microstructural scale, see Figure 1. The method also assumes that the principle of separation of scales is valid, ie, the characteristic length of the microscale, the trabecular thickness  $t$ , is much smaller than the characteristic length of the representative sample  $l$ , which in turn is also small when compared to the macroscale. In what follows, we assume that it is always possible to find a representative sample such that the separation of scales is attained, and we refer to it as the representative volume element (RVE).

Macroscopic stress and strain can be computed as the volume average of their microscopic counterparts over the domain  $V$  of the representative sample, this is

$$\sigma = \langle \sigma_{\mu} \rangle = \frac{1}{V} \int_V \sigma_{\mu} dV \quad \text{and} \quad \epsilon = \langle \epsilon_{\mu} \rangle = \frac{1}{V} \int_V \epsilon_{\mu} dV. \quad (2)$$

Microscopic stresses  $\sigma_{\mu}$  and strains  $\epsilon_{\mu}$  are related via the microscopic stiffness tensor  $\mathbb{C}_{\mu}$ , which varies across  $V$  according to the different phases in the microscale:

$$\sigma_{\mu} = \mathbb{C}_{\mu} \epsilon_{\mu}. \quad (3)$$

Following Kabel et al,<sup>50</sup> the elastic behavior of the materials in the microstructure are considered isotropic; hence, the microscopic stiffness tensor  $\mathbb{C}_{\mu}$  can be defined in terms of 2 elastic constants: the Young modulus  $E_{\mu}$  and the Poisson ratio  $\nu_{\mu}$ .

Although asymptotic homogenization is rigorously valid for periodic microstructures, ie those composed by repeated unit cells in the domain, Terada et al<sup>59</sup> showed that periodic boundary conditions can be applied to nonperiodic heterogeneous media to get estimates of the mechanical properties. In fact, they showed that results obtained using other boundary conditions converge to the results obtained using periodic boundary conditions when the size of the sample is big enough. Thus, the problem involves compatibility equations, linear elastic constitutive equations, equilibrium, and periodic conditions at the boundary of the RVE

$$\begin{cases} \epsilon_{\mu}(y) = \frac{1}{2} (\nabla u_{\mu}(y) + \nabla u_{\mu}^T(y)) & \forall y \in V \\ \sigma_{\mu}(y) = \mathbb{C}_{\mu}(y) : \epsilon_{\mu}(y) & \forall y \in V \\ \operatorname{div} \sigma_{\mu}(y) = 0 & \forall y \in V \\ u_{\mu}(y) - \epsilon \cdot y & \text{periodic} \\ \sigma_{\mu}(y) \cdot n & \text{antiperiodic} \end{cases} \quad (4)$$

where  $n$  is the outward normal vector to the boundary of  $V$ .

In general, the strain field in the macroscale is not known a priori. However, since the problem is linear, any arbitrary  $\epsilon$  may be written as a linear combination of 6 unit strains, which are defined in matrix form as

$$\begin{aligned} \epsilon_{pm}^{11} &= \begin{bmatrix} 1 & 0 & 0 \\ 0 & 0 & 0 \\ 0 & 0 & 0 \end{bmatrix}, \quad \epsilon_{pm}^{22} = \begin{bmatrix} 0 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 0 \end{bmatrix}, \quad \epsilon_{pm}^{33} = \begin{bmatrix} 0 & 0 & 0 \\ 0 & 0 & 0 \\ 0 & 0 & 1 \end{bmatrix} \\ \epsilon_{pm}^{12} &= \begin{bmatrix} 0 & 1 & 0 \\ 1 & 0 & 0 \\ 0 & 0 & 0 \end{bmatrix}, \quad \epsilon_{pm}^{13} = \begin{bmatrix} 0 & 0 & 1 \\ 0 & 0 & 0 \\ 1 & 0 & 0 \end{bmatrix} \text{ and } \epsilon_{pm}^{23} = \begin{bmatrix} 0 & 0 & 0 \\ 0 & 0 & 1 \\ 0 & 1 & 0 \end{bmatrix}, \end{aligned} \quad (5)$$

where the superscripts denote a loading case and the subscripts stand for the strain components.

Once the 6 microscopic strain states are known, the local structure tensor  $M_{ijklpm}$ , which relates the macroscopic strain  $\epsilon_{pm}$  and the microstructural total strain  $\epsilon_{ij}$ , can be calculated using

$$\epsilon_{ij} = M_{ijklpm} \epsilon_{pm}. \quad (6)$$

The homogenized elasticity tensor  $\mathbb{C}$  is then calculated from  $\mathbb{M}$ . Starting from the Equation 3, both sides are integrated over the RVE and divided by its volume to get

$$\frac{1}{V} \int_V \sigma_{\mu} dV = \frac{1}{V} \int_V \mathbb{C}_{\mu} \epsilon_{\mu} dV, \quad (7)$$

which combined with Equations 2 and 6 allows to write

$$\sigma = \left( \frac{1}{V} \int_V \mathbb{C}_{\mu} \mathbb{M} dV \right) \epsilon, \quad (8)$$

where we have made use of the fact that  $\epsilon$  is constant within the RVE. From the comparison of Equations 1 and 8, it is immediate to conclude that

$$\mathbb{C} = \frac{1}{V} \int_V \mathbb{C}_{\mu} \mathbb{M} dV. \quad (9)$$

The approach by Browaeys and Chevrot<sup>60</sup> is used to compute the norm and to explore the symmetries of  $\mathbb{C}$ . Browaeys and Chevrot<sup>60</sup> represent  $\mathbb{C}$  as an elastic vector  $X$  with 21 orthogonal components:

$$X = (C_{11}, C_{22}, C_{33}, \sqrt{2}C_{23}, \sqrt{2}C_{13}, \sqrt{2}C_{12}, 2C_{44}, 2C_{55}, 2C_{66}, 2C_{14}, 2C_{25}, 2C_{36}, 2C_{34}, 2C_{15}, 2C_{26}, 2C_{24}, 2C_{35}, 2C_{16}, 2\sqrt{2}C_{56}, 2\sqrt{2}C_{46}, 2\sqrt{2}C_{45}). \quad (10)$$

The normalization factors in the above expression are included so that the Euclidean norm of an arbitrary elastic tensor  $\mathbb{C}$  and its associated elastic vector  $X$  are identical.

Following Browaeys and Chevrot,<sup>60</sup> the method by Cowin and Mehrabadi<sup>61</sup> is used to express  $X$  in the orientation for optimal decomposition, the so-called symmetry Cartesian coordinate system. Then,  $X$  is decomposed by a cascade of projections into a sum of vectors belonging to the symmetry classes triclinic, monoclinic, orthorhombic, tetragonal, hexagonal, and isotropic,

$$X = X_{tric} + X_{mon} + X_{ort} + X_{tet} + X_{hex} + X_{iso}. \quad (11)$$

The above decomposition is suitable to address the dominant orthotropic symmetry behavior of the cancellous bone (see Section 1),  $X_{orthotropic} = X_{ort} + X_{tet} + X_{hex} + X_{iso}$ . Computations for the norm, optimal orientation, and the decomposition of the elasticity tensor are done using the Matlab Seismic Anisotropy Toolkit by Walker and Wookey.<sup>62</sup>

## 4 | HOMOGENIZATION ANALYSIS USING THE POLARIZATION-BASED FFT METHOD

The scheme by Monchiet and Bonnet<sup>37</sup> is used to implement the FFT method used in this work. Monchiet and Bonnet<sup>37</sup> reformulated the problem 4 in terms of the “polarization tensor,”

$$\tau(y) = (C_\mu(y) - C^0) : e_\mu(y), \quad (12)$$

to obtain

$$\left\{ \begin{array}{ll} e_\mu(y) = \frac{1}{2}(\nabla u_\mu(y) + \nabla u_\mu^T(y)) & \forall y \in V \\ \text{div} \sigma_\mu(y) = 0 & \forall y \in V \\ e_\mu(y) = (C_\mu(y) - C^0)^{-1} : \tau(y) & \forall y \in V \\ \sigma_\mu(y) = \tau(y) + C^0 : e_\mu(y) & \forall y \in V \\ u_\mu(y) - e_\mu y & \text{periodic} \\ \sigma_\mu(y) \cdot n & \text{antiperiodic} \\ \langle \tau(y) \rangle_V = T \end{array} \right. \quad (13)$$

where  $C^0$  is the stiffness tensor for a homogeneous reference medium. Note that the uniform polarization  $T$  is prescribed over the unit cell, and that, both, the macroscopic stress and strain,  $\sigma$  and  $e$ , are unknowns. However, because of the

linearity of the equations, macroscopic stress and strain are related as follows<sup>37</sup>:

$$\sigma = T + C^0 : e. \quad (14)$$

The solution of the problem in Equation 13 is found by discretizing the RVE into a regular grid consisting of  $N_1 \times N_2 \times N_3$  voxels in the directions  $y_1, y_2$  and  $y_3$ , respectively, and computed using the following discrete iterative scheme:

$$\left\{ \begin{array}{l} \hat{t}^i = F^{-1}(\hat{\tau}^i) \\ e_\mu^i(y_d) = (C_\mu(y_d) - C^0)^{-1} : \tau^i(y_d) \\ \hat{e}_\mu^i = F(e_\mu^i) \\ \hat{\sigma}_\mu^i(\xi_d) = C^0 : \hat{e}_\mu^i(\xi_d) + \hat{t}^i(\xi_d) \\ \text{Convergence tests} \\ \hat{t}^{i+1}(\xi_d) = \hat{t}^i(\xi_d) - \alpha C^0 : \hat{\Gamma}^0(\xi_d) : \hat{\sigma}_\mu^i(\xi_d) - \beta \hat{\Delta}^0(\xi_d) : \hat{e}_\mu^i(\xi_d) \end{array} \right. \quad (15)$$

where  $\hat{\Gamma}^0$  and  $\hat{\Delta}^0$  are respectively the periodic Green tensors for strain and stress (see expressions A1 and A2 in Appendix 1);  $\mathcal{F}$  and  $\mathcal{F}^{-1}$  denote the Fourier transform and its inverse, while the  $\hat{\cdot}$  is used to indicate that variables are in the Fourier space; vectors  $y_d$  are the discrete coordinates of the voxels in the real space and  $\xi_d$  are their corresponding  $N_1 \times N_2 \times N_3$  frequencies in Fourier space;  $\alpha$  and  $\beta$  are coefficients, which are chosen thereafter to obtain the best rate of convergence. It is interesting to observe that the above scheme reduces to the Eyre-Milton<sup>35</sup> and augmented Lagrangian<sup>36</sup> schemes when the coefficients  $\alpha$  and  $\beta$  are set to  $\alpha = \beta = 2$  and  $\alpha = \beta = 1$ , respectively.<sup>32,33</sup>

The iterative scheme 15 converges when stress  $\sigma_\mu^i$  and strain  $e_\mu^i$  are respectively equilibrated and compatible fields, and the average strain equals the prescribed macroscopic strain  $e_\mu^i(y)_V = e$ .<sup>38</sup> Moulinec and Silva<sup>38</sup> did a comprehensive review and analysis of the conditions for the convergence of the iterative scheme, and they summarized the sufficient conditions for convergence. Unfortunately, they could not demonstrate the convergence of the method for the case of microstructures with voids and rigid inclusions (ie, microstructures with infinite contrast). On the other hand, Michel et al.<sup>31,34</sup> and Bilger et al.<sup>40</sup> used the augmented Lagrangian scheme to perform analyses for materials with voids and rigid inclusions that did converge.

The optimal choice of  $\alpha$  and  $\beta$  to minimize the number of iterations is a very difficult task that depends on elastic properties, model resolution, and geometry.<sup>32,33</sup> In general,

the convergence rate reduces markedly with the increase of the contrast between the elastic properties of the microstructure phases. High-contrast cases are of particular interest for this work as cancellous microstructures consists of a solid and a void phase. In the absence of a formal demonstration yielding to the convergence of the iterative scheme for infinite contrast microstructures,<sup>38</sup> the mechanical response of the void phase is mimicked using very compliant elastic properties, what results in high, but finite, contrast models. Moulinec and Silva<sup>38</sup> studied the dependency of the rate of convergence with the contrast for different settings of the iterative scheme 15. They found that for high-contrast models, the Eyre-Milton ( $\alpha=\beta=2$ ) and the polarization-based scheme with  $\alpha=\beta=1.5$  present the highest convergence rates (both settings converge at the same rate). Based on these results, the polarization-based scheme with  $\alpha=\beta=1.5$  was chosen for this work. The selection of the stiffness for the void phase that results in reasonable balance between accuracy and computational performance will be addressed in next section.

The convergence criteria consist on comparing the deviations from equilibrium, compatibility, and the prescribed loading conditions in the Fourier space with a prescribed tolerance  $\epsilon = 10^{-4}$ . The expressions for the convergence criteria in the Fourier space can be found in Appendix 2.

The scheme 15 was implemented in-house according to the memory-saving algorithm by Moulinec and Silva.<sup>38</sup> The algorithm was programmed in C, and a suitable parallel code was obtained using OpenMP. Two computers were used to test the implementation, a HP ML350p equipped with 2 Intel E5-2620 Xeon processors and 136GB of RAM, and a Dell PowerEdge C6145 equipped with 4 AMD Opteron 6276s processors and 128GB of RAM. Depending on the load case, the solution of a model consisting of  $128 \times 128 \times 128$  voxels needed of around 950 iterations. The solution time was around 2 hours per load case in the HP system in sequential mode (1 processor), while in parallel mode, a maximum of  $2\times$  speedup was achieved using 4 logical processors. A model consisting of  $300 \times 300 \times 300$  voxels was used to test the algorithm in the Dell system. The number of iterations for that model were around 830 iterations, depending on the load case. Computation times were between 36 and 45 hours in sequential mode; a maximum of  $3\times$  speedup was achieved with 8 logical processors. In what respects to the memory requirement, it increased linearly with the number of voxels according to the following equation

$$\text{Memory [GB]} = 1.57^* \frac{\text{Number of voxels}}{1 \times 10^6}. \quad (16)$$

For the homogenization, the 6 load cases in Equation 5 are solved using the scheme 15, and the corresponding results

are replaced in Equation 6 to compute the structure tensor  $\mathbb{M}^p$  for every voxel in the model. To this end, a system of equations is set for each load case using the macroscopic strains  $\epsilon_{pm}^{kl}$  and their corresponding strains  $\epsilon_{\mu ij}^{kl}$  at the micro-scale:

$$\begin{Bmatrix} \epsilon_{ij}^{11} \\ \epsilon_{ij}^{22} \\ \epsilon_{ij}^{33} \\ \epsilon_{ij}^{12} \\ \epsilon_{ij}^{13} \\ \epsilon_{ij}^{23} \end{Bmatrix} = \begin{bmatrix} \epsilon_{\mu 11}^{11} & \epsilon_{\mu 22}^{11} & \epsilon_{\mu 33}^{11} & \epsilon_{\mu 12}^{11} & \epsilon_{\mu 13}^{11} & \epsilon_{\mu 23}^{11} \\ \epsilon_{\mu 11}^{22} & \epsilon_{\mu 22}^{22} & \epsilon_{\mu 33}^{22} & \epsilon_{\mu 12}^{22} & \epsilon_{\mu 13}^{22} & \epsilon_{\mu 23}^{22} \\ \epsilon_{\mu 11}^{33} & \epsilon_{\mu 22}^{33} & \epsilon_{\mu 33}^{33} & \epsilon_{\mu 12}^{33} & \epsilon_{\mu 13}^{33} & \epsilon_{\mu 23}^{33} \\ \epsilon_{\mu 11}^{12} & \epsilon_{\mu 22}^{12} & \epsilon_{\mu 33}^{12} & \epsilon_{\mu 12}^{12} & \epsilon_{\mu 13}^{12} & \epsilon_{\mu 23}^{12} \\ \epsilon_{\mu 11}^{13} & \epsilon_{\mu 22}^{13} & \epsilon_{\mu 33}^{13} & \epsilon_{\mu 12}^{13} & \epsilon_{\mu 13}^{13} & \epsilon_{\mu 23}^{13} \\ \epsilon_{\mu 11}^{23} & \epsilon_{\mu 22}^{23} & \epsilon_{\mu 33}^{23} & \epsilon_{\mu 12}^{23} & \epsilon_{\mu 13}^{23} & \epsilon_{\mu 23}^{23} \end{bmatrix}_p \begin{Bmatrix} \mathbb{M}_{ij11}^p \\ \mathbb{M}_{ij22}^p \\ \mathbb{M}_{ij33}^p \\ \mathbb{M}_{ij12}^p \\ \mathbb{M}_{ij13}^p \\ \mathbb{M}_{ij23}^p \end{Bmatrix}_p. \quad (17)$$

Once  $\mathbb{M}^p$  is known for every voxel, the homogenized stiffness tensor is calculated using the discrete version of Equation 9:

$$\mathbb{C} = \frac{1}{\sum_{p=1}^N V_p} \sum_{p=1}^N \mathbb{C}_\mu^p \mathbb{M}^p V_p = \frac{1}{N} \sum_{p=1}^N \mathbb{C}_\mu^p \mathbb{M}^p \quad (18)$$

where  $N$  is the number of voxels within the RVE and  $V_p$  are their volumes. Note that, in Equation 18, we made use of the fact that the volumes of all voxels are identical. The computations for the homogenization analysis were coded in Matlab.

## 5 | MODEL CONSTRUCTION

Models for the FFT analyses are constructed from stacks of 2-dimensional images of the microstructures. In the case of natural samples, images are obtained directly from micro-CT scans, while for the artificial samples they are produced synthetically from the cell geometry (see Section 2.1). In both cases, the images are resized using region averaging to create a “box” of dimensions  $N_1 \times N_2 \times N_3$ . Every voxel is identified as belonging to the bone tissue or to the void phase. Two approaches are considered for the specification of the threshold for the image segmentation: (1) it is set equal to that used for the determination of the solid volume fraction of the specimen (see Section 2.2); and (2) it is adjusted individually for each model such that its volume fraction matches that measured for the specimen.<sup>63</sup> Figure 4 illustrates a typical model of a natural specimen.

The voxels in the loci of the solid phase have the mechanical properties of the bone tissue reported in Table 3. As mentioned earlier, the mechanical response of the void phase is mimicked using very compliant elastic

![Figure 4: A 3D visualization of a complex, porous material structure, likely a bone sample, represented by a mesh of voxels. The structure is dark gray with many interconnected voids.](0ba998c66ef6a980bac9c0c12e9452bf_img.jpg)

Figure 4: A 3D visualization of a complex, porous material structure, likely a bone sample, represented by a mesh of voxels. The structure is dark gray with many interconnected voids.

**FIGURE 4** Model for the Fast Fourier Transform analysis of sample N3. Geometry representation using  $135 \times 135 \times 135$  voxels

properties. Preliminary tests were performed for the selection of the stiffness for the void phase that results in reasonable balance between accuracy and computational performance. To this end, a model for a solid cubic unit cell with a cylindrical hole of radius  $r/L=0.47$  (volume fraction  $\phi=0.30$ ) was solved for a wide range of contrasts between the bulk moduli  $k$  of the void and the solid phase,

$$\theta = \frac{k_{\text{void}}}{k_{\text{solid}}}. \quad (19)$$

The model was discretized using  $N_1=N_2=N_3=51$  voxels. The bulk modulus for the reference material was set to  $k^0=(k_{\text{solid}}+k_{\text{void}})/2$  and the shear modulus  $\mu^0=(\mu_{\text{solid}}+\mu_{\text{void}})/2$ . The results for the normalized norm of the homogenized stiffness tensor,  $\|C\|/\|C_{\text{solid}}\|$ , and the number of iterations in terms of  $\theta$  are presented in Figure 5A and Figure 5B, respectively. The reference value  $\|C\|/\|C_{\text{solid}}\|=0.50$  in Figure 5A was computed using PREMAT<sup>64</sup> with a high-resolution FEA model. Based on the ad hoc criterion that  $\|C\|/\|C_{\text{solid}}\|$  changes less than 1% over the range  $10^{-4} \leq \theta \leq 10^{-8}$ , the value  $\theta=10^{-4}$  is selected as a trade-off between the accuracy and performance of the computations. The result  $\|C\|/\|C_{\text{solid}}\|=0.48$  for  $\theta=10^{-4}$  differs by less than 4% with respect to the PREMAT result. No attempt was made to refine the model. The effects of the voxel size on the results of the computational homogenization procedure will be assessed in Section 6.

## 6 | RESULTS

### 6.1 | Artificial samples

The first analyses aim to assess the effect of the voxel size  $d$  on the accuracy of the FFT method. To draw conclusions independently of the error in the representation of the geometry that arises from the segmentation, analyses are performed for models constructed using images with resolutions coarse enough to produce geometries that are exactly represented by all the voxel sizes. Each of the 5 artificial specimens were solved using 7 voxel sizes in the range  $0.02 \leq d/L \leq 0.4$ . The resultant models had from  $40 \cdot 10^3$  to  $20 \cdot 10^6$  voxels. Results of the convergence analyses for the norm of the stiffness tensors  $\|C\|/\|C_{0.02}\|$  are plot in Figure 6. The normalizing factor  $\|C_{0.02}\|$  is the norm of the stiffness tensor computed with the smallest voxel size  $d/L=0.02$ . It can be observed from Figure 6 that, in all the cases, norms of the stiffness tensors attain voxel-size independent values. Results for voxel sizes  $d/L \leq 0.05$  have

![Figure 5: Two plots showing the relationship between stiffness contrast and computational results. Plot A shows the normalized norm of the homogenized stiffness tensor, and Plot B shows the number of iterations.](4495fbec19aac6861f1a0b35c4dc38bc_img.jpg)

**Figure 5A: Normalized norm of the homogenized stiffness tensor**

| Stiffness contrast between phases, $\theta$ | Normalized norm of the homogenized stiffness tensor, $\ C\ /\ C_{\text{solid}}\ $ |
|---------------------------------------------|-----------------------------------------------------------------------------------|
| $1.E-08$                                    | ~0.475                                                                            |
| $1.E-06$                                    | ~0.478                                                                            |
| $1.E-04$                                    | ~0.480                                                                            |
| $1.E-02$                                    | ~0.495                                                                            |
| $1.E+00$                                    | ~0.530                                                                            |

**Figure 5B: Number of iterations**

| Stiffness contrast between phases, $\theta$ | Number of iterations |
|---------------------------------------------|----------------------|
| $1.E-08$                                    | ~1.0E+05             |
| $1.E-06$                                    | ~1.0E+04             |
| $1.E-04$                                    | ~1.0E+03             |
| $1.E-02$                                    | ~1.0E+02             |
| $1.E+00$                                    | ~1.0E+00             |

Figure 5: Two plots showing the relationship between stiffness contrast and computational results. Plot A shows the normalized norm of the homogenized stiffness tensor, and Plot B shows the number of iterations.

**FIGURE 5** A, norm of the homogenized stiffness tensor and B, number of iterations as functions of the stiffness contrast between the phases

![Figure 6: A scatter plot showing the normalized stiffness tensor, ||C||/||C_0.02||, as a function of normalized voxel size, d/t, for artificial samples A1 through A5. The y-axis ranges from 0.00 to 1.20, and the x-axis ranges from 0.00 to 0.30. Data points for A1 (open circle), A2 (open square), A3 (open triangle), A4 (open diamond), and A5 (cross) are plotted. Most points are clustered around a value of 1.00, with some deviation for A5 at higher voxel sizes.](f519a5be118c846f631c992412353fb9_img.jpg)

Figure 6: A scatter plot showing the normalized stiffness tensor, ||C||/||C\_0.02||, as a function of normalized voxel size, d/t, for artificial samples A1 through A5. The y-axis ranges from 0.00 to 1.20, and the x-axis ranges from 0.00 to 0.30. Data points for A1 (open circle), A2 (open square), A3 (open triangle), A4 (open diamond), and A5 (cross) are plotted. Most points are clustered around a value of 1.00, with some deviation for A5 at higher voxel sizes.

**FIGURE 6** Artificial samples. Normalized norm of the stiffness tensor as a function of the normalized voxel size. Results of models without geometry representation error

a deviation less than 1% from  $\|C_{0.02}\|$ , whereas for  $d/t \leq 0.10$  the deviations are less than 5%.

The effects of the geometry representation error are assessed in Figure 7. To keep the figure clear, results are presented only for A3 and A5, the samples that resulted with the largest deviations from the reference solid volume fractions when segmented using a fixed threshold value (segmentation approach (1) in Section 5). As it can be observed from Figure 7, solid volume fractions converge linearly to the references values either by excess (A3) or by defect (A5). For example, the solid volume fraction of A5 has a deficit of approximately 15% with respect to the reference when the voxel size is  $d/t = 0.1$ .

Figure 8 depicts the results for the convergence analyses of the normalized stiffness tensors  $\|C\|/\|C_{FEM}\|$  for the 2 segmentation strategies introduced in Section 5. The normalization factor  $\|C_{FEM}\|$  for each sample is the norm of the stiffness tensors computed by Kowalczyk<sup>41</sup> using FEM. It can be observed that in  $\|C\|$  converges linearly with the voxel

![Figure 7: A scatter plot showing the normalized solid volume fraction, phi/phi_ref, as a function of normalized voxel size, d/t, for natural and artificial samples A3, A5, N2, and N4. The y-axis ranges from 0.80 to 1.15, and the x-axis ranges from 0.00 to 0.35. Data points for A3 (open square), A5 (cross), N2 (open circle), and N4 (cross) are plotted. A3 shows an increasing trend, while A5, N2, and N4 show a decreasing trend as voxel size increases.](df476ed6ad0bb890c67aa63e7647d071_img.jpg)

Figure 7: A scatter plot showing the normalized solid volume fraction, phi/phi\_ref, as a function of normalized voxel size, d/t, for natural and artificial samples A3, A5, N2, and N4. The y-axis ranges from 0.80 to 1.15, and the x-axis ranges from 0.00 to 0.35. Data points for A3 (open square), A5 (cross), N2 (open circle), and N4 (cross) are plotted. A3 shows an increasing trend, while A5, N2, and N4 show a decreasing trend as voxel size increases.

**FIGURE 7** Solid volume fraction as a function of the normalized voxel size for the natural and artificial samples

![Figure 8: A scatter plot showing the normalized stiffness tensor, ||C||/||C_FEM||, as a function of normalized voxel size, d/t, for artificial samples A2 through A5. The y-axis ranges from 0.75 to 1.05, and the x-axis ranges from 0.00 to 0.20. Data points for A2 (open square), A3 (open triangle), A4 (open circle), and A5 (cross) are plotted. Two lines represent the 'Fixed threshold' (dashed) and 'Variable threshold' (solid) segmentation strategies. All data series show a linear decrease as voxel size increases.](58de972a8c79c238b69cbeeafcc8d5fb_img.jpg)

Figure 8: A scatter plot showing the normalized stiffness tensor, ||C||/||C\_FEM||, as a function of normalized voxel size, d/t, for artificial samples A2 through A5. The y-axis ranges from 0.75 to 1.05, and the x-axis ranges from 0.00 to 0.20. Data points for A2 (open square), A3 (open triangle), A4 (open circle), and A5 (cross) are plotted. Two lines represent the 'Fixed threshold' (dashed) and 'Variable threshold' (solid) segmentation strategies. All data series show a linear decrease as voxel size increases.

**FIGURE 8** Artificial samples: normalized norm of the stiffness tensor as a function of the normalized voxel size. Results for the A1 sample were not calculated because it was not possible to compute models with the sizes needed to get  $d/t \leq 0.10$  (more than  $10^6$  voxels) with the available computing resources

size for every case. The 2 segmentation strategies behave almost the same; they lead to nearly identical results when extrapolated to 0 voxel size. Moreover, extrapolated results are in excellent agreement to reference values by Kowalczyk,<sup>41</sup> maximum differences are less than 2% for sample A2. Results in Figure 8 allow to conclude that, irrespectively of the segmentation strategy, the linear extrapolation of the values computed for 2 models with  $d/t \leq 0.10$  can be used to produce accurate estimations of the homogenized stiffness tensor.

### 6.2 | Natural samples

The model size is a key issue for the homogenization analysis of the natural samples. The 1-dimensional probabilistic model of the tissue microstructure due to Harrigan et al<sup>65</sup> is used to estimate representative model sizes. Based on the assumption that bulk stress and strain are volumetric averages of the stress and strain within the constituents of the microstructure, see Equation 2, Harrigan et al<sup>65</sup> propose that the length scales of stresses and strains are similar to that of the solid volume fraction.

Figure 9 shows the mean values and standard deviations of the solid linear fraction as functions of the normalized scanned length,  $\ell/(t+s)$ , for samples N2 (bovine femoral head) and N4 (femur of adult rat). Each data point in Figure 9 is the result of 300 linear scans along lines oriented in the orthogonal directions  $y_1, y_2$  and  $y_3$  and with origins at random locations. These analyses are done using the maximum resolution of the CT-scans reported in Table 2. For comparison purposes, Figure 9 also presents the (volumetric) solid volume fractions determined in Section 2.2. Figure 9A shows that, for the sample N2, the mean value of the solid linear fraction and its standard

![Figure 9: Mean and standard deviation of the linear solid fraction as functions of normalized line length for artificial samples A, N2 and B, N4. (A) Sample N2: Y-axis 'Linear solid fraction' (0.00 to 0.60), X-axis 'Normalized scanned length, l/(t+s)' (0 to 8). (B) Sample N4: Y-axis 'Linear solid fraction' (0.00 to 0.50), X-axis 'Normalized scanned length, l/(t+s)' (0 to 5). Both plots show mean value (solid line), standard deviation (open squares), and solid volume fraction (solid horizontal line).](10c82dcc5f2c237961329dd29d65859c_img.jpg)

Figure 9 consists of two subplots, (A) and (B), showing the mean and standard deviation of the linear solid fraction as functions of normalized scanned length,  $l/(t+s)$ .

Subplot (A) is for sample N2. The y-axis represents the 'Linear solid fraction' ranging from 0.00 to 0.60. The x-axis represents the 'Normalized scanned length,  $l/(t+s)$ ' ranging from 0 to 8. The legend indicates: Mean value (solid line), Standard deviation (open squares), and Solid volume fraction (solid horizontal line). The mean value starts at approximately 0.52 and remains relatively constant. The standard deviation starts at approximately 0.40 and decreases rapidly, converging towards the mean value as the scanned length increases. The solid volume fraction is indicated by a horizontal line at approximately 0.52.

Subplot (B) is for sample N4. The y-axis represents the 'Linear solid fraction' ranging from 0.00 to 0.50. The x-axis represents the 'Normalized scanned length,  $l/(t+s)$ ' ranging from 0 to 5. The legend indicates: Mean value (solid line), Standard deviation y1 (open squares), Standard deviation y2 (open triangles), Standard deviation y3 (open diamonds), and Solid volume fraction (solid horizontal line). The mean value starts at approximately 0.30 and remains relatively constant. The standard deviations (y1, y2, y3) start at approximately 0.45, 0.35, and 0.30 respectively and decrease rapidly, converging towards the mean value as the scanned length increases. The solid volume fraction is indicated by a horizontal line at approximately 0.30.

Figure 9: Mean and standard deviation of the linear solid fraction as functions of normalized line length for artificial samples A, N2 and B, N4. (A) Sample N2: Y-axis 'Linear solid fraction' (0.00 to 0.60), X-axis 'Normalized scanned length, l/(t+s)' (0 to 8). (B) Sample N4: Y-axis 'Linear solid fraction' (0.00 to 0.50), X-axis 'Normalized scanned length, l/(t+s)' (0 to 5). Both plots show mean value (solid line), standard deviation (open squares), and solid volume fraction (solid horizontal line).

**FIGURE 9** Mean and standard deviation of the linear solid fraction as functions of normalized line length for artificial samples A, N2 and B, N4

deviation are direction independent. The linear solid fraction rapidly converges towards the solid volume fraction. Differences between the solid linear fractions and the reference value are smaller than 6% for scanned lengths larger than 5 intertrabecular lengths. The standard deviation diminishes exponentially with the scanned length, flattening out at approximately 4 intertrabecular lengths. The maximum value for the dispersion is about 20% of the mean value.

Results for the mean solid linear fraction of sample N4 in Figure 9B are like those of sample N2. Discrepancies between the solid linear fraction and the reference volume solid fraction are below 10% for scanned lengths larger than 4 intertrabecular distances. On the other hand, the standard deviation depends on the direction of analysis. Directions  $y_1$  and  $y_3$  behave similarly; they both converge towards a

standard deviation of about 60% the mean value. The  $y_2$ -direction converges to a standard deviation of around 26% the mean value. Based on the above results, it is concluded that scanned lengths  $\ell/(t+s) \geq 4$  allow for size-independent values of the mean values and standard deviations of the solid volume fractions. Samples N1 and N3 show analogous behaviors to N2 and N4, respectively; they are not plot due to space limitations.

The bone type and the relative sizes of the specimens affect the results obtained in terms of linear solid fraction for the 2 sets of samples. Samples N1 and N2 are relatively small when compared to the diaphysis of the femur from which they were obtained, so they might be considered as RVEs. On the other hand, samples N3 and N4 span over large portions of the entire distal section of the rat femurs, so they do not satisfy the scale separation hypothesis. The anisotropy and larger dispersion of the results for samples N3 and N4 can be explained by the presence of the growth plates observed in Figure 3C,D. Therefore, samples N3 and N4 cannot be considered RVEs, but they are suitable for the computation of apparent elastic properties.

The effect of the voxel size on the accuracy of the homogenization method was assessed for the natural samples. Three convergence analyses were conducted: the convergence of the FFT method when models are free of geometry representation error, the error of the segmentation procedure, and the convergence rate of the overall homogenization procedure.

Convergence of the FFT method when free of the geometry representation errors was assessed using series of models with voxel sizes  $0.03 \leq dt \leq 0.3$ . Results for the norm of the stiffness tensors,  $\|C\|$ , were compared to the solution computed for the smallest voxels size,  $\|C_{0.03}\|$ . Quotients  $\|C\|/\|C_{0.03}\|$  as functions of voxel sizes for the different samples behave similarly to those of the artificial samples in Figure 6:  $\|C\|/\|C_{0.03}\| \leq 0.98$  for  $dt \leq 0.05$  and  $\|C\|/\|C_{0.03}\| \leq 0.90$  for  $dt \leq 0.10$ .

The results for the geometry representation error for the segmentation procedure (1) are shown in Figure 7 for samples N2 and N4. The comparison with the artificial samples show that natural samples are less sensitive to voxel size than artificial samples. Note, for instance, that for a voxel size  $dt = 0.1$  the errors in the solid volume fractions of the natural samples are around 2%, while for the artificial samples they can reach 15%. These results are attributed to the differences in the geometric periodicity and smoothness between the 2 sets of samples. When discretized with regular voxel arrays, the periodic and smooth geometries of artificial samples result in consistent mismatches (either in excess or in deficit of solid volume) between the actual sample geometries and their voxel representations. On the other hand, the irregular geometries of natural samples result in a combination of local excess and deficit mismatches that compensate over the whole model domain.

The convergence analyses for the complete homogenization procedure followed a strategy similar to that of the artificial samples. Since no reference solutions were available,  $\|C\|$  were computed for the natural samples N1 and N2 using progressively smaller voxel sizes and the results compared to those of the smallest voxel size,  $dlt=0.06$ , in terms of the quotient  $\|C\|/\|C_{0.06}\|$ . When plotted as functions of  $dlt$ ,  $\|C\|/\|C_{0.06}\|$  exhibit linear behaviors like that of the artificial samples in Figure 8. Results for models with voxel sizes  $dlt < 0.10$  allow for accurate linear extrapolations of the components of the stiffness tensor. In fact, under these conditions, the linear fits have coefficients of determination  $R^2$  higher than 0.99.

Based on the previous results, the stiffness matrices for N1 and N2 are computed via the extrapolation to 0 voxel size of 2 sets of results of models with  $dlt < 0.10$ . The stiffness matrices expressed in the symmetry Cartesian coordinate system (see Section 3) are

$$C_{N1} = \begin{bmatrix} 0.9924 & 0.4030 & 0.4398 & 0.0378 & 0.0134 & 0.0063 \\ 0.4030 & 1.4566 & 0.4773 & -0.0041 & -0.0020 & 0.0171 \\ 0.4398 & 0.4773 & 1.8418 & -0.0139 & -0.0092 & 0.0005 \\ 0.0378 & -0.0041 & -0.0139 & 0.4657 & -0.0417 & -0.0042 \\ 0.0134 & -0.0020 & -0.0092 & -0.0417 & 0.5450 & -0.0093 \\ 0.0063 & 0.0171 & 0.0005 & -0.0042 & -0.0093 & 0.3493 \end{bmatrix} [GPa] \quad (20)$$

$$\text{and } C_{N2} = \begin{bmatrix} 1.8765 & 0.5059 & 0.7400 & 0.0283 & -0.0906 & 0.0484 \\ 0.5059 & 2.2795 & 1.0195 & 0.0817 & 0.0554 & -0.0410 \\ 0.7400 & 1.0195 & 2.6216 & -0.0747 & 0.0624 & -0.0178 \\ 0.0283 & 0.0817 & -0.0747 & 0.8846 & 0.0010 & 0.0065 \\ -0.0906 & 0.0554 & 0.0624 & 0.0010 & 0.8174 & -0.0363 \\ 0.0484 & -0.0410 & -0.0178 & 0.0065 & -0.0363 & 0.6703 \end{bmatrix} [GPa]. \quad (21)$$

Figure 10 shows the symmetry classes decomposition of the stiffness matrices in Equations 20 and 21. It is observed that the isotropic class accounts for the most

![Figure 10: Stacked bar chart showing the decomposition of the stiffness tensors of natural samples N1, N2, N3, and N4 into symmetry classes. The Y-axis represents the 'Fraction of the total norm' from 0.00 to 1.00. The X-axis lists the samples N1, N2, N3, and N4. The legend indicates the following symmetry classes: Isotropic (blue), Hexagonal (dark grey), Tetragonal (medium grey), Orthorhombic (light grey), Monoclinic (white), and Triclinic (black). For N1, the isotropic class is approximately 0.80. For N2, it is approximately 0.85. For N3, it is approximately 0.60. For N4, it is approximately 0.45.](624d9669faa18991d525fea5f0e03269_img.jpg)

Figure 10: Stacked bar chart showing the decomposition of the stiffness tensors of natural samples N1, N2, N3, and N4 into symmetry classes. The Y-axis represents the 'Fraction of the total norm' from 0.00 to 1.00. The X-axis lists the samples N1, N2, N3, and N4. The legend indicates the following symmetry classes: Isotropic (blue), Hexagonal (dark grey), Tetragonal (medium grey), Orthorhombic (light grey), Monoclinic (white), and Triclinic (black). For N1, the isotropic class is approximately 0.80. For N2, it is approximately 0.85. For N3, it is approximately 0.60. For N4, it is approximately 0.45.

**FIGURE 10** Decomposition of the stiffness tensors of the natural samples in their symmetry classes

significant fractions (78% and 83% for N1 and N2, respectively) of the stiffness matrices. Other relevant contributions are the hexagonal (9% and 6%), orthorhombic (7% and 4%), and triclinic (3% and 7%) classes. On the other hand, tetragonal and monoclinic classes have minor contributions, less than 2%. It is interesting to note that the overall orthotropic symmetry, given by the sum of the isotropic, hexagonal, tetragonal, and orthorhombic classes, adds up 95% for N1 and 93% for N2. These results are in excellent agreement with the 95% orthotropic elastic symmetry of the human trabecular bone reported by van Rietbergen and Huiskes.<sup>49</sup>

The stiffness matrices for N3 and N4, also expressed in their symmetry Cartesian coordinate systems, are

$$C_{N3} = \begin{bmatrix} 0.4924 & 0.1716 & 0.3116 & -0.0411 & -0.0600 & 0.0400 \\ 0.1716 & 1.2586 & 0.4481 & 0.0015 & 0.0037 & 0.0358 \\ 0.3116 & 0.4481 & 1.8429 & -0.0096 & 0.0654 & -0.0902 \\ -0.0411 & 0.0015 & -0.0096 & 0.6102 & -0.0581 & -0.0130 \\ -0.0600 & 0.0037 & 0.0654 & -0.0581 & 0.2365 & 0.0386 \\ 0.0400 & 0.0358 & -0.0902 & -0.0130 & 0.0386 & 0.3771 \end{bmatrix} [GPa] \quad (22)$$

and

$$C_{N4} = \begin{bmatrix} 0.4028 & 0.2245 & 0.2498 & 0.0035 & -0.0278 & 0.0551 \\ 0.2245 & 1.8178 & 0.6833 & 0.0565 & -0.0280 & 0.0164 \\ 0.2498 & 0.6833 & 3.0901 & -0.0661 & 0.0303 & -0.0216 \\ 0.0035 & 0.0565 & -0.0661 & 0.9328 & -0.1265 & 0.0246 \\ -0.0278 & -0.0280 & 0.0303 & -0.1265 & 0.3018 & 0.0172 \\ 0.0551 & 0.0164 & -0.0216 & 0.0246 & 0.0172 & 0.2356 \end{bmatrix} [GPa] \quad (23)$$

The results for the symmetry class decompositions are shown in Figure 10. The overall orthotropic symmetries for N3 and N4 are 88% and 90%, respectively. These values are slightly lower than those found for N1 and N2. There are also differences between the relative fractions of the symmetry classes. Although isotropic symmetry makes the largest contributions to the stiffness matrices of samples N3 and N4, their contributed percentages, 59% and 46%, are lower than for samples N1 and N2. Increments in the hexagonal symmetry, which rise to 15% for N3 and to 26% for N4, compensate the reduction in the isotropy. The higher elastic anisotropy of N3 and N4 with respect to N1 and N2 is consistent with the anisotropy of the linear solid fraction observed for N4 above in this section.

## 7 | CONCLUSIONS

The polarized-based FFT method of Monchiet and Bonnet<sup>37</sup> and asymptotic homogenization were used in combination with micro-CT scans and nanoindentation tests to compute the effective elastic properties of cancellous bone. The

performance of the method was investigated for natural and artificial bone microstructures.

Model geometries were built directly from micro-CT scans. It is found that the geometry representation error, measured as the discrepancy between the model and the actual solid volume fraction, is smaller for the natural microstructures than for the artificial ones. Voxel sizes equal to one-tenth the trabecular thickness,  $d/t \leq 0.1$ , resulted in errors less than 2% for the natural samples. Artificial samples required of voxel sizes approximately 5-time smaller to attain the same level of accuracy. These results are attributed to differences in periodicity and smoothness between natural and artificial bone microstructures. Because of the regular voxel array, the periodic and smooth artificial microstructures result in consistent mismatches (either in excess or in deficit) between the actual sample geometries and their voxel representations. On the other hand, the irregular geometry of natural bone results in a combination of local excess and deficiency mismatches that compensate over the whole domain. In every case, the geometry representation errors converge linearly to 0 as voxel sizes go to 0.

The elastic response of the void phase was mimicked using a very compliant material. Based on the results for a benchmark problem, it was concluded that the compliance for the void phase must be set, at least,  $10^4$  times that of the bone tissue to attain homogenized stiffness tensor with errors less than 1%. This setting results in a reasonable trade-off between accuracy and the computational cost (number of iterations) for the FFT method.

It was found that, in absence of geometry representation errors, the results for the effective homogenized stiffness tensor are independent of the voxel size for models with  $d/t \leq 0.05$ . Besides, when the geometry representation error is considered, the effective elastic properties can be accurately estimated via the linear extrapolation of the results computed using 2 models with voxel size  $d/t \leq 0.10$ .

The above guidelines have proven effective to deal with both, artificial and natural microstructures. The results for the homogenized stiffness tensors of the artificial microstructures showed discrepancies smaller than 2% with respect to the FE computations by Kowalczyk.<sup>41</sup> For its part, the symmetry classes of the stiffness tensors computed for the bovine femoral-head samples were in excellent agreement with those reported by van Rietbergen and Huiskes.<sup>49</sup> For the implanted Hokkaido rat femurs, the sample sizes only allowed for the computation of apparent elastic properties. Anyway, the results were consistent with measurements of the linear solid fraction anisotropy.

Overall, this study has shown that the FFT method is suitable to estimate the fully anisotropic elastic response of

cancellous bone using data from micro-CT images and nanoindentation tests. The method is computationally efficient, it avoids meshing, which makes model construction very fast, versatile, and robust. These characteristics make the method very attractive to automate the systematic analysis of a series of microstructures. Moreover, the recent work by Ly et al.<sup>33</sup> provides the means to extend the FFT method to the computation of the cancellous bone permeability, which is an important property towards the simulation of cancellous bone as a biphasic medium.

## ACKNOWLEDGEMENTS

This work has been supported by research grants of the Agencia Nacional de Promoción Científica of the República Argentina, the National University of Mar del Plata and the Project PIRSES-GA2009\_246977 “Numerical Simulation in Technical Sciences” of the Marie Curie Actions FP7-PEOPLE-2009-IRSES of the European Union. Authors gratefully acknowledge J. M. Alves and A. M. Hakme da Silva (University of São Paulo, Brazil), P. Zaslansky (JWI/BCRT Charite, Germany) and S. Omar (University of Mar del Plata, Argentina) for kindly providing the micro-CT data of samples N1, and N3 and N4, respectively. Authors also acknowledge to CSC-CONICET (Argentina) for granting the access to the cluster TUPAC.

## REFERENCES

- Carretta R, Lorenzetti S, Müller R. Towards patient-specific material modeling of trabecular bone post-yield behavior. *Int J Numer Methods Biomed Eng.* 2013;29(2):250-272. <https://doi.org/10.1002/cnm.2516>
- Currey JD. *Bones: Structure and Mechanics*. New Jersey: Princeton University Press; 2006.
- Lane NE. Epidemiology, etiology, and diagnosis of osteoporosis. *Am J Obstet Gynecol.* 2006;194(2):S3-S11. <https://doi.org/10.1016/j.ajog.2005.08.047>
- Blanchard R, Morin C, Malandrino A, Vella A, Sant Z, Hellmich C. Patient-specific fracture risk assessment of vertebrae: a multiscale approach coupling X-ray physics and continuum micromechanics. *Int J Numer Methods Biomed Eng.* 2015;26(1) n/a-n/a. <https://doi.org/10.1002/cnm.2760>
- van Rietbergen B, Odgaard A, Kabel J, Huiskes R. Relationships between bone morphology and bone elastic properties can be accurately quantified using high-resolution computer reconstructions. *J Orthop Res.* 1998;16(1):23-28. <https://doi.org/10.1002/jor.1100160105>
- van Rietbergen B, Odgaard A, Kabel J, Huiskes R. Direct mechanics assessment of elastic symmetries and properties of trabecular bone architecture. *J Biomech.* 1996;29(12):1653-1657. [https://doi.org/10.1016/S0021-9290\(96\)80021-2](https://doi.org/10.1016/S0021-9290(96)80021-2)

7. Ulrich D, van Rietbergen B, Laib A, Rüegsegger P. The ability of three-dimensional structural indices to reflect mechanical aspects of trabecular bone. *Bone*. 1999;25(1):55-60. [https://doi.org/10.1016/S8756-3282\(99\)00098-8](https://doi.org/10.1016/S8756-3282(99)00098-8)
8. Pistoia W, van Rietbergen B, Laib A, Rüegsegger P. High-resolution three-dimensional-pQCT images can be an adequate basis for in-vivo microFE analysis of bone. *J Biomech Eng*. 2001;123(2):176-183. <https://doi.org/10.1115/1.1352734>
9. van Rietbergen B, Ito K. A survey of micro-finite element analysis for clinical assessment of bone strength: the first decade. *J Biomech*. 2015;48(5):832-841. <https://doi.org/10.1016/j.jbiomech.2014.12.024>
10. Podshivalov L, Fischer A, Bar-Yoseph PZ. 3D hierarchical geometric modeling and multiscale FE analysis as a base for individualized medical diagnosis of bone structure. *Bone*. 2011;48(4):693-703. <https://doi.org/10.1016/j.bone.2010.12.022>
11. Podshivalov L, Fischer A, Bar-Yoseph PZ. Multiscale FE method for analysis of bone micro-structures. *J Mech Behav Biomed Mater*. 2011;4(6):888-899. <https://doi.org/10.1016/j.jmbm.2011.03.003>
12. Rodríguez-Florez N, Oyen ML, Shefelbine SJ. Age-related changes in mouse bone permeability. *J Biomech*. 2014;47(5):1110-1116. <https://doi.org/10.1016/j.jbiomech.2013.12.020>
13. Olesiak SE, Oyen ML, Ferguson VL. Viscous behavior in Berkovich nanoindentation of bone. In: Proceedings of the SEM Annual Conference; 2009.
14. Schwiedzik J, Gross T, Bina M, Preterklier M, Zysset PK, Pahr DH. Experimental validation of a nonlinear  $\mu$  FE model based on cohesive-frictional plasticity for trabecular bone. *Int J Numer Methods Biomed Eng*. 2016;32(4):807-827. <https://doi.org/10.1002/cnm.2739>
15. Gilbert RP, Guyenne P, Yvonne OM. A quantitative ultrasound model of the bone with blood as the interstitial fluid. *Math Comput Modell*. 2012;55(9-10):2029-2039. <https://doi.org/10.1016/j.mcm.2011.12.004>
16. Gilbert RP, Guyenne P, Li J. A viscoelastic model for random ultrasound propagation in cancellous bone. *Comput Math Appl*. 2013;66(6):943-964. <https://doi.org/10.1016/j.camwa.2013.06.022>
17. Widmer RP, Ferguson SJ. On the interrelationship of permeability and structural parameters of vertebral trabecular bone: a parametric computational study. *Comput Methods Biomech Biomed Engin*. 2012;16: (August 2014):1-15. <https://doi.org/10.1080/10255842.2011.643787>
18. Guo X-DE, McMahon TA, Keaveny TM, Hayes WC, Gibson LJ. Finite element modeling of damage accumulation in trabecular bone under cyclic loading. *J Biomech*. 1994;27(2):145-155. [https://doi.org/10.1016/0021-9290\(94\)90203-8](https://doi.org/10.1016/0021-9290(94)90203-8)
19. Kowalczyk P. Elastic properties of cancellous bone derived from finite element models of parameterized microstructure cells. *J Biomech*. 2003;36(7):961-972. [https://doi.org/10.1016/S0021-9290\(03\)00065-4](https://doi.org/10.1016/S0021-9290(03)00065-4)
20. Stauber M, Müller R. Age-related changes in trabecular bone microstructures: global and local morphometry. *Osteoporos Int*. 2006;17(4):616-626. <https://doi.org/10.1007/s00198-005-0025-6>
21. Ebinger T, Diebels S, Steeb H. Numerical homogenization techniques applied to growth and remodelling phenomena. *Comput Mech*. 2007;39(6):815-830. <https://doi.org/10.1007/s00466-006-0071-8>
22. Kowalczyk P. Simulation of orthotropic microstructure remodelling of cancellous bone. *J Biomech*. 2010;43(3):563-569. <https://doi.org/10.1016/j.jbiomech.2009.09.045>
23. Moulinec H, Suquet L. A fast numerical method for computing the linear and nonlinear properties of composites. *C R Acad Sci Paris, Série II*. 1994;1. 318:1417-1423.
24. Willot F, Pellegrini Y-P, Iliart MI, Castañeda PP. Effective-medium theory for infinite-contrast two-dimensionally periodic linear composites with strongly anisotropic matrix behavior: dilute limit and crossover behavior. *Phys Rev B*. 2008;78(10):104111. <https://doi.org/10.1103/PhysRevB.78.104111>
25. Anglin BS, Lebensohn RA, Rollett AD. Validation of a numerical method based on Fast Fourier Transforms for heterogeneous thermoelastic materials by comparison with analytical solutions. *Comput Mater Sci*. 2014;87:209-217. <https://doi.org/10.1016/j.commatsci.2014.02.027>
26. Lebensohn RA. N-site modeling of a 3D viscoplastic polycrystal using Fast Fourier Transform. *Acta Mater*. 2001;49(14):2723-2737. [https://doi.org/10.1016/S1359-6454\(01\)00172-0](https://doi.org/10.1016/S1359-6454(01)00172-0)
27. Donegan SP, Rollett AD. Simulation of residual stress and elastic energy density in thermal barrier coatings using fast Fourier transforms. *Acta Mater*. 2015;96:212-228. <https://doi.org/10.1016/j.actamat.2015.06.019>
28. Willot F, Giliibert L, Jeulin D. Microstructure-induced hotspots in the thermal and elastic responses of granular media. *Int J Solids Struct*. 2013;50(10):1699-1709. <https://doi.org/10.1016/j.ijsolstr.2013.01.040>
29. Willot F, Jeulin D. Elastic and electrical behavior of some randommultiscale highly-contrasted composites. *Int J Multiscale Comput Eng*. 2011;9(3):305-326. <https://doi.org/10.1615/IntJMultCompEng.v9.i3.40>
30. Willot F, Abdallah B, Pellegrini Y-P. Fourier-based schemes with modified Green operator for computing the electrical response of heterogeneous media with accurate local fields. *Int J Numer Methods Eng*. 2014;98(7):518-533. <https://doi.org/10.1002/nme.4641>
31. Sixto-Camacho LM, Bravo-Castillero J, Brenner R, et al. Asymptotic homogenization of periodic thermo-magneto-electro-elastic heterogeneous media. *Comput Math Appl*. 2013;66(10):2056-2074. <https://doi.org/10.1016/j.camwa.2013.08.027>
32. Azzimonti DF, Willot F, Jeulin D. Optical properties of deposit models for paints: full-fields FFT computations and representative volume element. *J Mod Optic*. 2013;60(7):519-528. <https://doi.org/10.1080/09500340.2013.793778>
33. Ly HB, Monchiet V, Grande D. Computation of permeability with Fast Fourier Transform from 3-D digital images of porous microstructures. *Int J Numer Methods Heat Fluid Flow*. 2016;26(5):1328-1345. <https://doi.org/10.1108/HFF-12-2014-0369>
34. Moulinec H, Suquet P. A numerical method for computing the overall response of nonlinear composites with complex microstructure. *Comput Methods Appl Mech Eng*. 1998;157(1-2):69-94. [https://doi.org/10.1016/S0045-7825\(97\)00218-1](https://doi.org/10.1016/S0045-7825(97)00218-1)
35. Eyre DJ, Milton GW. A fast numerical scheme for computing the response of composites using grid refinement. *Eur Phys J*

- Appl Phys.* 1999;6(1):41-47. <https://doi.org/10.1051/epjap:1999150>
36. Michel J-C, Moulinec H, Suquet P. A computational method based on augmented Lagrangians and fast Fourier transforms for composites with high contrast. *CMES: Comput Model Eng Sci.* 2000;1(2):79-88. <https://doi.org/10.3970/cmES.2000.001.239>
  37. Monchiet V, Bonnet G. A polarization-based FFT iterative scheme for computing the effective properties of elastic composites with arbitrary contrast. *Int J Numer Methods Eng.* 2012;89(11):1419-1436. <https://doi.org/10.1002/nme.3295>
  38. Moulinec H, Silva F. Comparison of three accelerated FFT-based schemes for computing the mechanical response of composite materials. *Int J Numer Methods Eng.* 2014;97(13):960-985. <https://doi.org/10.1002/nme.4614>
  39. Michel J-C, Moulinec H, Suquet P. A computational scheme for linear and non-linear composites with arbitrary phase contrast. In: 5th U.S. National Congress on Computational Mechanics, 4-6 Aug. 1999, vol 52; 2001:139-160. <https://doi.org/10.1002/nme.275>
  40. Bilger N, Auslender F, Bornert M, et al. Effect of a nonuniform distribution of voids on the plastic response of voided materials: a computational and statistical analysis. *Int J Solids Struct.* 2005;42(2):517-538. <https://doi.org/10.1016/j.ijsolstr.2004.06.048>
  41. Kowalczyk P. Orthotropic properties of cancellous bone modelled as parameterized cellular material. *Comput Methods Biomech Biomed Engin.* 2006;9(3):135-147. <https://doi.org/10.1080/10255840600751473>
  42. Parkinson IH, Fazzalari NL. Characterisation of Trabecular Bone Structure. In: Silva MJ, ed. *Skeletal Aging and Osteoporosis: Biomechanics and Mechanobiology*. Berlin, Heidelberg: Springer Berlin Heidelberg; 2013:31-51. [https://doi.org/10.1007/8415\\_2011\\_113](https://doi.org/10.1007/8415_2011_113)
  43. Oftadeh R, Perez-Viloria M, Villa-Camacho JC, Vaziri A, Nazarian A. Biomechanics and mechanobiology of trabecular bone: a review. *J Biomech Eng.* 2015;137(1):10802. <https://doi.org/10.1115/1.4029176>
  44. Brennan O, Kennedy OD, Lee TC, Rackard SM, O'Brien FJ. Biomechanical properties across trabeculae from the proximal femur of normal and ovariectomised sheep. *J Biomech.* 2009;42(4):498-503. <https://doi.org/10.1016/j.jbiomech.2008.11.032>
  45. Kabel J, van Rietbergen B, Odgaard A, Huiskes R. Constitutive relationships of fabric, density, and elastic properties in cancellous bone architecture. *Bone.* 1999;25(4):481-486. [https://doi.org/10.1016/S8756-3282\(99\)00190-8](https://doi.org/10.1016/S8756-3282(99)00190-8)
  46. Keaveny TM, Guo XE, Wachtel EF, McMahon TA, Hayes WC. Trabecular bone exhibits fully linear elastic behavior and yields at low strains. *J Biomech.* 1994;27(9). [https://doi.org/10.1016/0021-9290\(94\)90053-1](https://doi.org/10.1016/0021-9290(94)90053-1)
  47. Cowin SC. Bone poroelasticity. *J Biomech.* 1999;32(3):217-238. [https://doi.org/10.1016/S0021-9290\(98\)00161-4](https://doi.org/10.1016/S0021-9290(98)00161-4)
  48. Yang G, Kabel J, Van Rietbergen B, Odgaard A, Huiskes R, Cowin SC. The anisotropic Hooke's law for cancellous bone and wood. *J Elast.* 1998;53(2):125-146. <https://doi.org/10.1023/A:100757532693>
  49. van Rietbergen B, Huiskes R. Elastic constants of cancellous bone. In: Cowin SC, ed. *Bone Mechanics Handbook*. 2nd ed. Boca Raton: CRC Press; 2001.
  50. Kabel J, Van Rietbergen B, Dalstra M, Odgaard A, Huiskes R. The role of an effective isotropic tissue modulus in the elastic properties of cancellous bone. *J Biomech.* 1999;32(7):673-680. [https://doi.org/10.1016/S0021-9290\(99\)00045-7](https://doi.org/10.1016/S0021-9290(99)00045-7)
  51. Doube M, Klosowski MM, Arganda-Carreras I, et al. BoneJ: free and extensible bone image analysis in ImageJ. *Bone.* 2010;47(6):1076-1079. <https://doi.org/10.1016/j.bone.2010.08.023>
  52. Ibarra Pino AA. Estudio del comportamiento mecánico del hueso trabecular mediante técnicas de homogeneización. 2011.
  53. Silva AMH, Alves JM, Da Silva OL, et al. Microstructural assessment of cancellous bone using 3D microtomography. *J Phys: Conf Ser.* 2011;313:12008. <https://doi.org/10.1088/1742-6596/313/1/012008>
  54. Ballarre J, Manjubala I, Schreiner WH, Orellano JC, Fratzl P, Cere SM. Improving the osteointegration and bone-implant interface by incorporation of bioactive particles in sol-gel coatings of stainless steel implants. *Acta Biomater.* 2010;6(4):1601-1609. <https://doi.org/10.1016/j.actbio.2009.10.015>
  55. Ballarre J, Seltzer R, Mendoza E, et al. Morphologic and nanomechanical characterization of bone tissue growth around bioactive sol-gel coatings containing wollastonite particles applied on stainless steel implants. *Mater Sci Eng C.* 2011;31(3):545-552. <https://doi.org/10.1016/j.msec.2010.11.030>
  56. Oliver WC, Pharr GM. An improved technique for determining hardness and elastic modulus using load and displacement sensing indentation experiments. *J Mater Res.* 1992;7(6):1564-1583. <https://doi.org/10.1557/JMR.1992.1564>
  57. Coathup MJ, Blunn GW, Flynn N, Williams C, Thomas NP. A comparison of bone remodelling around hydroxyapatite-coated, porous-coated and grit-blasted hip replacements retrieved at post-mortem. *J Bone Joint Surg. British volume* 2001;83(1):118-123. <https://doi.org/10.1302/0301-620X.83b1.10062>
  58. Hollister SJ, Kikuchi N. A comparison of homogenization and standard mechanics analyses for periodic porous composites. *Comput Mech.* 1992;10(2):73-95. 10.1007/BF00369853
  59. Terada K, Hori M, Kyoya T, Kikuchi N. Simulation of the multiscale convergence in computational homogenization approaches. *Int J Solids Struct.* 2000;37(16):2285-2311. [https://doi.org/10.1016/S0020-7683\(98\)00341-2](https://doi.org/10.1016/S0020-7683(98)00341-2)
  60. Broawyess JT, Chevrot S. Decomposition of the elastic tensor and geophysical applications. *Geophys J Int.* 2004;159(2):667-678. <https://doi.org/10.1111/j.1365-246X.2004.02415.x>
  61. Cowin SC, Mehrabadi M. On the identification of material symmetry for anisotropic elastic materials. *Q J Mech Appl Math.* 1987;40(4):451-476. <https://doi.org/10.1093/qjmam/40.4.451>
  62. Walker AM, Wooley J. MSAT—a new tool for the analysis of elastic and seismic anisotropy. *Comput Geosci.* 2012;49:81-90. <https://doi.org/10.1016/j.cageo.2012.05.031>
  63. Niebur GL, Yuen JC, Hsia A, Keaveny TM. Convergence behavior of high-resolution finite element models of trabecular bone. *J Biomech Eng.* 1999;121(6):629-635. <https://doi.org/10.1115/1.2800865>
  64. Guedes JM, Kikuchi N. Preprocessing and postprocessing for materials based on the homogenization method with adaptive finite element methods. *Comput Methods Appl Mech Eng.* 1990;83:143-198. [https://doi.org/10.1016/0045-7825\(90\)90148-F](https://doi.org/10.1016/0045-7825(90)90148-F)

65. Harrigan TP, Jasty M, Mann RW, Harris WH. Limitations of the continuum assumption in cancellous bone. *J Biomech.* 1988;21:269-275. [https://doi.org/10.1016/0021-9290\(88\)90257-6](https://doi.org/10.1016/0021-9290(88)90257-6)

**How to cite this article:** Colabella L, Ibarra Pino AA, Ballarre J, Kowalczyk P, Cisilino AP. Calculation of cancellous bone elastic properties with the polarization-based FFT iterative scheme. *Int J Numer Meth Biomed Engng.* 2017;33:e2879. <https://doi.org/10.1002/cnm.2879>

## APPENDIX 1

The explicit versions of the periodic strain and stress Green tensors associated to the isotropic reference material with Lamé coefficients  $\lambda^0$  and  $\mu^0$  are

$$\hat{\Gamma}_{ijkh}^0(\xi) = \frac{1}{4\mu^0|\xi|^2} (\delta_{kh}\xi_i\xi_j + \delta_{ik}\xi_j\xi_h + \delta_{jk}\xi_i\xi_h + \delta_{ij}\xi_k\xi_h) \quad (A1.1)$$

$$- \frac{\lambda^0 + \mu^0}{\mu^0(\lambda^0 + 2\mu^0)} \frac{\xi_i\xi_j\xi_k\xi_h}{|\xi|^4}$$

and

$$\hat{\Delta}_{ijkh}^0(\xi) = \mathbb{C}_0 - \mathbb{C}_0 : \hat{\Gamma}_{ijkh}^0(\xi) : \mathbb{C}_0, \quad (A1.2)$$

where  $\delta_{ij}$  is the Kronecker delta function.

## APPENDIX 2

The convergence test at each iteration  $i$  consists in comparing the deviations from equilibrium, compatibility, and the prescribed loading conditions with a prescribed tolerance. Following Moulinec and Silva,<sup>38</sup> the following convergence tests are used in this work:

- Criterion on equilibrium: It evaluates the  $L_2$ -norm of the divergence of the stress, which is evaluated in Fourier space as

$$\|div(\sigma_\mu)\|_2 = \sqrt{\sum_{\xi} |\xi \cdot \hat{\sigma}_\mu(\xi)|^2} \quad (A2.1)$$

where  $|\cdot|$  is the Euclidean norm of a vector. Expression A2.1 is normalized by the macroscopic stress to make it insensitive to a linear factor on the prescribed strain

$$e_{equilibrium} = \frac{\|div(\sigma_\mu)\|_2}{\|\hat{\sigma}_\mu\|} = \frac{\sqrt{\sum_{\xi} |\xi \cdot \hat{\sigma}_\mu(\xi)|^2}}{\|\hat{\sigma}_\mu(0)\|}, \quad (A2.2)$$

where  $\|\cdot\|$  is the Frobenius norm of a tensor.

- Criterion on compatibility: It is evaluated in Fourier space by

$$e_{compatibility} = \frac{\max_{\xi} (\max_{i=1,\dots,6} (|\hat{c}_i(\xi)|))}{\sqrt{\sum_{\xi} \hat{e}_\mu(\xi) : \hat{e}_\mu^*(\xi)}} \quad (A2.3)$$

where  $(\cdot)^*$  stands for the complex conjugate and the 6 compatibility relations are

$$\hat{c}_1(\xi) = -\xi_2\xi_5\hat{e}_{\mu 11}(\xi) - \xi_5\xi_1\hat{e}_{\mu 22}(\xi) + 2\xi_1\xi_2\hat{e}_{\mu 12}(\xi)$$

$$\hat{c}_2(\xi) = -\xi_3\xi_5\hat{e}_{\mu 22}(\xi) - \xi_5\xi_2\hat{e}_{\mu 33}(\xi) + 2\xi_2\xi_3\hat{e}_{\mu 23}(\xi)$$

$$\hat{c}_3(\xi) = -\xi_1\xi_5\hat{e}_{\mu 33}(\xi) - \xi_5\xi_3\hat{e}_{\mu 11}(\xi) + 2\xi_3\xi_1\hat{e}_{\mu 13}(\xi)$$

$$\hat{c}_4(\xi) = -\xi_2\xi_3\hat{e}_{\mu 11}(\xi) + \xi_1\xi_2\hat{e}_{\mu 13}(\xi) + \xi_1\xi_3\hat{e}_{\mu 12}(\xi) - \xi_1\xi_1\hat{e}_{\mu 23}(\xi)$$

$$\hat{c}_5(\xi) = -\xi_3\xi_1\hat{e}_{\mu 22}(\xi) + \xi_2\xi_3\hat{e}_{\mu 12}(\xi) + \xi_2\xi_1\hat{e}_{\mu 23}(\xi) - \xi_2\xi_2\hat{e}_{\mu 13}(\xi)$$

$$\hat{c}_6(\xi) = -\xi_1\xi_2\hat{e}_{\mu 33}(\xi) + \xi_3\xi_5\hat{e}_{\mu 23}(\xi) + \xi_5\xi_2\hat{e}_{\mu 13}(\xi) - \xi_5\xi_3\hat{e}_{\mu 12}(\xi). \quad (A2.4)$$

- Criterion on the loading condition: The convergence on loading conditions on the prescribed macroscopic strain is tested using

$$e_{loading} = \frac{\|\langle \hat{\sigma}_\mu \rangle - \mathbb{E}\|}{\|\mathbb{E}\|} = \frac{\sqrt{\langle (\hat{\sigma}_\mu - \mathbb{E}) : (\hat{\sigma}_\mu - \mathbb{E}) \rangle}}{\sqrt{\mathbb{E} : \mathbb{E}}}. \quad (A2.5)$$