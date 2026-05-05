---
title: "Parameter identification of sound absorption model of porous materials based on modified particle swarm optimization algorithm"
authors: ["Xiaomei Xu, Ping Lin"]
year: 2021
source: paper
journal: "PLOS ONE, 16(5), e0250950 — DOI: 10.1371/journal.pone.0250950"
ingested: 2026-05-05
sha256: a41b8f49f0fb7b6dd70ad4c8f4f072e7a7281dafb61c238adbae85ff2a5dc302
conversion: pymupdf4llm
---

## PLOS ONE 

## RESEARCH ARTICLE 

Parameter identification of sound absorption model of porous materials based on modified particle swarm optimization algorithm 

## **Xiaomei XuID*, Ping Lin** 

College of Automobile and Traffic Engineering, Nanjing Forestry University, Nanjing, China 

* xxm120480@126.com 

~~a1111111111 a1111111111 a1111111111 a1111111111 a1111111111~~ 

**==> picture [10 x 12] intentionally omitted <==**

## OPEN ACCESS 

**Citation:** Xu X, Lin P (2021) Parameter identification of sound absorption model of porous materials based on modified particle swarm optimization algorithm. PLoS ONE 16(5): e0250950. https://doi.org/10.1371/journal. pone.0250950 

**Editor:** Seyedali Mirjalili, Torrens University Australia, AUSTRALIA 

**Received:** August 16, 2020 

**Accepted:** April 17, 2021 

## **Published:** May 4, 2021 

**Copyright:** © 2021 Xu, Lin. This is an open access article distributed under the terms of the Creative Commons Attribution License, which permits unrestricted use, distribution, and reproduction in any medium, provided the original author and source are credited. 

**Data Availability Statement:** All relevant data are within the manuscript and its Supporting information files. 

## Abstract 

Porous materials have been widely used in the field of noise control. The non-acoustical parameters involved in the sound absorption model have an important effect on the sound absorption performance of porous materials. How to identify these non-acoustical parameters efficiently and accurately is an active research area and many researchers have devoted contributions on it. In this study, a modified particle swarm optimization algorithm is adopted to identify the non-acoustical parameters of the jute fiber felt. Firstly, the sound absorption model used to predict the sound absorption coefficient of the porous materials is introduced. Secondly, the model of non-acoustical parameter identification of porous materials is established. Then the modified particle swarm optimization algorithm is introduced and the feasibility of the algorithm applied to the parameter identification of porous materials is investigated. Finally, based on the sound absorption coefficient measured by the impedance tube the modified particle swarm optimization algorithm is adopted to identify the nonacoustical parameters involved in the sound absorption model of the jute fiber felt, and the identification performance and the computational performance of the algorithm are discussed. Research results show that compared with other identification methods the modified particle swarm optimization algorithm has higher identification accuracy and is more suitable for the identification of non-acoustical parameters of the porous materials. The sound absorption coefficient curve predicted by the modified particle swarm optimization algorithm has good consistency with the experimental curve. In the aspect of computer running time, compared with the standard particle swarm optimization algorithm, the modified particle swarm optimization algorithm takes shorter running time. When the population size is larger, modified particle swarm optimization algorithm has more advantages in the running speed. In addition, this study demonstrates that the jute fiber felt is a good acoustical green fibrous material which has excellent sound absorbing performance in a wide frequency range and the peak value of its sound absorption coefficient can reach 0.8. 

**Funding:** This research was supported by National Natural Science Foundation of China under Grant No. 51605228 and Six Talent Peaks Project in Jiangsu Province under Grant No. JXQC-025. 

**Competing interests:** The authors have declared that no competing interests exist. 

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

1 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

## **1 Introduction** 

Nowadays porous materials have been widely used in the field of noise control. Many researchers have devoted contributions on the sound absorption performance of these materials. The sound absorption performance of materials is commonly characterized by the sound absorption coefficient (SAC). The SAC of materials can be experimentally evaluated using the impedance tube [1] or be predicted using acoustic transfer analysis method along with experimental measurements [2]. Allard and Attala demonstrated the prediction of the SAC of porous materials by using the transfer matrix method [3]. 

There are two main models for porous materials to predict their SAC in previous studies [4]: the empirical model represented by Delany-Bazley (DB) model [5] and the phenomenological model represented by Johnson-Champoux-Allard (JCA) model [6]. The empirical model only needs to measure the air flow resistivity and then establish respectively the powerlaw relations between the characteristic impedance and the air flow resistivity, and the relations between the propagation constant and the air flow resistivity by fitting a large number of measurements. It is obvious that the empirical models are easy to implement. However, the empirical model does not consider the microstructure of the pores, and moreover, each empirical model is usually best suitable for certain type of materials and certain frequency ranges. The phenomenological model takes the influence of micro-factors on the acoustical properties of the materials into account. They consider the frame of a porous material as rigid and involve five non-acoustical parameters for the surface impedance calculation, namely porosity, tortuosity, air flow resistivity, viscous and thermal characteristic lengths [7]. The phenomenological model establishes a relationship between the microstructure and the acoustic performance through characterizing porous materials with equivalent fluid, which makes them have higher prediction accuracy. 

As a representative of the phenomenon model, the JCA model is now the most widely used model in predicting the SAC of porous materials [8]. The prediction accuracy of the SAC considerably depends on the measurement precision or identification precision of the material non-acoustical parameters [9]. Measurement of the non-acoustical parameters is not a simple task, as it involves dedicated measurement facilities that are not very common to all acoustic characterization laboratories [10]. In that case the inverse acoustic characterization method is adopted by many researchers to identify the non-acoustical parameters. The main focus of the method is on the reduction of error between the experimental data and the theoretically predicted data. 

Many optimization techniques have been adopted to perform the inverse acoustic characterization method in recent years. Some researchers used traditional optimization techniques like least squares technique [11]. Atalla and Panneton solved the inverse characterization problem of three parameters in the JCA model based on differential evolution algorithm [12]. Pelegrinis et al. used the Nelder-Mead simplex optimization method to solve the error minimization problem [13]. Cobo et al. combined four models and simulated the annealing algorithm to retrieve non-acoustical parameters of the granular acoustic absorbing materials [14]. Bonfiglio and Pompoli compared the effect of different methods applied to determine the physical parameters of porous materials [15]. The research results of literature [15] show that the analytical method and the iterative method are difficult to deal with the non-linear constrains and the optimization solution time of the iterative method is relatively long, the quality of the optimal results for the Nelder-Mead simplex optimization depends considerably on the setting of initial parameters, and the local searching ability of the genetic algorithm is relatively poor and it involves complicated encoding and decoding process. 

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

2 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

The particle swarm optimization (PSO) algorithm is also one of the methods used for the inverse characterization problems [16]. The PSO algorithm presents many advantages over other algorithms as it is robust and suitable for the nonlinear design space and it can easily handle continuous, discrete and integer variable types. As a population-based optimization algorithm the PSO algorithm requires lower computational effort [17]. Bansod and Mohanty performed the inverse estimation for the non-acoustical parameters of the jute material with the PSO algorithm and obtained good results of the inverse estimation [17]. However, it is worth noting that for some large-scale nonlinear optimization problems, PSO algorithm is easy to encounter a local optimum solution. In order to avoid this issue, some improvements and modifications have been proposed. The modification approach of PSO algorithm could be grouped as initial solution settings, solution space deduction, evolution process improvement, and heuristic rule, etc. [18]. 

In this study, a modified particle swarm optimization (MPSO) algorithm is adopted to identify the non-acoustical parameters of the jute fiber felt. The main contributions of this paper are twofold: (1) The identification performance and computation performance of the MPSO algorithm applied to identifying the non-acoustical parameters of the natural porous materials are explored; (2) The sound absorption performance of the natural jute fiber felt in a wide frequency range is revealed. 

The remainder of this article is organized as follows. A sound absorption model of porous materials is introduced in Section 2. In Section 3, a non-acoustical parameter identification model is established. In Section 4, a modified particle swarm optimization algorithm is illustrated. And in Section 5, application of the modified particle swarm optimization algorithm in the non-acoustical parameters identification of the jute fiber felt is investigated and discussed. In the last section, concluding remarks are provided and directions for future work are highlighted. 

## **2 Sound absorption model** 

As the semi-empirical model, JCA model is the most widely used sound absorption model. It contains five physical parameters, namely that, porosity _ϕ_ , air flow resistivity _σ_ , tortuosity _α_ 1, viscous characteristic length Λ and thermal characteristic length Λ’. Porosity is the percentage of pore volume occupied by saturated medium (generally air) compared to the total volume of the material in the natural state. Air flow resistivity has important influence on the sound absorption performance of porous materials. It is usually defined as the resistance of air flowing through the porous material with certain thickness. Tortuosity of porous materials is the deviation between the actual path and the straight path of the sound waves in materials, which represents the complexity of the material pores. Both the porosity and the tortuosity are dimensionless quantities. The viscous characteristic length represents the magnitude of the viscous force and the thermal characteristic length describes the degree of thermal exchange between the saturated medium in the pore and the solid frame at high frequencies. 

According to the JCA model, the effective density _ρe_ ( _ω_ ) and bulk modulus _Ke_ ( _ω_ ) of the porous materials can be calculated using the following expressions. 

**==> picture [289 x 39] intentionally omitted <==**

**==> picture [301 x 45] intentionally omitted <==**

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

3 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

where _ω_ is the angular frequency of the incident wave, _j_ is the imaginary unit, _ρ_ 0 is the air density, _Npr_ is the Prandtl number of air, _η_ is the dynamic viscosity of air, _γ_ is the specific heat ratio related to the air state, and _P_ 0 is the ambient atmospheric pressure. It needs to be noted that Λ and _Λ’_ are associated with some other physical parameters of the materials and they can be written as 

**==> picture [274 x 27] intentionally omitted <==**

where _c_ and _c_ ´ are shape factor and scale factor of the pore cross section, respectively. The characteristic impedance _Zc_ ( _ω_ ) and complex propagation constant _ke_ ( _ω_ ) of porous materials can be deduced by Eqs (1) and (2), and they can be expressed as Eqs (4) and (5). 

**==> picture [242 x 67] intentionally omitted <==**

Considering that the porous material with thickness _d_ is backed by the rigid boundary, the sound absorption coefficient (SAC) _α_ of the porous material can be denoted by the following equations. 

**==> picture [256 x 24] intentionally omitted <==**

**==> picture [228 x 52] intentionally omitted <==**

where _Zs_ ( _ω_ ) is the surface characteristic impedance, _Z_ 0 is the air characteristic impedance and is equal to _ρ_ 0 _c_ 0, in which _c_ 0 is the sound speed, and _R_ is the sound reflection coefficient. 

## **3 Non-acoustical parameter identification model** 

In the JCA model there are five non-acoustical parameters that need to be identified: porosity, air flow resistivity, tortuosity, viscous characteristic length and thermal characteristic length. In this study, the main task is to identify four parameters except the porosity by means of the optimization techniques as the porosity can be calculated out based on the measured density. 

It can be seen from Eq (3) that the viscous characteristic length Λ and thermal characteristic length Λ´ are functions of the shape factor _c_ and scale factor _c´_ of the pore cross section, respectively. The range of the characteristic length value is commonly from 1 to 3000, whereas the value of shape factor _c_ or scale factor _c_ ´ generally ranges from 0.3 to 3.3. The shape factor _c_ and scale factor _c_ ´ are selected as the design variables instead of the viscous characteristic length and thermal characteristic length because narrowing the solution space helps to converge to a reasonable solution. Set the dimension of the particle _D_ to 4, thus the four components in the particle’s position vector represent four unknown parameters in the JCA model, namely _**x**_ = [ _σ_ , _α_ 1, _c_ , _c_ ´]. 

It is obvious that the non-acoustical parameter identification is essentially a constrained multi-dimensional parameter optimization problem. The objective is to find the global optimal parameters to make the predicted SAC most consistent with the experimental SAC. According 

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

4 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

to the principle of the least square method, the fitness function and the constraints can be given in Eq (9). 

**==> picture [281 x 122] intentionally omitted <==**

where _T_ is the number of sampling frequency points in the testing frequency range, _fi_ is the _i_ th frequency point sampled in the experiment, _α_ EXP denotes the SAC measured at the frequency _fi_ , and _α_ JCA denotes the SAC predicted by the JCA model at the same frequency. 

## **4 Optimization algorithm** 

In this section the optimization algorithm adopted to solve the non-acoustical parameter identification model of the porous materials is presented. 

## **4.1 Standard particle swarm optimization algorithm** 

Particle swarm optimization (PSO) algorithm was first proposed by Kennedy and Eberhart in 1995 [19], which is an efficient population-based stochastic search technique. The PSO algorithm regards an individual as a particle without weight or volume in the search space. Each particle in the swarm represents a candidate solution to the optimization problem and flies at a certain speed in the multi-dimensional search space. The flight state can be described by the velocity vector and the position vector. Suppose that in the _D_ -dimensional space the current position of _i_ th particle ( _i_ = 1, 2,. . ., _N_ ) is _**xi**_ = [ _xi_ 1, _xi_ 2,. . ., _xiD_ ] and the current velocity is _**vi**_ = [ _vi_ 1, _vi_ 2, . . ., _viD_ ], where _N_ denotes the swarm size. The best position encountered by the _i_ th particle itself is _pbest_ and the best position in the whole swarm is _gbest_ . The position vector of the particle is dynamically adjusted according to its momentum and both the individual and the global memories. The particle therefore takes advantage of the best position to make itself fly towards the optimal solution. Update of the particle velocity and position is written as 

**==> picture [286 x 13] intentionally omitted <==**

**==> picture [230 x 12] intentionally omitted <==**

where _v[k] id_[and] _[ x] id[k]_[denote the current velocity and the current position of the] _[ i]_[th particle at] _[ d]_[th] dimension in the _k_ th iteration, _p[k] id_[and] _[ g] id[k]_[denote] _[ p][best]_[ and] _[ g][best]_[ respectively,] _[ w]_[ is the inertia] weight which is used to realize the effective control of the particle’s flight velocity, _c_ 1 and _c_ 2 are two acceleration coefficients reflecting the level of self-cognition and social cognition among the particles, _r_ 1 and _r_ 2 are two random numbers uniformly distributed in the interval [0, 1]. Note that, the solution space is bounded by [ _x_ min, _x_ max] and the velocity is bounded by [ _v_ min, _v_ max]. 

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

5 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

## **4.2 Modified particle swarm optimization algorithm** 

In this subsection, inspired by the previous research work the improvements of the PSO algorithm are made from the following three aspects. 

**4.2.1 Chaotic initialization.** Standard PSO mostly adopts the random distribution strategy to generate the initial population. In the case of a large search space it is difficult for the initial population to give a high ergodic degree, which affects the solving efficiency of the PSO algorithm. To improve the quality of particles, the initial position and velocity are initialized with a pseudo-random chaotic sequence. The chaotic sequences are constructed by the chaotic logistic map, and the map relationship can be expressed as [20] 

**==> picture [278 x 11] intentionally omitted <==**

where _zi_ denotes the _i_ th chaotic variable which is distributed in the interval (0, 1) and _μ_ is a predetermined constant called bifurcation coefficient. When _μ_ 2[3.57, 4] and _zi =_ 2{0, 0.25, 0.5, 0.75, 1}, the dynamic system behaves a completely chaotic state [21]. At this time, the track of chaotic variables can be guaranteed to traverse the entire search space. The detailed procedure of the chaotic initialization algorithm in this study is outlined as follows. 

- _**Step 1**_ . Set iteration number and bifurcation coefficient. Randomly construct a _D_ dimensional initial chaotic variable _z_ 1 = [ _z_ 11, _z_ 12, . . ., _z_ 1 _D_ ]; each dimension component is a random number that distributes between 0 and 1. 

- _**Step 2**_ . If component values of the chaotic variable _zi_ are 0, 0.25, 0.5, 0.75 and 1, give the component a small perturbation by Eq (13) and then update _zi_ using Eq (12); otherwise update _zi_ directly using Eq (12) without any changes. 

**==> picture [223 x 11] intentionally omitted <==**

where _r_ is a random number. 

- _**Step 3**_ . Suppose _N_ is the preset largest iteration times which is equal to the swarm size. If the iteration number _i_ = _N_ , then stop the iteration; otherwise set _i_ = _i_ +1, and then go back to step 2. 

- _**Step 4**_ . After the iteration is completed, the chaotic matrix [ _z_ 1; _z_ 2; . . .; _zN_ ] is formed by _N_ chaotic vectors. Then remap each element in the matrix from the chaotic region (0, 1) into the initial solution space according to Eq (14). 

**==> picture [284 x 12] intentionally omitted <==**

**4.2.2 Sigmoid-based acceleration coefficients.** In order to obtain the balance between the global search competence early in the algorithmic process and the global convergence late in the algorithmic process, literature [22] proposed the adjusting strategy of the acceleration coefficients based on the sigmoid function. The sigmoid-based acceleration coefficients can be written as 

**==> picture [282 x 24] intentionally omitted <==**

**==> picture [271 x 24] intentionally omitted <==**

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

6 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

where _λ_ is the control parameter used to adjust the values of the sigmoid-based acceleration coefficients ( _λ_ = 0.0001), _c_ 1 _f_ and _c_ 1 _i_ are constants and the values are 2.5 and 0.5, respectively [22]. _τ_ is defined as the ratio of the current iteration times _k_ to the maximum iteration times _M_ . In the early solution process, when _τ_ = 0 the value of _c_ 1 begins to decrease nonlinearly from 2.5 and the value of _c_ 2 begins to increase nonlinearly from 0.5, which makes the initial particles disperse into the solution space. When _τ_ = 1, the value of _c_ 1 drops to 0.5 and the value of _c_ 2 rises to 2.5. Under such conditions the tendency for the particles approaching to the optimal position of the group is strengthened. 

**4.2.3 Adaptive inertia weight.** In order to balance the global exploration capacity and the local search optimum capacity, the adaptive inertial weight factor strategy is adopted to dynamically change the inertia weight according to the fitness values. The adaptive inertial weight factor is often used in conjunction with the chaotic sequence to improve the performance of searching optimum [23]. The inertia weight can be expressed as 

**==> picture [301 x 45] intentionally omitted <==**

where _w[k] i_[and] _[ f][ k] i_[.represent the inertial weight and fitness value of the] _[ i]_[th particle in the] _[ k]_[th iter-] ation, _w_ max and _w_ min are the maximal and the minimal values of the inertial weight, _f_ avg _[k]_[and] _f_ min _[k]_[denote the average fitness value and the minimum fitness value of current total particles,] respectively. If the fitness value is smaller than its average value, a relatively small _w_ is given to slow down the velocity of the particles in local space to find the global optimal solution. If the fitness value is larger than its average value, the step length of searching optimum needs to be increased to improve the capacity of global searching optimum by setting the inertial weight value as the maximum _w_ max. 

## **4.3 Implementation of the modified particle swarm optimization algorithm** 

The flow chart of the MPSO algorithm is shown in Fig 1 and the detailed steps of the algorithm are summarized as follows. 

- _**Step 1**_ . Input parameter values to the algorithm, including _D_ , _N_ , _M_ , _w_ max, _w_ min, _x_ min, _x_ max, _v_ min and _v_ max. 

- _**Step 2**_ . Initialize velocity and position of the particles based on the chaotic initialization algorithm mentioned above, then calculate the fitness for all particles in current population according to Eq (9). At the same time record the current optimal position of the individual particle _pbest_ and the global optimal position _gbest_ . 

- _**Step 3**_ . Set _k_ = 1. 

_**Step 4**_ . Determine _c[k]_ 1[and] _[ c][k]_ 2[by Eqs (][15][) and (][16][).] 

_**Step 5**_ . Set _i_ = 1. 

_**Step 6**_ . Calculate _favg[k]_[and] _[ f][ k]_ min[of current particle population.] 

_**Step 7**_ . Determine o _[k] i_[by][ Eq (17)][.] 

_**Step 8**_ . Update the velocity _v[k] i_[and position] _[ x] i[k]_[of the particles based on Eqs (][10][) and (][11][).] 

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

7 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

**==> picture [370 x 552] intentionally omitted <==**

**Fig 1. Flow chart of the MPSO algorithm.** https://doi.org/10.1371/journal.pone.0250950.g001 

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

8 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

_**Step 9**_ . If the position and velocity are out of the range, adjust them by using Eqs (18) and (19). 

**==> picture [256 x 108] intentionally omitted <==**

_**Step 10**_ . Calculate the fitness _fi[k]_[of the current particle by][ Eq (9)][.] 

_**Step 11**_ . Update _pbest_ and _gbest_ . 

_**Step 12**_ . If _i < N_ , set _i_ = _i_ +1 and go back to step 7, otherwise go to the next step. 

_**Step 13**_ . If _k < M_ , set _k_ = _k_ +1 and go back to step 4, otherwise terminate the algorithm and output the final optimal solution _gbest_ according to the minimum fitness value. 

Run the MPSO algorithm many times and then determine the final optimal results according to the smallest fitness value. The optimal viscous characteristic length and thermal characteristic length can be calculated through the shape factor _c_ and the scale factor _c´_ according to Eq (3). Thus the JCA prediction model with identified parameters is determined. 

## **4.4 Verification of the modified particle swarm optimization algorithm** 

Verification of the feasibility for the MPSO algorithm applied to parameter identification of porous materials is carried out based on the relevant data offered by literature [24]. In literature [24], analytical method, indirect method, genetic algorithm and iterative method were all used to predict the five non-acoustical parameters of a polyurethane foam, respectively. The measured values of the air flow resistivity, porosity and tortuosity of this material were listed in Table 1. Literature [25] used the method of multi-levels inverse estimation to obtain the five non-acoustical parameter values for the same material. In this study the MPSO algorithm is also utilized to estimate the five parameters of the same material. Set the maximum iteration number _M_ as 150 and the population size _N_ as 50. The _w_ min and _w_ max of the inertial weight are 

**Table 1. Parameter values measured and identified by the above mentioned methods.** 

|**Parameters**|**Air flow resistivity****_σ_ (N**�**s/**<br>**m4)**|**Porosity****_ϕ_ **|**Tortuosity****_α_**1|**Viscous characteristic length Λ**<br>**(μm)**|**Thermal characteristic length Λ’**<br>**(μm)**|
|---|---|---|---|---|---|
|**Methods**||||||
|Measured-[24]|5359|1|1.08|-|-|
|Analytical method-[24]|6641|0.9|1.03|83|267|
|Indirect method-[24]|6414|0.99|1.15|135|250|
|Genetic algorithm-[24]|6252|0.99|1.14|132|251|
|Iterative method-[24]|6200|0.99|1.10|130|250|
|Multi-levels inverse estimation-<br>[25]|5658|0.98|1|100|250|
|MPSO algorithm|5340|0.99|1.12|121|271|
|https://doi.org/10.1371/journal.pone.0250950.t001||||||



PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

9 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

set as 0.4 and 0.9, respectively. The parameter values identified by the above mentioned methods are listed in Table 1. 

In Table 1, the relative errors of the air flow resistivity identified by the methods addressed in literature [24] are all more than 15%. The relative error of air flow resistivity identified by the method of multi-levels inverse estimation is reduced to 5.2%, while the relative errors of the porosity and the tortuosity are increased obviously [25]. However, for the MPSO algorithm, the relative error of the air flow resistivity is reduced to 0.35%, and the relative errors of the porosity and the tortuosity are 1% and 3.70%, respectively. It is obvious that among the above methods the MPSO algorithm has the most advantages in identifying the non-acoustical parameters involved in the JCA model of the porous materials. 

## **5 Application of modified particle swarm optimization algorithm** 

In this section the MPSO algorithm is adopted to identify the non-acoustical parameters involved in the JCA model of the jute fiber felt based on the SAC measured by the impedance tube. The SAC predicted by the JCA model is compared with the experimental SAC. And the identification performance and computation performance of the MPSO algorithm are discussed. 

## **5.1 Jute fiber felt sample** 

Natural fibers have better sound absorption performance due to their naturally formed porous structure [8]. Jute fiber is a kind of natural fiber with excellent performance and it is commonly used as vehicle ceiling, door interior frame, seat back, and other interior trim substrates and acoustic packaging materials [26]. The jute fiber is stacked, heated and bonded into a feltlike form after the mixing, carding and net-paving process. The microscopic structure under environmental scanning electron microscopy of the jute fiber felt is shown in Fig 2, and the statistical average of the fiber diameter is 23.67 μm. 

**==> picture [253 x 234] intentionally omitted <==**

**Fig 2. SEM photograph of the jute fiber felt.** 

https://doi.org/10.1371/journal.pone.0250950.g002 

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

10 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

**Table 2. Geometric and physical parameters of the samples.** 

|**Parameters**|**Sample****_L_**|**Sample****_S_**|**Average**|
|---|---|---|---|
|**Diameter (mm)**|100.92|31.5|-|
|**Thickness (mm)**|18.93|18.65|18.79|
|**Density (kg/m3)**|43.14|40.72|41.93|
|**Porosity**|0.96|0.96|0.96|



https://doi.org/10.1371/journal.pone.0250950.t002 

The porosity of the jute fiber felt can be estimated according to Eq (20). 

_�_ ¼ ð1 � r _m=_ r _f_ Þ � 100% ð20Þ 

in which, _ρm_ is the density of the jute fiber felt sample, _ρf_ is the density of the raw material and the porosity of the jute fiber felt comes out to be 0.96. 

The jute fiber felt is made into two circular samples with different diameters. Their diameters match with the inner diameters of the large and small impedance tubes, respectively. The geometric and physical parameters of the two samples are listed in Table 2, where _L_ and _S_ indicate the large-diameter and the small-diameter samples, respectively. 

## **5.2 Testing of the sound absorption coefficient for the jute fiber felt** 

In order to obtain the SAC curve of the jute fiber felt the SAC testing system shown in Fig 3 is established, which consists of two sets of B&K 4206 impedance tubes, the power amplifier, the sound calibration instrument and the PULSE analysis software, etc. Two jute fiber felt samples and the impedance tube installed with a sample are displayed in Fig 4. 

The acoustic impedance tube test system is used to measure the SAC of the samples according to the ISO 10534–2: 1998 [27]. The large diameter impedance tube is used to measure the SAC of the sample at the frequency ranging from 250 Hz to 1600 Hz, and the small diameter impedance tube is applied to the frequency ranging from 500 Hz to 6000 Hz. It is obvious that 

**==> picture [264 x 88] intentionally omitted <==**

**Fig 3. SAC testing system of the jute fiber felt.** 

https://doi.org/10.1371/journal.pone.0250950.g003 

**==> picture [264 x 91] intentionally omitted <==**

**Fig 4. Jute fiber felt samples and the impedance tube installed with a sample.** 

https://doi.org/10.1371/journal.pone.0250950.g004 

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

11 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

there is an overlap of the SAC values at the frequency ranging from 500 Hz to 1600 Hz. The SAC values in the overlap frequency range can be calculated according to Eq (21) [28]. 

**==> picture [275 x 25] intentionally omitted <==**

where _αS_ and _αL_ represent the SAC measured by the small tube and the large tube, respectively. 

## **5.3 Results and discussion** 

In this subsection the identification performance and the computational performance of the MPSO algorithm are discussed. 

**5.3.1 Comparison of the identification performance.** Based on the experimental SAC and the porosity of the jute fiber felt, the standard PSO algorithm and the MPSO algorithm are adopted to identify the non-acoustical parameters involved in the JCA model of the jute fiber felt. Set the maximum iterative number _M_ as 150 and the population size _N_ as 50. The _w_ min and _w_ max of the inertial weight are set as 0.4 and 0.9, respectively. In the standard PSO algorithm, _c_ 1 and _c_ 2 are both set as 2 and the inertial weight reduces linearly [29]. The rest parameters of the PSO algorithm are set the same as those of the MPSO algorithm. The optimization process runs ten times independently. The optimal parameter values and the fitness values are listed in Table 3. 

It can be seen from Table 3 that the average fitness value of MPSO algorithm is much lower than that of the PSO algorithm. For the MPSO algorithm the difference between the maximum and the minimum fitness values is not significant, which demonstrates the optimization process is stable. The excellent performance of the MPSO algorithm is mainly attributed to the improvements of the PSO algorithm in three aspects. The chaotic initialization mechanism enables the MPSO algorithm to generate a diverse initial population before entering iteration. Both the sigmoid-based acceleration coefficient and the adaptive inertia weight factor are conducive to the emergence of the optimal solution and the stability of the MPSO algorithm. 

Substitute the values of the non-acoustical parameters shown in Table 3 into the JCA model to predict the SAC of the jute fiber felt. The predicted SAC curve and the experimental curve are shown in Fig 5. As can be observed from Fig 5, the jute fiber felt has excellent sound absorbing performance in a wide frequency range and the peak value of SAC can reach 0.8. Compared with the SAC curve predicted by the PSO algorithm, the SAC curve predicted by the MPSO algorithm has better consistency with the experimental curve. Therefore, it demonstrates that the MPSO algorithm has more advantages in predicting the non-acoustical parameters of the JCA model for the porous materials. 

**5.3.2 Comparison of the computational performance.** In order to verify the efficiency of the MPSO algorithm and analyze the influence of population size on the algorithm performance, two cases are tested with different population size ( _N_ = 50, 100, 150). Results of the comparison are shown in Figs 6 and 7. 

**Table 3. Comparison of the identification results by the PSO and MPSO algorithms.** 

|**Algorithms**||**Fitness values**|**Fitness values**|||**Optimal non-acoustical parameter values (Min.)**|**Optimal non-acoustical parameter values (Min.)**|**Optimal non-acoustical parameter values (Min.)**|
|---|---|---|---|---|---|---|---|---|
||**Min.**|**Max.**|**Avg.**|**Std.**|**Air flow resistivity****_σ_ (N**�**s/**<br>**m4)**|**Tortuosity**<br>**_α_**1|**Viscous characteristic length Λ**<br>**(μm)**|**Thermal characteristic length Λ´**<br>**(μm)**|
|PSO|0.8411|89.1185|46.6094|38.6162|13629|1|353|353|
|MPSO|0.2497|2.4874|1.1448|1.1555|12742|1|267|267|



https://doi.org/10.1371/journal.pone.0250950.t003 

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

12 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

**==> picture [348 x 275] intentionally omitted <==**

**Fig 5. Comparison of the three SAC curves of the jute fiber felt.** 

https://doi.org/10.1371/journal.pone.0250950.g005 

**==> picture [421 x 169] intentionally omitted <==**

**Fig 6. CPU time and average fitness value for two algorithms at the case of** _**N**_ **= 50, 150 and 250. (** _**a**_ **)** CPU time. **(** _**b**_ **)** Average fitness value. 

https://doi.org/10.1371/journal.pone.0250950.g006 

It can be seen from Fig 6(a) that the CPU time costed by the two algorithms increases with the population size, which is caused by the increase of computational effort. With the same population size the MPSO algorithm takes the shorter CPU running time which is 4.2% average less than the running time taken by the PSO algorithm. With the increase of population size, the MPSO algorithm has more advantages in terms of running speed. As shown in Fig 6 (b), the optimal average fitness values of the MPSO and PSO algorithms decrease with the 

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

13 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

**==> picture [269 x 206] intentionally omitted <==**

**Fig 7. Iterative results of PSO and MPSO algorithms.** 

https://doi.org/10.1371/journal.pone.0250950.g007 

increasing of the population size. Moreover, for three different population size the average fitness values of the MPSO algorithm are very small, which indicates that the MPSO algorithm has more advantages in searching the global optimal solution. 

As can be seen from Fig 7, the average fitness value of the PSO algorithm decreases quickly at the beginning of iteration and the activity of the population particles reduces after a few times of iteration, which leads the algorithm to converge quickly and the optimal solution tends to fall into the local optimum. And the smaller the population size is, the more likely it is to fall into local optimum. It means that for the case of standard PSO algorithm in order to obtain better identification performance for the non-acoustical parameters it needs larger population size, while larger population size means higher computing time cost. Compared with the PSO algorithm the average fitness value of the MPSO algorithm decreases slowly at the beginning of iteration and the curves maintain downward trend even in the later period of iteration, which demonstrates the strong global search capability and avoids the problem of premature convergence. Moreover, the average fitness value of MPSO algorithm is not easily affected by the population size. Even if the population size is smaller the MPSO algorithm can still obtain the better solution. In other words, the MPSO algorithm can achieve the global minimum with high tolerance for the variations of the population size and the control parameters. The MPSO algorithm presents good performance in the identification of the non-acoustical parameters for the natural porous materials. 

## **6 Conclusions** 

In this study, a MPSO algorithm is adopted to identify the non-acoustical parameters involved in the sound absorption model of the porous materials. The feasibility of the MPSO algorithm applied to the non-acoustical parameter identification of porous materials is investigated. The identification performance and the computational performance of the MPSO algorithm in identifying the non-acoustical parameters of the jute fiber felt are discussed. Research results show that the MPSO algorithm can accurately and effectively identify the non-acoustical parameters involved in the JCA model of the porous materials. Compared with the standard PSO algorithm the SAC curve predicted by the MPSO algorithm has better consistency with 

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

14 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

the experimental SAC curve, and in terms of the computer running time the MPSO algorithm costs shorter time, especially when the population size increases the MPSO algorithm presents more obvious advantages. In addition, this study demonstrates that the jute fiber felt is a good acoustical green fibrous material which has excellent sound absorbing performance in a wide frequency range and the peak value of its SAC can reach 0.8. 

This study is limited in a specific condition, i.e., variability is not considered properly. Future research could analyze the effect of different algorithm parameters on the solution quality and convergence speed, which is conducive to demonstrating the algorithm robustness and obtaining more effective parameter design. Future possible work is to propose more efficient evolutionary algorithms to solve parameter identification problems with more practical constraints. 

## **Supporting information** 

**S1 Data.** (XLSX) 

**S2 Data.** (XLSX) 

## **Acknowledgments** 

The authors would like to appreciate Dr. Xiaoli Wu for her help with some experiments. 

## **Author Contributions** 

**Conceptualization:** Xiaomei Xu. 

**Formal analysis:** Ping Lin. 

**Funding acquisition:** Xiaomei Xu. 

**Methodology:** Xiaomei Xu. 

**Validation:** Xiaomei Xu, Ping Lin. 

**Writing – original draft:** Xiaomei Xu, Ping Lin. 

**Writing – review & editing:** Xiaomei Xu, Ping Lin. 

## **References** 

**1.** Berardi U, Iannace G. Acoustic characterization of natural fibers for sound absorption applications. Building and Environment. 2015; 94(2):840–852. https://doi.org/10.1016/j.buildenv.2015.05.029 

**2.** Fouladi MH, Nor MJM, Ayub M, Leman ZA. Utilization of coir fiber in multilayer acoustic absorption panel. Applied Acoustics. 2010; 71(3):241–249. https://doi.org/10.1016/j.apacoust.2009.09.003 

**3.** Allard JF, Attala N. Propagation of sound in porous media: modelling of sound absorbing materials. 2nd edition, John Wiley & Sons Ltd; 2009. 

**4.** Kalauni K, Pawar SJ. A review on the taxonomy, factors associated with sound absorption and theoretical modeling of porous sound absorbing materials. Journal of Porous Materials. 2019; 26(6):1795– 1819. https://doi.org/10.1007/s10934-019-00774-2 

**5.** Delany ME, Bazley EN. Acoustical properties of fibrous absorbent materials. Applied Acoustics. 1970; 3 (2):105–116. https://doi.org/10.1016/0003-682X(70)90031-9 

**6.** Allard JF, Champoux Y. New empirical equations for sound propagation in rigid frame fibrous materials. Journal of the Acoustical Society of America. 1992; 91(6):3346–3353. https://doi.org/10.1121/1.402824 

**7.** Champoux Y, Allard JF. Dynamic tortuosity and bulk modulus in air-saturated porous media. Journal of Applied Physics. 1991; 70(4):1975–1979. https://doi.org/10.1063/1.349482 

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

15 / 16 

PLOS ONE 

Parameter identification of sound absorption model of porous materials 

**8.** Cao LT, Fu QX, Si Y. Porous materials for sound absorption. Composites Communications. 2018; 10:25–35. https://doi.org/10.1016/j.coco.2018.05.001 

**9.** Verdiere K, Panneton R, Atalla N, Elkoun S. Inverse poroelastic characterization of open-cell porous materials using an impedance tube. SAE Technical Paper No. 2017-01-1878. 

**10.** Kino N, Ueno T. Experimental determination of the micro and macro-structural parameters influencing the acoustical performance of fibrous media. Applied Acoustics. 2007; 68(11):1439–1458. https://doi. org/10.1016/j.apacoust.2006.07.008 

**11.** Fellah ZEA, Mitri FG, Fellah M, Ogam E, Depollier. Ultrasonic characterization of porous absorbing materials: Inverse problem. Journal of Sound and Vibration. 2007; 302(4–5):746–759. https://doi.org/ 10.1016/j.jsv.2006.12.007 

**12.** Atalla Y, Panneton R. Inverse acoustical characterization of open cell porous media using impedance tube measurements. Canadian Acoustics. 2005; 33(1):11–24. 

**13.** Pelegrinis MT, Horoshenkov KV, Burnett A. An application of Kozeny-Carman flow resistivity model to predict the acoustical properties of polyester fibre. Applied Acoustics. 2016; 101:1–4. https://doi.org/10. 1016/j.apacoust.2015.07.019 

**14.** Cobo P, Simon F. A comparison of impedance models for the inverse estimation of the non-acoustical parameters of granular absorbers. Applied Acoustics. 2016; 104:119–126. https://doi.org/10.1016/j. apacoust.2015.11.006 

**15.** Bonfiglio P, Pompoli F. Inversion problems for determining physical parameters of porous materials: overview and Comparison Between Different Methods. Acta Acustica United with Acustica. 2013; 99 (3):341–351. https://doi.org/10.3813/AAA.918616 

**16.** V M Jr, Cardoso EL, Stahlschmidt J. Particle swarm optimization and identification of inelastic material parameters. Engineering Computations. 2013; 30(7):936–960. https://doi.org/10.1108/EC-10-20110118 

**17.** Bansod PV, Mohanty AR. Inverse acoustical characterization of natural jute sound absorbing material by the particle swarm optimization method. Applied acoustics. 2016; 112:41–52. https://doi.org/10. 1016/j.apacoust.2016.05.011 

**18.** Zhang YD, Wang SH, Ji GL. A Comprehensive survey on particle swarm optimization algorithm and its applications. Mathematical Problems in Engineering, 2015;1–38. https://doi.org/10.1155/2015/931256 

**19.** Kennedy J, Eberhart R. Particle swarm optimization. Proceedings of the IEEE international conference on neural networks. 1995;4:1942–1948. 

**20.** Liu B, Wang L, Jin Y, Tang F, Huang D. Improved particle swarm optimization combined with chaos. Chaos, Solitons and Fractals. 2005; 25(5):1261–1271. https://doi.org/10.1016/j.chaos.2004.11.095 

**21.** Tian D. Particle swarm optimization with chaos-based initialization for numerical optimization. Intelligent Automation & Soft Computing. 2018; 24(2):331–342. 

**22.** Tian D, Zhao X, Shi Z. Chaotic particle swarm optimization with sigmoid-based acceleration coefficients for numerical function optimization. Swarm and Evolutionary Computation. 2019; 51:100573. https:// doi.org/10.1016/j.swevo.2019.100573 

**23.** Wang J, Zhu S, Zhao W, Zhu W. Optimal parameters estimation and input subset for grey model based on chaotic particle swarm optimization algorithm. Expert Systems with Applications. 2011; 38(7):8151– 8158. https://doi.org/10.1016/j.eswa.2010.12.158 

**24.** Bonfiglio P, Pompoli F. Comparison of different inversion techniques for determining physical parameters of porous media. 19th International congress on acoustics. 2007. p. 1–6. 

**25.** Hentati T, Bouazizi L, Taktak M, Trabelsi H, Haddar M. Multi-levels inverse identification of physical parameters of porous materials. Applied Acoustics. 2015; 108:26–30. https://doi.org/10.1016/j. apacoust.2015.09.013 

**26.** Noryani M, Sapuan SM, Mastura MT, Zuhri MYM, Zainudin ES. Material selection criteria for natural fibre composite in automotive component: A review. IOP Conference Series: Materials Science and Engineering. 2018;368(1): 012002. 

**27.** Acoustics-determination of sound absorption coefficient and impedance in impedance tubes, Part 2: Transfer-function method. London: International Organization for Standardization, ISO: 10534-2-1998, 1998. 

**28.** Yao D, Zhang J, Wang RQ, Xiao XB, Jin XS. Experiment and simulation optimization on characteristics of sound absorption of mattress material in sleeper EMU. Journal of Zhejiang University (Engineering Science). 2016; 50(8):1486–1492. 

**29.** Shi Y, Eberhart R. A modified particle swarm optimizer. Proceedings of the IEEE international conference on evolutionary computation. 1998. p. 69–73. 

PLOS ONE | https://doi.org/10.1371/journal.pone.0250950 May 4, 2021 

16 / 16