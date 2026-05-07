

## Example: Sun, Rain, and Activities

**States.**  $S_1 = \text{sun}$ ,  $S_2 = \text{rain}$

**Symbols.**  $v_1 = \text{walk}$ ,  $v_2 = \text{shop}$ ,  $v_3 = \text{clean}$

**Parameters.**

![State transition diagram for a Hidden Markov Model with two states: SUN (S1) and RAIN (S2). SUN is a yellow box with self-loop 0.8, transition to RAIN 0.2, and emissions walk: 0.5, shop: 0.4, clean: 0.1. RAIN is a blue box with self-loop 0.7, transition to SUN 0.3, and emissions walk: 0.1, shop: 0.3, clean: 0.6.](820515db47ded68f5e0b625f4ec7d2c1_img.jpg)

$$\pi = \begin{bmatrix} \text{sun} & \text{rain} \\ 0.5 & 0.5 \end{bmatrix}$$
$$A = \begin{bmatrix} & \text{sun} & \text{rain} \\ \text{sun} & 0.8 & 0.2 \\ \text{rain} & 0.3 & 0.7 \end{bmatrix}$$
$$B = \begin{bmatrix} & \text{walk} & \text{shop} & \text{clean} \\ \text{sun} & 0.5 & 0.4 & 0.1 \\ \text{rain} & 0.1 & 0.3 & 0.6 \end{bmatrix}$$

}  $\lambda$

```
graph LR; S1[SUN (S1)] -- 0.8 --> S1; S1 -- 0.2 --> S2[RAIN (S2)]; S2 -- 0.3 --> S1; S2 -- 0.7 --> S2; style S1 fill:#f9d585,stroke:#333,stroke-width:1px; style S2 fill:#a6c9e4,stroke:#333,stroke-width:1px;
```

State transition diagram for a Hidden Markov Model with two states: SUN (S1) and RAIN (S2). SUN is a yellow box with self-loop 0.8, transition to RAIN 0.2, and emissions walk: 0.5, shop: 0.4, clean: 0.1. RAIN is a blue box with self-loop 0.7, transition to SUN 0.3, and emissions walk: 0.1, shop: 0.3, clean: 0.6.

**Observations.**  $O = (\text{walk}, \text{clean}, \text{walk})$ ,  $T = 3$ .

## Forward–Backward and the smoothed posterior $\gamma_t(i)$

**The right inference target.** Given the whole observation sequence  $O = O_{1:T}$ , what should we believe about the hidden state  $q_t$  at any one time  $t$ ?

$$\gamma_t(i) = P(q_t = S_i | O, \lambda).$$

![Diagram illustrating the forward-backward algorithm. A sequence of hidden states q1, q2, qt, qt+1, qT is shown in a row. Below each state is an observation node O1, O2, Ot, Ot+1, OT. The state qt is highlighted with a red circle. The states q1 and q2 are in a blue shaded region labeled 'past O1:t'. The states qt+1 and qT are in an orange shaded region labeled 'future Ot+1:T'. Arrows point from each state to its corresponding observation and to the next state in the sequence.](4792a2ccd62226861fadc22117edb7b1_img.jpg)

Diagram illustrating the forward-backward algorithm. A sequence of hidden states q1, q2, qt, qt+1, qT is shown in a row. Below each state is an observation node O1, O2, Ot, Ot+1, OT. The state qt is highlighted with a red circle. The states q1 and q2 are in a blue shaded region labeled 'past O1:t'. The states qt+1 and qT are in an orange shaded region labeled 'future Ot+1:T'. Arrows point from each state to its corresponding observation and to the next state in the sequence.

**Markov split** (future  $\perp$  past given  $q_t$ ):

$$\begin{aligned}\gamma_t(i) &\propto P(q_t = S_i, O_{1:t}, O_{t+1:T}) \\ &= \underbrace{P(q_t = S_i, O_{1:t})}_{\alpha_t(i) \text{ (forward)}} \cdot \underbrace{P(O_{t+1:T} | q_t = S_i)}_{\beta_t(i) \text{ (backward)}}\end{aligned}$$

**Two recursions, both  $\mathcal{O}(N^2T)$ :**  $\alpha_t(i)$  collects past mass into state  $i$  at time  $t$ ;  $\beta_t(i)$  collects probability of the future given state  $i$  at time  $t$ . The smoothed posterior is just their product (and the data likelihood is the normaliser):  $\gamma_t(i) = \alpha_t(i) \beta_t(i) / P(O | \lambda)$ ,  $P(O | \lambda) = \sum_i \alpha_T(i) = \sum_i \pi_i b_i(O_1) \beta_1(i)$ .

$P(O)$  and learning  $\lambda$  are built from  $\alpha$  and  $\beta$ .

### Deriving $\gamma_t(i)$

Split the observation sequence at time  $t$ , apply the chain rule, and drop the past from the conditional. The drop uses HMM conditional independence ( $O_{t+1:T} \perp O_{1:t} \mid q_t$ , by d-separation on the unrolled chain):

$$\begin{aligned}\gamma_t(i) &\propto P(q_t = S_i, O) \\ &= P(q_t = S_i, O_{1:t}, O_{t+1:T}) \\ &= P(q_t = S_i, O_{1:t}) \cdot P(O_{t+1:T} \mid q_t = S_i, O_{1:t}) \quad [\text{chain rule}] \\ &= \underbrace{P(q_t = S_i, O_{1:t})}_{\alpha_t(i) \text{ (forward)}} \cdot \underbrace{P(O_{t+1:T} \mid q_t = S_i)}_{\beta_t(i) \text{ (backward)}} \quad [\text{future} \perp \text{past} \mid q_t]\end{aligned}$$

The decomposition forces the two definitions. Now we just need recursions.

**Forward** (sketch; full derivation is Exercise 2 on the sheet). Marginalising  $\alpha_t$  over  $q_{t-1}$  with Markov + output-independence:

$$\alpha_t(j) = \left[ \sum_i \alpha_{t-1}(i) a_{ij} \right] b_j(O_t), \quad \alpha_1(j) = \pi_j b_j(O_1).$$

**Backward** (same two assumptions, marginalise  $\beta_t$  over  $q_{t+1}$ ).

$$\begin{aligned}\beta_t(i) &= \sum_j P(q_{t+1} = S_j, O_{t+1:T} \mid q_t = S_i) \\ &= \sum_j \underbrace{P(q_{t+1} = S_j \mid q_t = S_i)}_{a_{ij}} \underbrace{P(O_{t+1} \mid q_{t+1} = S_j)}_{b_j(O_{t+1})} \underbrace{P(O_{t+2:T} \mid q_{t+1} = S_j)}_{\beta_{t+1}(j)} \\ &= \sum_j a_{ij} b_j(O_{t+1}) \beta_{t+1}(j), \quad \beta_T(i) = 1.\end{aligned}$$

### Forward Procedure

$$\alpha_1(i) = \pi_i b_i(O_1), \quad \alpha_{t+1}(j) = \left[ \sum_i \alpha_t(i) a_{ij} \right] b_j(O_{t+1}), \quad P(O | \lambda) = \sum_i \alpha_T(i)$$

![A directed graph representing a Hidden Markov Model (HMM) with two states (sun, rain) and three time steps (t=1, t=2, t=3). Transitions are between states at the same time step and between consecutive time steps. Emissions are labeled below each state at each time step.](9e6062272bbe3ddbb7c0606721d64cf0_img.jpg)

The diagram illustrates the forward procedure for a Hidden Markov Model (HMM) with two states: 'sun' (yellow circles) and 'rain' (blue circles) across three time steps:  $t=1$ ,  $t=2$ , and  $t=3$ . The initial probabilities are  $\alpha_1(\text{sun}) = 0.25$  and  $\alpha_1(\text{rain}) = 0.05$ . The observations are 'walk' at  $t=1$ , 'clean' at  $t=2$ , and 'walk' at  $t=3$ . The emission probabilities are  $b_{\text{sun}}(\text{walk}) = 0.5$ ,  $b_{\text{rain}}(\text{walk}) = 0.1$ ,  $b_{\text{sun}}(\text{clean}) = 0.8$ ,  $b_{\text{rain}}(\text{clean}) = 0.2$ ,  $b_{\text{sun}}(\text{walk}) = 0.5$ , and  $b_{\text{rain}}(\text{walk}) = 0.1$ . The transition probabilities are  $a_{\text{sun}, \text{sun}} = 0.8$ ,  $a_{\text{sun}, \text{rain}} = 0.3$ ,  $a_{\text{rain}, \text{sun}} = 0.2$ , and  $a_{\text{rain}, \text{rain}} = 0.7$ . The forward variables are calculated as  $\alpha_2(\text{sun}) = 0.0215$ ,  $\alpha_2(\text{rain}) = 0.051$ ,  $\alpha_3(\text{sun}) = 0.0163$ , and  $\alpha_3(\text{rain}) = 0.004$ .

A directed graph representing a Hidden Markov Model (HMM) with two states (sun, rain) and three time steps (t=1, t=2, t=3). Transitions are between states at the same time step and between consecutive time steps. Emissions are labeled below each state at each time step.

$$\begin{aligned} \alpha_1(\text{sun}) &= 0.5 \cdot 0.5 &= 0.25 \\ \alpha_1(\text{rain}) &= 0.5 \cdot 0.1 &= 0.05 \\ \\ \alpha_2(\text{sun}) &= (0.25 \cdot 0.8 + 0.05 \cdot 0.3) \cdot 0.1 &= 0.0215 \\ \alpha_2(\text{rain}) &= (0.25 \cdot 0.2 + 0.05 \cdot 0.7) \cdot 0.6 &= 0.051 \\ \\ \alpha_3(\text{sun}) &= (0.0215 \cdot 0.8 + 0.051 \cdot 0.3) \cdot 0.5 &= 0.0163 \\ \alpha_3(\text{rain}) &= (0.0215 \cdot 0.2 + 0.051 \cdot 0.7) \cdot 0.1 &= 0.004 \\ \\ P(O | \lambda) &= \alpha_3(\text{sun}) + \alpha_3(\text{rain}) &= 0.0203 \end{aligned}$$

**Intuition.**  $\alpha_t(i) = P(O_1, \dots, O_t, q_t = S_i | \lambda)$  collects the total probability mass over *all* paths that explain the observations up to time  $t$  and end in state  $S_i$ . Summing over  $i$  at  $t = T$  marginalises the final state and yields  $P(O | \lambda)$ .

**Cost.**  $\mathcal{O}(N^2 T)$  for the recursion versus  $\mathcal{O}(N^T)$  for naive enumeration. On the sheet's text task ( $N = 200, T = 50$ ) that's about  $2 \cdot 10^6$  updates against  $10^{115}$  paths.

### Viterbi: the same recursion, with max for $\sum$

$$\delta_1(j) = \pi_j b_j(O_1), \quad \delta_{t+1}(j) = \left[ \max_i \delta_t(i) a_{ij} \right] b_j(O_{t+1}), \quad \psi_{t+1}(j) = \arg \max_i \delta_t(i) a_{ij}$$

![A directed graph representing the Viterbi algorithm for a Hidden Markov Model (HMM) with two states (sun, rain) and three time steps (t=1, t=2, t=3). The nodes are arranged in a grid: sun (yellow) and rain (blue) for each time step. Transitions are shown by arrows: sun to sun (red), sun to rain (grey), rain to sun (grey), and rain to rain (grey). Emission probabilities are shown inside the nodes: sun at t=1 (0.25), rain at t=1 (0.05), sun at t=2 (0.020), rain at t=2 (0.030), sun at t=3 (0.008), and rain at t=3 (0.0021). Observations are: walk at t=1, clean at t=2, and walk at t=3. The best path is highlighted in red: sun at t=1, sun at t=2, sun at t=3.](e394c2b5c61344f6a12397f430086072_img.jpg)

A directed graph representing the Viterbi algorithm for a Hidden Markov Model (HMM) with two states (sun, rain) and three time steps (t=1, t=2, t=3). The nodes are arranged in a grid: sun (yellow) and rain (blue) for each time step. Transitions are shown by arrows: sun to sun (red), sun to rain (grey), rain to sun (grey), and rain to rain (grey). Emission probabilities are shown inside the nodes: sun at t=1 (0.25), rain at t=1 (0.05), sun at t=2 (0.020), rain at t=2 (0.030), sun at t=3 (0.008), and rain at t=3 (0.0021). Observations are: walk at t=1, clean at t=2, and walk at t=3. The best path is highlighted in red: sun at t=1, sun at t=2, sun at t=3.

$$\delta_1(\text{sun}) = 0.25$$

$$\delta_1(\text{rain}) = 0.05$$

$$\delta_2(\text{sun}) = \max(0.20, 0.015) \cdot 0.1 = 0.020$$

$$\delta_2(\text{rain}) = \max(0.05, 0.035) \cdot 0.6 = 0.030$$

$$\delta_3(\text{sun}) = \max(0.016, 0.009) \cdot 0.5 = 0.008$$

$$\delta_3(\text{rain}) = \max(0.004, 0.021) \cdot 0.1 = 0.0021$$

$$\psi_2(\text{sun}) = \text{sun}, \quad \psi_2(\text{rain}) = \text{sun} \qquad \psi_3(\text{sun}) = \text{sun}, \quad \psi_3(\text{rain}) = \text{rain}$$

$$P^* = 0.008, \quad Q^* = (\text{sun}, \text{sun}, \text{sun})$$

**Intuition.**  $\delta_t(j)$  = probability of the *single best* path ending in  $S_j$  at time  $t$  (max over  $q_{1:t-1}$ , not  $\sum$ ). The red term inside each max is the winning  $\delta_{t-1}(i) \cdot a_{ij}$ , so  $\psi_t(j)$  is the index  $i$  on that side. Backtracking from  $\arg \max_i \delta_T(i)$  along these winners gives  $Q^*$ .

### Baum–Welch: ML for $\lambda$ when $Q$ is hidden

**Goal:** ML estimate  $\hat{\lambda} = \arg \max_{\lambda} P(O | \lambda)$ . If  $Q$  were observed, ML would reduce to counting transitions and emissions (closed form, just as  $\hat{\theta} = k/n$  for the coin). But  $Q$  is hidden:  $P(O | \lambda) = \sum_Q P(Q, O | \lambda)$ .

**Posteriors over the latent path** (under current  $\lambda$ ):

$$\gamma_t(i) = P(q_t = S_i | O, \lambda), \quad \xi_t(i, j) = P(q_t = S_i, q_{t+1} = S_j | O, \lambda) = \frac{\alpha_t(i) a_{ij} b_j(O_{t+1}) \beta_{t+1}(j)}{P(O | \lambda)} \text{ (sandwich)}$$

![Diagram illustrating the forward and backward passes in the Baum–Welch algorithm. The forward pass (blue background) includes states q1, q2, ..., qt and observations O1, O2, ..., Ot. The backward pass (red background) includes states qt+1, ..., qT and observations Ot+1, ..., OT. A transition arrow labeled a_ij connects qt to qt+1, and an emission arrow labeled b_j(O_{t+1}) connects qt+1 to Ot+1.](f6d72d7c790e7f585532140f3971639a_img.jpg)

The diagram shows a sequence of hidden states  $q_1, q_2, \dots, q_t, q_{t+1}, \dots, q_T$  and observations  $O_1, O_2, \dots, O_t, O_{t+1}, \dots, O_T$ . The forward pass (blue background) calculates  $\alpha_t(i)$  for  $q_1, q_2, \dots, q_t$ . The backward pass (red background) calculates  $\beta_{t+1}(j)$  for  $q_{t+1}, \dots, q_T$ . A transition  $a_{ij}$  is shown from  $q_t$  to  $q_{t+1}$ , and an emission  $b_j(O_{t+1})$  is shown from  $q_{t+1}$  to  $O_{t+1}$ .

Diagram illustrating the forward and backward passes in the Baum–Welch algorithm. The forward pass (blue background) includes states q1, q2, ..., qt and observations O1, O2, ..., Ot. The backward pass (red background) includes states qt+1, ..., qT and observations Ot+1, ..., OT. A transition arrow labeled a\_ij connects qt to qt+1, and an emission arrow labeled b\_j(O\_{t+1}) connects qt+1 to Ot+1.

**Re-estimation** (soft counts over totals, analogous to  $\hat{\theta} = k/n$  for the coin):

$$\bar{\pi}_i = \gamma_1(i), \quad \bar{a}_{ij} = \frac{\sum_t \xi_t(i, j)}{\sum_t \gamma_t(i)}, \quad \bar{b}_j(k) = \frac{\sum_{t: O_t = v_k} \gamma_t(j)}{\sum_t \gamma_t(j)}$$

Iterate; each pass is guaranteed not to decrease  $P(O | \lambda)$ .

Baum–Welch on  $O = (\text{walk, clean, walk})$

![Diagram of a Hidden Markov Model (HMM) with three hidden states q1, q2, and q3. Transitions are shown as arrows from q1 to q2 and q2 to q3. Observations are shown as arrows from each state to a shaded circle: q1 to 'walk', q2 to 'clean', and q3 to 'walk'.](1956f44611abd5c3c41049836aa78ad8_img.jpg)

```

graph LR
    q1((q1)) --> q2((q2))
    q2 --> q3((q3))
    q1 --> w1((walk))
    q2 --> c((clean))
    q3 --> w3((walk))
    style w1 fill:#888
    style c fill:#888
    style w3 fill:#888
  
```

Diagram of a Hidden Markov Model (HMM) with three hidden states q1, q2, and q3. Transitions are shown as arrows from q1 to q2 and q2 to q3. Observations are shown as arrows from each state to a shaded circle: q1 to 'walk', q2 to 'clean', and q3 to 'walk'.

**Backward recursion** (mirror of forward):  $\beta_T(i) = 1$ ,  $\beta_t(i) = \sum_j a_{tj} b_j(O_{t+1}) \beta_{t+1}(j)$ .

$$\beta_3(\text{sun}) = 1$$

$$\beta_3(\text{rain}) = 1$$

$$\beta_2(\text{sun}) = 0.8 \cdot 0.5 \cdot 1 + 0.2 \cdot 0.1 \cdot 1 = 0.42$$

$$\beta_2(\text{rain}) = 0.3 \cdot 0.5 \cdot 1 + 0.7 \cdot 0.1 \cdot 1 = 0.22$$

$$\beta_1(\text{sun}) = 0.8 \cdot 0.1 \cdot 0.42 + 0.2 \cdot 0.6 \cdot 0.22 = 0.060$$

$$\beta_1(\text{rain}) = 0.3 \cdot 0.1 \cdot 0.42 + 0.7 \cdot 0.6 \cdot 0.22 = 0.105$$

**Posteriors** (soft counts):  $\gamma_t(i) = \frac{\alpha_t(i) \beta_t(i)}{P(O | \lambda)}$ ,  $\xi_t(i, j) = \frac{\alpha_t(i) a_{tj} b_j(O_{t+1}) \beta_{t+1}(j)}{P(O | \lambda)}$ .

$$\xi_1(\text{sun, rain}) = \frac{0.25 \cdot 0.2 \cdot 0.6 \cdot 0.22}{0.0203} = 0.326, \quad \gamma_2(\text{sun}) = \frac{0.0215 \cdot 0.42}{0.0203} = 0.446$$

**Re-estimation** (one update on our data):

$$\bar{\pi} = (0.74, 0.26) \text{ was } (0.5, 0.5)$$

$$\bar{a}(\text{sun} \rightarrow \text{sun}) = 0.71 \text{ was } 0.8$$

$$\bar{b}_{\text{sun}}(\text{walk}) = 0.78 \text{ was } 0.5$$

*posterior over the initial state shifts toward sun, and the model adapts to the data.*