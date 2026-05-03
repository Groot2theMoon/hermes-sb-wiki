---
title: "Application of machine learning on the design of acoustic metamaterials and phononic crystals"
journal: "10.1088/1361-665X/ad51bc"
authors: ["Author"]
year: 2024
source: paper
ingested: 2026-05-03
sha256: 5fb83520f53c3171397959acb5371007b5aad7afe9844f87e21c550a67ff8bcd
conversion: pymupdf4llm
---

Smart Materials and Structures 

Smart Mater. Struct. **33** (2024) 073001 (26pp) 

https://doi.org/10.1088/1361-665X/ad51bc 

## **Topical Review** 

## **Application of machine learning on the design of acoustic metamaterials and phonon crystals: a review** 

## **Jianquan Chen**[1]  **, Jiahan Huang**[1][,] _**[∗]**_  **, Mingyi An**[1] **, Pengfei Hu**[1] **, Yiyuan Xie**[1] **, Junjun Wu**[1] **and Yu Chen**[2] 

1 School of Mechatronics Engineering and Automation, Foshan University, Foshan 528225, People’s Republic of China 

2 School of Mechanical Engineering, Chengdu University, Chengdu 610106, People’s Republic of China 

E-mail: jiahanhuang@fosu.edu.cn 

Received 20 November 2023, revised 3 March 2024 Accepted for publication 28 May 2024 Published 6 June 2024 

**==> picture [33 x 37] intentionally omitted <==**

## **Abstract** 

This comprehensive review explores the design and applications of machine learning (ML) techniques to acoustic metamaterials (AMs) and phononic crystals (PnCs), with a particular focus on deep learning (DL). AMs and PnCs, characterized by artificially designed microstructures and geometries, offer unique acoustic properties for precise control and manipulation of sound waves. ML, including DL, in combination with traditional artificial design have promoted the design process, enabling data-driven approaches for feature identification, design optimization, and intelligent parameter search. ML algorithms process extensive AM data to discover novel structures and properties, enhancing overall acoustic performance. This review presents an in-depth exploration of applications associated with ML techniques in AMs and PnCs, highlighting specific advantages, challenges and potential solutions of applying of using ML algorithms associated with ML techniques. By bridging acoustic engineering and ML, this review paves the way for future breakthroughs in acoustic research and engineering. 

Keywords: phononic crystals, acoustic metamaterials, machine learning, deep learning 

## **1. Introduction** 

In the modern field of science and engineering, precise control and manipulation of sound waves are of great significance. Acoustic metamaterials (AMs), as emerging materials, possess special acoustic properties and functionalities through the careful design and manipulation of their microstructures and geometries. They are composite structures composed of various materials, and their microstructures and geometries are 

> _∗_ Author to whom any correspondence should be addressed. 

artificially designed and optimized to achieve extraordinary physical properties that natural materials do not possess, such as single negativity [1–3] (negative mass or negative modulus) or double negativity [4–6] (negative mass and modulus), negative refraction [7, 8], etc, enabling special wave propagation and wave control of sound waves. These unique properties make AMs have wide-ranging applications prospects in areas such as sound wave control [9, 10], acoustic invisibility [11– 13], and acoustic imaging [14–16]. 

The history of AMs can be traced back to the structure of periodic arrangements of elastic elements called phononic crystals (PnCs), which were primarily used for controlling the 

© 2024 IOP Publishing Ltd 

1 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

propagation and characteristics of phonons. As early as the 1990s, Kushwaha _et al_ [17] proposed the concept of PnCs analogous to photonic crystals and calculated the elastic wave bandgaps. Subsequently, PnCs attracted extensive attention from researchers, and in 1995, Martinez-Sala _et al_ [18] experimentally verified the existence of elastic wave bandgaps. The study of PnCs laid the foundation for the development of AMs and provided new ideas and methods for controlling the propagation and characteristics of sound waves. Li and Chan [19] introduced AMs in 2004 as an analogous concept. The realization of AMs triggered a research boom in related applications such as sound absorption and insulation [20–23], acoustic energy harvesting [24–27] and acoustic cloaking [28–30] in the field of acoustics. 

Traditional design methods for AMs are primarily based on the theory and physical models of periodic structures, which allow precise control of the propagation and scattering characteristics of sound waves by adjusting the microstructural parameters within them. These design methods can be divided into two categories: those based on homogeneous media theory and those based on multiscale methods. However, traditional design methods have certain limitations, such as limited design space and fixed design periodicity. The development of machine learning (ML) techniques has provided new support for the design of AMs. ML techniques can be applied to datadriven design of AMs, where by processing large amounts of data on AMs, ML algorithms can identify and extract features of AMs, thereby achieving design and optimization of AMs. This approach can speed up the design process, discover new structures and properties of AMs, and improve the acoustic performance of the design. In addition, ML techniques can also be applied to intelligent optimization algorithms for AMs. Using methods such as genetic algorithms (GAs) and neural networks, ML can automatically search for and optimize the design parameters of AMs, speeding up the search for optimal solutions and improving the performance of AMs while shortening the design cycle of AMs. It is worth noting that traditional design methods for AMs are limited to periodic structures, but ML techniques can enable the design and optimization of non-periodic AMs, opening up the possibility of designing a greater variety of AMs with different shapes. By combining traditional AMs design methods with ML techniques, more accurate, efficient, and diverse AMs designs can be achieved. This will promote the widespread application of AMs in sound wave control, acoustic isolation, acoustic imaging, and other fields, and bring about new breakthroughs and advances in acoustic engineering and scientific research. 

In section 2 of this paper, we introduce the basic concepts and classifications of PnCs and AMs. The concept of ML algorithms is introduced in the section 3, And their specific applications in AMs and PnCs are discussed (see sections 4 and 5). Next, we discuss the advantages, current challenges and potential solutions of applying of using ML algorithms in the design of PnCs and AMs in section 6. Finally, we summarize the article in section 7. 

## **2. Basic principles of AMs and PnCs** 

AMs are artificially designed composites that utilize periodic structures, multilayer structures, inclusion structures, and other methods to cause specific phase and amplitude changes in the propagation, reflection, refraction, and interference of acoustic waves. This allows for the control and modulation of acoustic waves, producing properties such as negative refractive index, negative group velocity, and negative acoustic parameters. These properties ultimately control acoustic wave propagation, imaging, and focusing. This section will cover the basic principles of AMs, various common structural types of AMs, and the basic design principles of PnCs. 

## _2.1. Basic principles of AMs_ 

AMs control acoustic wave equations in a homogeneous medium are as follows: 

**==> picture [151 x 25] intentionally omitted <==**

where _ρ_ and _K_ are the mass density and bulk modulus of the fluid medium, _p_ and _t_ are the sound pressure and time, respectively. The acoustic wave velocity controlling the change of wave direction at the interface is given by c = � _K/ρ_ . Acoustic impedance ( _Z_ 0) is defined as the ratio of the pressure in the wave to the velocity of the fluid, expressed as _Z_ 0 = _p/ν_ = _√Kρ_ , it controls the amplitude of reflection and transmission at the interface. 

Compared to traditional acoustic materials, the properties of AMs and PnCs also can be expressed by the transmission loss TL ( _θ_ ) and sound absorption coefficient: the transmission loss of the component at the angle of incident is expressed as: 

**==> picture [196 x 25] intentionally omitted <==**

where, _ms_ is the mass per unit area and _ω_ is the angular frequency of sound wave. _ρ_ and _c_ are the density and speed of sound in air, respectively. 

Sound absorption coefficient ( _α_ ) is a physical quantity that measures the sound absorption performance of acoustic materials and can reflect the strength of the material’s sound absorption ability. Sound absorption coefficient calculation formula (2-3), where _E_ i is the incident sound energy; _E_ r is reflected sound energy, 

**==> picture [170 x 23] intentionally omitted <==**

When the direction of acoustic wave incidence is vertical incidence on the surface of the AM structure, the acoustic impedance ( _Z_ 0) can also be used to represent the reflection coefficient, and the sound absorption coefficient of the material can be expressed as: 

2 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [385 x 199] intentionally omitted <==**

**Figure 1.** Typical resonant acoustic metamaterial diagram (a) Schematic diagram of thin plate periodic array of attached spring-mass resonators. Reproduced from [31]. © IOP Publishing Ltd All rights reserved. (b) On the left is an idealized two-dimensional metamaterial structure, and on the right is a plate with periodic local resonance. Reprinted from [32], Copyright 2014, with permission from Elsevier. (c) Schematic diagram of the unit cells of a locally resonant stiffened plate. Reproduced with permission from [33]. (d) Resonance plate diagram of double cantilever structure. Reproduced with permission from [34]. 

**==> picture [185 x 28] intentionally omitted <==**

It is important to note that when evaluating the performance of AMs and PnCs, factors beyond transmission loss and sound absorption coefficient must be considered. These factors include negative refraction index, phonon band gap, and other special performance indicators. Equivalent parameters of negative index materials: 

**==> picture [147 x 21] intentionally omitted <==**

where _n−_ eff is the equivalent refractive index of the negative index material, _n_ is the velocity of light in vacuum, and _c_ 0 is the phase velocity in the negative index material. 

The calculation of the phonon bandgap involves the use of Brillouin zone theory and numerical simulation methods. The Brillouin region folding method is used to determine the boundary of the Brillouin region based on the lattice structure of the PnC. The frequency range of the band gap is then determined by analyzing the dispersion relationship of phonons in the Brillouin region. Numerical simulation methods such as transfer matrix method, plane wave expansion method, finite difference time domain method, and multiple scattering method are used to solve the acoustic wave equation or dynamic equation numerically. These methods model the corresponding structure, calculate the frequency and mode of phonons, and finally determine the band gap of phonons by analyzing the propagation mode in the frequency range. 

## _2.2. Types of common AMs_ 

_2.2.1. Resonant-type AMs._ Resonant AMs are a type of AMs that incorporate resonant structures, such as helical 

springs and mass-spring resonators, into microstructures. These structures exhibit unique acoustic properties, including negative impedance and negative elastic modulus within a specific frequency range. As a result, they can produce phenomena such as negative refraction and phonon band gaps. The achievement of these properties is dependent on the careful design and control of the structural and physical parameters of the metamaterials. The design principle is based on the local resonance effect. This means that when the size of the metamaterial is equivalent to the wavelength of the incident sound wave, the microstructure interacts with the incident sound wave and triggers resonance. To achieve this, a suitable structural unit must be selected, and its geometry, size and material parameters must be adjusted to construct a metamaterial with ideal acoustic properties. 

Resonant elements, such as spring-mass resonators, are frequently used in AMs to achieve resonance. Xiao _et al_ ’s [31] model of locally resonant thin plates constructed on homogeneous thin plates (see figure 1(a)) is an example of this. The Plane Wave expansion method was developed to evaluate the bandgap attenuation performance. Nouh _et al_ [32] proposed metamaterial plates composed of periodic cells with built-in local resonances (see figure 1(b)). Xi-Xi _et al_ [33] introduced an acoustic plate that can generate a low-frequency local resonance band gap and expand the high-frequency Bragg band gap by periodically arranging spring-vibrator resonance units on the stiffened plate (see figure 1(c)). In the same year, Jian _et al_ [34] proposed attaching multiple double cantilever structures periodically to the thin plate to obtain a locally resonant thin plate that can generate multiple low-frequency bending band gaps (see figure 1(d)). The resonant AM thin plate has the advantages of frequency selectivity and structure tunability, which can enable the control of specific frequency sound 

3 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [385 x 283] intentionally omitted <==**

**Figure 2.** Typical thin film acoustic metamaterials (a) thin-film acoustic metamaterial decorated with asymmetric rigid lamellae. Reproduced from [35], with permission from Springer Nature.(b)Novel thin film acoustic metamaterials for external circuits. Reproduced with permission from [36]. (c) The distributed structure thin-film acoustic metamaterial is composed of four metal foils and a cross-shaped flexible vinyl acetate (EVA) material swing arm. The swing arm is attached to the surface of a polyimide (PI) film with EVA material serving as a frame and swing arm support. Reprinted from [37], Copyright 2019, with permission from Elsevier. (d) Box frame thin film acoustic metamaterial. Reprinted from [38], Copyright 2022, with permission from Elsevier. 

waves. However, narrow-band characteristics and manufacturing complexity are also among their disadvantages. 

_2.2.2. Membrane-type AMs._ Membrane-type AMs, also referred to as thin-film AMs, are materials with a unique structure and properties. They consist of a thin film and additional mass units, which modulate acoustic waves and provide acoustic isolation through the interaction of the film’s vibration and the additional mass unit. A metal sheet is placed in the center of the film and pre-tensioned to create a mass-spring-like structure, resulting in a unique dynamic mass phenomenon. This allows for the transmission of sound waves when the dynamic mass is zero, and the reflection of sound waves when the dynamic mass is infinite. Additionally, adjusting the position of the metal sheet can achieve translational and rotational resonance. Thin-film AMs utilize the negative mass effect to achieve effective acoustic isolation in the low frequency range. They offer advantages over conventional acoustic isolation materials by effectively isolating low-frequency noise at specific frequencies while maintaining light weight, small size, and convenient layout. This provides a new solution for acoustic applications. 

Mei _et al_ [35] proposed a thin-film AM decorated with asymmetric rigid lamellae (see figure 2(a)) that can completely absorb low-frequency airborne sound at selective resonance frequencies in the range of 100–1000 Hz. In 2019, 

Zi-Hou _et al_ [36] proposed a novel AM with piezoelectrics connected to external circuits embedded in a tensioned elastic membrane(see figure 2(b)). Zhou _et al_ [37] presented a lowfrequency AMs with a frequency range of 20–1200 Hz (see figure 2(c)). The AMs exhibited good acoustic isolation performance and the circuit parameters could be adjusted to further improve its performance. A distributed structure thin film AM is proposed in this study. The structure is lightweight, flexible, and ultrathin. It is designed to broaden the frequency band of acoustic isolation and improve the acoustic isolation performance. Jang _et al_ [38] also proposed an acoustic isolation thin film metamaterial with a box-shaped frame and vibrating membrane (see figure 2(d)). This metamaterial can block sound waves in the 1960–2790 and 3910–5660 Hz frequency bands. 

_2.2.3. Helmholtz resonance-type AM._ Helmholtz resonant AMs use the Helmholtz resonator principle to control and modulate sound waves. A Helmholtz resonator consists of a cavity and one or more necks connected to it. When sound waves are applied to the neck inlets, the whole system can be equated to a mass-spring-damping system. The air volume in the neck functions as a mass, while the expansion and contraction of the air in the cavity behaves like a spring. The oscillation of the air in the neck against the tube wall and the radiation of sound in the neck correspond to damping. This design 

4 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [247 x 161] intentionally omitted <==**

**Figure 3.** Schematic diagram of Helmholtz resonator and schematic diagram of equivalent mass spring damping. 

principle can be achieved by adjusting the geometrical parameters of the cavity and neck to control the frequency and propagation characteristics of the sound wave. The figure 3 illustrates a Helmholtz cavity, which comprises a short tube with a radius of ‘a’ and a neck length connected to a rectangular cavity with a specific volume. 

AMs use Helmholtz resonators arranged in a periodic, identical, or ordered manner to efficiently manipulate acoustic waves. The geometrical parameters of the resonating cavities, such as the cavity area and neck length, can be adjusted to tune the metamaterials to absorb, reflect, and transmit acoustic waves of different frequencies. Common AMs for Helmholtz resonators include periodic one-dimensional Helmholtz resonant cavities with acoustic inductance and acoustic capacitance. Fang _et al_ [39] first proposed this type of AM (see figure 4(a)). In recent years, Duan _et al_ [40] proposed metal hexagonal cellular Helmholtz resonators for the perfect absorption of lowfrequency and ultra-broadband acoustics in the underwater. These resonators are lightweight and can be tuned as AMs (see figure 4(b)). In 2022, Yang _et al_ [41] proposed a tunable parallel Helmholtz AM (see figure 4(c)) by introducing multiple resonant cavities to obtain a wider acoustic absorption band. In 2023, they proposed a novel modular nested Helmholtz resonator AM [42] (see figure 4(d)). The proposed tunable modular nested Helmholtz resonator facilitates the suppression of multiple non-stationary narrowband noises. While Helmholtz resonator AMs offer structural tenability and compactness, they also present fabrication complexity and energy loss. These factors must be taken into account when assessing the suitability and limitations of AMs for specific applications. 

_2.2.4. Space-coiling AMs._ Space-coiling AMs is a specially designed AMs with a spatially coiled structure. This AM controls and manipulates sound waves by winding their paths through space. By designing the various coiled paths, the propagation path of sound waves inside the metamaterial is longer than the physical dimensions of the metamaterial itself. Using this special structure, space-coiling AMs 

can be constructed with acoustic properties that have extreme intrinsic parameters, such as double negativity, near-zero density, and high refractive index, based on the reflection, scattering, and interference of acoustic waves in the space-wound structure. Conventional space-coiling metamaterial structures (figure 5(a)) have gradually evolved into various geometries that can be manipulated for specific wavelengths, such as conical labyrinthine structures (figure 5(b)), symmetric spacewound structures (figure 5(c)), space-coiling AMs with quasifractal geometries (figure 5(d)), and so on. AMs by introducing space-coiling structures have the advantages of multiband performance and design flexibility, but they also face the corresponding disadvantages of process fabrication complexity and size limitation. 

_2.2.5. Composite structural AMs._ Composite structural AMs are materials that consist of two or more components with different structures, such as varying shapes, materials, or dimensions. This combination of components allows for highly controllable and tunable acoustic properties. The design of composite AMs depends on selecting the appropriate combination of components and optimizing their arrangement. Composite structural AMs exhibit exceptional acoustic properties and have a broad range of applications. Figure 1 illustrates several commonly used composite structured AMs. Lee _et al_ [47] was able to achieve negative density and negative equivalent modulus by integrating a membrane with a Helmholtz resonator structure. This was accomplished by adding a membrane to the hollow tube of the Helmholtz resonator, as shown in figure 1(a). Fok and Zhang [48] achieved double-negative properties by using two different resonant structures to form a hybrid AM (see figure 1(b)). Fei _et al_ [49] used a micro perforated panel (MPP) and coiled-up Fabry– Perot channels (see figure 6(c)) to absorb up to 99% of the acoustic energy at the resonance frequency ( _<_ 500 Hz) due to frictional loss of acoustic energy in the MPP, resulting in excellent sound absorption. Xie _et al_ [50] combined the Helmholtz resonator with a MPP and honeycomb cell structure (see figure 6(d)). Each honeycomb cell corresponds to a perforation at the top of the MPP, forming a Helmholtz resonator. The acoustic absorption effect is also up to 99% at the resonance frequency. 

## _2.3. The basic principles of PnCs_ 

PnCs are materials with periodic structures that can control the propagation properties of sound waves. The design of PnCs is based on the scattering and diffraction phenomena of sound waves in periodic structures. Therefore, the design of PnCs can be attributed to two key principles: Bragg scattering and local resonance mechanism. Bragg scattering refers to the scattering of sound waves in a particular direction when they encounter a periodic structure due to the periodicity of the structure. This scattering coupling with the periodic structure and scatterers leads to the formation of bandgaps in the PnCs. Phononic bandgaps refer to the frequency range in 

5 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [385 x 265] intentionally omitted <==**

**Figure 4.** Common types of Helmholtz AMs. (a) AMs diagram with One-dimensional array Helmholtz resonator. Reprinted from [39], Copyright 2006, with permission from Elsevier. (b)Hexagon honeycomb Helmholtz resonator diagram. Reprinted from [40], with the permission of AIP Publishing. (c) Multiple cavity APH-AM diagram. Reproduced from [41]. CC BY 4.0. (d) AMs diagram of a nested Helmholtz resonator. Reprinted from [42], Copyright 2023, with permission from Elsevier. 

**==> picture [247 x 212] intentionally omitted <==**

**Figure 5.** Common space-coiling metamaterials. (a) Traditional space-coiling metamaterial unit cell: Space-coiling metamaterial structure with the overall length of t and overall width of a is depicted here, acoustic wave trajectory is shown as the dashed line. Reprinted figure with permission from [43], Copyright 2012 by the American Physical Society. (b)Tapered labyrinthine AMs: On the left is 3D Horn-port labyrinthine unit cell, On the right is 3D Anisotropic spiral unit cell. Reprinted from [44], with the permission of AIP Publishing. (c) AMs with symmetrically coiled spatial structure. Reprinted from [45], Copyright 2020, with permission from Elsevier. (d) A type of space-coiling AMs featuring quasi-fractal geometries with filling curves based on the construction for recursive substructures of triangles. Reprinted from [46], Copyright 2021, with permission from Elsevier. 

which sound waves cannot propagate, resulting in a band of forbidden frequencies. The bandgap frequency range in PnCs tends to be at lower frequencies for local resonance-type PnCs, 

whereas for Bragg scattering-type bandgaps, they are formed due to the scattering coupling of the periodic structure and scatterers. 

6 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [247 x 266] intentionally omitted <==**

**Figure 6.** Common types of composite structural AMs. (a) AMs with membrane and helmholtz resonator. Reprinted figure with permission from [47], Copyright 2010 by the American Physical Society. (b) AMs with two different resonating structures. Reprinted figure with permission from [48], Copyright 2011 by the American Physical Society. (c) AMs with MPP and coiled-up FP channel. Reprinted from [49], with the permission of AIP Publishing. (d) The acoustic surface panel with honeycomb core and MPP. Reprinted from [50], Copyright 2019, with permission from Elsevier. 

For local resonance, the resonance frequency _ω_ can be calculated using the following formula: 

**==> picture [143 x 25] intentionally omitted <==**

where _K_ is the equivalent spring constant of the local resonant unit, and _m_ is its equivalent mass. 

For Bragg scattering, the scattering angle _θ_ can be calculated by: 

**==> picture [158 x 25] intentionally omitted <==**

where _λ_ is the wavelength of the incident acoustic wave, and _d_ is the periodic arrangement spacing of the microstructures in the metamaterial. 

Additionally, according to Bloch–Floquet theory, when designing the unit cell of a PnCs, it should exhibit periodicity along the _x_ and _y_ axes. All nodes at the boundaries of the unit cell satisfy the following conditions: 

**==> picture [168 x 13] intentionally omitted <==**

In the mentioned equations: 

_u_ represents the displacement matrix of all nodes. _a_ represents the lattice constant of the structure. 

_K_ represents the stiffness matrix of the typical unit cell. 

**==> picture [159 x 14] intentionally omitted <==**

In this equation: 

_ω_ represents the eigenfrequency (angular frequency). _M_ represents the mass matrix of the typical unit cell. 

## _2.4. Differences and relations between PnCs and AMs_ 

Although PnCs and AMs share some similarities in their application to acoustic frequencies, they differ significantly in aspects such as frequency range, physical mechanism, application focus, and corresponding materials. AMs are mainly applied to low and medium frequencies, manipulating acoustic waves through structural design and special materials. In comparison, the application range of PnCs is broader, covering the frequency range from infrasound to ultrasound. Their mechanism for controlling acoustic waves is based on the periodicity of lattice structures and Bragg scattering effects. In addition, the application focus of AMs is on negative refraction, superlensing, cloaking techniques, and sound absorption. The differences between PnCs and AMs are summarized in table 1: 

## **3. Overview of ML** 

ML is a pivotal branch of artificial intelligence, aiming to develop and apply algorithms that enable machines to learn from data and improve their performance. Starting from early concepts and simple algorithms in the 1950s, to the development of deep learning (DL) and neural networks in the early 21st century, ML has made significant strides. ML has provided effective tools for solving complex nonlinear problems, particularly in domains such as speech recognition [51], computer vision [52], natural language processing [53], finance [54], and healthcare [55]. 

The design and optimization of AMs and PnCs present complex challenges, involving various fields including physics, materials science, and engineering. The inherent complexities often necessitate substantial time and computational resources when employing traditional design and optimization methods. Introducing ML can greatly enhance the efficiency of the design and optimization process. By training ML models, it becomes possible to rapidly predict the performance of metamaterials and identify optimal designs. Moreover, ML can be employed to address inverse design problems, wherein the objective is to determine the corresponding metamaterial designs that achieve desired performance. In this section, we introduce the mainstream ML algorithms that have been applied to the field of AMs and PnCs. 

## _3.1. Supervised learning and unsupervised learning_ 

Supervised learning is a subfield of ML that focuses on learning the mapping between input and output variables. The models used in supervised learning aim to learn from pre-labeled 

7 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

> **Table 1.** Comparison between phononic crystals and acoustic metamaterials. 

|**Table**|**1.** Comparison between phononic crystals and acou|stic metamaterials.|
|---|---|---|
||Phononic crystals|Acoustic metamaterials|
|Constituent structure|A periodic structure consisting of two (or|A periodic structure consisting|
||more) elastic materials|mainly of microstructural units.|
|Basic principle|Bragg scattering and local resonance.|Structure-based scattering and|
|||refection control, as well as special|
|||material properties and resonance|
|||effects.|
|Bandgap characteristics|The focus is on generating band gaps,|It is often designed to achieve|
||regions within the frequency range where|special acoustic properties such as|
||sound waves cannot propagate.|negative refraction,|
|||supertransmission, or focusing of|
|||sound waves.|
|Characteristic control|The propagation of phonons (the quanta|Artifcial structures and special|
||of sound waves) is regulated by adjusting|materials are used to regulate sound|
||the periodicity and lattice constant of the|waves.|
||lattice.||



data samples, attempting to predict the corresponding output with relative accuracy when given new, unseen data. This process involves error feedback and continuous adjustment of model parameters to minimize the discrepancy between predicted and actual results. For instance, the support vector machine (SVM) is a potent supervised learning algorithm for classification and regression. Its core concept is to determine the optimal decision boundary, which involves maximizing the distance between different classes. This is achieved by constructing a hyperplane that effectively separates the various categories. One of the main functions of SVM is to use kernel functions to map data from the original input space to a highdimensional feature space. This is done to find the optimal separation hyperplane in that space. The observation is that data may not be linearly separable in its original space, but it can be mapped to a higher-dimensional space where it is linearly separable. Common kernel functions in SVM include the linear kernel, polynomial kernel, radial basis function (RBF) kernel, and sigmoid kernel. SVM can be used to classify the acoustic properties of materials or predict the effects of different structural parameters on the properties in the design of AMs and PnCs. This provides data-driven guidance for material design. Other supervised learning algorithms commonly used are linear regression, decision trees, and random forests. 

Unlike supervised learning, unsupervised learning does not use pre-labelled responses to train the model. Instead, it finds hidden patterns in the data by analyzing features in the dataset. Unsupervised learning algorithms work without explicit output references, revealing the natural clustering, distribution, data density, and relationships of the structure by dividing the dataset into multiple subsets made up of data points with similar characteristics. Principal component analysis (PCA) is a statistical technique that reduces data dimensionality while preserving as much of the original data as possible. It calculates the covariance matrix of the data and finds the eigenvectors and eigenvalues of that matrix. The data is then projected into a new coordinate system defined by the eigenvectors, which are the principal components of the data. In the design of 

AMs and PnCs, PCA can be used to analyze and simplify complex data sets. This helps researchers to identify key factors that affect material properties, leading to more efficient material design and optimization. Additionally, various clustering algorithms are also commonly used as unsupervised learning algorithms. 

## _3.2. Reinforcement learning_ 

Reinforcement learning can be described as an optimization and decision process that falls between supervised and unsupervised learning. Unlike supervised learning, which depends on a significant amount of labeled data for deep feature extraction and classification, and unlike unsupervised learning, which necessitates unlabeled data for training, reinforcement learning employs a sample label known as the reward. This reward is not as precise as in supervised learning, but rather is delayed and sparse. Reinforcement learning is advantageous in that it does not require labelled data for training. Instead, it necessitates an environment, a reward formula, and an automatic learning model to continuously improve itself. This type of learning relies on interaction with the environment and a reward-based mechanism. The fundamental principle of reinforcement learning is that agent interact with the environment through trial and error (as shown in figure 7). Agent observe the state of the environment to perform actions and receive rewards or punishments from the environment to learn. The objective is to learn the optimal strategy for a given environment to maximize cumulative rewards. 

Reinforcement learning is well-suited for multi-objective optimization and high-dimensional parametric space problems in the context of AMs and PnCs design. Design tasks typically involve finding an optimal solution in a complex parameter space by tuning the periodic structure, geometry, and other material parameters. Reinforcement learning algorithms learn the optimal design strategy by interacting with the environment and guiding the search process through rewards 

8 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [247 x 234] intentionally omitted <==**

**Figure 7.** Schematic diagram of reinforcement learning principles. 

and punishments. In cases where a design task involves multiple potentially conflicting objectives, such as acoustic transmission, isolation, and focusing performance, reinforcement learning can effectively balance these objectives. 

Common reinforcement learning algorithms used in this process include Q learning, SARSA, Deep Q networks (DQN), deep Deterministic Policy Gradient (DDPG), and softexecutor-Critic (SAC). In the design of AMs and PnCs, the design problem can be modelled as a Markov decision process. The agent learns how to improve the structure by trying different design options and evaluating their acoustic performance, ultimately achieving the goal of optimizing acoustic properties. In short, reinforcement learning provides an efficient, reward-oriented optimization method for AM design, enabling efficient solutions to complex, multi-objective, and high-dimensional design problems. 

## _3.3. DL_ 

In recent years, DL has demonstrated significant potential in the design of AMs and PnCs. The origins of DL can be traced back to the 1950s, coinciding with research on artificial neural networks. With the advancement of computational power and the availability of big data, DL gained momentum in the early 21st century, particularly in the fields of image recognition, speech recognition, and natural language processing. DL, a branch of ML, can be applied to all three types of tasks: unsupervised learning, supervised learning, and reinforcement learning. DL is not limited to specific categories and can be employed across different task types as a ML approach. For example, in supervised learning of DL models, unsupervised pre-training can improve the model’s performance. In deep reinforcement learning (DRL), deep neural networks (DNNs) 

can approximate value functions or optimize policies. In comparison to conventional ML techniques, DL models are capable of tackling intricate learning and decision-making problems by constructing DNNs. This allows them to learn more complex feature representations and abstract concepts. 

DL is founded on artificial neural networks that simulate the way the human brain processes information for learning and decision-making. The fundamental unit of an artificial neural network is a neuron (as illustrated in figure 8(a)). Each neuron receives a set of input signals ( _x_ 1 _, x_ 2), performs a weighted sum of the inputs using weights ( _w_ 1 _, w_ 2), and then applies a nonlinear activation function ( _f_ ) to produce an output signal ( _Y_ ). The artificial neural network consists of multiple neurons that form the input layer, hidden layer(s), and output layer. Each neuron receives inputs from the neurons in the previous layer and generates an output, as illustrated in figure 8(b). The input layer acts as the starting point of the network, receiving input data and passing it to the next layer. The hidden layer or layers, which are situated between the input layer and the output layer, are responsible for extracting features and creating abstract representations of the input data. Each neuron in the hidden layer performs a weighted sum and nonlinear transformation of the input signals based on the connection weights and activation function with the neurons in the previous layer, resulting in an output signal. The output layer receives inputs from the last hidden layer and produces the final output of the network. Finally, the artificial neural network adjusts to the input data’s features and makes predictions and decisions by learning and adapting its weights. 

The essence of DL is in the automatic extraction and learning of features through multi-layer neural networks. Each layer can extract more abstract and high-level features from the raw data. During this process, activation functions, such as ReLU ( _f_ ( _x_ ) = max (0, _x_ )), provide the network with nonlinearity. 

9 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [385 x 358] intentionally omitted <==**

**Figure 8.** Schematic of the principles of various networks. (a) neuron model; (b) artificial neural network; (c) convolutional neural network; (d) generative adversarial network; (f) the autoencoder. 

Meanwhile, a loss function, such as mean squared error, measures the deviation between model predictions and actual data. This guides the model to adjust the weight parameters through the backpropagation algorithm to minimize the loss. 

Convolutional neural networks (CNNs) are a type of artificial neural network that provides several advantages in processing grid-structured data. Unlike traditional fully connected neural networks, CNN incorporate spatial structure information of input data by introducing operations such as convolutional layers, pooling layers, and local connectivity (as illustrated in figure 8(c)). The convolutional layer is a fundamental element of CNN. It extracts local features by applying filters (convolutional kernels) to the input data. This mechanism of local connectivity and weight sharing enables CNN to capture local patterns and features in the input data, resulting in excellent performance in image processing tasks. Additionally, CNN differ from traditional artificial neural networks by introducing pooling layers. Pooling layer decrease data dimensionality by downsampling while retaining crucial feature information. This reduces network parameters and computational complexity, while enhancing network robustness and generalization ability. In summary, CNNs are tailored for grid-structured data processing. Convolutional layers and 

pooling layers effectively extract local features from input data, demonstrating excellent performance in tasks related to AMs image design. 

The generative adversarial network (GAN) is a neural network architecture that comprises a generator and a discriminator. The GAN is a neural network architecture that comprises a generator and a discriminator. These two components are trained in an adversarial manner to produce realistic data samples, as illustrated in figure 8(d). The generator takes a random noise vector as input and maps it through a series of transformation layers to generate synthetic data samples in a high-dimensional space. The discriminator is responsible for binary classification, attempting to distinguish between real and synthetic data. The generator aims to maximize the discriminator’s inability to differentiate between the two types of data, while the discriminator aims to maximize the probability of correctly classifying them. GAN can be used to generate and optimize the structural shapes of PnCs and AMs. The generator network can be trained to produce structures with specific acoustic propagation characteristics, which accelerates the structural optimization process of AMs. In addition to GAN, there are two common variants: Wasserstein GANs (WGANs) and conditional GANs (CGAN). WGANs improve 

10 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

the training process and convergence of GAN by introducing the Wasserstein distance, while CGAN enable conditional sample generation by introducing a conditional vector. 

The Autoencoder is an unsupervised learning algorithm that belongs to DL. It consists of two main components: an encoder and a decoder (as shown in figure 8(f)). The encoder maps the input data to a low-dimensional representation that captures the key features of the input data. The decoder maps the low-dimensional representation back to the original data space and attempts to reconstruct the input data. The aim of training an autoencoder is to minimize the reconstruction error, which is the difference between the output of the decoder and the original input. The autoencoder learns how to compress and reconstruct the input data to minimize the reconstruction error by adjusting the parameters of the encoder and decoder. Training an autoencoder can lead to effective feature representations of input data, which can be used for tasks such as dimensionality reduction, feature extraction, and denoising. Autoencoders can also generate new samples similar to the input data. Variations of the basic autoencoder include Sparse Autoencoder, Denoising Autoencoder, and Variational Autoencoder. These variations introduce additional constraints and objectives in the loss function, network structure, or training process to further enhance the performance and learning capabilities of autoencoders. 

## **4. Application of ML algorithms in AM design** 

## _4.1. Metamaterial structure optimization based on traditional ML methods_ 

In the design of AMs, structural optimization based on traditional ML methods has proven to be critical for achieving specific acoustic performance goals. These methods mainly include GA, Gaussian-Bayesian models (G-BM), nonlinear programming, and Monte Carlo start-point technique (MCSP), which have shown remarkable results in solving the high computational cost of complex AM design. 

GA has been widely used in metamaterial structure optimization. For example, Dong _et al_ [56] used an improved singleobjective GA to design a square lattice subwavelength AM with broadband negative refraction and subwavelength imaging properties under a topological optimization framework. In addition, Robeck _et al_ [57] used nonlinear manifold interpolation and ML methods to solve the nonlinear uniformity constraint problem in aperiodic wideband metamaterial design. 

The G-BM has also shown its superiority in the inverse design of AMs. Zheng _et al_ [58] proposed an inverse design method based on the G-BM that effectively adaptively adjusts multiple structural parameters of a typical AMs absorber to achieve low frequency and high sound absorption performance with fewer evaluations (only 37). Similarly, An Chen _et al_ [59] adopted an improved Gauss-Bayes modelassisted subwavelength absorber design method to optimize high sound absorption performance for multi-component aperiodic structures. 

The MCSP has also shown its usefulness in the design of periodic metamaterials. Bacigalupo _et al_ [60] combined the asymptotic homogenization method and the MCSP to study the dispersion wave propagation in periodic metamaterials with quadruple topology and local resonant inclusion, and successfully solved the bandgap optimization problem. The same team also demonstrated the effectiveness of RBF networks and objective function interpolation Monte Carlo methods [61] in maximizing low-frequency bandgap amplitudes for periodic AMs with quadruple chiral microstructures. 

The above examples of traditional ML are summarized in table 2. Those traditional ML methods play an important role in the structural design and optimization of AMs. By combining these methods, the computational efficiency and optimization performance are effectively improved, and the precise numerical optimization of the structural parameters of AMs is realized. These methods may perform well for specific design problems, but their ability to generalize to other different types of AM designs may be limited. 

## _4.2. Optimization of metamaterial structures based on DL models_ 

As ML continues to advance, researchers have increasingly recognized the convenience offered by a wider range of ML methods. In the design of AMs, there has been a shift toward more sophisticated model architectures, such as neural networks, CNNs, DRL, and GANs. These DL model approaches for optimizing the structures of AMs have distinct advantages and applicability in practical applications. Researchers can improve the efficiency and performance of AM design by selecting appropriate methods based on specific design requirements and task objectives. The following table 3 summarizes the advantages of common models for DL and the scenarios in which they can be used. 

_4.2.1. Metamaterial structure optimization based on DNN and CNN models._ Neural networks are a general ML model that can be used for the optimization of AMs structures. A neural network consists of multiple layers of neurons that can learn nonlinear relationships and feature representations of input data. Overall, a neural network is a computational model that mimics the nervous system of the human brain, processing information and learning through multiple layers of neurons and connections. It is the basis of DL and has been widely used in various AMs design tasks, where neural network architectures are applied to solve the problems of designing onedimensional nonperiodic metamaterial systems for AMs [62], meta-model representation and design optimization of highdimensional nonperiodic metamaterial systems [63] modular designing and finding the optimal structure with specific acoustic properties [64] and modeling and inverse designing of membrane supersurface absorbers, respectively [65], and other problems. 

11 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

> **Table 2.** Traditional typical machine learning examples. 

||**Table 2.** Traditional typical m|achine learning examples.||
|---|---|---|---|
|Algorithm|Meta-structure and performance|Description|Year|
|Nonlinear programming and||Addressing the problem of|2016 Reproduced from [60],|
|a quasi-Monte Carlo||structural optimization|with permission from|
|multi-start technique|||Springer Nature.|
|Genetic algorithms||Topology optimization|2019 Reprinted from [56],|
|||framework based on|Copyright 2019, with|
|||enhanced genetic algorithm|permission from Elsevier.|
|Gauss-Bayesian model||Inverse design of acoustic|2020 Reprinted from [58],|
|||metamaterials based on|with the permission of AIP|
|||Gaussian-Bayesian model|Publishing.|
|Radial basis function||Parameter optimization of|2020 Reproduced from [61],|
|networks and quasi-Monte||acoustic metamaterials|with permission from|
|Carlo methods|||Springer Nature.|



**Table 3.** Common models of deep learning. 

||**Table 3.** Common models of deep learning.||
|---|---|---|
|Model|Adapting to the scene|Advantages|
|Deep neural networks|Complex feature modeling and structural|It can deal with complex nonlinear|
||optimization problems are required|relationships and has strong|
|||generalization ability|
|Convolutional neural networks|Design tasks that require accurate|It can deal with high-dimensional|
||prediction of the relationship between|data and achieve high prediction|
||acoustic properties and structural|accuracy|
||parameters||
|Deep reinforcement learning|Design tasks that require optimization of|It can handle complex structural|
||continuous parameters|parameter spaces and optimize|
|||objective functions|
|Generative deep learning|Scenes with metamaterial structures that|The acoustic properties of the|
||meet specifc acoustic performance|generated samples can be precisely|
||requirements need to be generated|controlled|



DNNs, on the other hand, are a special type of neural network with a structure of multiple hidden layers. These hidden layers allow the network to have a more complex representation and be able to learn more abstract and higherlevel feature representations. Compared to traditional shallow 

neural networks, DNNs are able to learn more complex and higher-level feature representations in AMs design, which improves the performance and expressive ability of the model. Cheng _et al_ [66] implemented the inverse design of a composite acoustic absorber unit based on a Helmholtz resonant 

12 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [247 x 430] intentionally omitted <==**

**Figure 9.** Deep neural network and deep autoencoder network acoustic metamaterial design framework. (a) deep neural network model structure. (b) Deep autoencoder network model structure. Reprinted from [66], Copyright 2021, with permission from Elsevier. (c) Convolutional neural network structure diagram for the design of metasurface absorber. Reproduced from [69]. © IOP Publishing Ltd All rights reserved. 

cavity and porous materials using DNNs and deep selfencoder networks (figures 9(a) and (b)), which improved the efficiency and accuracy of the corresponding design unit. Liu _et al_ [67] solved the problem of complex design process and long development cycle of phonon plate metamaterials by DNN based AMs design. By combining a multi-objective optimization algorithm with a DL neural network, Du and Mei [68] constructed a comprehensive and efficient optimization framework to intelligently design acoustic retroreflectors so that their seven different diffraction orders work together to achieve the expected efficient reflection function over a wide and continuous range of incidence angles. 

Whereas CNN is a neural network structure specialized in processing image and spatial data, in AMs structure optimization, CNN can be used to analyze the relationship between acoustic properties and predicted structural parameters based on two-dimensional cellular maps of metamaterials. By training the neural network, the mapping relationship between acoustic properties and structural parameters can be established and the optimization of structural parameters can be performed. 

Zhao _et al_ [70] proposed a dual—CNN optimization method for acoustic wave control to design hypersurfaces. The method achieves highly accurate hypersurface design by establishing a CNN mapping the local acoustic field to the hypersurface phase gradient and further optimizing it by another CNN. This ML method not only provides higher accuracy than traditional GAs, but also achieves regional control of the local acoustic field by obtaining the phase gradient of the hypersurface based on the acoustic field. Donda _et al_ [69] used a CNN to simulate the broad absorption spectral response on a millisecond time scale to realize an ultrathin thickness up to ultrathin surface absorber by feeding a set of geometrical inputs to the CNN (figure 9(c)), allowing the data to be smoothed and upsampled in a learnable manner. The output of the CNN is fed to fully connected layers that produce a predicted spectrum (red dashed line) compared to the ground truth (blue curve).on the other hand, Liu _et al_ [71] used CNN to solve the problem of bandwidth limitation of conventional acoustic absorption materials. Wu _et al_ [72] proposed an acoustic metasurface design method based on multi-fidelity complex CNNs to predict high-dimensional scattered sound fields at a low data cost. The time cost is only 8% of that of the GA. 

_4.2.2. Metamaterial structure optimization based on DRL model and CNN models._ Reinforcement learning algorithms are a method for learning optimal behavior by interacting with the environment. In AMs structure optimization, reinforcement learning algorithms can be used to search for optimal metamaterial structure parameters. By defining states, actions and reward functions, reinforcement learning algorithms can automatically learn and optimize acoustic properties (figure 10(a)). DRL, on the other hand, combines the techniques of reinforcement learning and DL by utilizing DNNs to approximate value functions or policy functions. With DNNs, DRL can deal with high-dimensional state and action spaces, enabling intelligences to learn complex decision-making strategies. A semi-analytical method for suppressing acoustic scattering using reinforcement learning algorithms was proposed by Shah _et al_ [73]. The design parameters of a cylindrical scatterer in water, including position and radius, were controlled by introducing a reinforcement learning agent to minimize the total scattering cross section (TSCS). The study employs a double deep Q-learning network (DDQN, (figure 10(b)) and a deep deterministic policy gradient algorithm and shows good design performance compared to state-of-the-art methods using traditional optimization 

13 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [385 x 177] intentionally omitted <==**

**Figure 10.** Deep reinforcement learning acoustic metamaterial design framework. Reproduced with permission from [73]. Copyright 2021, Acoustic Society of America. (a) reinforcement learning algorithm, interaction diagram between agent and environment; (b) Diagram of DDQN agent interacting with the environment by adjusting design parameters). 

algorithms. And then Shah and Amirkulova [74] proposed a general framework based on DRL for discovering optimal design of metamaterials by optimizing the design parameters including position, radius, and material to minimize the scattering effect. 

_4.2.3. Metamaterial structure optimization based on generative DL model._ Generative DL is an important branch of DL that aims to generate new data samples using neural network models. The goal of generative DL is to learn the probability distribution of the data so that new samples similar to the original data can be generated. In the case of AM structures, generative DL models are used to expand the training dataset of AMs. By generating new samples of AMs, it is possible to increase the diversity of the training data and improve the generalization ability and robustness of the model. 

Amirkulova _et al_ [75] proposed a method to approximate and minimize the acoustic wave scattering data driven in the design of a 2D acoustic cloak by combining a generative DL model and data optimization based on multiple scattering theory. In which a cylindrical structure is encoded as a potential vector by a generative DL model and random potential values are decoded to generate a new structure. By combining variational selfencoders, supervised learning, unsupervised learning and Gaussian processes, the optimal arrangement of scatterers at the minimum scattering cross-section is predicted. Gurbuz _et al_ [76] proposed a generative DL based approach for AMs design using CGAN. This model is illustrated in figure 11, where the cell is first discretized into a pixel-based binary image based on the stochastic generator algorithm to generate the data, which is then trained by the generator, while the CGAN is used to regulate the image generation process to make it reach the unit cell used for soundproofing purposes. In this way, by providing design instructions for AMs, the candidate cells are examined, optimized, and tailored to achieve the desired characteristics of sound insulation in the 

face of a small data set and without relying on the professional experience of experts. 

CGANs is one of the generative DL models that combines the concepts of GAN and conditionalization. CGAN introduces conditional information on top of GAN, which enables the generator to generate specific types of samples based on given conditions. In the optimization of AMs, CGAN can be used to generate metamaterial structures with specific acoustic properties. By inputting the acoustic properties as conditions to the generator, conditional adversarial networks can generate metamaterial structures that meet specific acoustic requirements. Lai _et al_ [77] proposed a method based on conditional Wasserstein GANs to simulate the TSCS of rigid cylindrical configurations by DL to minimize the twodimensional TSCS, thus achieving a reduced TSCS for cylindrical planar configurations with more efficient computational efficiency. The method innovatively combines WGANs with CNNs and achieves better simulation results by adding coordinate convolutional layers. 

_4.2.4. Metamaterial structure optimization based on other DL models._ In addition to the DL models mentioned above, there are other types of DL network models that are suitable for optimizing the structure of AMs. For instance, Wang _et al_ [78] proposed a probabilistic generative network model to reveal the implicit relationship between the structure and spectral response of AMs. This model was applied to the ondemand inverse design of acoustic absorbers. Peng _et al_ [79] proposed a ML approach to design lightweight AMs with specific acoustic isolation frequencies and bandwidths. They achieved a solution for low-frequency noise control by modeling the sound insulation and analyzing the influencing factors. Wang _et al_ [80] proposed a framework based on deep feature learning to design cellular metamaterials with specific bandgap widths and stiffnesses. The framework uses a generalized β-variable autoencoder to learn the potential space, 

14 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [385 x 258] intentionally omitted <==**

**Figure 11.** Generative deep learning AMs design framework. Reproduced from [76]. CC BY 4.0. (a) discrete cells into pixel-based binary images; (b) Schematic diagram of the training program; (c) Schematic diagram of the generator and discriminator with detailed information on the number of neurons. 

enabling unsupervised periodic cellular creative design and property-driven optimization. 

## _4.3. Prediction of AM properties based on ML_ 

ML algorithms can be used to build prediction models for predicting the acoustic structure, absorption coefficient, and acoustic isolation performance of new AMs by learning existing AMs design and performance data. By ML efficient and accurate predictive models, this provides effective design guidance for AMs design and helps accelerate AM design. 

The researchers use a flexible combination of various algorithmic network configurations to build models that meet prediction needs. It can solve the time problem of reverse design and improve the design efficiency and accuracy, and at the same time, it has good robustness and generalization, and can be extended to the design of different inputs and structures. Ding _et al_ [81] proposed a method to describe the inverse mechanism of nonlocal hypersurfaces using a DL algorithm (figure 12(a)) to achieve accurate control of sound propagation by learning the complex inverse aggregated coupling. For the complexity problem of aggregated coupling of all subunits in nonlocal hypersurfaces, the proposed method can efficiently predict multi-channel reflections and arbitrary energy ratios, while predicting the relative error is less than 1%. Ciaburro and Iannace [82] constructed a novel metamaterial by using a polyvinyl chloride film with buttons adhered to it, and accurately predicted the acoustic absorption coefficients of the newly designed metamaterials under a simulation 

model based on an artificial neural network (figure 12(b)), which was also used to carry out a sensitivity analysis and to evaluate the contribution of various input variables to the output. The model achieves accurate prediction and sensitivity analysis of the acoustic properties of AMs and provides a new approach to improve the design of sound insulation systems. Tran _et al_ [83] used a CNN model to simulate multiple scattering of acoustic waves in a cylindrical structure and trained it on data generated by multiple scattering theory. The results showed that the model was able to accurately predict the TSCS of the acoustic cylindrical structure and inverse design of the scatterer configurations was achieved by a convolutional self-encoder. Thang _et al_ [84] investigated and developed a new ML framework (figure 12(c)) for predicting optimal metastructures, such as planar configurations of a scatterer with a specific functionality, and designed cylindrical cylindrical considering the minimization of TSCS obstacle acoustic cloak, and predicting the optimal arrangement of scatterers for a given TSCS through an inverse design algorithm combining a variational self-coder and a Gaussian process. Ciaburro and Iannace [85] used a ML approach based on a regression tree prediction model (figure 12(d)) to predict the sound absorption coefficient of membrane AMs, and thus proposed an innovative membrane AMs in the field of sustainable building design. Material design method. Sun [86] investigated the sound insulation performance of membrane-type AMs using a factorweighted k-nearest neighbor classification method based on the hierarchical analysis method (AHP), which was able to predict different levels of sound insulation and achieved a classification accuracy of 98.2% in the experiments. Two deep 

15 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [385 x 227] intentionally omitted <==**

**Figure 12.** Design framework for machine learning algorithms to predict the performance of acoustic metamaterials. (a) Schematic diagram of data acquisition and series network. Reprinted figure with permission from [81], Copyright 2021 by the American Physical Society. (b) Design framework for predicting sound absorption performance based on artificial neural network. Reproduced with permission from [82]. Copyright 2021, Acoustic Society of America. (c) Design a predictive acoustic cylindrical structure framework based on the combination of VAE and supervised learning methods. Reproduced with permission from [84]. (d) Regression tree prediction model framework. Reprinted from [85], Copyright 2021, with permission from Elsevier. 

CNN models (TLCNN and PGCNN) embedded with physical knowledge were proposed by Wang _et al_ [87] for predicting phonon dispersion curves of Two-dimension phononic metamaterials (figure 13(a)). 

## _4.4. AM reverse design based on DL_ 

AM reverse design is a popular topic among researchers in this field, Dong _et al_ [90] proposed a systematic bottom-up inversedesign methodology for implementing ultra-broadband; Zhou _et al_ [91] proposed decoupled inverse design of hybrid metasurfaces based on the topology optimization. However, ML methods were not taken into consideration. 

ML algorithms not only predict performance but also enable on-demand reverse design with high degrees of freedom. This is particularly useful in AM design, where reverse engineering on demand can facilitate the development of materials with specific acoustic properties that may be challenging to achieve using traditional design methods. For instance, materials with a specific frequency band gap or the ability to transmit sound waves in a particular direction can be designed to meet industrial or research requirements. The use of ML, particularly DL, in the inverse design of AMs allows for a comprehensive understanding of complex acoustic behavior and the effective translation of this knowledge into practical material designs. 

Oddiraju _et al_ [92] proposed a framework for the inverse design of acoustic substructures using an invertible neural network (INN) for a meta material systems for on-demand 

retrieval reverse design. Frequency response modeling of periodic and non-periodic phononic structures was achieved by training an INN model that can forward predict high-fidelity samples and learning the inverse mapping with guaranteed reversibility. Zhang _et al_ ’s [88] team explored the application of ML in the inverse design of AMs by constructing a framework of forward and backward networks (figure 13(b)), taking the target sound absorption curve as an input and outputting a metamaterial structure that satisfies the absorption curve, and evaluating its performance through the forward network. The trained forward network is able to predict the performance of structures beyond the range of the training set with high accuracy and high generalization performance, while the inverse network is able to autonomously adopt the parameters of structures beyond the range for performance optimization. Using a DL approach, Hou _et al_ [89] designed a neural network for ondemand design of metamaterial structures (Figure 13(c)). The forward network takes the structural parameter as input and produces the wavelength-reflectance curve for both polarization directions as output. The reverse network, on the other hand, uses the input wavelength-refraction curve to predict the desired structure, significantly reducing the time required to solve the inverse problem. Yinggang _et al_ [93] proposed a DL-based method for intelligent prediction and design of AM bundles. The energy band structure and transport properties of acoustic ultramaterial bundles were calculated by the spectral element method, and a high degree of freedom design space dataset was constructed. A fully connected DL neural network model is utilized to predict the vibration transmission characteristics of the acoustic hypermaterial bundle, and on-demand 

16 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [385 x 278] intentionally omitted <==**

**Figure 13.** (a) Deep convolutional neural network models (TLCNN and PGCNN) used to predict phonon dispersion curves of two-dimensional phonon metamaterials. Reproduced from [87], with permission from Springer Nature. (b) Architecture of the inverse design framework. Reproduced from [88], with permission from Springer Nature. (c) In this figure, FNN refers to the forward neural network, and RNN refers to the reverse neural network. Reprinted figure with permission from [89], Copyright 2021 by the American Physical Society. 

reverse design is realized. Miao _et al_ [94] proposed a design for the inversion of megapixel holograms based on acoustic metasurfaces, assisted by DL, to reconstruct megapixel images. 

## **5. Application of ML algorithms in PnCs design** 

## _5.1. PnCs performance prediction based on ML_ 

PnCs is a periodic structure with special acoustic properties. The application of ML algorithms in PnCs design can help optimize the structure and performance of PnCs for acoustic wave control. Performance prediction of PnCs is one of the key problems in the design of acoustic AMs and PnCs, and ML-based methods provide new ways to solve this problem. ML algorithms are able to quickly and accurately predict the performance metrics of PnCs by learning the patterns therein from a large amount of data, providing useful guidance and optimization schemes for the design of PnCs. Predicting the performance of PnC using ML algorithms can greatly speed up the design process and provide a comprehensive evaluation of the properties of PnCs. 

_5.1.1. Predicting the dispersion relations of PnCs by ML._ In 

PnCs, the propagation of phonons is affected by Bragg scattering due to the periodic structure of the lattice. Bragg scattering is a phenomenon in which phonons are scattered by wave 

vectors with similar lattice constants in the periodic structure. This leads to the phenomenon of forbidden bands (energy band gaps, or BG) of phonons in the dispersion relation diagram. Forbidden bands are those frequency ranges that appear in the dispersion relation diagram where the propagation of phonons is hindered, which in turn results in the energy of the phonons not being able to propagate within the forbidden bands, resulting in anomalies in the localized modes of phonons or in the density of phonon states. Therefore, the dispersion relation diagram of a PnCs can demonstrate the existence and characteristics of the forbidden band, reflecting the propagation properties of phonons in the material and the effects of phonon-lattice interactions. Therefore, the prediction of accurate dispersion relations of PnCs is of great significance for the study and design of new PnCs materials. Liu and Yu [95] predicted the dispersion relation of one-dimensional PnCs using deep backpropagation neural network (DBP-NN) and RBF neural network (RBF-NN). Through training and testing, it is demonstrated that these two neural networks have good performance in predicting the DR of PnCs. For singleparameter prediction, the RBF-NN exhibits shorter training time and higher prediction accuracy, while the DBP-NN is more stable for two- and three-parameter prediction. This study verifies the feasibility of using neural networks to predict the DR of PnCs and provides a useful reference for the application of neural networks in PnCs and metamaterial design. The ML framework and experimental results are shown in figures 14(a)–(d): 

17 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [385 x 331] intentionally omitted <==**

**Figure 14.** Effect diagram of PnCs design framework and predicted dispersion relationship. (a) Deep backpropagation neural network (DBP-NN) design framework; (b) radial basis function neural network (RBF-NN) design framewor; (c) Single parameter prediction effect diagram corresponding to deep backpropagation neural network (c figure left) and radial basis function neural network (c figure right); (d) two-parameter prediction effect diagram corresponding to deep backpropagation neural network (d figure left) and radial basis function neural network (d figure right). Reproduced from [95], with permission from Springer Nature. (e) Proxy deep learning (DL) design framework; (f) Comparison of time spent on dispersion curve prediction by proxy DL model and time spent on dispersion curve Pawel-simulation by cnventional FEM finite element model. Reprinted from [96], Copyright 2023, with permission from Elsevier. 

Kudela _et al_ [96] is proposing a new approach based on an agent DL model for PnCs topology optimization, which consists of three main modules (figure 14(e)): dataset computation, supervised learning, and topology optimization; a large dataset of acoustic PnCs instances is obtained by using finite element method (FEM) computation; the dataset is then used for supervised training of the agent DL model. It learns the mapping between the input (cavity shape) and the output (dispersion map). The trained DL model is then used for ultrafast prediction of dispersion maps in a topology optimization framework based on GAs. As shown in figure 14(f), compared with the traditional FEM computation which takes 0.5–1.5 h, the trained DL model is able to predict the dispersion map with ultra-fast speed (10–100 ms), which can replace the traditional computationally-intensive dispersion map solver and be effectively used in the optimization framework. 

The dispersion relation map demonstrates the frequencywavevector relationship of the propagation of phonons in a PnCs, while the crystal bandgap corresponds to the frequency range of the forbidden band, indicating the region where the propagation of phonons is prohibited. The crystal bandgap is 

specific to the width and location of the forbidden band, i.e. the frequency range of phonon states that are not allowed in the forbidden band. Therefore, the crystal bandgap characteristics of PnCs crystals can also be directly predicted to achieve the design of the booster PnC. The data-driven approach to PnCs crystal design proposed by Li _et al_ [97] is a combination of image processing, finite element analysis, and DL modeling (The model is illustrated in figure 15). The relationship between the band gap and topological features was established by training an autoencoder to extract topological features and using finite element analysis to calculate the band gap. By this method, PnCs with expected bandgap was successfully designed. In contrast, Sadat and Wang [98] explored the ability of three different ML algorithms (logistic/linear regression, artificial neural networks, and random forests) to rapidly screen PnCs structures with phonon bandgaps and predict the center frequency and width of the bandgap, and found that random forests performed best overall. The accuracy of selecting PnCs with bandgaps was successfully improved when combined with the Random Forest model for rapid screening. The model for predicting the center frequency and width of the 

18 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [385 x 296] intentionally omitted <==**

**Figure 15.** Deep learning framework and prediction effect diagram. Reprinted from [97], Copyright 2019, with permission from Elsevier. (a) deep learning design framework diagram; (b) Topology corresponding to some generated samples and corresponding test samples; (c) Distribution of cross-validation errors and test errors. 

bandgap performed well (see figure 16), especially when a bandgap was known to exist. 

_5.1.2. Predicting the band structure of PnCs by ML._ In addition to being able to predict the dispersion relation and crystal band gap of a PnCs, ML can also predict the energy band structure of a PnC. The energy band structure can provide detailed information about the propagation properties of PnC in a PnC, including information about forbidden bands, bandgap characteristics, and so on. In some ways, the prediction of the energy band structure is more difficult than the prediction of the dispersion relation, the crystal band gap. Javadi _et al_ [99] used a data-driven approach to predict the energy band structure of thermoelastic waves in a beam of nanophonic PnCs, which provided a numerical framework for the classification of the bandgap and the fast prediction of PnCs properties using preprocessing methods, hyper-parameter optimization, and shallow and DNNs. Han _et al_ [100] used a DL framework combining GANs and CNNs to predict and inverse design the energy band structure of PnCs crystals. The energy band structures of PnCs were predicted by training a CNN and inverse-designed by connecting a generator to the CNN. The complex energy band structures were also calculated using the periodic spectral FEM to screen out topologies with large spatial attenuation. The optimized PnCs topologies with expected band gaps with sound and vibration isolation potential are finally obtained. 

## _5.2. Inverse design and topology optimization of PnCs based on ML_ 

ML algorithms can be used for the inverse design of PnCs. Inverse design of PnCs refers to the reverse design of a PnCs structure with specific energy band structure and topological features based on desired acoustic properties and functional requirements by means of optimization algorithms and ML methods. This inverse design methodology has important application potential in the field of AMs and PnCs. ML algorithms play a key role in the inverse design of PnCs, which are able to search and optimize PnCs structures quickly and efficiently by learning a large amount of data and patterns. 

Liu _et al_ [101] implemented an intelligent inverse design of one-dimensional PnCs using supervised neural network (SNN) and unsupervised neural network (U-NN). By designing structural parameters, such as filling ratio, shear modulus ratio and mass density ratio, S-NN and U-NN are able to efficiently and accurately meet the target band gap requirements. For single-parameter or two-parameter design, both neural networks show excellent performance and robustness, while U- NN performs better in three-parameter design, as shown in figure 17. Compared with traditional GAs, the neural networks have faster computational speeds and design accuracy can be ensured by proper neural network model construction. Miao _et al_ [102] proposed a robust DL method combining a DNN and a GA for the reverse design of two-dimensional PnCs for dispersion engineering. The forward prediction process is 

19 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [385 x 220] intentionally omitted <==**

**Figure 16.** Prediction renderings of logical/linear regression, artificial neural network, and random forest with known bandgaps. Reprinted from [98], with the permission of AIP Publishing. (Linear regression (a) and (b), artificial neural network (c) and (d), and random forest (e) and (f) machine learning models against bandgap centers (a), (c) and (c) Forecast results of (e) and width (b), (d) and (f). 

**==> picture [385 x 179] intentionally omitted <==**

**Figure 17.** Effect diagram of intelligent reverse design of one-dimensional PnC realized by supervised neural network (S-NN) and unsupervised neural network (U-NN). Reprinted from [101], with the permission of AIP Publishing. (a) Human supervised neural network (S-NN) design frame diagram; (b) unsupervised neural network (U-NN) design frame diagram; (c) single-parameter two neural network design renderings; (d) two-parameter two neural network design renderings; (e) three-parameter two neural network design renderings. 

realized by predicting the energy band boundaries of PnCs through a high-precision DNN model, and combined with GA for reverse design. The framework is capable of generating desired PnCs with expected bandgap boundaries in seconds, demonstrating efficient and accurate performance. 

Luo _et al_ [103] applied the Q-learning algorithm to the inverse design of the energy band structure of layered PnCs, demonstrating the promising application of reinforcement learning in mechanical design (The model is illustrated in figure 18(a)). Taking two examples of task objectives of maximizing the first-order bandgap width and achieving a specific bandgap range for different goals, the Q-learning algorithm with a changing objective function is applied to find the inverse design of mechanical problems, and intelligent 

PnCs crystal design is achieved by the reinforcement learning approach. It is found that the interactive inverse design method can be applied to PnCs design problems with different demand scenarios by defining different states, actions and rewards with high efficiency and stability. Unlike Luo, Maghami and Hosseini [104] proposed a DRL-based methodology (figure 18(b)), this study applied DRL to the inverse design of PnCs for the realization of the desired energy band structure; which was used for the inverse design of layered PnCs beams, focusing on the analysis of the energy band structure of the propagation of thermoelastic waves. The methodology allows the user to immediately generate design parameters from trained agents without unnecessary searching. 

20 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

**==> picture [385 x 164] intentionally omitted <==**

**Figure 18.** Design framework diagram for reinforcement learning. (a) reinforcement learning framework for layered PnCs. Reprinted from [103], Copyright 2020, with permission from Elsevier. (b) overview diagram of the design process for deep reinforcement learning for PnCs. Reprinted from [104], Copyright 2022, with permission from Elsevier. 

In addition to this, other different types of combinations of DL methods and ML algorithms can be used to realize the precise manipulation and reverse design of PnCs structures. For example, Leilei _et al_ [105] proposed a softmax logistic regression and multitask learning based PnC inverse design method to realize the precise manipulation of acoustic and elastic waves of PnCs through artificial neural networks. The method transforms the PnCs inverse design problem into a multicomponent material classification problem, and the trained neural network is used to rapidly design a PnCs structure with a target bandgap. Liangshu _et al_ [106] on the other hand, tackled the challenge of fast and inverse exploration of geometries through two different ML approaches to inverse design schemes. One uses reinforcement learning algorithms to efficiently and inversely design the structural parameters to maximize the bandgap width. The other one solves the problem of training difficulty due to data inconsistency by means of a tandem architecture neural network and successfully accomplishes the task of inverse structural design with target topological properties. Han _et al_ [107] used a joint framework combining a data-driven DL model and a semi-analytical two-dimensional periodic-spectral finite-element method to achieve the inverse design of a PnC topology with dominant superconformal waveforms by training CNNs and GANs. Properties of the inverse design and optimization of PnCs topologies. A DL-based inverse design framework for defective PnCs as narrow band pass filters was proposed by Lee _et al_ [108]. By comparing four DL models (DNN, tandem neural network, conditional variational self-encoder, and CGAN), it was concluded that the framework using conditional variational self-encoder and CGAN can be used to achieve design optimization by probabilistic methods to maximize the transmittance at the target frequency. This framework simplifies the inverse design process by providing an automated and efficient approach and finding the optimal design solution. 

All of the above can show that ML methods have great potential in the inverse design of PnCs. They provide automated, efficient and solutions to complex challenges and offer 

new ways for precise control and optimization of PnCs structures. These studies are important for advancing the development and applications in the field of PnCs. 

## **6. Advantages and challenges of ML algorithms** 

## _6.1. Advantages_ 

- (1) Efficiency and fast design: traditional AMs and PnCs design methods usually require a lot of time and computational resources, such as searching a huge parameter space to find the best structure and performance, which depends on the experience of researchers and the time cost of continuous trial and error. In addition, the design of AMs and PnCs involves multiple parameters, such as geometry, material properties and structural arrangement, which will also consume a lot of time. In contrast, ML algorithms are able to quickly predict metamaterial properties and find the best design by training models. This efficiency makes the design process considerably faster, thus saving time and resources. ML can speed up the exploration process and help find more effective design solutions through efficient search and optimization methods. 

- (2) Nonlinear problem solving: the design and optimization of AMs and PnCs often involve complex nonlinear problems. Traditional design methods may not be able to deal with these nonlinear relationships effectively. And ML algorithms with powerful nonlinear modeling and prediction capabilities can better solve these complex problems. 

- (3) Data-driven design: ML algorithms are based on data for learning and optimization, and are able to learn patterns and laws from a large amount of acoustic data. This datadriven design approach can help discover hidden associations and features in AMs and PnCs for more accurate design and optimization. 

- (4) Multi-disciplinary cross-applications: the design and optimization of acoustic AMs and PnCs involves knowledge from multiple fields, such as physics, materials science and engineering. ML algorithms have a wide range 

21 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

of application areas and can combine knowledge and technology from different fields to provide comprehensive and integrated solutions for acoustic material design. 

## _6.2. Challenges_ 

- (1) Data requirements and quality: the performance of ML algorithms relies heavily on the quality and quantity of input data. In AMs and PnCs design, obtaining highquality data may be difficult and the amount of data may be relatively limited. Therefore, it is a challenge to efficiently acquire and process suitable training data. 

- (2) Model selection and tuning: there are numerous model and algorithm choices in ML algorithms, and how to select appropriate model structures and parameter settings is a key issue. In addition, for complex acoustic design problems, the model tuning and training process can be very complex and time-consuming. 

- (3) Explanatory and interpretable: ML algorithms are usually presented in the form of black-box models, whose internal decision-making process and result interpretation may lack interpretability. In AMs and PnCs design, interpretability and explainability are crucial for understanding the rationality of the design results and optimization process. Therefore, it is a challenge to improve the interpretability of ML algorithms. 

- (4) Domain knowledge fusion: AMs and PnCs design involves knowledge and expertise from multiple domains. ML algorithms need to be able to effectively fuse these domain knowledge and incorporate them into the design process. It is a challenge to realize the effective fusion and application of domain knowledge. 

## _6.3. Potential solutions_ 

To address the challenges of ML algorithms in the design of AMs and PnCs, researchers can consider the following Potential solutions: 

- (1) One of the main challenges in the application of ML in the design of AMs and PnCs is the availability of highquality data sets and the limitations in the amount of data. To effectively address this challenge, data enhancement techniques such as random transformations, noise injection, and feature interpolation can be employed to artificially increase the diversity and size of the dataset. As well as generating algorithms to create additional synthetic data, they are able to efficiently scale high-quality training datasets. For situations where the amount of data is limited, transfer learning and small sample learning (such as fee-shot learning or meta-learning) techniques will likely be key solutions, enabling models to quickly learn new concepts from limited data. The implementation of these integrated strategies will help overcome data-related challenges and improve the effectiveness and accuracy of ML models in the design of AMs and PnCs. 

- (2) Automatic model selection and tuning: To face the challenges of model selection and tuning, the following comprehensive strategies can be adopted: first, based on the characteristics of the data and the complexity of the problem, exploratory data analysis is used to guide the appropriate model selection, such as DL models for nonlinear and high-dimensional data, while SVM or decision trees may be more suitable for small-scale or less featuresbased data sets. Secondly, hyperparameter optimization techniques such as grid search and random search are used to evaluate the model performance in combination with k-fold cross-validation to ensure the stability and generalization ability of the model on different data subsets. In complex tasks, ensemble learning methods and multimodel fusion strategies can be used to take advantage of each model to improve generalization ability and robustness. For dynamically changing datasets, online learning methods can be considered to adapt to new data, and the model is regularly tested for adaptability to ensure its continued performance. Through the comprehensive application of these methods, the problems of model selection and optimization in the design of AMs and PnCs can be effectively solved, and the accuracy and efficiency of the design can be improved. 

- (3) Interpretability and Improving Interpretability: to solve this problem, first choose a ML model with natural interpretability, such as decision trees or linear regression models. These models are easy to interpret due to their simple and intuitive decision-making process. Second, for complex models such as DNNs, posterior interpretation techniques such as locally interpretable model-opaque box interpretation (LIME) or integrated gradients can be used. These techniques provide insight into a model’s decisionmaking process by analyzing its response to specific inputs. In addition, it is an effective strategy to implement model visualizations, such as activation maps or attention mechanism visualizations, to show which parts of the data the model focuses on when making decisions. Model training methods with interpretability constraints, such as regularization techniques, can also be used to limit model complexity and improve its interpretability. By applying these methods in combination, it is possible to improve the interpretability of models in the design of AMs and PnCs while maintaining their performance, thus providing researchers and engineers with a more transparent and understandable model decision process. 

- (4) Cross-domain collaboration and knowledge sharing platform: to solve the problem of domain knowledge fusion, first, it should emphasize the establishment of multidisciplinary teams, including experts in physics, acoustics, materials science, and computer science in the research team, so as to facilitate the understanding and solution of problems from different perspectives. In addition, the development and use of interdisciplinary data sets is another effective strategy; by integrating data from different fields, the model can learn a wider range of knowledge, thus improving the accuracy and innovation of the design. In practice, expert systems can also be used to 

22 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

aid the decision-making process by incorporating expert insights and experience into model design and training to enhance the usefulness and effectiveness of models. Through the integrated application of these methods, it is possible to effectively integrate ML models with knowledge in the field of AMs and PnC design, thus fully realizing the potential of ML in this field. 

In summary, the ML algorithm has several advantages, including high efficiency, strong nonlinear problem-solving ability, data-driven design, and cross-application in the design of AMs and PNCs. To address the challenges at hand, this text suggests potential solutions such as expanding data sets through data enhancement techniques, automating model selection and tuning methods, exploring ML models with high interpretability, and establishing platforms for crossdomain collaboration and knowledge sharing. In the future, AMs and PnC designs may be developed using ML to adjust their acoustic properties in real-time in response to environmental changes or specific needs. This adaptive and dynamic metamaterial will utilize ML algorithms to predict and respond to environmental changes, such as automatically reducing noise pollution or optimizing building acoustics. At the same time, metamaterials combined with ML have the potential to develop highly sensitive and precise intelligent acoustic imaging and sensing systems. These systems could find applications in medical diagnostics, industrial inspection, or security monitoring. 

## **7. Conclusion** 

The past several years have seen an increasing amount of research on the application of ML algorithms in the design of AMs and PnCs. Through ML algorithms, researchers can utilize a large amount of data for the rapid design and optimization of AMs and PnCs, thereby improving design efficiency and performance. In the design of AMs and PnCs, ML algorithms can learn the mapping relationship between input and output, enabling prediction and optimization of metamaterial performance. Simultaneously, ML algorithms can also be used to solve inverse design problems, that is, given the desired performance, find the design of metamaterials and crystals that achieve these performances. We have reviewed recent research on ML techniques, however, this is an active area of research with much more to be learned and a significant step in AMs and PnCs research. Finally, the paper summarizes the advantages, current challenges and potential solutions of applying ML to the design of AMs and PnCs. 

## **Data availability statement** 

The data cannot be made publicly available upon publication because no suitable repository exists for hosting data in this field of study. The data that support the findings of this study are available upon reasonable request from the authors. 

## **Acknowledgments** 

This work was supported by the National Natural Science of China (Grant No. 51805277), the Guangdong Basic and Applied Basic Research Foundation (2022A1515140044) and the Research Foundation of Universities of Guangdong Province (2021KCXTD083). 

## **ORCID iDs** 

Jianquan Chen  https://orcid.org/0009-0000-0585-9269 Jiahan Huang  https://orcid.org/0009-0008-4896-8877 

## **References** 

- [1] Liu Z _et al_ 2000 Locally resonant sonic materials _Science_ **289** 1734–6 

- [2] Kovacevich D A and Popa B-I 2022 Programmable bulk modulus in acoustic metamaterials composed of strongly interacting active cells _Appl. Phys. Lett._ **121** 101701 

- [3] Hao L, Li Y, Yan X, Yang X, Guo X, Xie Y, Pang S, Chen Z and Zhu W 2022 Tri-band negative modulus acoustic metamaterial with nested split hollow spheres _Front. Mater._ **9** 909671 

- [4] Dong H-W, Zhao S-D, Wang Y-S, Cheng L and Zhang C 2020 Robust 2D/3D multi-polar acoustic metamaterials with broadband double negativity _J. Mech. Phys. Solids_ **137** 103889 

- [5] Li Z and Wang X 2021 Wave propagation in a dual-periodic elastic metamaterial with multiple resonators _Appl. Acoust._ **172** 107582 

- [6] Gao Y and Wang L 2022 Active multifunctional composite metamaterials with negative effective mass density and negative effective modulus _Compos. Struct._ **291** 115586 

- [7] Huang H, Huo S and Chen J 2021 Subwavelength elastic topological negative refraction in ternary locally resonant phononic crystals _Int. J. Mech. Sci._ **198** 106391 

- [8] Cai Z, Zhao S, Huang Z, Li Z, Su M, Zhang Z, Zhao Z and Song Y 2022 Negative refraction acoustic lens based on elastic shell encapsulated bubbles _Adv. Mater. Technol._ **7** 2101186 

- [9] Song Y and Shen Y 2021 A tunable phononic crystal system for elastic ultrasonic wave control _Appl. Phys. Lett._ **118** 224104 

- [10] Gao N, Zhang Z, Deng J, Guo X, Cheng B and Hou H 2022 Acoustic metamaterials for noise reduction: a review _Adv. Mater. Technol._ **7** 2100698 

- [11] Fan S-W, Zhao S-D, Cao L, Zhu Y, Chen A-L, Wang Y-F, Donda K, Wang Y-S and Assouar B 2020 Reconfigurable curved metasurface for acoustic cloaking and illusion _Phys. Rev._ B **101** 024104 

- [12] Ahmed W W, Farhat M, Zhang X and Wu Y 2021 Deterministic and probabilistic deep learning models for inverse design of broadband acoustic cloak _Phys. Rev. Res._ **3** 013142 

- [13] Zaremanesh M and Bahrami A 2023 Two-dimensional honeycomb lattice structure for underwater acoustic cloaking using pentamode materials _Phys. Scr._ **99** 015946 

- [14] Craig S R, Welch P J and Shi C 2020 Non-Hermitian complementary acoustic metamaterials for imaging through skull with imperfections _Front. Mech. Eng._ **6** 55 

- [15] Fuyin M and Zimmerman N M 2022 Acoustic focusing and imaging via phononic crystal and acoustic metamaterials _J. Appl. Phys._ **131** 205102 

- [16] Zuo G, Huang Z and Ma F 2023 A tunable sub-wavelength acoustic imaging planar metalens _J. Appl. Phys._ **56** 145401 

23 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

- [17] Kushwaha M S, Halevi P, Dobrzynski L and 

   - Djafari-Rouhani B 1993 Acoustic band structure of periodic elastic composites _Phys. Rev. Lett._ **71** 2022–5 

- [18] Martínez-Sala R, Sancho J, Sánchez J V, Gómez V, Llinares J and Meseguer F 1995 Sound attenuation by sculpture _Nature_ **378** 241 

- [19] Li J and Chan C T 2004 Double-negative acoustic metamaterial _Phys. Rev._ E **70** 055602 

- [20] Liao G, Wang Z, Luan C, Liu J, Yao X and Fu J 2021 Broadband controllable acoustic focusing and asymmetric focusing by acoustic metamaterials _Smart Mater. Struct._ **30** 045021 

- [21] Pan H, Ding X, Qiao H, Huang W, Xiao J and Zhang Y 2023 Metamaterial-based acoustic enhanced sensing for gearbox weak fault feature diagnosis _Smart Mater. Struct._ **32** 105034 

- [22] Chen A, Yang Z, Zhao X, Anderson S and Zhang X 2023 Composite acoustic metamaterial for broadband low-frequency acoustic attenuation _Phys. Rev. Appl._ **20** 014011 

- [23] Ruan H, Yu P, Hou J and Li D 2024 Low-frequency band gap design of acoustic metamaterial based on cochlear structure _Smart Mater. Struct._ **33** 025017 

- [24] Ma T-X, Li Z-Y, Zhang C and Wang Y-S 2022 Energy harvesting of Rayleigh surface waves by a phononic crystal Luneburg lens _Int. J. Mech. Sci._ **227** 107435 

- [25] Motaei F and Bahrami A 2022 Energy harvesting from sonic noises by phononic crystal fibers _Sci. Rep._ **12** 10522 

- [26] Xiao H, Tan T, Li T, Zhang L, Yuan C and Yan Z 2023 Enhanced multi-band acoustic energy harvesting using double defect modes of Helmholtz resonant metamaterial _Smart Mater. Struct._ **32** 105030 

- [27] Li B, Chen H, Xia B and Yao L 2023 Acoustic energy harvesting based on topological states of multi-resonant phononic crystals _Appl. Energy_ **341** 121142 

- [28] Zhou H-T, Fan S-W, Li X-S, Fu W-X, Wang Y-F and Wang Y-S 2020 Tunable arc-shaped acoustic metasurface carpet cloak _Smart Mater. Struct._ **29** 065016 

- [29] Chen P, Haberman M R and Ghattas O 2021 Optimal design of acoustic metamaterial cloaks under uncertainty _J. Comput. Phys._ **431** 110114 

- [30] Yang R, Zhang X and Wang G 2022 A hybrid acoustic cloaking based on binary splitting metasurfaces and near-zero-index metamaterials _Appl. Phys. Lett._ **120** 021603 

- [31] Xiao Y, Wen J and Wen X 2012 Flexural wave band gaps in locally resonant thin plates with periodically attached spring–mass resonators _J. Phys. D: Appl. Phys._ **45** 195401 

- [32] Nouh M, Aldraihem O and Baz A 2015 Wave propagation in metamaterial plates with periodic local resonances _J. Sound Vib._ **341** 53–73 

- [33] Xi-Xi Z _et al_ 2016 Flexural wave band gaps and vibration reduction properties of a locally resonant stiffened plate _Acta Phys. Sin._ **65** 176202 

- [34] Jian W _et al_ 2016 Low frequency band gaps and vibration reduction properties of a multi-frequency locally resonant phononic plate _Acta Phys. Sin._ **65** 064602 

- [35] Mei J, Ma G, Yang M, Yang Z, Wen W and Sheng P 2012 Dark acoustic metamaterials as super absorbers for low-frequency sound _Nat. Commun._ **3** 756 

- [36] Zi-Hou H _et al_ 2019 Sound insulation performance of thin-film acoustic metamaterials based on piezoelectric materials _Acta Phys. Sin._ **68** 134302 

- [37] Zhou G, Wu J H, Lu K, Tian X, Huang W and Zhu K 2020 Broadband low-frequency membrane-type acoustic metamaterials with multi-state anti-resonances _Appl. Acoust._ **159** 107078 

- [38] Jang J-Y, Park C-S and Song K 2022 Lightweight soundproofing membrane acoustic metamaterial for 

broadband sound insulation _Mech. Syst. Signal Process._ **178** 109270 

- [39] Fang N, Xi D, Xu J, Ambati M, Srituravanich W, Sun C and Zhang X 2006 Ultrasonic metamaterials with negative modulus _Nat. Mater._ **5** 452–6 

- [40] Duan M, Yu C, Xin F and Lu T J 2021 Tunable underwater acoustic metamaterials via quasi-Helmholtz resonance: from low-frequency to ultra-broadband _Appl. Phys. Lett._ **118** 071904 

- [41] Yang X, Yang F, Shen X, Wang E, Zhang X, Shen C and Peng W 2022 Development of adjustable parallel Helmholtz acoustic metamaterial for broad low-frequency sound absorption band _Materials_ **15** 5938 

- [42] Yang X, Shen X, Yang F, Yin Z, Yang F, Yang Q, Shen C, Xu M and Wan J 2023 Acoustic metamaterials of modular nested Helmholtz resonators with multiple tunable absorption peaks _Appl. Acoust._ **213** 109647 

- [43] Liang Z and Li J 2012 Extreme acoustic metamaterial by coiling up space _Phys. Rev. Lett._ **108** 114301 

- [44] Xie Y, Konneker A, Popa B-I and Cummer S A 2013 Tapered labyrinthine acoustic metamaterials for broadband impedance matching _Appl. Phys. Lett._ **103** 201906 

- [45] Almeida G D, Vergara E F, Barbosa L R and Brum R 2021 Low-frequency sound absorption of a metamaterial with symmetrical-coiled-up spaces _Appl. Acoust._ **172** 107593 

- [46] Xiang L, Wang G and Zhu C 2022 Controlling sound transmission by space-coiling fractal acoustic metamaterials with broadband on the subwavelength scale _Appl. Acoust._ **188** 108585 

- [47] Lee S H, Park C M, Seo Y M, Wang Z G and Kim C K 2010 Composite acoustic medium with simultaneously negative density and modulus _Phys. Rev. Lett._ **104** 054301 

- [48] Fok L and Zhang X 2011 Negative acoustic index metamaterial _Phys. Rev._ B **83** 214304 

- [49] Fei W _et al_ 2019 Low-frequency sound absorption of hybrid absorber based on micro-perforated panel and coiled-up channels _Appl. Phys. Lett._ **114** 151901 

- [50] Xie S, Wang D, Feng Z and Yang S 2020 Sound absorption performance of microperforated honeycomb metasurface panels with a combination of multiple orifice diameters _Appl. Acoust._ **158** 107046 

- [51] Hannun A _et al_ 2014 Deep speech: scaling up end-to-end speech recognition (arXiv:1412.5567) 

- [52] Kaiming H _et al_ 2016 Deep residual learning for image recognition _Proc. IEEE Conf. on Computer Vision and Pattern Recognition_ 

- [53] Devlin J _et al_ 2018 Bert: pre-training of deep bidirectional transformers for language understanding (arXiv:1810.04805) 

- [54] Sirignano J, Sadhwani A and Giesecke K 2016 Deep learning for mortgage risk (arXiv:1607.02470) 

- [55] Miotto R, Wang F, Wang S, Jiang X and Dudley J T 2018 Deep learning for healthcare: review, opportunities and challenges _Brief. Bioinform._ **19** 1236–46 

- [56] Dong H-W, Zhao S-D, Wei P, Cheng L, Wang Y-S and Zhang C 2019 Systematic design and realization of double-negative acoustic metamaterials by topology optimization _Acta Mater._ **172** 102–20 

- [57] Robeck C, Cipolla J and Kelly A 2019 Convolutional neural network driven design optimization of acoustic metamaterial microstructures _J. Acoust. Soc. Am._ **146** 2830 

- [58] Zheng B, Yang J, Liang B and Cheng J-C 2020 Inverse design of acoustic metamaterials based on machine learning using a Gauss–Bayesian model _J. Appl. Phys._ **128** 134902 

- [59] Chen A _et al_ 2022 Machine learning-assisted low-frequency and broadband sound absorber with coherently coupled weak resonances _Appl. Phys. Lett._ **120** 033501 

- [60] Bacigalupo A _et al_ 2016 Design of acoustic metamaterials through nonlinear programming _Machine Learning,_ 

24 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

_Optimization, and Big Data: Second International Workshop, MOD 2016, (Volterra, Italy, August 26–29 August 2016)_ (Springer International Publishing) 

- [61] Bacigalupo A, Gnecco G, Lepidi M and Gambarotta L 2020 Machine-learning techniques for the optimal design of acoustic metamaterials _J. Optim. Theory Appl._ **187** 630–53 

- [62] Wu R-T, Liu T-W, Jahanshahi M R and Semperlotti F 2021 Design of one-dimensional acoustic metamaterials using machine learning and cell concatenation _Struct. Multidiscip. Optim._ **63** 2399–423 

- [63] Wiest T _et al_ 2022 Efficient design of acoustic metamaterials with design domains of variable size using graph neural networks _Volume 3A: 48th Design Automation Conf. (DAC)_ 

- [64] Semenov N S _et al_ 2022 Application of machine learning technology to optimize the structure of two-dimensional metamaterials based on the spectrum of natural frequencies _AIP Conf. Proc._ **2533** 020039 

- [65] Baali H, Addouche M, Bouzerdoum A and Khelif A 2023 Design of acoustic absorbing metasurfaces using a data-driven approach _Commun. Mater._ **4** 40 

- [66] Cheng B, Wang M, Gao N and Hou H 2022 Machine learning inversion design and application verification of a broadband acoustic filtering structure _Appl. Acoust._ **187** 108522 

- [67] Liu T-W, Chan C-T and Wu R-T 2023 Deep-learning-based acoustic metamaterial design for attenuating structure-borne noise in auditory frequency bands _Materials_ **16** 1879 

- [68] Du Z and Mei J 2023 Wide-angle and high-efficiency acoustic retroreflectors enabled by many-objective optimization algorithm and deep learning models _Phys. Rev. Mater._ **7** 115201 

- [69] Donda K, Zhu Y, Merkel A, Fan S-W, Cao L, Wan S and Assouar B 2021 Ultrathin acoustic absorbing metasurface based on deep learning approach _Smart Mater. Struct._ **30** 085003 

- [70] Zhao T, Li Y, Zuo L and Zhang K 2021 Machine-learning optimized method for regional control of sound fields _Extreme Mech. Lett._ **45** 101297 

- [71] Liu L, Xie L-X, Huang W, Zhang X J, Lu M-H and Chen Y-F 2022 Broadband acoustic absorbing metamaterial via deep learning approach _Appl. Phys. Lett._ **120** 251701 

- [72] Wu J, Feng X, Cai X, Huang X and Zhou Q 2023 A deep learning-based multi-fidelity optimization method for the design of acoustic metasurface _Eng. Comput._ **39** 3421–39 

- [73] Shah T, Zhuo L, Lai P, De La Rosa-Moreno A, Amirkulova F and Gerstoft P 2021 Reinforcement learning applied to metamaterial design _J. Acoust. Soc. Am._ **150** 321–38 

- [74] Shah T A and Amirkulova F 2022 Deep reinforcement learning-based framework for the design of broadband acoustic metamaterials _J. Acoust. Soc. Am._ **152** A170 

- [75] Amirkulova F, Tran T and Khatami E 2021 Generative deep learning model for broadband acoustic metamaterial design _J. Acoust. Soc. Am._ **150** A209 

- [76] Gurbuz C, Kronowetter F, Dietz C, Eser M, Schmid J and Marburg S 2021 Generative adversarial networks for the design of acoustic metamaterials _J. Acoust. Soc. Am._ **149** 1162–74 

- [77] Lai P, Amirkulova F and Gerstoft P 2021 Conditional Wasserstein generative adversarial networks applied to acoustic metamaterial design _J. Acoust. Soc. Am._ **150** 4362 

- [78] Wang Z-W _et al_ 2023 On-demand inverse design of acoustic metamaterials using probabilistic generation network _Sci. China Phys. Mech. Astron._ **66** 224311 

- [79] Peng W, Zhang J, Shi M, Li J and Guo S 2023 Low-frequency sound insulation optimisation design of 

membrane-type acoustic metamaterials based on Kriging surrogate model _Mater. Des._ **225** 111491 

- [80] Wang Z, Xian W, Baccouche M R, Lanzerath H, Li Y and Xu H 2022 Design of phononic bandgap metamaterials based on Gaussian mixture beta variational autoencoder and iterative model updating _ASME J. Mech. Des._ **144** 041705 

- [81] Ding H, Fang X, Jia B, Wang N, Cheng Q and Li Y 2021 Deep learning enables accurate sound redistribution via nonlocal metasurfaces _Phys. Rev. Appl._ **16** 064035 

- [82] Ciaburro G and Iannace G 2021 Modeling acoustic metamaterials based on reused buttons using data fitting with neural network _J. Acoust. Soc. Am._ **150** 51–63 

- [83] Tran T, Khatami E and Amirkulova F 2021 Total multiple scattering cross section evaluation using convolutional neural networks for forward and inverse designs of acoustic metamaterials _J. Acoust. Soc. Am._ **149** A129 

- [84] Thang T, Amirkulova F A and Khatami E 2022 Broadband acoustic metamaterial design via machine learning _J. Theor. Comput. Acoust._ **30** 2240005 

- [85] Ciaburro G and Iannace G 2022 Membrane-type acoustic metamaterial using cork sheets and attached masses based on reused materials _Appl. Acoust._ **189** 108605 

- [86] Sun Y 2022 The prediction and analysis of acoustic metamaterial based on machine learning _Int. J. Artif. Intell. Tools_ **31** 2240003:1–2240003:16 

- [87] Wang Z, Xian W, Li Y and Xu H 2023 Embedding physical knowledge in deep neural networks for predicting the phonon dispersion curves of cellular metamaterials _Comput. Mech._ **72** 221–39 

- [88] Zhang H, Liu J, Ma W, Yang H, Wang Y, Yang H, Zhao H, Yu D and Wen J 2023 Learning to inversely design acoustic metamaterials for enhanced performance _Acta Mech. Sin._ **39** 722426 

- [89] Hou Z, Tang T, Shen J, Li C and Li F 2020 Prediction network of metamaterial with split ring resonator based on deep learning _Nanoscale Res. Lett._ **15** 1–8 

- [90] Dong H-W, Shen C, Zhao S-D, Qiu W, Zheng H, Zhang C, Cummer S A, Wang Y-S, Fang D and Cheng L 2022 Achromatic metasurfaces by dispersion customization for ultra-broadband acoustic beam engineering _Natl Sci. Rev._ **9** nwac030 

- [91] Zhou H-T, Zhang S-C, Zhu T, Tian Y-Z, Wang Y-F and Wang Y-S 2023 Hybrid metasurfaces for perfect transmission and customized manipulation of sound across water–air interface _Adv. Sci._ **10** 2207181 

- [92] Oddiraju M, Behjat A, Nouh M and Chowdhury S 2022 Inverse design framework with invertible neural networks for passive vibration suppression in phononic structures _J. Mech. Des._ **144** 021707 

- [93] Yinggang L _et al_ 2023 Vibration transmission characteristic prediction and structure inverse design of acoustic metamaterial beams based on deep learning _J. Vib. Control_ **30** 807–21 

- [94] Miao X-B, Dong H-W, Zhao S-D, Fan S-W, Huang G, Shen C and Wang Y-S 2023 Deep-learning-aided metasurface design for megapixel acoustic hologram _Appl. Phys. Rev._ **10** 021411 

- [95] Liu C-X and Yu G-L 2019 Predicting the dispersion relations of one-dimensional phononic crystals by neural networks _Sci. Rep._ **9** 15322 

- [96] Kudela P, Ijjeh A, Radzienski M, Miniaci M, Pugno N and Ostachowicz W 2023 Deep learning aided topology optimization of phononic crystals _Mech. Syst. Signal Process._ **200** 110636 

- [97] Li X, Ning S, Liu Z, Yan Z, Luo C and Zhuang Z 2020 Designing phononic crystal with anticipated band gap through a deep learning based data-driven method 

25 

Smart Mater. Struct. **33** (2024) 073001 

Topical Review 

_Comput. Methods Appl. Mech. Eng._ **361** 112737 

- [98] Sadat S M and Wang R Y 2020 A machine learning based approach for phononic crystal property discovery _J. Appl. Phys._ **128** 025106 

- [99] Javadi S, Maghami A and Mahmoud Hosseini S 2022 A deep learning approach based on a data-driven tool for classification and prediction of thermoelastic wave’s band structures for phononic crystals _Mech. Adv. Mat. Struct._ **29** 6612–25 

- [100] Han S, Han Q and Li C 2022 Deep-learning-based inverse design of phononic crystals for anticipated wave attenuation _J. Appl. Phys._ **132** 154901 

- [101] Liu C-X _et al_ 2019 Neural networks for inverse design of phononic crystals _AIP Adv._ **9** 085223 

- [102] Miao X-B, Dong H W and Wang Y-S 2023 Deep learning of dispersion engineering in two-dimensional phononic crystals _Eng. Optim._ **55** 125–39 

- [103] Luo C, Ning S, Liu Z and Zhuang Z 2020 Interactive inverse design of layered phononic crystals based on 

reinforcement learning _Extreme Mech. Lett._ **36** 100651 

- [104] Maghami A and Hosseini S M 2022 Automated design of phononic crystals under thermoelastic wave propagation through deep reinforcement learning _Eng. Struct._ **263** 114385 

- [105] Leilei C _et al_ 2021 Inverse design of phononic crystals by artificial neural networks _Chin. J. Theor. Appl. Mech._ **53** 1992–8 

- [106] Liangshu H _et al_ 2022 Machine-learning-driven on-demand design of phononic beams _Sci. China Phys. Mech. Astron._ **65** 33–44 

- [107] Han S, Han Q, Jiang T and Li C 2023 Inverse design of phononic crystals for anticipated wave propagation by integrating deep learning and semi-analytical approach _Acta Mech._ **234** 4879–97 

- [108] Lee D, Youn B D and Jo S-H 2023 Deep-learning-based framework for inverse design of a defective phononic crystal for narrowband filtering _Int. J. Mech. Sci._ **255** 108474 

26 

