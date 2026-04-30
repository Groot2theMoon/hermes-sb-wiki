---
source_url: 
ingested: 2026-04-29
sha256: 1d8713cab113df5610d91013d19a335ba137a40ed6cf2c7bd9fe9f36dad3d272
---

# Second Law of Thermodynamics with Discrete Quantum Feedback Control 

Takahiro Sagawa[1] and Masahito Ueda[1][,][2] 

> 1Department of Physics, Tokyo Institute of Technology, 

2-12-1 Ookayama, Meguro-ku, Tokyo 152-8551, Japan 

> 2ERATO Macroscopic Quantum Control Project, JST, 

2-11-16 Yayoi, Bunkyo-ku, Tokyo 113-8656, Japan 

(Dated: October 25, 2018) 

A new thermodynamic inequality is derived which leads to the maximum work that can be extracted from multi-heat baths with the assistance of discrete quantum feedback control. The maximum work is determined by the free-energy difference and a generalized mutual information content between the thermodynamic system and the feedback controller. This maximum work can exceed that in conventional thermodynamics and, in the case of a heat cycle with two heat baths, the heat efficiency can be greater than that of the Carnot cycle. The consistency of our results with the second law of thermodynamics is ensured by the fact that work is needed for information processing of the feedback controller. 

PACS numbers: 03.67.-a,05.70.Ln,05.30.-d,03.65.Ta 

Among a large number of studies conducted on the relationship between thermodynamics and information processing [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], particularly provoking is the work by Szilard [2] who argued that positive work Wext can be extracted from an isothermal cycle if Maxwell’s demon plays the role of a feedback controller [7]. It is now well understood that the role of the demon does not contradict the second law of thermodynamics, because the initialization of the demon’s memory entails heat dissipation [3, 4, 5]. We note that, in the case of an isothermal process, the second law of thermodynamics can be expressed as 

**==> picture [157 x 13] intentionally omitted <==**

where ∆F[S] is the difference in the Helmholtz free energy between the initial and final thermodynamic equilibrium states. 

In a different context, quantum feedback control has attracted considerable attention for controlling and stabilizing a quantum system [16, 17, 18, 19, 20, 21, 22]. It can be applied, for example, to squeezing an electromagnetic field [18], spin squeezing [20], and stabilizing macroscopic coherence [22]. While the theoretical framework of quantum feedback control as a stochastic dynamic system is well developed, the possible thermodynamic gain of quantum feedback control has yet to be fully understood. 

In this Letter, we derive a new thermodynamic inequality which sets the fundamental limit on the work that can be extracted from multi-heat baths with discrete quantum feedback control [7, 24], consisting of quantum measurement [24, 25] and a mechanical operation depending on the measurement outcome. The maximum work is characterized by a generalized mutual information content between the thermodynamic system and the feedback controller. We shall refer to this as the QC-mutual information content, where QC indicates that the mea- 

sured system is quantal and that the measurement outcome is classical. The QC-mutual information content reduces to the classical mutual information content [23] in the case of classical measurement. In the absence of feedback control, the new inequality (12) reduces to the Clausius inequality. In the case of an isothermal process, its upper bound exceeds that of inequality (1) by an amount proportional to the QC-mutual information content. 

We consider a thermodynamic process for system S which can contact heat baths B1, B2, · · · , Bn at respective temperatures T1, T2, · · · , Tn. We assume that system S is in thermodynamic equilibrium in the initial and final states. For simplicity, we also assume that the initial and final temperature of S is given by T ≡ (kBβ)[−][1] . This can be realized by contacting S with, for example, B1 in the preparation of the initial state and during equilibration to the final state; in this case T = T1. We do not, however, assume that the system is in thermodynamic equilibrium between the initial and final states. 

We assume that system S and heat baths Bm are as a whole isolated and that they only come into contact with some external mechanical systems and the feedback controller. Apart from the feedback controller, the total Hamiltonian can be written as 

**==> picture [215 x 28] intentionally omitted <==**

where H[ˆ][SB][m] (t) is the interaction Hamiltonian between system S and heat bath Bm. The Hamiltonian H[ˆ][S] (t) describes a mechanical operation on S through such external parameters as an applied magnetic field or volume of the gas, and the Hamiltonian H[ˆ][SB][m] (t) describes, for example, the attachment (detachment) of an adiabatic wall or Bm to (from) S. We consider a time evolution from ti to tf , assume H[ˆ][SB][m] (ti) = H[ˆ][SB][m] (tf ) = 0 for all m, and write H[ˆ][S] (ti) = H[ˆ] i[S][and][H][ˆ][S][(][t][f][)][=][H][ˆ] f[S][.][The][time] 

2 

evolution of the total system with discrete quantum feedback control can be divided into the following five stages: 

Stage 1 (Initial state) At time ti, the initial state of S and that of Bm are in thermodynamic equilibrium at temperatures T and Tm, respectively. We assume that the density operator of the entire state is given by the canonical distribution 

**==> picture [246 x 38] intentionally omitted <==**

where βm ≡ (kBTm)[−][1] (m = 1, 2, · · · , n), Zi[S] ≡ tr{exp(−βH[ˆ] i[S][)][}][,][and][Z][B][m][≡][tr][{][exp(][−][β][m][H][ˆ][B][m][)][}][.] We denote the Helmholtz free energy of system S as Fi[S] ≡ −kBT ln Zi[S][.] Stage 2 (Unitary evolution) From ti to t1ˆ, the entire system undergoes unitary evolution Ui = T exp ��tti1 Hˆ (t)dt/iℏ�. 

Stage 3 (Measurement ) From t1 to t2, the feedback controller performs quantum measurement on S described by measurement operators {M[ˆ] k} and obtains each outcome k with probability pk. Let X be the set ofˆ outcomesˆ k’s, and {D[ˆ] k} be POVM as defined by Dk ≡ Mk[†] M[ˆ] k; we then have pk = tr( D[ˆ] k ˆρ). We denote the pre-measurement density operator of the entire system as ˆ ρ1, the post-measurement density operator with outcome k as ρˆ[(] 2[k][)] ≡ M[ˆ] k ˆρM[ˆ] k[†][/p][k][, and define][ρ][ˆ][2][≡][�] k[p][k][ ˆ][ρ] 2[(][k][)][.][Note] that our scheme can be applied not only to a quantum measurement, but also to a classical measurement which can be described by setting [ˆρ1, D[ˆ] k] = 0 for all k. Stage 4 (Feedback control ) From t2 to t3, the feedback controller performs a mechanical operation on S depending on outcome k. Let U[ˆ] k be the corresponding unitary operator on the entire system, and ρˆ[(] 3[k][)] ≡ U[ˆ] k ˆρ[(] 2[k][)] Uˆk[†] be the density operator of the entire system at t3 corresponding to outcome k. We define ρˆ3 ≡[�] k[p][k][ ˆ][ρ] 3[(][k][)][.][Note] that the feedback control is characterized by {M[ˆ] k} and {U[ˆ] k}. 

Stage 5 (Equilibration and final state) From t3 to tf , theˆ entire system evolves according to unitary operator Uf which is independent of outcome k. We assume that by tf system S and heat bath Bm will have reached thermodynamic equilibrium at temperatures T and Tm, respectively. We denote as ρˆf the density operator of the final state of the entire system, which is related to the initial state as 

**==> picture [214 x 23] intentionally omitted <==**

ˆ We emphasize that ρf need not equal the rigorous canonical distribution ρˆ[can] f , as given by 

**==> picture [250 x 39] intentionally omitted <==**

where Zf[S][≡][tr][{][exp(][−][β][H][ˆ] f[S][)][}][.][We only assume that the fi-] nal state is in thermodynamic equilibrium from a macroscopic point of view [13]. We will proceed to our main analysis. The difference in the von Neumann entropy between the initial and final states can be bounded from the foregoing analysis as follows: 

**==> picture [251 x 159] intentionally omitted <==**

where S(ˆρ) ≡−tr(ˆρ ln ˆρ) is the von Neumann entropy and H({pk}) ≡−[�] k∈X[p][k][ ln][ p][k][is][the][Shannon][infor-] mation content. Note that in deriving the inequality (6), we used the convexity of the von Neumann entropy, i.e. S([�] k[p][k][ ˆ][ρ] 3[(][k][)][)][≥][�] k[p][k][S][(ˆ][ρ] 3[(][k][)][).][Defining][notations] H˜ (ˆρ1, X) ≡−[�] k[tr(] �Dˆ k ˆρ1�Dˆ k ln �Dˆ k ˆρ1�Dˆ k) and I(ˆρ1 : X) ≡ S(ˆρ1) + H({pk}) − H[˜] (ˆρ1, X), (7) we obtain 

**==> picture [179 x 11] intentionally omitted <==**

We refer to I(ˆρ1 : X) as the QC-mutual information content which describes the information about the measured system that has been obtained by measurement. As shown later, I(ˆρ1 : X) satisfies 

**==> picture [178 x 11] intentionally omitted <==**

ˆ We note that I(ˆρ1 : X) = 0 holds for all state ρ1 if and only if D[ˆ] k is proportional to the identity operator for all k, which means that we cannot obtain any information about the system by this measurement. On the other hand, I(ˆρ1 : X) = H({pk}) holds if and only if D[ˆ] k is the projection operator satisfying [ˆρ1, D[ˆ] k] = 0 for all k, which means that the measurement on state ρˆ1 is classical and error-free. In the case of classical measurement (i.e. [ˆρ1, D[ˆ] k] = 0 for all k), I(ˆρ1 : X) reduces to the classical mutual information content. In fact, we can write I(ˆρ1 : X) in this case as Iρˆ1(ˆρ≡1 :[�] Xi)[q][i] =[|][ψ][i] −[⟩⟨][�][ψ][i] i[|][q][is][i][ ln][the][ q][i][spectrum][−][�] k,i[q][i][p][decomposition][(][k][|][i][) ln][ p][(][k][|][i][),][where][of][the] measured state, and p(k|i) ≡⟨ψi|D[ˆ] k|ψi⟩ can be interpreted as the conditional probability of obtaining outcome k under the condition that the measured state is |ψi⟩. 

3 

ˆ I(ˆρ1 : X) can be written as I(ˆρ1 : X) = χ({ρ[(] 2[k][)][}][)][ −] ∆Smeas, where χ({ρˆ[(] 2[k][)][}][)][≡][S][(ˆ][ρ][2][)][ −][�] k∈X[p][k][S][(ˆ][ρ] 2[(][k][)][)][is] the Holevo χ quantity which sets the Holevo bound [24, 26], and ∆Smeas ≡ S(ˆρ2) − S(ˆρ1) is the difference in the von Neumann entropy between the pre-measurement and post-measurement states. If ∆Smeas = 0 holds, that is, if the measurement process does not disturb the measured system, then I(ˆρ1 : X) reduces to the Holevo χ quantity; in this case, the upper bound of the entropy reduction with discrete quantum feedback control is given by the distinguishability of post-measurement states {ρˆ[(] 2[k][)][}][.] Nielsen et al. have derived inequality S(ˆρi) − S(ˆρf ) ≤ S(ˆρi, E) [7, 24], where S(ˆρi, E) is the entropy exchange which depends on entire process E, including the feedback process. In contrast, our inequality (8) is bounded by I(ˆρ1 : X) which does not depend on the feedback process, but only depends on pre-measurement state ρˆ1 and POVM {D[ˆ] k}, namely, on the information gain by the measurement alone. 

It follows from inequality (8) and Klein’s inequality [27] that 

**==> picture [198 x 11] intentionally omitted <==**

Substituting Eqs. (3) and (5) into inequality (10), we have 

**==> picture [247 x 40] intentionally omitted <==**

where Ei[S] ≡ tr( H[ˆ] i[S][ρ][ˆ][i][),] Ef[S] ≡ tr( H[ˆ] f[S][ρ][f][),] Ei[B][m] ≡ tr( H[ˆ][B][m] ρˆi), and Ef[B][m] ≡ tr( H[ˆ][B][m] ρˆf ). Defining the difference in the internal energy between the initial and final states of system S as ∆U[S] ≡ Ef[S][−][E] i[S][,][the][heat][ex-] change between system S and heat bath Bm as Qm ≡ Ei[B][m] − Ef[B][m] , and the difference in the Helmholtz free energy of system S as ∆F[S] ≡ Ff[S][−][F] i[ S][,][we][obtain] 

**==> picture [234 x 28] intentionally omitted <==**

This is the main result of this Letter. Inequality (12) represents the second law of thermodynamics in the presence of a discrete quantum feedback control, where the effect of the feedback control is described by the last term. For a thermodynamic heat cycle in which I(ˆρ1 : X) = 0, ∆U[S] = 0, and ∆F[S] = 0 hold, inequality (12) reduces to the Clausius inequality 

**==> picture [152 x 28] intentionally omitted <==**

The equality in (12) holds if and only if ρˆ[(] 3[k][)] is independent of measurement outcome k (i.e. the feedback control ˆ ˆ is perfect), and ρf coincides with ρ[can] f . 

We will discuss two important cases for inequality. Let us first consider a situation in which the system undergoes an isothermal process in contact with single heat bath B at temperature T . In this case, (12) reduces to 

**==> picture [190 x 13] intentionally omitted <==**

where the first law of thermodynamics, Wext = �nm=1[Q][m][−][∆][U][ S][,][is][used.][Inequality][(14)][implies][that] we can extract work greater than −∆F[S] from a single heat bath with feedback control, but that we cannot extract work larger than −∆F[S] +kBT I(ˆρ1 : X). If we do not get any information, (14) reduces to (1). On the other hand, in the case of classical and error-free measurement, (14) becomes Wext ≤−∆F[S] + kBT H({pk}). 

The upper bound of inequality (14) can be achieved with the Szilard engine [2] which is described as follows. A molecule is initially in thermal equilibrium in a box in contact with a heat bath at temperature T . We quasi-statically partition the box into two smaller boxes of equal volume, and perform a measurement on the system to find out in which box the molecule is. When the molecule is found in the right one, we remove the left one and move the right one to the left position, which is the feedback control. We then expand the box quasistatically and isothermally so that the final state of the entire system returns to the initial state from a macroscopic point of view. During the entire process, we obtain ln 2 of information and extract kBT ln 2 of work from the system. 

We next consider a heat cycle which contacts two heat baths: BH at temperature TH and BL at TL with TH > TL. We assume that H[ˆ] i[S][=][H][ˆ] f[S][,][∆][U][ S][= 0,][and][∆][F][ S][= 0.] Noting that Wext = QH + QL, we can obtain 

**==> picture [209 x 25] intentionally omitted <==**

Without a feedback control, (15) shows that the upper bound for the efficiency of heat cycles is given by that of the Carnot cycle: Wext/QH ≤ 1 − TL/TH. With feedback control, (15) implies that the upper bound for the efficiency of heat cycles becomes larger than that of the Carnot cycle. The upper bound of (15) can be achieved by performing a Szilard-type operation during the isothermal process of the one-molecule Carnot cycle; if we perform the measurement and feedback with ln 2 of information in the same scheme as the Szilard engine during the isothermal process at temperature TH, the work that can be extracted is given by Wext = (1 − TL/TH)(QH − kBTH ln 2) + kBTH ln 2 = (1 − TL/TH)QH + kBTL ln 2. Note that we can reach the same bound by performing the Szilard-type operation during the isothermal process at temperature TL. We now prove inequality (9). For simplicity of notation, we consider a quantum system denoted as Q in general, instead of S and Bm’s. The measured state 

4 

of system Q is written as ρˆ, and POVM as {D[ˆ] k}k∈X . We introduce auxiliary system R which is spanned by orthonormal basis {|φk⟩}k∈X , and define two states σˆ1 and σˆ2 of Q + R as σˆ1 ≡[�] k √ρˆD[ˆ] k√ρˆ ⊗|φk⟩⟨φk| and σˆ2 ≡[�] k �Dˆ k ˆρ�Dˆ k ⊗|φk⟩⟨φk|. It can be shown ˆ ˆ ˆ ˆ that tr([√] ρD[ˆ] k√ρ) = tr(�Dk ˆρ�Dk) = pk, trR(ˆσ1) = ˆ ˆ ρ, and trQ(ˆσ1) = �k[p][k][|][φ][k][⟩⟨][φ][k][|] ≡ ρR. Defining σˆ1[(][k][)] ≡[√] ρˆD[ˆ] k√ρ/pˆ k, σˆ2[(][k][)] ≡ �Dˆ k ˆρ�Dˆ k/pk and ρˆ[′] ≡ �k[p][k][σ][ˆ] 2[(][k][)][,][we][have] 

**==> picture [250 x 68] intentionally omitted <==**

Since S(L[ˆ][†][ ˆ] L) = S(L[ˆ] L[ˆ][†] ) holds for any linear operator L[ˆ] , we have S(ˆσ2) =[�] k[p][k][S][(ˆ][σ] 2[(][k][)][)][+][H][(][{][p][k][}][)][=] �k[p][k][S][(ˆ][σ] 1[(][k][)][) +][ H][(][{][p][k][}][) =][ S][(ˆ][σ][1][).][Therefore] H˜ (ˆρ, X) = S(ˆσ1) ≤ S(ˆρ) + S(ˆρR) = S(ˆρ) + H({pk}), (17) 

which implies I(ˆρ : X) ≥ 0. The equality in (17) holds for alluct ρˆρˆif⊗andρˆR foronlyallif ρσˆˆ:1 canthatbeis,writtenDˆ k is asproportionaltensor prod-to the identity operator for all k. We will next show that I(ˆρ : X) ≤ H({pk}). We make spectral decompositions ˆ as ρ =[�] i[q][i][|][ψ][i][⟩⟨][ψ][i][|][and][ρ][ˆ][′][=][�] j[r][j][|][ψ] j[′][⟩⟨][ψ] j[′][|][,][where] ˆ rj =[�] i[q][i][d][ij][,][and][define][d][ij][≡][�] k[|⟨][ψ][i][|] �Dk|ψj[′][⟩|][2][,] where[�] i[d][ij][=][1][for][all][j][and][�] j[d][ij][=][1][for][all][i][.] It follows from the convexity of −x ln x that S(ˆρ) = −[�] i[q][i][ ln][ q][i][≤−][�] j[r][j][ ln][ r][j][=][ S][(ˆ][ρ][′][).][Therefore,] 

**==> picture [237 x 82] intentionally omitted <==**

**==> picture [19 x 11] intentionally omitted <==**

It can be shown that the left-hand side is equal to zero for all ρˆ if and only if D[ˆ] k is a projection operator satisfying [ˆρ, D[ˆ] k] = 0 for all k. 

Our results do not contradict the second law of thermodynamics, because there exists an energy cost for information processing of the feedback controller [3, 4, 5]. Our results are independent of the state of the feedback controller, be it in thermodynamic equilibrium or not, because the feedback control is solely characterized by {M[ˆ] k} and {U[ˆ] k}. 

In conclusion, we have extended the second law of thermodynamics to a situation in which a general thermodynamic process is accompanied by discrete quantum feedback control. We have applied our main result (12) to an 

isothermal process and a heat cycle with two heat baths, and respectively obtained inequalities (14) and (15). We have identified the maximum work that can be extracted from a heat bath(s) with feedback control; the maximum work is characterized by the generalized mutual information content between the measured system and the feedback controller. 

This work was supported by a Grant-in-Aid for Scientific Research (Grant No. 17071005) and by a 21st Century COE program at Tokyo Tech, “Nanometer-Scale Quantum Physics”, from the Ministry of Education, Culture, Sports, Science and Technology of Japan. 

- [1] J. C. Maxwell, “Theory of Heat” (Appleton, London, 1871). 

- [2] L. Szilard, Z. Phys. 53, 840 (1929). 

- [3] R. Landauer, IBM J. Res. Develop. 5, 183 (1961). 

- [4] C. H. Bennett, Int. J. Theor. Phys. 21, 905 (1982). 

- [5] B. Piechocinska, Phys. Rev. A 61, 062314 (2000). 

- [6] S. Lloyd, Phys. Rev. A 56, 3374 (1997). 

- [7] M. A. Nielsen, C. M. Caves, B. Schumacher, and H. Barnum, Proc. R. Soc. London A, 454, 277 (1998). 

- [8] G. J. Milburn, Aus. J. Phys. 51, 1 (1998). 

- [9] M. O. Scully, Phys. Rev. Lett. 87, 220601 (2001). 

- [10] J. Oppenheim, M. Horodecki, P. Horodecki, and R. Horodecki, Phys. Rev. Lett. 89, 180402 (2002). 

- [11] T. D. Kieu, Phys. Rev. Lett. 93, 140403 (2004). 

- [12] K. Maruyama, F. Morikoshi, and V. Vedral, Phys. Rev. A 71, 012108 (2005). 

- [13] T. Sagawa and M. Ueda, e-Print: cond-mat/0609085 (2006). 

- [14] “Maxwell’s demon 2: Entropy, Classical and Quantum Information, Computing”, H. S. Leff and A. F. Rex (eds.), (Princeton University Press, New Jersey, 2003). 

- [15] K. Maruyama, F. Nori, and V. Vedral, e-Print: 0707.3400 (2007). 

- [16] H. M. Wiseman and G. J. Milburn, Phys. Rev. Lett. 70, 548 (1993). 

- [17] H. M. Wiseman, Phys. Rev. A 49 2133 (1994). 

- [18] H. M. Wiseman and G. J. Milburn, Phys. Rev. A 49 1350 (1994). 

- [19] A. C. Doherty, S. Habib, K. Jacobs, H. Mabuchi, S. M. Tan, Phys. Rev. A 62 012105 (2000). 

- [20] J. M. Geremia, J. K. Stockton, H. Mabuchi, Science 304, 270 (2004). 

- [21] R. van Handel, J. K. Stockton, and H. Mabuchi, IEEE Trans. Auto. Contr. 50 768 (2005). 

- [22] P. Tombesi and D. Vitali, Phys. Rev. A 51 4913 (1995). 

- [23] T. M. Cover and J. A. Thomas, Elements of Information theory (John Wiley and Sons, 1991). 

- [24] M. A. Nielsen and I. L. Chuang, “Quantum Computation and Quantum Information” (Cambridge University Press, Cambridge, 2000). 

- [25] E. B. Davies and J. T. Lewis, Commun. Math. Phys. 17, 239 (1970). 

- [26] A. S. Holevo, Problemy Peredachi Informatsii 9, 3 (1973). 

- [27] H. Tasaki, e-Print: cond-mat/0009244. 

