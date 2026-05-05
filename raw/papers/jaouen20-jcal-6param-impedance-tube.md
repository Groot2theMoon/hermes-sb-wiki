---
title: "Estimation of all six parameters of Johnson-Champoux-Allard-Lafarge model for acoustical porous materials from impedance tube measurements"
authors: ["Luc Jaouen, Emmanuel Gourdon, Philippe Glé"]
year: 2020
source: paper
journal: "J. Acoust. Soc. Am., 148(4), 1998 — DOI: 10.1121/10.0002110"
ingested: 2026-05-05
sha256: 7e403bd943de333aa595d0fe3dc9a3d3ceec56b8791a2790ca44e826715ec48c
conversion: pymupdf4llm
---

ARTICLE ................................... 

**==> picture [49 x 22] intentionally omitted <==**

## Estimation of all six parameters of Johnson-Champoux-AllardLafarge model for acoustical porous materials from impedance tube measurements 

Luc Jaouen,[1,][a)] Emmanuel Gourdon,[2,][b)] and Philippe Gle[�][3,][c)] 

1Matelys, 7 rue des Mara^ıchers, Vaulx-en-Velin, 69120, France 

Ecole Nationale des Travaux Publics de l’2�Laboratoire de Tribologie et Dynamique des Syste`mes, Unit �Etat, rue Maurice Audin, 69518, Vaulx en Velin Cedex, Francees Mixtes de Recherche, Centre National de la Recherche Scientifique 5513,� 

> 3 � � Unite Mixte de Recherche en Acoustique Environnementale, Centre d’Etudes et d’expertise sur les Risques, l’Environnement, la Mobilite et l’Amenagement, Universit� e Gustave Eiffel, 11 rue Jean Mentelin, Strasbourg, 67200, France� 

## ABSTRACT: 

The open porosity of air-saturated acoustical porous materials is estimated from the low-frequency or highfrequency asymptotes of the real part of the dynamic bulk modulus. Combining this technique with the estimation of the static air-flow resistivity from the low-frequency asymptote of the imaginary part of the dynamic mass density and the analytical inversions of the remaining parameters from the dynamic mass density and bulk modulus [methods introduced by Panneton and Olny, J. Acoust. Soc. Am. 119(4), 2027–2040 (2006) and Olny and Panneton 123(2), 814–824 (2008)], this work estimates all six parameters of a Johnson-Champoux-Allard-Lafarge model from impedance tube measurements. A classical two-microphone impedance tube, as well as three- or four-microphone tubes, can be used for these measurements and estimations. Examples of applications and limits of the method are presented and a tool to estimate the open porosity and the static air-flow resistivity is made available online. VC 2020 Acoustical Society of America. https://doi.org/10.1121/10.0002162 (Received 30 April 2020; revised 18 September 2020; accepted 19 September 2020; published online 13 October 2020) [Editor: Kirill V. Horoshenkov] Pages: 1998–2005 

## I. INTRODUCTION 

The open porosity, defined as the ratio between the fluid volume occupied by the connected fluid phase to the total volume of a material, is a key parameter to describe the sound performances of porous materials (in some models, it is hidden as it is assumed to be close to one). 

Various techniques have been developed to measure this parameter for porous materials, in general, and acoustical porous materials, in particular. An overview of these techniques, which are mostly based on Archimedes’s principle, Boyle-Mariotte law, and, more recently, impedance tube measurements, is presented in Sec. II. 

In addition to these works on the open porosity assessment, a technique has been developed for the estimation of the five remaining parameters of the Johnson-ChampouxAllard-Lafarge (JCAL) model[1–3] (see Ref. 4 for an overview of the complete model). This technique, introduced by Panneton and Olny[5] and Olny and Panneton,[6] is based, using an impedance tube, on the measurements of the dynamic mass density and the dynamic bulk modulus.[7][,][8] This method is described in Sec. III. 

Reworking a technique for the estimation of the open porosity estimation from impedance tube measurements and combining it with works by Olny and Panneton, we propose 

> a)Electronic mail: luc.jaouen@matelys.com, ORCID: 0000-0002-3141-800X. b)ORCID: 0000-0002-6746-4403. c)ORCID: 0000-0002-1916-430X. 

a technique for the estimation of all six parameters of the JCAL model from impedance tube measurements. The novelty of this work lies in the fact that only one apparatus (among the most widespread in acoustic laboratories and providing extra information, such as the measured normal sound absorption and normal surface impedance, at no extra cost), working at audible frequencies, is used to estimate six parameters. This operation is performed in four steps, as described in Sec. III, instead of using a global minimization. The list of the estimated parameters is reported in Table I together with the quantities from which the parameters are estimated. Applications of this technique are presented in Sec. IV. 

A tool to estimate the open porosity and the static airflow resistivity is made available online.[9] 

## II. OPEN POROSITY ASSESSMENT 

A brief overview of the methods used to assess the open porosity in acoustical porous materials is first presented. An issue encountered with materials having multiple scales of porosity is then discussed, as well as a technique introduced to deal with this issue. In Sec. IIB, this technique is used to estimate the open porosity of acoustical materials in general. 

## A. Overview of the open porosity measurement or estimation techniques 

Numerous methods have been developed to measure or estimate the value of the open porosity of materials. This 

0001-4966/2020/148(4)/1998/8/$30.00 

1998 J. Acoust. Soc. Am. 148 (4), October 2020 

> VC 2020 Acoustical Society of America 

https://doi.org/10.1121/10.0002162 

**==> picture [84 x 57] intentionally omitted <==**

TABLE I. Parameters of the JCAL model and the quantity from which they can be estimated. K denotes the complex dynamic bulk modulus, q is the complex dynamic mass density, Re is the real part of a quantity, and Im is the imaginary part of a quantity. 

|Parameter|Symbol|Units|Estimation from|
|---|---|---|---|
|Open porositya|/||Low- or high-frequency asymptote of Re(K)|
|Static air-fow resistivity|r|N s m�4|Low-frequency asymptote of Im(q)|
|High-frequency limit of the||||
|dynamic tortuosityb|a1||q|
|Characteristic viscous length|K|m|q|
|Characteristic thermal length|K0|m|K|
|Static thermal permeability|k0<br>0|m2|K|



aOften referred to as porosity while not being always equivalent. bOften referred to as tortuosity. 

section provides a brief and non-exhaustive overview of these methods. In geophysics, the methods to measure or estimate the open porosity are usually based on Archimedes’s principle, saturating the pores by a fluid like, for example, mercury (see, e.g., Ref. 10). For acoustical porous materials (usually exhibiting only one fluid phase, air, saturating the solid phase), Beranek published a first method in 1942 (Ref. 11), based on the Boyle-Mariotte law. This method is suitable for materials characterized by a high open porosity (often 90% or more) and pore dimensions between 10 to 1000 lm (i.e., the same size as the viscous and thermal boundary layers for hollow cylinders in the human audible frequency range). The method was further refined in 1991 by Champoux et al.,[12] who published the scheme of an apparatus, including a reservoir to isolate the apparatus from atmospheric pressure fluctuations, a piston with a micrometer drive for multiple point measurements, and an air-based differential pressure transducer. 

Some other variants of Archimedes’s principle or the Boyle-Mariotte law have been proposed by different authors, most often to simplify the method and reduce the measurement times or the costs of previous methods (see, e.g., Refs. 13–16). 

To date, all the methods referred to above have been successfully used worldwide on thousands of materials with only one important point to notice: the measured open porosity includes the volume of pores with diameters below 1 lm [which can represent a porosity up to 0.7 (Ref. 17)] but which have a negligible contribution to the acoustic flow. This point, which is one of the motivations of our work, will be discussed later on. 

Other techniques to assess the open porosity include optical methods (see, e.g., Sec. 3.2.4.2.3 in Ref. 18), in particular, computed tomograph scans, or methods based on pulse reflection and/or transmission with signal postprocessing at ultrasonic frequencies. In 2003, as an example of the pulse method, Fellah et al.[19] proposed a technique based on the measurements of the reflection coefficients for two oblique incidences. The reflected waves are approximated by the waves reflected at the first air–porous interface; in other words, the method gives information on the “areal” porosity, i.e., at the interface between the material and the surrounding fluid (this areal porosity might differ 

from the volumetric porosity due to foaming process, gravity, crumbling, etc., which can lead to a stratified material or material with gradually varying properties). In 2005, Umnova et al.[20] proposed another method at ultrasonic frequencies. As in the work by Fellah et al.,[19] this method gives estimations for both the tortuosity and open porosity. This time, though, both reflection and transmission measurements are applied on thick samples of rigid porous materials consisting of large grains or fibers with a mean pore size or mean characteristic size of several millimeters. 

In the audible frequency range, and in an impedance tube, the first work, to our knowledge, was proposed by Sellen[21] in 2003 with an estimation of the open porosity / from the low-frequency asymptotes of the acoustic admittance Y (note that the e[þ][j][x][t] time convention is used in this article), 

**==> picture [227 x 22] intentionally omitted <==**

where x denotes the angular frequency in Hertz. h is the thickness of the tested material sample in meters, P0 is the atmospheric pressure in Pascal during the measurements, and Im denotes the imaginary part of a complex quantity. One drawback of this method, pointed out by the author in Ref. 21 (see p. 88 or p. 104) and others[22] is its low accuracy for materials with high open porosity (from 80% and above) due to a limited resolution of the admittance values. 

Facing issues assessing the open porosity that only contributes to the acoustical flow of materials with multiple scales of porosity, some authors found this quantity could be estimated from the low- or high-frequency asymptotes of the dynamic bulk modulus K.[23–26] We suggest to name this open porosity that participates in the acoustical flow in multi-scale porous materials the “effective open porosity.” 

In previous works, impedance tube measurements were performed in addition to direct measurements based on Archimedes’s principle or the Boyle-Mariotte law except in the works by Venegas and Umnova[24] and Venegas,[25] involving activated carbons that support adsorption and desorption for which the direct porosity measurements could provide effective porosity values much larger than one. 

These works, based on impedance tube measurements, were all applied to materials with multiple scales of porosity: double-porosity mineral foams in Ref. 23, double- 

J. Acoust. Soc. Am. 148 (4), October 2020 

Jaouen et al. 1999 

https://doi.org/10.1121/10.0002162 

**==> picture [84 x 57] intentionally omitted <==**

porosity granular materials in Refs. 24 and 25, or fibrous materials made of natural hollow fibers in Ref. 26, with an exception being[25] where it was also applied to a single porosity granular (see pp. 83 and 84). 

The motivation behind these impedance tube measurements was to identify which part of the open porosity participates with the acoustic flow, i.e., the effective open porosity. Indeed, direct measurements, based on Archimedes’s principle and the Boyle-Mariotte law, can measure the porosity in a connected network of pores with pores having a characteristic dimension on the order of 1 lm or less. While this specific “micro” porosity does not participate in the acoustic flow, it can, however, be important for thermal exchanges or adsorption/desorption effects. 

Note that most three-dimensional (3D) printed materials available today faced this double-porosity issue as the printing resolution, usually around some micrometers for polymers, implies a micro porosity, in addition to the designed and targetted “meso” porosity. 

## B. The proposed methodology and its limitations 

The proposed methodology is equivalent to the one described to deal with materials exhibiting multiple scales of porosity with one scale having a characteristic length on the order of 1 lm or less. However, we will apply it, here, to porous media with a single porosity scale. 

The low- and high-frequency asymptotes of the real part of the dynamic bulk modulus are, respectively, 

**==> picture [227 x 24] intentionally omitted <==**

**==> picture [227 x 24] intentionally omitted <==**

where c is the ratio of the specific heats of the fluid saturating the pores of the material. 

Equations (2) and (3) show that the open porosity / affects the low- and high-frequency asymptotes of the real part of the bulk modulus of a material. Thus, measuring the bulk modulus of a material with an impedance tube (see Sec. III A) and identifying its low- or high-frequency asymptote allows for the estimation of the open porosity /. Note that it is usually not possible to observe both asymptotes with a unique, classical, impedance tube (as it would require a tube with a small diameter—while being large enough to ensure the sample is representative of the material—and a large spacing between the upfront microphones). 

- (1) Measurement of the dynamic mass density and bulk modulus (see Sec. III A), 

- (2) estimation of the open porosity following the method described in Sec. II B, 

- (3) estimation of the static air-flow resistivity following the work by Panneton and Olny,[5] and 

- (4) estimation of the four remaining parameters following Panneton and Olny.[5][,][6] 

## A. Measurement of dynamic mass density and bulk modulus 

The dynamic mass density and bulk modulus of a porous material can be measured from various impedance tube configurations. We refer the reader to the works presented in Table II for detailed descriptions of how to measure these quantities, depending on the configuration. 

Note that the dynamic mass density q (kg m[�][3] ) and the dynamic bulk modulus K (Pa) are linked to the characteristic wavenumber k (m[�][1] ) and the characteristic impedance Zc (N s m[�][3] ; used in some references of Table II alternately to q and K) by the following relations: 

**==> picture [227 x 54] intentionally omitted <==**

**==> picture [227 x 22] intentionally omitted <==**

**==> picture [227 x 21] intentionally omitted <==**

While these latter intrinsic quantities describe the material at specific pressure and temperature conditions, it is usually preferable to extract the intrinsic parameters leading to these quantities by following a model like JCAL to get more insight of the dissipation mechanisms inside this material. 

## B. Estimation of the static air-flow resistivity 

In 2006, Panneton and Olny[5] proposed a method to estimate the static air-flow resistivity r from the imaginary part of the dynamic mass density q, 

**==> picture [227 x 15] intentionally omitted <==**

TABLE II. Methods available to assess the dynamic mass density q and dynamic bulk modulus K of porous media from impedance tube measurements. 

## III. ESTIMATIONS OF ALL SIX JCAL PARAMETERS 

Using the method described in Sec. II B and the works published by Panneton and Olny and Olny and Panneton,[5][,][6] it is, thus, possible to estimate the six parameters of the JCAL model. These parameters and the way they can be estimated are reported in Table I. 

The characterizations of these six acoustical parameters rely on a four-step method: 

|Method|Reference(s)|
|---|---|
|Two microphones, two thicknesses|Smith and Parrott (Ref.35)|
|Two microphones, two cavities|Utsunoet. al. (Ref.34)|
|Three microphones, rigid backing|Iwaseet al.(Refs.30and36)|
||Salissou and Panneton (Ref.37)|
|Three microphones with cavity|Salissouet al.(Ref.38)|
|Four microphones|Song and Bolton (Ref.39)|



2000 J. Acoust. Soc. Am. 148 (4), October 2020 

Jaouen et al. 

https://doi.org/10.1121/10.0002162 

**==> picture [84 x 57] intentionally omitted <==**

This method, tested on numerous materials and by several characterization laboratories, now appears in the informative appendix of ISO 9053-1.[27] 

## C. Analytical inversion of the four remaining parameters 

The main topic of the works by Panneton and Olny[5][,][6] was the estimation of the four parameters which remain to be estimated: the high-frequency limit of the dynamic tortuosity (term often simplified to simply “tortuosity”) a1, the viscous characteristic length K, the thermal characteristic length K[0] , and the static thermal permeability k0[0][. These esti-] mations are done by analytical inversions of the expressions of q and K given in the JCAL model. 

Indeed, for the JCAL model, q and K are 

**==> picture [227 x 115] intentionally omitted <==**

where q0 is the density at rest of the fluid saturating the pores (kg m[�][3] ), g is its dynamic viscosity (N s m[�][2] ), Cp is its specific heat at constant pressure (J kg[�][1] K[�][1] ], and j is its thermal conductivity (W m[�][1] K[�][1] ). 

The four remaining parameters can, therefore, be estimated from previous knowledge of the open porosity / and the static air-flow resistivity r as 

**==> picture [227 x 168] intentionally omitted <==**

Note that the estimations of the four remaining parameters are not based on asymptotic behaviors for q or K and should be valid in the whole frequency range of use of an impedance tube following ISO 10534-2 (Ref. 28), assuming that none of the effects discussed in Sec. V affect the measurements of q and K. 

## IV. APPLICATIONS 

To illustrate the six-parameter characterization method described above, two examples are reported below: one with 

TABLE III. Parameters of the JCAL model and their standard deviations estimated using the method described in this work for the two tested materials. 

|Parameter|Symbol|Units|Material 1|Material 2|
|---|---|---|---|---|
|Open porosity|/||0.9960.01|0.8860.02|
|Static air-fow resistivity|r|N s m�4|29006100|2810061700|
|High-frequency limit of the|||||
|dynamic tortuosity|a1||1.0160.01|1.8260.24|
|Characteristic viscous length|K|10�6 m|200611|5564|
|Characteristic thermal length|K0|10�6 m|896654|105613|
|Static thermal permeability|k00|10�10 m2|140617|2269|



a material of open porosity estimated to 0.99 6 0.01 and a second for a material with a lower porosity estimated to 0.88 6 0.02. The measured open porosities for these materials, following the direct measurement technique described by Champoux et al.[12] [i.e., ISO 9053-1 (Ref. 27)], were 0.99 6 0.01 and 0.87 6 0.02, respectively. Obviously, the small deviation between the measured and estimated values for the second material has no noticeable impact on the other parameters. The complete set of parameters for these materials, obtained using the method described in this work, are reported in Table III. 

The measurements have been performed with threemicrophone impedance tubes of inner-diameters 29 mm (material 1) and 46 mm (material 2). For both tubes, the distance between the two up-front microphones was 20 mm. The tube with an inner-diameter of 46 mm has a highfrequency limit for the validity of the measurements around 4300 Hz (where the effects of the first non-planar acoustic mode propagation are no longer negligible). The highfrequency limit of the 29-mm inner diameter tube is theoretically around 6400 Hz, but only results up to 5000 Hz are reported as effects of the first non-planar acoustic mode of propagation can already be observed at 5000 Hz (see Fig. 1 or Fig. 5, for example). The microphone spacing explains 

**==> picture [203 x 158] intentionally omitted <==**

FIG. 1. (Color online) Material 1 (grey). The real part of the dynamic bulk modulus (K) normalized by the static pressure during measurements P0 (101 000 Pa) as a function of the frequency. Shown in dashed red is the estimation of the porosity in the frequency range identified in green. 

J. Acoust. Soc. Am. 148 (4), October 2020 

Jaouen et al. 2001 

https://doi.org/10.1121/10.0002162 

**==> picture [84 x 57] intentionally omitted <==**

FIG. 2. (Color online) Material 2 (grey). The real part of the dynamic bulk modulus K normalized by the static pressure during measurements P0 (101 500 Pa) as a function of the frequency. Shown in dashed red is the estimation of the porosity in the frequency range identified in green. 

the noise observed in Figs. 1 and 5 at frequencies below 150–200 Hz. 

## A. Estimations of the open porosities 

The real part of the measured bulk modulus, normalized with the static atmospheric pressure during test P0, is plotted as a function of the frequency for each material in Figs. 1 and 2. 

One of the two asymptotes reported in Sec. II B has to be identified by the experimenter for the estimation of the open porosity. Here, a frequency range is identified, in green, where the asymptote is supposed to be reached. From this frequency range, a mean or mode value for the open porosity can then be estimated, as well as a confidence interval (here, the standard deviation). 

In Fig. 2, the low-frequency asymptote is used to estimate the open porosity, whereas in Fig. 1, the highfrequency asymptote is used. To clearly identify these asymptotic regimes, log-scales for abscissas are used in Figs. 1 and 2. 

## B. Estimations of the static air-flow resistivities 

The estimations of the static air-flow resistivities for both materials are done using the low-frequency asymptote of the imaginary part of the dynamic mass density [see Eq. (8)]. 

Figures 3 and 4 show the frequency ranges for each material, in green, where the asymptotes are supposed to be reached. From a frequency range, a mean or mode value for the static air-flow resistivity can then be estimated, as well as a confidence interval (here, again, the standard deviation). 

The estimation of the static air-flow resistivity r for material 1 (Fig. 3) is done between approximately 750 and 1050 Hz as the lower frequencies are impacted with 

**==> picture [218 x 183] intentionally omitted <==**

FIG. 3. (Color online) Material 1 (grey). The imaginary part of the dynamic mass density (q) normalized by the mass density of air at rest q0 (1.2 kg m[�][3] ) as a function of the frequency. Shown in dashed purple is the same quantity estimated using Eq. (8) with the mean value of the static air-flow resistivity r obtained in the highlighted frequency area. 

vibrations of the material skeleton (also known as Biot resonances). A Biot resonance is also observed, to a lesser extent, on the dynamic bulk modulus (see Figs. 1 and 5). 

## C. Estimations of the four remaining parameters for each material 

Figures 5 and 6 show the real and imaginary parts of the dynamic bulk modulus and dynamic mass density, respectively, for material 1, together with the simulations of these quantities with respect to the JCAL model using the parameters reported in Table III. The remaining parameters 

**==> picture [223 x 184] intentionally omitted <==**

FIG. 4. (Color online) Material 2 showing the imaginary part of the dynamic mass density (q) normalized by the mass density of air at rest q0 (1.2 kg m[�][3] ) as a function of the frequency. Shown in dashed purple is the same quantity estimated using Eq. (8) with the mean value of the static airflow resistivity r obtained in the highlighted frequency area. 

2002 J. Acoust. Soc. Am. 148 (4), October 2020 

Jaouen et al. 

https://doi.org/10.1121/10.0002162 

**==> picture [209 x 37] intentionally omitted <==**

**==> picture [223 x 67] intentionally omitted <==**

FIG. 5. (Color online) Material 1 (grey). Measurements of the real (top) and imaginary (bottom) parts of the dynamic bulk modulus (K) normalized by the static pressure P0 (101 000 Pa) as a function of the frequency. Shown in dashed blue and dashed purple are the same quantities estimated using the material parameters reported in Table III. 

have been estimated using the analytical inversions proposed by Panneton and Olny and Olny and Panneton.[5][,][6] Good correspondences are observed between measurements and simulations (except in the frequency range where a Biot resonance occurs). 

Figures 7 and 8 show the real and imaginary parts of the dynamic bulk modulus and dynamic mass density, respectively, for material 2, together with the simulations of these quantities after estimations of the remaining parameters (again following the works by Panneton and Olny and Olny and Panneton[5][,][6] ). The mean values of the parameters, together with their standard deviations, are reported in Table III. Again, a good correspondence is observed between 

**==> picture [223 x 126] intentionally omitted <==**

FIG. 6. (Color online) Material 1 (grey). Measurements of the real (top) and imaginary (bottom) parts of the dynamic mass density (q) normalized by the mass density of air at rest q0 (1.2 kg m[�][3] ) as a function of the frequency. Shown in dashed blue and dashed purple are the same quantities estimated using the material parameters reported in Table III. 

**==> picture [214 x 40] intentionally omitted <==**

FIG. 7. (Color online) Material 2 (grey). Measurements of the real (top) and imaginary (bottom) parts of the dynamic bulk modulus (K) normalized by the static pressure P0 (101 000 Pa) as a function of the frequency. Shown in dashed blue and dashed purple are the same quantities estimated using the material parameters reported in Table III. 

measurements and simulations for this material and with these parameters. 

## V. DISCUSSION 

The method described in this work and the accuracy of the estimated parameters obviously depend on the measured mass density q and bulk modulus K. 

Different effects can influence the characterization process. 

> • The boundary conditions can influence the overall behaviors of q and K. Leakages around the material sample in the tube can create double-porosity effects,[29] which will modify q and K. Vibrations of the material skeleton (i.e., 

**==> picture [222 x 184] intentionally omitted <==**

FIG. 8. (Color online) Material 2 (grey). Measurements of the real (top) and imaginary (bottom) parts of the dynamic mass density (q) normalized by the mass density of air at rest q0 (1.2 kg m[�][3] ) as a function of the frequency. Shown in dashed blue and dashed purple are the same quantities estimated using the material parameters reported in Table III. 

J. Acoust. Soc. Am. 148 (4), October 2020 

Jaouen et al. 2003 

https://doi.org/10.1121/10.0002162 

**==> picture [84 x 57] intentionally omitted <==**

its solid phase) will also have an impact on the measured q and K. Thus, it is important to avoid or reduce such effects, as discussed in ISO 10534-2 (Ref. 28), concerning leakages or adding nails to the material sample as described in Ref. 30 to reduce or shift the frequencies of the frame resonances, or to extract the parameters from frequency ranges not affected by the boundary conditions. 

- The accuracy in the estimations of / and r influences the other parameters. Indeed, / is needed to estimate K[0] and k0[0][, whereas][ /][ and][ r][ are needed to estimate][ a][1][and][ K][ (see] Sec. III C). 

From measurements on nearly a hundred materials (foams, granular materials—from assembly of polymer spheres to road pavements, compressed or not compressed fibrous, including felts), it appears the proposed estimation method for the open porosity has a standard deviation dependent on the porosity value of a material. For high porosity materials (/ � 0:90), its standard deviation is usually 2% compared to 1%–2% for the direct measurement based on the method by Champoux et al.[12] For low porosity materials (/ < 0:90), its standard deviation is usually 5% compared to 2%–5% for the direct measurement based on the method by Champoux et al. The standard deviations of the direct measurements are extracted from inter-laboratory tests, in particular, the one by Pompoli et al.,[31] published in 2017. 

Concerning the resistivity, the uncertainty greatly depends on the nature of the material and a generalized value for the standard deviation is not easy to define. From the materials tested by the authors, it appears that the standard deviation for the resistivity is around 5%–20% (as the standard deviation for direct measurements observed in Ref. 31, excluding results obviously irrelevant). 

Concerning the four remaining parameters, works are still in progress to observe if generalized values can be 

Finally, one should note that to obtain a fair signal-tonoise ratio when measuring the quantities q and K, it might be necessary to increase or decrease the thickness of the tested sample. An alternative method for material samples with a small thickness has also been proposed[32] to characterize facing screens or perforated plates (which can be considered as thin porous materials[33] ). 

## VI. CONCLUSION 

A method for the characterization of the six acoustical parameters of the JCAL model has been presented. It requires the use of only one device: an impedance tube (with two-, three-, or four-microphone positions by measuring the dynamic mass density q and the dynamic bulk modulus K). This method is not based on any numerical inversions but relies on analytical calculations of the parameter values from measured q and K and the identification of two of their asymptotic behaviors. 

This method offers the following: 

- a validity check compared to direct measurements of the open porosity and the static air-flow resistivity when these quantities can be directly obtained, 

- estimations for these quantities when they cannot be directly measured (i.e., when material samples do not fulfill the direct measurement requirements) and allows the complete characterization of the material. 

1D. L. Johnson, J. Koplik, and R. Dashen, “Theory of dynamic permeability and tortuosity in fluid-saturated porous media,” J. Fluid Mech. 176, 379–402 (1987). 2Y. Champoux and J.-F. Allard, “Dynamic tortuosity and bulk modulus in air-saturated porous media,” J. Appl. Phys. 70, 1975–1979 (1991). 3 D. Lafarge, P. Lemarinier, J.-F. Allard, and V. Tarnow, “Dynamic compressibility of air in porous structures at audible frequencies,” J. Acoust. Soc. Am. 102(4), 1995–2006 (1997). 4L. Jaouen, “JCAL model” (2006), available at http://apmr.matelys.com/ PropagationModels/MotionlessSkeleton/JohnsonChampouxAllardLafarge Model.html (Last viewed April 9, 2020). 5R. Panneton and X. Olny, “Acoustical determination of the parameters governing viscous dissipation in porous media,” J. Acoust. Soc. Am. 119(4), 2027–2040 (2006). 6X. Olny and R. Panneton, “Acoustical determination of the parameters governing thermal dissipation in porous media,” J. Acoust. Soc. Am. 123(2), 814–824 (2008). 7I. B. Crandall, Theory of Vibrating Systems and Sound (Van Nostrand Cie, New York, 1926). 8O. C. Zwikker and C. W. Kosten, Sound-Absorbing Materials (Elsevier, New York, 1949). 9See https://bit.ly/CharacFromTube (Last viewed October 6, 2020). 10ISO 15901-1, “Acoustics—Evaluation of pore size distribution and porosity of solid materials by mercury porosimetry and gas adsorption—Part 1: Mercury porosimetry” (International Organization for Standardization, Geneva, Switzerland, 2016). 11L. L. Beranek, “Acoustic impedance of porous materials,” J. Acoust. Soc. Am. 13, 248–260 (1942). 12Y. Champoux, M. R. Stinson, and G. A. Daigle, “Air-based system for the measurement of porosity,” J. Acoust. Soc. Am. 89(2), 910–916 (1991). 13R. W. Leonard, “Simplified porosity measurements,” J. Acoust. Soc. Am. 20(1), 39–41 (1948). 14P. Leclaire, O. Umnova, K. Horoshenkov, and L. Maillet, “Porosity measurement by comparison of air volumes,” Rev. Sci. Instrum. 74(3), 1366–1370 (2003). 

> 15R. Panneton and E. Gros, “A missing mass method to measure the open porosity of porous solids,” Acta Acust. Acust. 91(2), 342–348 (2005). 

> 16Y. Salissou and R. Panneton, “Pressure/mass method to measure open porosity of porous solids,” J. Appl. Phys. 101, 124913 (2007). 17F.-X. B�ecot, L. Jaouen, and E. Gourdon, “Applications of the dual porosity theory to irregularly shaped porous materials,” Acta Acust. Acust. 94(5), 715–724 (2008). 

- 18F. A. L. Dullien, Porous Media: Fluid Transport and Pore Structure (Academic, New York, 1979). 

> 19Z. E. Fellah, S. Berger, W. Lauriks, C. Depollier, C. Arist�egui, and J.-Y. Chapelon, “Measuring the porosity and the tortuosity of porous materials via reflected waves at oblique incidence,” J. Acoust. Soc. Am. 113(5), 2424–2433 (2003). 

20O. Umnova, K. Attenborough, H.-C. Shin, and A. Cummings, “Deduction of tortuosity and porosity from acoustic reflection and transmission measurements on thick samples of rigid-porous materials,” Appl. Acoust. 66(6), 607–624 (2005). 

> 21N. Sellen, “Modification de l’imp�edance de surface d’un mat�eriau par contr^ole actif: Application �a la caract�erisation et �a l’optimisation d’un absorbant acoustique” (“Modification of the surface impedance of a material with active control: Application to the characterization and the optimization of an acoustic absorber”), Ph.D. thesis, Ecole Centrale de Lyon, Lyon, France, 2003 (in French). 

> 22G. Beno^ıt, “Caract�erisation des propri�et�es acoustiques de rev^etements poreux par mesures in situ—Application au colmatage des chauss�ees” (“Characterization of the acoustic properties of porous coatings using 

2004 J. Acoust. Soc. Am. 148 (4), October 2020 

Jaouen et al. 

https://doi.org/10.1121/10.0002162 

**==> picture [84 x 57] intentionally omitted <==**

in-situ measurements—Application to the clogging of road surfaces”), Ph.D. thesis, Ecole Nationale des Travaux Publics de l’Etat, Lyon, France, 2013 (in French). 

- 23L. Jaouen and X. Olny, “Indirect acoustical characterization of a foam with two scales of porosity,” in Proc. of SAPEM, 2005, Lyon, France (2005). 

- 24R. Venegas and O. Umnova, “Acoustical properties of double porosity granular materials,” J. Acoust. Soc. Am. 130(5), 2765–2776 (2011). 

- 25R. Venegas, “Microstructure influence on acoustical properties of multiscale porous materials,” Ph.D. thesis, University of Salford, Salford, UK, 2011. 

- 26P. Gl�e, “Acoustique des mat�eriaux du b^atiment �a base de fibres et particules v�eg�etales—Outils de caract�erisation, mod�elisation et optimisation (“Acoustics of building materials based on vegetal fibers and particles— Characterization, modeling and optimization tools”),” Ph.D. thesis, Ecole Nationale des Travaux Publics de l’Etat, Lyon, France, 2013 (in French). 

- 27ISO 9053-1, “Acoustics—Materials for acoustical applications— Determination of airflow resistance—Part 1: Static airflow method” (International Organization for Standardization, Geneva, Switzerland, 2018). 

- 28ISO 10534-2, “Acoustics—Determination of sound absorption coefficient and impedance in impedance tubes—Part 2: Transfer-function method” (International Organization for Standardization, Geneva, Switzerland, 1998). 

- 29X. Olny and C. Boutin, “Acoustic wave propagation in double porosity media,” J. Acoust. Soc. Am. 114, 73–89 (2003). 

- 30T. Iwase, Y. Izumi, and R. Kawabata, “A new sound tube measuring method for propagation constant in porous material—Method without any air space at the back of test material,” in Proc. of Internoise, 1998, Christchurch, New Zealand (1998). 

- 31F. Pompoli, P. Bonfiglio, K. V. Horoshenkov, A. Khan, L. Jaouen, F.-X. B�ecot, F. Sgard, F. Asdrubali, F. D’Alessandro, J. H€ubelt, N. Atalla, C. K. Am�edin, W. Lauriks, and L. Boeckx, “How reproducible is the acoustical characterization of porous media?,” J. Acoust. Soc. Am. 141(2), 945–955 (2017). 

- 32L. Jaouen and F.-X. B�ecot, “Acoustical characterization of perforated facings,” J. Acoust. Soc. Am. 129(3), 1400–1406 (2011). 

- 33N. Atalla and F. Sgard, “Modeling of perforated plates and screens using rigid frame porous models,” J. Sound Vib. 303, 195–208 (2007). 

- 34H. Utsuno, T. Tanaka, T. Fujikawa, and A. F. Seybert, “Transfer function method for measuring characteristic impedance and propagation constant of porous materials,” J. Acoust. Soc. Am. 86(2), 637–643 (1989). 

- 35C. D. Smith and T. L. Parrott, “Comparison of three methods for measuring acoustic properties of bulk materials,” J. Acoust. Soc. Am. 74(5), 1577–1582 (1983). 

- 36 T. Iwase and Y. Izumi, “A new sound tube measuring method for propagation constant in porous material—Method without any air space at the back of test material,” J. Acoust. Soc. Jpn. J. 52(6), 411–419 (1996) (in Japanese). 

37Y. Salissou and R. Panneton, “Wideband characterization of the complex wave number and characteristic impedance of sound absorbers,” J. Acoust. Soc. Am. 128(5), 2868–2876 (2010). 

- 38Y. Salissou, O. Doutres, and R. Panneton, “Complement to standard method for measuring normal incidence sound transmission loss with three microphones,” J. Acoust. Soc. Am. 131, EL216–EL222 (2012). 

- 39B. H. Song and J. S. Bolton, “A transfer matrix approach for estimating the characteristic impedance and wave numbers of limp and rigid porous materials.,” J. Acoust. Soc. Am. 107(3), 1131–1152 (2000). 

J. Acoust. Soc. Am. 148 (4), October 2020 

Jaouen et al. 2005