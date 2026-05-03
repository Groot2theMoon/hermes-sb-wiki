---
title: "Microscale modelling of nonwoven material compression"
journal: "10.1002/pamm.202400176"
authors: ["Wan"]
year: 2024
source: paper
ingested: 2026-05-03
sha256: 53c1e713f53022fdf7f5525652d87182fc05f80653239a2239a8439bb7be48f7
conversion: pymupdf4llm
---

Received: 30 May 2024 Accepted: 25 September 2024 

DOI: 10.1002/pamm.202400176 

**R E S E A RC H A RT I C L E** 

**==> picture [77 x 16] intentionally omitted <==**

**==> picture [76 x 24] intentionally omitted <==**

## **Microscale modelling of non-woven material compression** 

## **Chengrui Wan[1] Yousef Heider[2] Bernd Markert[1]** 

1Institute of General Mechanics, RWTH Aachen University, Aachen, Germany 

2Institute of Mechanics and Computational Mechanics, Leibniz Universität Hannover, Hannover, Germany 

## **Correspondence** 

Chengrui Wan, Institute of General Mechanics, RWTH Aachen University, Eilfschornsteinstr 18, 52062 Aachen, Germany. Email: chengrui.wan@iam.rwth-aachen.de 

## **Funding information** 

German Research Foundation, Grant/Award Number: 516937265 

## **Abstract** 

This research presents a discrete numerical model designed to simulate the uniaxial compression of non-woven materials composed of entangled, noncross-linked fibre systems. These materials undergo varying compression states, particularly during processes such as needle-punching in their production. Understanding the microstructure at different compression states is critical to accurately simulate the macroscopic behaviour of non-woven materials in such scenarios. The implementation of our numerical model, which uses force-based dynamics for discrete particles, incorporates recovery forces originating from fibre elasticity and repulsive forces at fibre contacts. The frictional behaviour of the fibres is also described in the numerical model. The algorithm has been optimised for improved computational efficiency when simulating large numbers of fibres. Given the initial configuration of the fibre system, the model is capable of simulating the compressed fibre system at any compression state. It also provides a load-compression relationship, thus serving as a homogenisation method for understanding the mechanical behaviour of such microstructural materials. 

## **K E Y WO R D S** 

compression, computational modelling, microstructural mechanics, non-woven materials 

## **1 INTRODUCTION** 

Non-woven materials are essential components in a wide range of industrial applications, requiring continuous optimisation of manufacturing processes and material performance. Needle-punching, one of the most common manufacturing processes for non-woven fabrics, has shown potential for improvement through the introduction of vibration to reduce machine wear and fibre damage [1]. A comprehensive understanding of the underlying mechanics of the material during needle-punching, particularly as it undergoes different compression states, is critical to achieving these optimisations. To this end, we envisage a multiscale approach, starting with a microscopic study of the fibre system, followed by the application of macroscopic frameworks such as the theory of porous media [2, 3]. 

A critical first step in this multiscale investigation is to characterise the fibre system of the material at different compression levels. While CT scanning provides a direct imaging approach, it may be inefficient to scan at each compression level. To address this challenge and to lay the groundwork for the broader future study, a numerical model to simulate the compression of non-woven materials is desirable. Previous research in this domain has yielded valuable insights. In ref. [4], a finite element model was developed for concentrated random-fibre networks. In ref. [5], a finite element model was developed to predict the behaviour of entangled, cross-linked fibrous material under compression. Both refs. [4] and [5] 

This is an open access article under the terms of the Creative Commons Attribution-NonCommercial License, which permits use, distribution and reproduction in any medium, provided the original work is properly cited and is not used for commercial purposes. © 2024 The Author(s). _Proceedings in Applied Mathematics & Mechanics_ published by Wiley-VCH GmbH. 

wileyonlinelibrary.com/journal/pamm **1 of 12** 

_Proc. Appl. Math. Mech._ 2024;e202400176. https://doi.org/10.1002/pamm.202400176 

**2 of 12** 

used 3D beam elements for the fibres and performed the simulations in ABAQUS/Explicit. The problem with such finite element models is that a high target volume fraction cannot be achieved after compression. Meanwhile, Rodney et al. proposed a 3D discrete model for semiflexible fibres based on molecular dynamics simulations [6], where the fibres were discretised as beads contacting with each other. Based on their work, Barbier et al. investigated fibres with larger aspect ratios and the influence of static friction at the contacts [7]. In ref. [8], an algorithm was developed to generate bending hardcore fibres, where the repulsion force and the recovery force were employed to model the behaviour of the fibres. A parametrised model for the 3D microstructure of compressed fibre-based materials was introduced in ref. [9], which is a two-stage approach combining a translation algorithm and the iterative avoidance algorithm introduced in ref. [8]. The discrete models in refs. [6–9] allow compression up to high volume fractions. However, there is no proof that the elastic and contact behaviour of the fibres is correctly reconstructed. 

The aim of our research is to develop a discrete numerical model for the compression of the entangled, non-cross-linked fibre system of non-woven fabric materials, with a focus on accurately reconstructing the elastic and contact behaviour of fibres. We employ a molecular dynamics simulation algorithm akin to those in refs. [6, 7], while investigating strategies to improve numerical efficiency and convergence. This model not only provides an efficient way to capture the deformation in the fibre system during compression but also gives insight into the micromechanics of the material. 

## **2 METHOD** 

In this section, we introduce a computational model for the uniaxial compression of an entangled, non-cross-linked fibre system. The fibre box, on which the compression model is based, is defined in 2.1. The framework of the compression algorithm is presented in 2.2. The forces that determine the elastic and contact behaviour of the fibres during compression are respectively defined in 2.3 and 2.4. Finally, in 2.5, the convergence of the compression model and attempts to improve it are discussed. 

## **2.1 Configuration of the fibre system** 

In this study, numerical compression is applied to a cubic cell of the fibre system, designated as the fibre box  = {𝑖} with 𝑖= 1, 2, … , 𝑛𝐹 referring to the index of the fibres in the box, and 𝑛𝐹 being the total number of fibres. Each fibre 𝑖 is represented by its centreline, which is further discretised as a polygon line, whose nodes are denoted as 𝑷𝑖,𝑗 = (𝑥𝑖,𝑗, 𝑦𝑖,𝑗, 𝑧𝑖,𝑗) with 𝑗= 1, 2, … referring to the index of the nodes of 𝑖. 

In order to perform numerical compression, it is necessary to know the topology of the original fibre system. This can be determined by examining samples of material using CT scans, which produce 3D binary images of the samples. These images can then be used to identify the fibres present in the sample. This identification process can be carried out in a number of ways. In ref. [10], a segmentation algorithm is proposed to automatically extract individual fibres from 3D tomographic data. A method based on the analysis of the local fibre orientation map was proposed in ref. [11]. More recently, an approach based on a convolutional neural network has been proposed by Grießr et al. [12]. 

In this paper, however, the demonstration of the numerical compression is carried out using a fibre box comprising stochastically generated fibres. Assuming that fibres do not terminate within the representative cell of the fibre system, a fibre is generated according to the following process: 

1. First, a random point on the surface of the fibre box is selected as the initial node of the fibre. 

2. Second, a random ‘growing’ direction is picked within the box. The second node of the fibre is chosen in this direction at a given node distance 𝐷. 

3. The next growing direction is randomly chosen within a maximum deviation angle from the present direction. This maximum deviation angle is determined by the node distance 𝐷 and the specified maximum fibre curvature 𝜅𝑚𝑎𝑥. The fibre then grows a step further in the new direction. 

4. The process described in step 3 is repeated until the fibre reaches the surface of the fibre box again. 

In order to avoid the overlapping of fibres in such a stochastically generated fibre box, the balancing step in the algorithm introduced in 2.2 is performed. This ensures that the overlapping fibres can be repelled apart by the repulsive contact forces. 

**3 of 12** 

WAN et al. 

## **2.2 Basic scheme of the compression algorithm** 

The numerical compression in this study is realised in a series of subsequent compression steps. In each compression step, the fibre box begins with the result of the previous step and is then subjected to a slight further compression. The compression model proposed in this study allows for the achievement of a very high compression ratio after a number of compression steps. Each compression step is comprised of two substeps, that is, shifting and balancing. In the _shifting step_ , the fibre nodes are translated in the compression direction. Subsequently, the fibre system is in an unbalanced state, characterised by distortion and overlapping of the fibres. In the subsequent _balancing step_ , various forces on the fibre nodes are defined. The fibre nodes are driven by these forces until they reach a state of equilibrium, where the total force on each node is zero. The forces defined in this study include recovery forces, which originate from the elastic potentials of the fibres and control the fibres’ deformation. Repulsive contact forces are also included, which reconstruct the contact behaviour of overlapping fibres. Friction between fibres is modelled as an exchange of momentum between the fibre nodes. 

The dimensions of the original fibre box are defined as [0, 𝑋] × [0, 𝑌] × [0, 𝑍0]. Throughout this study, it is assumed that the fibre box undergoes uniaxial compression in the negative 𝑧-axis. Consequently, each shifting step results in a reduction in dimensions from [0, 𝑋] × [0, 𝑌] × [0, 𝑍𝑘−1] to [0, 𝑋] × [0, 𝑌] × [0, 𝑍𝑘]. Here, 𝑍𝑘 denotes the size of the box in the 𝑧-direction after the 𝑘-th compression step. Two distinct shifting schemes are explored in this study. In the first scheme, only the nodes from the top layer of the box are shifted downwards. This process resembles the effect of quasi-statically pressing the box from the top boundary. Thus, the position 𝑧𝑖,𝑗 of a node 𝑗 belonging to fibre 𝑖 is computed as 

**==> picture [362 x 31] intentionally omitted <==**

In the second scheme, all nodes in the box undergo a uniform translation, which represents a uniform compression 

**==> picture [286 x 24] intentionally omitted <==**

In the balancing step, since the forces are defined on the nodes, the system simply evolves according to Newton’s equation of motion: 𝒂𝑖,𝑗 = 𝑭𝑚𝑖,𝑗[, where][ 𝑚][is the mass of the node][ 𝑷][𝑖,𝑗][, and][ 𝒂][𝑖,𝑗][,][ 𝑭][𝑖,𝑗][are the corresponding acceleration and force,] respectively. In principle, any forward numerical procedure for solving this equation is suitable, for example, the forward Euler method. However, as in the works of Rodney [6] and Barbier [7], we have adopted the velocity Verlet algorithm due to its accuracy and simplicity. This algorithm [13] contains four steps at each time increment from 𝑡 to 𝑡+ Δ𝑡: 

1. First update of velocities: 𝒗𝑖,𝑗(𝑡+[1] 2[Δ𝑡) = 𝒗][𝑖,𝑗][(𝑡) +][1] 2[𝒂][𝑖,𝑗][(𝑡) ⋅Δ𝑡][;] 

2. Update of positions: 𝑷𝑖,𝑗(𝑡+ Δ𝑡) = 𝑷𝑖,𝑗(𝑡) + 𝒗𝑖,𝑗(𝑡+[1] 2[Δ𝑡) ⋅Δ𝑡][;] 

3. Calculation of accelerations: 𝒂𝑖,𝑗(𝑡+ Δ𝑡) = Δ𝑡; 

- 𝑭𝑖,𝑗(𝑡+Δ𝑡) , where the forces are determined by the positions of nodes at 𝑡+ 𝑚 

**==> picture [329 x 17] intentionally omitted <==**

The total force acting on each node is summed up and monitored. When the sum of forces falls below a specified threshold 𝐹stop, it is assumed that equilibrium has been reached and the balancing step is complete. 

## **2.3 Elastic behaviour of fibres** 

When fibres are deformed during compression, they tend to recover their original form due to their elasticity. Therefore, we define recovery forces on the nodes that allow the reconstruction of the elastic potential of the fibres. The total elastic energy of a fibre can be broken down to the energy of each segment between nodes, which works as elastic springs connecting the nodes. In this study, two kinds of elastic springs are introduced: linear springs and angular springs. 

**4 of 12** 

A linear spring connects two neighbouring nodes, 𝑷𝑖,𝑗 and 𝑷𝑖,𝑗+1 in a fibre 𝑖. Under the assumption of linear elasticity, the elastic potential of a linear spring is: 

**==> picture [303 x 21] intentionally omitted <==**

where 𝐸 is Young’s modulus of the fibre material, 𝐴 is the sectional area of the fibre, 𝐷 is original node distance, and 𝑑𝑖,𝑗 = |𝑷𝑖,𝑗 −𝑷𝑖,𝑗+1| denotes the current distance between the nodes 𝑷𝑖,𝑗 and 𝑷𝑖,𝑗+1 after deformation. Therefore, the recovery forces induced by the linear spring are 

**==> picture [428 x 31] intentionally omitted <==**

for node 𝑷𝑖,𝑗 and node 𝑷𝑖,𝑗+1 respectively, where 𝒏𝑖,𝑗 denotes the unit vector from node 𝑷𝑖,𝑗 to node 𝑷𝑖,𝑗+1. An angular spring connects three consecutive nodes, 𝑷𝑖,𝑗−1, 𝑷𝑖,𝑗, and 𝑷𝑖,𝑗+1 in a fibre 𝑖. The angular spring applies forces to the three nodes when the angle ∠(𝑷𝑖,𝑗𝑷𝑖,𝑗−1, 𝑷𝑖,𝑗𝑷𝑖,𝑗+1) formed by the two neighbouring segments at the node 𝑷𝑖,𝑗 changes during deformation. Θ𝑖,𝑗 and 𝜃𝑖,𝑗 denote this angle before and after deformation respectively. Discretising the elastic energy of an Euler beam 

**==> picture [300 x 24] intentionally omitted <==**

where 𝐼 is the second moment of the sectional area and 𝜅 is the curvature of the fibre, the elastic energy of an angular spring can be expressed as 

**==> picture [306 x 20] intentionally omitted <==**

After defining the following auxiliary vectors 

**==> picture [392 x 17] intentionally omitted <==**

**==> picture [365 x 115] intentionally omitted <==**

the recovery forces induced by the angular spring can be expressed as 

**==> picture [379 x 48] intentionally omitted <==**

It is necessary to ascertain whether there are sufficient recovery forces defined. Differential geometry [14] indicates that a three-dimensional curve is uniquely determined by its arc length, curvature, and torsion. During deformation, the arc length (node distance) and the curvature of the fibre are controlled by the linear and angular springs, respectively. From the perspective of pure mathematics, it would be reasonable to introduce a third kind of recovery force induced by the torsional spring, which would serve to control the torsion of the fibre. However, Picu and Ganghoffer [15] indicates that the torsion mode only makes a negligible contribution to the elastic energy in a fibre with a circular cross-section. Furthermore, in real 

**5 of 12** 

WAN et al. 

**==> picture [193 x 157] intentionally omitted <==**

**F I G U R E 1** Plot of μ(𝜃). 

fibre boxes, the torsion mode of a fibre is constrained by its interactions with other fibres. Consequently, the consideration of torsion is not included in this study. 

## **2.4 Contact behaviour of fibres** 

In this section, we first discuss the normal contact force 𝑭[con] between two fibres, 𝑖 and 𝑗. Since 𝑭[con] only depends on the neighbourhood of the contact site, it is sufficient to consider the contact of two identical cylinders that have the same radius, 𝑅, as the fibres. The cylinders contact each other with an overlap of Δ𝑐 at a skewness angle of 𝜃. The dimensionless overlap is defined as 𝛿𝑐 =[Δ][𝑐] 𝑅[. Without loss of generality, the cylinders are assumed to be parallel to the][ 𝑥𝑦][-plane. Therefore,] the centrelines of the cylinders can be expressed as parametric equations (𝑢, 0, 0) and (𝑣cos 𝜃, 𝑣sin 𝜃, (2 −𝛿𝑐)𝑅), where 𝑢 and 𝑣 are the natural arc length parameters. The direction of the normal contact force 𝑭[con] is along the 𝑧-axis. 

The contact between two skew cylinders is elliptical. In our study, the Hertzian theory [16, 17] is employed to calculate the magnitude of the contact force. This is given by 

**==> picture [306 x 26] intentionally omitted <==**

where 𝜈 is Poisson’s ratio of the fibre material and 𝜇(𝜃) summarises the dependence of 𝐹[con] on 𝜃, which is given by 

**==> picture [307 x 47] intentionally omitted <==**

where 𝑒 is the solution to 

**==> picture [342 x 26] intentionally omitted <==**

Here, 𝐾(𝑒) and 𝐸(𝑒) refer to the 1st and 2nd kind complete elliptic integrals. For better computational efficiency, a value table has been constructed for the implicit function μ(𝜃). A graph of μ(𝜃) is shown in Figure 1. 

In our model, the fibres are discretised as nodes, and the contact force 𝑭[con] is to be reconstructed from the set of node ~~c~~ on pairs 𝑖 × 𝑗 = (𝑷𝑖,𝑘, 𝑷𝑗,𝑙), 𝑘, 𝑙= 1, 2, 3, …. More specifically, a function 𝑭 (𝑷𝑖,𝑘, 𝑷𝑗,𝑙) is sought to determine a discrete contact force for each node pair, such that the vector sum of the discrete contact forces over all pairs gives the total contact force 

**==> picture [307 x 25] intentionally omitted <==**

**6 of 12** 

For each node pair (𝑷𝑖,𝑘, 𝑷𝑗,𝑙), let 𝒓𝑘,𝑙 = 𝑷𝑗,𝑙 −𝑷𝑖,𝑘 = (𝜉𝑘,𝑙, 𝜂𝑘,𝑙, 𝜁𝑘,𝑙) be the vector that connects its two nodes with components (𝜉, 𝜂, 𝜁) in the 3D space. The distance and the dimensionless overlap between the two nodes are given, respectively, by 

**==> picture [334 x 21] intentionally omitted <==**

~~c~~ on It is evident that certain requirements must be met for the function 𝑭 (𝑷𝑖,𝑘, 𝑷𝑗,𝑙). For 𝑟𝑘,𝑙 ≥ 2𝑅, that is, 𝛿𝑘,𝑙 ≤ 0, the force ~~c~~ on 𝑭 should be zero. For 𝛿𝑘,𝑙 > 0, the force is non-zero and monotonously increasing with 𝛿𝑘,𝑙. Furthermore, the force ~~c~~ on should have the same direction as the vector 𝒓𝑘,𝑙. We use 𝛾𝑘,𝑙 to denote the projection factor of 𝑭 to the direction of the total contact force 𝑭[con] , which is the 𝑧-axis: 

**==> picture [276 x 26] intentionally omitted <==**

~~c~~ on A simple model of the discrete contact force is that the magnitude of the force 𝑭 only depends on the overlap 𝛿𝑘,𝑙 of the node pair. This is also the practice in many other studies, such as refs. [6–9]. In such simple models, with 

**==> picture [315 x 25] intentionally omitted <==**

Equation (14) can be rewritten as 

**==> picture [304 x 30] intentionally omitted <==**

where 𝑓(𝛿𝑘,𝑙) is sought. Due to its discrete nature, this problem is challenging to solve. Therefore, we consider the continuous version of it, where 𝑓(𝛿𝑘,𝑙) is replaced by 𝑓(𝛿)[̃] . This gives the following equation: 

**==> picture [409 x 68] intentionally omitted <==**

With the coordinate transform (𝑢, 𝑣) →(𝑟, 𝜙) 

**==> picture [417 x 40] intentionally omitted <==**

where 𝑟∈[0, 1], 𝜙∈[0, 2𝜋], Equation (19) can be simplified to 

**==> picture [413 x 37] intentionally omitted <==**

Upon separation of the variables 𝜃 and 𝛿𝑐, the function 𝑓(𝛿)[̃] can be solved as 

**==> picture [305 x 27] intentionally omitted <==**

However, it is not possible to make the dependence of 𝜃 on both sides of Equation (21) equal. This indicates that for such simple models, the dependence of the total contact force 𝐹[con] on 𝜃 is always through (1∕sin 𝜃), no matter how the function 𝑓(⋅) is chosen. In order to obtain the correct dependence μ(𝜃), the model must be extended in such a way that the node pairs ‘know’ the skew angle 𝜃 at which the fibres cross. In our study, we approximate the fibre orientation at each node by considering the directions of neighbouring segments. Consequently, it becomes feasible to determine the skewness angle 

**7 of 12** 

WAN et al. 

**==> picture [172 x 155] intentionally omitted <==**

~~c~~ on **F I G U R E 2** Relationship between 𝐹 and 𝛿𝑘,𝑙. 

**(A)** 

**==> picture [12 x 8] intentionally omitted <==**

**----- Start of picture text -----**<br>
(B)<br>**----- End of picture text -----**<br>


**F I G U R E 3** Comparison of the cylinder model and the discrete model for 𝐹[con] with a skewness angle of (A) 90[◦] and (B) 15[◦] , respectively. 

for each node pair, as the orientations of both fibres are known. In such an extended model, the discrete contact force is given by 

**==> picture [364 x 28] intentionally omitted <==**

Figure 2 illustrates the relationship between the discrete contact force and the overlap of the node pair. In Figure 3, the contact forces calculated using the cylinder model and the discrete model are compared for a 𝐷∕𝑅 ratio of 0.5. The results demonstrate that the discrete model effectively reconstructs the correct contact behaviour. While the discretisation error in this case is already considered small, it can be further reduced, if necessary, by selecting a smaller 𝐷∕𝑅 ratio. 

Analogously, the contact force between a fibre and the fibre box is modelled as the normal contact force between a cylinder and an infinitely rigid plane, as described by Hertzian theory: 

**==> picture [295 x 22] intentionally omitted <==**

**8 of 12** 

where 𝐿 is the length of the cylinder, and Δ denotes the overlap of the cylinder and the box. This force can be reconstructed by defining the discrete fibre-to-box contact forces 

**==> picture [316 x 21] intentionally omitted <==**

for all nodes 𝑷𝑖,𝑗, 𝑖, 𝑗= 1, 2, … that have positive overlap Δ(𝑷𝑖,𝑗) with the box. Here, the overlap between a node and the fibre box is defined as Δ(𝑷𝑖,𝑗) = 𝑅−𝑑𝑖,𝑗[𝐵][, where][ 𝑑] 𝑖,𝑗[𝐵][is the distance between the node and the box surface. The direction of] the fibre-to-box contact force is always normal to the box surface. 

Friction occurs between fibres when they come into contact. We model the frictions as velocity exchanges between contacting nodes. For a node pair in contact, (𝑷𝑖,𝑘, 𝑷𝑗,𝑙), the tangential relative velocity 𝒗rel is defined as the component of the velocity difference that is perpendicular to the contact direction 𝒓𝑘𝑙. The normal component of the relative velocity is irrelevant as no adhesion is assumed. It is also assumed that the exchange of velocity 𝒗ex is independent of the relative velocity, but dependent on the normal contact, that is, the overlap. The following formula for friction is proposed: 

**==> picture [310 x 26] intentionally omitted <==**

where the two parameters, 𝑐1 and 𝑐2, are to be calibrated with experimental data. As friction has not been modelled as a force, but as an exchange of velocities, this step is implemented after the first velocity updating step in the velocity Verlet algorithm. 

Finally, it is important to note that the computation of the contact forces is a time-consuming process, accounting for the majority of the time spent in the balancing step. In this study, node pairs with a positive overlap are efficiently searched with the k-d tree algorithm [18]. Additionally, since it is possible that a long fibre may contact itself, we allow the fibre indices 𝑖 and 𝑗 to be equal in a contact node pair (𝑷𝑖,𝑘, 𝑷𝑗,𝑙). However, two adjacent nodes in the same fibre are inherently close to each other and therefore have a positive overlap. These node pairs cannot be counted as contact node pairs. In our study, we use the following criterion: for a node pair (𝑷𝑖,𝑘, 𝑷𝑖,𝑙) with a positive overlap, if all nodes in 𝑖 between 𝑷𝑖,𝑘 and 𝑷𝑖,𝑙 also have a positive overlap with 𝑷𝑖,𝑘, then 𝑷𝑖,𝑘 and 𝑷𝑖,𝑙 are considered ‘adjacent’ and are not counted as a contact node pair. 

## **2.5 Convergence of the compression model** 

Convergence issues may arise during the balancing step in the compression model. Despite being based on dynamics, the balancing step aims to identify the equilibrium state, rather than to capture the dynamic evolution of the system over time. From the perspective of physics, the system does indeed reach a state of rest at the end. This is because although the recovery and repulsive forces are conservative, there is friction that gradually reduces the kinetic energy of the system. However, in the numerical model, the friction itself requires calibration. In order to facilitate a more rapid and controllable convergence, damping is incorporated into the simulation. At each time increment, for each node, the scalar product of the velocity vector and the total force acting upon it is evaluated. If the scalar product is negative, it indicates that the force is pulling the node back. In this case, a factor smaller than 1, designated as 𝑓damp, is multiplied to the velocity. 

Furthermore, it is necessary to implement a mechanism to limit the velocities of the nodes. This is because the simulation is discrete in time. Therefore, it is necessary to ensure that when two nodes move towards each other, they actually make contact rather than passing through each other. This requirement gives the maximum velocity permitted before the position updating step in the simulation: 

**==> picture [276 x 21] intentionally omitted <==**

Therefore, in our model, the node velocities are reduced before each position updating step 

**==> picture [307 x 27] intentionally omitted <==**

**9 of 12** 

WAN et al. 

**TA B L E 1** Simulation parameters and material properties. 

|𝑿<br>**(**𝛍𝐦**)**<br>100<br>𝚫𝒕<br>**(**𝟏𝟎−𝟗𝐬**)**<br>0.25|𝒀<br>**(**𝛍𝐦**)**<br>100<br>𝒄𝟏<br>−<br>0.1|𝒁𝟎<br>**(**𝛍𝐦**)**<br>100<br>𝒄𝟐<br>−<br>1|𝒏𝑭<br>−<br>400<br>𝒇**damp**<br>−<br>0.5|**Number of nodes**<br>−<br>29198<br>𝑭**stop**<br>**(N)**<br>3|𝑹<br>**(**𝛍𝐦**)**<br>2<br>**Material density**<br>**(**𝐠∕𝐜𝐦<br>𝟑**)**<br>0.9|𝜿𝒎𝒂𝒙<br>**(**𝛍𝐦−𝟏**)**<br>0.2<br>𝑬<br>**(GPa)**<br>1.5|𝑫<br>**(**𝛍𝐦**)**<br>1<br>𝝂<br>−<br>0.42|
|---|---|---|---|---|---|---|---|



**==> picture [493 x 220] intentionally omitted <==**

**F I G U R E 4** The fibre box at the initial state. 

This adjustment ensures that node velocities remain within the bound of 𝑣max. Typically, node velocities are small compared to 𝑣max, and they will remain almost unaffected. Since this process reduces the kinetic energy of the system, it is also considered as a source of damping. 

## **3 RESULTS** 

This section presents the results of simulations based on the compression model proposed in the previous section. Material properties typical of polypropylene were chosen for the fibres, and the parameters used to define the fibre box and the simulation are summarised in Table 1. The initial state of the fibre box is illustrated in Figure 4. 

In the first simulation, the first shifting scheme introduced in Section 2.2 was applied, that is, the fibre box is quasistatically compressed from the top boundary. Fifty compression steps are performed, each step reducing the maximum 𝑧-dimension of the fibre box by 1% 𝑍0. The evolution of the fibre system after 20, 30, and 50 steps is shown in Figure 5. 

The solid volume fraction of the fibre system increases from 36.198% to 71.323% during the simulation (Figure 6). Monitoring the fibre-to-box contact force at the bottom surface allowed us to establish the relationship between compression and pressure, as shown in Figure 7. The near-zero pressure at the bottom in the early steps indicates that the fibre system did not reach its maximum unforced packing limit until approximately step 30. Beyond this point, increasing fibre contacts in the equilibrium state led to a higher homogenised stiffness of the fibre material with increasing compression. 

The second simulation used the same settings as the first, except that the uniform compression scheme was employed. Seventy compression steps were performed, each with the same compression increment as in the first simulation. This allowed the fibre system to be compressed to nearly 100% nominal solid volume fraction, demonstrating the robustness of the compression model even at such high compression levels. Figure 8 shows the fibre system after 20, 50, and 70 steps of compression. 

**10 of 12** 

**==> picture [493 x 150] intentionally omitted <==**

**F I G U R E 5** Compression of the fibre system in the first simulation. 

**==> picture [195 x 156] intentionally omitted <==**

**F I G U R E 6** Solid volume fraction during compression. 

**==> picture [170 x 155] intentionally omitted <==**

**F I G U R E 7** Relationship between pressure and compression. 

## **4 CONCLUSION** 

In this study, we have proposed a computational model for the numerical compression of non-woven materials. Given the initial configuration of the fibre system, the model is capable of simulating the compressed fibre system at any compression state. The correct elastic and contact behaviour of the fibres during compression is reconstructed in the model. The model also serves as a primary homogenisation method, providing a basic understanding of the relationship between pressure and compression state. Future work will focus on experimental validation, parameter calibration, and extending the model 

**11 of 12** 

WAN et al. 

**==> picture [493 x 148] intentionally omitted <==**

**F I G U R E 8** Three states illustrating the compression of the fibre system in the second simulation. 

to incorporate additional material properties and loading conditions. Other ways of describing the frictional behaviour of the fibres, such as that proposed in ref. [19], will also be explored in order to gain a better understanding of the irreversible deformation of non-woven materials. 

Moreover, building on the findings of this study and leveraging the datasets obtained from the lower-scale analyses, future research will explore advanced machine learning-based multiscale approaches tailored for porous materials. Notably, we aim to incorporate methodologies similar to those reported in recent studies (see, e.g., refs. [20–24]), which have demonstrated significant advancements in the modelling and simulation of complex material behaviours. These references provide a foundational basis for extending our work into more sophisticated computational realms. 

## **AC K N OW L E D G M E N T S** 

The authors would like to gratefully thank the German Research Foundation (DFG) for the support of the project “SonicFibre – Experimental and numerical multiscale analysis of temporary friction reduction during textile production by means of plate vibration excitation”, grant number 516937265. 

## **O RC I D** 

_Chengrui Wan_ https://orcid.org/0009-0001-7999-302X _YousefHeider_ https://orcid.org/0000-0003-2281-2563 

## **R E F E R E N C E S** 

1. Archut, J. L., Kins, R., Heider, Y., Cloppenburg, F., Markert, B., Gries, T., & Corves, B. (2022). A study of the mechanical response of nonwovens excited by plate vibration. _Applied Mechanics_ , _3_ (2), 496–516. 

2. Ehlers, W., & Bluhm, J. (Eds.). (2002). _Porous media_ . Springer Berlin Heidelberg. 

3. Markert, B., Heider, Y., & Ehlers, W. (2010). Comparison of monolithic and splitting solution schemes for dynamic porous media problem. _International Journal for Numerical Methods in Engineering_ , _82_ , 1341–1383. 

4. Abd El-Rahman, A. I., & Tucker, C. L. (2013). Mechanics of random discontinuous long-fiber thermoplastics. Part II: Direct simulation of uniaxial compression. _Journal of Rheology_ , _57_ (5), 1463–1489. 

5. Chatti, F., Poquillon, D., Bouvet, C., & Michon, G. (2018). Numerical modelling of entangled carbon fibre material under compression. _Computational Materials Science_ , _151_ (August), 14–24. 

6. Rodney, D., Fivel, M., & Dendievel, R. (2005). Discrete modeling of the mechanics of entangled materials. _Physical Review Letters_ , _95_ (10), 108004. 

7. Barbier, C., Dendievel, R., & Rodney, D. (2009). Numerical study of 3D-compressions of entangled materials. _Computational Materials Science_ , _45_ (3), 593–596. 

8. Altendorf, H., & Jeulin, D. (2011). Random-walk-based stochastic modeling of three-dimensional fiber systems. _Physical Review E_ , _83_ (4), 041804. 

9. Gaiselmann, G., Tötzke, C., Manke, I., Lehnert, W., & Schmidt, V. (2014). 3D microstructure modeling of compressed fiber-based materials. _Journal of Power Sources_ , _257_ (July), 52–64. 

10. Gaiselmann, G., Manke, I., Lehnert, W., & Schmidt, V. (2013). Extraction of curved fibers from 3D data. _Image Analysis & Stereology_ , _32_ (1), 57. 

11. Viguié, J., Latil, P., Orgéas, L., Dumont, P., Rolland Du Roscoat, S., Bloch, J. F., Marulier, C., & Guiraud, O. (2013). Finding fibres and their contacts within 3D images of disordered fibrous media. _Composites Science and Technology_ , _89_ , 202–210. 

**12 of 12** 

12. Grießer, A., Westerteiger, R., Glatt, E., Hagen, H., & Wiegmann, A. (2023). Identification and analysis of fibers in ultra-large micro-CT scans of nonwoven textiles using deep learning. _The Journal of The Textile Institute_ , _114_ (11), 1647–1657. 

13. Allen, M. P., & Tildesley, D. J. (2017). _Computer simulation of liquids_ (2nd ed.). Oxford University Press. 

14. Carmo, M. P. D. (2016). _Differential geometry of curves and surfaces_ (Revised & updated 2nd ed.). Dover Publications Inc. 

15. Picu, C., & Ganghoffer, J. F. (Eds.). (2020). _Mechanics of fibrous materials and applications: Physical and modeling aspects_ (Vol. 596). CISM International Centre for Mechanical Sciences. Springer International Publishing. 

16. Barber, J. (2018). _Contact mechanics, solid mechanics and its applications_ (Vol. 250). Springer International Publishing. 

17. Popov, V. L. (2017). _Contact mechanics and friction_ . Springer. 

18. Maneewongvatana, S., & Mount, D. M. (1999). Analysis of approximate nearest neighbor searching with clustered point sets. arXiv:cs/9901013. 

19. Tkachuk, M., & Tkachuk, A. (2024). Large deformation of cable networks with fiber sliding as a second-order cone programming. _International Journal of Solids and Structures_ , _298_ , 112848. 

20. Heider, Y., Wang, K., & Sun, W. (2020). So(3)-invariance of informed-graph-based deep neural network for anisotropic elastoplastic materials. _Computer Methods in Applied Mechanics and Engineering_ , _363_ , 112875. 

21. Heider, Y., Suh, H. S., & Sun, W. (2021). An offline multi-scale unsaturated poromechanics model enabled by self-designed/self-improved neural networks. _International Journal for Numerical and Analytical Methods in Geomechanics_ , _45_ (9), 1212–1237. 

22. Chaaban, M., Heider, Y., & Markert, B. (2022). A multiscale LBM–TPM–PFM approach for modeling of multiphase fluid flow in fractured porous media. _International Journal for Numerical and Analytical Methods in Geomechanics_ , _46_ (14), 2698–2724. 

23. Chaaban, M., Heider, Y., Sun, W., & Markert, B. (2024). A machine-learning supported multi-scale LBM-TPM model of unsaturated, anisotropic, and deformable porous materials. _International Journal for Numerical and Analytical Methods in Geomechanics_ , _48_ (4), 889–910. 

24. Aldakheel, F., Elsayed, E., Tarek, Z., & Wriggers, P. (2023). Efficient multiscale modeling of heterogeneous materials using deep neural networks. _Computational Mechanics_ , _72_ , 155–171. 

**How to cite this article:** Wan, C., Heider, Y., & Markert, B. (2024). Microscale modelling of non-woven material compression. _Proceedings in Applied Mathematics and Mechanics_ , e202400176. https://doi.org/10.1002/pamm.202400176 

