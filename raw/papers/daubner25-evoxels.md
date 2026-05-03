---
title: "evoxels: A differentiable physics framework for voxel-based microstructure simulations"
arxiv: "2507.21748"
authors: ["Simon Daubner"]
year: 2025
source: paper
ingested: 2026-05-03
sha256: ffe529adce316d8d93d95eec693cb10ea808575b6310ba8783e76dc045c0b004
conversion: pymupdf4llm
---

evoxels: A differentiable physics framework for voxel-based microstructure simulations 

Simon Daubner ∗1, Alexander E. Cohen2, Benjamin D¨orich 3, and Samuel J. Cooper 1 

> 1Imperial College London, United Kingdom 

> 2Massachusetts Institute of Technology, United States 

> 3Karlsruhe Institute of Technology, Germany 

## **1 Summary** 

Materials science inherently spans disciplines: experimentalists use advanced microscopy to uncover micro- and nanoscale structure, while theorists and computational scientists develop models that link processing, structure, and properties. Bridging these domains is essential for inverse material design where you start from desired performance and work backwards to optimal microstructures and manufacturing routes. Integrating high-resolution imaging with predictive simulations and datadriven optimization accelerates discovery and deepens understanding of process–structure–property relationships. 

**==> picture [390 x 144] intentionally omitted <==**

Figure 1: Artwork visualizing the core idea of evoxels: a Python-based differentiable physics framework for simulating and analyzing 3D voxelized microstructures. 

The differentiable physics framework **evoxels** is based on a fully Pythonic, unified voxel-based approach that integrates segmented 3D microscopy data, physical simulations, inverse modeling, and machine learning. 

- At its core is a voxel grid representation compatible with both pytorch and jax to leverage massive parallelization on CPU, GPU and TPU for large microstructures. 

- Both backends naturally provide high computational performance based on just-in-time compiled kernels and end-to-end gradient-based parameter learning through automatic differentiation. 

- ∗Corresponding author: `s.daubner@imperial.ac.uk` 

1 

- The solver design based on advanced Fourier spectral time-stepping and low-RAM in-place updates enables scaling to hundreds of millions of DOFs on commodity hardware (e.g. forward Cahn-Hilliard simulation with 400[3] voxels on NVIDIA RTX 500 Ada Laptop GPU with 4GB memory) and billions of DOFs on high end data-center GPUs (1024[3] voxels on NVIDIA RTX A6000; more details see Figure 3). 

- Its modular design includes comprehensive convergence tests to ensure the right order of convergence and robustness for various combinations of boundary conditions, grid conventions and stencils during rapid prototyping of new PDEs. 

While not intended to replace general finite-element or multi-physics platforms, it fills a unique niche for high-resolution voxel workflows, rapid prototyping for structure simulations and materials design, and fully open, reproducible pipelines that bridge imaging, modeling, and data-driven optimization. 

From a high-level perspective, evoxels is organized around two core abstractions: VoxelFields and VoxelGrid. VoxelFields provides a uniform, NumPy-based container for any number of 3D fields on the same regular grid, maximizing interoperability with image I/O libraries (e.g. tif le, h5py, napari, scikit-image) and visualization tools (PyVista, VTK). VoxelGrid couples these fields to either a PyTorch or JAX backend, offering pre-defined boundary conditions, finite difference stencils and FFT libraries as sketched in Figure 2. The implemented solvers leverage advanced Fourier spectral timesteppers (e.g. semi-implicit, exponential integrators), on-the-fly plotting and integrated walltime and RAM profiling. A suite of predefined PDE “problems” (e.g. Cahn–Hilliard, reactiondiffusion, multi-phase evolution) can be solved out of the box or extended via user-defined ODEs classes with custom right-hand sides. Integrated convergence tests ensure each discretization achieves the expected order before it ever touches real microscopy data. 

**==> picture [390 x 145] intentionally omitted <==**

Figure 2: Visualisation of package concept. The VoxelFields class acts as the user interface for organising 3D fields on a regular grid including plotting and export functions. Solvers are assembled in a modular fashion. The chosen timestepper and ODE class are just-in-time compiled (green becomes one kernel) based on the given VoxelGrid backend. 

**evoxels** is aimed squarely at researchers who need a “plug-in-your-image, get-your-answer” workflow for digital materials science and inverse design. Experimentalists can feed segmented FIB-SEM or X-ray tomograms directly into high-performance simulations; computational scientists and modelers benefit from a truly open, reproducible framework. It speaks to anyone who wants special-purpose solvers for representative volume elements - without the overhead of mesh generation - while still offering the flexibility to develop new solvers, test boundary conditions, and incorporate machinelearning-driven optimization. evoxels provides both the turnkey usability of a specialized package and the extensibility of a low-level research toolkit for e.g. benchmarking tortuosity, fitting diffusion coefficients, or prototyping novel phase-field models. 

2 

## **2 Statement of Need** 

Understanding the link between microstructure and material properties is a central challenge in materials science which increasingly relies on high-resolution 3D imaging, large-scale simulations, and data-driven optimization. Despite the growing availability of segmented volumes from FIBSEM, X-ray CT, or synchrotron tomography, and data augmentation through generative AI [1, 2] the pipeline from experimental data to simulation remains fragmented. Existing simulation tools rarely operate directly on voxelized microscopy data, instead requiring costly meshing or complex preprocessing. While boundary-conforming meshes (finite element/finite volume method) can better capture complex geometries, voxel-based methods (finite difference and Fourier pseudospectral methods) – especially in combination with smoothed boundary techniques [3, 4] – offer a robust and practical alternative for computing effective material properties. In many materials science applications, small numerical or geometric errors (e.g. 5–10 %) are acceptable, as modeling assumptions are often approximate and the goal is to capture the correct order of magnitude or understand factors like tortuosity or relative transport rates – that is, how much better or worse a given microstructure performs. Furthermore, many commercial codes rely on proprietary data formats, complicating data exchange and reproducibility. In addition to these technical hurdles, significant domain expertise is typically required to configure simulations i.e. choosing appropriate time-stepping schemes, numerical discretizations, and boundary conditions. Even for well-studied problems such as the Cahn–Hilliard equation [5, 6], no scalable 3D Python implementation exists, highlighting a broader lack of open, reusable simulation frameworks in the field. These gaps in data interoperability, code availability, and accessible expertise continue to hinder progress in understanding process-structureproperty relationships and limit the practical deployment of inverse design methodologies. 

The **evoxels** package enables large-scale forward and inverse simulations on uniform voxel grids, ensuring direct compatibility with microscopy data and harnessing GPU-optimized FFT and tensor operations. This design supports forward modeling of transport and phase evolution phenomena, as well as backpropagation-based inverse problems such as parameter estimation and neural surrogate training - tasks which are still difficult to achieve with traditional FEM-based solvers. This differentiable-physics foundation makes it easy to embed voxel-based solvers as neural-network layers, train generative models for optimal microstructures, or jointly optimize processing and properties via gradient descent. By keeping each simulation step fast and fully backpropagatable, evoxels enables data-driven materials discovery and high-dimensional design-space exploration. 

There remains significant untapped potential in applying FFT-based semi-implicit schemes [6] and exponential integrators [7] across the broader landscape of digital materials science. Although these methods are well-established in areas such as spectral homogenization and phase-field modeling, their adoption has largely been limited to specialized research codes. For example in [8], a C `++` - CUDA implementation of exponential integrators combined with FFT on a GPU was shown to outperform state-of-the-art exponential integrators implementations by fully exploiting the tensor structure of the spatial discretizations. However, few open-source frameworks incorporate these methods into modern simulation pipelines that support automatic differentiation and GPU acceleration—capabilities increasingly critical for inverse design and data-driven workflows. 

To evaluate performance against state-of-the-art python libraries, we benchmark the stiff, fourthorder Cahn–Hilliard spinodal-decomposition problem using torchode and Diffrax. As shown in Figure 3, evoxels’ native pseudo-spectral IMEX solver achieves runtimes one to two orders of magnitude shorter than general-purpose ODE integrators and requires substantially less GPU memory. By contrast, the TSIT5 integrator with PID-controlled timestepping which is available in both torchode and Diffrax demands finer timesteps, increasing both computation time and memory use to impractical levels for parameter optimization or inverse-design tasks. We also provide a custom Diffrax pseudo-spectral IMEX implementation fully integrated into the evoxels framework; while its wall time matches the native evoxels solver, it incurs higher memory overhead. Finally, fully implicit schemes (e.g., Diffrax’s Implicit Euler) exhaust GPU memory on moderate-sized 3D grids (even _<_ 100[3] ), underlining their unsuitability for high-resolution microstructure simulations. evoxels positions itself as a lightweight, accessible, and rigorously tested tool for prototyping voxelbased PDE solvers. Compared to domain-specific tools like taufactor [10] and magnum.np [11], 

3 

**==> picture [429 x 170] intentionally omitted <==**

Figure 3: Comparison of wall time and maximum GPU memory usage for the Cahn-Hilliard (CH) problem. Wall time for solving 1000 timesteps with fixed stepsize ∆ _t_ = 1 based on pseudo-spectral IMEX scheme with evoxels-torch (blue) and evoxels-jax (red) - both with and without just-in-time (jit) compilation; pseudo spectral IMEX scheme as custom diffrax solver (orange); and tsit5 scheme in combination with a PID timestep controller in torchode (green) and diffrax (purple). Vertical lines denote maximum problem size on Nvidia RTX A6000 for reference. Black datapoints refer to spectral element simulation of CH using MATLAB on Nvidia A100 [9]. GPU memory footprint of all pytorch-based simulations shown in b) shows linear scaling with amount of voxels. 

evoxels supports a broader range of problems, boundary conditions, and numerical methods while maintaining a modular, user-friendly interface for imaging-driven workflows. At the same time, it is more specialized and efficient for problems on uniform grids with fixed physics than generalpurpose solvers like FiPy or FEniCS. evoxels is not intended to replace multiphysics platforms such as COMSOL or MOOSE, but to complement them by filling a niche in high-resolution, imaging-driven, and differentiable simulations. 

Building on prior advances in microstructure characterization [4], phase-field modeling for battery materials [12] and the inverse learning of physics from image data [13], evoxels integrates these capabilities into a unified, extensible codebase. It is currently being used by researchers and students alike to advance inverse-learning capabilities and to develop advanced time integration methods. In a field where open-source simulation tools remain underdeveloped, it provides a practical blueprint for reproducible digital materials science, helping to democratize capabilities that have long been confined to specialist groups or proprietary codebases. 

## **Acknowledgements** 

We acknowledge computational resources and support provided by the Imperial College Research Computing Service (http://doi.org/10.14469/hpc/2232). This work has received financial support from the European Union’s Horizon Europe research and innovation programme under grant agreement No 101069726 (SEATBELT project). Views and opinions expressed are however those of the author(s) only and do not necessarily reflect those of the European Union or CINEA. Neither the European Union nor the granting authority can be held responsible for them. 

4 

## **Appendix: Microstructure modelling** 

This section provides an insight into the PDEs behind the scenes, i.e. the types of computational problems that are commonly encountered in digital materials science and materials design. These problems can largely be classified into two categories: one set governs the calculation of effective properties in complex heterogeneous structures; the other describes microstructural evolution via phase transformations, or reaction–diffusion mechanisms. In inverse-design scenarios - where one prescribes target properties and then tailors the material’s developmental pathways - these two PDE classes become tightly coupled. Understanding and efficiently solving both types is essential for predictive modeling and optimized materials innovation. 

## **Reaction-diffusion systems** 

The time-dependent evolution of a single species undergoing reaction and diffusion given by Fick’s law is described by the PDE 

**==> picture [282 x 22] intentionally omitted <==**

where the diffusivity _D_ can be a function of space _x_ and/or composition _c_ . Within the more general framework of linear irreversible thermodynamics, the driving force for diffusion is given by the gradient in chemical potential _∇µ_ and with the chemical mobility _M_ , the concentration evolution is then governed by 

**==> picture [292 x 22] intentionally omitted <==**

Note that the chemical potential is a function of concentration as in the case of the Cahn-Hilliard problem. 

The Gray-Scott model is an example of two species coupled by an interaction term which can lead to surprisingly complex pattern formation. It can be expressed as two coupled PDEs 

**==> picture [307 x 22] intentionally omitted <==**

**==> picture [307 x 22] intentionally omitted <==**

The model describes two species _A_ and _B_ which are dispersed in another medium assuming dilute solution (pairwise diffusion coefficients are equal to zero). _cA_ is added at a given feed rate _f_ but it can maximally reach a concentration of _cA_ = 1. A reaction converts _cA_ into _cB_ in the presence of _cB_ (i.e. reaction term _cAc_[2] _B_[).] _[c][B]_[is][continuously][removed][with][a][given][kill][rate] _[k]_[until][it][reaches] _cB_ = 0. Both species are also diffusing within the solution with given chemical diffusivities _DA_ and _DB_ respectively. 

## **Phase transformations of first and second order** 

We start from a free energy functional for a two-phase system 

**==> picture [219 x 24] intentionally omitted <==**

where _γ_ 0 [J/m[2] ] denotes the interfacial energy and _ε_ [m] scales the width of the diffuse interface. Note that in this case, the homogeneous free energy is given by a double-well potential while in the context of the Cahn-Hilliard equation a regular free energy involving logarithmic terms is often employed and, in the context of the multiphase field method, an obstacle-type potential can be found. However, the following procedure would be identical in all cases. 

5 

The second order phase transition problem - also known as the _Cahn-Hilliard equation_ [5, 14] - can be derived by inserting the chemical potential _µ_ = _δf_ int _/δϕ_ given by the functional derivative of the given free energy formulation into the mass conservation equation which yields 

**==> picture [332 x 22] intentionally omitted <==**

which is a fourth-order PDE in space. Specifically, we use a variable mobility of the form _M_ = _D_ 0 _ϕ_ (1 _− ϕ_ ) and the homogenous part of the chemical potential is given by the polynomial expression _g_ ( _ϕ_ ) =[18] _ε[ϕ]_[(1] _[ −][ϕ]_[)(1] _[ −]_[2] _[ϕ]_[).][Additionally,][a][forcing][(source/sink)][term] _[f]_[can][be][considered.] Alternatively, the kinetics of a first-order phase transformation can be derived from the linear relaxation of the system free energy towards its minimum 

**==> picture [306 x 24] intentionally omitted <==**

also known as the _Allen-Cahn equation_ for the non-conserved order parameter _ϕ_ . Note that the kinetic coefficient _L_ is chosen as _M/ε_ such that _M_ represents a physical mobility of the migrating interface which is independent of its diffuse width scaled by _ε_ [15]. Eq. (6) leads to the formation of a diffuse interface and an evolution of the microstructure driven by curvature minimization. An interesting variation of Eq. (6) is obtained by subtracting the curvature-driven forces from the laplacian of _ϕ_ [16, 17, 18] such that 

**==> picture [216 x 25] intentionally omitted <==**

This will create a smooth transition in the direction of the surface normal while the shape is not altered by curvature minimization [16]. Instead of subtracting the curvature the normal part of the laplacian can be computed directly [18] 

**==> picture [246 x 24] intentionally omitted <==**

A multi-phase generalization of Eq. (6) is given by a set of N coupled PDEs [19, 20] given as the sum of pairwise interactions 

**==> picture [293 x 34] intentionally omitted <==**

where _N_[˜] denotes the amount of locally present phases and _Mαβ_ denotes a matrix of pairwise interfacial mobilities. 

## **Smoothed boundary method** 

Oftentimes, the equations discussed above are confined to a given microstructure like lithium ion transport in the pore space of an electrode microstructure. Following [3, 21], we re-write the diffusion equation (1) with the indicator function _ψ_ as 

**==> picture [305 x 22] intentionally omitted <==**

where _jN_ is the normal boundary flux. The flux _jN_ can vary spatially and/or temporally and for a closed system _jN_ = 0 holds. If the microstructure does not evolve over time ( _∂ψ/∂t_ = 0) the equality _ψ∂c/∂t_ = _∂ψc/∂t_ holds. Therefore, we can re-formulate the PDE using _ψc_ = _z_ 

**==> picture [329 x 25] intentionally omitted <==**

This formulation is beneficial in terms of generality and the use of FFT based semi-implicit timestepping as discussed in the next section. 

6 

## **Semi-implicit timestepping** 

Consider the (mass / heat) conservation equation (see Eq. (1)) 

**==> picture [134 x 22] intentionally omitted <==**

with variable mobility (diffusivity/conductivity) Γ and a forcing (sink/source) term _f_ . Following the procedure sketched in [6, 22] we can re-formulate the equation to 

**==> picture [188 x 22] intentionally omitted <==**

to then apply the semi-implicit Fourier spectral method to discretize the PDE in Fourier space 

**==> picture [296 x 23] intentionally omitted <==**

ˆ where _F_ ( _u_ ) = _u_ denotes the Fourier transform. This yields the following equation for the new timestep _u_ ˆ _[n]_[+1] 

**==> picture [315 x 12] intentionally omitted <==**

which corresponds to the following time-stepping scheme in real space 

**==> picture [272 x 25] intentionally omitted <==**

Note that this procedure is relatively simple as it only involves coding the finite difference approximation of the original right-hand side of the problem rhs = _∇·_ (Γ _∇u_ ) + _f_ ( _u, t_ ) as would be common to use any predefined timestepping scheme from existing python packages such as torchode and diffrax. In comparison to the explicit Euler scheme, this procedure additionally involves one forward FFT and one inverse FFT but leads to much larger stable timesteps [6, 22]. Note that as _u[n]_ and _u[n]_[+1] both must satisfy the boundary conditions, the update _F[−]_[1] _{. . . }_ itself fulfills certain boundary constraints. Critically, as long as Dirichlet boundary conditions on _u_ are not a function of time the update exhibits constant zero boundary conditions which enables the efficient use of FFT. This procedure can be equally applied to all reaction-diffusion and phase evolution problems given above, e.g. when applied to the fourth order Cahn-Hilliard problem, this results in 

**==> picture [265 x 24] intentionally omitted <==**

and, similarly, the smoothed boundary formulation of the diffusion equation then reads 

**==> picture [351 x 25] intentionally omitted <==**

The prefactor inside the inverse Fourier transform always takes the form ∆ _t/_ (1 _−_ ∆ _t S_ ) where _S_ is the symbol of the spatial operator i.e. its representation in the Fourier (spectral) domain. For instance, the diffusion operator _D∇_[2] corresponds to _−k_[2] _D_ . Within the evoxels framework, the symbol must be defined together with the numerical right-hand side of the PDE for applying pseudo-spectral timesteppers to a given problem definition. 

7 

## **References** 

- [1] Steve Kench and Samuel J. Cooper. Generating three-dimensional structures from a twodimensional slice with generative adversarial network-based dimensionality expansion. _Nature Machine Intelligence_ , 3(4):299–305, 2021. 

- [2] Donal P. Finegan, Isaac Squires, Amir Dahari, Steve Kench, Katherine L. Jungjohann, and Samuel J. Cooper. Machine-Learning-Driven Advanced Characterization of Battery Electrodes. _ACS Energy Letters_ , 7(12):4368–4378, dec 2022. 

- [3] Hui-Chia Yu, Hsun-Yi Chen, and K Thornton. Extended smoothed boundary method for solving partial differential equations with general boundary conditions on complex boundaries. _Modelling and Simulation in Materials Science and Engineering_ , 20(7):075008, oct 2012. 

- [4] S Daubner and B. Nestler. Microstructure Characterization of Battery Materials Based on Voxelated Image Data: Computation of Active Surface Area and Tortuosity. _Journal of The Electrochemical Society_ , 171(12):120514, dec 2024. 

- [5] J. W. Cahn and J. E. Hilliard. Free Energy of a Nonuniform System. I. Interfacial Free Energy. _The Journal of Chemical Physics_ , 28(2):258–267, feb 1958. 

- [6] Jingzhi Zhu, Long-Qing Chen, Jie Shen, and Veena Tikare. Coarsening kinetics from a variablemobility Cahn-Hilliard equation: Application of a semi-implicit Fourier spectral method. _Physical Review E_ , 60(4):3564–3572, oct 1999. 

- [7] M. Hochbruck and A. Ostermann. Exponential integrators. _Acta Numerica_ , 19:209–286, may 2010. 

- [8] M. Caliari, F. Cassini, L. Einkemmer, A. Ostermann, and F. Zivcovich. A _µ_ -mode integrator for solving evolution equations in Kronecker form. _J. Comput. Phys._ , 455:Paper No. 110989, 16, 2022. 

- [9] Xinyu Liu Xinyu Liu, Jie Shen Jie Shen, and Xiangxiong Zhang Xiangxiong Zhang. A Simple GPU Implementation of Spectral-Element Methods for Solving 3D Poisson Type Equations on Rectangular Domains and Its Applications. _Communications in Computational Physics_ , 36(5):1157–1185, jan 2024. 

- [10] Steve Kench, Isaac Squires, and Samuel Cooper. TauFactor 2: A GPU accelerated python tool for microstructural analysis. _Journal of Open Source Software_ , 8(88):5358, aug 2023. 

- [11] Florian Bruckner, Sabri Koraltan, Claas Abert, and Dieter Suess. magnum.np: a PyTorch based GPU enhanced finite difference micromagnetic simulation framework for high level development and inverse design. _Scientific Reports_ , 13(1):12054, jul 2023. 

- [12] Simon Daubner, Marcel Weichel, Martin Reder, Daniel Schneider, Qi Huang, Alexander E Cohen, Martin Z. Bazant, and Britta Nestler. Simulation of intercalation and phase transitions in nano-porous, polycrystalline agglomerates. _npj Computational Materials_ , 11(1):211, jul 2025. 

- [13] Hongbo Zhao, Haitao Dean Deng, Alexander E. Cohen, Jongwoo Lim, Yiyang Li, Dimitrios Fraggedakis, Benben Jiang, Brian D. Storey, William C. Chueh, Richard D. Braatz, and Martin Z. Bazant. Learning heterogeneous reaction kinetics from X-ray videos pixel by pixel. _Nature_ , 621(7978):289–294, sep 2023. 

- [14] J. W. Cahn. On spinodal decomposition. _Acta Metallurgica_ , 9:795–801, 1961. 

- [15] Britta Nestler, Harald Garcke, and Bj¨orn Stinner. Multicomponent alloy solidification: Phasefield modeling and simulations. _Physical Review E_ , 71(4):041609, apr 2005. 

- [16] Ying Sun and Christoph Beckermann. Sharp interface tracking using the phase-field equation. _Journal of Computational Physics_ , 220(2):626–653, 2007. 

8 

- [17] Tomohiro Takaki and Junji Kato. Phase-field topology optimization model that removes the curvature effects. _Mechanical Engineering Journal_ , 4(2):16–00462–16–00462, 2017. 

- [18] Ephraim Schoof. _Chemomechanische Modellierung der W¨armebehandlung von St¨ahlen mit der Phasenfeldmethode_ . Dissertation, Karlsruhe Institute of Technology (KIT), 2020. 

- [19] Simon Daubner, Paul W Hoffrogge, Martin Minar, and Britta Nestler. Triple junction benchmark for multiphase-field and multi-order parameter models. _Computational Materials Science_ , 219:111995, feb 2023. 

- [20] P W Hoffrogge, S Daubner, D Schneider, B Nestler, B Zhou, and J Eiken. Triple junction benchmark for multiphase-field models combining capillary and bulk driving forces. _Modelling and Simulation in Materials Science and Engineering_ , 33(1):015001, jan 2025. 

- [21] X. Li, J. Lowengrub, A. Ratz, and A. Voigt. Solving PDEs in complex geometries. _Communications in Mathematical Sciences_ , 7(1):81–107, 2009. 

- [22] L.Q. Chen and Jie Shen. Applications of semi-implicit Fourier-spectral method to phase field equations. _Computer Physics Communications_ , 108(2-3):147–158, feb 1998. 

9 

