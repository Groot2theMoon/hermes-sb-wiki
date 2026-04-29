---
source_url: https://www.tu.berlin/lectures/ml2-2023
ingested: 2026-04-29
sha256: 58cd3236078afe9106b5c6d41bf9142a7e0d9184d11f784d4410c62c52568416
---

## Canonical Correlation Analysis (CCA) 

**==> picture [136 x 100] intentionally omitted <==**

**==> picture [116 x 101] intentionally omitted <==**

**==> picture [85 x 101] intentionally omitted <==**

Lecture by Klaus-Robert Müller, TUB 2023 

## **Setting** 

Measurements are linear superpositions of underlying factors (e.g., sources in EEG/MEG context): 

= x(t) As(t) + ²(t) 

**==> picture [15 x 16] intentionally omitted <==**

Neither A nor s(t) known 

**==> picture [15 x 15] intentionally omitted <==**

Assumptions on A and/or s(t) required to determine the factorization 

Huge variety of methods methods emploing different assumptions: 

PCA, CCA, ICA, JADE, TDSEP, SOBI, NGCA, CSP, SPOC, SSA, SCSA, MVARICA, CICAAR, … 

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

2 

## Canonical Correlation Analysis (CCA) 

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

3 

## Canonical Correlation Analysis (CCA) 

## Latent variable Z is measured in multivariate datasets X and Y 

**==> picture [196 x 30] intentionally omitted <==**

Which representation of X and Y reflects Z best? 

CCA:  That representation that maximises the correlation between X and Y. 

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 4 Lecture at TUB 2023 

## Canonical Correlation Analysis (CCA) 

**==> picture [630 x 392] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

5 

## **Example** 

**==> picture [532 x 414] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

6 

## **Example** 

**==> picture [523 x 392] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

7 

## **Finding the CCA Solution** 

## Assuming centered data 

We can compute empirical cross-covariance matrices and auto-covariance matrices 

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

**==> picture [208 x 55] intentionally omitted <==**

**==> picture [150 x 103] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

8 

## **Finding the CCA Solution** 

**==> picture [626 x 386] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

9 

## **Finding the CCA Solution** 

**==> picture [599 x 385] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 10 Lecture at TUB 2023 

## **Finding the CCA Solution** 

**==> picture [628 x 341] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 11 Lecture at TUB 2023 

## **Example** 

**==> picture [624 x 391] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 12 Lecture at TUB 2023 

## **Example** 

## After CCA 

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

**==> picture [462 x 347] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

13 

## **A Short History of CCA** 

- Extensions of CCA 

   - more than two variables [Kettenring 1971] 

   - Kernel CCA (kCCA) [Akaho 2001] 

      - finds non-linear dependencies 

      - applicable to high-dimensional data 

- Recently CCA became popular in 

   - Machine Learning 

      - Objective function for kernel ICA [Bach 2002] 

      - Mutual information estimation [Gretton 2005] 

   - Neuroscience 

      - Receptive fields without spike triggering [Macke 2008] 

      - Analysis of fMRI and multivariate stimuli [Hardoon 2007] 

      - Analysis of multi-modal recordings [Bießmann 2009] 

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 14 Lecture at TUB 2023 

## **Shortcomings of Standard CCA** 

- Sometimes covariance matrices are too big to compute 

   - Example: Bag-of-Words feature space (potentially infinite dimensional) 

- CCA does not capture non-linear dependencies 

## • Solution: 

- **Kernel Canonical Correlation Analysis (kCCA)** 

- Operates on kernels of the data (not covariance matrices) 

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

15 

## **Bag-of-Words Feature Representation** 

**==> picture [548 x 399] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

16 

## **Solving CCA on the Data Kernels** 

Same intuition as for kernel PCA: any solution found by CCA has to lie in the subspace spanned by the data points. 

A sufficient representation of this subspace can be obtained by the inner products of all data points (linear kernels). 

**==> picture [152 x 73] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 17 Lecture at TUB 2023 

## **Solving CCA on the Data Kernels** 

**==> picture [623 x 245] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 18 Lecture at TUB 2023 

## **Example** 

**==> picture [632 x 381] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

19 

## **Example** 

**==> picture [636 x 381] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

20 

## **Temporal Kernel CCA (tkCCA)** 

## • If variables are coupled with delays 

– simultaneous samples will not be correlated 

– Standard (k)CCA will not find the right solution 

- Solution 

   - Shift one variable relative to the other 

– Maximise correlation for (a sum over) all relative time lags 

➡(k)CCA finds _canonical variates and correlation_ 

tkCCA finds ➡ _canonical convolution and correlogram_ 

**==> picture [564 x 102] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

21 

## **tkCCA: correlating apples and oranges over time** 

**==> picture [464 x 73] intentionally omitted <==**

**==> picture [374 x 107] intentionally omitted <==**

**==> picture [370 x 85] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 23 Lecture at TUB 2023 

## **Application: Neuro-Vascular Coupling** 

**==> picture [585 x 397] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

25 

## **Experimental Setup** 

## Simultaneous measurements of 

- fMRI/ BOLD signal 

- Intracortical neural activity 

**==> picture [275 x 188] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

**==> picture [240 x 188] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

26 

## **Analysis of Simultaneous Recordings** 

Spectrogram of neural activity 

**==> picture [189 x 177] intentionally omitted <==**

fMRI Time series 

**==> picture [98 x 108] intentionally omitted <==**

– X and Y have different dimensions 

– High-dimensional data 

– non-instantaneous couplings 

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

27 

## **tkCCA Objective** 

**==> picture [626 x 376] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

28 

## **Raw Data During Spontaneous Activity** 

**==> picture [622 x 387] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

29 

## **Results: Spatial dependencies and HRF** 

**==> picture [615 x 378] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 30 Lecture at TUB 2023 

**==> picture [670 x 294] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

31 

## **Temporal Dynamics of Web Data** 

**==> picture [606 x 222] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 32 Lecture at TUB 2023 

## **Canonical Trend Analysis** 

**==> picture [574 x 224] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 33 Lecture at TUB 2023 

## **Motivation** 

**==> picture [582 x 118] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 34 Lecture at TUB 2023 

## **Canonical Trend Analysis for Social Networks** 

**==> picture [597 x 430] intentionally omitted <==**

## **Data Extraction** 

**==> picture [539 x 390] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

36 

## **Data Extraction: Retweet Location** 

**==> picture [542 x 228] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 37 Lecture at TUB 2023 

## **Mean Location of Reweeted News Articles** 

**==> picture [600 x 311] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

38 

## **Downsampling of Geographic Information** 

**==> picture [597 x 358] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

39 

## **Canonical Trend Model** 

**==> picture [470 x 346] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

42 

## **Why projecting on canonical subspace** 

**==> picture [578 x 268] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 43 Lecture at TUB 2023 

## **Canonical Trend Analysis** 

**==> picture [581 x 382] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

44 

## **Canonical Trend Analysis** 

**==> picture [565 x 376] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 45 Lecture at TUB 2023 

## **Efficient Computation of Canonical Trends** 

**==> picture [532 x 409] intentionally omitted <==**

## **Efficient Computation of Canonical Trends** 

**==> picture [532 x 346] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

47 

## **Efficient Computation of Canonical Trends** 

**==> picture [602 x 344] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

48 

## **Comparisons: Mean, PCA and Canonical Trends** 

**==> picture [533 x 375] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 49 Lecture at TUB 2023 

## **Comparisons: Mean, PCA and Canonical Trends** 

**==> picture [542 x 360] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 50 Lecture at TUB 2023 

## **Comparisons: Mean, PCA and Canonical Trends** 

**==> picture [536 x 431] intentionally omitted <==**

## **Comparisons: Mean, PCA and Canonical Trends** 

**==> picture [544 x 265] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

52 

## **Canonical Convolution** 

**==> picture [512 x 404] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

53 

## **Canonical Convolution** 

**==> picture [612 x 374] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller Lecture at TUB 2023 

54 

## **Spatiotemporal Analysis of Retweets of News** 

**==> picture [602 x 357] intentionally omitted <==**

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 55 Lecture at TUB 2023 

## **Summary** 

- CCA 

   - finds projections for two datasets that maximise their correlation 

- kernel CCA 

   - extend CCA to potentially non-linear dependencies 

   - makes CCA applicable to high dimensional data 

- temporal kernel CCA 

   - extends kCCA to data with non-instantaneous correlations 

– computes multivariate convolution from one modality to another 

**==> picture [56 x 41] intentionally omitted <==**

**==> picture [45 x 38] intentionally omitted <==**

Klaus-Robert Müller 56 Lecture at TUB 2023 
