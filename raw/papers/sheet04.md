

# Exercise Sheet 4

## Exercise 1: Markov Model Forward Problem (20 P)

A Markov Model can be seen as a joint distribution over states at each time step  $q_1, \dots, q_T$  where  $q_t \in \{S_1, \dots, S_N\}$ , and where the probability distribution has the factored structure:

$$P(q_1, \dots, q_T) = P(q_1) \cdot \prod_{t=2}^T P(q_t|q_{t-1})$$

Factors are the probability of the initial state and conditional distributions at every time step.

(a) *Show* that the following relation holds:

$$P(q_{t+1} = S_j) = \sum_{i=1}^N P(q_t = S_i) P(q_{t+1} = S_j|q_t = S_i)$$

for  $t \in \{1, \dots, T-1\}$  and  $j \in \{1, \dots, N\}$ .

## Exercise 2: Hidden Markov Model Forward Problem (20 P)

A Hidden Markov Model (HMM) can be seen as a joint distribution over hidden states  $q_1, \dots, q_T$  at each time step and corresponding observation  $O_1, \dots, O_T$ . Like for the Markov Model, we have  $q_t \in \{S_1, \dots, S_N\}$ . The probability distribution of the HMM has the factored structure:

$$P(q_1, \dots, q_T, O_1, \dots, O_T) = P(q_1) \cdot \prod_{t=2}^T P(q_t|q_{t-1}) \cdot \prod_{t=1}^T P(O_t|q_t)$$

Factors are the probability of the initial state and conditional distributions at every time step.

(a) *Show* that the following relation holds:

$$P(O_1, \dots, O_t, O_{t+1}, q_{t+1} = S_j) = \sum_{i=1}^N P(O_1, \dots, O_t, q_t = S_i) P(q_{t+1} = S_j|q_t = S_i) P(O_{t+1}|q_{t+1} = S_j)$$

for  $t \in \{1, \dots, T-1\}$  and  $j \in \{1, \dots, N\}$ .

## Exercise 3: Programming (60 P)

Download the programming files on ISIS and follow the instructions.