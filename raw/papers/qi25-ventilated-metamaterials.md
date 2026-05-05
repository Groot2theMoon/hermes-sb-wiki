---
title: "Low-frequency broadband metamaterials for ventilated acoustic insulation"
authors: ["Hao-Bo Qi, Shi-Wang Fan, Mu Jiang, Zhu Tong, Badreddine Assouar, Yue-Sheng Wang"]
year: 2025
source: paper
journal: "Int. J. Mechanical Sciences — HAL: hal-04982038"
ingested: 2026-05-05
sha256: 09c75772fc3495784849309d4db0c1e6ab13f86b8cafeed34730745a9116be0e
conversion: pymupdf4llm
---

**==> picture [242 x 136] intentionally omitted <==**

## **Low-frequency broadband metamaterials for ventilated acoustic insulation** 

Hao-Bo Qi, Shi-Wang Fan, Mu Jiang, Zhu Tong, Badreddine Assouar, Yue-Sheng Wang 

**==> picture [8 x 10] intentionally omitted <==**

## **To cite this version:** 

Hao-Bo Qi, Shi-Wang Fan, Mu Jiang, Zhu Tong, Badreddine Assouar, et al.. Low-frequency broadband metamaterials for ventilated acoustic insulation. International Journal of Mechanical Sciences, 2025, 289, pp.110044. ⟨10.1016/j.ijmecsci.2025.110044⟩. ⟨hal-04982038⟩ 

## **HAL Id: hal-04982038 https://hal.science/hal-04982038v1** 

Submitted on 7 Mar 2025 

**HAL** is a multi-disciplinary open access archive for the deposit and dissemination of scientific research documents, whether they are published or not. The documents may come from teaching and research institutions in France or abroad, or from public or private research centers. 

L’archive ouverte pluridisciplinaire **HAL** , est destinée au dépôt et à la diffusion de documents scientifiques de niveau recherche, publiés ou non, émanant des établissements d’enseignement et de recherche français ou étrangers, des laboratoires publics ou privés. 

**==> picture [49 x 18] intentionally omitted <==**

Distributed under a Creative Commons CC BY-NC-ND 4.0 - Attribution - Non-commercial use - No Derivative Works - International License 

## Low-frequency Broadband Metamaterials for Ventilated Acoustic 

## Insulation 

Hao-Bo Qi[1] , Shi-Wang Fan[2,3,] *, Mu Jiang[1,4] , Zhu Tong[1] , Badreddine Assouar[4,] * and YueSheng Wang[1,5,] * 

> 1 _Department of Mechanics, School of Mechanical Engineering, Tianjin University, Tianjin 300350, China_ 

> 2 _Department of Engineering Mechanics, Shijiazhuang Tiedao University, Shijiazhuang 050043, China_ 

> 3 _Provincial Collaborative Innovation Center of Mechanics of Intelligent Materials in Hebei, Shijiazhuang Tiedao University, Shijiazhuang 050043, China_ 

> 4 _Universite de Lorraine, CNRS, Institut Jean Lamour, Nancy 54000, France_ 

> 5 _Institute of Engineering Mechanics, Beijing Jiaotong University, Beijing 100044, China_ 

*Corresponding author. _E-mail addresses_ : swfan@stdu.edu.cn & badreddine.assouar@univ-lorraine.fr & yswang@tju.edu.cn 

## **Abstract** 

Achieving effective sound insulation across a broadband range at low frequency while ensuring sufficient ventilation remains a significant challenge in the field of acoustic engineering, as there exist complex trade-offs in attenuation capacity, operating frequency, and opening size. Here, a double Archimedean spiral structure is proposed and then optimized using genetic algorithms. The sparse design, featuring ventilated channels on both sides of the unit, significantly expands the operational frequency range, effectively blocking over 80% of incident energy within the 546-1575 Hz range. Its working mechanism can be attributed to the Fano-like resonance effect, which is further revealed by employing a mechanical analogy based on the spring-mass model. Moreover, the addition of foams and a reconfigurable modular assembly enhances both broadband sound reduction and flexibility. Consistency between numerical simulations and experimental results validate the potential for this approach in applications of ventilated acoustic insulation, offering advantageous theoretical and 

1 

practical perspectives. 

**Keywords:** Acoustic Metamaterials, Optimization, Broadband, Reconfigurable, Ventilated Insulation 

## **1.Introduction** 

Noise in everyday life inflicts considerable harm upon humans, particularly compromising auditory and neurological health [1]. As such, the need for effective noise control has become increasingly urgent. Currently, available technologies encompass active noise cancellation (ANC) [2, 3] and passive noise reduction [4, 5]. ANC operates by emitting sound waves that are phase-inverted relative to external noise, exploiting the principle of destructive interference to effectively mitigate sound, thereby making substantial contributions to the advancement of noise reduction technologies. Nevertheless, ANC technology necessitates extensive computational resources, external power support, precise algorithms, and the ability to function under challenging environmental conditions, which pose significant technical hurdles [6, 7]. Moreover, the manufacturing costs associated with ANC components remain a formidable concern. In the future, innovations in chip integration and the development of cost-effective materials are expected to catalyze the widespread adoption and refinement of ANC technologies. 

Another approach, passive noise reduction, is typically achieved through traditional methods such as sound-absorbing material [8, 9], soundproof enclosures, double glazing [10, 11]. However, these materials face notable challenges, including high operational frequencies and the risk of mechanical overheating due to inadequate ventilation. Fortunately, the advent of metamaterials offers promising potential for addressing these issues. 

In the past decade, significant advancements in the metamaterial [12–14] 

2 

technology have been made in the fields of electromagnetics [15, 16] and acoustics [17– 20]. The primary characteristics of metamaterials stem from their unique geometric structures [21] rather than the physical properties of traditional materials, paving new paths for scientific research and practical applications. In acoustic applications [22, 23], metamaterials drive the development of acoustic lenses [24–26], acoustic stealth [27– 30], and holographic acoustic imaging [31] by precisely controlling effective density [32, 33] and bulk modulus [34–36], achieving accurate manipulation of sound waves [37–39], including single-negative and double-negative characteristics [40, 41], and furthering innovations in underwater acoustics technology [42, 43]. 

Meanwhile, substantial advancements have been made in the field of ventilated metamaterials [44, 45]. Utilizing openings within units and gaps between units, they can achieve ventilation and reduction at specific frequencies. To introduce the working principle, the total energy in the sound filed is partitioned into three components: transmitted energy ( _T_ ), reflected energy ( _R_ ), and absorbed energy ( _A_ ) [46]. Assuming − the total energy is unity, the relation _T_ =1− _A R_ holds. By maximizing either _A_ or _R_ , ventilated metamaterials can be classified into two distinct categories: ventilated acoustic absorption (VAA) or ventilated acoustic insulation (VAI). 

In the field of VAA, metamaterials resonate and generate the same impedance as air. Sound waves can enter the metamaterial, then friction occurs with microstructures, dissipating the sound energy. Gao et al. [47] harnessed the weak coupling effect to engineer a metamaterial that integrates an ultrathin ring cavity with a perforated inner shell structure, achieving broad-band impedance matching across the 380-470 Hz frequency range, under the condition of a 70% open area. Zhang et al. [48] introduced a quadruple resonance cavity within the annular region, employing a cascaded four-unit configuration. This design enabled efficient sound absorption across the 453-697 Hz 

3 

range under a 25% opening ratio. Furthermore, experiments are conducted under conditions of airflow, demonstrating that the number of layers has a minimal effect on the wind speed ratio. 

Given the inherent limitations of resonance mechanism, narrowband characteristics in such structures are often inevitable. Additionally, broadband soundabsorbing structures designed for air are typically large and structurally complex [49]. As a result, this field calls for further exploration and innovation. 

In the field of VAI, metamaterials resonate and create an impedance mismatch with air, causing sound waves to be reflected into the incident region. There are three main forms: cylindrical silencers [50, 51], plate barriers [52–54], and sparse array structures [55–58]. For cylindrical silencers and plate barriers, the design concept is fundamentally the same. An air channel is integrated within the unit, with microstructures surrounding the channel to induce local resonance, such as Helmholtz resonators [59], Fabry–Pérot resonators [60] or multiple resonance [61] to achieve the desired VAI effects. The narrow sound insulation bandwidth resulting from local resonance can be expanded by cascading multiple units [62]. Each unit is designed with unique parameters or topological configurations to target specific frequencies, thereby extending the noise reduction bandwidth. For plate barriers, different edges can also be designed to achieve seamless splicing, constructing a VAI barrier [63]. 

Unlike the previous two kinds, the ventilation design of sparse array metamaterials utilizes the space between adjacent units rather than openings inside the units. Therefore, the internal space of the units can be fully utilized to design various structural configurations, such as C-shaped capsules [64], L-shaped resonant cavities [65], and space-coiled structures [36]. Nguyen et al. [66] introduced a square coiled structure, inspired by the Fano-like resonance principle [67–70], engineered to deliver 

4 

exceptional sound insulation over a broad frequency range of 440–3850 Hz, utilizing a three-layer configuration with a porosity of 29.5%. Furthermore, Gao et al. [71], by employing the rainbow trapping mechanism, devised a cascading arrangement of 20 units, achieving effective sound insulation within the 880–1915 Hz range while maintaining a porosity of 70%. 

However, the VAI structures have significant limitations. Methodologically speaking, most of the traditional configurations inevitably suffer from the blindness of the empirical design, and difficult to effectively balance the two requirements of ventilation and sound insulation. Practically, some structures are only effective for specific frequencies, while noise in daily life is typically wideband. And these structures typically insulate only higher-frequency sound waves, but most noise tends to be low frequency. Additionally, the few existing low-frequency broadband structures are quite thick due to the stacking strategy, making them unsuitable for practical production and application. Therefore, significant challenges remain in VAI metamaterial design to simultaneously achieve low frequency, wide bandwidth, and minimal thickness. 

Moreover, research must also focus on how structural application scenarios specifically impact design. Multi-frequency noise in different application environments makes the performance requirements for acoustic insulation structures more complex. Most current designs are fixed configurations that, once constructed, are difficult to adjust or rebuild to accommodate different frequencies, limiting their adaptability and flexibility [72]. This fixed design problem is particularly evident in scenarios requiring precise acoustic control over varying noise environments, becoming a significant limitation. 

Wen et al. [73] utilized an origami-based structure to attain single-degree-offreedom modulation, thereby enabling precise control over cavity size and 

5 

consequently facilitating frequency tunability. Building upon this origami framework, Jin et al. designed various configurations and optimized the geometric parameters to enable adjustable functionality that strikes a balance between ventilation and noise reduction. Li [74] and Xiang [75] et al. achieved frequency tunability by translating external structures, thereby modifying multiple geometric parameters. Yu et al. [76] introduced a rotational structure, enabling reconfigurability through the adjustment of the embedded component angles. Although these operations enable reconfigurability that can be adjusted on demand, most structures rely on electrical and mechanical controls, leading to challenges such as increased energy consumption and the requirement for high-precision operation. Therefore, it is imperative to explore alternative solutions. 

In this paper, we introduce an Archimedean spiral structure, leveraging its diverse parameter combinations for optimization. By integrating genetic algorithms with COMSOL Multiphysics, we achieve effective energy blocking, surpassing 80% insulation of incident energy within the 546–1575 Hz range. Subsequently, the Fanolike resonance characteristic of the unit is analyzed through the spring oscillator model, while a modular design is developed via parametric scanning. Finally, sound-absorbing materials are incorporated in the experimental setup to further enhance the noise reduction capabilities of the structure. The experimental results demonstrate a strong correlation with the theoretical predictions. 

This paper is organized as follows. Section 2 presents the geometric equation of the Archimedean spiral, providing a comprehensive description of the finite element model setup, detailing the optimization process, and analyzing the results. In Section 3, the spring oscillator model is employed to analogize the structure, elucidating its Fanolike resonance characteristics and validating the accuracy of the analogy. Section 4 

6 

utilizes parametric scanning to explore various equation parameters, proposing a modular design. Finally, Section 5 offers a detailed overview of the experimental setup, where the test results are in close agreement with the predicted outcomes. 

## **2. Design, Simulation and Optimization** 

In this section, the geometric design of the Archimedes spiral is first introduced, followed by the setup of the numerical method. The optimal framework is then constructed using a genetic algorithm (GA). Finally, the optimal results are analyzed, and the origin of the insulating properties, which arise from the single negative characteristic, is explained. 

## _2.1 Archimedes spiral_ 

Implementing the Fano resonance mechanism [77] requires a binary medium composed of continuous air and a discrete resonant structure [54]. To minimize spatial dimensions, coiled architectures such as Archimedean spirals are preferred. However, a solitary spiral fails to form an effective resonant cavity. To establish a cavitary structure, a rotationally symmetric design is employed, which simultaneously connects the acoustic wave channel and accommodates the resonant cavity. Concurrently, sparse array configurations maintain continuous states. Consequently, a VAI barrier is engineered using Archimedean spirals. 

The schematic VAI barrier is shown in Fig. 1(a). For clarity, a small unit of the overall structure has been separated to provide detailed insights as shown in Fig. 1(b). The structure has the shape of an Archimedean spiral, with its polar equation given as 

**==> picture [259 x 13] intentionally omitted <==**

which is formed by the locus of a point moving away from the origin at constant speed while rotating at constant angular speed. _θ_ 0 is the starting angle of the spiral; _θ_ 1 is the ending angle of the spiral. All values are in radians. A centrosymmetric transformation 

7 

is performed in the structure, as shown in Fig. 1(c). The blue part is the structure, and the green part is the air. To more intuitively represent the ventilation effect, the ventilation rate ( _ψ_ ) satisfies 

**==> picture [248 x 12] intentionally omitted <==**

Considering the wide variation range and diverse combination possibilities of parameters in the Archimedean spiral equation, this study conducted an in-depth optimization analysis on it. In view of the limitations and needs in actual application scenarios, the structural parameters have been finely adjusted and constrained, aiming 

to optimize its acoustic performance, especially in terms of low-frequency and broadband acoustic insulation. 

**==> picture [416 x 298] intentionally omitted <==**

FIG. 1 (a) Schematic of sparse array structure with VAI. (b) A close-up view of one unit. (c) Geometric structure. _t=_ 2 mm, _a=_ 2 _ρ_ end, _b=_ ( _a_ +2 _t_ ) / (1- _ψ_ ), _ρ_ end= _α_ + _βθ_ 1. (d) The finite element model of the double Archimedean helix unit. 

_2.2 Finite element model_ 

8 

In the subsequent optimization process, using GA for fitness evaluation, precise numerical simulation plays a critical role in ensuring accurate results. All numerical simulations in this study are performed in COMSOL Multiphysics 5.6 using the pressure acoustics module. The specific simulation settings are shown in Fig. 1(d). 

Considering the periodicity of the structure, a unit, defined by the input parameters, is positioned within a rectangular waveguide. Given the significant impedance contrast between the solid and air, all boundaries of the solid structures are treated as hard boundaries. The left section represents the sound incident region (In.), serving as a simulation of the incoming wave. The right section corresponds to the transmission region (Tr.), employed to compute the sound energy transmission coefficient ( _T_ ). The two terminals are enveloped by a perfectly matched layer (PML) to emulate an anechoic field. The Archimedes spiral is rendered utilizing a "parametric curve" representation. The study domain is constructed through set difference operations. The upper and lower boundaries of the waveguide are subjected to periodic boundary conditions. The incident region is configured with a background pressure field characterized by a plane wave of unit amplitude. The detection point of the transmitted data may, in principle, be arbitrarily selected, provided that the plane waveform within the waveguide is preserved. Nonetheless, to mitigate the influence of boundary effects, it is advisable to position the observation point at a sufficient distance from the unit surface within the transmission domain. In our simulations, a separation of 1000 mm (≈ _λ_ max) proves to be adequate. The speed of sound in air is set to 343 m/s and air density 1.21 kg/m[3] . To ensure precise resolution of the wavelength within the computational mesh, the maximum mesh size is constrained to one-tenth of the shortest wavelength under consideration. 

The supplementary materials provide further analysis of the safety assessment 

9 

under different operating conditions, an exploration of the impact of structural deformation on sound insulation performance, and a study of the acoustic-structure coupling effects. 

To reduce time cost in the optimization, the thermal-viscosity effect on the acoustic reduction performance of the structure is neglected after verification through numerical simulation, see supplementary material for details. 

## _2.3 Optimization based on GA_ 

Genetic algorithm [78], as a non-gradient search algorithm, significantly relies on the definition of the fitness function in the process of finding the optimal solution. As mentioned earlier, the focus is mainly on _T_ . However, only considering _T_ as the optimization goal is not comprehensive. Especially when _ψ_ drops to zero, see supplementary material for details, although the sparse array achieves excellent sound insulation effect, it is equivalent to a wall blocking sound waves and violates the original intention of VAI design. Therefore, when _T_ reaches zero and ventilation requirements are not satisfied, the design cannot be deemed successful. To achieve optimal ventilation performance, the ventilation rate emerges as a critical parameter that must be optimized in conjunction with geometric considerations for comprehensive evaluation. In the process of GA optimization, the goal is to find the individual with the smallest fitness value. This fitness function considers two key factors: _T_ and _ψ_ . 

In the optimization process, a frequency domain ( _F_ : [ _f_ down, _f_ up]) and the primary optimization frequency domain ( _F_ o: [ _f_ odown, _f_ oup]) are defined. Under the range _F_ o, the transmission coefficient for the _i_ -th frequency is denoted as _T_ o _i_ . For frequencies within _F_ but outside _F_ o, the corresponding transmission coefficient is denoted as _Ti_ . The penalty factor, _bandr_ , is used to ensure the acoustic isolation efficiency. Then, the optimization is formulated as 

10 

**==> picture [208 x 35] intentionally omitted <==**

**==> picture [370 x 121] intentionally omitted <==**

=%[\3B .AA "- 

α = /(M(D1Mβ = /(SFCMD1MθD = /DMπ1Mθ( = /(SDπMCπ1Mψ = /DS(MDS*1M where _nr_ is the total number of sampling frequencies. When all _T_ o _i_ are less than or equal to 0.2, _bandr_ is set to 1; otherwise, it is set to 10. The upper and lower bounds for the constrained intervals of _ψ_ are represented by _ψ_ up and _ψ_ down, respectively. The weighting factors _q_ 1, _q_ 2 and _q_ 3 are used to balance the contribution of each component in the fitness function, subject to the condition that their sum equals 1. In this optimization, the values are assigned as _q_ 1=0.8 and _q_ 2= _q_ 3=0.1. 

Through several rounds of optimization iteration, the hyperparameters of GA are carefully adjusted to improve the efficiency and accuracy of the design process. The frequency domain ( _F_ : [ _f_ down, _f_ up]) is defined as the range of [400, 1500], while the primary optimization frequency domain ( _F_ o: [ _f_ odown, _f_ oup]) is set to [600, 1100]. The population size is set to 30; the mutation rate is adjusted to 0.3; the crossover rate is set to 0.7; and the upper limit of the number of iterations is 1000 generations. These parameters are designed to ensure that the algorithm can effectively approach the global optimal solution within a reasonable time. Through this method, not only is _T_ paid attention to, but the ventilation performance is also included in the optimization, with the goal of achieving higher design standards and different design requirements. 

After completing the above foundation, the optimization process of the GA can be 

11 

quickly launched through sufficient algebraic iteration. Finally, the optimized parameters are 

**==> picture [322 x 14] intentionally omitted <==**

For the optimization efficiency, it is worth pointing out that the optimization employs parallel computations by invoking 30 cores on a Linux cluster equipped with Intel Xeon Platinum 8270 @ 2.70 GHz. Each generation necessitates approximately 50 seconds of processing, and the complete optimization process spans approximately 7 hours, contingent upon the efficiency of the parallel computation. 

_2.5 Results_ 

The transmission of the optimized structure is shown in Fig. 2(a). Numerical simulations show that the structure achieves an excellent sound insulation at 546-1575 Hz blocking 80% of noise at a specific ventilation rate. It is worth noting that the characteristics of the curve show significant similarity with the Fano-like resonance effect curve [50, 79]. The Archimedean double helix structure functions as a discrete state in Fano-like resonance. When the structure is designed and arrayed, the air in the gap between structures remains unimpeded, aligning with the continuous state. 

After completing the structural optimization, to deeply analyze the sound pressure distribution characteristics inside the structure, two points A and B are specially selected to draw the sound pressure in Fig. 2(b). According to the effective medium theory [80], when the structural scale is at the sub-wavelength level, the structure can be approximately regarded as a special medium, and its density ( _ρ_ eff) and bulk modulus ( _к_ eff) both exhibit dispersion. Using the four-point transmission method [81], these parameters can be accurately calculated in Fig. 2(c). It is observed in detail that in the low transmission frequency band, the structure exhibits two bands with single negative properties. Combined with the sound pressure distributions it can be seen that when the 

12 

first-order resonance occurs, the internal sound pressure presents a nearly uniform monopole distribution, and the structure exhibits a negative effective bulk modulus; while when the second-order resonance occurs, the internal sound pressure distribution shows the opposite trend, that is, a dipole distribution, where the structure exhibits a negative density [36]. 

**==> picture [416 x 348] intentionally omitted <==**

FIG. 2. (a) The transmission spectrum of the structure is depicted, with dips A and B marked. (b) Sound pressure diagram at two points A and B. (c) The effective parameters of the structure. The green area represents the single-negative characteristic. 

## **3. Mechanical analog of Fano-like resonance** 

This section provides a further explanation of the Fano-like resonance in the transmission spectrum. First, a spring oscillator model is used to establish an analogy 

to Fano-like resonance. Then, by leveraging the scalar characteristic of sound pressure, the optimization results can be correlated with the spring oscillator model. Finally, the 

13 

validity of the correlation is confirmed by introducing the protruding and indented structure. 

Three spring oscillator models are designed, namely System I, System II, and System III [79]. The schematic is shown in Fig. 3(a)-(c). The Helmholtz resonator, as a classic example, can be seen as a spring oscillator system with a single mass subjected to a unilateral force. When Helmholtz resonators are connected in series, they can be viewed as multiple masses linked by springs. For simplicity, this discussion focuses on single-mass and dual-mass systems. System I consists of an oscillator with a eigenfrequency _ω_ 0, subjected to a harmonic force of amplitude _A_ . It can be regarded as a Helmholtz cavity. System II consists of two coupled oscillators with eigenfrequencies _ω_ 1 and _ω_ 2, where the first oscillator is subjected to a harmonic force of amplitude _A_ The system can be viewed as a configuration of two Helmholtz cavities connected in series. 

The displacement amplitudes of the oscillator in System I and the first oscillator in System II are calculated and shown in Fig. 3(e). The green line exhibits a Lorentzian profile, with only one maximum point due to the presence of a single oscillator in System I. Because of the presence of two oscillators in System II, two maxima are observed. The red line shows an antisymmetric trend near the second peak, where it first reaches a minimum displacement amplitude and then achieves the maximum value. This is a typical phenomenon of Fano-like resonance in mechanical systems. Detailed calculation steps can be found in the supplementary materials. 

A careful analysis of the proposed Archimedean double helix structure suggests that it can be approximated as a dual-mass system coupled by springs. When sound pressure is treated as a scalar, placing the structure in a sound pressure field causes its opposing openings to experience opposite forces. Therefore, it can be approximated as 

14 

a spring oscillator model where two oscillators are subjected to counterpart forces, leading to the construction of System III. The correlation between them is shown in Fig. 3(c) and (d), where the same color represents similar parts in both models. To ensure equal energy input with System II, instead of applying the force to just one mass, it is split into two equal but opposite forces with the amplitude _A_ /2 and applied to both oscillators in System III. 

Hence, System III encompasses two fundamental systems with eigenfrequencies _ω_ 1 and _ω_ 2. Each oscillator is situated within two different media characterized by damping _γ_ 1 and _γ_ 2; the coupling coefficient between oscillators is _ν_ 12. Two equal and opposite forces, _!_ ! = _"_ #$%(ω _#_ ) & and _!_ ! = − _"_ #$%(ω _#_ ) !" are applied to the two oscillators simultaneously to ensure the input energy is the same. Then the equation of motion of the system can be expressed as follows: 

**==> picture [307 x 41] intentionally omitted <==**

> where _!_ ! = _"_ !["#$%] _#_ ω _$_ & and _!_ ! = _"_ !["#$%] _#_ ω _$_ & represent the steady-state displacement of oscillator 1 and 2, respectively. To simplify the problem and compare it with other situations, let _γ_ 2=0, _A_ =1. The simplified formula is 

**==> picture [291 x 41] intentionally omitted <==**

The displacement amplitude of each oscillator can be solved as 

**==> picture [307 x 77] intentionally omitted <==**

The detailed calculation steps are provided in the supplementary material. 

15 

Focus only on the real part of the complex numbers _c_ 1 and _c_ 2. All quantities are normalized, assuming _γ_ 1=0.025s[-1] , _ω_ 2 =1.6 _ω_ 1 and _ν_ 12=0.3rad[2] /s[2] . With an external excitation ranging from _ω_ =0.1 _ω_ 1~2 _ω_ 1, the displacement amplitude curves for the two oscillators can be calculated. The displacement amplitude of oscillator 1 is plotted in Fig. 3(e). By comparing System II, significant changes in System III can be observed: 

(1). The lower-order resonance frequency shifts to a lower frequency, while the higher-order resonance frequency shifts to a higher frequency. 

(2). The magnitudes of the two extrema change significantly, with the lowfrequency resonance becoming more pronounced. 

(3). At the second resonance frequency, the antisymmetric trend reverses. In System II, the trend shows a minimum displacement amplitude followed by a maximum, while in System III, the amplitude response reaches a maximum displacement before achieving the minimum one. This leads to an increase in the displacement amplitude near the second-order resonance frequency. 

To provide a clearer representation, Transmission Loss ( _TL_ ) and Transmission coefficient ( _T_ ) is defined as 

**==> picture [260 x 34] intentionally omitted <==**

where _pi_ is the incident pressure; _pt_ is the transmitted sound pressure. _TL_ is plotted in Fig. 3(f). At the second-order resonance, it is observed that _TL_ initially reaches its maximum before shifting to its minimum. This pattern aligns with the second-order resonance behavior observed in System III. 

16 

**==> picture [416 x 383] intentionally omitted <==**

FIG. 3. Spring oscillator systems: (a) System I (an oscillator with a eigenfrequency _ω_ 0, subjected to a harmonic force of amplitude _A_ ), (b) System II (two coupled oscillators with eigenfrequencies _ω_ 1 and _ω_ 2, where the first oscillator is subjected to a harmonic force of amplitude _A_ ) (c) System III (two coupled oscillators with eigenfrequencies _ω_ ₁ and _ω_ ₂, where the first is acted on by a force of amplitude _A_ /2, and the second by an equal but opposite force). (d) Archimedes spiral structure. (e) The displacement amplitudes of oscillator 1 in system I, II, III. (f). The _TL_ of Archimedes spiral structure. 

To further explore the correlation between the System III framework and the 

Archimedes spiral structure, two novel configurations, namely protruding and indented structures, have been devised, as illustrated in Figs. 4(a) and 4(b). Subsequently, the simulations of _TL_ are recomputed in Fig. 4(c). The protruding surfaces increase the mass of the oscillator, thereby lowering the system eigenfrequency. In contrast, the indented surfaces reduce the mass of the oscillator, leading to an increase in the system 

17 

eigenfrequency. By examining the second resonant frequency in the transmission spectrum, it becomes evident that the resonant frequencies of the protruding and indented structures are positioned on opposite sides of the resonance in the initial 

structure. 

**==> picture [416 x 251] intentionally omitted <==**

FIG. 4. Schematic of structures features: protruding (a) and indented (b) structure; (c) Comparison of _TL_ for different units. The initial structure serves as a benchmark. 

## **4. Parametric analysis and reconfigurable design** 

In this section, the parameters of the Archimedean spiral equation are explored, and a reconfigurable structure is designed to address the limitations of sparse array metamaterial in achieving tunability. 

For each parameter ( _ψ_ is analyzed in the supplementary material), three specific values are chosen, and the corresponding results are presented in Fig. 5(a)-(c). When the starting radius ( _θ_ 0 =0) _α_ increases, the volume of the resonant cavity becomes larger, facilitating low-frequency sound insulation. Similarly, the radius growth rate _β_ , when increased, enlarges the volume of the side branch resonant cavity, causing the first transmission dip to shift to a lower frequency. Changes in these two parameters achieve 

18 

a shift in the sound insulation band, but they alter the overall size of the structure. An increase in the value of _θ_ 1 also leads to a larger cavity volume, thus shifting the first transmission point to a lower frequency. However, this also results in a deterioration of the sound insulation effect, and the effective range of variation for _θ_ 1 is small. It can be observed that changes in _α_ , _β_ and _θ_ 1 present significant limitations in practical applications. Fig. 5(d) shows that when _θ_ 0 varies within its effective range there are significant changes in the sound insulation band. Although the sound insulation performance slightly deteriorates at higher frequencies, the sound insulation coefficient of the structure still meets the previous constraints ( _T_ <0.2) within a certain frequency range. Therefore, it holds the potential to function as an adjustable parameter, facilitating reconfigurable capabilities. In particular, the adjustment of parameter _θ_ 0 can achieve the shift of the sound insulation frequency range without altering the overall size of the units. To deeply explore the impact of changes in _θ_ 0 on the insulation band, a cloud diagram of _T_ is plotted in Fig. 5(e). The observation results show that when _θ_ 0 increases, the sound insulation frequency in the blue area tends to be high and large in a certain range. This finding provides an important design basis for achieving frequency adjustment. In the supplementary materials, a line graph representing the sound insulation performance characterized by _T_ is drawn. 

19 

**==> picture [416 x 499] intentionally omitted <==**

FIG. 5. _TL_ spectrum as a function of parameters: (a) _α=_ 0, 4, 8. (b) _β=_ 2, 5, 8. (c) _θ_ 1=8, 8.5, 9.5. (d) _θ_ 0=1.7, 4.5, 5.1. (e) Contour map of _T_ across varying parameter _θ_ 0 and corresponding frequencies. (f) Modular design diagram. 

To realize the reconfigurable function, a modular splicing structure is designed. 

This design accomplishes the shifting of sound insulation bands by seamlessly integrating various modules. As shown in Fig. 5(f), the structure is divided into several modules. The long strip-shaped part represents the Archimedean spiral structure. The 

20 

square part serves as the base to fix the entire frame. By simply inserting the outer frame into the base, a double Archimedean spiral structure at specific frequencies can be quickly constructed as needed. 

## **5. Experimental Verification** 

In this section, experiments are conducted on multiple units using specialized acoustic equipment, and sound-absorbing foam is incorporated to mitigate the transmission of high-frequency sound waves. 

A three-unit sample is printed by 3D printing technology. Later, sound-absorbing materials (melamine) are added inside the structure to improve its acoustic performance. The schematic is shown in Fig. 6(a). The sample is sandwiched between 10 cm-thick acrylic plates and enclosed by 5 cm of sound-absorbing material to simulate an anechoic and free-field environment. Acoustic wave excitation is performed using three loudspeakers (COSTE, 4Ω), while measurements are recorded through a data acquisition system (3160-A-042, Brüel & Kjær). The experimental setup is depicted in Fig. 6(b). 

It is important to note that the experiment had limitations, see supplementary material for details. These limitations caused the sound waves in the waveguide to not be completely planar and the transmission amplitude to be uneven [82]. Therefore, when analyzing the insulation performance, it is necessary to normalize the sound pressure in the waveguide. When the structure is present in the waveguide, the sound pressure _I_ 1 in the transmission region is measured. After removing the structure, _I_ 2 measured in the same location. The normalized transmission coefficient is given by _I_ 1/ _I_ 2. However, this operation cannot fully eliminate its influence, so the measured results will be greater than 1. The comparison between the simulation and the experiment is shown in Fig. 6(c), with a good match between the results. It can be observed that the introduction of acoustic foam has improved the noise reduction effect for highfrequency sound waves. 

21 

Subsequently, experiments are conducted on the reconstructed structure with _θ_ 0=1.7, 4.5, 5.1. A comparison between the numerical simulation and the experimental results is shown in Fig. 6(d)-(f). It can be observed that the simulation results closely match the experimental data, confirming the effectiveness of units in practical applications. To verify that three samples can adequately reflect a good balance between sound insulation and ventilation of our optimized structure, we refer to the supplementary material for repeating the measurement by using six units. The result shows that their transmission trends remain consistent in the operating frequency range. 

**==> picture [417 x 307] intentionally omitted <==**

FIG. 6. (a) Experimental sample display and schematic of the acoustic foam. (b) Schematic of experimental set. (c) Comparison of simulation and experiment of lossless unit and lossy unit. (f)-(h) Comparison of simulation and experiment of lossless units at _θ_ 0 = 1.7, 4.5, 5.1. 

Finally, the wider context is also explored. The above analysis is based on double 

Archimedean spirals as a centrally symmetric structure. Furthermore, two specific structures are discussed. The first one increases the structural difference between the 

22 

two helices while keeping the starting and ending angles consistent. The second one tries to make the overall structure more uniform, see the supplementary material for more details. The results show that when there is a large difference between the two helical structures, the first 2nd-order resonance frequencies will change significantly. 

## **6. Conclusions** 

This paper designs a double Archimedean spiral structure based on Fano-like resonance and optimizes it through GA. Validated through experimental measurements, the structure achieves remarkable sound insulation, effectively blocking around 80% of incident acoustic energy across the frequency range of 546 to 1575 Hz, demonstrating its excellent soundproofing performance. 

A spring oscillator model analogous to second-order resonance is adopted to explain this phenomenon. The properties of the sound pressure scalar field induce two opposing forces on the structure, reversing the resonance trend and thereby achieving broadband sound insulation. 

Subsequently, the study investigates the impact of parameter variations on sound insulation performance, designs a modular splicing structure, validates the design through experiments, and explores the effect of sound-absorbing materials on noise reduction. The consistency between experimental and simulation results strongly supports the research on optimized and reconfigurable VAI metamaterials. 

The structure has no redundant parts and possesses multiple advantages such as lightweight, broadband, and tunable features. 

23 

## **Acknowledgments** 

This work is supported by the National Natural Science Foundation of China (Nos. 12102276,11991031,12021002), the Natural Science Foundation of Hebei Province (No. A2022210016), and the Science and Technology Project of Hebei Education Department (No. BJK2024131). 

24 

## **References** 

- [1] Basner, M.; Babisch, W.; Davis, A.; Brink, M.; Clark, C.; Janssen, S.; Stansfeld, S. Auditory and Non-Auditory Effects of Noise on Health. _Lancet_ , **2014** , _383_ (9925), 1325–1332. 

- [2] Zhuo, Y.; Chen, X.; Liu, Z.; Sheng, Z.; Wu, H. Nonreciprocal Intelligent Soundproof Barrier with Active Nonlocal Acoustic Metastructure. _Adv. Mater. Technol._ , **2024** , 2301693. 

- [3] Cai, L.; Mo, Y.; Yang, S.; Lu, Y.; Qian, X.; Lv, C.; Zhang, D.; You, C. Material Design and Performance Study of a Porous Sound-Absorbing Sound Barrier. _Buildings_ , **2024** , _14_ (10), 3118. 

- [4] Kang, J.; Brocklesby, M. W. Feasibility of Applying Micro-Perforated Absorbers in Acoustic Window Systems. _Appl. Acoust._ , **2005** , _66_ (6), 669–689. 

- [5] Tang, S. K. Reduction of Sound Transmission across Plenum Windows by Incorporating an Array of Rigid Cylinders. _J. Sound Vibr._ , **2018** , _415_ , 25–40. 

- [6] Wang, T.; Liang, X.; Yan, L.; Bai, Y.; Tang, J. Research on Follow-up Active Noise Control with Phased-Array Secondary Sound Source. _J. Vib. Control_ , **2024** , _30_ (1–2), 181–192. 

- [7] Liao, W.; Hao, J.; Luo, X. A Sound Insulation Cooling Fin for Broadband Noise Control and Ventilation. _J. Phys. D: Appl. Phys._ , **2025** , _58_ (8), 085502. 

- [8] Kumar, S.; Lee, H. P. Recent Advances in Acoustic Metamaterials for Simultaneous Sound Attenuation and Air Ventilation Performances. _Crystals_ , **2020** , _10_ (8), 686. 

- [9] Zuccherini Martello, N.; Fausti, P.; Santoni, A.; Secchi, S. The Use of Sound Absorbing Shading Systems for the Attenuation of Noise on Building Façades. An Experimental Investigation. _Buildings_ , **2015** , _5_ (4), 1346–1360. 

- [10] Tang, S. K. A Review on Natural Ventilation-Enabling Façade Noise Control Devices for Congested High-Rise Cities. _Appl. Sci_ , **2017** , _7_ (2), 175. 

- [11] Bajraktari, E.; Lechleitner, J.; Mahdavi, A. The Sound Insulation of Double Facades with Openings for Natural Ventilation. _Build. Acoustics_ , **2015** , _22_ (3–4), 163–176. 

- [12] Muhammad; Kennedy, J.; Lim, C. W. Machine Learning and Deep Learning in Phononic Crystals and Metamaterials – A Review. _Mater. Today Commun._ , **2022** , _33_ , 104606. 

- [13] Wu, G.; Ke, Y.; Zhang, L.; Tao, M. Acoustic Metamaterials with Zero-Index Behaviors and Sound Attenuation. _J. Phys. D: Appl. Phys._ , **2022** , _55_ (28), 285301. 

- [14] Lei, Y.; Hui Wu, J.; Wang, L.; Huang, Y.; Niu, J. Deep Sub-Wavelength Acoustic Transmission Enhancement and Whisper via the Monopole Resonance in Meta-Cavities. _Appl. Acoust._ **2023** , _203_ , 109227. 

- [15] Cui, T. J.; Qi, M. Q.; Wan, X.; Zhao, J.; Cheng, Q. Coding Metamaterials, Digital Metamaterials and Programmable Metamaterials. _Light: Sci. Appl._ , **2014** , _3_ (10), e218. 

- [16] Wu, X.; Yan, H.; Zhou, Y.; Zhang, P.; Lu, Q.; Shi, H. Review of Additive Manufactured Metallic Metamaterials: Design, Fabrication, Property and Application. _Optics & Laser Technology_ , **2025** , _182_ , 112066. 

- [17] Arjunan, A.; Baroutaji, A.; Robinson, J.; Vance, A.; Arafat, A. Acoustic Metamaterials for 

25 

Sound Absorption and Insulation in Buildings. _Build. Environ._ , **2024** , _251_ , 111250. 

- [18] Assouar, B.; Liang, B.; Wu, Y.; Li, Y.; Cheng, J. C.; Jing, Y. Acoustic Metasurfaces. _Nat. Rev. Mater._ , **2018** , _3_ (12), 460–472. 

- [19] Babaee, S.; Overvelde, J. T. B.; Chen, E. R.; Tournat, V.; Bertoldi, K. Reconfigurable OrigamiInspired Acoustic Waveguides. _Sci. Adv._ , **2016** , _2_ (11), e1601019. 

- [20] Asdrubali, F.; Buratti, C. Sound Intensity Investigation of the Acoustics Performances of High Insulation Ventilating Windows Integrated with Rolling Shutter Boxes. _Appl. Acoust._ , **2005** , _66_ (9), 1088–1101. 

- [21] Li, Y.; Liang, B.; Zou, X.; Cheng, J. Extraordinary Acoustic Transmission through Ultrathin Acoustic Metamaterials by Coiling up Space. _Appl. Phys. Lett_ , **2013** , _103_ (6), 063509. 

- [22] Li, Q.; Dong, R.; Mao, D.; Wang, X.; Li, Y. A Compact Broadband Absorber Based on Helical Metasurfaces. _Int. J. Mech. Sci._ , **2023** , _254_ , 108425. 

- [23] Krasikova, M.; Krasikov, S.; Melnikov, A.; Baloshin, Y.; Marburg, S.; Powell, D. A.; Bogdanov, A. Metahouse: Noise‐Insulating Chamber Based on Periodic Structures. _Adv. Mater. Technol._ , **2023** , _8_ (1), 2200711. 

- [24] Zhou, C.; Wang, Q.; Pu, S.; Li, Y.; Guo, G.; Chu, H.; Ma, Q.; Tu, J.; Zhang, D. Focused Acoustic Vortex Generated by a Circular Array of Planar Sector Transducers Using an Acoustic Lens, and Its Application in Object Manipulation. _J. Appl. Phys._ , **2020** , _128_ (8), 084901. 

- [25] Huang, S.; Peng, L.; Sun, H.; Wang, Q.; Zhao, W.; Wang, S. Frequency Response of an Underwater Acoustic Focusing Composite Lens. _Appl. Acoust._ , **2021** , _173_ , 107692. 

- [26] Cominelli, S.; Braghin, F. Optimal Design of Broadband, Low-Directivity Graded Index Acoustic Lenses for Underwater Communication. _The Journal of the Acoustical Society of America_ , **2024** , _156_ (3), 1952–1963. 

- [27] Yu, G.; Qiu, Y.; Li, Y.; Wang, X.; Wang, N. Underwater Acoustic Stealth by a Broadband 2- Bit Coding Metasurface. _Phys. Rev. Applied_ , **2021** , _15_ (6), 064064. 

- [28] Zhao, S. D.; Dong, H. W.; Miao, X. B.; Wang, Y.-S.; Zhang, C. Broadband Coding Metasurfaces with 2-Bit Manipulations. _Phys. Rev. Appl._ , **2022** , _17_ (3), 034019. 

- [29] Fan, S. W.; Zhao, S. D.; Cao, L. Y.; Zhu, Y. F.; Chen, A. L.; Wang, Y. F.; Donda, K.; Wang, Y. S.; Assouar, B. Reconfigurable Curved Metasurface for Acoustic Cloaking and Illusion. _Phys. Rev. B_ , **2020** , _101_ (2), 024104. 

- [30] Romero-García, V.; Lamothe, N.; Theocharis, G.; Richoux, O.; García-Raffi, L. M. Stealth Acoustic Materials. _Phys. Rev. Appl._ , **2019** , _11_ (5), 054076. 

- [31] Fan, S. W.; Zhu, Y. fan; Cao, L. un; Wang, Y. F.; Li Chen, A. L.; Merkel, A.; Wang, Y. S.; Assouar, B. Broadband Tunable Lossy Metasurface with Independent Amplitude and Phase Modulations for Acoustic Holography. _Smart Mater. Struct._ , **2020** , _29_ (10), 105038. 

- [32] Kim, M.; Lee, K.; Bok, E.; Hong, D.; Seo, J.; Lee, S. H. Broadband Muffler by Merging Negative Density and Negative Compressibility. _Appl. Acoust._ , **2023** , _208_ , 109373. 

26 

- [33] Graciá-Salgado, R.; García-Chocano, V. M.; Torrent, D.; Sánchez-Dehesa, J. Negative Mass Density and ρ-near-Zero Quasi-Two-Dimensional Metamaterials: Design and Applications. _Phys. Rev. B_ , **2013** , _88_ (22), 224305. 

- [34] García-Chocano, V. M.; Graciá-Salgado, R.; Torrent, D.; Cervera, F.; Sánchez-Dehesa, J. Quasi-Two-Dimensional Acoustic Metamaterial with Negative Bulk Modulus. _Phys. Rev. B_ , **2012** , _85_ (18), 184102. 

- [35] Fang, N.; Xi, D.; Xu, J.; Ambati, M.; Srituravanich, W.; Sun, C.; Zhang, X. Ultrasonic Metamaterials with Negative Modulus. _Nat. Mater._ , **2006** , _5_ (6), 452–456. 

- [36] Cheng, Y.; Zhou, C.; Yuan, B. G.; Wu, D. J.; Wei, Q.; Liu, X. J. Ultra-Sparse Metasurface for High Reflection of Low-Frequency Sound Based on Artificial Mie Resonances. _Nat. Mater._ , **2015** , _14_ (10), 1013–1019. 

- [37] Jiang, M.; Wang, Y. F.; Assouar, B.; Wang, Y. S. Scattering-Free Modulation of Elastic ShearHorizontal Waves Based on Interface-Impedance Theory. _Phys. Rev. Appl._ , **2023** , _20_ (5), 054020. 

- [38] Zhu, Y. F.; Zou, X. Y.; Li, R. Q.; Jiang, X.; Tu, J.; Liang, B.; Cheng, J.-C. Dispersionless Manipulation of Reflected Acoustic Wavefront by Subwavelength Corrugated Surface. _Sci. Rep._ , **2015** , _5_ (1), 10966. 

- [39] Zhou, H. T.; Fan, S. W.; Li, X. S.; Fu, W. X.; Wang, Y. F.; Wang, Y. S. Tunable Arc-Shaped Acoustic Metasurface Carpet Cloak. _Smart Mater. Struct._ , **2020** , _29_ (6), 065016. 

- [40] Maurya, S. K.; Pandey, A.; Shukla, S.; Saxena, S. Double Negativity in 3D Space Coiling Metamaterials. _Sci. Rep._ , **2016** , _6_ (1), 33683. 

- [41] Li, J.; Chan, C. T. Double-Negative Acoustic Metamaterial. _Phys. Rev. E_ , **2004** , _70_ (5), 055602. 

- [42] Zhou, H. T.; Fu, W. X.; Li, X. S.; Wang, Y. F.; Wang, Y. S. Loosely Coupled Reflective Impedance Metasurfaces: Precise Manipulation of Waterborne Sound by Topology Optimization. _Mech. Syst. Signal Proc._ , **2022** , _177_ , 109228. 

- [43] Zhang, H. jia; Liu, J.; Ma, W. T.; Yang, H. T.; Wang, Y.; Yang, H. B.; Zhao, H. G.; Yu, D. L.; Wen, J. H. Learning to Inversely Design Acoustic Metamaterials for Enhanced Performance. _Acta Mech. Sin._ , **2023** , _39_ (7), 722426. 

- [44] Zhang, X.; Qu, Z.; Wang, H. Engineering Acoustic Metamaterials for Sound Absorption: From Uniform to Gradient Structures. _iScience_ , **2020** , _23_ (5), 101110. 

- [45] Xu, Z.; Qiu, W.; Cheng, Z.; Yang, J.; Liang, B.; Cheng, J. Broadband Ventilated Sound Insulation Based on Acoustic Consecutive Multiple Fano Resonances. _Phys. Rev. Appl._ , **2024** , _21_ (4), 044049. 

- [46] Dong, R.; Sun, M.; Mo, F.; Mao, D.; Wang, X.; Li, Y. Recent Advances in Acoustic Ventilation Barriers. _J. Phys. D: Appl. Phys._ , **2021** , _54_ (40), 403002. 

- [47] Gao, Y. X.; Cheng, Y.; Liang, B.; Li, Y.; Yang, J.; Cheng, J. C. Acoustic Skin Meta-Muffler. _Sci. China Phys. Mech. Astron._ , **2021** , _64_ (9), 294311. 

- [48] Zhang, Y.; Wu, C.; Li, N.; Liu, T.; Wang, L.; Huang, Y. Ventilated Low-Frequency Sound 

27 

Absorber Based on Helmholtz Acoustic Metamaterial. _Phys. Lett. A_ , **2024** , _523_ , 129779. 

- [49] Nguyen, H.; Wu, Q.; Xu, X.; Chen, H.; Tracy, S.; Huang, G. Broadband Acoustic Silencer with Ventilation Based on Slit-Type Helmholtz Resonators. _Appl. Phys. Lett._ , **2020** , _117_ (13), 134103. 

- [50] Chen, A.; Zhao, X.; Yang, Z.; Anderson, S.; Zhang, X. Broadband Labyrinthine Acoustic Insulator. _Phys. Rev. Appl._ , **2022** , _18_ (6), 064057. 

- [51] Sun, M.; Fang, X.; Mao, D.; Wang, X.; Li, Y. Broadband Acoustic Ventilation Barriers. _Phys. Rev. Appl._ , **2020** , _13_ (4), 044028. 

- [52] Ma, P. S.; Seo, Y. H.; Lee, H. J. Multiband Ventilation Barriers Enabled by Space-Coiling Acoustic Metamaterials. _Appl. Acoust._ , **2023** , _211_ , 109565. 

- [53] Yu, X. Design and In-Situ Measurement of the Acoustic Performance of a Metasurface Ventilation Window. _Appl. Acoust._ , **2019** , _152_ , 127–132. 

- [54] Liu, C.; Shi, J.; Zhao, W.; Zhou, X.; Ma, C.; Peng, R.; Wang, M.; Hang, Z. H.; Liu, X.; Christensen, J.; et al. Three-Dimensional Soundproof Acoustic Metacage. _Phys. Rev. Lett._ **2021** , _127_ (8), 084301. 

- [55] Sun, Y.; Xia, J.; Sun, H.; Yuan, S.; Ge, Y.; Liu, X. Dual‐Band Fano Resonance of Low‐ Frequency Sound Based on Artificial Mie Resonances. _Adv. Sci._ , **2019** , _6_ (20), 1901307. 

- [56] Guan, Y.; Ge, Y.; Sun, H.; Yuan, S.; Liu, X. Low-Frequency, Open, Sound-Insulation Barrier by Two Oppositely Oriented Helmholtz Resonators. _Micromachines_ , **2021** , _12_ (12), 1544. 

- [57] Wang, G.; Hu, J.; Xiang, L.; Shi, M.; Luo, G. Topology-Optimized Ventilation Barrier for Mid-to-High Frequency Ultrabroadband Sound Insulation. _Appl. Acoust._ , **2023** , _202_ , 109145. 

- [58] Chen, Z.; Chong, Y. B.; Lim, K. M.; Lee, H. P. Reconfigurable 3D Printed Acoustic Metamaterial Chamber for Sound Insulation. _Int. J. Mech. Sci._ , **2024** , _266_ , 108978. 

- [59] Dong, R.; Mao, D.; Wang, X.; Li, Y. Ultrabroadband Acoustic Ventilation Barriers via HybridFunctional Metasurfaces. _Phys. Rev. Appl._ , **2021** , _15_ (2), 024044. 

- [60] Liu, C.; Wang, H.; Liang, B.; Cheng, J.; Lai, Y. Low-Frequency and Broadband Muffler via Cascaded Labyrinthine Metasurfaces. _Appl. Phys. Lett._ , **2022** , _120_ (23), 231702. 

- [61] Chen, A.; Yang, Z.; Zhao, X.; Anderson, S.; Zhang, X. Composite Acoustic Metamaterial for Broadband Low-Frequency Acoustic Attenuation. _Phys. Rev. Appl._ , **2023** , _20_ (1), 014011. 

- [62] Xiao, Z.; Gao, P.; He, X.; Qu, Y.; Wu, L. Multifunctional Acoustic Metamaterial for Air Ventilation, Broadband Sound Insulation and Switchable Transmission. _J. Phys. D: Appl. Phys._ , **2023** , _56_ (4). 

- [63] Kumar, S.; Xiang, T. B.; Lee, H. P. Ventilated Acoustic Metamaterial Window Panels for Simultaneous Noise Shielding and Air Circulation. _Appl. Acoust._ , **2020** , _159_ , 107088. 

- [64] Melnikov, A.; Maeder, M.; Friedrich, N.; Pozhanka, Y.; Wollmann, A.; Scheffler, M.; Oberst, S.; Powell, D.; Marburg, S. Acoustic Metamaterial Capsule for Reduction of Stage Machinery Noise. _J. Acoust. Soc. Am._ , **2020** , _147_ (3), 1491–1503. 

- [65] Gao, S.; Hu, X.; Mo, Y.; Zeng, H.; Mao, F.; Zhu, Y.; Zhang, H. Tunable Acoustic Transmission 

28 

Control and Dual-Mode Ventilated Sound Insulation by a Coupled Acoustic Metasurface. _Phys. Rev. Applied_ , **2024** , _21_ (4), 044045. 

- [66] Nguyen, H. Q.; Wu, Q.; Chen, H.; Chen, J. J.; Yu, Y. K.; Tracy, S.; Huang, G. L. A Fano-Based Acoustic Metamaterial for Ultra-Broadband Sound Barriers. _Proc. R. Soc. A-Math. Phys. Eng. Sci._ , **2021** , _477_ (2248), 20210024. 

- [67] Luk’yanchuk, B.; Zheludev, N. I.; Maier, S. A.; Halas, N. J.; Nordlander, P.; Giessen, H.; Chong, C. T. The Fano Resonance in Plasmonic Nanostructures and Metamaterials. _Nat. Mater._ , **2010** , _9_ (9), 707–715. 

- [68] Fano, U. Effects of Configuration Interaction on Intensities and Phase Shifts. _Phys. Rev._ , **1961** , _124_ (6), 1866–1878. 

- [69] Zhu, Y.; Dong, R.; Mao, D.; Wang, X.; Li, Y. Nonlocal Ventilating Metasurfaces. _Phys. Rev. Applied_ , **2023** , _19_ (1), 014067. 

- [70] Zhi hu Y.; Jia hui F.; Yu ping Z.; Hui yun Z.; Qingdao Key Laboratory of Terahertz Technology, College of Electronic and Information Engineering, Shandong University of Science and Technology, Qingdao 266590, China. Fano resonances design of metamaterials based on deep learning. _Chinese Optics_ , **2023** , _16_ (4), 816–823. 

- [71] Gao, S.; Zhu, Y.; Su, Z.; Zeng, H.; Zhang, H. Broadband Ventilated Sound Insulation in a Highly Sparse Acoustic Meta-Insulator Array. _Phys. Rev. B._ , **2022** , _106_ (18), 184107. 

- [72] Bilal, O. R.; Foehr, A.; Daraio, C. Reprogrammable Phononic Metasurfaces. _Adv. Mater._ , **2017** , _29_ (39), 1700628. 

- [73] Wen, G.; Zhang, S.; Wang, H.; Wang, Z.; He, J.; Chen, Z.; Liu, J.; Xie, Y. M. Origami-Based Acoustic Metamaterial for Tunable and Broadband Sound Attenuation. _Int. J. Mech. Sci_ , **2023** , _239_ , 107872. 

- [74] Li, X.; Zhang, H.; Tian, H.; Huang, Y.; Wang, L. Frequency-Tunable Sound Insulation via a Reconfigurable and Ventilated Acoustic Metamaterial. _J. Phys. D: Appl. Phys._ , **2022** , _55_ (49), 495108. 

- [75] Xiang, X.; Tian, H.; Huang, Y.; Wu, X.; Wen, W. Manually Tunable Ventilated Metamaterial Absorbers. _Appl. Phys. Lett._ , **2021** , _118_ (5), 053504. 

- [76] Yu, C.; Chen, X.; Duan, M.; Li, M.; Wang, X.; Mao, Y.; Zhao, L.; Xin, F.; Lu, T. J. Adjustable Sound Absorbing Metastructures for Low-Frequency Variable Discrete Sources. _Int. J. Mech. Sci._ , **2024** , _267_ , 108965. 

- [77] Ghaffarivardavagh, R.; Nikolajczyk, J.; Anderson, S.; Zhang, X. Ultra-Open Acoustic Metamaterial Silencer Based on Fano-like Interference. _Phys. Rev. B_ , **2019** , _99_ (2), 024302. 

- [78] Jiang, M.; Zhou, H. T.; Li, X. S.; Fu, W. X.; Wang, Y. F.; Wang, Y. S. Extreme Transmission of Elastic Metasurface for Deep Subwavelength Focusing. _Acta Mech. Sinica_ , **2022** , _38_ (3), 121497. 

- [79] Joe, Y. S.; Satanin, A. M.; Kim, C. S. Classical Analogy of Fano Resonances. _Phys. Scr._ , **2006** , _74_ (2), 259. 

29 

- [80] Fokin, V.; Ambati, M.; Sun, C.; Zhang, X. Method for Retrieving Effective Properties of Locally Resonant Acoustic Metamaterials. _Phys. Rev. B_ , **2007** , _76_ (14), 144302. 

- [81] Dong, H. W.; Zhao, S. D.; Wei, P.; Cheng, L.; Wang, Y. S.; Zhang, C. Z. Systematic Design and Realization of Double-Negative Acoustic Metamaterials by Topology Optimization. _Acta Mater._ , **2019** , _172_ , 102–120. 

- [82] Christensen, J.; Martin-Moreno, L.; Garcia-Vidal, F. J. Theory of Resonant Acoustic Transmission through Subwavelength Apertures. _Phys. Rev. Lett._ , **2008** , _101_ (1), 014301. 

30