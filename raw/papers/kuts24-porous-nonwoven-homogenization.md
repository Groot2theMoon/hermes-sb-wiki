---
title: "Computational homogenization of linear elastic properties in porous non-woven fibrous materials"
journal: "10.1016/j.mechmat.2023.104849"
authors: ["Mikhail Kuts"]
year: 2024
source: paper
ingested: 2026-05-03
sha256: 190eb09119a9027b0523d238fa7e4c0aaec7647cce00389eef76d203152f39b5
conversion: pymupdf4llm
---

Version of Record: https://www.sciencedirect.com/science/article/pii/S0167663623003149 Manuscript_9cbc9b5db69082371a621f826e56e08b 

# 1 **Computational Homogenization of Linear Elastic** 2 **Properties in Porous Non-Woven Fibrous Materials** 

- 3 

## **Mikhail Kuts, James Walker, Pania Newell** 

- 4 Department of Mechanical Engineering, The University of Utah, Salt Lake City, UT, USA 

- 5 E-mail: pania.newell@utah.edu 

- 6 **Abstract.** Porous non-woven fibrous media are widely used in various industrial applications such 7 as filtration, insulation, and medical textiles due to their unique structural and functional properties. 8 However, predicting the mechanical behavior of these materials is challenging due to their complex 9 microstructure and anisotropic nature. In this study, a computational model is developed to simulate 

- 10 the mechanical response of porous non-woven fibrous media under external loading. The model is 11 based on the finite element method and takes into account the geometric and material properties 12 of the fibers and the void spaces between them. The effects of various factors such as fiber size, 13 porosity, and fibers’ intersection ratio on the mechanical behavior of the material are investigated. The 14 results reveal that the material’s porosity and fibers’ intersection ratio are the most significant factors 15 influencing its mechanical properties. Additionally, the increase in fiber diameter has a relatively 16 minor effect on the material’s elastic properties. However, such changes in elastic properties are 17 primarily attributed to the increase in randomness within the fibrous network, which is directly related 18 to the fiber diameter for the investigated structure. The proposed computational model predicts the 19 mechanical properties of porous non-woven fibrous media and can provide invaluable insights into 20 the design and optimization of porous non-woven fibrous media for various scientific and engineering 21 applications. 

22 

_**Keywords:** Fibrous porous media, Finite element modeling, Mechanical Properties, FEniCSx._ 

- 23 

## **Introduction** 

- 24 Fibrous porous materials, which consist of randomly distributed fibers in a network structure, have 25 gained significant attention due to their wide range of applications in various engineering and 26 scientific fields. Such materials possess unique properties that surpass those of the constituent 27 fibers. These properties include high porosity, large surface area, and lightweight, which contribute 28 to their high absorptive, filtration, and thermal and acoustic insulation capabilities [37, 64, 17]. 29 Additionally, some materials exhibit enhancement in their mechanical properties when the fiber 30 diameter is less than 200 nm [17]. These unique functionalities led to their utilization in diverse 31 areas including medical masks, filters, thermal and sound insulation, battery separators, absorbent 32 products, and packaging materials. 

- 33 Materials with randomly distributed fibers can be divided into two large classes, depending on 34 their structure: quasi-structured and randomly distributed [48]. The first class includes materials 35 with a perturbed regular structure, such as quasi-body centered cubic nanolattices [17] or the open36 cell foams (see Fig. 1-a). These materials exhibit significant similarities and can be considered as 37 a unified class of materials. Materials with controlled fiber orientation obtained by electrostatic 38 deposition and spinning or magnetic alignment of fibers also belong to this class. Other types of 

© 2023 published by Elsevier. This manuscript is made available under the Elsevier user license https://www.elsevier.com/open-access/userlicense/1.0/ 

- 39 materials have a random distribution of fibers without any specific structure (see Fig. 1-b–d). But 40 even in such materials, their fibers can have a predominant orientation along one or several axes or 41 planes (see Fig. 1-c), such as the needle-punched structures, which are produced from non-woven 42 fibre fabrics by means of a through-thickness needling technique [16, 21]. 

**==> picture [142 x 106] intentionally omitted <==**

**==> picture [142 x 106] intentionally omitted <==**

**==> picture [295 x 132] intentionally omitted <==**

**----- Start of picture text -----**<br>
a) b)<br>c) d)<br>**----- End of picture text -----**<br>


**Figure 1.** SEM pictures of fibrous materials: _a_ – Metal Foam in Scanning Electron Microscope ©SecretDisc, CC BY-SA 3.0; _b_ – Outer Layer of Medical Mask ©Alexander Klepnev, CC BY 4.0; _c_ – Cotton Fibers ©Janice Carr, Laura Rose, USCDCP, CC0; _d_ – “Moonmilk” Calcium Carbohydrate Fibers ©Brian England, CC-BY-4.0; 

- 43 The structure of non-woven fibrous materials is mainly determined by the fiber material and 44 the manufacturing process. Furthermore, there are different methods of fiber bonding including 45 mechanical, chemical, and thermal bonding [64]. In chemical bonding, binding agents are used 46 in combination with various methods such as spraying, printing, coating, or saturation to connect 47 fibers together (see Fig. 1-a). The resulting medium is fully connected, where all fibers are bonded, 48 and the fiber connections transmit both axial forces and moments. In thermal bonding, fibers are 49 joined together through a heating and cooling process (see Fig. 1-c). However, the main method 50 of fiber bonding is mechanical bonding (see Fig. 1-d), which involves fibers being bonded using 51 methods such as hydroentanglement, stitching, and needle punching. Overall, due to the immense 52 diversity in structure and available fabrication methods, designing fibrous porous materials with 53 specific properties is a complex task. 

- 54 Understanding the effective properties of fibrous porous materials is essential for gaining 55 insights into their behavior and optimizing their performance. By determining the effective 56 properties, we can comprehend how these materials behave under external loads. Moreover, 

- 57 

   - understanding the effective properties allows us to assess the overall performance of existing fibrous 

- 58 porous materials, providing valuable information for quality control and ensuring reliable and 59 efficient applications. In addition to understanding existing materials, knowledge of effective 60 properties plays a significant role in the future design of fibrous porous materials. By manipulating 61 and tailoring the material structural parameters, such as porosity, fiber diameter and shape, 62 and method of fiber binding, we can engineer materials with desired effective properties. This 

- 63 enables the design of materials that exhibit specific mechanical strength, thermal conductivity, 

2 

64 permeability, or other targeted characteristics. However, achieving this level of control requires 65 the development of a robust computational model capable of accurately predicting the effective 66 properties of fibrous porous materials and in our case mechanical properties of non-woven fibrous 67 materials. This poses a challenge, as a model must account for the complex interplay between 68 material behavior and various structural parameters. 

69 Over the past decades, extensive research has been conducted on fibrous porous systems. An 70 early contribution to the study of the mechanical properties of fibrous media is the work by Cox [18], 71 where he obtained an analytical solution describing the deformations of a two-dimensional (2D) 72 fibrous system. This work assumed that the fibers only experience tension while their orientation 73 is random and described by a distribution function. In a series of recent works, Bosco et al. [14, 12, 74 13] developed analytical solutions for describing the hygro-mechanical behavior of fibrous porous 75 systems. Their work focused on simplified 2D lattice structures with orthogonal fiber arrangements. 76 In one of their studies [13], they explored an analytical solution based on the Voigt model, where the 77 fibrous medium is treated as a composite plate composed of an infinite number of layers oriented 78 according to a probability density function. However, they showed that such models have inherent 79 limitations and are applicable only within a restricted range of coverage area and fiber orientations. 

80 To address the limitations of analytical solutions, numerical models have been employed to 81 investigate fibrous porous systems, offering more flexibility and the ability to consider a greater 82 number of factors compared to analytical approaches. For instance, Farukh et al. [22] conducted 83 an finite element analysis (FEA) of a thermally bonded non-woven fibrous system, incorporating 84 damage criteria based on the deformation and fracture behavior of individual fibers into their 85 model. Sozumer et al. [57] also took a similar approach to investigate the effect of the central 86 notch on non-woven fibrous networks experimentally and numerically. Additionally, it is also 87 worth noting that there is a significant amount of works containing experimental investigations 88 on the mechanical behavior of both individual fibers [22] and fibrous systems [57, 19]. For instance, 89 Cucumazzo et al. [19] investigated the rate dependency of fibers by individually testing fibers that 90 exhibited nonlinear elasticity followed by plastic strain hardening up to failure. These results were 91 further incorporated in their paper [20] where they used an approach to model the mechanical 92 behavior of a thermally bonded fibrous network using shell elements. 

93 A more advanced approach has been proposed by Kulachenko and Uesaka in [35] where they 94 introduced a framework for direct modeling of 2D paperlike random fibrous networks, employing 3- 95 node Timoshenko beam elements. Later Borodulina et al. [11] utilized their framework to simulate 96 fracture dynamics of a dry fiber network during tensile loading. In another work, Borodulina 97 et al. [10] investigated the effect of variation of individual fibers’ and bonds’ properties on the 98 effective stiffness and strength of the fibrous network. The additional development of these works 99 is demonstrated in the works of Mansur et al. [41, 40] , where authors used the same framework 100 as desrcribed in [35], to develop a stochastic constitutive model for an isotropic fiberous network, 101 transitioning from representative volume elements (RVE) to stochastic volume element (SVE). The 102 proposed approach enables the propagation of uncertainties from the microscale to the macroscale, 103 allowing for more efficient modeling of the behavior of an isotropic fibrous network compared to 104 directly simulating the entire medium. Other researchers [39, 38, 37] adopted a similar approach 105 to model three-dimensional (3D) random fibrous (RF) networks composed of ceramics. Using 2- 106 node Timoshenko beam elements, interfiber contact was simulated, incorporating the combined 107 influences of grain boundaries and interfaces. 

108 A drawback of using beam elements is the complexity of extending the model to investigate 109 coupled thermo-hydro-mechanical (THM) behavior. Geers et al. [12, 13, 53, 15] proposed a 110 2D framework for studying the THM behavior of paper-like materials represented as random 111 fibrous networks. A regular grid with quadrilateral elements was used to construct the geometry. 112 Although this approach allows for modeling the THM behavior of a wide range of fibrous materials 113 (nonwoven, lattice, etc.), it has several limitations: 1) the usage of spatial discretization method 

3 

114 results in a coarse representation of fiber boundaries and introduces dimensional redundancy 115 in solving system of linear equations (SLE), causing higher computations compared to adaptive 116 meshing; 2) this method is applicable only to materials with pronounced 2D structures; 3) the 2D 117 description does not account for fibers wrapping each other [15]. Therefore, the most promising 118 approach is to model fibrous materials in a 3D framework, as it allows for a more accurate 119 consideration of the material’s internal mechanics. However, currently, there is a scarcity of 120 works utilizing a 3D framework to study random fibrous networks. One such work is [62], which 121 investigates the mechanical behavior of sintered metallic fiber structures. In this study, the 122 simulations are conducted based on actual material structures obtained from micro-computed 123 tomography (micro-CT) images. The resulting model consists of over 4.5 million linear elements, 124 which is computationally demanding. 

- 125 Karakoc et al. [32] also used a 3D finite element method (FEM) to examine 2D random fibrous 126 networks composed of curvilinear fibers. They presented an original approach involving the 127 projection of the fibers’ boundary nodes onto the control nodes of the domain bounding the RVE, 128 followed by solving a boundary value problem on this domain instead of the RVE boundary domain. 129 Such an approach is highly suitable for investigating RVEs with non-conformal meshes, particularly 130 for 2D networks such as paper. The main disadvantage of this work is the usage of elements with 131 reduced integration, which resulted in a lower accuracy. 

- 132 Additionally, it is worth mentioning that others [52, 23] also investigated the elastic behavior 133 of woven materials with different structures (2D and 3D) in a 3D framework. These studies 134 combine homogenization methods with the higher-order elasticity terms to determine the averaged 135 components of the stiffness and curvature tensors, offering advantages when the scales separation 136 approach does not apply [61]. The drawbacks of these works include the use of a regular “Voxel" 137 grid, which significantly increases the number of degrees of freedom in the problem, imprecise 138 description of fiber boundaries, and the usage of elements with reduced integration, which exhibit 139 low accuracy. Thus, it is crucial to develop a computationally efficient model that allows for the 140 investigation of the behavior of random fibrous networks in a 3D framework. 

141 Thus, it can be observed that the existing literature lacks comprehensive studies on the 142 mechanical properties of non-woven fibrous materials in the context of 3D random fibrous 143 networks. Most previous works have primarily focused on 2D structures or have utilized simplified 144 fiber representations, which limit their ability to accurately capture the complex behavior of real145 world non-woven materials. Moreover, the few studies that do consider 3D structures often examine 146 ordered materials with significantly smaller RVEs. Motivated by these research gaps, the objective 147 of this study is to develop a numerical model that accounts for various structural parameters, 148 including porosity, fiber diameter, fiber shape, and the method of fiber binding. By investigating 149 the mechanical properties of non-woven fibrous materials in their true 3D complexity, this research 150 aims to offer a more comprehensive understanding of their behavior, enabling the optimization of 151 material construction and improvement of operational characteristics. 

152 The paper is structured as follows: in Section 1, we provide an overview of the methodology, 153 including the constitutive model, properties identification, and a detailed description of the 154 computational workflow using the FEniCSx framework. Section 2 focuses on the model setup, 155 encompassing the problem description, network geometry generation, numerical setup, and an 156 in-depth analysis of mesh convergence. Section 3 presents and discusses the simulation results, 157 and finally, Section 4 provides the concluding remarks for the paper. 

158 **1. Methodology** 

159 In this section, we start with a brief overview of the constitutive model for fibrous systems followed 160 by some general insights into the asymptotic homogenization method. Subsequently, we introduce 161 the details of our computational workflow and the tools used in our study. 

4 

- 162 _1.1. Constitutive model and properties of fibrous network_ 

163 In this study, we consider a fibrous porous network made of polypropylene (PP) fibers. PP can be 164 considered as isotropic material, meaning that its mechanical properties are independent of the 165 direction. This assumption simplifies the modeling process and allows for a more straightforward 166 analysis of the fibrous network. The constitutive model used to describe the behavior of the fibrous 167 network is given through the constitutive relation 

## 168 

**==> picture [252 x 12] intentionally omitted <==**

169 where _**σ**_ is the Cauchy stress tensor, 4 **C** _f_ is the 4th order elasticity tensor and _**ϵ**_ is the symmetric 170 strain tensor. In Voigt notation, the elasticity tensor 4 **C** _f_ can be expressed as: 

171 

**==> picture [389 x 84] intentionally omitted <==**

172 where _E f_ and _ν f_ are Young’s modulus and Poisson’s ratio of the fibers material. 

173 Other important parameters in characterizing the fibrous network’s mechanical behavior are 174 its volume fraction and porosity. Volume fraction _ϕ_ represents the proportion of the total volume 175 occupied by the fibers in the network and can be calculated as 

176 

**==> picture [246 x 26] intentionally omitted <==**

177 where _Vf_ is the fibers’ volume and _Vt_ , is the total volume of the RVE. The porosity _η_ is defined as: 

178 

**==> picture [283 x 27] intentionally omitted <==**

179 where _Vv_ is the volume of voids in the specimen. These parameters affect key properties such as 180 stiffness, strength, and overall deformation response. 

181 _1.2. Extracting effective property via homogenization_ 

182 The asymptotic homogenization method, proposed by Bahvalov [6] and further developed 183 by Bensoussan, Lions, and Papanicolaou [9], Sánchez-Palencia [54], Pobedrja [51], Bahvalov184 Panaskenko [5], and others, is used to determine the effective properties of fibrous nonwoven 185 materials among many other materials [34, 60, 59, 27, 43]. The details of this method are well 186 described in the works of Panasenko [47] and Sokolov [31]. 

187 The main idea of asymptotic homogenization is to divide the solution domain into two distinct 188 levels: the microscopic scale with a characteristic size of _l_ and the macroscopic scale with a 189 characteristic size of _L_ , such that _l << L_ . At the microscopic scale, the domain is represented as 190 a heterogeneous structure with periodicity. At the macroscopic scale, the material is considered 191 homogeneous with certain averaged characteristics. 

192 As shown in Figure 2, the governing equations for the linear elasticity within a domain _Ω_ with 193 boundary _∂Ω_ will take the form: 

**==> picture [283 x 57] intentionally omitted <==**

194 

5 

**==> picture [217 x 180] intentionally omitted <==**

**----- Start of picture text -----**<br>
T<br>∂Ω<br>T<br>∂Ω<br>u<br>∂Ω<br>ue Ω<br>**----- End of picture text -----**<br>


**Figure 2.** Linear elasticity problem domain with boundary and applied boundary conditions 

4 195 where **u** is displacements vector, _**ϵ**_ and _**σ**_ denote strain and stress tensors respectively, and **C** 196 denotes 4[th] rank tensor of elastic properties. The boundary conditions are presented as known 197 displacements and surface tractions on the outer boundary: 

198 

**==> picture [285 x 29] intentionally omitted <==**

199 For the homogenization procedure, we will use the Voigt notation, according to which the stress 200 and strain tensors are represented as a vector: 

201 

**==> picture [365 x 79] intentionally omitted <==**

202 Then the stiffness can be determined as: 

203 

**==> picture [267 x 15] intentionally omitted <==**

204 where **C** _e f[v] f_[is][averaged][matrix][of][elastic][properties,] _[〈]_ _**[ϵ]**[v][ 〉]_[and] _[〈]_ _**[σ]**[v][ 〉]_[are][average][strain][and][stress] 205 vectors within the volume of the RVE _V_ , and are determined according to: 

206 

207 

208 

**==> picture [276 x 79] intentionally omitted <==**

209 After the averaging process, any solutions of the system of equations (5)–(7) with different 210 boundary conditions (8)-(9) must satisfy equation (11). Therefore, to determine the matrix **C** _e f[v] f_[,] 

6 

211 we need to solve 6 different boundary value problems, whose averaged parameters can be expressed 212 as an equation: 

213 

**==> picture [428 x 16] intentionally omitted <==**

214 or 215 

**==> picture [255 x 15] intentionally omitted <==**

216 And then by solving this equation for **C** _e f[v] f_[, we obtain] 

217 

**==> picture [257 x 16] intentionally omitted <==**

218 Here in (15) and (16) we employ matrix multiplication on the tensors written as matrices using Voigt 219 notation, which yields a matrix as the result. 

220 Figure 3 shows three types of boundary conditions that are commonly used in the homogeniza221 tion procedure of heterogeneous media. Here is a brief explanation of each: 

- 222 _•_ Kinematic Uniform Boundary Conditions (KUBC) [28, 9, 29] assumes that the strain field 223 is uniform on the boundary of a cell of a composite material (CM). This type of boundary 224 condition is often used to determine the effective elastic properties of composites. 

- 225 _•_ Static Uniform Boundary Conditions (SUBC) [28, 9, 29] assumes that the stress field is uniform 226 on the boundary of a cell of a composite material. This type of boundary condition is often 227 used to determine the effective strength properties of composites. 

- 228 _•_ Periodic Boundary Conditions (PBC) [26, 5, 47, 44] assumes that the stress and displacement 229 fields are periodic within the domain, with periodicity corresponding to the cell size. This type 230 of boundary condition is commonly employed to evaluate not only mechanical properties but 231 also thermal and hygro properties. It also shows faster convergence of the field of interest, such 232 as displacement or temperature fields. 

**==> picture [114 x 114] intentionally omitted <==**

**==> picture [115 x 114] intentionally omitted <==**

**==> picture [114 x 114] intentionally omitted <==**

**==> picture [260 x 10] intentionally omitted <==**

**----- Start of picture text -----**<br>
a ) b ) c )<br>**----- End of picture text -----**<br>


**Figure 3.** Different types of boundary condition: kinematic uniform ( _a_ ), static uniform ( _b_ ) and periodic ( _c_ ) boundary conditions. 

233 

Other types of BCs used for CM property identification include: 

- 234 _•_ Mixed uniform BCs [42, 46]: These boundary conditions combine two or more types of 235 boundary conditions to model more complex loading and deformation scenarios. 

- 236 _•_ Non-uniform boundary conditions [24]: These boundary conditions assume that the external 237 load or displacement is non-uniform across the unit cell of the composite material. 

7 

238 Although PBC captures the periodicity of the microstructure and it can lead to accurate 239 homogenized properties, it requires a conjoint mesh on the opposite boundaries of the RVE, 240 which can be challenging to achieve for random fibrous networks. KUBC, on the other hand, is 241 simpler to implement and can be applied to any arbitrary geometry without the need for uniformity 242 or periodicity, especially for random media. It is also computationally efficient, since it does 243 not change the dimension of the resolving SLE, and can be applied to large-scale problems [63]. 244 Moreover, since one of the aims of this work was to build a numerical framework that is applicable 245 to various types of networks, the KUBC approach was used in this study. 

246 For KUBC two types of boundary conditions can be considered: the uniaxial tension along the 247 _i_[th] direction and shear in _i − j_ plane. For the first type of boundary condition, the boundary nodes’ 248 displacement will be calculated as: 

249 

**==> picture [276 x 31] intentionally omitted <==**

250 where _L i_ is the RVE size along the i[th] direction. For the second type of boundary condition the 251 boundary nodes’ displacement will be: 

252 

**==> picture [281 x 50] intentionally omitted <==**

253 An example of boundary conditions for applying the shear loading is shown in Figure 4. 

**==> picture [274 x 131] intentionally omitted <==**

**==> picture [38 x 95] intentionally omitted <==**

**==> picture [38 x 95] intentionally omitted <==**

**Figure 4.** Example of applying KUBC for shear loading 

254 Fianlly, the macroscopic strain tensor can be obtained by averaging the local strain tensor over 255 the RVE through the following equations: 

256 

**==> picture [248 x 29] intentionally omitted <==**

257 _1.3. Computational workflow using FEniCSx_ 

258 For the numerical implementation, we chose FEniCSx framework [56, 55], a powerful and versatile, 259 open-source computational tool. FEniCSx provides significant advancements over the legacy 

8 

- 260 version of FEniCS, making it an ideal choice for developing an efficient and robust approach to 261 homogenizing mechanical properties in our study. One primary motivation for selecting FEniCSx 262 is its open-source nature, which promotes inclusivity and accessibility to researchers regardless of 263 their financial resources. This commitment to open science ensures that a broader community of 264 researchers can leverage and benefit from the capabilities offered by FEniCSx. Moreover, FEniCSx 265 offers a wide range of improvements and enhancements compared to its legacy version. It provides 266 comprehensive support for various cell types and elements, along with features like memory 267 parallelization and complex number support. These enhancements improve computational 268 efficiency and extend the range of problems that can be effectively solved. Furthermore, FEniCSx 269 incorporates an enhanced library design, contributing to the overall effectiveness and reliability of 270 the framework in performing complex numerical simulations. 

- 271 To ensure transparency and reproducibility, we have made all the code utilized in this study 272 available on GitHub [36]. Sharing the codebase enables other researchers to easily access and verify 273 the computational workflow, facilitating replicating our results and fostering further advancements 274 

- 275 The generalized flowchart of the computational workflow is shown in Figure 5. This framework 276 comprises three main stages: preprocessing, solving, and postprocessing. The preprocessing stage 277 involves mesh generation using GMSH [25], an open-source mesh generator. GMSH supports 278 the generation of various mesh types, including structured, unstructured, and adaptive meshes, 279 providing flexibility in mesh design. A notable feature of GMSH is its integration with the 280 OpenCASCADE kernel, enabling the creation of complex 2D and 3D geometries using boundary 281 representation (B-Rep) and constructive solid geometry (CSG) techniques. This capability is 282 particularly valuable when simulating the mechanical properties of complex fibrous networks, as it 283 allows for accurate geometry representation. 

**==> picture [376 x 250] intentionally omitted <==**

**----- Start of picture text -----**<br>
API<br>gmsh-script<br>PythonC++ gmsh OCC Vizualization, Plotting, Analysis<br>Julia<br>Paraview<br>PyVista<br>Export mesh to  .msh Export to  .vtk  or  .xdmf<br>Import Mesh Set Solver<br>Assign Material Properties Parameters Compute Averaged<br>Elastic Properties<br>< C ><br>Define Governing Equations in a Weak For each BVP<br>Form<br>∫ Ω [σ] [(] [u] [):] [ε] [(] [v] [)] [dx=] ∫ Ω [f] [·] [vdx +] ∂∫ Ω [T] [·] [vds] BuildAssemble FEProblem: [and Ki ], { Fi } Compute AveragedStress and Strain<br>Assign BC <ε [V] i [>] [=] V [1] ∫ [ε][V] [(] [x] i [)] [dx]<br>Define a Set of Boundary Values Ω<br>Problems for Different BC Solve<br><σ [V]<br>{KUBC, SUBC, PBC, MBC, etc.} [ Ki ]{ ui }={ Fi } i [>] [=] V [1] ∫ Ω [σ][V] [(] [x] i [)] [dx]<br>Preprocessing Postprocessing<br>FEniCSx PETSc<br>Model Initialization<br>Integration and Averaging<br>**----- End of picture text -----**<br>


**Figure 5.** Generalized workflow describing first-order homogenization using FEniCSx 

284 Additionally, GMSH provides multiple programming interfaces, including its own scripting 

9 

285 language, C++, Python, and Julia. The availability of Python programming interfaces is 286 advantageous since FEniCSx also utilizes Python as its primary programming language. This 287 compatibility enables seamless integration between the mesh generation process in GMSH and 288 the subsequent computation stage in FEniCSx. Furthermore, the option to use C++ or Julia 289 programming interfaces offers the possibility to improve the performance and accelerate the 290 computational speed, if required. 

290 291 The main part of the computational workflow consists of three subparts: model initialization, 292 solving the constitutive system of linear equations using PETSc [7, 8], and computation of the 293 averaged mechanical properties. For model initialization, the dolfinx.io module is employed, 294 facilitating the import of the geometry generated in GMSH. Once the geometry is imported, we 295 define the governing equations described by Eq. (5)–(7) in weak form using the Unified Form 296 Language (UFL) [2]. The weak form of these equations takes the following form: 

**==> picture [291 x 12] intentionally omitted <==**

297 

298 where **v** is a test function, defined on the test functions space _V_[ˆ][3] , **u** is the trial function which 299 represents an unknown displacements to be solved, _a_ ( _·_ , _·_ ) and _L_ ( _·_ ) are bilinear and linear form, 300 respectively, which are calculated as: 

301 

**==> picture [292 x 78] intentionally omitted <==**

302 The bilinear form _a_ ( **u** , **v** ) and the linear form _L_ ( **v** ) further are used to assemble stiffness matrix **K** 303 and forces vector **f** which govern a constitutive system of linear equations: 

304 

**==> picture [245 x 11] intentionally omitted <==**

305 where **u** _[n] ∈_ �[3] _[N]_ is a vector of nodal displacements with _N_ - number of degrees of freedom. 306 The solution of the system (23) is obtained using PETSc, which provides various Krylov subspace 307 methods for solving large-scale linear systems efficiently. 

308 The computation of averaged mechanical properties involves the calculation of integrals in Eqs. 309 (12) and (13). FEniCSx simplifies this procedure by utilizing the dolfinx.fem.assemble function, 310 which allows to compute integrals of specified forms formulated using UFL. The final calculation 311 of the averaged mechanical properties can be achieved through Eq.(16). 

312 Lastly, in the postprocessing stage, both ParaView [1, 4] and PyVista [58] were used for the 313 visualization of the computed results. ParaView, a widely recognized and extensively used scientific 314 visualization software, provided us with a comprehensive set of tools for analyzing and visualizing 315 simulation data. To facilitate the visualization process, the mesh with calculated fields is exported 316 to the VTK or XDMF file formats directly, which seamlessly integrates with ParaView. Leveraging 317 ParaView enables interactive exploration and in-depth visualization of the data. Additionally, we 318 utilized PyVista, a Python library, for direct visualization within the Jupyter Notebook environment. 319 PyVista offered a convenient interface for generating high-quality visualizations directly from our 320 computational workflow. With PyVista, we visualized the mesh, displayed the computed results, 321 and created interactive plots within the familiar Jupyter Notebook interface. 

322 **2. Model setup** 

323 This section highlights the numerical model from geometry generation to numerical analysis. It 324 should be noted that in this study, we employed the “quasi-BCC nanogrid” microstructure as 325 previously introduced in [17]. The choice of this microstructure was motivated by its simplicity and 326 inherent randomness, which make it ideal for showcasing the concept of our numerical approach. 

10 

- 327 _2.1. Geometry creation of the fibrous porous network_ 

- 328 The geometry of the investigated material can be described as a quasi-structured fibrous medium 329 with an orthogonal fiber arrangement. The lattice is composed of a triad of three mutually 330 orthogonal fibers with a circular cross-section (see Figure 6–I), intersecting by an amount of _si_ = 331 _d f γ_ , where _d f_ is the fiber diameter, and _γ_ is the intersection ratio. Each fiber axis is then shifted 332 from the triad center by _s_ off = 0.5( _d f − si_ ). 

**==> picture [447 x 332] intentionally omitted <==**

**----- Start of picture text -----**<br>
I IV<br>si<br>y<br>d<br>f<br>x<br>s off<br>P<br>l II III<br>N<br>N<br>**----- End of picture text -----**<br>


**Figure 6.** Structure and geometry of fibrous network: I — geometry of a single fibers’ triad with diameter _d f_ and intersection _si_ ; II — generation of fibers within a grid _N × N_ with a pitch _Pl_ along each basis axes for a given fillness parameter _ψ_ ; III — fusion of all three sets of fibers; IV — result network 

333 Within the RVE, the fiber triads are located at the nodes of a simple cubic lattice with a pitch _Pl_ . 334 The maximum number of fibers along one axis is _N_[2] , where _N_ is a grid size. However, structural 335 defects in the form of vacancies (absence of fibers) may occur, resulting in the actual number of 336 fibers along each axis varying within the range 1 _≤ m ≤ N_[2] . The fiber fill fraction of the structure _m_ 337 is characterized by the parameter “fillness” _ψ_ = _N_[2][.][If][the][number][of][fibers][is][different][in][each] 

338 direction, the structure will be characterized by three respective coefficients ( _ψx_ , _ψy_ , _ψz_ ): 

339 

**==> picture [249 x 21] intentionally omitted <==**

340 However, in the current work, the network with equal fillness along all axis ( _ψx_ = _ψy_ = _ψz_ = _ψ_ ) is 341 considered. Thus, the overall actual number of fibers within the RVE is _Nf_ = 3 _m_ . 

11 

- 342 To ensure the connectivity of the structure during RVE generation, the vacancies are randomly 343 distributed on two of the base planes (see Figure 6–II), followed by the computation of all 344 fiber intersections along these two directions. Fibers along the third direction are generated at 345 existing nodes without repetition and then supplemented randomly to reach the desired quantity. 346 Subsequently, cylindrical fibers are generated at the obtained nodes (see Figure 6–III) and fused 347 together into a single body using the fusion (i.e., merge) operation (Figure 6–IV). 

348 It is worth noting that in this work, it is assumed that fibers can only intersect from one side 349 by a fixed amount. Thus, the maximum diameter for the chosen pitch is related by the following 350 dependence: 

351 

**==> picture [253 x 26] intentionally omitted <==**

352 _2.2. Problem description_ 

353 This study focuses on a chemically bonded quasi-structured fibrous media composed of PP fibers. 354 The main properties of the typical PP fibers are presented in Table 1. The network structure is 355 designed to resemble a configuration described in the literature [17]. It is assumed that all fibers 356 intersect with each other, and through a bonding process, the entire network forms a cohesive solid 357 body. 

**Table 1.** The main properties of the typical PP fibers 

|**Property**|**Unit**|**Value**|
|---|---|---|
|Young’s modulus|GPa|1.8|
|Poisson’s ratio|—|0.43|
|Elongation, Yield|—|0.10–0.12|
|Elongation, Break|—|0.50–1.45|
|Density|g<br>mL|0.905|



358 Primarily, the effect of RVE size was investigated through two types of networks: (i) a structured 359 mesh and (ii) a quasi-structured mesh with fillness ratio _ψ_ = 0.5. The results of the first investigation 360 were used to define the size of the RVE for the second investigation. 

- 361 For the structured grid convergence analysis, a porosity of 0.5 was chosen, with a fiber diameter 362 of 0.2 mm and an intersection ratio of 25%. To achieve the target porosity, the spacing between 363 fibers was set at 0.423 mm. Several meshes were generated with varying parameters, including the 364 number of fibers per axis, the overall number of fibers within the RVE, and mesh parameters such 365 as the overall number of nodes and elements. The specific values for these parameters are listed in 366 Table 2. Additionally, Figure 7( _a_ – _b_ ) illustrates the RVEs of structured networks with scale ratios of 1, 367 4, and 7. 

- 368 Similarly, the investigation of convergence on the quasi-structured network was performed. The 369 geometrical fiber parameters such as their diameter and the intersection ratio remained consistent 370 with the structured network, while the porosity was increased to 0.744. The generated networks for 371 scale ratios of 2, 6, and 8 are depicted in Figure 7( _d_ – _f_ ). 372 The second and primary investigations are dedicated to studying the influence of porosity and 373 fiber geometry on the effective mechanical properties of the fibrous porous network. The selected 374 network structure enables the examination of the mechanical properties of the medium with 375 specific porosity values and varying diameters of fibers. This is achieved by adjusting the density 376 of the fiber grid. Additionally, the impact of intersection magnitude, which affects the bonding 377 process, is examined to understand its effect on the mechanical properties. The grid size _N_ of the 378 network was selected as 6 based on the findings from investigating the size effect of the RVE. The 

12 

**Table 2.** Parameters of the RVE of structured network 

|Network Type|Scale ratio|Number of Fibers|Number of DoFs|Number of Elements|
|---|---|---|---|---|
||1|3|20,778|3,636|
|Structured|2<br>3<br>4<br>5<br>6|12<br>27<br>48<br>75<br>108|79,820<br>189,452<br>427,372<br>835,624<br>1,353,934|14,260<br>34,508<br>77,648<br>150,362<br>244,362|
||7|147|2,085,690|376,530|
|Unstructured|2<br>4<br>6<br>8<br>10|6<br>24<br>54<br>96<br>150|37,866<br>161,224<br>498,865<br>1,080,284<br>2,072,314|6,782<br>30,047<br>92,481<br>200,570<br>383,332|



**==> picture [455 x 276] intentionally omitted <==**

**----- Start of picture text -----**<br>
a b c<br>) ) )<br>d e<br>) ) f  )<br>Structured<br>Unstructured<br>**----- End of picture text -----**<br>


**Figure 7.** Examples of the mesh used for the study of the RVE size on the structured ( _a_ – _c_ ) and unstructured ( _d_ – _f_ ) networks with different scale ratios: _a_ ) scale ratio = 1, _b_ ) scale ratio = 4, _c_ ) scale ratio = 7, _d_ ) scale ratio = 2, _e_ ) scale ratio = 6, _f_ ) scale ratio = 10. 

379 grid pitch _Pl_ was 50 _µm_ , so the length of the RVE was _L_ = _Pl N_ = 300 _µm_ . The variable parameters 380 of the investigated network are shown in Table 3. 

13 

**Table 3.** Geometrical properties of the investigated RVEs 

|Fibers<br>number<br>Fillness Fibers’<br>diameter<br>Porosity Intersection<br>ratio|Fibers<br>number<br>Fillness Fibers’<br>diameter<br>Porosity Intersection<br>ratio|
|---|---|
|_Nf_<br>_ψ_<br>_d f_<br>_ϕ_<br>_γ_|_Nf_<br>_ψ_<br>_d f_<br>_ϕ_<br>_γ_|
|—<br>—<br>mm_×_10_−_2<br>—<br>—|—<br>—<br>mm_×_10_−_2<br>—<br>—|
|12<br>0.33<br>1.800<br>0.9<br>0.25<br>18<br>0.50<br>1.470<br>0.9<br>0.25<br>24<br>0.67<br>1.275<br>0.9<br>0.25<br>30<br>0.83<br>1.140<br>0.9<br>0.25<br>12<br>0.33<br>2.550<br>0.8<br>0.25<br>18<br>0.50<br>2.085<br>0.8<br>0.25<br>24<br>0.67<br>1.810<br>0.8<br>0.25<br>30<br>0.83<br>1.620<br>0.8<br>0.25<br>36<br>1.00<br>1.480<br>0.8<br>0.25<br>18<br>0.50<br>2.560<br>0.7<br>0.25<br>24<br>0.67<br>2.221<br>0.7<br>0.25<br>30<br>0.83<br>1.990<br>0.7<br>0.25<br>36<br>1.00<br>1.820<br>0.7<br>0.25<br>12<br>0.33<br>1.815<br>0.9<br>0.40<br>18<br>0.50<br>1.485<br>0.9<br>0.40|24<br>0.67<br>1.290<br>0.9<br>0.40<br>30<br>0.83<br>1.155<br>0.9<br>0.40<br>12<br>0.33<br>2.590<br>0.8<br>0.40<br>18<br>0.50<br>2.120<br>0.8<br>0.40<br>24<br>0.67<br>1.845<br>0.8<br>0.40<br>30<br>0.83<br>1.655<br>0.8<br>0.40<br>36<br>1.00<br>1.515<br>0.8<br>0.40<br>18<br>0.50<br>2.620<br>0.7<br>0.40<br>24<br>0.67<br>2.278<br>0.7<br>0.40<br>30<br>0.83<br>2.045<br>0.7<br>0.40<br>36<br>1.00<br>1.875<br>0.7<br>0.40<br>18<br>0.50<br>3.040<br>0.6<br>0.40<br>24<br>0.67<br>2.645<br>0.6<br>0.40<br>30<br>0.83<br>2.378<br>0.6<br>0.40<br>36<br>1.00<br>2.183<br>0.6<br>0.40|



- 381 

## _2.3. Numerical setup_ 

- 382 The numerical setup employed in this study encompassed an unstructured FEM-mesh comprising 383 27 nodal second-order hexahedral elements. This choice of mesh allowed for an accurate 384 representation of the geometric features and facilitated efficient computations within the FEniCSx 385 framework. The mesh sizes of the RVEs used in this investigation varied within a range of _≈_ 0.4 _×_ 10[6] 386 DoFs up to _≈_ 1.8 _×_ 10[6] DoFs. Additionally, a convergence study was performed using meshes of up 387 to _≈_ 2.2 _×_ 10[6] DoFs. 

- 388 For solving the governing system (23), we utilized the conjugate gradient (CG) method, 389 combined with the multigrid preconditioner. This combination of solvers and preconditioners 390 ensured rapid convergence and efficient solutions to the problem at hand. 

- 391 In our specific project, the utilization of the multigrid preconditioner and conjugate gradient 392 (CG) solver proved to be effective in efficiently handling fairly large problems. For instance, a 393 problem consisting of approximately 4 _×_ 10[5] DoFs was solved within a computational time of fewer 394 than 10 minutes. These computations were performed on a personal computer equipped with an 395 i7-1165G7 2.8 GHz processor and 16GB of RAM. Specifically, the entire computational process was 396 executed within a Docker container installed on Windows Subsystem for Linux 2 (WSL2). It should 397 be noted that running the computations on a native Linux system results in additional performance 398 improvements. 

399 

## _2.4. Mesh convergence_ 

- 400 We investigated the dependence of solution accuracy on element size through systematic variations 401 in mesh parameters and observation of convergence behavior. The convergence study was 402 performed on a representative cell containing a single triad of fibers, with the depicted meshes 403 shown in Figure 8. 

- 404 We evaluated the accuracy of the numerical solution by evaluating the _L_ 2 norm of the error for 405 the components of the elasticity tensor **C** _[h] e f f_[compared to the reference solution] **[C]**[˜] _[e f][f]_[(see. Figure] 

14 

**==> picture [115 x 114] intentionally omitted <==**

**==> picture [114 x 114] intentionally omitted <==**

**==> picture [115 x 114] intentionally omitted <==**

**==> picture [114 x 114] intentionally omitted <==**

**==> picture [351 x 10] intentionally omitted <==**

**----- Start of picture text -----**<br>
a ) b ) c ) d )<br>**----- End of picture text -----**<br>


**Figure 8.** Meshes used for mesh convergence tests: coarse mesh with _h_ = 4.7 _µ_ m ( _a_ ), mean mesh with _h_ = 2.6 _µ_ m ( _b_ ), fine mesh with _h_ = 1.5 _µ_ m ( _c_ ) and reference mesh with _h_ = 1.0 _µ_ m ( _d_ ) 

- 406 

## 8- _a_ ). The _L_ 2 norm is defined as follow: 

**==> picture [474 x 15] intentionally omitted <==**

- 408 where _λi_ is an i[th] eigenvalue of the tensor **A** . In our case it corresponds to the maximum eigenvalue 409 _λ[c]_[the][elasticity][tensor] **[C]**[.][The][reference][solution] **[C]**[˜][was][obtained][using][a][mesh][with][an] _ma x_[of] 

- 410 element size of approximately 1 _µ_ m. Model parameters and corresponding solution errors are 411 provided in Table 4. Figure 9 shows the relationship between the error and element size. Through 412 regression analysis, we determined the convergence rate to be approximately _O_ ( _h_[2.61] ), where _h_ 413 represents the element size. 

**Table 4.** Parameters of the RVE used for mesh convergence investigation 

|Element size,_µ_m<br>DoFs<br>Elements|_L_2(**C**_h_<br>_ef f −_˜**C**_e f f_)<br>_L_2( ˜**C**_e f f_)|
|---|---|
|4.7<br>11,194<br>2,052<br>2.6<br>67,206<br>10,702<br>1.5<br>384,562<br>55,270<br>1.0<br>999,194<br>137,736|38.5_×_10_−_3<br>7.69_×_10_−_3<br>1.57_×_10_−_3<br>—|



- 414 **3. Simulation results and discussion** 

- 415 The following subsections provide an in-depth discussion of the results of our case studies. 

- 416 _3.1. Anisotropy of mechanical properties_ 

- 417 The structure of the selected fibrous media exhibits pronounced asymmetry even in the case of a 418 fully structured case (fillnes=1.0, see Figure 7), leading to the emergence of complex stress states 419 even under KUBC conditions. 

- 420 Due to the weak inter-fiber connectivity, individual fibers are subjected to bending under shear 421 loading. For example, Figure 10 illustrates the displacements fields for an RVE with porosity _ϕ_ = 0.8, 422 fiber diameter _d f_ = 25.5 _µ_ m and fillness _ψ_ = 0.333 subjected to tensile loading ( _a_ ) and shear loading 423 ( _b_ ), with a deformation scale of 0.5. All these factors contribute to the emergence of additional 424 interdependencies between the shear and tensile components of the elasticity matrix. In the case 

15 

**==> picture [253 x 202] intentionally omitted <==**

**----- Start of picture text -----**<br>
)<br>∼( C L 2<br>)/<br>∼( CC L - h 2<br>**----- End of picture text -----**<br>


**Figure 9.** _L_ 2 norm of relative error of effective matrix of elasticity for different average mesh size 

**==> picture [228 x 228] intentionally omitted <==**

**==> picture [228 x 228] intentionally omitted <==**

**==> picture [237 x 10] intentionally omitted <==**

**----- Start of picture text -----**<br>
a ) b )<br>**----- End of picture text -----**<br>


**Figure 10.** Displacements fields for uniform tension ( _a_ ) and shear( _b_ ) of RVE with porosity _ϕ_ = 0.8, fibers’ diameter _d f_ = 25.5 _µ_ m and fillness _ψ_ = 0.333 

- 425 where an equal number of fibers are present along each direction of the base lattice, the elasticity 426 matrix will consist of six distinct components, as shown in Figure 11. It should be mentioned that, 427 due to randomness in structure and computational error, these six components have a variation 428 in values. To represent these variations, min/max ranges are also shown in Figures 12, 13 and 429 14 in addition to the mean values. These components will be further discussed in the following 430 subsections. 

16 

**==> picture [171 x 171] intentionally omitted <==**

**----- Start of picture text -----**<br>
- -<br>C C C C C C<br>1 2 2 5 6 6<br>- -<br>C C C C C C<br>2 1 2 6 5 6<br>- -<br>C C C C C C<br>2 2 1 6 6 5<br>- - -<br>C C C C C C<br>5 6 6 3 4 4<br>C C C C C C<br>6 5 6 4 3 4<br>- - -<br>C C C C C C<br>6 6 5 4 4 3<br>**----- End of picture text -----**<br>


**Figure 11.** Structure of the matrix of elastic properties. 

431 _3.2. Investigation of the scale effect_ 432 Previously, in works [29, 30, 3, 45] was shown that for heterogeneous networks, an improperly 433 chosen mesoscale window can lead to inappropriate results since the volume element is not further 434 “representative.” Thus, in work [45], the SVE was introduced, and it was demonstrated that as 435 the mesoscale size increased, it tended to the RVE. In the following subsection, we examine the 436 effect of the unit cell size to determine the appropriate size of the mesoscale window, which can be 437 considered as representative [33]. 

437 . 438 The resulting values of the elasticity tensor components, namely _C_ 1 and _C_ 4, for various sizes of 439 the unit cell are illustrated in Figure 12. The analysis was performed on both structured networks 440 (with a fillness of _ψ_ = 1.0) and quasi-structured (heterogeneous) networks (with a fillness of _ψ_ = 0.5), 441 constructed according to the parameters outlined in Table 2, respectively. In Figure 12- _a_ , which 442 represents the component _C_ 1, it is evident that the value of _C_ 1 decreases with the increase in 443 the unit cell size, controlled by the base grid size _N_ . The same dependency on unit cell size is 444 observed for components _C_ 2 and _C_ 3 as well. However, the value of the _C_ 4 component increases 445 with an increase in the unit cell size and these variations are relatively small for the quasi-structured 446 networks. Additionally, it should be noticed that component _C_ 1 shows very small variations, 447 whereas component _C_ 4 displays a noticeable variation, which increases with higher network fillness 448 and decreases with larger unit cell size. It can be explained by the fact that the components of 449 the elasticity tensor, which corresponded to the _C_ 1, were responsible only for tension along the 450 basis axes and depended only on the cross-section area, which was equal for each unit cell along 451 all three basis axes. However, component _C_ 4 mainly depends on the fibers’ connection, which 452 is not constant due to the asymmetry of the connection within the triad (see Figure 6) and the 453 heterogeneous structure of unit cells with fillness _ψ ̸_ = 1. It is worth mentioning that the components 454 _C_ 5 and _C_ 6 exhibit similar behavior as component _C_ 4. 

455 While it is commonly accepted that the KUBC overestimates the elastic parameters of the 456 investigated material, Figure 12 demonstrates an opposite trend for component _C_ 4. Moreover, it 457 is important to note that while the change in the unit cell size has a significant impact on the elastic 458 properties of materials with a structured fiber, resulting in a 33% change in the value of component 459 _C_ 1 and over 75% change in the value of component _C_ 4, its effect on materials with heterogeneous 460 fibers is much smaller. However, increasing the unit cell size considerably reduces the variability 461 of components _C_ 4, _C_ 5, and _C_ 6 for heterogeneous materials, whereas its effect on the variation of 462 elastic properties in structured materials is negligible. 

463 Furthermore, this investigation aids in determining the optimal unit cell size to balance 

17 

**==> picture [416 x 166] intentionally omitted <==**

**----- Start of picture text -----**<br>
ψ ψ<br>N N<br>a ) b )<br>C 1 C 4<br>**----- End of picture text -----**<br>


**Figure 12.** The scale effect of unit cell on the components of the elasticity tensor: ( _a_ ) _C_ 1 and ( _b_ ) _C_ 4. 

464 computational efficiency and acceptable accuracy. Based on these considerations, a unit cell with 465 a base grid size of _N_ = 6 was chosen for the subsequent investigation described in Subsection 3.3 466 and will be considered as the RVE. 

- 467 _3.3. Influence of fibers diameter and porosity_ 

- 468 Given the significant influence of fiber diameter on the mechanical properties, particularly the 469 strength and stiffness, of fibrous porous materials, this section focuses on examining the response 470 of the elasticity tensor with respect to variations in fiber diameter. Specifically, Figure 13 illustrates 471 the relationship between the components of the elasticity tensor and the diameter of the fibers for 472 RVEs with an intersection ratio of _γ_ = 0.25 for different values of porosity. 

473 These plots demonstrate that as the porosity increases, the components of the elasticity tensor 474 **C** decrease. A closer look also reveals that the largest change is observed for the porosity of _ϕ_ = 0.7, 475 while for the porosity of _ϕ_ = 0.9, the changes are nearly negligible and comparable to computational 476 errors. Additionally, as the porosity decreases, there is a noticeable reduction in the components of 477 the elasticity tensor when the fiber diameter size increases. However, the most significant changes 478 are observed in the absolute values of components _C_ 1, _C_ 3, and _C_ 2. At a certain point (i.e., higher 479 porosity), these components reach a stable value, and even a slight increase is observed as the role 480 

- 481 In contrast, components _C_ 4, _C_ 5, and _C_ 6 do not reach a stable value. Furthermore, a 50% increase 482 in fiber diameter leads to a multiple decrease in the values of these components. Another interesting 483 observation is that increasing the fiber diameter leads to an increase in the variation of components 484 _C_ 4, _C_ 5, and _C_ 6. 

- 485 The maximum value is observed for components _C_ 1 and the minimal value — for _C_ 4. Moreover, 486 all components can be ordered as follows _C_ 1 _≫ C_ 3 _> C_ 2 _≫ C_ 6 _> C_ 5 _> C_ 4. The low values of 487 components _C_ 4– _C_ 6 is explained by the cubic structure of the network. In the limiting case with high 488 randomness, it may come to the case of anisotropy with cubic symmetry, where these components 489 are equal to zero, which can be observed from the trends of these components plots (see Figure 13). 490 As it was mentioned in the Subsection 3.2, the component _C_ 1 is responsible for the tension along the 491 basis axes. And since the fibers are also located along them, this component has the highest value. 492 The component _C_ 3 is responsible for shear in basis planes, and its low value can be explained by the 493 fact that fibers have weak connections, and during shear, they mainly exhibit bending deformations. 494 Finally, a low value of the component _C_ 2 means that for the chosen geometry, compression along 495 one of the basis axes has little effect on deformation along two other axes. 

18 

**==> picture [416 x 462] intentionally omitted <==**

**----- Start of picture text -----**<br>
725 50<br>Porosity φ : Porosity φ :<br>0.9 0.9<br>700 0.8 40 0.8<br>0.7 0.7<br>675 30<br>650 20<br>625 10<br>10 15 20 25 10 15 20 25<br>Fiber diameter df , µ m Fiber diameter df , µ m<br>70<br>Porosity φ : 8 Porosity φ :<br>0.9 0.9<br>60<br>0.8 0.8<br>0.7 6 0.7<br>50<br>4<br>40<br>2<br>30<br>20 0<br>10 15 20 25 10 15 20 25<br>Fiber diameter df , µ m Fiber diameter df , µ m<br>12 20<br>Porosity φ : Porosity φ :<br>10 0.9 0.9<br>0.8 15 0.8<br>8 0.7 0.7<br>6 10<br>4<br>5<br>2<br>0 0<br>10 15 20 25 10 15 20 25<br>Fiber diameter df , µ m Fiber diameter df , µ m<br>MPa MPa<br>C 1, C 2,<br>MPa MPa<br>C 3, C 4,<br>MPa MPa<br>C 5, C 6,<br>**----- End of picture text -----**<br>


**Figure 13.** Effect of fiber diameter on components of the tensor of elasticity for the network with _γ_ = 0.25 

496 Similarly, the results for RVEs with an intersection ratio of _γ_ = 0.4 are presented in Figure 14. The 497 same effects are observed in these cases as well. However, reaching a stable value is only observed 498 for higher porosities of _ϕ_ = 0.8 and _ϕ_ = 0.9. The changes in components _C_ 1, _C_ 2, and _C_ 3 for a porosity 499 of _ϕ_ = 0.7 are approximately 30 MPa, 15 MPa, and 18 MPa, respectively. In relative terms, these 500 changes correspond to approximately 4%, 20%, and 21%, respectively. For the porosity of _ϕ_ = 0.6, 501 the changes are approximately 60 MPa (7.3%), 30 MPa (30%), and 28 MPa (24%), respectively. 502 Meanwhile, components _C_ 4, _C_ 5, and _C_ 6 decrease by a factor of 2, 3, and 2.5, respectively. 

503 Furthermore, it should be noted that the components of the elasticity tensor **C** for networks with 504 an intersection ratio of _γ_ = 0.4 are significantly larger compared to those with _γ_ = 0.25. For example, 505 the increase in the _C_ 1 component is 3.1% for _ϕ_ = 0.9, 5.2% for _ϕ_ = 0.8, and 10% for _ϕ_ = 0.7. 

19 

**==> picture [416 x 462] intentionally omitted <==**

**----- Start of picture text -----**<br>
850 120<br>Porosity φ : Porosity φ :<br>0.9 0.9<br>100<br>800 0.8 0.8<br>0.7 0.7<br>0.6 80 0.6<br>750<br>60<br>700<br>40<br>650 20<br>10 15 20 25 30 10 15 20 25 30<br>Fiber diameter df , µ m Fiber diameter df , µ m<br>120 15<br>Porosity φ : Porosity φ :<br>0.9 0.9<br>100<br>0.8 0.8<br>0.7 10 0.7<br>80 0.6 0.6<br>60<br>5<br>40<br>20 0<br>10 15 20 25 30 10 15 20 25 30<br>Fiber diameter df , µ m Fiber diameter df , µ m<br>25<br>Porosity φ : Porosity φ :<br>0.9 30 0.9<br>20<br>0.8 0.8<br>0.7 0.7<br>15 0.6 20 0.6<br>10<br>10<br>5<br>0 0<br>10 15 20 25 30 10 15 20 25 30<br>Fiber diameter df , µ m Fiber diameter df , µ m<br>MPa MPa<br>C 1, C 2,<br>MPa MPa<br>C 3, C 4,<br>MPa MPa<br>C 5, C 6,<br>**----- End of picture text -----**<br>


**Figure 14.** Effect of fiber diameter on components of the tensor of elasticity for the network with _γ_ = 0.4 

## **4. Conclusion** 

506 507 The present study introduces a computational model based on the finite element method, which 508 serves as a robust tool for simulating the mechanical properties of porous non-woven fibrous media. 509 This model incorporates the geometric and material characteristics of the fibers and the void spaces, 510 enabling a consistent analysis of the material’s mechanical response. Through systematically 511 varying parameters such as fiber size, porosity, and fiber intersection ratio, we explored their 512 impacts on the mechanical properties of fibrous porous materials. 

- 513 The results demonstrate that the material’s porosity and fibers’ intersection ratio are the primary 514 factors influencing its mechanical behavior within the elastic region. A 10% increase in porosity 515 results in a corresponding up to 10% increase in the value of the _C_ 1 component, assuming the 

20 

- 516 diameter remains constant. Similarly, when the intersection ratio _γ_ is increased from 0.25 to 0.4, 517 there is a 7.3% increase in the value of the _C_ 1 component. 

- 518 For the investigated structure it was observed that as the fiber diameter increases, the structural 519 fillness of the material decreases, even at a fixed porosity. This leads to a higher level of randomness 520 in the material’s structure. Conversely, for smaller fiber diameters, the random fibrous network 521 becomes more structured. This insight provides valuable knowledge for understanding and 522 designing porous non-woven fibrous media, as the level of structural filling directly affects their 523 mechanical properties. Furthermore, the study reveals that the impact of fiber diameter on the 524 mechanical behavior of the material depends on the porosity. For materials with low porosity, both 525 fiber diameter and fillness factor play significant roles in determining the material’s properties. In 526 contrast, materials with high porosity exhibit minimal sensitivity to changes in fiber diameter and 527 

- 528 The analysis of the elasticity tensor components provides valuable insights into the mechanical 529 behavior of the material. Specifically, increasing the fiber diameter leads to a reduction in these 530 components, particularly for _C_ 1, _C_ 2, and _C_ 3. For example, doubling the fiber diameter results in a 531 decrease of up to 60 MPa in _C_ 1 and 25 MPa in _C_ 3. However, it is worth noting that these changes, 532 while significant, are small in relative value, ranging from 7.3% for _C_ 1 to 24% for _C_ 3. Moreover, 533 the _C_ 4, _C_ 5, and _C_ 6 components exhibit even more pronounced reductions, with _C_ 4 decreasing by 534 more than twice and _C_ 5 and _C_ 6 exhibiting approximately three times reduction. This behavior can 535 be attributed to the increase in the heterogeneity in the material’s structure caused by larger fiber 536 diameters, which subsequently leads to reduced anisotropy. These findings align with previous 537 research [13, 19, 32], further confirming the observed effect. Moreover, the study highlights the 538 influence of fiber diameter and fillness factor on the variation of the elasticity tensor components. 539 It was observed that increasing the fiber diameter and decreasing the fillness factor result in an 540 increased variation of the _C_ 4, _C_ 5, and _C_ 6 components, while the variation of the _C_ 1, _C_ 2, and _C_ 3 541 components remains relatively unchanged. 

- 542 At the same time, investigation of the RVEs size effect on the material’s behavior showed that 543 increasing the size of the RVE leads to an increase in the number of fibers, reduces high variation in 544 the _C_ 4, _C_ 5, and _C_ 6 components. These findings provide valuable insights into the computational 545 strategy for modeling non-woven fibrous media. While scaling up the RVE leads to a higher546 dimensional system in the finite element method, thus stabilizing the averaged values, it may 547 present computational challenges. Therefore, alternative approaches, such as two-scale modeling 548 of the media, show promise in addressing these challenges. The two-scale modeling approach 549 involves simulating various variations of the porous material at the microscale and not only 550 calculating the equivalent values of the elastic properties but also their dispersion. Subsequently, 551 at the mesoscale, the material is modeled as a continuum with spatial distributions of properties 552 based on microscale-defined intrinsic laws. This approach shares similarities with the utilization 553 of Stochastic Volume Elements [41, 40] or Stochastic Local FEM [49, 50]. However, modeling the 

- 554 random properties requires the application of uncertainty quantification methods, which will be 555 the focus of future work. 

- 556 

## **Acknowledgments** 

- 557 This work was supported by the National Science Foundation under award No 2033979 through the 558 division of Civil, Mechanical, and Manufacturing Innovation (CMMI). 

- 559 **Author contributions statement** 

- 560 **Mikhail Kuts** : Algorithms, software, modeling, analysis, writing - original draft and editing. **James** 

- 561 **Walker** : Software, network geometry generation, modeling, **Pania Newell** : Conceptualization, 562 supervision, writing- reviewing and editing, funding acquisition. 

21 

## 563 **Declaration of Generative AI and AI-assisted technologies in the writing process** 

- 564 During the preparation of this work, the author(s) used ChatGPT to reduce grammar errors and 565 enhance readability of the original draft of this manuscript. After utilizing this tool, the author(s) 566 reviewed and edited the content as necessary, and take(s) full responsibility for the content of the 567 publication. 

## 568 **References** 

- 569 [1] James Ahrens, Berk Geveci, and Charles Law. “Visualization Handbook”. In: ed. by Charles 570 D. Hansen and Christopher R. Johnson. Burlington, MA, USA: Elsevier Inc., 2005. Chap. Par571 aView: An End-User Tool for Large Data Visualization, pp. 717–731. URL: https://www. 572 sciencedirect.com/book/9780123875822/visualization-handbook. 

- 573 [2] Martin S. Alnæs et al. “Unified Form Language: A Domain-Specific Language for Weak 574 Formulations of Partial Differential Equations”. In: _ACM Trans. Math. Softw._ 40.2 (Mar. 2014). 575 ISSN: 0098-3500. DOI: 10.1145/2566630. URL: https://doi.org/10.1145/2566630. 

- 576 [3] K. Alzebdeh, I. Jasiuk, and M. Ostoja-Starzewski. “Scale and boundary conditions effects in 577 elasticity and damage mechanics of random composites”. In: (1998), pp. 65–80. DOI: 10. 578 1016/S0922-5382(98)80035-4. URL: https://linkinghub.elsevier.com/retrieve/ 579 pii/S0922538298800354. 

- 580 [4] Utkarsh Ayachit. _The paraview guide: a parallel visualization application_ . Kitware, Inc., 2015. 

- 581 [5] N. Bahvalov and G. Panasenko. “Homogenisation: Averaging Processes in Periodic Media”. 582 In: 36 (1989). DOI: 10.1007/978-94-009-2247-1. URL: http://link.springer.com/10. 583 1007/978-94-009-2247-1. 

- 584 [6] N. S. Bahvalov. “Averaged characteristics of bodies with periodic structure”. In: _Dokl. Akad._ 585 _Nauk SSSR_ 218 (1974), pp. 1046–1048. ISSN: 0002-3264. 

- 586 [7] Satish Balay et al. “Efficient Management of Parallelism in Object Oriented Numerical 587 Software Libraries”. In: _Modern Software Tools in Scientific Computing_ . Ed. by E. Arge, A. M. 588 Bruaset, and H. P. Langtangen. Birkhäuser Press, 1997, pp. 163–202. 

- 589 [8] Satish Balay et al. _PETSc Web page_ . https://petsc.org/. 2023. URL: https://petsc.org/. 

- 590 [9] Alain. Bensoussan, J.-L. (Jacques-Louis) Lions, and George Papanicolaou. _Asymptotic analysis_ 591 _for periodic structures_ . North-Holland Pub. Co., 1978, p. 700. ISBN: 9780444851727. 

- 592 [10] S. Borodulina, H. R. Motamedian, and A. Kulachenko. “Effect of fiber and bond strength 593 variations on the tensile stiffness and strength of fiber networks”. In: _International Journal of_ 594 _Solids and Structures_ 154 (Dec. 2018), pp. 19–32. ISSN: 00207683. DOI: 10.1016/j.ijsolstr. 595 2016.12.013. 

- 596 [11] Svetlana Borodulina et al. “Stress-strain curve of paper revisited”. In: _Nordic Pulp & Paper_ 597 _Research Journal_ 27 (2 May 2012), pp. 318–328. ISSN: 2000-0669. DOI: 10.3183/npprj-2012598 27-02-p318-328. URL: https://www.degruyter.com/document/doi/10.3183/npprj599 2012-27-02-p318-328/html. 

- 600 [12] E. Bosco, R. H. J. Peerlings, and M. G. D. Geers. “Asymptotic homogenization of hygro-thermo601 mechanical properties of fibrous networks”. In: (Sept. 2016). DOI: 10.1016/j.ijsolstr. 602 2017.03.015. URL: http://arxiv.org/abs/1609.07622%20http://dx.doi.org/10. 603 1016/j.ijsolstr.2017.03.015. 

- 604 [13] E. Bosco, R. H.J. Peerlings, and M. G.D. Geers. “Hygro-mechanical properties of paper fibrous 605 networks through asymptotic homogenization and comparison with idealized models”. In: 606 _Mechanics of Materials_ 108 (May 2017), pp. 11–20. ISSN: 01676636. DOI: 10.1016/j.mechmat. 607 2017.01.013. 

22 

- 608 [14] Emanuela Bosco, Ron H.J. Peerlings, and Marc G.D. Geers. “Predicting hygro-elastic 609 properties of paper sheets based on an idealized model of the underlying fibrous network”. 610 In: _International Journal of Solids and Structures_ 56 (Mar. 2015), pp. 43–52. ISSN: 00207683. 611 DOI: 10.1016/j.ijsolstr.2014.12.006. 

- 612 [15] Emanuela Bosco et al. “Hygro-mechanics of fibrous networks: A comparison between micro613 scale modelling approaches”. In: Elsevier, Jan. 2022, pp. 179–201. ISBN: 9780128222072. DOI: 614 10.1016/B978-0-12-822207-2.00009-X. 

- 615 [16] Xiaoming Chen et al. “Three-dimensional needle-punching for composites A review”. In: 616 _Composites Part A: Applied Science and Manufacturing_ 85 (June 2016), pp. 12–30. ISSN: 1359617 835X. DOI: 10.1016/J.COMPOSITESA.2016.03.004. 

- 618 [17] Hongwei Cheng et al. “Mechanical metamaterials made of freestanding quasi-BCC nanolat619 tices of gold and copper with ultra-high energy absorption capacity”. In: _Nature Communi-_ 620 _cations_ 14 (1 Dec. 2023). ISSN: 20411723. DOI: 10.1038/s41467-023-36965-4. 

- 621 [18] H L Cox. “The elasticity and strength of paper and other fibrous materials”. In: _British Journal_ 622 _of Applied Physics_ 3 (3 Mar. 1952), pp. 72–79. ISSN: 0508-3443. DOI: 10.1088/0508-3443/3/ 623 3/302. 

- 624 [19] V. Cucumazzo et al. “Anisotropic mechanical behaviour of calendered nonwoven fabrics: 625 Strain-rate dependency”. In: _Journal of Composite Materials_ 55 (13 June 2021), pp. 1783–1798. 626 ISSN: 1530793X. DOI: 10.1177/0021998320976795. 

- 627 [20] Vincenzo Cucumazzo and Vadim V. Silberschmidt. “Mechanical Behaviour of Nonwovens: 628 Continuous Approach with Parametric Finite-element Modelling”. In: vol. 451. July 2022, 629 pp. 35–70. DOI: 10.1007/978-3-031-18393-5_4. URL: https://link.springer.com/ 630 10.1007/978-3-031-18393-5_4. 

- 631 [21] H. Dabiryan et al. “Simulating the structure and air permeability of needle-punched 632 nonwoven layer”. In: _Journal of the Textile Institute_ 109 (8 Aug. 2018), pp. 1016–1026. ISSN: 633 17542340. DOI: 10.1080/00405000.2017.1398060. 

- 634 [22] Farukh Farukh et al. “Meso-scale deformation and damage in thermally bonded nonwovens”. 635 In: _Journal of Materials Science_ 48 (6 Mar. 2013), pp. 2334–2345. ISSN: 00222461. DOI: 10.1007/ 636 s10853-012-7013-y. 

- 637 [23] Jean François Ganghoffer et al. “Prediction of the Effective Mechanical Properties of Regular 638 and Random Fibrous Materials Based on the Mechanics of Generalized Continua”. In: _CISM_ 639 _International Centre for Mechanical Sciences, Courses and Lectures_ 596 (2020), pp. 63–122. 640 ISSN: 23093706. DOI: 10.1007/978-3-030-23846-9_2. 

- 641 [24] M. G.D. Geers, V. Kouznetsova, and W. A.M. Brekelmans. “Gradient-enhanced computational 642 homogenization for the micro-macro scale transition”. In: _Journal de Physique IV, Colloque_ 643 11 (5 2001), pp. 145–152. ISSN: 1155-4339. DOI: 10 . 1051 / JP4 : 2001518. URL: https : 644 / / research . tue . nl / en / publications / gradient - enhanced - computational - 645 homogenization-for-the-micro-macr. 

- 646 [25] Christophe Geuzaine and Jean-François Remacle. “Gmsh: A 3-D finite element mesh 647 generator with built-in pre- and post-processing facilities”. In: _International Journal for_ 648 _Numerical Methods in Engineering_ 79 (11 Sept. 2009), pp. 1309–1331. ISSN: 00295981. DOI: 649 10.1002/nme.2579. URL: https://onlinelibrary.wiley.com/doi/10.1002/nme.2579. 

- 650 [26] Z. Hashin and S. Shtrikman. “A variational approach to the theory of the elastic behaviour 651 of multiphase materials”. In: _Journal of the Mechanics and Physics of Solids_ 11 (2 Mar. 1963), 652 pp. 127–140. ISSN: 0022-5096. DOI: 10.1016/0022-5096(63)90060-7. 

- 653 [27] Bang He, Louis Schuler, and Pania Newell. “A numerical-homogenization based phase654 field fracture modeling of linear elastic heterogeneous porous media”. In: _Computational_ 655 _Materials Science_ 176 (2020), p. 109519. 

23 

- 656 [28] R. Hill. “Elastic properties of reinforced solids: Some theoretical principles”. In: _Journal of the_ 657 _Mechanics and Physics of Solids_ 11 (5 Sept. 1963), pp. 357–372. ISSN: 0022-5096. DOI: 10.1016/ 658 0022-5096(63)90036-X. 

- 659 [29] C. Huet. “Application of variational concepts to size effects in elastic heterogeneous bodies”. 660 In: _Journal of the Mechanics and Physics of Solids_ 38 (6 Jan. 1990), pp. 813–841. ISSN: 0022-5096. 661 DOI: 10.1016/0022-5096(90)90041-2. 

- 662 [30] Christian Huet. “Coupled size and boundary-condition effects in viscoelastic heterogeneous 663 and composite bodies”. In: _Mechanics of Materials_ 31 (12 Dec. 1999), pp. 787–829. ISSN: 664 01676636. DOI: 10.1016/S0167-6636(99)00038-1. URL: https://linkinghub.elsevier. 665 com/retrieve/pii/S0167663699000381. 

- 666 [31] Dimitrienko Yuriy Ivanovich and Alexander Pavlovich Sokolov. _Metod konechnykh elementov_ 667 _dlja reshenia lokal’nykh zadach mekhaniki kompozitsionykh materialov [Finite element_ 668 _method for solving local problems of mechanics of composite materials]_ . BMSTU Publ., 2010, 669 p. 66. 

- 670 [32] Alp Karakoc, Jouni Paltakari, and Ertugrul Taciroglu. “On the computational homogenization 671 of three-dimensional fibrous materials”. In: _Composite Structures_ 242 (June 2020), p. 112151. 672 ISSN: 0263-8223. DOI: 10.1016/J.COMPSTRUCT.2020.112151. 

- 673 [33] Varvara Gennadyevna Kouznetsova and Technische Universiteit Eindhoven. _Computational_ 674 _homogenization for the multi-scale analysis of multi-phase materials_ . Technische Universiteit 675 Eindhoven, 2002. ISBN: 9038627343. 

- 676 [34] VG Kouznetsova, Marc GD Geers, and WAM1112 Brekelmans. “Multi-scale second-order 677 computational homogenization of multi-phase materials: a nested finite element solution 678 strategy”. In: _Computer methods in applied Mechanics and Engineering_ 193.48-51 (2004), 679 pp. 5525–5550. 

- 680 [35] Artem Kulachenko and Tetsu Uesaka. “Direct simulations of fiber network deformation and 681 failure”. In: _Mechanics of Materials_ 51 (Aug. 2012), pp. 1–14. ISSN: 01676636. DOI: 10.1016/j. 682 mechmat.2012.03.010. 

- 683 [36] M. S. Kuts and J. T. Walker. _Fibrous porous media homogenization_ . https://github.com/ 684 kutsjuice/Fibrous-porous-media-homogenization. 2023. 

- 685 [37] Qiang Liu et al. “Experimental and FEM analysis of the compressive behavior of 3D random 686 fibrous materials with bonded networks”. In: _Journal of Materials Science_ 49 (3 Feb. 2014), 687 pp. 1386–1398. ISSN: 00222461. DOI: 10.1007/S10853- 013- 7823- 6/FIGURES/11. URL: 688 https://link.springer.com/article/10.1007/s10853-013-7823-6. 

- 689 [38] Qiang Liu et al. “Finite element analysis on tensile behaviour of 3D random fibrous materials: 690 Model description and meso-level approach”. In: _Materials Science and Engineering A_ 587 691 (Dec. 2013), pp. 36–45. ISSN: 09215093. DOI: 10.1016/J.MSEA.2013.07.087. 

- 692 [39] Zixing Lu et al. “Experiment and modeling on the compressive behaviors for porous silicon 693 nitride ceramics”. In: _Materials Science and Engineering A_ 559 (Jan. 2013), pp. 201–209. ISSN: 694 09215093. DOI: 10.1016/J.MSEA.2012.08.081. 

- 695 [40] Rami Mansour and Artem Kulachenko. “Stochastic constitutive model of thin fibre networks”. 696 In: Elsevier, Jan. 2022, pp. 75–112. ISBN: 9780128222072. DOI: 10.1016/B978-0-12-822207697 2.00014-3. 

- 698 [41] Rami Mansour et al. “Stochastic constitutive model of isotropic thin fiber networks based on 699 stochastic volume elements”. In: _Materials_ 12 (3 Feb. 2019). ISSN: 19961944. DOI: 10.3390/ 700 ma12030538. 

24 

- 701 [42] H. Moulinec and Pierre Suquet. “A fast numerical method for computing the linear and 702 nonlinear mechanical properties of composites”. In: _Comptes Rendus de l’Académie des_ 703 _sciences. Série II. Mécanique, physique, chimie, astronomie_ (1994). URL: https : / / hal . 704 science/hal-03019226%20https://hal.science/hal-03019226/document. 

- 705 [43] Pania Newell et al. “Numerical Investigation of Hydraulically-Driven and Chemically-Driven 706 Fractures in Geological Subsurface”. In: _AGU Fall Meeting Abstracts_ . Vol. 2020. 2020, MR001– 707 0002. 

- 708 [44] Martin Ostoja-Starzewski. “Material spatial randomness: From statistical to representative 709 volume element”. In: _Probabilistic Engineering Mechanics_ 21.2 (2006), pp. 112–132. ISSN: 710 0266-8920. DOI: https://doi.org/10.1016/j.probengmech.2005.07.007. URL: https: 711 //www.sciencedirect.com/science/article/pii/S0266892005000433. 

- 712 [45] Martin Ostoja-Starzewski. “Material spatial randomness: From statistical to representative 713 volume element”. In: _Probabilistic Engineering Mechanics_ 21 (2 Apr. 2006), pp. 112–132. ISSN: 714 02668920. DOI: 10.1016/j.probengmech.2005.07.007. 

- 715 [46] D H Pahr and H J Böhm. _Assessment of Mixed Uniform Boundary Conditions for Predicting_ 716 _the Mechanical Behavior of Elastic and Inelastic Discontinuously Reinforced Composites_ . 2008, 717 pp. 1–12. 

- 718 [47] G. P. Panasenko. “Homogenization for periodic media: From microscale to macroscale”. 719 In: _Physics of Atomic Nuclei_ 71 (4 Apr. 2008), pp. 681–694. ISSN: 10637788. DOI: 10.1134/ 720 S106377880804008X/METRICS. URL: https://link.springer.com/article/10.1134/ 721 S106377880804008X. 

- 722 [48] R. C. Picu. “Mechanics of random fiber networksa review”. In: _Soft Matter_ 7 (15 July 2011), 723 pp. 6768–6785. ISSN: 1744-6848. DOI: 10.1039/C1SM05022B. URL: https://pubs.rsc. 724 org/en/content/articlehtml/2011/sm/c1sm05022b%20https://pubs.rsc.org/en/ 725 content/articlelanding/2011/sm/c1sm05022b. 

- 726 [49] Dmytro Pivovarov et al. “On periodic boundary conditions and ergodicity in computational 727 homogenization of heterogeneous materials with random microstructure”. In: _Computer_ 728 _Methods in Applied Mechanics and Engineering_ 357 (Dec. 2019). ISSN: 00457825. DOI: 10. 729 1016/j.cma.2019.07.032. 

- 730 [50] Dmytro Pivovarov et al. “Stochastic local FEM for computational homogenization of hetero731 geneous materials exhibiting large plastic deformations”. In: _Computational Mechanics_ 69 (2 732 Feb. 2022), pp. 467–488. ISSN: 14320924. DOI: 10.1007/s00466-021-02099-x. 

- 733 [51] B. E. Pobedrya. “Numerical solution of problems of the mechanics of a deformable solid 734 inhomogeneous body”. In: _Vestnik Moskov. Univ. Ser. I Mat. Mekh._ 4 (1983), pp. 78–85. ISSN: 735 0201-7385. 

- 736 [52] Y. Rahali, I. Goda, and J. F. Ganghoffer. “Numerical identification of classical and nonclassical 737 moduli of 3D woven textiles and analysis of scale effects”. In: _Composite Structures_ 135 (Jan. 738 2016), pp. 122–139. ISSN: 0263-8223. DOI: 10.1016/J.COMPSTRUCT.2015.09.023. 

- 739 [53] P. Samantray et al. “Role of inter-fibre bonds and their influence on sheet scale behaviour of 740 paper fibre networks”. In: _International Journal of Solids and Structures_ 256 (Dec. 2022). ISSN: 741 00207683. DOI: 10.1016/j.ijsolstr.2022.111990. 

- 742 [54] E. Sánchez-Palencia. “Non-Homogeneous Media and Vibration Theory”. In: _Lecture Note in_ 743 _Physics, Springer-Verlag_ 320 (1980), pp. 57–65. URL: https : / / cir . nii . ac . jp / crid / 744 1571980073995060480. 

- 745 [55] Matthew W. Scroggs et al. “Basix: a runtime finite element basis evaluation library”. In: _Journal_ 746 _of Open Source Software_ 7 (73 May 2022), p. 3982. ISSN: 2475-9066. DOI: 10.21105/joss. 747 03982. 

25 

- 748 [56] Matthew W. Scroggs et al. “Construction of Arbitrary Order Finite Element Degree-of749 Freedom Maps on Polygonal and Polyhedral Cell Meshes”. In: _ACM Trans. Math. Softw._ 48.2 750 (May 2022). ISSN: 0098-3500. DOI: 10.1145/3524456. URL: https://doi.org/10.1145/ 751 3524456. 

- 752 [57] E. Sozumert et al. “Damage mechanisms of random fibrous networks”. In: vol. 628. Institute 753 of Physics Publishing, July 2015. DOI: 10.1088/1742-6596/628/1/012093. 

- 754 [58] C. Bane Sullivan and Alexander Kaszynski. “PyVista: 3D plotting and mesh analysis through a 755 streamlined interface for the Visualization Toolkit (VTK)”. In: _Journal of Open Source Software_ 756 4.37 (May 2019), p. 1450. DOI: 10.21105/joss.01450. URL: https://doi.org/10.21105/ 757 joss.01450. 

- 758 [59] Bozo Vazic, Bilen Emek Abali, and Pania Newell. “Determining parameters in generalized 759 thermomechanics for metamaterials by means of asymptotic homogenization”. In: _arXiv_ 760 _preprint arXiv:2207.03353_ (2022). 

- 761 [60] Bozo Vazic, Bilen Emek Abali, and Pania Newell. “Generalized thermo-mechanical framework 762 for heterogeneousmaterials through asymptotic homogenization”. In: _Continuum Mechanics_ 763 _and Thermodynamics_ 35 (1 Jan. 2023), pp. 159–181. ISSN: 14320959. DOI: 10.1007/s00161764 022-01171-y. 

- 765 [61] Bozo Vazic et al. “Mechanical analysis of heterogeneous materials with higher-order 766 parameters”. In: _Engineering with Computers_ 38 (6 Dec. 2022), pp. 5051–5067. ISSN: 14355663. 767 DOI: 10.1007/s00366-021-01555-9. 

- 768 [62] C. Veyhl et al. “On the mechanical properties of sintered metallic fibre structures”. In: 769 _Materials Science and Engineering A_ 562 (Feb. 2013), pp. 83–88. ISSN: 09215093. DOI: 10.1016/ 770 j.msea.2012.11.034. 

- 771 [63] David J. Walters, Darby J. Luscher, and John D. Yeager. “Considering computational speed vs. 772 accuracy: Choosing appropriate mesoscale RVE boundary conditions”. In: _Computer Methods_ 773 _in Applied Mechanics and Engineering_ 374 (2021), p. 113572. ISSN: 0045-7825. DOI: https: 774 //doi.org/10.1016/j.cma.2020.113572. URL: https://www.sciencedirect.com/ 775 science/article/pii/S004578252030757X. 

- 776 [64] Korhan Babacan Yilmaz et al. “A brief review on the mechanical behavior of nonwoven 777 fabrics”. In: _Journal of Engineered Fibers and Fabrics_ 15 (2020). ISSN: 15589250. DOI: 10.1177/ 778 1558925020970197. 

26 

