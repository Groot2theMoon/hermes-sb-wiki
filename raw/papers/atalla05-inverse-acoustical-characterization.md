---
title: "Inverse acoustical characterization of open cell porous media using impedance tube measurements"
authors: ["Youssef Atalla, Raymond Panneton"]
year: 2005
source: paper
journal: "Canadian Acoustics, 33(1), 11-20"
ingested: 2026-05-05
sha256: d1467c9130ce12b7c639daa74398b6e357c18c150fbc363294452bd32ff99f8c
conversion: pymupdf4llm
---

_**Research article/Article de recherche**_ 

## **I n v e r s e A c o u s t i c a l C h a r a c t e r i z a t i o n  O f O p e n C e l l P o r o u s  M e d i a U s i n g** 

## **I m p e d a n c e T u b e M e a s u r e m e n t s** 

## **Youssef Atalla and Raymond Panneton** 

Groupe d’Acoustique de l’Université de Sherbrooke Département génie mécanique, Université de Sherbrooke Sherbrooke, QC Canada, J1K 2R1; Youssef.Atalla@USherbrooke.ca 

## **a b s t r a c t** 

Unlike porous models developed for particular absorbing materials and frequency ranges, the JohnsonChampoux-Allard model is a generalized model for sound propagation in porous materials over a wide range of frequencies. This model is nowadays used widely across the acoustic research community and by industrial sector. However to use this model, the knowledge, particularly, of the intrinsic material properties defining the model is necessary. Using the proposed porous model and with the knowledge of the intrinsic properties, the calculation of the desired acoustical indicators as well as the design and optimization of several acoustic treatments for noise reduction can be done efficiently and rapidly. The model of JohnsonChampoux-Allard is based on five intrinsic properties of the porous medium: the flow resistivity, the porosity, the tortuosity, the viscous characteristic length, and the thermal characteristic length. While the open porosity and airflow resistivity can be directly measured without great difficulties, the direct measurements of the three remaining properties are usually complex, less robust, or destructive. To circumvent the problem, an inverse characterization method based on impedance tube measurements is proposed. It is shown that this inverse acoustical characterization can yield reliable evaluations of the tortuosity, and the viscous and thermal characteristic lengths. The inversion algorithm contains an optimization process and hence it is verified that the identified optimal three parameter, even though derived from a mathematical optimum for a given experimental configuration (sample’s thickness, measured frequency range), are the intrinsic properties of the characterized porous material. 

## **r é s u m é** 

À la différence de certains modèles adaptés à une gamme de matériaux poreux insonorisant et/ou à de fréquences, le modèle de Johnson-champoux-Allard peut décrire la propagation du son dans les milieux poreux de façon générale et assez précise. Du fait que ce modèle soit bien adapté à une vaste gamme de matériaux et de fréquences, il est largement utilisé de nos jours par la communauté scientifique ainsi que par le secteur industriel. L’utilisation de ce modèle nécessite cependant la connaissance en particulier de cinq paramètres qui décrivent de façon macroscopique la géométrie interne du réseau interconnecté de pores d’un matériaux poreux. Connaissant ces paramètres, le calcul des indicateurs acoustiques ainsi que la conception, l’optimisation de nouveaux traitements acoustiques pour la réduction du bruit peuvent être effectués efficacement et rapidement. Les cinq paramètres sont : la porosité, la résistance à l’écoulement, la tortuosité, les dimensions caractéristiques visqueuse et thermique. Alors que les paramètres tels la porosité et la résistance à l’écoulement peuvent être mesurés directement facilement et avec assez de précision, la mesure directe de la tortuosité et des deux dimensions caractéristiques est généralement plus complexe, moins robuste ou destructive. Pour contourner ce problème, une méthode d’identification inverse de ces paramètres basée sur des mesures fines en tube d’impédance est proposée. Il est montré que cette méthode inverse de caractérisation acoustique permet une identification fiables de la tortuosité et des dimensions caractéristiques. Puisque cette méthode inverse est basée sur une procédure d’optimisation, il est vérifié que les paramètres issus de l’inversion ne sont pas que des optimums mathématiques valides seulement pour une configuration expérimentale donnée (épaisseur d’échantillon, gamme fréquentielle de mesure), mais aussi des propriétés intrinsèques au matériau caractérisé. 

11 - Vol. 33 No. 1 (2005) 

_Canadian Acoustics /  Acoustique canadienne_ 

## **1. INTRODUCTION** 

In acoustics, the propagation and dissipation of acoustic and elastic waves within an open cell air-saturated porous medium is described by the Biot theory1,2. Following this theory, three waves propagate within the material: two compression waves -  one mostly related to the fluid phase and the other to the solid phase, and one shear wave in the solid phase. Under acoustic excitations, the solid frame of the material can be assumed acoustically rigid (i.e. motionless) over a wide range of frequencies3-5. Consequently, only a compression wave, governed by the Helmholtz equation, now propagates in the fluid phase3. The porous medium is seen as an equivalent fluid with effective density p and bulk modulus _K_ . These effective properties accounts for the viscous and thermal losses that attenuate the compression wave. At the macroscopic level, these losses are related to five geometrical parameters of the porous medium: the open porosity ^, the airflow resistivity ct, the tortuosity a*,, the viscous characteristic length A, and the thermal characteristic length A ’. A detailed description of these 5 parameters can be found elsewhere3,6. 

Several works have been done to link the effective properties to the geometrical parameters3. In this work, a five-parameter model (the above five parameters) based on the works by Johnson _et a l_ and Champoux and Allard8, is selected. In this model, the effective density is given by Johnson _et a l ,_ and depends on the porosity, resistivity, tortuosity, and viscous characteristic length. Similarly, the effective bulk modulus is given by Champoux and Allard8, and depends on the porosity and thermal characteristic length. It is important to point out that the five-parameter model used in this paper may suffer from imprecision at low-frequencies. More accurate models include, in addition to the above five parameters, the static thermal permeability9, and two adjustable parameters for the thermal10 and viscous11 effects. These low-frequency corrections become important for materials having a behaviour that diverge strongly from cylindrical pore materials and/or having an interior structure presenting a rapid variation of pore section. In the present work different reasons motivate the choice of using the fiveparameter model instead of others. Firstly, the JohnsonChampoux-Allard model is one of the most commonly used generalized models for describing, accurately, the sound propagation in porous materials over a wide range of frequencies. The success with which this rigid model has been applied to many porous materials depend largely upon its ability to account simply for the random geometry of common porous materials available nowadays with no adjustable parameters since all the five parameters defining the model have a physical meaning and can be directly measured experimentally. 

Secondly, when comparing the five-parameters model to more complicated new models in which more than five parameters are used, Henry12 pointed out that the 

differences between the models are only at low frequencies and for a global acoustical indicators such as the absorption coefficient or the surface impedance, the differences are relatively small for the commonly used porous materials. In addition, there are not enough experimental data available in the literature concerning the values of these additional low frequency parameters. Consequently, it will be difficult to handle, successfully, the physical constraints for these new parameters if the corresponding models are retained in the inverse characterization. However, it is possible to confine the proposed inverse characterization to higher frequency ranges, where the low-frequency parameters will have little impact, and where the five parameters model will gives precise results. 

Thirdly and due to its robustness, the JohnsonChampoux-Allard model is nowadays implemented in several well known commercial vibro-acoustic softwares. Using the Johnson-Champoux-Allard model and with the knowledge of the five intrinsic properties the calculation of the desired acoustical indicators, as well as the design and the optimization of several acoustic treatments for noise reduction can be done efficiently and rapidly. However, while parameters such as the porosity and airflow resistivity can be easily measured, directly, using standard techniques13-15, the review of different methods6,16" 23 that have been developed for measuring the three other parameters shows that they are more difficult to determine with enough accuracy. In addition the developed techniques usually require more sophisticated and expensive set-ups. 

Tortuosity can be measured by a non-acoustical direct method which is based on the work of Brown16 and is successfully demonstrated by Johnson _et al11._ In this method, the porous material is filled with an electrolyte, and the electrical resistivity of the saturated material is measured and linked to the tortuosity. The method naturally applies to non-conductive frame and may be destructive. Poor results may be obtained if the operational procedure is not followed carefully, such as to make sure that the electrolyte completely saturates the porous network, which is difficult to do for highly resistive acoustical materials. The thermal characteristic length can also be obtained by a nonacoustical technique. Henry _et_ al18 showed that the specific surface measured by the BET technique19 can be related to the thermal characteristic length. The BET technique is cumbersome, costly, and, for typical acoustical foams, may yield large errors20. 

Alternative methods, based on acoustical ultrasound measurements, have been developed over the past ten years to circumvent the difficulties inherent in the direct characterization of the tortuosity and characteristic lengths. These methods use the exact high-frequency asymptotic limit of the effective density and bulk modulus. Frequency20-23 and temporal6,24,25 methods for ultrasonic wave propagation in rigid porous materials have been proposed. These methods are very promising; however, they are not easily adaptable by conventional acoustic 

Vol. 33 No. 1 (2005) - 12 

_Canadian Acoustics / Acoustique canadienne_ 

laboratories. Also, they suffer from two major limitations. The first limitation is related to the high attenuation of the ultrasound waves in the material. For highly dissipative materials or thicker layers, the ultrasound techniques are hardly applicable. The second limitation is related to the smallness of the wavelength compared to the pore size. As the wavelength approaches the pore size, diffusion of the ultrasound waves and heterogeneities of the structure at this scale will most likely affect the measurement and create large errors in the evaluation of the three parameters20. These two limitations are encountered for a number of sound absorbing materials. 

In this paper, an alternative acoustical method to the ultrasound techniques is proposed for the measurements of the tortuosity and characteristic lengths. The method derives from the solution of an inverse characterization problem proposed by the authors26,27. The method is easy to implement in the sense that it relies on standardized impedance tube measurements and global optimization algorithms. The method is robust in the sense that it works for a wide range of sound absorbing materials for which their rigid-frame behavior can be modeled as an equivalent fluid under acoustical excitations -  true for most poroelastic materials above a certain frequency range. 

In the following, the equivalent fluid model for porous materials is first recalled to introduce the inverse characterization problem. Second, the selected cost function is developed and discussed. Third, the method is applied to the characterization of four porous materials (two foams and two fibrous). Fourth, the inversion results are validated through comparisons between simulations and measurements over a wide range of frequencies and for different configurations of layered materials. Finally, the conclusion and the perspectives of the method are discussed. 

## **2. INVERSE CHARACTERIZATION** 

## **2.1 Acoustical model** 

Following the objective of this work and the above discussion, it is proposed to investigate the feasibility of an inverse characterization to identify the tortuosity, and the viscous and thermal characteristic lengths of an open cell 

**==> picture [187 x 90] intentionally omitted <==**

air-saturated porous medium based on simple standardized acoustical measurements in an impedance tube. schematic of the problem under consideration is depicted in Figure 1. It consists of an open cell air-saturated porous layer bonded onto the impervious rigid termination of a waveguide. The walls of the waveguide are assumed rigid, impervious, and perfectly reflective. The porous layer is also bonded to the wall all over its contour. Normal incidence acoustical waves excite the front face of the porous layer. At the interface of the air cavity and porous layer, the normalized surface impedance from the air cavity side is given by3: 

**==> picture [221 x 14] intentionally omitted <==**

where _Z_ , _Zc_ , _k_ , and ^ are the surface impedance (the ratio of acoustic pressure to the associated particle velocity), the characteristic impedance of the equivalent fluid, the complex wave number, and the open porosity of the porous sample, respectively. _Z0_ is the characteristic impedance of the air. The tilde symbol (~) indicates that the associated variable is complex-valued and frequency dependent, and _j_ = V -T . 

To eliminate the effects of the elasticity of the frame of the porous sample, the acoustical excitations are in a frequency range where the porous layer behaves mostly as acoustically rigid, i.e. for frequencies greater than the decoupling frequency4. Since the frame of the material is assumed motionless, only a longitudinal compression wave in the fluid phase propagates along its axis. Under this rigid-frame assumption, the fluid saturating the interconnected cells of the porous material can be macroscopically described as an equivalent homogeneous fluid of effective density p and effective bulk modulus _K_ . In this case, following the equivalent fluid model based on the works by Johnson _et_ al7 and Champoux and Allard8, the characteristic impedance and complex wave number of the “rigid” porous layer are given by : 

**==> picture [119 x 59] intentionally omitted <==**

with the effective density p : 

**==> picture [221 x 26] intentionally omitted <==**

and the bulk modulus _K_ 

**Figure 1. Porous material set on an impervious rigid wall: Normal incidence.** 

13 - Vol. 33 No. 1 (2005) 

_Canadian Acoustics / Acoustique canadienne_ 

**==> picture [177 x 68] intentionally omitted <==**

In Equations 2 thru’ 5, ro is the angular frequency, _P0_ is the barometric pressure, and y, B2, p0, and r  are the specific heat ratio, Prandtl number, density, and dynamic viscosity of the saturating air, respectively. The five remaining properties in Eqs. (4) and (5) are those defining the complexity of the porous network. They are the open porosity f , static airflow resistivity a, tortuosity a*, viscous characteristic length A, and thermal characteristic length A '. 

## **2.2 Cost function** 

In the previous section, the normalized surface impedance _Zs_ was analytically related to the five macroscopic properties of the porous network, the properties of the saturating air, and the thickness of the sample. Since the open porosity and the airflow resistivity can be determined with acceptable accuracy using standard techniques, only the tortuosity and the two characteristic lengths are unknown in the right hand side of Eq. (1). Consequently, through precise measurements of the normalized surface impedance on a porous sample and using its analytical expression (Eq. (1)), a non-linear regression fit can be designed and optimized to identify the three intrinsic remaining unknowns parameters (a*, A, A'). By defining the unknown parametric vector a = {aœ, A, A'}, the approach is then to design a cost function that measures the agreement, over a specific frequency range, between an observed normalized surface impedance _Z 0S_ and a numerical prediction _Z es_ (a) for a given estimate of the adjustable vector a. 

The cost function is conventionally arranged so that small values represent close agreement. For the purpose of this study, the following cost function is then considered: 

**==> picture [221 x 31] intentionally omitted <==**

where superscripts _e_ and _o_ stand for estimated and observed, respectively, _N_ is the total number of computed frequencies retained from the frequency range of interest. The estimated values are obtained from Eq. (1> for a given parametric vector a. The observed values _Zs0_ are the measured normalized surface impedance of the porous sample to be characterized. These data can be measured in an impedance tube following the standard test procedure described in ASTM E1050-86. 

The inverse characterization problem related to the impedance tube configuration shown in Figure 1, is to find the parametric vector a = {aœ, A, A'} ,such that 

**==> picture [217 x 23] intentionally omitted <==**

where LB and UB are the lower and upper bounds that limit the research domain on the adjustable parametric vector a. 

Due to errors in the measurements of the surface impedance and the other properties needed in Eq. (1>, the first condition in Eq. (7) is hardly likely to be met. Hence, a minimization of the cost function makes it easier to find the optimal parametric vector a. The minimization procedure will be discussed in section 2.4. 

The bounds in Eq. (7) are necessary to limit the domain of research on a, and to ensure that realistic values are obtained for the searched parameters during the solution process. In this study, the bounds on a have been derived from the literature as discussed in the introduction. 

By definition, the tortuosity cannot be lower than 1. Also, published and in-house measurements on a wide variety of commonly used acoustical porous materials have shown that the tortuosity is usually lower than 4. For the case of a material made up from parallel cylindrical pores perpendicular to the input surface, both characteristic lengths are equal 

However, for common porous materials, the viscous characteristic length is smaller than the thermal characteristic length. Moreover, the following relations are found in the literature3 : 

**==> picture [241 x 45] intentionally omitted <==**

**==> picture [221 x 10] intentionally omitted <==**

where _c_ and _c ’_ are pore shape parameters related to the viscous and thermal dissipation, respectively. From the above discussion and Eqs. (8) and (9), the lower and upper bounds in Eq. (7) can then be built from the following constraints: 

**==> picture [219 x 51] intentionally omitted <==**

The upper and lower bounds on the characteristic lengths will vary from one iteration to the next in the minimization process. 

Vol. 33 No. 1 (2005) - 14 

_Canadian Acoustics / Acoustique canadienne_ 

It should be pointed out that a cost function based on other acoustical indicators, such as the reflection coefficient or the absorption coefficient, could be designed. However, the discussion about the best indicator to use for the procedure is beyond the scope of this paper. 

## **2.3 Analysis of cost function** 

In this section, the cost function Eq. (6) is analyzed. To do so, an open cell foam material is considered. Although the analysis is performed on a specific foam, the obtained results may apply to other sound absorbing materials. For a proper analysis of the cost function, the observed impedance _Z 0_ is obtained by simulations using Eqs. (1)-(5) in view of eliminating the effects of experimental errors. In this ideal case, the solution of the inverse characterization problem of Eq. (7) should lead to the exact properties of the studied material. The studied material is a 49.92-mm thick layer of Foam 1. Its material properties are given in Tables I and II. The sound absorption curve for this material is shown in Figure 2 . It is a typical curve for sound absorbing materials. The curve may be divided into three zones: Zone I -  below the first maximum, Zone II -  around the first maximum, and zone III -  above the first maximum. 

First, if the tortuosity is fixed to its exact value of 1.315, the evaluation of Eq. (6) over the domain [60 < A <  365 |im , 60 < A '< 730 |im] -  included in the domain given by the second equation of Eq. (10) -  shows different contour plots depending upon the selected frequency range in the calculation. 

If the frequency range of the inversion corresponds to Zone I of Figure 2, the contour plot of the cost function presented in Figure 3(a), shows a rapid variation along the A'-axis and a slow variation along the A-axis. If the frequency range of the inversion now corresponds to Zone III, the contour plot, presented in Figure 3(b) shows a slow 

**==> picture [209 x 158] intentionally omitted <==**

**==> picture [50 x 7] intentionally omitted <==**

**----- Start of picture text -----**<br>
Frequency (Hz)<br>**----- End of picture text -----**<br>


**Figure 2. Absorption coefficient of a 49.92-mm thick layer of Foam 1.** 

**Table I. Material properties of the studied materials measured using direct methods.** 

|Properties||Foam|Foam|Fibrous|Fibrous|Screen|Units|
|---|---|---|---|---|---|---|---|
|||1|2|1|2|||
|Name|Symbol|||||||
|Static||||||||
|airflow|a|4 971|8 197|21 235|50 470|450 000|Ns/m4|
|resistivity||||||||
|Open||0.97|0.95|0.94|0.89|||
|porosity||||||||
|Density|P1|21.6|23.9|89.6|150.0||kg/m3|



variation along the A'- axis and a rapid variation along the A- axis. These results are logical since at low frequencies the thermal dissipation usually dominates over the viscous dissipation, and for higher frequencies, it is the viscous dissipation that dominates. Consequently, an ideal frequency range for the inverse characterization should cover a part of Zones I and III so the cost function may have a same level of sensitivity to both characteristic lengths. However due to the fact that zone I includes information about parameters such as flow resistivity and porosity that have the highest weight at low frequencies and on which the inversion highly depends, one conclude that this zone must be included in the inversion. On the other hand, the zone II seems to be a good alternative to zone III since it contains the maximum absorption and could be seen like bridge information between zone I and III. In order to confirm this choice the same numerical study as above has been performed on the cost function defined on a frequency range covering zones I and II. The result is shown in Figure 4(a). In this case, the variations of the cost function along both axes are similar. 

Similar contour plots are also obtained for other tortuosity values apart from the exact tortuosity of 1.315; however, the minimum of the cost function is located elsewhere. The dots in Figure 4(a) represent the locations of the minima for different tortuosity values ranging from 1 to 1.6. Theoretically, one can conclude from this observation that there exists only one minimum in the characteristic length mapping for a given tortuosity plane. Nevertheless, the minimum related to the exact tortuosity of 1.315 is the lowest minimum and leads to the exact characteristic lengths (A=123.19 |im, A'=289.54 |im). In Figure 4(b) the evolution of the cost function minima in function of the tortuosity is presented. It is noted that there exists only one minimum. As expected, for this ideal theoretical case, the minimum of the minima (optimal solution) falls to zero only at the exact tortuosity value of 1.315. 

In conclusion, using an appropriate minimization algorithm for the inverse characterization problem of Eq. (7), the selected cost function should theoretically lead to the exact solution for the parametric vector a under the condition that an appropriate frequency range is used. 

The properties of the foam are given in Tables I and II. The curve is obtained using Eqs. (1)-(5). 

_Canadian Acoustics / Acoustique canadienne_ 

**15 - Vol. 33 No. 1 (2005)** 

## **2.4 Solution of inverse characterization** 

Due to errors in the measurements of the observed impedance _Z°s_ and the other properties needed in Eq. (1) to 

estimate _Z es_ , the first condition in Eq. (7) -  i.e. Æ(a) = 0 -  is hardly likely to be met. Hence, a more practical way to state the inverse characterization problem is to find the parametric vector a that minimizes the cost function Æ(a) and satisfies the constraint LB < a < UB . 

As shown in the previous section, to find the best-fit parametric vector a, it is necessary to find the global minimum of the inverse chacaterization problem. Several techniques are available to minimize a multivariable 

**==> picture [212 x 161] intentionally omitted <==**

**==> picture [213 x 202] intentionally omitted <==**

**----- Start of picture text -----**<br>
Viscous length A  (u.m)<br>Viscous length A  (|j.m)<br>**----- End of picture text -----**<br>


**Figure 3. Contour plot of the cost function versus the characteristic lengths for the exact tortuosity of 1.315. (a) Results obtained from Eq. (6) using the frequency range covering “Zone I” in Figure 2 (b). Results obtained from Eq. (6) using the frequency range covering “Zone III” in** 

**Figure 2.** 

The contour plot is related to a 49.92-mm thick layer of Foam 1. The small circle shows the location of the theoretical minimum, i.e. R = 0. 

function28,29. However, with the non-linear dependencies in terms of the vector a in Eq. (6), the minimization must proceed iteratively, i.e. a sequence of approximate solutions is generated. Moreover, for this minimization problem, there may be multiple, equal or unequal, minimal solutions. A standard algorithm such as Newton-Raphson method cannot avoid the possibility of mistaking a local minimum for a global minimum. It follows that the minimization technique adopted must be able to identify the global minimum (global solution) among all the local solutions and also to handle constraints (in order to localize the reliable physical solutions). Also, an important task that should be examined to retain a minimization algorithm among others is its ability to deal with noisy data and to extract 

**==> picture [218 x 160] intentionally omitted <==**

**==> picture [76 x 7] intentionally omitted <==**

**----- Start of picture text -----**<br>
Viscous length A  (Mm)<br>**----- End of picture text -----**<br>


**==> picture [222 x 181] intentionally omitted <==**

**Figure 4. (a) Contour plot of the cost function versus the characteristic lengths for the exact tortuosity of 1.315 and the frequency range covering “Zones I and II”. The dots indicate the locations of the minima for other tortuosity values ranging from 1 to 1.6. (b) Evolution of the minima as a function of the tortuosity. The dots are the minima shown in (a) transposed along the tortuosity axis. The graphs are related to a** 

**49.92-mm thick layer of Foam 1.** 

Vol. 33 No. 1 (2005) - 16 

_Canadian Acoustics / Acoustique canadienne_ 

information from noise. 

Following the above discussion, a number of algorithms have been implemented and tested26. The one offering the best performance was a differential evolution algorithm30-32. In the following, the differential evolution global optimisation algorithm is summarized. 

## **2.5 Differential evolution algorithm** 

Like genetic algorithms, differential evolution is part of the evolutionary algorithm class that is based on an analogy between evolution of living species and the process of optimization. The main difference between differential evolution and genetic algorithm is that differential evolution operates directly on problem unknowns. Unlike genetic algorithm, no binary coding of variables is required which makes differential evolution easier to implement. Differentail evolution algorithm interprets the value of the cost function at a point like optimum measures of physical form of this point. Then, guided by the principle of the survival of most suitable, a first population of the vectors is transformed into vector of solution during the repeated cycles of the mutation, the recombination, and the selection. The total structure of the differential evolution algorithm resembles the majority of the methods of search based on an initial population. Two alignments are updated; each one holds a population of N-Dimensional vectors with real values. Primary alignment holds the current population, while secondary alignment accumulates the vectors that are selected for the next generation. The selection occurs by competition between the existing vectors and the trial vectors. The trial vectors employed by differential evolution are formed by the mutation and the recombination of the vectors in primary alignment. The mutation is an execution that makes small random changes with one or more parameters of an existing vector of population. The mutation is crucial for the diversity of update in a population, and is typically carried out by the perturbation. A convenient source of the suitably measured perturbations and which makes differential evolution different from the Evolutionary Strategies29 is the population itself. Each pair of vectors (XA, _XB)_ in primary alignment defines a differential of vector, _XA_ - _XB._ When these two vectors are selected by chance, their weighed difference can be employed to perturb another vector in primary alignment Xc: 

**==> picture [221 x 10] intentionally omitted <==**

The weight _F_ is a user-supplied constant. The optimal value of _F_ for the majority of the functions was found to lie in the range [0.4, 1]26. An effective variation of this scheme 

* 

implies to maintain the best vector so far, _X_ . This can be combined with _Xc_ and then perturbed, yielding: 

**==> picture [222 x 9] intentionally omitted <==**

Then, in mutation, the most successful member of a population influences all trial vectors. 

Recombination, or the crossover, provides an alternative and complementary means of creating viable vectors. Conceived to resemble the normal process by which a child inherits the DNA from its parents, new parameter combinations are built from the components of existing vectors. This effectively scrambles information on successful combinations, allowing the search for an optimum to concentrate on the most promising area of the space of solution. 

Each primary array vector _Xc_ of alignment is targeted for the recombination with _X'C_ to produce a trial vector _XT._ Thus, the trial vector is the child of two parents, a noisy random vector and the primary array vector against which it must compete. The recombination is determined by a crossover constant C, where 0 < _C_ < 1 . In exponential crossover, a starting parameter is selected at random. Then _C_ is compared to uniformly distributed random number from within the interval [0, 1]. Subsequent trial vectors parameters are chosen from _X C_ until the random generator of number produces a value larger than _C_ (or until all the parameters have been determined). In binary crossover, the random experiment is performed for each parameter. If the random number is smaller than C, the trial vector parameter is chosen from X'C, otherwise it comes from XC. In both cases, when _C_ =1, every trial vector parameter comes from _X'C_ , making with the trial vector _XT_ an exact replica of the noisy random vector. Once new trial solutions have been generated, selection determines which one among them will survive into the next generation. Each child _XT_ is confronted to its parent _XC_ in the primary array. Only the best candidate is then allowed to advance into the next generation. For more details about how crossover process using the constant C is working in differential evolution, the reader must refer to the work of Price30,32 . 

In all, only three parameters control the differential algorithm: the population size _N,_ the weight _F_ applied to the differential in mutation, and the constant _C_ that mediates the crossover operation. Several numerical tests have been performed26 and the results were used to set up an adequate and robust evolutionist optimization algorithm to solve the problem stated by Eq.10 in the shortest time. Then, the final parameteric estimation set up, using differential evolution algorithm, was applied for identification of material intrinsic properties from real experimental data. 

Many reasons are behind the choice of using a global optimization technique such as differential evolution instead of others optimization algorithms. First of all, there may be multiple, equal, or unequal optimal solutions for the inverse characterization problem proposed in this paper, since it is an over determined problem with more equations than unknowns. Therefore, a simple standard minimization procedure like a well-known Newton-Raphson scheme cannot avoid the possibility of mistaking a local minimum for a global minimum. In addition for a local optimization 

17 - Vol. 33 No. 1 (2005) 

_Canadian Acoustics / Acoustique canadienne_ 

technique, the obtained solutions depend narrowly on the trial guess (initial parameters to start the minimization). It follows that a global optimization algorithm such as differential evolution scheme has to be adopted in this problem in order to be able to identify, efficiently, the global minimum (optimal solution) among all the local solutions. Differential evolution algorithm is retained also due to its flexibility to handle different kind of constraints on the unknown parameters with a robust convergence behaviour. It must be emphasized finally, that compared to many robust global optimization algorithms, such as adapted simulated annealing and genetic algorithms, differential evolution has shown a net robustness and superiority .32 

## **3. RESULTS** 

## **3.1 Inverse characterization of porous samples** 

Using the inverse characterization problem described in the previous section, two foams and two fibrous sound absorbing materials are characterized. The airflow resistivity, bulk density, and open porosity of the materials have been measured with direct methods13-15 and are presented in Table I. The inverse characterization operates on the frequency range 500-1600 Hz which is within the range of a large diameter (10 cm) B&K 4206 impedance tube. Even though such impedance tube allows accurate measurements down to 200 Hz, the lower limit is fixed to 500 Hz for two reasons. Firstly, using only data above 500 Hz will eliminate the imprecise data at low frequencies which are associated with systematical errors of the experimental set-up (the limited microphone spacing compared to the wavelengths at these frequencies). Secondly, the five-parameter model used in this inverse characterization problem is imprecise at low frequencies12, 

**==> picture [212 x 156] intentionally omitted <==**

**Table II. Results of the inverse characterization on the studied** 

## **porous materials.** 

Three samples per material are used. The thickness of each sample is given in the second column. The intrinsic properties obtained by the proposed inverse characterization are given in the five last columns. The mean properties for each material are written in bold face. 

|Material|Thick.|Tortuo.|Viscous|Thermal|_c_|_c'_|
|---|---|---|---|---|---|---|
||_L_(mm)|a*|Length|Length|0.3<c<3.3|0.3<c’<c|
||||A' (^m)|A' (^m)|||
|Foam 1|49.75|1.30|119.11|286.09|1.67|0.69|
||50.36|1.30|116.92|297.98|1.70|0.67|
||49.66|1.34|133.55|284.56|1.52|0.71|
||**49.92**|**1.31**|**123.19**|**289.54**|**1.63**|**0.69**|
|Foam 2|34.43|1.49|152.50|206.14|1.10|0.81|
||34.63|1.35|104.10|221.00|1.53|0.72|
||34.00|1.43|142.70|210.00|1.15|0.78|
||**34.35**|**1.42**|**133.10**|**212.65**|**1.26**|**0.77**|
|Fibrous 1|23.46|1.00|51.31|121.16|1.67|0.71|
||23.37|1.00|46.13|125.54|1.86|0.68|
||23.27|1.00|48.42|96.47|1.77|0.89|
||**23.37**|**1.00**|**48.62**|**114.39**|**1.77**|**0.76**|
|Fibrous 2|37.91|1.00|39.76|123.65|1.44|0.46|
||36.68|1.00|35.61|137.37|1.60|0.42|
||37.54|1.00|49.15|81.79|1.17|0.70|
||**37.38**|**1.00**|**41.51**|**114.27**|**1.41**|**0.45**|



and hence eliminating data below the 500 Hz limit is a practical way to recover the best estimation of the unknown parameters. In addition, even if the data seems to be clean in the absorption coefficient curve of the material, the error could be important while dealing with the impedances curves. On the other hand, it is interesting to present results (both measurements and simulations) in a large frequency band even for frequencies below 500 Hz to show how the retained rigid model compare to experiments at these frequencies. This will be a good indication of the quality of the identified parameters used for simulations. Consequently all the presented results are shown down to 200 Hz. The measurements of the acoustical parameters follow standard ASTM E 1050-8633. To prevent acoustical leaks around the edge of a sample, pressurized water jet cutting is used to achieve a perfect circular shape. The diameter of a sample is slightly greater (1% greater) than the inside diameter of the tube so that its edges be considered bonded to the wall due to friction. This reinforces also the rigid frame behavior of the material on which the inverse characterization model relies. 

**==> picture [49 x 8] intentionally omitted <==**

**----- Start of picture text -----**<br>
Frequency (Hz)<br>**----- End of picture text -----**<br>


**Figure 5. Absorption coefficient of the four porous materials.** The curves are averaged over three samples for each material. The mean thickness is indicated in parenthesis. 

_Canadian Acoustics / Acoustique canadienne_ 

**Vol. 33 No. 1 (2005) - 18** 

The room ambient temperature and barometric pressure during impedance tube measurements are (a) Foam 1: 21.5°C and 992 mbar, (b) Foam 2: 24.6 °C and 977 mbar, (c) Fibrous 1: 22.6°C and 1002 mbar, and (d) Fibrous 2: 24.6 °C and 977 mbar. These room conditions are necessary to have a good evaluation of the air properties used in Eqs. (4) and (5). 

Under these experimental conditions and set-up, the measured absorption coefficients are shown in Figure 5 for the four materials to be characterized. The presented absorption is averaged over 3 samples. The thickness of each sample and the mean thicknesses are given in Table II. As previously stated in section 2.3, the ideal frequency range should cover Zones I and II of the absorption coefficient curve of the material as shown in Figure 2. However, the absorption coefficient curves presented in Figure 5 show that while Zone I is completely covered for the four porous materials considered, Zone II is only partially covered for Foam 1 and Fibrous 2, and is completely missing for Foam 2 and Fibrous 1. This is 

mainly due to the experimental setup used. In fact, the large impedance tube and the microphone spacing used in the measurements have limited the higher frequency limit, and consequently the frequency Zone II or III. The large impedance tube was retained in order to use the same large samples (10 cm in diameter) that have been used for the porosity and airflow resistivity measurements. It will be shown later, that covering both Zones I and II is not a necessary condition to achieve a good estimation of the unknown parameters. It will speed up the convergence of the optimizer since it deals with less experimental data. Also, in Figure 5, one may note that for Foam 2, the absorption coefficient curve presents a dip around 1400 Hz which is believed to be associated to the frame elasticity of the foam. The equivalent fluid model on which the inverse characterization relies cannot account for this elastic behavior. However, it will be shown that it does not affect noticeably the inversion since it is a local effect occurring only around the frame resonance -  the rest of the curve being of a rigid type. Hence, the equivalent fluid model 

**==> picture [212 x 164] intentionally omitted <==**

**==> picture [212 x 164] intentionally omitted <==**

**==> picture [456 x 195] intentionally omitted <==**

**----- Start of picture text -----**<br>
Frequency (Hz) Frequency (Hz)<br>Frequency (Hz) Frequency (Hz)<br>**----- End of picture text -----**<br>


**Figure 6. Normalized surface impedance for each of the three samples of (a) Foam 1, (b) Foam 2, (c) Fibrous 1, & (d) Fibrous 2.** The lines are the measurements used to solve the inverse characterization problem for each sample. The dots are predictions obtained using the mean thickness ( _**L**_ ) of the materials and their mean optimal parameters given in table II. 

19 - Vol. 33 No. 1 (2005) 

_Canadian Acoustics /  Acoustique canadienne_ 

behind the inverse characterization acts like a filter, filtering the elastic behavior of the frame and capturing mainly the rigid behavior. Figure 6 shows the normalized surface impedances on which the inverse characterization problem Eq. 7 will be applied. For each material, three samples are tested. The optimal parameters (tortuosity and characteristic lengths) identified by the inverse characterization for each material samples, and their mean values are reported in Table II. Also, the pore shape factors _c_ and c’ defined in Eqs. 8 and 9 are given in Table II. 

Following the inverse characterization results of Table II, one can note that the identified tortuosity and characteristic lengths for the three samples of a given material are close to each other. For the fibrous materials, a tortuosity near unity and ratios A ' / A of 2.35 and 2.75 are found respectively for Fibrous 1 and Fibrous 2. This is in accordance with the physics of fibrous materials that predicts a characteristic lengths ratio A' / A * 2 for ideal cylindrical fibers, and a tortuosity near unity for common fibrous materials34. For the foams, the values found are typical values compared to published data on foams. The 

discrepancies between some estimated values of a given porous material, especially in the case of Fibrous 2, may be due to the sensitivity of the mounting conditions from one sample to another, heterogeneities between samples, and uncertainties on the thickness -  difficult to measure with precision for fibrous materials. Using the mean thicknesses and the mean optimal parameters given in Table II, good agreements are obtained when predictions of the normalized surface impedance, using Eqs.(1)-(5), are compared to the measured impedances Figure 6. 

## **3.2 Validation results** 

To validate the proposed inverse characterization procedure and verify that the optimal identified parameters are good estimates of the physical intrinsic properties of the tested materials, three validation tests are performed. 

**==> picture [210 x 157] intentionally omitted <==**

**==> picture [209 x 156] intentionally omitted <==**

**==> picture [453 x 193] intentionally omitted <==**

**----- Start of picture text -----**<br>
Frequency (Hz) Frequency (Hz)<br>FIBROUS 2 (d)<br>Real part<br>Imaginary part<br>L  = 18.98 mm<br>----- Measurement<br>• •  Prediction with optimal paramaters<br>200 400 600 800  1000  1200  1400 1600<br>Frequency (Hz) Frequency (Hz)<br>**----- End of picture text -----**<br>


**Figure 7. Normalized surface impedance for a thickness different from the one used for the inverse characterization on (a) Foam 1, (b) Foam 2, (c) Fibrous 1, and (d) Fibrous 2. Comparisons between impedance tube measurements and predictions using the mean optimal material parameters given in table II.** 

Vol. 33 No. 1 (2005) - 20 

_Canadian Acoustics / Acoustique canadienne_ 

## Comparisons for different thicknesses 

The first validation test is to compare predictions to measurements for thicknesses different from those used for the inverse characterization. The thicknesses of the new test samples are: Foam 1, 98.7 mm; Foam 2, 68.77 mm; Fibrous 1, 46.83 mm; Fibrous 2, 18.98 mm. Figure 7 shows the comparisons in terms of normalized surface impedance. The predictions use the mean optimal parameters of Table II. A good agreement between the predicted and measured surface impedances is still observed for these new configurations. Consequently, the optimal parameters seem to be independent of the thickness. 

## Comparisons for a different frequency range 

The second validation test is to compare numerical predictions to measurements for a frequency range different from the one used for the inverse characterization. Figure 8 shows the comparisons for the frequency range, 200 Hz to 

6500 Hz. In this case, the small (29 mm) B&K 4206 impedance tube is used. The predictions use the mean optimal parameters of Table II. In this validation test also, it is observed that the predicted results, using the optimal parameters, correlate with impedance tube measurements. Consequently, the optimal parameters seem to be independent of the frequency range. 

## Comparisons for different multilayered materials. 

The third validation test is to compare predictions to measurements for multilayered materials instead of single layered material used in the inverse characterization. The predictions for the multilayered materials are based on the wave approach, also known as the transfer matrix method3. 

This method assumes layers of infinite extent and is essentially based on the representation of plane wave propagation in different media in terms of transfer matrices. This approach is well suited for the analysis of multilayers 

**==> picture [454 x 362] intentionally omitted <==**

**----- Start of picture text -----**<br>
L  =  68.77 mm<br>—  Measurement<br>•   Prediction with optimal paramaters<br>200  900  1600 2300 3000 3700 4400 5100 5800 6500<br>Frequency (Hz) Frequency (Hz)<br>200  900  1600 2300 3000 3700 4400 5100 5800 6500<br>Frequency (Hz) Frequency (Hz)<br>**----- End of picture text -----**<br>


**Figure 8. Normalized surface impedance for a frequency range different from the one used for the inverse characterization on (a) Foam 1, (b) Foam 2, (c) Fibrous 1, and (d) Fibrous 2.** Comparisons between impedance tube measurements and predictions using the mean optimal material parameters given in table II. 

21 - Vol. 33 No. 1 (2005) 

_Canadian Acoustics / Acoustique canadienne_ 

made up from a combination of elastic, porous-elastic and fluid layers. Figure 9(a) compares the predicted and measured absorption coefficient for a two-layer configuration made from a 24.70-mm thick layer of Foam 1, and a 23.37-mm thick layer of Fibrous 1 backed by the rigid 

**==> picture [220 x 161] intentionally omitted <==**

**==> picture [220 x 344] intentionally omitted <==**

**----- Start of picture text -----**<br>
1<br>0.9<br>0.8<br>®  0.7<br>% 0.6<br>oo Fibrous 1 (23.37 mm)<br>Screen (0.35 mm)<br>J  05<br>f  0.4 Foam 1 (24.7 mm)<br>_Qw<br>«  0.3<br>"O<br>§  0.2 Measurement<br>0.1 Prediction with optimal paramaters<br>0<br>0 200  400  600  800  1000  1200  1400  1600<br>1<br>0.9<br>0.8<br>ten 0.7<br>Foam 2 (34.54 mm)<br>tion 0.5<br>tirop 0.4 Fibrous 2 (18.35 mm<br>s<br>.Q<br>a 0.3<br>d<br>uon 0.2  Measurement<br>0.1  Prediction with optimal paramaters<br>0<br>0  700  1400 2100 2800 3500 4200 4900 5600 6300<br>Frequency (Hz)<br>**----- End of picture text -----**<br>


wall. A similar comparison for a three-layer configuration is presented in Figure 9(b). The multilayered configuration is made up from a 23.37-mm thick layer of Fibrous 1, a 0.35-mm thick micro-porous screen, and a 24.70-mm thick layer of Foam 1 backed by the rigid wall. Since the used micro-porous film was defined mainly by its airflow resistivity, given in Table I, it was then modeled using the Delany and Basely model35. A final comparison over the frequency range 0-6300 Hz is presented in Figure 9(c). The multilayered configuration is made from a 34.54-mm thick layer of Foam 2, and a 18.35-mm thick layer of Fibrous 2 backed by the rigid wall. In this case, the small (29 mm) B&K 4206 impedance tube is used. 

For the three multilayered configurations, good agreements are found between predictions and measurements; except where elastic resonances -  not captured by the equivalent fluid model - occur. Consequently, the optimal parameters found with the inverse characterization seem to be independent of the layered configuration. 

Following the good agreements between predictions and measurements for the three previous validation tests, it is shown that the optimal parameters (tortuosity, and viscous and thermal characteristic lengths) found with the proposed acoustical inverse characterization method, are not dependent of the material’s thickness, frequency range, and layered configuration. Therefore, the optimal solution found by the inverse characterization problem yields good estimates of the intrinsic geometrical parameters of the tested porous materials. 

## **4. SENSITIVITY ANALYSIS** 

In this section, the sensitivity of an inverse characterization to errors associated to the directly measured airflow resistivity and open porosity is discussed. The errors considered here are those related to the apparatus used for the flow resistivity and porosity measurements. To minimize all kind of errors (systematic and random), precise apparatuses, based on the published works13-15, were used. With these apparatus, the maximum errors associated to the measured resistivity _a_ and porosity ^ are respectively Act = 1.6 % and A^ = 2 %. 

To analyze the influence of these errors on the identified tortuosity and two characteristic lengths, the errors were introduced in the optimization procedure. Since the errors Aa and A^ are introduced simultaneously, they may occur both together or not, and in different direction. Therefore, there are a total of 9 possible error combinations to be considered in the sensitivity analysis. 

**Figure 9. Sound absorption coefficient for multilayered configurations.** Comparisons between impedance tube measurements and predictions using the mean optimal material parameters given 

in Table II. 

_Canadian Acoustics / Acoustique canadienne_ 

**Vol. 33 No. 1 (2005) - 22** 

**Table III. Sensitivity of the inverse characterization due to errors on directly measured static airflow resistivity and open porosity for Foam 1 (sample1, Table II). Aa = 1.6 % (79.54** N .m /s4 **), A< = 2 % (0.0194).** 

||||||nio<br>£<br>In|r<br>t<br>s|
|---|---|---|---|---|---|---|
|Case|Applied|a  ± Aa|||<|'|
||error||<±A<|a*|||
|number|(±Aa,±A<)|(N.m/s4)|||t <br>(|(<br>)|
|**1**|**(0, 0)**|**4971**|**0.970**|**1.30**|**119.19**|**286.09**|
|2|(0, +)|4971|0.9894|1.29|112.55|318.66|
|3|(0, -)|4971|0.9506|1.31|126.74|255.05|
|4|(+, 0)|5050|0.970|1.30|120.66|284.97|
|5|(-, 0)|4891|0.970|1.29|117.62|287.22|
|6|(+, +)|5050|0.9894|1.29|113.94|317.68|
|7|(-, -)|4891|0.9506|1.30|125.04|256.36|
|8|(-, +)|4891|0.9894|1.28|111.20|319.66|
|9|(+, -)|5050|0.9506|1.31|128.52|253.72|
||||Mean|1.30|119.50|286.60|
||Maximum absolute||error (%)|1.54|7.82|11.73|



**Table IV. Sensitivity of the inverse characterization due to errors on directly measured static airflow resistivity and open porosity for Fibrous 1 (sample1, Table II). Aa = 1.6 % (807.52** N.m/s4 **), A< = 2 % (0.0178).** 

||||||Inversion|results|
|---|---|---|---|---|---|---|
|Case|Applied|a  ± Aa|||A|A'|
|number|error<br>(±Aa,±A< )|(N.m/s4)|<±A<|a*|(^m)|(^m )|
|**1**|**(0, 0)**|**50470**|**0.890**|**1.00**|**39.76**|**123.65**|
|2|(0, +)|50470|0.9078|1.00|38.90|134.12|
|3|(0, -)|50470|0.8722|1.00|40.38|113.31|
|4|(+, 0)|51277|0.890|1.06|43.73|110.25|
|5|(-, 0)|49662|0.890|1.00|40.02|136.79|
|6|(+, +)|51277|0.9078|1.17|54.71|122.21|
|7|(-, -)|49662|0.8722|1.00|41.03|126.73|
|8|(-, +)|49662|0.9078|1.00|38.83|147.61|
|9|(+, -)|51277|0.8722|1.01|39.72|98.17|
||||Mean|1.03|41.90|123.65|
||Maximum absolute||error (%)|17|37.60|20.61|



Only two from the four porous materials under tests are considered in this sensitivity analysis: Foam 1 with the lowest flow resistivity, and Fibrous 2 with the highest flow resistivity. The sensitivity analysis is conducted only on one sample for each material. This is sufficient to give a trend on how the identified parameters are affected by the errors associated to the directly measured properties a and <. The results obtained are presented in Table III for Foam 1, and in Table IV for Fibrous 2. From these results, one can note that the overall maximum error on the three parameters occur when the errors on both a and < are introduced: (+, +), (-, -), (+, -), and (-, +). For Foam 1, the maximum error occurs for the thermal characteristic length (11.73 %). For Fibrous 1, the maximum error occurs for the viscous characteristic length (37.6%). These maximum errors are overestimated, since the extreme error combinations used in this analysis are unlikely to occur in reality. Nevertheless, introducing the errors on a and < in the inverse 

characterization, and taking the mean value for each of the resulting parameters averages out the errors. This is observed in Table III and IV, where the mean values on the three characterized parameters are close to the case with no error (case number 1). 

Finally, it is worth mentioning that extensive study performed on several porous materials26 showed that the variation of the mean of the identified parameters from one sample to another is almost always more important than the variation due to the effect of the errors associated to the directly measured parameters. Consequently, using different samples of the same material and using the obtained mean values and their standard deviations is a practical way to use the inverse characterization problem. 

## **5. CONCLUSION** 

In this paper, an inverse acoustical characterization procedure for the identification of tortuosity and characteristic lengths of sound absorbing porous materials using impedance tube was proposed. The method relies on the solution of an inverse characterization problem solved using a global optimizer based on differential evolution algorithm. It was shown that the proposed inverse characterization method theoretically leads to a unique solution (optimal solution) in terms of the tortuosity, and the viscous and thermal characteristic lengths. 

The proposed acoustical inversion procedure was used to characterize four acoustic materials (two foams and two fibrous). The optimal parameters identified for tortuosity and the two characteristic lengths by inversion were consistent with published and known values for foam and fibrous materials. To validate the inverse characterization results, and to verify that the optimal parameters identified are good estimates of the intrinsic properties of the materials, three validation tests were successfully performed. The validations tests were based on configurations different than those used for the inverse characterization. From the validation tests, it was shown that the optimal parameters identified by inversion are not dependent of the material’s thickness, frequency range, and layered configuration. Therefore, the optimal solution found by the inverse characterization is very good estimate of the intrinsic tortuosity and characteristic lengths of the tested porous materials. 

The results of this paper show that the presented inverse acoustic characterization technique leads to reliable estimates of the physical properties of the tested materials. The suggested technique is simple to use but robust enough to be applied, with success, to a large range of sound absorbing materials. Consequently it can be seen as a promising and a good alternative characterization technique to the existing ones. 

23 - Vol. 33 No. 1 (2005) 

_Canadian Acoustics / Acoustique canadienne_ 

## **ACKNOWLEDGMENTS** 

This research was supported by the National Sciences and Engineering Research Council of Canada (NSERC) and the Fonds de recherche sur la nature et les technologies du Québec (FQRNT). 

## **REFERENCES** 

1 Biot, M.A.. “The theory of propagation of elastic waves in a fluidsaturated porous solid. I. Low-frequency range,” J. Acoust. Soc. Am. 28(2), 168-178 (1956). 

2 Biot, M.A.. “The theory of propagation of elastic waves in a fluidsaturated porous solid. II. Higher-frequency range,” J. Acoust. Soc. Am. 28(2), 179-191 (1956). 

3 J.-F. Allard, _Propagation o f Sound in Porous Media: Modeling Sound Absorbing Materials;_ Elsevier Applied Science, New York, (1993). 

4 O.C. Zwikker and C.W. Kosten, _Sound-Absorbing Materials;_ Elsevier, Amsterdam, (1949). 

5 A. Bardot, B. Brouard, and J-F. Allard, “Frame decoupling at low frequencies in thin porous layers saturated by air,” J. Appl. Phys. 79, 8223-8229 (1996). 

6 Z.A. Fellah, C. Depollier, M. Fellah, and W. Lauriks, “Caractérisation complète des matériaux acoustiques par des measures ultrasonores” (Full ultrasound characterization of acoustic materials), Acoustique & Techniques 36, 26-32 (2004). 7 D. L. Johnson., J. Koplik, and R. Dashen., “Theory of dynamic permeability and tortuosity in fluid-saturated porous media,” J. Fluid Mechanics 176, 379-402 (1987). 

8 Y. Champoux and J.-F. Allard, “Dynamic tortuosity and bulk modulus in air-saturated porous media,” J. Appl. Phys. 70, 1975-1979 (1991). 

9 D. Lafarge, P. Lemarinier, J.F. Allard, and V.Tarnow, “Dynamic compressibility of air in porous structures at audible frequencies,” J. Acoust. Soc. Am. 102(4), 1995-2006 (1997). 

10 D. Lafarge, “Propagation du son dans les matériaux poreux à structure rigide saturés par un fluide viscothermique” (Propagation of sound in rigid frame porous materials saturated by a viscothermal fluid) ; Ph.D. dissertation, Université du Maine, Nantes, France, (1993). 

11 S. R. Pride, F. D. Morgan, et A. F. Gangi, “Drag forces of porousmedium acoustics,” Phys. Rev. B 47, 4964-4975 (1993). 

12 M. Henry, “Mesure des paramètres caractérisant un milieu poreux” (Measurement of porous materials parameters) ; Ph.D. dissertation, Univ. du Maine, Le Mans, France, (1997). 

13 Y. Champoux, M.R. Stinson, and G.A. Daigle, “Air-based system for the measurement of the porosity,” J. Acoust. Soc. Am. 89, 910-916 (1990). 

14 M.R. Stinson and G.A. Daigle, “Electronic system for the measurement of flow resistance,” J. Acoust. Soc. Am., 83, 2422-2428 (1988). 

15 Standard test method for airflow resistance of acoustical materials, ASTM C 522-80 (1980). 

16 R.J.S. Brown, “Connection between formation factor for electrical resistivity and fluid-solid coupling factor in Biot’s equations for acoustic waves in fluid-filled media,” Geophys 45, 1269-1275 (1980). 

17 D.L. Johnson, T.J. Plona, C. Scala, F. Pasierb, and H. Kojima, “Tortuosity and acoustic slow waves,” Phys. Rev. Lett. 49, 1840-1844 (1982). 

18 M. Henry., P. Lemarinier, and J. F. Allard, “Evaluation of the characteristic dimensions for porous sound-absorbing materials,” J. Appl. Phys. 77, 17-20 (1995). 

19 S. Brunauer, P.H. Emmett, and E. Teller, “Adsorption of gases in multimolecular layers,” J. Am. Chem. Soc. 60, 309-319 (1938). 

20 M. Melon, “Caractérisation de matériaux poreux par ultrasons” (Ultrasound characterization of porous materials), Ph.D. dissertation, Univ. du Maine, Le Mans, France, (1996). 

21 J.F. Allard, B. Castagnede, and M. Henry, “Evaluation of tortuosity in acoustic porous materials saturated by air,” Rev. Sci. Instrum. 65(3), 209-210 (1994). 

22 P. Leclaire, L. Kelders, W. Lauriks, M. Melon., N. Brown and B. Castagnede, “Determination of the viscous and thermal characteristic lengths of plastic foams by ultrasonic measurements in helium and air,” J. Appl. Phys. 80, 2009-2012 (1996). 

23 P. Leclaire, L. Kelders, W. Lauriks, C. Glorieux, and J. Thoen, “Determination of the viscous characteristic lengths in air filled porous materials by ultrasonic attenuation measurements,” J. Acoust. Soc. Am. 99(4), 1944-1949 (1996). 

24 Z. A. Fellah, S. Berger, W. Lauriks, C. Depollier, C. Aristégui, and J.-Y. Chapelon, “Measuring the porosity and tortuosity of porous materials via reflected waves at oblique incidence,” J. Acoust. Soc. Am. 113(5), 2424-2433 (2003). 

25 Z.E.A. Fellah, C. Depollier, S. Berger, W. Lauriks, P. Trompette, and J.-Y. Chapelon, “Determination of transport parameters in airsaturated porous materials via reflected ultrasonic waves,” J. Acoust. Soc. Am. 114(5), 2561-2569 (2003). 

26 Y. Atalla, “Développement d’une technique inverse de caractérisation acoustique des matériaux poreux’’ (Development of an inverse characterization method for porous materials), Ph.D. dissertation, Université de Sherbrooke, Sherbrooke, Canada, (2002). 

27 Y. Atalla and R. Panneton, “Low-frequency inverse method for the identification of the viscous and thermal characteristic lengths of porous media,” Proceedings of Internoise 99, 595-600 (1999). 

28 S.S. Rao, _Engineering Optimization: Theory and Practice;_ John Wiley & Sons, New York, (1996). 

29 T. Back, _Evolutionary Algorithms in Theory and Practice;_ University Press, Oxford, (1995). 

30 K.V. Price, _An introduction to Differential Evolution_ (McGrawHill, New York, 1999), pp.79-108. 

31 R. Storn, and K. Price, “Differential Evolution,” Dr. Dobb's Journal 22, 18-24 (1997). 

32 R. Storn, and K. Price, “Differential evolution - A simple and efficient adaptive scheme for global optimization over continuous spaces,” Journal of Global Optimization 11(4), 341-359 (1997). 

33 Standard test method for Impedance and Absorption of acoustical materials using a tube, two microphones and a digital frequency analysis system, ASTM E 1050-86 (1986). 

34 J.F. Allard and Y. Champoux, “New empirical equations for sound absorption in rigid frame fibrous materials,” J. Acoust. Soc. Am. 91, 3346-3353 (1992). 

35 M. E. Delany & E. N. Basely, “Acoustical properties of fibrous materials.” Applied acoustics, 3, 105-116 (1970). 

Vol. 33 No. 1 (2005) - 24 

_Canadian Acoustics / Acoustique canadienne_ 

**Created for You** Brüel&Kjæ r presents its innovative 4th generation hand-held instrum ent for sound and vibration. Experienced users from  all over the w orld assisted us in set­ 

ting the requirements for the new Type 2250. 

- Color Touch Screen is the easiest user interface ever 

- Non-slip surfaces w ith contours de­ signed to  fit com fortably in any hand 

- Incredible 120 dB measurement range so you can't mess up your measurement by selecting an improper measurement range 

- User log-in so the meter is configured the way you w ant it to be, and tem ­ plates to make it easy to find user defined setups 

- Optional Applications fo r Frequency Analysis and Logging are seamlessly integrated w ith the standard integrat­ ing SLM application 

- High Contrast display and "traffic light" indicator make it easy to  determine the measurement status at a distance even in daylight 

- SD and CF memory and USB connectivity make Type 2250 the state-of-the-art sound analyzer 

Created, built and made for you personally, you'll find Type 2250 w ill make a wonderful difference to your w ork and measurements tasks. 

For more info please go directly to 

**www.type2250.com** 

**==> picture [4 x 27] intentionally omitted <==**

**----- Start of picture text -----**<br>
L L "S 89 0V a<br>**----- End of picture text -----**<br>


**HEADQUARTERS: DK-2850 Nærum ■ Denmark ■ Telephone: +4545 80 05 00** 

**Fax: +4545 801405 ■ www.bksv.com ■ info@bksv.com** 

**USA: 2815 Colonnades Court, Building A  - Norcross, GA 30071** 

**Toll free (800) 332-2040 - www.BKhome.com - bkinfo@bksv.com** 

Australia (+61)2 9889-8888 • Austria (+43)1 865 7400 • Brazil (+55) 11 5188-8166 Canada (+1)514695-8225 • China (+86)10680 29906 • Czech Republic (+420)2 67021100 Finland (+358)9-755 950 • France (+33)1 69 90 71 00 • Germ any(+49)421 17 87 0 Hong Kong (+852)2548 7486 • Hungary (+36) 1 215 83 05 • Ireland (+353)1 8074083 Italy (+39)0257 68061 • Japan (+81)3 3779 8671 • Republic o f Korea (+82)2 3473 0605 N etherlands (+31)318 55 9290 • Norw ay (+47)66 771155 • Poland (+48)22 816 75 56 Portugal (+351)21 47114 53 • Singapore (+65)3774512 • Spain (+34)91 6590820 Slovak Republic (+421)25443 0701 • Sweden (+46)8449 8600 Switzerland (+41)1 880 7035 • Taiwan (+886)22 713 9303 U nited Kingdom  (+ 44)1438739000 Local representatives and service organizations w orld w id e 

**ACOustics Begins With ACO™ ACOustical Interface ™** 

**Very Random™ Noise Generator White, Pink, 1kHz SPL Calibrator A/ew511ES124 124 dBSPL@1 kHz iACOtron™Preamps 4022,4012,4016 4212 CCLD for ICP*™ Applications AÆWRA and RAS Right Angle Preamps DM2-22** 

**„ Systems PS9200KIT SI7KIT** 

**Simple Intensity"** _New_ **7052SYS** 

**Includes:** 

**==> picture [418 x 18] intentionally omitted <==**

**----- Start of picture text -----**<br>
4212 CCLD Pream ArTX*tixj«<br>S * J* clo   r<br>**----- End of picture text -----**<br>


**for ICP™ Applications^** 

**7052S Type 1.5™ 2 Hz to>20 kHz Titanium Diaphrag WS1 Windscreen Measurement Microphones Type 1** 

**Dummy Mic WS1 and WS7 Windscreens** _**NEW**_ **-80T Family Hydrophobically Treated** _NEW_ **SA6000 Family ACOustAlarm™ with ACOustAlert™** 

**1” 1/2” 1/4”** 

**2Hz to 120 kHz <10 dBA Noise >175 dBSPL Polarized and Electret** 

## **ACO Pacific, Inc.** 

_NEW_ **PSIEPE4 2604 Read Ave., Belmont, California, 94002, USA** _and_ **ICP1248 Tel: 650-595-8588 Fax: 650-591-2891 ICP™(pcb) Adaptors for P S 9 2 0 0 a n d P h a n t o m e-Mail: acopac@acopacific.com Web Site: www.acopacific.com**