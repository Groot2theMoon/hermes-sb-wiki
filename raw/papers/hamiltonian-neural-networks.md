---
source_url: 
ingested: 2026-04-29
sha256: f03f08dea35bed3266aac06cb15280674ce843f06de6a7e72b93eed73551424e
---

## **Hamiltonian Neural Networks** 

**Sam Greydanus** Google Brain `sgrey@google.com` 

**Misko Dzamba Jason Yosinski** PetCube Uber AI Labs `mouse9911@gmail.com yosinski@uber.com` 

## **Abstract** 

Even though neural networks enjoy widespread use, they still struggle to learn the basic laws of physics. How might we endow them with better inductive biases? In this paper, we draw inspiration from Hamiltonian mechanics to train models that learn and respect exact conservation laws in an unsupervised manner. We evaluate our models on problems where conservation of energy is important, including the two-body problem and pixel observations of a pendulum. Our model trains faster and generalizes better than a regular neural network. An interesting side effect is that our model is perfectly reversible in time. 

**==> picture [397 x 209] intentionally omitted <==**

**----- Start of picture text -----**<br>
Ideal m as s-spring system Baseline NN Prediction<br>Noisy observations Hamiltonian NN Prediction<br>**----- End of picture text -----**<br>


Figure 1: Learning the Hamiltonian of a mass-spring system. The variables _q_ and _p_ correspond to position and momentum coordinates. As there is no friction, the baseline’s inner spiral is due to model errors. By comparison, the Hamiltonian Neural Network learns to _exactly_ conserve a quantity that is analogous to total energy. 

## **1 Introduction** 

Neural networks have a remarkable ability to learn and generalize from data. This lets them excel at tasks such as image classification [21], reinforcement learning [45, 26, 37], and robotic dexterity [1, 22]. Even though these tasks are diverse, they all share the same underlying physical laws. For example, a notion of gravity is important for reasoning about objects in an image, training an RL agent to walk, or directing a robot to manipulate objects. Based on this observation, researchers have become increasingly interested in finding physics priors that transfer across tasks [43, 34, 17, 10, 6, 40]. 

Preprint. Under review. 

Untrained neural networks do not have physics priors; they learn approximate physics knowledge directly from data. This generally prevents them from learning _exact_ physical laws. Consider the frictionless mass-spring system shown in Figure 1. Here the total energy of the system is being conserved. More specifically, this particular system conserves a quantity proportional to _q_[2] + _p_[2] , where _q_ is the position and _p_ is the momentum of the mass. The baseline neural network in Figure 1 learns an approximation of this conservation law, and yet the approximation is imperfect enough that a forward simulation of the system drifts over time to higher or lower energy states. Can we define a class of neural networks that will precisely conserve energy-like quantities over time? 

In this paper, we draw inspiration from Hamiltonian mechanics, a branch of physics concerned with conservation laws and invariances, to define _Hamiltonian Neural Networks_ , or _HNNs_ . We begin with an equation called the Hamiltonian, which relates the state of a system to some conserved quantity (usually energy) and lets us simulate how the system changes with time. Physicists generally use domain-specific knowledge to find this equation, but here we try a different approach: 

_Instead of crafting the Hamiltonian by hand, we propose parameterizing it with a neural network and then learning it directly from data._ 

Since almost all physical laws can be expressed as conservation laws, our approach is quite general [27]. In practice, our model trains quickly and generalizes well[1] . Figure 1, for example, shows the outcome of training an HNN on the same mass-spring system. Unlike the baseline model, it learns to conserve an energy-like quantity. 

## **2 Theory** 

**Predicting dynamics.** The hallmark of a good physics model is its ability to predict changes in a system over time. This is the challenge we now turn to. In particular, our goal is to learn the dynamics of a system using a neural network. The simplest way of doing this is by predicting the next state of a system given the current one. A variety of previous works have taken this path and produced excellent results [41, 14, 43, 34, 17, 6]. There are, however, a few problems with this approach. 

The first problem is its notion of discrete “time steps” that connect neighboring states. Since time is actually continuous, a better approach would be to express dynamics as a set of differential equations and then integrate them from an initial state at _t_ 0 to a final state at _t_ 1. Equation 1 shows how this might be done, letting **S** denote the time derivatives of the coordinates of the system[2] . This approach has been under-explored so far, but techniques like Neural ODEs take a step in the right direction [7]. 

**==> picture [283 x 27] intentionally omitted <==**

The second problem with existing methods is that they tend not to learn exact conservation laws or invariant quantities. This often causes them to drift away from the true dynamics of the system as small errors accumulate. The HNN model that we propose ameliorates both of these problems. To see how it does this — and to situate our work in the proper context — we first briefly review Hamiltonian mechanics. 

**Hamiltonian Mechanics.** William Hamilton introduced Hamiltonian mechanics in the 19[th] century as a mathematical reformulation of classical mechanics. Its original purpose was to express classical mechanics in a more unified and general manner. Over time, though, scientists have applied it to nearly every area of physics from thermodynamics to quantum field theory [29, 32, 39]. 

In Hamiltonian mechanics, we begin with a set of coordinates ( **q** _,_ **p** ). Usually, **q** = ( _q_ 1 _, ..., qN_ ) represents the positions of a set of objects whereas **p** = ( _p_ 1 _, ..., pN_ ) denotes their momentum. Note how this gives us _N_ coordinate pairs ( _q_ 1 _, p_ 1) _..._ ( _qN , pN_ ). Taken together, they offer a complete description of the system. Next, we define a scalar function, _H_ ( **q** _,_ **p** ) called the Hamiltonian so that 

**==> picture [260 x 23] intentionally omitted <==**

> 1 We make our code available at `github.com/greydanus/hamiltonian-nn` . 

> 2 Any coordinates that describe the state of the system. Later we will use position and momentum ( **p** _,_ **q** ). 

2 

Equation 2 tells us that moving coordinates in the direction **S** _H_ = � _∂∂H_ **p** _[,][ −][∂] ∂[H]_ **q** � gives us the time evolution of the system. We can think of **S** as a vector field over the inputs of _H_ . In fact, it is a special kind of vector field called a “symplectic gradient”. Whereas moving in the direction of the gradient of _H_ changes the output as quickly as possible, moving in the direction of the symplectic gradient _keeps the output exactly constant_ . Hamilton used this mathematical framework to relate the position and momentum vectors ( **q** _,_ **p** ) of a system to its total energy _Etot_ = _H_ ( **q** _,_ **p** ). Then, he found **S** _H_ using Equation 2 and obtained the dynamics of the system by integrating this field according to Equation 1. This is a powerful approach because it works for almost any system where the total energy is conserved. 

Hamiltonian mechanics, like Newtonian mechanics, can predict the motion of a mass-spring system or a single pendulum. But its true strengths only become apparent when we tackle systems with many degrees of freedom. Celestial mechanics, which are chaotic for more than two bodies, are a good example. A few other examples include many-body quantum systems, fluid simulations, and condensed matter physics [29, 32, 39, 33, 9, 12]. 

**Hamiltonian Neural Networks.** In this paper, we propose learning a parametric function for _H_ instead of **S** _H_ . In doing so, we endow our model with the ability to learn _exactly_ conserved quantities from data in an unsupervised manner. During the forward pass, it consumes a set of coordinates and outputs a single scalar “energy-like” value. Then, before computing the loss, we take an in-graph gradient of the output with respect to the input coordinates (Figure A.1). It is with respect to this gradient that we compute and optimize an _L_ 2 loss (Equation 3). 

**==> picture [290 x 25] intentionally omitted <==**

For a visual comparison between this approach and the baseline, refer to Figure 1 or Figure 1(b). This training procedure allows HNNs to learn conserved quantities analogous to total energy straight from data. Apart from conservation laws, HNNs have several other interesting and potentially useful properties. First, they are perfectly reversible in that the mapping from ( **q** _,_ **p** ) at one time to ( **q** _,_ **p** ) at another time is bijective. Second, we can manipulate the HNN-conserved quantity (analogous to total energy) by integrating along the gradient of _H_ , giving us an interesting counterfactual tool (e.g. “What would happen if we added 1 Joule of energy?”). We’ll discuss these properties later in Section 6. 

## **3 Learning a Hamiltonian from Data** 

Optimizing the gradients of a neural network is a rare approach. There are a few previous works which do this [42, 35, 28], but their scope and implementation details diverge from this work and from one another. With this in mind, our first step was to investigate the empirical properties of HNNs on three simple physics tasks. 

**Task 1: Ideal Mass-Spring.** Our first task was to model the dynamics of the frictionless mass-spring system shown in Figure 1. The system’s Hamiltonian is given in Equation 4 where _k_ is the spring constant and _m_ is the mass constant. For simplicity, we set _k_ = _m_ = 1. Then we sampled initial coordinates with total energies uniformly distributed between [0 _._ 2 _,_ 1]. We constructed training and test sets of 25 trajectories each and added Gaussian noise with standard deviation _σ_[2] = 0 _._ 1 to every data point. Each trajectory had 30 observations; each observation was a concatenation of ( **q** _,_ **p** ). 

**==> picture [236 x 23] intentionally omitted <==**

**Task 2: Ideal Pendulum.** Our second task was to model a frictionless pendulum. Pendulums are nonlinear oscillators so they present a slightly more difficult problem. Writing the gravitational constant as _g_ and the length of the pendulum as _l_ , the general Hamiltonian is 

**==> picture [260 x 23] intentionally omitted <==**

Once again we set _m_ = _l_ = 1 for simplicity. This time, we set _g_ = 3 and sampled initial coordinates with total energies in the range [1 _._ 3 _,_ 2 _._ 3]. We chose these numbers in order to situate the dataset along the system’s transition from linear to nonlinear dynamics. As with Task 1, we constructed training and test sets of 25 trajectories each and added the same amount of noise. 

3 

**Task 3: Real Pendulum.** Our third task featured the position and momentum readings from a real pendulum. We used data from a _Science_ paper by Schmidt & Lipson [35] which also tackled the problem of learning conservation laws from data. This dataset was noisier than the synthetic ones and it did not _strictly_ obey any conservation laws since the real pendulum had a small amount of friction. Our goal here was to examine how HNNs fared on noisy and biased real-world data. 

## **3.1 Methods** 

In all three tasks, we trained our models with a learning rate of 10 _[−]_[3] and used the Adam optimizer [20]. Since the training sets were small, we set the batch size to be the total number of examples. On each dataset we trained two fully-connected neural networks: the first was a baseline model that, given a vector input ( **q** _,_ **p** ) output the vector ( _∂_ **q** _/∂t, ∂_ **p** _/∂t_ ) directly. The second was an HNN that estimated the same vector using the derivative of a scalar quantity as shown in Equation 2 (also see Figure A.1). Where possible, we used analytic time derivatives as the targets. Otherwise, we calculated finite difference approximations. All of our models had three layers, 200 hidden units, and `tanh` activations. We trained them for 2000 gradient steps and evaluated them on the test set. 

We logged three metrics: _L_ 2 train loss, _L_ 2 test loss, and mean squared error (MSE) between the true and predicted total energies. To determine the energy metric, we integrated our models according to Equation 1 starting from a random test point. Then we used MSE to measure how much a given model’s dynamics diverged from the ground truth. Intuitively, the loss metrics measure our model’s ability to fit individual data points while the energy metric measures its stability and conservation of energy over long timespans. To obtain dynamics, we integrated our models with the fourth-order Runge-Kutta integrator in `scipy.integrate.solve_ivp` and set the error tolerance to 10 _[−]_[9] [30]. 

## **3.2 Results** 

**==> picture [396 x 262] intentionally omitted <==**

**----- Start of picture text -----**<br>
Predictions MSE between coordinates Total HNN -c onserved quantity Total energy<br>Ideal mass-spring<br>Ideal pendulum<br>Real pendulum<br>**----- End of picture text -----**<br>


Figure 2: Analysis of models trained on three simple physics tasks. In the first column, we observe that the baseline model’s dynamics gradually drift away from the ground truth. The HNN retains a high degree of accuracy, even obscuring the black baseline in the first two plots. In the second column, the baseline’s coordinate MSE error rapidly diverges whereas the HNN’s does not. In the third column, we plot the quantity conserved by the HNN. Notice that it closely resembles the total energy of the system, which we plot in the fourth column. In consequence, the HNN roughly conserves total energy whereas the baseline does not. 

4 

We found that HNNs train as quickly as baseline models and converge to similar final losses. Table 1 shows their relative performance over the three tasks. But even as HNNs tied with the baseline on on loss, they dramatically outperformed it on the MSE energy metric. Figure 2 shows why this is the case: as we integrate the two models over time, various errors accumulate in the baseline and it eventually diverges. Meanwhile, the HNN conserves a quantity that closely resembles total energy and diverges more slowly or not at all. 

It’s worth noting that the quantity conserved by the HNN is not equivalent to the total energy; rather, it’s something very close to the total energy. The third and fourth columns of Figure 2 provide a useful comparison between the HNN-conserved quantity and the total energy. Looking closely at the spacing of the _y_ axes, one can see that the HNN-conserved quantity has the same scale as total energy, but differs by a constant factor. Since energy is a relative quantity, this is perfectly acceptable[3] . 

The total energy plot for the real pendulum shows another interesting pattern. Whereas the ground truth data does not quite conserve total energy, the HNN roughly conserves this quantity. This, in fact, is a fundamental limitation of HNNs: they assume a conserved quantity exists and thus are unable to account for things that violate this assumpation, such as friction. In order to account for friction, we would need to model it separately from the HNN. 

## **4 Modeling Larger Systems** 

Having established baselines on a few simple tasks, our next step was to tackle a larger system involving more than one pair of ( _p, q_ ) coordinates. One well-studied problem that fits this description is the two-body problem, which requires four ( _p, q_ ) pairs. 

**==> picture [298 x 25] intentionally omitted <==**

**Task 4: Two-body problem.** In the two-body problem, point particles interact with one another via an attractive force such as gravity. Once again, we let _g_ be the gravitational constant and _m_ represent mass. Equation 6 gives the Hamiltonian of the system where _µ_ is the reduced mass and **pCM** is the momentum of the center of mass. As in previous tasks, we set _m_ 1 = _m_ 2 = _g_ = 1 for simplicity. Furthermore, we restricted our experiments to systems where the momentum of the center of mass was zero. Even so, with eight degrees of freedom (given by the _x_ and _y_ position and momentum coordinates of the two bodies) this system represented an interesting challenge. 

## **4.1 Methods** 

Our first step was to generate a dataset of 1000 near-circular, two-body trajectories. We initialized every trajectory with center of mass zero, total momentum zero, and radius _r_ = _∥_ **q2** _−_ **q1** _∥_ in the range [0 _._ 5 _,_ 1 _._ 5]. In order to control the level of numerical stability, we chose initial velocities that gave perfectly circular orbits and then added Gaussian noise to them. We found that scaling this noise by a factor of _σ_[2] = 0 _._ 05 produced trajectories with a good balance between stability and diversity. 

We used fourth-order Runge-Kutta integration to find 200 trajectories of 50 observations each and then performed an 80/20% train/test set split over trajectories. Our models and training procedure were identical to those described in Section 3 except this time we trained for 10,000 gradient steps and used a batch size of 200. 

## **4.2 Results** 

The HNN model scaled well to this system. The first row of Figure 3 suggests that it learned to conserve a quantity nearly equal to the total energy of the system whereas the baseline model did not. 

The second row of Figure 3 gives a qualitative comparison of trajectories. After one orbit, the baseline dynamics have completely diverged from the ground truth whereas the HNN dynamics have only accumulated a small amount of error. As we continue to integrate up to _t_ = 50 and beyond (Figure B.1), both models diverge but the HNN does so at a much slower rate. Even as the HNN 

3To see why energy is relative, imagine a cat that is at an elevation of 0 m in one reference frame and 1 m in another. Its potential energy (and total energy) will differ by a constant factor depending on frame of reference. 

5 

diverges from the ground truth orbit, its total energy remains stable rather than decaying to zero or spiraling to infinity. We report quantitative results for this task in Table 1. Both train and test losses of the HNN model were about an order of magnitude lower than those of the baseline. The HNN did a better job of conserving total energy, with an energy MSE that was several orders of magnitude below the baseline. 

Having achieved success on the two-body problem, we ran the same set of experiments on the chaotic three-body problem. We show preliminary results in Appendix B where once again the HNN outperforms its baseline by a considerable margin. We opted to focus on the two-body results here because the three-body results still need improvement. 

**==> picture [219 x 146] intentionally omitted <==**

**----- Start of picture text -----**<br>
Ground truth Hamiltonian NN Baseline NN<br>Time<br>y<br>x<br>Energy<br>Trajectory<br>**----- End of picture text -----**<br>


## **5 Learning a Hamiltonian from Pixels** 

One of the key strengths of neural netFigure 3: works is that they can learn abstract repredynamics sentations directly from high-dimensional data such as pixels or words. Having trained HNN models on position and momentum coordinates, we were eager to see whether we could train them on arbitrary coordinates like the latent vectors of an autoencoder. 

Figure 3: Analysis of an example 2-body trajectory. The dynamics of the baseline model do not conserve total energy and quickly diverge from ground truth. The HNN, meanwhile, approximately conserves total energy and accrues a small amount of error after one full orbit. 

**Task 5: Pixel Pendulum.** With this in mind, we constructed a dataset of pixel observations of a pendulum and then combined an autoencoder with an HNN to model its dynamics. To our knowledge this is the first instance of a Hamiltonian learned directly from pixel data. 

## **5.1 Methods** 

In recent years, OpenAI Gym has been widely adopted by the machine learning community as a means for training and evaluating reinforcement learning agents [5]. Some works have even trained world models on these environments [15, 16]. Seeing these efforts as related and complimentary to our work, we used OpenAI Gym’s `Pendulum-v0` environment in this experiment. 

First, we generated 200 trajectories of 100 frames each[4] . We required that the maximum absolute displacement of the pendulum arm be _[π]_ 6[radians.][Starting from][ 400][ x][ 400][ x][ 3][ RGB pixel observations,] we cropped, desaturated, and downsampled them to 28 x 28 x 1 frames and concatenated each frame with its successor so that the input to our model was a tensor of shape `batch` x 28 x 28 x 2. We used two frames so that velocity would be observable from the input. Without the ability to observe velocity, an autoencoder without recurrence would be unable to ascertain the system’s full state space. 

In designing the autoencoder portion of the model, our main objective was simplicity and trainability. We chose to use fully-connected layers in lieu of convolutional layers because they are simpler. Furthermore, convolutional layers sometimes struggle to extract even simple position information [23]. Both the encoder and decoder were composed of four fully-connected layers with `relu` activations and residual connections. We used 200 hidden units on all layers except the latent vector **z** , where we used two units. As for the HNN component of this model, we used the same architecture and parameters as described in Section 3. Unless otherwise specified, we used the same training procedure as described in Section 4.1. We found that using a small amount of weight decay, 10 _[−]_[5] in this case, was beneficial. 

**Losses.** The most notable difference between this experiment and the others was the loss function. This loss function was composed of three terms: the first being the HNN loss, the second being a classic autoencoder loss ( _L_ 2 loss over pixels), and the third being an auxiliary loss on the autoencoder’s 

> 4Choosing the “no torque” action at every timestep. 

6 

latent space: 

**==> picture [260 x 13] intentionally omitted <==**

The purpose of the auxiliary loss term, given in Equation 7, was to make the second half of **z** , which we’ll label **zp** , resemble the derivatives of the first half of **z** , which we’ll label **zq** . This loss encouraged the latent vector ( **zq** _,_ **zp** ) to have roughly same properties as canonical coordinates ( **q** _,_ **p** ). These properties, measured by the Poisson bracket relations, are necessary for writing a Hamiltonian. We found that the auxiliary loss did not degrade the autoencoder’s performance. Furthermore, it is not domain-specific and can be used with any autoencoder with an even-sized latent space. 

**==> picture [397 x 188] intentionally omitted <==**

**----- Start of picture text -----**<br>
Ground truth<br>Hamiltonian NN<br>Baseline NN<br>Pendulum angle<br>0.2<br>Ground truth<br>0.0 Hamiltonian NN<br>0.2 Baseline NN<br>0 20 40 60 80 100<br>Time<br>**----- End of picture text -----**<br>


Figure 4: Predicting the dynamics of the pixel pendulum. We train an HNN and its baseline to predict dynamics in the latent space of an autoencoder. Then we project to pixel space for visualization. The baseline model rapidly decays to lower energy states whereas the HNN remains close to ground truth even after hundreds of frames. It mostly obscures the ground truth line in the bottom plot. 

## **5.2 Results** 

Unlike the baseline model, the HNN learned to conserve a scalar quantity analogous to the total energy of the system. This enabled it to predict accurate dynamics for the system over much longer timespans. Figure 4 shows a qualitative comparison of trajectories predicted by the two models. As in previous experiments, we computed these dynamics using Equation 2 and a fourth-order Runge-Kutta integrator. Unlike previous experiments, we performed this integration in the latent space of the autoencoder. Then, after integration, we projected to pixel space using the decoder network. The HNN and its baseline reached comparable train and test losses, but once again, the HNN dramatically outperformed the baseline on the energy metric (Table 1). 

Table 1: Quantitative results across all five tasks. Whereas the HNN is competitive with the baseline on train/test loss, it dramatically outperforms the baseline on the energy metric. All values are multiplied by 10[3] unless noted otherwise. See Appendix A for a note on train/test split for Task 3. 

||Train loss||Test loss||Energy||
|---|---|---|---|---|---|---|
|Task|Baseline|HNN|Baseline|HNN|Baseline|HNN|
|1: Ideal mass-spring|37_±_2|37_±_2|37_±_2|**36**_±_**2**|170_±_20|_._**38**_± ._**1**|
|2: Ideal pendulum|33_±_2|33_±_2|**35**_±_**2**|36_±_2|42_±_10|**25**_±_**5**|
|3: Real pendulum|2_._7_± ._2|9_._2_± ._5|**2**_._**2**_± ._**3**|6_._0_± ._6|390_±_7|**14**_±_**5**|
|4: Two body (_×_106)|33_±_1|3_._0_± ._1|30_± ._1|**2**_._**8**_± ._**1**|6_._3_e_4_±_3_e_4|**39**_±_**5**|
|5: Pixel pendulum|18_± ._2|19_± ._2|**17**_± ._**3**|18_± ._3|9_._3_±_1|_._**15**_± ._**01**|



7 

## **6 Useful properties of HNNs** 

While the main purpose of HNNs is to endow neural networks with better physics priors, in this section we ask what other useful properties these models might have. 

**==> picture [140 x 131] intentionally omitted <==**

**----- Start of picture text -----**<br>
0.4<br>tinit<br>tfinal<br>0.2<br>0.0<br>0.2<br>1 0 1 2<br>z0 (analogous to )<br> (analogous to )<br>0<br>z<br>1<br>z<br>**----- End of picture text -----**<br>


**Adding and removing energy.** So far, we have seen that integrating the symplectic gradient of the Hamiltonian can give us the time evolution of a system but we have not tried following the Riemann gradient **R** _H_ = � _∂∂H_ **q** _[,][∂] ∂[H]_ **p** �. Intuitively, this corresponds to adding or removing some of the HNN-conserved quantity from the system. It’s especially interesting to alternate between integrating **R** _H_ and **S** _H_ . Figure 5 shows how we can take advantage of this effect to “bump” the pendulum to a higher energy level. We could imagine using this technique to answer counterfactual questions e.g. “What would have happened if we applied a torque?” 

Figure 5: Visualizing integration in the latent space of the Pixel Pendulum model. We alternately integrate **S** _H_ at low energy (blue circle), **R** _H_ (purple line), and then **S** _H_ at higher energy (red circle). 

**Perfect reversibility.** As neural networks have grown in the latent space of the Pixel Pendulum size, the memory consumption of transient activations, the intermediate activations saved for backpropagation, has model. We alternately integrate **S** _H_ at become a notable bottleneck. Several works propose semilow energy (blue circle), **R** _H_ (purple reversible models that construct one layer’s activations line), and then **S** _H_ at higher energy (red from the activations of the next [13, 25, 19]. Neural ODEs circle). also have this property [7]. Many of these models are only approximately reversible: their mappings are not quite bijective. Unlike those methods, our approach is guaranteed to produce trajectories that are perfectly reversible through time. We can simply refer to a result from Hamiltonian mechanics called Liouville’s Theorem: _the density of particles in phase space is constant_ . What this implies is that any mapping ( **q** 0 _,_ **p** 0) _→_ ( **q** 1 _,_ **p** 1) is bijective/invertible. 

## **7 Related work** 

**Learning physical laws from data.** Schmidt & Lipson [35] used a genetic algorithm to search a space of mathematical functions for conservation laws and recovered the Lagrangians and Hamiltonians of several real systems. We were inspired by their approach, but used a neural neural network to avoid constraining our search to a set of hand-picked functions. Two recent works are similar to this paper in that the authors sought to uncover physical laws from data using neural networks [18, 4]. Unlike our work, they did not explicitly parameterize Hamiltonians. 

**Physics priors for neural networks.** A wealth of previous works have sought to furnish neural networks with better physics priors. Many of these works are domain-specific: the authors used domain knowledge about molecular dynamics [31, 38, 8, 28], quantum mechanics [36], or robotics [24] to help their models train faster or generalize. Others, such as Interaction Networks or Relational Networks were meant to be fully general [43, 34, 2]. Here, we also aimed to keep our approach fully general while introducing a strong and theoretically-motivated prior. 

**Modeling energy surfaces.** Physicists, particularly those studying molecular dynamics, have seen success using neural networks to model energy surfaces [3, 11, 36, 44]. In particular, several works have shown dramatic computation speedups compared to density functional theory [31, 38, 8]. Molecular dynamics researchers integrate the derivatives of energy in order to obtain dynamics, just as we did in this work. A key difference between these approaches and our own is that 1) we emphasize the Hamiltonian formalism 2) we optimize the gradients of our model (though some works do optimize the gradients of a molecular dynamics model [42, 28]). 

## **8 Discussion** 

Whereas Hamiltonian mechanics is an old and well-established theory, the science of deep learning is still in its infancy. Whereas Hamiltonian mechanics describes the real world from first principles, deep learning does so starting from data. We believe that Hamiltonian Neural Networks, and models like them, represent a promising way of bringing together the strengths of both approaches. 

8 

## **9 Acknowledgements** 

Sam Greydanus would like to thank the Google AI Residency Program for providing extraordinary mentorship and resources. The authors would like to thank Nic Ford, Trevor Gale, Rapha Gontijo Lopes, Keren Gu, Ben Caine, Mark Woodward, Stephan Hoyer, Jascha Sohl-Dickstein, and many others for insightful conversations and support. 

Special thanks to James and Judy Greydanus for their feedback and support from beginning to end. 

## **References** 

- [1] Andrychowicz, M., Baker, B., Chociej, M., Jozefowicz, R., McGrew, B., Pachocki, J., Petron, A., Plappert, M., Powell, G., Ray, A., et al. Learning dexterous in-hand manipulation. _arXiv preprint arXiv:1808.00177_ , 2018. 

- [2] Battaglia, P., Pascanu, R., Lai, M., Rezende, D. J., et al. Interaction networks for learning about objects, relations and physics. In _Advances in neural information processing systems_ , pp. 4502–4510, 2016. 

- [3] Behler, J. Neural network potential-energy surfaces in chemistry: a tool for large-scale simulations. _Physical Chemistry Chemical Physics_ , 13(40):17930–17955, 2011. 

- [4] Bondesan, R. and Lamacraft, A. Learning symmetries of classical integrable systems. _arXiv preprint arXiv:1906.04645_ , 2019. 

- [5] Brockman, G., Cheung, V., Pettersson, L., Schneider, J., Schulman, J., Tang, J., and Zaremba, W. Openai gym. _arXiv preprint arXiv:1606.01540_ , 2016. 

- [6] Chang, M. B., Ullman, T., Torralba, A., and Tenenbaum, J. B. A compositional object-based approach to learning physical dynamics. _arXiv preprint arXiv:1612.00341_ , 2016. 

- [7] Chen, T. Q., Rubanova, Y., Bettencourt, J., and Duvenaud, D. K. Neural ordinary differential equations. pp. 6571–6583, 2018. URL `http://papers.nips.cc/paper/ 7892-neural-ordinary-differential-equations.pdf` . 

- [8] Chmiela, S., Tkatchenko, A., Sauceda, H. E., Poltavsky, I., Schütt, K. T., and Müller, K.-R. Machine learning of accurate energy-conserving molecular force fields. _Science advances_ , 3(5): e1603015, 2017. 

- [9] Cohen-Tannoudji, C., Dupont-Roc, J., and Grynberg, G. Photons and atoms-introduction to quantum electrodynamics. _Photons and Atoms-Introduction to Quantum Electrodynamics, by Claude Cohen-Tannoudji, Jacques Dupont-Roc, Gilbert Grynberg, pp. 486. ISBN 0-471-184330. Wiley-VCH, February 1997._ , pp. 486, 1997. 

- [10] de Avila Belbute-Peres, F., Smith, K., Allen, K., Tenenbaum, J., and Kolter, J. Z. End-to-end differentiable physics for learning and control. In _Advances in Neural Information Processing Systems_ , pp. 7178–7189, 2018. 

- [11] Gastegger, M. and Marquetand, P. High-dimensional neural network potentials for organic reactions and an improved training algorithm. _Journal of chemical theory and computation_ , 11 (5):2187–2198, 2015. 

- [12] Girvin, S. M. and Yang, K. _Modern condensed matter physics_ . Cambridge University Press, 2019. 

- [13] Gomez, A. N., Ren, M., Urtasun, R., and Grosse, R. B. The reversible residual network: Backpropagation without storing activations. In _Advances in neural information processing systems_ , pp. 2214–2224, 2017. 

- [14] Grzeszczuk, R. _NeuroAnimator: fast neural network emulation and control of physics-based models._ University of Toronto. 

- [15] Ha, D. and Schmidhuber, J. Recurrent world models facilitate policy evolution. In _Advances in Neural Information Processing Systems_ , pp. 2450–2462, 2018. 

9 

- [16] Hafner, D., Lillicrap, T., Fischer, I., Villegas, R., Ha, D., Lee, H., and Davidson, J. Learning latent dynamics for planning from pixels. _arXiv preprint arXiv:1811.04551_ , 2018. 

- [17] Hamrick, J. B., Allen, K. R., Bapst, V., Zhu, T., McKee, K. R., Tenenbaum, J. B., and Battaglia, P. W. Relational inductive bias for physical construction in humans and machines. _arXiv preprint arXiv:1806.01203_ , 2018. 

- [18] Iten, R., Metger, T., Wilming, H., Del Rio, L., and Renner, R. Discovering physical concepts with neural networks. _arXiv preprint arXiv:1807.10300_ , 2018. 

- [19] Jacobsen, J.-H., Smeulders, A., and Oyallon, E. i-revnet: Deep invertible networks. _arXiv preprint arXiv:1802.07088_ , 2018. 

- [20] Kingma, D. P. and Ba, J. Adam: A method for stochastic optimization. _International Conference on Learning Representations_ , 2014. 

- [21] Krizhevsky, A., Sutskever, I., and Hinton, G. Imagenet classification with deep convolutional neural networks. In _Advances in Neural Information Processing Systems 25_ , pp. 1106–1114, 2012. 

- [22] Levine, S., Pastor, P., Krizhevsky, A., Ibarz, J., and Quillen, D. Learning hand-eye coordination for robotic grasping with deep learning and large-scale data collection. _The International Journal of Robotics Research_ , 37(4-5):421–436, 2018. 

- [23] Liu, R., Lehman, J., Molino, P., Such, F. P., Frank, E., Sergeev, A., and Yosinski, J. An intriguing failing of convolutional neural networks and the coordconv solution. In _Advances in Neural Information Processing Systems_ , pp. 9605–9616, 2018. 

- [24] Lutter, M., Ritter, C., and Peters, J. Deep lagrangian networks: Using physics as model prior for deep learning. _International Conference on Learning Representations_ , 2019. 

- [25] MacKay, M., Vicol, P., Ba, J., and Grosse, R. B. Reversible recurrent neural networks. In _Advances in Neural Information Processing Systems_ , pp. 9029–9040, 2018. 

- [26] Mnih, V., Kavukcuoglu, K., Silver, D., Graves, A., Antonoglou, I., Wierstra, D., and Riedmiller, M. Playing Atari with Deep Reinforcement Learning. _ArXiv e-prints_ , December 2013. 

- [27] Noether, E. Invariant variation problems. _Transport Theory and Statistical Physics_ , 1(3): 186–207, 1971. 

- [28] Pukrittayakamee, A., Malshe, M., Hagan, M., Raff, L., Narulkar, R., Bukkapatnum, S., and Komanduri, R. Simultaneous fitting of a potential-energy surface and its corresponding force fields using feedforward neural networks. _The Journal of chemical physics_ , 130(13):134101, 2009. 

- [29] Reichl, L. E. _A modern course in statistical physics_ . AAPT, 1999. 

- [30] Runge, C. Über die numerische auflösung von differentialgleichungen. _Mathematische Annalen_ , 46(2):167–178, 1895. 

- [31] Rupp, M., Tkatchenko, A., Müller, K.-R., and Von Lilienfeld, O. A. Fast and accurate modeling of molecular atomization energies with machine learning. _Physical review letters_ , 108(5): 058301, 2012. 

- [32] Sakurai, J. J. and Commins, E. D. _Modern quantum mechanics, revised edition_ . AAPT, 1995. 

- [33] Salmon, R. Hamiltonian fluid mechanics. _Annual review of fluid mechanics_ , 20(1):225–256, 1988. 

- [34] Santoro, A., Raposo, D., Barrett, D. G., Malinowski, M., Pascanu, R., Battaglia, P., and Lillicrap, T. A simple neural network module for relational reasoning. In _Advances in neural information processing systems_ , pp. 4967–4976, 2017. 

- [35] Schmidt, M. and Lipson, H. Distilling free-form natural laws from experimental data. _Science_ , 324(5923):81–85, 2009. 

10 

- [36] Schütt, K. T., Arbabzadah, F., Chmiela, S., Müller, K. R., and Tkatchenko, A. Quantumchemical insights from deep tensor neural networks. _Nature communications_ , 8:13890, 2017. 

- [37] Silver, D., Schrittwieser, J., Simonyan, K., Antonoglou, I., Huang, A., Guez, A., Hubert, T., Baker, L., Lai, M., Bolton, A., et al. Mastering the game of go without human knowledge. _Nature_ , 550(7676):354, 2017. 

- [38] Smith, J. S., Isayev, O., and Roitberg, A. E. Ani-1: an extensible neural network potential with dft accuracy at force field computational cost. _Chemical science_ , 8(4):3192–3203, 2017. 

- [39] Taylor, J. R. _Classical mechanics_ . University Science Books, 2005. 

- [40] Tenenbaum, J. B., De Silva, V., and Langford, J. C. A global geometric framework for nonlinear dimensionality reduction. _science_ , 290(5500):2319–2323, 2000. 

- [41] Tompson, J., Schlachter, K., Sprechmann, P., and Perlin, K. Accelerating eulerian fluid simulation with convolutional networks. In _Proceedings of the 34th International Conference on Machine Learning-Volume 70_ , pp. 3424–3433. JMLR. org, 2017. 

- [42] Wang, J., Olsson, S., Wehmeyer, C., Perez, A., Charron, N. E., de Fabritiis, G., Noe, F., and Clementi, C. Machine learning of coarse-grained molecular dynamics force fields. _ACS Central Science_ , 2018. 

- [43] Watters, N., Zoran, D., Weber, T., Battaglia, P., Pascanu, R., and Tacchetti, A. Visual interaction networks: Learning a physics simulator from video. In _Advances in neural information processing systems_ , pp. 4539–4547, 2017. 

- [44] Yao, K., Herr, J. E., Toth, D. W., Mckintyre, R., and Parkhill, J. The tensormol-0.1 model chemistry: A neural network augmented with long-range physics. _Chemical science_ , 9(8): 2261–2269, 2018. 

- [45] Yosinski, J., Clune, J., Hidalgo, D., Nguyen, S., Zagal, J. C., and Lipson, H. Evolving robot gaits in hardware: the hyperneat generative encoding vs. parameter optimization. In _Proceedings of the 20th European Conference on Artificial Life_ , pp. 890–897, August 2011. 

11 

## **A Supplementary Information for Tasks 1-3** 

**==> picture [143 x 111] intentionally omitted <==**

**==> picture [215 x 109] intentionally omitted <==**

**==> picture [279 x 9] intentionally omitted <==**

**----- Start of picture text -----**<br>
(a) Baseline NN (b) Hamiltonian NN<br>**----- End of picture text -----**<br>


Figure A.1: HNN schema. The forward pass of an HNN is composed of a forward pass through a differentiable model as well as a backpropagation step through the model. 

**Training details.** We selected hyperparameters using a coarse grid search over learning rates _{_ 10 _[−]_[1] _,_ 10 _[−]_[2] _,_ 10 _[−]_[3] _}_ , layer widths _{_ 100 _,_ 200 _,_ 300 _}_ , activations _{_ `tanh` _,_ `relu` _}_ , and batch size where relevant _{_ 100 _,_ 200 _}_ . The main objective of this work was not to produce state-of-the-art results, so the settings we chose were aimed simply at producing models that gave good qualitative performance on the tasks at hand. We used weight decay of 10 _[−]_[4] on the first three tasks. 

We trained all of these experiments on a desktop CPU. 

**The train/test split on Task 3.** We partitioned the train and test sets on Task 3 in an unusual manner. The dataset provided by [35] consisted of just a single trajectory from a real pendulum, as shown in the second panel of Figure 2(c). We needed to evaluate our model’s performance over a series of adjacent time steps in order to measure the energy MSE metric. For this reason, we were forced to use the first 4 _/_ 5 of this trajectory for training (black vectors in Figure 2(c)) and the last 1 _/_ 5 for evaluation (red vectors). 

The consequence of this train/test split is that our test set had a slightly different distribution from our training set. We found that the relative magnitudes of the test losses between the baseline and HNN models were informative. We did not perform this ungainly train/test split on the other two tasks in this section. 

12 

**==> picture [318 x 314] intentionally omitted <==**

**----- Start of picture text -----**<br>
Mass-spring system Data Baseline NN Hamiltonian NN<br>1.0 1.0 1.0<br>0.5 0.5 0.5<br>p 0.0 p 0.0 p 0.0<br>0.5 0.5 0.5<br>1.0 1.0 1.0<br>1 0 1 1 0 1 1 0 1<br>q q q<br>(a) Task 1: Ideal mass-spring<br>Pendulum system Data Baseline NN Hamiltonian NN<br>2 2 2<br>1 1 1<br>p 0 p 0 p 0<br>1 1 1<br>2 2 2<br>2 0 2 2 0 2 2 0 2<br>q q q<br>(b) Task 2: Ideal pendulum<br>Real pendulum Real pendulum data Baseline NN Hamiltonian NN<br>1.5 1.0 1.0<br>1.0<br>0.5 0.5<br>0.5<br>p 0.0 TrainTest p 0.0 p 0.0<br>0.5<br>0.5 0.5<br>1.0<br>1.5 1.0 1.0<br>1 0 1 0.5 0.0 0.5 0.5 0.0 0.5<br>q q q<br>(c) Task 3: Real pendulum<br>**----- End of picture text -----**<br>


Figure A.2: More qualitative results comparing the HNN to a baseline neural network on the first three physics tasks. From top to bottom: Task 1: Ideal mass-spring, Task 2: ideal pendulum, Task 3: Real pendulum. 

## **B Supplementary Information for Task 4: Two-body problem** 

> **Training details.** We selected hyperparameters with a grid search as described in the previous section. Again, the main objective of this work was not to produce state-of-the-art results, so the settings we chose were aimed simply at producing models that gave good qualitative performance on the tasks at hand. We did not use weight decay on this task, though when we tried a weight decay of 10 _[−]_[4] or results did not change significantly. 

We trained this experiment on a desktop CPU. 

13 

**==> picture [318 x 205] intentionally omitted <==**

**----- Start of picture text -----**<br>
Trajectories Ground truth energy Baseline NN energy<br>4 True path, body 0 0.4 0.4<br>32 True path, body 1NN path, body 0NN path, body 1 0.2 0.2<br>1 0.0 0.0<br>Potential<br>0 Kinetic<br>0.2 Total 0.2<br>1<br>2 0.4 0.4<br>34 0.6 0.6 PotentialKineticTotal<br>6 4 2 0 2 4 6 0 10 20 30 40 50 0 10 20 30 40 50<br>x Time Time<br>(a) Baseline NN<br>Trajectories Ground truth energy Baseline NN energy<br>1.00 0.4 0.4<br>0.75 0.2 0.2<br>0.50<br>0.250.000.25 True path, body 0True path, body 1NN path, body 0NN path, body 1 0.00.2 PotentialKineticTotal 0.00.2 PotentialKineticTotal<br>0.50 0.4 0.4<br>0.75<br>1.00 0.6 0.6<br>1.5 1.0 0.5 0.0 0.5 1.0 1.5 0 10 20 30 40 50 0 10 20 30 40 50<br>x Time Time<br>(b) Hamiltonian NN<br>y<br>y<br>**----- End of picture text -----**<br>


Figure B.1: More qualitative results for the orbit task. Numerical errors accumulate in the baseline model until the bodies end up traveling in opposite directions. The total energy diverges towards infinity as well. In comparison, the HNN’s trajectory diverges from the ground truth but continues to roughly conserve the total energy of the system. 

**==> picture [378 x 255] intentionally omitted <==**

**----- Start of picture text -----**<br>
Random seed 0 Random seed 1 Random seed 2 Random seed 3<br>0.10 Ground truthBaseline NN 0.13 0.5 0.11 Ground truthBaseline NN<br>0.11 Hamiltonian NN 0.14 1.0 0.12 Hamiltonian NN<br>0.12 0.15 Ground truth 1.5 0.13<br>0.13 0.16 Baseline NNHamiltonian NN 2.0 0.14<br>0.140.15 0.170.18 2.53.03.5 Ground truthBaseline NNHamiltonian NN 0.150.160.17<br>0 5 10 15 20 25 0 5 10 15 20 25 0 5 10 15 20 25 0 5 10 15 20 25<br>Time Time Time Time<br>Random seed 4 Random seed 5 Random seed 6 Random seed 7<br>0.060.08 Ground truthBaseline NNHamiltonian NN 0.090.10 Ground truthBaseline NNHamiltonian NN 0.080.090.10 Ground truthBaseline NNHamiltonian NN 0.110.12 Ground truthBaseline NNHamiltonian NN<br>0.10 0.11 0.11 0.13<br>0.12<br>0.12 0.12 0.13 0.14<br>0.14 0.14 0.15<br>0.13 0.15<br>0.16 0.16 0.16<br>0 5 10 15 20 25 0 5 10 15 20 25 0 5 10 15 20 25 0 5 10 15 20 25<br>Time Time Time Time<br>Random seed 8 Random seed 9 Random seed 10 Random seed 11<br>0.2<br>0.15 Ground truth 0.3 Ground truth Ground truth<br>0.10 Baseline NNHamiltonian NN 0.4 0.2 Baseline NNHamiltonian NN 1.5 Baseline NNHamiltonian NN<br>0.6<br>0.05 0.8 0.1 1.0<br>0.00<br>1.0 0.0 0.5<br>0.05<br>1.2 Ground truth 0.1<br>0.10 Baseline NN 0.0<br>1.4 Hamiltonian NN<br>0.15 0.2<br>0 5 10 15 20 25 0 5 10 15 20 25 0 5 10 15 20 25 0 5 10 15 20 25<br>Time Time Time Time<br>Total energy Total energy Total energy Total energy<br>Total energy Total energy Total energy Total energy<br>Total energy Total energy Total energy Total energy<br>**----- End of picture text -----**<br>


Figure B.2: Comparison of how well the HNN conserves total energy compared to the baseline its baseline on the two-body task. 

**Three body problem.** As mentioned briefly in the body of the paper, we also trained our models on the three body problem. The results we report here show a relative advantage to using the HNN over the baseline model. However, both models struggled to accurately model the dynamics of the three-body problem, which is why we relegated these results to the Appendix. Going forward, we hope to improve these results to the point where they can play a more substantial role in Section 4. 

14 

Table 2 gives a summary of quantitative results and Figure B.3 shows a qualitative analysis of the models we trained on this task. 

Table 2: Quantitative results for the three body problem. All values are multiplied by 10[2] . The confidence intervals suggest that both models struggle to model the distribution of the dataset. We hypothesize that the dynamic range of the dataset is a key issue. 

||Train loss||Test loss||Energy MSE||
|---|---|---|---|---|---|---|
|Task|Baseline|HNN|Baseline|HNN|Baseline|HNN|
|4b: Three body|9_._6_±_7|8_._0_±_2|**38**_±_**40**|49_±_48|**1**_._**1e4**_±_**8e3**|4_._2_±_3|



**==> picture [318 x 212] intentionally omitted <==**

**----- Start of picture text -----**<br>
Ground truth Hamiltonian NN Baseline NN<br>Time<br>y<br>x<br>Energy<br>Trajectory<br>**----- End of picture text -----**<br>


Figure B.3: Analysis of an example three-body trajectory. The baseline model does not conserve total energy and quickly diverges from ground truth. The HNN, meanwhile, roughly conserves total energy and its trajectories resemble the ground truth. 

## **C Supplementary Information for Task 5: Pixel Pendulum** 

**Training details.** We selected hyperparameters with a grid search as described in the previous section. We used a weight decay of 10 _[−]_[5] on this experiment. We found that, unlike previous experiments, weight decay had a significant impact on results. We suspect that this is because the scale of the gradients on the weights of the HNN portion of the model were different from the scale of the gradients of the weights of the autoencoder portion of the model. 

We trained this experiment on a desktop CPU. 

15 

**==> picture [320 x 175] intentionally omitted <==**

**----- Start of picture text -----**<br>
Latent representation of data (z) 0.4 Pendulum phase space<br>real data points<br>0.2 0.2<br>0.0 0.0<br>0.2 0.2<br>1 0 1 2 1 0 1 2<br>z0 (analogous to ) z0 (analogous to )<br>(a) Latent space of the autoencoder (b) Contour plot of HNN-conserved quantity<br>in latent space<br> (analogous to )z0  (analogous to )z0<br>z1 z1<br>**----- End of picture text -----**<br>


Figure C.1: Latent space plots from the Pixel Pendulum model. Note that the learned latent space bears a strong resemblance to the true phase space of a pendulum. In particular, there is a faint diamond shape to the outer contour lines of Figure 1(b). This pattern is reminiscent of the nonlinear dynamics we observed in the ideal pendulum phase space plot of Figure 2 (row 2, column 1) 

16 

