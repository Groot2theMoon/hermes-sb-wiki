---
title: "Bayesian inversion methods for acoustical characterisation of poroviscoelastic media"
authors: ["Matti Niskanen"]
year: 2020
source: paper
journal: "PhD Thesis, Le Mans Université — NNT: 2020LEMA1002 — HAL: tel-04145308"
ingested: 2026-05-05
sha256: e370069008f65f0e7d48d2185675b3d369a0dd36e9f3c04bcd6997e0ec487259
conversion: pymupdf4llm
---

**==> picture [242 x 136] intentionally omitted <==**

## **Bayesian inversion methods for acoustical characterisation of poroviscoelastic media** 

Matti Niskanen 

**==> picture [8 x 10] intentionally omitted <==**

## **To cite this version:** 

Matti Niskanen. Bayesian inversion methods for acoustical characterisation of poroviscoelastic media. Mechanics of materials [physics.class-ph]. Le Mans Université; Itä-Suomen yliopisto, 2020. English. ⟨NNT : 2020LEMA1002⟩. ⟨tel-04145308⟩ 

**HAL Id: tel-04145308 https://theses.hal.science/tel-04145308v1** 

Submitted on 29 Jun 2023 

**HAL** is a multi-disciplinary open access archive for the deposit and dissemination of scientific research documents, whether they are published or not. The documents may come from teaching and research institutions in France or abroad, or from public or private research centers. 

L’archive ouverte pluridisciplinaire **HAL** , est destinée au dépôt et à la diffusion de documents scientifiques de niveau recherche, publiés ou non, émanant des établissements d’enseignement et de recherche français ou étrangers, des laboratoires publics ou privés. 

**==> picture [49 x 19] intentionally omitted <==**

HAL Authorization 

## THESE DE DOCTORAT DE 

## LE MANS UNIVERSITE 

COMUE UNIVERSITE BRETAGNE LOIRE 

ECOLE DOCTORALE N° 602 _Sciences pour l'Ingénieur_ Spécialité : _Acoustique_ 

## Par 

## **Matti NISKANEN** 

## **Bayesian inversion methods for acoustical characterisation of poroviscoelastic media** 

Méthodes Bayesienne pour la caractérisation acoustique des matériaux poroviscoelastiques 

**Thèse présentée et soutenue à Kuopio, Finlande, le 17.01.2020 Unité de recherche : LAUM, UMR CNRS 6613 Thèse N° : 2020LEMA1002** 

## **Rapporteurs avant soutenance** : 

J. Stuart BOLTON Professor, Purdue University Daniela CALVETTI Professor, Case Western Reserve University 

## **Composition du Jury :** 

Président : Prénom Nom Fonction et établissement d’exercice (9) _(à préciser après la soutenance)_ Examinateurs :  Nuutti HYVÖNEN Professor, Aalto University Jean-Daniel CHAZOT Maitre de Conférences, Université de Technologie Compiégne Peter GÖRANSSON Professor, KTH Royal Institute of Technology Francine LUPPE Professor, Université du Havre Dir. de thèse : Olivier Dazel Professor, Le Mans Université Co-dir. de thèse : Timo LÄHIVAARA Docent, University of Eastern Finland Co-encadrant : Jean-Philippe GROBY Habilitation à Diriger des Recherces, Le Mans Université Co-encadrant : Aroune DUCLOS Maitre de Conférences, Le Mans Université Co-encadrant : Jari KAIPIO Professor, University of Auckland 

**Titre :** METHODES D'INVERSION BAYESIENNE POUR LA CARACTERISATION ACOUSTIQUE DES MATERIAUX POROVISCOELASTIQUES 

**Mots clés :** Méthodes bayesiennes, Matériaux poroélastiques, Estimation de paramètres 

**Résumé :** Les matériaux poreux naturels et artificiels sont rencontrés et utilisés dans de nombreux domaines de l'ingénierie, de la médecine et de la physique. L'un des défis actuels consiste à caractériser de manière fiable la structure des pores de ces matériaux car elle influe grandement sur leurs propriétés physiques. La caractérisation est généralement effectuée à l’aide de méthodes d’inversion déterministe basées sur la minimisation d’une fonction coût par les moindres carrés. Ces approches fournissent des informations relativement fiables lorsque le nombre de paramètres recherché est faible. Lorsque ce nombre devient important, ces approches montrent une limite qui se traduit par une mauvaise estimation des paramètres de minimisation par les moindres carrés. 

Dans cette thèse, la caractérisation des matériaux poreux est abordée par une approche bayésienne qui permet de pouvoir considérer naturellement et quantitativement les incertitudes sur les paramètres recherchées. Dans un premier temps, cette approche est appliquée au cas de matériaux poreux à squelette rigide et saturés d’air. L’application au cas de matériaux poreux saturés par un fluide lourd est abordée dans une deuxième partie. Les méthodes ont été testées sur des mesures, effectuées dans le cadre de ce travail de thèse, en particulier au tube à impédance ou dans une cuve à eau. Les méthodes et résultats développés dans ce travail mettent en évidence que les techniques d’inversion bayesiennes permettent de caractériser de manière fiable les matériaux poro-visco-élastiques 

## **Title :** BAYESIAN INVERSION METHODS FOR ACOUSTICAL CHARACTERISATION OF POROVISCOELASTIC MEDIA 

**Keywords :** Bayesian methods, Poroelastic materials, Parameter estimation 

**Abstract :** Natural and artificial porous materials are encountered and used in many fields of engineering, medicine and physics. One of the current challenges is to reliably characterize the pore structure of these materials as it greatly affects their physical properties. Characterization is usually performed using deterministic inversion methods that are based on minimizing a cost function in the least squares sense. These approaches can provide reliable parameter estimates when the number of parameters is small, but with an increasing number of parameters the least squares estimates and, in particular, error estimates often become unreliable. 

In this thesis, we study the characterization of porous materials in the Bayesian framework for inverse problems, where uncertainties can be treated and quantified naturally. First, we apply this approach to the case of air-saturated porous materials whose frame can be modelled as rigid. The case of porous materials saturated by a heavy fluid, where the frame is modelled as elastic, is then discussed in a second part. We tested the methods with real measurements carried out as part of this thesis work, either in an impedance tube or in a water tank. The results indicate that the Bayesian inversion techniques developed in this work can provide robust estimates for the parameters and the parameter uncertainties of poroviscoelastic materials. 

## PUBLICATIONS OF THE UNIVERSITY OF EASTERN FINLAND DISSERTATIONS IN FORESTRY AND NATURAL SCIENCES 

## N:o 369 

## _**Matti Niskanen**_ 

## **BAYESIAN INVERSION METHODS FOR ACOUSTICAL CHARACTERISATION OF POROVISCOELASTIC MEDIA** 

## ACADEMIC DISSERTATION 

To be presented by the permission of the Faculty of Science and Forestry for public examination in the _SN201_ in _Snellmania_ Building at the University of Eastern Finland, Kuopio, on _January 17th_ , 2020, at 12 o’clock. 

University of Eastern Finland Department of Applied Physics Kuopio 2020 

Grano Oy Jyväskylä, 2020 Editors: Pertti Pasanen, Jukka Tuomela, Matti Tedre, and Raine Kortet 

Distribution: 

University of Eastern Finland Library / Sales of publications `julkaisumyynti@uef.fi http://www.uef.fi/kirjasto` 

ISBN: 978-952-61-3304-1 (print) ISSNL: 1798-5668 ISSN: 1798-5668 ISBN: 978-952-61-3305-8 (pdf) ISSNL: 1798-5668 ISSN: 1798-5676 

ii 

Author’s address: University of Eastern Finland Department of Applied Physics P.O.Box 1627 70211 Kuopio Finland email: matti.niskanen@uef.fi Supervisors: Docent Timo Lähivaara University of Eastern Finland Department of Applied Physics P.O.Box 1627 70211 Kuopio Finland email: timo.lahivaara@uef.fi Professor Olivier Dazel Le Mans Université Laboratoire d’Acoustique de l’Université du Mans LAUM - UMR CNRS 6613 Avenue Olivier Messiaen 72085 Le Mans cedex 9 France email: olivier.dazel@univ-lemans.fr M. Jean-Philippe Groby, CNRS Researcher, Habilitation à Diriger des Recherches Le Mans Université Laboratoire d’Acoustique de l’Université du Mans LAUM - UMR CNRS 6613 Avenue Olivier Messiaen 72085 Le Mans cedex 9 France email: jean-philippe.groby@univ-lemans.fr M. Aroune Duclos, Maître de Conférences Le Mans Université Laboratoire d’Acoustique de l’Université du Mans LAUM - UMR CNRS 6613 Avenue Olivier Messiaen 72085 Le Mans cedex 9 France email: aroune.duclos@univ-lemans.fr Professor Jari Kaipio University of Auckland Department of Applied Mathematics 38 Princes Street Auckland CBD New Zealand email: j.kaipio@auckland.ac.nz 

iii 

Reviewers: Professor Daniela Calvetti Case Western Reserve University Department of Mathematics, Applied Mathematics and Statistics 10900 Euclid Avenue Cleveland, OH 44106 United States email: daniela.calvetti@case.edu Professor Stuart Bolton Purdue University School of Mechanical Engineering 585 Purdue Mall West Lafayette, IN 47907 United States email: bolton@purdue.edu Opponents: Professor Nuutti Hyvönen Aalto University Department of Mathematics and Systems Analysis P.O.Box 11000 00076 AALTO Finland email: nuutti.hyvonen@aalto.fi M. Jean-Daniel Chazot, Maître de Conférences Université de Technologie Compiégne Laboratoire Roberval UMR CNRS 7337 CS 60319 60203 Compiègne cedex France email: jean-daniel.chazot@utc.fr 

iv 

## Matti Niskanen 

Bayesian inversion methods for acoustical characterisation of poroviscoelastic media Kuopio: University of Eastern Finland, 2020 Publications of the University of Eastern Finland Dissertations in Forestry and Natural Sciences; 369 

## **ABSTRACT** 

Natural and artificially made porous materials are encountered and used in numerous fields of engineering, medicine, and physics. One of the challenges is to be able to reliably characterise the pore structure of these materials, as it has a great influence on their physical properties. Characterising porous materials using acoustical methods has become a common procedure in many laboratories, in part because the methods are non-destructive and can be performed on relatively cheap instruments. The characterisation is commonly carried out using deterministic inversion methods, where a cost functional of model residuals is minimised, typically with a least squares (LS) approach. These approaches can provide reliable parameter estimates when the number of parameters is small, but with an increasing number of parameters the LS parameter estimates and, in particular, error estimates often become unreliable. 

In this thesis, we study the characterisation of porous materials in the Bayesian framework for inverse problems, where uncertainties can be treated and quantified naturally. We first examine air-saturated porous materials whose frame can be modelled as rigid, which has been often the assumption in inverse characterisation methods. Next, we focus on water-saturated materials and the more general case where the frame is elastic. A key contribution of this thesis is to develop inversion methods with which we can reliably characterise these poroviscoelastic materials. 

Each proposed method is tested with real measurements, carried out either in an impedance tube using audible frequencies or in a water tank with ultrasound. To compute the Bayesian parameter estimates and assess the uncertainties related to them, we employ Markov chain Monte Carlo algorithms. The results of this thesis indicate that the Bayesian approach for porous material characterisation can provide robust estimates for the parameters and their uncertainties. 

v 

## **RESUM[´] E[´]** 

Les matériaux poreux naturels et artificiels sont rencontrés et utilisés dans de nombreux domaines de l’ingénierie, de la médecine et de la physique. L’un des défis actuel consiste à caractériser de manière fiable la structure des pores de ces matériaux car elle influe grandement sur leurs propriétés physiques. Dans ce contexte, la caractérisation des matériaux poreux à l’aide de méthodes acoustiques est devenue une procédure courante dans de nombreux laboratoires. Cela se justifie en particulier en raison du caractère non destructif de ces méthodes associé à un faible coût de l’équipement nécessaire. La caractérisation est généralement effectuée à l’aide de méthodes d’inversion déterministe basées sur la minimisation d’une fonction coût par les moindres carrés. Ces approches fournissent des informations relativement fiables lorsque le nombre de paramètres recherché est faible. Lorsque ce nombre devient important, ces approches montrent une limite qui se traduit par une mauvaise estimation des paramètres de minimisation par les moindres carrés. 

Dans cette thèse, la caractérisation des matériaux poreux est abordée par une approche bayésienne du problème inverse. Cette approche présente l’intérêt de pouvoir considérer quantitativement les incertitudes sur les paramètres recherchées. Dans les approches bayésiennes proposées, l’estimation des paramètres et l’évaluation des incertitudes sont obtenues en utilisant des algorithmes de Monte-Carlo avec des chaînes de Markov. Dans un premier temps, cette approche est appliquée au cas de matériaux poreux saturés d’air. Dans ce cas, la modélisation est réalisée en supposant le squelette comme étant rigide. Des expériences sont ensuite réalisées dans un tube d’impédance à des fréquences audibles. Les mesures ainsi réalisées permettent de tester cette première application. L’application au cas de matériaux poreux saturés par un fluide lourd est abordée dans une deuxième partie où la modélisation permet de considérer l’élasticité du squelette et son effet sur la propagation. De nouvelles mesures sont réalisées dans une cuve à eau à des fréquences ultrasonores afin de tester cette deuxième application de l’approche bayésienne. Le développement de méthodes d’inversion permettant de caractériser de manière fiable ce type de matériaux poro-visco-élastiques constitue une contribution majeure de ces travaux de thèses. Les résultats de cette thèse indiquent que l’approche bayésienne pour la caractérisation des matériaux poreux fournie des estimations robustes pour les paramètres des modèles tout en y associant leur incertitude. 

_**Universal Decimal Classification:** 519.217.2, 534.6, 539.217, 539.3, 620.179.16_ _**INSCPEC Theasaurus:** porous materials; porosity; viscoelasticity; acoustic analysis; acoustic measurement; ultrasonic measurement; acoustic impedance; nondestructive testing; inverse problems; parameter estimation; Bayes methods; Markov processes; Monte Carlo methods_ 

_**Yleinen suomalainen ontologia:** materiaalit; materiaalitutkimus; huokoisuus; joustavuus; kimmoisuus; akustinen analyysi; ultraäänitutkimus; rikkomaton aineenkoetus; inversioongelmat; parametrit; estimointi; bayesilainen menetelmä; Markovin ketjut; Monte Carlo -menetelmät_ 

vi 

## **ACKNOWLEDGEMENTS** 

This thesis was carried out as a jointly supervised thesis between the Department of Applied Physics in the University of Eastern Finland and the Laboratoire d’Acoustique de l’Université du Mans in the Le Mans University during the years 2015-2019. The study received financial support from the Academy of Finland, Jenny and Antti Wihuri Foundation, Saastamoinen Foundation, the RFI Le Mans Acoustique, and the DENORMS COST action. 

I would first like to thank my supervisor in Finland, Docent Timo Lähivaara, for your guidance, encouragement, and help over these years. I would also like to thank Docent Tomi Huttunen for guiding me in the beginning of the project. It has been a privilege to work with both of you. In addition, I am grateful for the patience and understanding you showed as my plans were changing and I went on a rather long research visit to New Zealand. 

I wish to express my deepest gratitude to my supervisors in France, Professor Olivier Dazel, HDR Jean-Philippe Groby, and MCF Aroune Duclos. You made me feel very welcome to Le Mans, and your enthusiasm towards acoustics and porous materials provided an exciting atmosphere to work in. During my 1.5 years in Le Mans I learned a lot about acoustics, but more importantly about the French way of life, and I will never forget the raclette nights we shared together. 

I would also like to express my sincerest thanks to my New Zealand supervisor Professor Jari Kaipio, who welcomed me into his group in the University of Auckland when life was taking me to the other side of the world. My research visit there turned into almost two years, during which you were always there to offer me help, guidance, encouragement, and discouragement, in the correct proportions, when it was needed. It truly was an honour to work with you and your group. 

In addition, I would like to thank the official pre-examiners Professor Daniela Calvetti and Professor J. Stuart Bolton for taking the time to review my thesis and providing excellent feedback. 

During these four years I have had the pleasure to live and work in three different countries. I have met lots of amazing people, but moving around has meant I have had to say a lot of goodbyes as well. First I would like to thank my good friends Elie and Valentin for always being willing to act as my French-English translators, even when we had just barely met. When I moved to France I did not speak a word of French, but you helped me navigate through the French administration and most importantly, showed me which ones of the hundreds of different cheeses were worth trying (all of them). Thanks for all the gigs and all the evenings at Le Lézard. Also thanks to Charlotte, Mathieu, Quentin, Nico, Dimitri, Weichun, and many others for making my stay in Le Mans unforgettable. I want to also thank my Kuopio friends Antti, Timo, Petteri, Arttu, Johanna, Simo, and Pekka, for the friendship, housing assistance, and discgolf company. Further, I want to thank all my Auckland office mates, Ru, Owen, Pascal, Hwan, Susana, Vincent, Scarlett, and Annabelle, for the laughs and evenings we spent together. You were always down (up?) for some bananagrams to liven up the work day. 

Of course, the longest lasting support for my scientific endeavours comes from my family. I owe a huge thanks to my parents Sirpa and Jorma, and my brothers Timo and Tuomas for always encouraging and supporting me. 

Finally, I would like to thank my partner Lily. You have travelled across the 

vii 

world with me and have shown endless love and support during these years, for which I cannot thank you enough. 

Kuopio, January 17th, 2020 

_Matti Niskanen_ 

viii 

## **LIST OF PUBLICATIONS** 

This thesis consists of the present review of the author’s work in the field of acoustics and the following selection of the author’s publications: 

- **I** M. Niskanen, J.-P. Groby, A. Duclos, O. Dazel, J. Le Roux, N. Poulain, T. Huttunen, and T. Lähivaara, “Deterministic and statistical characterization of rigid frame porous materials from impedance tube measurements,” _J. Acoust. Soc. Am._ , vol. 142, no. 4, 2407–2418 (2017). 

- **II** M. Niskanen, O. Dazel, J.-P. Groby, A. Duclos, and T. Lähivaara, “Characterising poroelastic materials in the ultrasonic range - A Bayesian approach,” _J. Sound Vib._ , vol. 456, 30–48 (2019). 

- **III** M. Niskanen, A. Duclos, O. Dazel, J.-P. Groby, J. Kaipio, and T. Lähivaara, “Estimating the material parameters of an inhomogeneous poroelastic plate from ultrasonic measurements in water,” _J. Acoust. Soc. Am._ , vol. 146, no. 4, 2596–2607 (2019). 

Throughout the overview, these papers will be referred to by Roman numerals. 

## **AUTHOR’S CONTRIBUTION** 

The publications selected in this dissertation are original research papers on statistical characterisation of porous materials using acoustical methods. All publications are results of joint work with the author of this thesis, the supervisors, and the co-authors. The author of this thesis has been the principal writer and the corresponding author in all of the publications but the help, guidance, and contribution of the thesis supervisors has been significant. The author has also been responsible for conducting the experiments, developing the codes for the forward models and the inversion, and producing the numerical results. 

ix 

## TABLE OF CONTENTS 

|**1**|**Introduction**|**Introduction**|**1**|
|---|---|---|---|
|**2**|**Wave propagation in porous media**||**5**|
||2.1|Rigid frame porous media.................................................................|6|
|||2.1.1<br>The Johnson-Champoux-Allard-Lafarge model........................|7|
||2.2|Poroelastic media.............................................................................|10|
|||2.2.1<br>The Biot model.....................................................................|11|
|||2.2.2<br>Losses in water-saturated materials........................................|12|
||2.3|Models to compute the acoustic response of a multilayer system.......|14|
|||2.3.1<br>Waves in layered media..........................................................|14|
|||2.3.2<br>The transfer matrix method...................................................|16|
|||2.3.3<br>The global matrix method.....................................................|17|
|**3**|**Bayesian methods for parameter estimation**||**19**|
||3.1|Parameter estimation in the Bayesian framework ..............................|19|
|||3.1.1<br>Likelihood.............................................................................|21|
|||3.1.2<br>Prior models..........................................................................|22|
||3.2|Markov chain Monte Carlo...............................................................|22|
|||3.2.1<br>Metropolis-Hastings update...................................................|23|
|||3.2.2<br>Efciency measures................................................................|24|
|||3.2.3<br>Stopping criteria and diagnosing convergence.........................|25|
||3.3|MCMC Samplers..............................................................................|28|
|||3.3.1<br>Overview...............................................................................|28|
|||3.3.2<br>Adaptive algorithms...............................................................|29|
|||3.3.3<br>Parallel tempering..................................................................|30|
|**4**|**Review of thesis results**||**33**|
||4.1|Publication **I**: Characterisation of rigid frame porous materials from||
|||impedance tube measurements.........................................................|33|
|||4.1.1<br>Measurement setup...............................................................|33|
|||4.1.2<br>Inversion ...............................................................................|34|
|||4.1.3<br>Results..................................................................................|35|
||4.2|Publication **II**: Computational methods for estimating the material||
|||parameters of poroelastic media.......................................................|37|
|||4.2.1<br>The simulation model............................................................|37|
|||4.2.2<br>Inversion ...............................................................................|38|
|||4.2.3<br>Results..................................................................................|39|
||4.3|Publication **III**: Estimating the material parameters of poroelastic||
|||objects from ultrasound measurements in water................................|42|
|||4.3.1<br>The measurement setup.........................................................|42|
|||4.3.2<br>Inversion ...............................................................................|43|
|||4.3.3<br>Results..................................................................................|43|



xi 

**5 Conclusion** 

**49 53** 

## **BIBLIOGRAPHY** 

xii 

**1 Introduction** 

Nearly all materials are porous to some degree. In some, the porosity occurs naturally, others are manufactured to be porous, and in fact it is rather difficult to find or manufacture a genuinely non-porous solid [1]. In this thesis, we examine materials whose pores form a fluid-filled interconnected network inside a solid frame. Such materials commonly around us include the human body with its bones and tissues, plants, rocks, soils, concrete, plaster, fabrics, wools, and so on [2]. It is well known that the structure of the pores greatly affects the materials’ physical properties, such as density, thermal conductivity, and strength. In addition, the connected pore structure allows fluid to flow through the materials, which gives them special properties and enables countless applications. These include insulation and dissipation of thermal energy, absorption of acoustic and mechanical energy, filtration, diffusion, and mixing of flow, which is why porous materials find uses in fields such as civil engineering, geophysical exploration, food industry, and chemical industry to name a few [2]. It is therefore essential that we have reliable methods to characterise the pore structure of materials. 

Due to the practical importance of porous material characterisation, numerous methods have been proposed for it [1, 3–5]. These include measurements of fluid flow, gas adsorption, and X-ray and neutron scattering. One class of methods in particular, based on acoustic probing of the medium, has received a lot of interest in the recent years. Acoustic characterisation methods are based on the fact that pore parameters have a strong influence on the response of porous media to sound waves [6,7]. In reverse, the acoustic response carries lots of information on the pore structure, which we can attempt to extract using inversion methods. Acoustical characterisation methods are non-destructive, relatively low-cost, and have the potential to provide information on a multitude of pore structure parameters from a single measurement. 

The first step in acoustical characterisation is to solve the forward problem, that is, develop methods to model the acoustic response of porous materials that we can then compare to measurements. Mathematically, we can represent porous media to consist of two phases, a compressible fluid and an elastic solid phase, which both contribute to wave propagation as a coupled fluid-solid system. We call these kind of materials _poroelastic_ . A generally accepted theory to model the deformations in this bi-phasic media is the Biot theory [8–12], which was published by M. A. Biot in 1956 [8, 9]. The Biot theory predicts the existence of three distinct waves in an isotropic poroelastic medium, all of which have been experimentally observed [13,14]. In some cases, such as with many air-saturated porous media, the coupling between the solid and the fluid phases is weak. In such a case, an incident acoustic wave may not transfer enough energy to the solid phase to cause it to vibrate, and we can model the porous medium as having a rigid frame. Only one type of wave, the longitudinal acoustic wave, can propagate in this medium. We can then simplify our models by replacing the poroelastic material with an equivalent fluid model whose properties are defined by the saturating fluid and the solid matrix. 

The inverse problem in acoustical characterisation has been traditionally carried 

1 

out in the deterministic sense. The most straightforward approach is to minimise a cost functional, such as the least squares functional, of the model residuals. Studies that use a least squares minimisation approach to estimate the pore structure parameters include [15–27]. Approaches where the parameters are connected to the data using an analytical inverse mapping have also been proposed [28–31]. When the number of estimated parameters is small, deterministic approaches can provide reliable parameter estimates for porous media, as shown by the review articles [3,5]. However, with a growing number of estimated parameters, the parameter estimates and especially possible uncertainty estimates often become unreliable. 

Recent studies [32,33] have shown that the reproducibility of deterministic characterisation methods between different acoustic laboratories is quite poor, with the exception of a few parameters. Some of the poor reproducibility can be explained by inhomogeneities in the measured samples and by a lack of standardised measurement and calibration procedures. On the other hand, acoustic models for porous media include nonlinear interactions between the model parameters, the pore parameters may be strongly correlated with each other, and the cost functions often exhibit several minima. These factors present considerable difficulties for minimising the cost function, and the point estimate provided by the optimisation may not summarise the complex parameter space structures very well. In addition, there are underlying uncertainties associated with the measurements that can be difficult to model, and are therefore often neglected. In the context of inverse problems, however, neglecting the modelling errors may yield meaningless estimates [34–36]. 

Another approach to the inverse problem is to solve it in the Bayesian framework [34, 37–39], which has several pragmatic advantages compared to the deterministic solutions. For example, it allows us to be explicit in defining prior information, and provides a way to directly quantify uncertainty. In addition, the Bayesian approach can naturally handle inaccuracies between the models and actual experiments. In the Bayesian framework, all unknowns are modelled as random variables, and the inverse problem takes the form of statistical inference. The solution of the inverse problem is then the _posterior probability density_ (ppd), which combines our knowledge on the measurement and model uncertainties, possible prior information, and the measurement data. Once the posterior model has been derived, we can compute point and interval estimates to summarise the information in an easily understandable form. The _maximum a posteriori_ (MAP) and _conditional mean_ (CM) estimates, defined in Chapter 3, are examples of Bayesian point estimates. The MAP estimate can be solved with an optimisation approach, but finding the CM estimate, as well as computing the interval estimates, is an integration problem. In the recent years, Bayesian methods have started to gain popularity for characterising porous materials, especially ones that can be modelled as an equivalent fluid [40–44], but methods for poroelastic inversion have also been proposed [44,45]. 

In this thesis, the aim is to develop robust acoustical characterisation methods for both rigid and elastic frame porous materials, using measurements done with typical existing instruments. In particular, we are interested in quantifying the uncertainty in the parameter estimates so that the repeatability and reproducibility of the characterisation methods could be improved. To this end, we adopt the Bayesian framework for inverse problems. To explore the true posterior density, we then use Markov chain Monte Carlo (MCMC) [46, 47] methods, which are often the only practical way to draw samples from a high-dimensional and possibly multi-modal posterior. However, MCMC methods can be computationally very demanding, because often to obtain a representative sample of the posterior the forward problem 

2 

needs to be solved hundreds of thousands of times, possibly even more. This is why we pay close attention to the speed of the forward models used, and use fast matrix methods to solve the Biot equations. In addition, we have been able to take advantage of the numerous advances to MCMC in the recent years [48–51], which have made it possible to construct efficient samplers for poroelastic wave propagation problems. 

The results of this thesis have been published in **I** – **III** . 

In publication **I** , we examine rigid frame porous media that can be measured in a standard transmission impedance tube [52]. These materials include acoustic foams, automotive felt materials, and different kinds of wools. We solve the inverse problem in the Bayesian framework, but in addition compare the results to inversion from a least-squares minimisation approach. We make the comparison to highlight the differences between the traditional way of solving the characterisation inverse problem, and the Bayesian approach. 

In publications **II** and **III** , we focus on porous materials with an elastic frame. First, publication **II** provides a numerical study into the feasibility of estimating basically all Biot input parameters, just from acoustic reflection and transmission data in the ultrasonic frequencies. We consider some stability issues of the forward model, and then construct an efficient MCMC sampler to explore the posterior. We use methods such as Adaptive Metropolis (AM) [48] and Parallel Tempering (PT) for the MCMC sampler and find that it can explore the peaky posterior density reasonably efficiently. 

Publication **III** is a study into the characterisation of a poroelastic ceramic material, submerged in water so that we can excite the solid waves. We examine numerous measurements from several parts of a object made from the porous ceramic, and carry out the inversion separately in each measurement spot. This highlights the heterogeneity of the sample, and provides a way of quantifying it. 

The introduction to this thesis is organised as follows. Chapter 2 presents briefly the basics of acoustic wave propagation in rigid and elastic frame porous media, and matrix methods for their numerical simulation. Chapter 3 introduces the Bayesian framework for inverse problems, along with the sampling methods used in this thesis. Chapter 4 reviews and studies the results of the publications **I** – **III** , and a conclusion is given in Chapter 5. 

3 

**2 Wave propagation in porous media** 

In this chapter, we will review the basics of sound propagation in rigid and elastic frame porous media. Rigid frame porous media were considered in publication **I** , and elastic frame materials in publications **II** and **III** . We first consider mathematical models that describe the acoustically relevant properties of porous media, and define the parameters that are related to the pore properties. We also state the acoustic and poroelastic wave equations. At the end of the chapter we discuss the construction of the forward models and their computational implementation, and especially some fast matrix methods for solving the wave equations. 

Porous materials consist of a continuous solid skeleton that forms the frame of the material and of a fluid phase that fills the pores in the solid, such as in the porous rock of Figure 2.1. For most applications, we are interested in materials whose pores form an interconnected network, which allows acoustic propagation within the porous frame. We call these kind of materials _open-cell_ , as opposed to _closed-cell_ porous materials where each pore is isolated from their neighbour. In addition, we can define a _saturated_ porous medium, where all the pores are filled with the same fluid. This simplifies their modelling considerably. An example of an _unsaturated_ porous medium would be a porous rock submerged in water where air is trapped inside some of the pores. In this thesis, we will consider saturated open-cell porous media, which we can model as a superimposition of two continua (the frame and the fluid) [53]. 

**==> picture [279 x 199] intentionally omitted <==**

**Figure 2.1:** An example of a naturally occurring porous material, scoria, which is volcanic rock solidified from foaming lava. Scoria typically has a high porosity and pore connectivity [54]. The rock is from the Maungauika volcano in Auckland, New Zealand. 

5 

Modelling attenuation mechanisms is of prime importance when modelling wave propagation in porous media. Acoustic waves in porous media are mainly attenuated through viscous and thermal losses that result from the interaction between the solid frame and the fluid. In the free field and at short distances, attenuation can be usually neglected without introducing large errors. However, when waves are propagating in small ducts (which porous media closely resemble), the effects of viscosity and heat conduction become important. These effects were understood already in 1868, when Kirchhoff published a general theory for sound propagation in tubes with an arbitrary cross section [55]. In his work, Kirchhoff considered the viscous and thermal effects together in the same equations [6]. In the case of cylindrical tubes, Zwikker and Kosten [56] worked out simpler expressions, where the viscous and thermal losses are treated separately. Stinson [57] later generalised these equations for an arbitrary cross section, and the use of separate expressions for viscous and thermal losses for sound propagation in ducts is now commonly used. 

Analytical description of sound propagation in porous media is, in general, impossible due to the complex geometry of their microstructure. Therefore, we have to model porous media in the macroscopic sense, relying on homogenised representations of the material. Such simplifications are possible when the long-wavelength condition is met, that is, acoustic wavelengths are much larger than the homogenised representative volume of the material, which in turn is much larger than the average pore size [6]. 

## **2.1 RIGID FRAME POROUS MEDIA** 

Often in cases where a porous material is saturated with air and excited by an airborne wave, we can assume the solid frame is motionless. In general, the frame can be assumed motionless when the solid-fluid coupling is weak, and little energy is transferred to the solid. The strength of this coupling is a function of frequency, and it gets weaker as the frequency increases [56]. A porous medium with a motionless solid phase can be modelled as a fluid whose apparent properties are a function of the solid properties [6]. We call such a medium an equivalent fluid. 

Time-harmonic wave propagation in an isotropic equivalent fluid medium can be described by the Helmholtz-like equation 

**==> picture [226 x 19] intentionally omitted <==**

where _∇_[2] is the Laplace operator, _p_ denotes the acoustic pressure, and _k_[˜] eq is the equivalent wave number in the fluid. We adopt the exp( _−_ i _ωt_ ) time convention, where i = _[√] −_ 1, _ω_ = 2 _π f_ is the angular frequency, and _f_ is the frequency. The wave number can be defined with the equivalent density _ρ_ ˜eq and the equivalent adiabatic bulk modulus _K_[˜] eq as 

**==> picture [219 x 31] intentionally omitted <==**

The tilde over the quantities denotes that they are complex-valued (due to attenuation) and frequency-dependent (because the governing physics is different at low and high frequencies). The acoustic behaviour of a fluid medium is completely described by _ρ_ ˜eq and _K_[˜] eq, and from these parameters we can derive interesting 

6 

properties such as the fluid’s equivalent speed of sound, _c_ ˜eq, and the equivalent characteristic impedance _Z_[˜] eq as 

**==> picture [270 x 31] intentionally omitted <==**

Any two of the above parameters can be used to describe the medium’s acoustic behaviour. 

Several models exist to express the acoustic properties _ρ_ ˜eq and _K_[˜] eq of an equivalent fluid. The simplest of these are empirical. They depend on very few macroscopic parameters, and are derived based on fitting suitable simple equations to a set of measurements. One of the first and the most well-known empirical models is the Delany-Bazley (D-B) model [58], where a material’s characteristic impedance and wave number are stated as a function of only one parameter, the flow resistivity. Some limitations of the D-B model are that it is only suitable for fibrous porous materials (such as various glass fibres), and that it is valid only for a restricted frequency range. In the low frequencies, the model returns non-causal solutions [59] that violate the Kramers-Krönig relations [60]. Since their introduction, several improvements to the D-B model have been made, which address the causality requirement but also widen the frequency range and types of applicable materials [59,61–65]. 

Empirical models are simple, but clearly not well suited for use in material characterisation due to the fact that they contain very few physical material parameters, and do not model the materials with enough accuracy to do inversion. For this reason, we will now consider semi-phenomenological models that are at least partly based on the physics of sound propagation in porous media. Again, there are many models available, such as the Wilson model [66] where the thermal and viscous effects are modelled as relaxation processes, or the pore size distribution model [67,68] which assumes that the pore sizes are log-normally distributed. In this thesis, we will use the Johnson-Champoux-Allard-Lafarge (JCAL) model, which is currently perhaps the most commonly used model and has been found to represent porous media accurately in many studies. 

## **2.1.1 The Johnson-Champoux-Allard-Lafarge model** 

The JCAL model [69–71] is a popular semi-phenomenological model that describes the equivalent density and bulk modulus of rigid frame porous media based on six physical parameters, defined in the following, that are independent of the saturating fluid. The JCAL model is directly used as the forward model in publication **I** , since our measurement procedure provides the materials’ densities and bulk moduli. The model is based on considering the asymptotic behaviour of the density and bulk modulus at low and high frequencies, and joining the asymptotes together with simple expressions. In the JCAL model, viscous losses are treated in the expression of the density and thermal losses are treated in the expression of bulk modulus. Let us first define the physical parameters, while keeping in mind that they are defined generally for any porous media, and are not dependent on the JCAL, or any other model, that uses them. 

**Open porosity** _φ_ **.** Porosity is one of the most important parameters describing a porous medium. It is defined as the volume of the fluid _Vf_ divided by the total volume of the material _Vt_ : 

7 

**==> picture [204 x 25] intentionally omitted <==**

However, for most applications we are mainly interested in _open porosity_ , the fraction of pores that are accessible from the outside. Incidently, this is also the pore space that acoustic methods are sensitive to, and so we use _φ_ to denote the open porosity. Typical values for sound absorbing materials are 0.95 _≤ φ ≤_ 0.99, but in general _φ ∈_ [0, 1]. 

**Static viscous permeability** _k_ 0 **.** Alongside porosity, viscous permeability _k_ ( _ω_ ) is the other main parameter describing porous media, and the most important parameter for describing sound absorbing materials. Viscous permeability describes the ease at which fluid can flow through a porous material, and is defined by Darcy’s law: 

**==> picture [223 x 25] intentionally omitted <==**

where _∇p_ is the pressure gradient, _⟨v⟩_ is the average fluid velocity in a porous medium, and _η_ is the dynamic viscosity of the saturating fluid. The static limit _k_ 0 = _ω_ lim _→_ 0 _[k]_[(] _[ω]_[)][depends][only][on][the][structure][of][the][porous][frame.][Flow][resistivity] _[σ]_[is] the reciprocal of permeability _σ_ = _η_ / _k_ 0. The values of permeability can span several orders of magnitude, from practically impermeable 10 _[−]_[20] m[2] to highly permeable 10 _[−]_[8] m[2] [72]. 

**Geometrical tortuosity** _α_ ∞ **.** When the pore network is not perfectly straight and parallel to the direction of wave propagation, the waves travel along longer paths. This increase in the path length results in an apparent increase of the density of the material compared to the density of the saturating fluid _ρ f_ . At high frequencies the 1 viscous skin depth _δ_ = (2 _η_ / _ρ f ω_ ) 2 becomes tiny compared to the pore size, and the fluid behaves approximately as an ideal, non-viscous, fluid [69]. In this limit, we can define the geometrical tortuosity _α_ ∞, which is a real-valued parameter that relates the effective density to the density of the fluid as _ρe_ = _α_ ∞ _ρ f_ . Theoretically, tortuosity is also connected to _k_ ( _ω_ ) [69], and in fact _k_ 0 and _α_ ∞ can be seen as parameters describing the effective density of the material at low and high frequencies, respectively. 

Geometrical tortuosity can be defined with the help of fluid velocities. Let us denote the microscopic fluid velocity of nonviscous fluid flow at **r** by _vm_ ( **r** ). Tortuosity 

**==> picture [238 x 62] intentionally omitted <==**

where the integrals are carried out over the homogenized representative volume _V_ . We can also define tortuosity with a simpler concept, related to the path lengths. Let _L_ be the length of a straight path through a porous material, and _L[′]_ the actual tortuous path (see Figure 2.2). Then 

8 

**==> picture [161 x 103] intentionally omitted <==**

**==> picture [155 x 97] intentionally omitted <==**

**Figure 2.2:** Left: Illustration of a tortuous path. Right: The open pore space regions have the greatest influence on Λ _[′]_ , and the constricted regions of the pore space have the greatest influence on Λ. 

**==> picture [217 x 28] intentionally omitted <==**

By definition, _α_ ∞ _≥_ 1, and typical values of tortuosity range between 1 and 3. 

**Characteristic viscous length** Λ **.** In many applications, we are interested in the ratio of pore volume to surface area. In the JCAL model, the characteristic viscous and thermal lengths are pore shape factors and provide an indication of this ratio. The characteristic viscous length Λ describes viscous effects at middle and high frequencies, and is defined as [69] 

**==> picture [235 x 57] intentionally omitted <==**

where the integrals are carried over the pore space, _vi_ ( **r** ) is the fluid velocity in the pore, and _vi_ ( **r** _w_ ) is the fluid velocity on the pore wall. The definition of Λ is such that constrictions in the pore network (see Figure 2.2), where the velocities are greater, contribute to the integral the most. It can therefore be thought of as an indication of the size of the constrictions. Typically, the viscous characteristic length ranges from 10 _µ_ m to 500 _µ_ m. 

**Characteristic thermal length** Λ _[′]_ **.** Thermal effects at high frequencies are described by the characteristic thermal length Λ _[′]_ . It is defined in a similar way to Λ, except that it does not consider fluid velocity in the pores, but only the ratio of average pore volume to average pore surface area [70]: 

**==> picture [218 x 56] intentionally omitted <==**

As the exchange area between the solid and the fluid is greater in the open regions (see Figure 2.2), these areas contribute to Eq. (2.9) the most. Therefore, thermal 

9 

characteristic length can be seen as an indication on the size of the open pore areas. By definition, Λ _[′] ≥_ Λ, and typically for fibrous sound absorbing materials Λ _[′]_ = 2Λ [6]. 

**Static thermal permeability** _k[′]_ 0 **[.]** Analogously to the dynamic viscous permeability, the dynamic thermal permeability _k[′]_ ( _ω_ ) relates the pressure gradient to the macroscopic excess temperature _⟨τ⟩_ as [71] 

**==> picture [224 x 25] intentionally omitted <==**

where _κ_ denotes thermal conductivity. The static thermal permeability _k[′]_ 0[=][lim] _ω→_ 0 _[k][′]_[(] _[ω]_[)][,] describes the thermal effects at low frequencies. 

**Expressions for** _ρ_ ˜eq **and** _K_[˜] eq 

Now we can state the equations for the density and bulk modulus in the JCAL model. The equivalent density _ρ_ ˜eq of the material is defined 

**==> picture [220 x 23] intentionally omitted <==**

and the dynamic tortuosity is written as 

**==> picture [276 x 31] intentionally omitted <==**

where _ν_ = _η_ / _ρ f_ is the kinematic viscosity. 

The expression for the equivalent bulk modulus _K_[˜] eq is given by 

**==> picture [250 x 27] intentionally omitted <==**

where _γ_ is the specific heat ratio, _P_ 0 is the static fluid pressure, and _α_ ˜ _[′]_ ( _ω_ ) is called ˜ ˜ the thermal tortuosity, as a homologue to _α_ ( _ω_ ). The quantity _α[′]_ ( _ω_ ) is written as 

**==> picture [270 x 32] intentionally omitted <==**

where _ν[′]_ = _ν_ /Pr, and Pr is the Prandtl number. The Prandtl number is an approximately constant property of fluids, describing the ratio of momentum diffusivity to thermal diffusivity. 

## **2.2 POROELASTIC MEDIA** 

In general, the frame of a porous medium is not motionless and vibrates in response to an acoustic excitation. This happens especially when the fluid-solid coupling is strong, for example when the saturating fluid is dense, such as water or oil, when the material the frame is made of is easily deformed, or when the acoustic frequencies are low. Obviously, the solid will vibrate from direct mechanical excitation as well. Accurate prediction of sound propagation in these cases can only be achieved if we 

10 

consider a model where the fluid and the frame move simultaneously. The Biot theory [8, 9] describes this situation, and is commonly considered to be the most accurate model for poroelastic media. 

## **2.2.1 The Biot model** 

Biot’s poroelastic wave equations can be thought of as coupling the linear elastodynamic equation for wave propagation in solids, and the Helmholtz equation for wave propagation in fluids. Biot derived his equations from the principles of continuum mechanics, assuming the existence of potentials and the principle of least action [73]. Later it has been shown that the same equations can be derived by a homogenisation approach starting from the microstructure [74]. 

The original Biot model [8, 9], published in 1956, represents a porous medium with six parameters, which are the displacements of the solid phase **u** and the fluid phase **U** . Some assumptions of the theory are isotropy and homogeneity of the medium, and that the long-wavelength condition is fulfilled. In 1962, Biot published an alternative formulation of the theory [11], which describes the medium with the solid displacement and a fluid/solid relative displacement **w** = _φ_ ( **U** _−_ **u** ). This formulation is more flexible because it allows the treatment of inhomogeneous materials and simplifies some boundary conditions, and we therefore use it in this thesis. Other representations of the Biot equations have also been proposed [75,76]. 

We will next describe the basic equations and parameters in the Biot theory. Further information, and detailed derivation of the theory, can be found for example in [2, 6, 73]. In Biot’s alternative formulation [11], we can write the equations of motion in the frequency domain as 

**==> picture [243 x 32] intentionally omitted <==**

where _**σ**_ is the total stress tensor, _ρ_ = (1 _− φ_ ) _ρs_ + _φρ f_ is the bulk density of the medium, _ρs_ is the density of the solid, and the rest of the parameters are defined in the same way as in the rigid frame case. In particular, we use the Johnson model of dynamical tortuosity (2.11)–(2.12) in the expression of equivalent density _ρ_ ˜eq. The stress-strain relations in the alternative formulation are of the form 

**==> picture [264 x 27] intentionally omitted <==**

_T_ Here _**ϵ**_ =[1] 2 � _∇_ **u** + ( _∇_ **u** ) � is the strain tensor, and **I** denotes an identity tensor. The quantities _N_ , _α_ B, _λc_ , and _M_ are elastic coefficients. The parameter _N_ is the classic shear modulus and _α_ B is the Biot-Willis coefficient [10]. The Biot-Willis coefficient controls the rigidity of the frame and is bounded by _φ ≤ α_ B _≤_ 1, where the lower limit corresponds to a rigid frame and the upper limit to a completely limp frame. In addition, _λc_ = _λ_ + _α_[2] B _[M]_[,][where] _[λ]_[and] _[M]_[are][other][elastic][parameters.][It][can][be] shown that when the parameters in the model are that of a perfect fluid ( _φ_ = 1, _α_ ∞ = 1, _N_ = 0, _k_ 0 _→_ ∞) the Biot equations reduce to the linear lossless acoustic wave equation, and when the parameters are that of a pure solid ( _φ_ = _α_ B = 0, _α_ ∞ _→_ ∞), we get the elastic wave equation [73]. 

11 

Rather than use the elastic parameters defined by Biot, we would like to characterise materials with more commonly used parameters. We therefore relate the _α_ B, _M_ , and _λc_ to porosity, shear modulus, and the bulk moduli _K f_ , _Ks_ (the bulk modulus of the elastic solid from which the frame is made of), and _Kb_ (the bulk modulus of the porous frame in a vacuum), with the following relations 

**==> picture [281 x 94] intentionally omitted <==**

see [6,10]. 

## **Waves in a poroelastic medium** 

A fluid medium can only support the compressional wave whereas an isotropic elastic medium can support both compressional and shear wave propagation. We can therefore expect that these three waves will also propagate in a poroelastic medium, a consolidation of a solid and a fluid phase. Indeed, in a homogeneous isotropic media the Biot equations admit three different kinds of solutions which are the three types of waves that can propagate in porous media, called the fast and slow longitudinal waves and the shear wave. However, the waves do not propagate in a single phase in isolation, but all waves propagate both in the solid and the fluid phase and can be distinguished by their velocity and mode of propagation. The faster of the two compressional waves corresponds to vibration in which overall and fluid displacements are nearly in phase, and the slower one to vibration where they are out of phase. For the shear wave the movements are in phase since the fluid does not exert shear force and influences the propagation only through inertial effects [73]. 

Figure 2.3 depicts the generation of the three Biot waves by mode conversion at the poroelastic boundary. A compressional wave is initially propagating in a fluid medium, meets a poroelastic slab at an angle and transmits a part of its energy into the poroelastic material (reflections are not shown) where the propagation continues as Biot waves. The waves refract at different angles depending on their velocity, and can eventually be recorded after they are converted back to a compressional wave in the fluid. Note that at normal incidence, a plane wave excitation does not generate a shear wave because there is no sideways excitation at the interface. 

## **2.2.2 Losses in water-saturated materials** 

Let us now consider attenuation of the waves in a poroelastic material. Like in the rigid frame situation, viscous effects in the fluid are an important loss factor, and we can use the dynamical tortuosity [69] model (2.11)–(2.12) to account for them. Possible thermal losses in the saturating fluid can also be accounted for with the Champoux-Allard-Lafarge model [70,71] (2.13)–(2.14). However, thermal effects can often be neglected when the medium is saturated with a liquid due to liquids’ compressibility being much lower than that of gases. 

12 

**==> picture [297 x 217] intentionally omitted <==**

**Figure 2.3:** A schematic showing the three Biot waves in a porous medium (after [13]). Reflected waves are not shown. 

Another source of attenuation in porous media are the viscoelastic losses in the solid frame. A viscoelastic material responds to an applied stress with a small delay, which means that the behaviour is time-dependent and the material can be said to have a memory [77]. In the frequency domain, we can model linear viscoelastic wave propagation with a complex elastic modulus, where the real part determines the phase velocity and the imaginary part determines the damping. When damping in the solid is small, we can use real and imaginary parts that are constant with frequency as the simplest attenuation model, but this is in general not valid [78]. The requirement of causality, which in the frequency domain is expressed with the Kramers-Krönig relations [60,73], necessitates that the real and imaginary parts are frequency dependent. 

Let us consider a general complex elastic modulus _M_ ( _ω_ ) = _M_ R( _ω_ ) + i _M_ I( _ω_ ), which consists of frequency-dependent real and imaginary parts. We can now define a dimensionless quality factor _Q_ , which describes the dissipation in the medium: 

**==> picture [224 x 25] intentionally omitted <==**

A highly dissipative medium has a small _Q_ , whereas for a purely elastic medium _Q →_ ∞ and the elastic modulus is real and constant. Note that the quality factor is always defined as (2.20), but different viscoelasticity models give different values of _Q_ . 

Models for describing the behaviour of _Q_ with respect to frequency are often derived based on simple mechanical models, springs and dampers. The simplest ones are the Maxwell and Kelvin-Voigt models, in which a spring and a damper are connected in series and in parallel, respectively [77]. These models are not very realistic, though, because the Maxwell model predicts infinite damping at zero frequency and no damping when _ω →_ ∞, and the Kelvin-Voigt model the opposite. 

13 

A more realistic model is the Zener or standard linear solid model, which combines a spring and a Kelvin-Voigt model. Attenuation in the Zener model is again frequency dependent, but now has a peak at a central frequency _ωm_ , and approaches zero as _ω →_ 0 and _ω →_ ∞. It is also possible to construct an attenuation profile that has multiple peaks by connecting several Zener elements in parallel. This model is called the generalised Zener model. 

The Zener model and especially its generalised version give a lot of freedom to represent an attenuation profile of a material. However, the downside is that each Zener element adds three free parameters that we need to set (or estimate during inversion). Often the frequency dependence of the quality factor is not known, but some experiments have shown that _Q_ stays nearly constant over a wide range of frequencies [73]. We can then make use of the constant _Q_ model, derived by Kjartansson in 1979 [79], which is a causal model where the quality factor is constant over the whole frequency range. The advantages of using this model are that it only includes two parameters, and is mathematically very simple. A complex modulus in the constant _Q_ model is expressed as 

**==> picture [256 x 30] intentionally omitted <==**

where _ω_ 0 is a reference frequency, _M_ 0 is the modulus of _M_ ( _ω_ ) at _ω_ 0, and _Q_ is the quality factor. 

## **2.3 MODELS TO COMPUTE THE ACOUSTIC RESPONSE OF A MULTILAYER SYSTEM** 

Let us now consider the construction of a forward model for the characterisation problem in publications **II** and **III** . This means constructing a model that predicts an acoustic response of a layered system that we can measure (in our case the reflection and transmission coefficients), when the equations governing wave propagation and the physical parameters of the system are known. 

In this thesis, motivated by computational efficiency, we use plane waves to model the wave propagation. Sound propagation in complex-shaped structures has to be usually solved with element-based methods such as the Finite Element [80], Ultra Weak Variational Formulation [81], or Discontinuous Galerkin [82] methods. These methods require a certain number of elements per acoustic wavelength and with high frequencies can become intolerably complex computationally, especially with inverse problems that we wish to solve by sampling methods where we have to repeatedly solve the forward problem. In this case the computational efficiency of the forward model can determine whether or not the problem is solvable at all in practice. A considerable saving of computational effort can be made if we have a layered system. This allows us to use a number of matrix methods to analytically represent the wave propagation [83], and solve the motion equations in a fraction of the time it takes with element-based methods. 

## **2.3.1 Waves in layered media** 

Let us consider a layered system as in Figure 2.4, where a plane wave initially propagating in medium Ω[[][0][]] is incident on the system consisting of _n_ layers. The layers are assumed to be flat, stacked along the _x_ 2-dimension, and to extend to infinity 

14 

**==> picture [95 x 95] intentionally omitted <==**

**Figure 2.4:** Representation of a multilayered system. Different media are denoted with Ω[[] _[i]_[]] and the locations of the interfaces by _Ii_ . 

in the other directions. The layers can consist of a fluid (or an equivalent fluid), an elastic solid, or a saturated poroelastic material. The termination condition can either be a rigid backing, in which case there is no transmission, or another layer extending to infinity in the _x_ 2-direction. Assuming isotropy, the coordinate axis can always be rotated so that there is no propagation in the _x_ 3 direction, and the problem reduces to two dimensions [6]. Let us represent an arbitrary field in the frequency domain as _χ_ ( _x_ 1, _x_ 2; _ω_ ). Because of the plane wave assumption, we can perform a ˆ Fourier transform along _x_ 1 and write the field as _χ_ ( **x** ; _ω_ ) = _χ_ ( _k_ 1, _x_ 2; _ω_ ) _e_[i] _[k]_[1] _[x]_[1] , where _k_ 1 = _−k_[[][0][]] sin( _ϕ_ inc), and _k_[[][0][]] = _ω_ / _c f_ . We will omit the _ω_ and _k_ 1 dependence for clarity, and write _χ_ ˆ( _k_ 1, _x_ 2; _ω_ ) _≡ χ_ ˆ( _x_ 2). 

In each layer, equations for the displacements, stresses, and pressure can be stated as the superposition of the wave fields in the layer. These physical fields are solutions to the wave equation (acoustic, elastic, or poroelastic depending on the material) in an infinite medium, and can be expressed as a function of the complex amplitude _A_ and wave number _k[type]_ 2 of each wave, where _type_ indicates the mode of the wave. The idea of multilayer matrix methods is then to combine these solutions of an infinite medium together by introducing boundary conditions at interfaces between the layers. In each layer we can have a backward and a forward propagating wave, so in a fluid layer we can have two, in an elastic layer four, and in a poroelastic layer six wave fields. We can thus write an expression of, for example, the _x_ 2 solid displacement _u_ ˆ in a poroelastic material as 

**==> picture [316 x 33] intentionally omitted <==**

where amplitudes 1 and 2 correspond to the fast longitudinal wave, amplitudes 3 and 4 correspond to the shear wave, and amplitudes 5 and 6 correspond to the slow longitudinal wave. We can state the other displacements and stresses as a function of the wave amplitudes **a** = [ _A_ 1, . . . , _A_ 6] _[T]_ as well, using the stress-strain relations (2.16). This derivation can be quite cumbersome, however, and in practice we can use the following simpler method based on state vector formalism. 

ˆ Let us combine the displacements, stresses, and pressure into a _state vector_ **s** ( _x_ 2). The state vector components can be selected arbitrarily as long as they are continuous at the interfaces, and it can be shown that for a given layer the number of the state vector components is equal to the number of the forward and backward propagating waves in the layer [84]. For example for fluids it is convenient to select 

15 

pressure and velocity normal to the interface since they are continuous over boundaries. For a poroelastic material we can choose **s** ˆ( _x_ 2) = [ _σ_ ˆ12, _σ_ ˆ22, _p_ ˆ, _u_ ˆ1, _u_ ˆ2, _v_ ˆ2], i.e. the normal components of the total stress tensor, _σ_ ˆ12 and _σ_ ˆ22, the pressure _p_ ˆ, the solid displacements _u_ ˆ1 and _u_ ˆ2, and the normal component of the total velocity ˆ ˆ _v_ 2 = _−_ i _ω_ ( ˆ _w_ 2 + _u_ 2). 

Using the state vector, we can write the equations of motion for any type of layer (see for example [85]) as a system of ordinary differential equations as 

**==> picture [224 x 25] intentionally omitted <==**

where **A** is the state matrix, which depends on the components selected for the state vector, and is a function of the material parameters, properties of the incident wave, and frequency. We can use this approach to model inhomogeneous materials too, in which case **A** will also be a function of _x_ 2. It can be shown (see [84]) that we can now write a matrix equation where the state vector is given as a function of the wave amplitudes **a** as 

**==> picture [225 x 12] intentionally omitted <==**

To find the field matrix [ **M** ], we calculate the eigendecomposition of **A** = **ΦΓΦ** _[−]_[1] , where **Φ** and **Γ** are matrices that include the eigenvectors and the eigenvalues, respectively. Then [ **M** ( _x_ 2)] = **Φ** exp _{−_ ( _x_ 2 _−_ **x** ref) **Γ** _}_ , where **x** ref is a reference location. 

## **2.3.2 The transfer matrix method** 

The transfer matrix method (TMM), also known as the Thomson-Haskell method [86, 87], is a well-known general purpose multilayer modelling tool which can be used to calculate the acoustic response of layered systems. The method assumes that the propagating waves are plane waves, but finite fields can be studied by superposition of the plane wave solutions [88]. The basic idea in the TMM is to represent the propagation in each layer with a matrix that relates the state vector of the system at the back of the layer to that at the front of the layer [83]. In the following, the notations are as in Figure 2.4. 

The goal in the TMM is to find a matrix _**T**_ which relates the state vector **s** ˆ[[][1][]] ( _I_ 1) of layer Ω[[][1][]] at the first interface to the state vector **s** ˆ[[] _[n][−]_[1][]] ( _In_ ) of layer Ω[[] _[n][−]_[1][]] at the last interface, i.e. 

**==> picture [235 x 13] intentionally omitted <==**

The state vectors at the beginning and end of the layers can then be connected to the known incident, unknown reflected, and unknown transmitted (if no rigid termination) waves, which lets us calculate the acoustic response of the system by solving a matrix equation. 

We can find the matrix _**T**_ in the following way. The amplitudes of the waves inside the same layer are obviously the same near both interfaces, so based on (2.24) we can write for the layer Ω[[][1][]] : 

**==> picture [291 x 13] intentionally omitted <==**

This means we can find a single layer transfer matrix: 

16 

**==> picture [235 x 14] intentionally omitted <==**

where [ **T**[[][1][]] ] = [ **M**[[][1][]] ( _I_ 2)][ **M**[[][1][]] ( _I_ 1)] _[−]_[1] . Now, if layer Ω[[][2][]] is made of the same type of material as layer Ω[[][1][]] , and the components of the state vectors are continuous at the boundary, we must have **s** ˆ[[][2][]] ( _I_ 2) = **s** ˆ[[][1][]] ( _I_ 2) and therefore 

**==> picture [235 x 14] intentionally omitted <==**

If the layers are of different materials we have to include interface matrices, but for simplicity we do not consider them here and direct the reader to [6, 89]. The same process can be repeated until all layers have been considered: 

**==> picture [282 x 14] intentionally omitted <==**

One of the strengths of the TMM is that we can describe multilayered systems by a single transfer matrix, simply by multiplying together the matrices of the single layers: 

**==> picture [251 x 14] intentionally omitted <==**

Finally, to find the response of the layered system, we express it in terms of the 

**==> picture [261 x 14] intentionally omitted <==**

In a usual case, the first and last layers are fluids (this corresponds to a layered system in air or water for example), and we can then have a longitudinal wave propagating towards and away from the system at both ends. To find the reflection and transmission coefficients **R** and **T** , respectively, we set the amplitude of the incoming wave to 1 at layer Ω[[][0][]] , and to 0 at layer Ω[[] _[n]_[]] so there is not a wave propagating towards the system from the back. Then the amplitude of the reflected wave corresponds to **R** and the transmitted wave to **T** , i.e. **a**[[][0][]] = [1, **R** ] _[T]_ and **a**[[] _[n]_[]] = [0, **T** ] _[T]_ . Now we have two equations and two unknowns so the coefficients can be solved. 

An important issue with the TMM is that it is known to exhibit instability at high frequencies and/or large layer thicknesses. This is known as the ”large _f d_ problem” [83]. The problem is of numerical origin (finite precision computers) and is caused mainly by the poor condition number of the transfer matrix, due to the combination of both exponentially decaying and growing components. We observed this instability in our simulations, which meant the TMM approach could not be used. Even though the cause is well-known, the proposed solutions to this differ, and are also dependent on the application. One option is the information vector method [84]. Another solution is to use the so-called global matrix method [90], which was adopted in this thesis. 

## **2.3.3 The global matrix method** 

The global matrix method (GMM) [83,90–92] is an alternative matrix formulation to the TMM, originally proposed in [90]. The main idea in the GMM is to write the forward and backward propagationg waves inside the material explicitly as a function of their amplitudes, and choose the origin of the waves to be on the interface 

17 

they originate from. We then assemble the equations for these waves in a single global matrix that represents the whole system. A disadvantage of the GMM is that the resulting matrix can be quite big, which can lead to longer calculation times. A significant advantage, however, is that this method is stable for all frequencies and thicknesses [91, 92]. The stability comes from the freedom to choose the origin of each wave on the interface where they originate, and the exponentially growing and decaying components are not coupled from one interface to the other. 

To show the principle of the GMM, let us again consider the layered system of Figure 2.4. Assuming layers of the same type, we can use the continuity of the state vector components on the first interface: 

**==> picture [250 x 13] intentionally omitted <==**

This can be also stated as 

**==> picture [259 x 26] intentionally omitted <==**

We can repeat the process for all interfaces and assemble the equations into a global matrix: 

**==> picture [360 x 147] intentionally omitted <==**

If adjacent layers are not of similar media (fluid-porous for example), the state vectors are not of the same size and we have to again use interface matrices [6]. 

Once the global matrix (2.34) is assembled, just like with the TMM, we have to know some of the wave amplitudes in order to solve the response of the system. Typically, we set one incoming wave amplitude to one and the rest to zero, and in the case of a layered system surrounded by fluid we then have **a**[[][0][]] = [1, **R** ] _[T]_ and **a**[[] _[n]_[]] = [0, **T** ] _[T]_ . The unknowns in the problem then consist of the amplitudes within the layers ( **a**[[][1][]] , . . . , **a**[[] _[n][−]_[1][]] ), as well as of **R** and **T** . The known parts of **a**[[][0][]] and **a**[[] _[n]_[]] , along with the parts of the global matrix corresponding to them, can now be moved to the right hand side of equation (2.34), and the unknown amplitudes can be solved by a single matrix inversion. 

18 

**3 Bayesian methods for parameter estimation** 

In this chapter, we discuss the inverse problem in the characterisation of porous media, namely estimating model parameters from acoustic measurements. Parameter estimation is a topic in publications **I** – **III** , but computational methods for the inversion are developed especially in publication **II** . We will treat the parameter estimation problem in the Bayesian framework, and this chapter starts by giving a brief review of Bayesian statistics. For a more comprehensive treatment we refer the reader to the following textbooks on Bayesian statistics and inversion: [34,37–39,93]. In the latter part of this chapter, we concentrate on methods of computational inference, mainly using sampling methods. 

## **3.1 PARAMETER ESTIMATION IN THE BAYESIAN FRAMEWORK** 

In the Bayesian approach, all unknowns are modelled as random variables, and we express the information about them as probability densities. The solution of the inverse problem is the posterior probability density (ppd), which combines the information that we learn from measurement data and what we know from other sources (the prior). The ppd can then be used to answer all questions that we can pose in terms of probabilities. These include ” _What are the parameter values that maximise the posterior probability?_ ”, ” _What is the mean value of the posterior?_ ”, and ” _What are the intervals that include most of the posterior probability?_ ”. 

The posterior is constructed using the famous Bayes’ formula: 

**==> picture [268 x 25] intentionally omitted <==**

which is an expression of the conditional probability of the unknown parameters _**θ**_ given the measurement data **y** . In order to find the posterior we have to consider the probability distribution of **y** in terms of _**θ**_ , which is done by constructing a model for the likelihood _π_ ( **y** _|_ _**θ**_ ). Likelihood tells us how the measurements would be distributed if we knew the unknown _**θ**_ . In addition, we need to include the possible prior information on _**θ**_ , denoted by the density _π_ ( _**θ**_ ), in which we express what we know about the unknowns prior to taking the measurement data into account. Lastly, in formulation (3.1) the term _π_ ( **y** ) is fixed, and only acts as a normalising constant. We can therefore ignore it and consider the unnormalised posterior that is proportional to the product of the likelihood and the prior. 

If the inverse problem has more than two unknowns, visualising the full posterior is difficult. Typically we then summarise the information contained in the posterior with point and interval estimates. Two perhaps the most common statistical point estimates are the _maximum a posteriori_ (MAP) and the _conditional mean_ (CM) estimates. The MAP estimate is the point which maximises the posterior probability 

**==> picture [240 x 16] intentionally omitted <==**

19 

Note that this maximiser may not exist or be unique [38]. Computing the MAP estimate requires the solution of an optimisation problem, and the procedure of computing the MAP estimates is similar to the one of the least squares. 

The CM is defined as the expected value of the posterior, that is, the center-ofmass 

**==> picture [237 x 21] intentionally omitted <==**

where _**θ** ∈_ **R** _[n]_ _**[θ]**_ and _n_ _**θ**_ denotes the number of the unknowns. The conditional mean is a conditionally biased but unconditionally unbiased estimate [94], and can be also shown to minimise the trace of the posterior covariance [38]. Computing the CM estimate is an integration problem. Usually the integral (3.3) is high-dimensional which renders quadrature integration approaches infeasible. In this case we typically approximate the integral using Markov chain Monte Carlo techniques, described later in this chapter. 

Examples of the spread estimates include the conditional covariance 

**==> picture [291 x 21] intentionally omitted <==**

if it exists, and the Bayesian (marginal) credible intervals CI _k_ ( _p_ ) = [ _aI_ , _bI_ ] _⊂_ **R** , 

**==> picture [240 x 25] intentionally omitted <==**

where the marginal posterior density of _θk_ is defined as 

**==> picture [297 x 21] intentionally omitted <==**

and the interval CI _k_ ( _p_ ) contains _p_ % of the marginal posterior mass. Definition of the _p_ % credible interval is not unique. One way to define the interval is so that the tails of the density function contain an equal amount of posterior mass 

**==> picture [299 x 23] intentionally omitted <==**

Another common way to define the interval is to minimise the distance between the endpoints 

**==> picture [305 x 26] intentionally omitted <==**

Credible intervals can be directly interpreted as statements on the probabilities of the parameter values [39], i.e. they represent the uncertainty in the estimates. 

It is also possible to define a credible set, where instead of the endpoints of the marginal densities we are looking for an equiprobability hypersurface in **R** _[n]_ _**[θ]**_ which encloses _p_ % of the posterior mass. 

20 

## **3.1.1 Likelihood** 

Let us now describe the construction of the likelihood model. The likelihood is a function that describes the distribution of the measurements when we know what _**θ**_ is, and what the measurements conditions are [34]. Likelihood thus contains the forward model, and information on measurement noise and some of the model uncertainties. 

We will start by considering the measurement noise. Most often, as is done in this thesis as well, measurement noise is modelled as additive and mutually independent of the unknowns. Let **y** _∈_ **R** _[n]_ **[y]** , where _n_ **y** denotes the length of the measurement vector. With the additive noise assumption, an observation model for the measurements can be written 

**==> picture [215 x 11] intentionally omitted <==**

where _h_ : **R** _[n]_ _**[θ]** →_ **R** _[n]_ **[y]** is the forward model that maps the unknown parameters to measurable data, and **e** _∈_ **R** _[n]_ **[y]** denotes the additive measurement noise component. Because _**θ**_ and **e** are mutually independent, the expression for the distribution of the measurements when _**θ**_ 

**==> picture [238 x 11] intentionally omitted <==**

where _π_ **e** ( _·_ ) denotes the distribution of the noise. The noise is often assumed to be normally distributed, which means that the likelihood can be written as 

**==> picture [360 x 27] intentionally omitted <==**

where **Γe** is the noise covariance matrix, and **e** _∗_ the noise mean. If the noise covariance is known, the term in front of the exponential is constant and only acts as a normalising factor. In this thesis we assume that **e** _∗_ = 0 and that all covariances are positive definite. Then, by denoting the square root of the inverse of the noise covariance with **L**[T] **e[L] e**[=] **[Γ] e** _[−]_[1][, we can write the likelihood as] 

**==> picture [270 x 25] intentionally omitted <==**

If the noise covariance is unknown, we can model it as another random variable that we estimate, and write it inside the exponential term 

**==> picture [314 x 25] intentionally omitted <==**

In publications **I** – **III** we model the noise as independent and identically distributed (i.i.d.), so that the general form of the noise covariance matrix is 

**==> picture [206 x 13] intentionally omitted <==**

where _σ_ **e**[2][is the noise variance and] **[ I]**[ denotes a] _[n]_ **[y]** _[×][ n]_ **[y]**[identity matrix.] 

21 

## **3.1.2 Prior models** 

The prior density _π_ ( _**θ**_ ) is used to represent information about the unknowns that we have _prior_ to taking the measurement data into account. In principle, constructing the prior is simple since the main requirement is that it gives a high probability to parameter values we expect to see, and a low probability to values we do not expect to see. The prior density should also constrain the unknowns to feasible values. Since the posterior is formed as a product of the likelihood and the prior, the prior has the biggest effect along the posterior dimensions that the data is not very informative. The exact analysis can be carried out using the eigenvalue analysis of posterior covariance. In parameter estimation this means that the prior is highly influential for parameters of which the data does not contain much information about. One difficulty in designing the prior may arise when the prior knowledge is qualitative in nature, because it can be hard to translate into a quantitative representation. The simplest form of the prior is a uniform density 

**==> picture [240 x 31] intentionally omitted <==**

where _D_ is the domain (of feasible values) to which we want to restrict _**θ**_ . We do not normalise the density because we are only interested in the relative probabilities between parameter values, and the constant normalising factor disappears in the proportionality (3.1). Priors of the form (3.15) are often used to specify positivity constraints, as was done in **I** , and they can also be used together with other types of priors, as was done in **II** and **III** . 

Perhaps the most commonly used form of prior is the multivariate normal distribution, where the probability density is written as 

**==> picture [261 x 25] intentionally omitted <==**

Here _**θ** ∗_ denotes the expected value of the prior, and **L**[T] _**θ**_ **[L]** _**θ**_[=] **[Γ]** _[−]_ _**θ**_[1] is a matrix square root of the inverse of the prior covariance matrix. We use multivariate normal priors (truncated with in indicator function of the form (3.15)) in publications **II** and **III** . 

## **3.2 MARKOV CHAIN MONTE CARLO** 

Computation of the conditional mean and interval estimates requires integrating over the posterior density. The integrals are nearly always approximated numerically since an analytical representation of the posterior is rarely obtainable. In low dimensions we can use deterministic integration methods such as Gauss quadratures, but as the number of unknowns grows, the so-called ”curse of dimensionality” renders such approaches infeasible. The alternative is to approximate the high-dimensional integrals by statistical methods, which are based on obtaining representative samples from the probability density of interest, and using the samples to approximate the expectations and other summaries. A common approach is Monte Carlo integration [95], where the samples are drawn randomly around the parameter space. The basic Monte Carlo method can be made more efficient with methods such as importance sampling, where the samples are still drawn at random but more often in regions of high probability. 

22 

Markov chain Monte Carlo (MCMC) is a class of particularly useful sampling methods, where samples from the parameter space are obtained by simulating random walks in it [96]. The random walk must form a _Markov chain_ , which by definition means that the next step in the chain can depend only on the chain’s previous position. The basic idea behind a MCMC simulation is that we start at a point (or in general, a state) _X_ 1 in the parameter space, do a random change to it that satisfies certain conditions, and repeat enough times. In doing so we generate a large sample of points that are distributed according to a given target distribution _π_ ( _·_ ), such as the posterior. MCMC differs from ordinary Monte Carlo methods in that the samples are no longer independent. However, despite the dependence of the samples, running a MCMC simulation may be significantly more efficient, and often the only feasible solution, for integrating complicated probability densities. 

A strength of the sampling methods is that once enough samples have been obtained, we can easily approximate unknown quantities of _π_ ( _·_ ), such as the expected value of a function _g_ : 

**==> picture [269 x 27] intentionally omitted <==**

where _X_ is the support of _π_ ( _**θ**_ ), and _n_ is the sample size. For example the CM estimate is computed by taking the mean value of the obtained posterior samples. In addition, computing the posterior marginal densities and credible intervals from the samples is trivial. 

The reason we can make the approximation in (3.17) is the ergodic theorem, which implies that if **Θ** = ( _**θ**_ 1, _**θ**_ 2, _**θ**_ 3, . . . ) is a Harris ergodic Markov chain with _π_ ( _·_ ) as its limiting distribution, then with probability 1, 

**==> picture [273 x 27] intentionally omitted <==**

if **E** _π|g| <_ ∞ [97]. For the precise definitions, see [95, 96, 98]. To construct such a Markov chain we use a _transition kernel K_ , which is a conditional probability density such that _**θ** k_ +1 _∼ K_ ( _**θ** k_ , _**θ** k_ +1). A simple example is the random walk process, _**θ** k_ +1 = _**θ** k_ + _ϵk_ , where the random term _ϵk_ does not depend on the previous samples. Obviously, when _n <_ ∞ the approximation _g_ ¯ _n_ is not exact. We will discuss the error variance later in this chapter. 

## **3.2.1 Metropolis-Hastings update** 

The transition kernel, or the update mechanism, with which the chain is generated is a central factor in the behaviour and efficiency of the MCMC sampler. The Metropolis-Hastings (MH) accept-reject update [46, 47] forms the basis of most of the update mechanisms. Let us again denote the target probability density with _π_ ( _·_ ), and the current location of the chain in the parameter space by _**θ** k_ . Then the steps for a single MH update are: 

1. Propose a candidate _**θ**[′]_ for the next element in the chain by drawing it from the proposal density _q_ ( _**θ** k_ , _**θ**[′]_ ). 

2. Calculate the acceptance ratio 

**==> picture [254 x 25] intentionally omitted <==**

23 

3. With probability _a_ ( _**θ** k_ , _**θ**[′]_ ) set _**θ** k_ +1 = _**θ**[′]_ (accept proposal), and otherwise set _**θ** k_ +1 = _**θ** k_ (reject proposal). 

Note that the chain is propagated even if the proposed candidate is rejected. In addition, when sampling from posterior densities, the normalising factor ( _π_ ( **y** ) in (3.1)) is cancelled out. The MH update is, in principle, very simple to implement. However, in practice there are enormous differences in the efficiency depending on the choice of the proposal density. 

As stated above, a special case of the MH algorithm is the _random walk Metropolis_ (RWM) algorithm, where the proposal is of the form _**θ**[′]_ = _**θ** k_ + _ϵk_ , where _ϵk_ is stochastically independent of _**θ** k_ . One of the most common method of constructing a RWM proposal is to use a Gaussian distribution, so the proposal has the form and _ϵk ∼N_ (0, **Σ** ), where **Σ** is the proposal covariance matrix. A useful property of the RWM proposals is that they are symmetric, i.e. _q_ ( _**θ** k_ , _**θ**[′]_ ) = _f_ ( _∥_ _**θ**[′] −_ _**θ** k∥_ ). With symmetric proposal densities the acceptance ratio (3.19) simplifies to 

**==> picture [248 x 25] intentionally omitted <==**

This is called the Metropolis acceptance ratio and it is the original MCMC algorithm that was proposed in 1953 [46]. In the Metropolis algorithm, if _π_ ( _**θ**[′]_ ) is greater than or equal to _π_ ( _**θ** k_ ) the proposal is always accepted, whereas if _π_ ( _**θ**[′]_ ) is smaller than _π_ ( _**θ** k_ ) the proposal is accepted with the probability _a_ ( _**θ** k_ , _**θ**[′]_ ). 

With Gaussian proposal densities, a big question is how to choose the the proposal covariance **Σ** . As already noted, the proposal has a huge effect on the efficiency of the algorithm, and different ways to choose **Σ** has been an area of active research. 

## **3.2.2 Efficiency measures** 

Although in the limit _n →_ ∞, _any_ correctly implemented MCMC sampler will generate a set of samples that are distributed according to the limiting distribution, an efficient sampler produces usable estimates quickly, whereas an inefficient one may not converge in the lifetime of the universe. We need therefore ways to assess the efficiency of the samplers. 

**Autocorrelation** An efficient MCMC sampler will mix well, i.e. it moves quickly all around the relevant parts of the parameter space, and will achieve convergence quickly (as opposed to pseudo-convergence where the chain seems to have converged but is actually stuck in a local maximum). Unfortunately, no diagnostic can reliably detect the convergence of a Markov chain. What we can do, however, is to check the autocorrelation of the chain, which gives an indication on how many iterations we need to produce one independent sample, and thus says something about the efficiency of the sampler. The ideal Markov chain would have an integrated autocorrelation time of one, _τ_ = 1, equivalent to i.i.d. sampling. 

Samples in a Markov chain are roughly independent when we consider a subsampled chain, where we take every _τ_ :th sample. To measure the efficiency of the sampler, we are mainly interested in the number of independent samples, or the _effective sample size_ (ESS), of the chain. The ESS can be estimated by considering the autocorrelation time for one variable at a time, but this ignores the correlations between parameters and gives an inaccurate picture of the sample quality. Vats _et_ 

24 

_al._ [99] have proposed a multivariate version of the ESS, which considers the covariance structure of the sample. They define it as 

**==> picture [241 x 28] intentionally omitted <==**

where _n_ is the sample size, _n_ _**θ**_ is the dimension of the parameter space, **Λ** is the sample covariance matrix, **Σ** ∞ is the asymptotic covariance matrix in the Markov chain central-limit theorem (see eq. (3.24)), and _| · |_ represents the matrix determinant. An estimate **Σ** _n_ for **Σ** ∞ can be found by a multivariate batch means estimator: 

**==> picture [265 x 28] intentionally omitted <==**

To calculate **Σ** _n_ we need to cut the chain into _an_ batches that have the length _bn_ (i.e. _n_ = _anbn_ ), _**θ**_[¯] _k_ is the mean value of the batch _k_ : 

**==> picture [234 x 31] intentionally omitted <==**

and _**θ**_[¯] is the mean value of all of the samples (i.e. the CM estimate). There are several ways to decide the batch size, but in general it should grow with the chain length, for example as _bn_ = _n_[1/2] or _bn_ = _n_[1/3] . Also higher correlation in the parameters calls for a larger batch size, suggesting that _bn_ ∝ _τ_ . 

## **3.2.3 Stopping criteria and diagnosing convergence** 

We need to have some criteria to stop the MCMC simulation. The simplest one is to run the chain for _N_ predetermined steps and then stop, but this is far from ideal. To make meaningful inferences we need to be relatively sure that the chain has first of all converged and secondly had enough time to sample the target distribution. Autocorrelation times together with looking at the time series of the individual chains provide a tool to assessing whether we can stop the simulation or not. 

A more objective stopping criteria can also be constructed. For example, we can decide to stop the simulation once a predetermined accuracy of a statistic is reached. Commonly we look at the estimate of the mean, _**θ**_[¯] , and its estimation error, the Monte Carlo standard error (MCSE), defined in the following. 

## **Burn-in** 

Before it is sensible to start estimating properties such as the mESS and MCSE, we need to make sure the chain has reached the steady-state. In the beginning of the MCMC run, especially if the starting location of the chain was far away from the main support of the pdf, the values do not represent the target density very well and it can be good to remove them so that they do not cause bias in the estimates. This initial period is called the burn-in period. Removing the burn-in is important especially when we are using adaptive MCMC methods that we will describe later. However, note that removing a burn-in phase from the beginning of the simulation is sometimes completely unnecessary [96]. This is the case when we do not use adaptation, and do sufficiently long runs so that the effect caused by the initial locations is negligible. 

25 

**==> picture [371 x 120] intentionally omitted <==**

**Figure 3.1:** The first 45,000 iterations of one parameter of an example MCMC run. During the first 15,000 iterations the chain is drifting towards the region of the main probability mass, but after that it stays more or less stationary. 

Figure 3.1 shows an example of a MCMC run, where the chain was not started in the region where the most of the probability mass is, and therefore in the beginning we can see the chain drifting towards this area. After about 15,000 iterations, the drifting seems to stop and we have reached the steady state. We could then remove these 15,000 iterations from the beginning as the burn-in. 

## **Monte Carlo standard error** 

The difference _g_ ¯ _n −_ **E** _π g_ is called the Monte Carlo error, and although in practice we can never know its true value, we can approximate it by estimating the variance of its asymptotic distribution. Let us examine the unidimensional case, i.e. _θ_ is a single unknown. The central limit theorem (CLT) states that [97]: 

**==> picture [253 x 19] intentionally omitted <==**

as _n →_ ∞, where _σg_[2][:][=][var] _[π][{][g]_[(] _[θ]_ 1[)] _[}]_[ +][ 2][ ∑] _i_[∞] =2[cov] _[π][ {][g]_[(] _[θ]_[1][)][,] _[ g]_[(] _[θ][i]_[)] _[}]_[,][and][we][assume] that _θ_ 1, _θ_ 2, _θ_ 3, . . . are identically distributed and _θ_ 1 is distributed according to the target distribution _π_ ( _·_ ). The CLT can be stated in the multivariate setting too, where we replace _σg_[2][with][its][multivariate][counterpart] **[Σ]** _[g]_[.][The][CLT][shows][that][that][the] accuracy of a Monte Carlo simulation increases as _[√] n_ . 

To estimate the Monte Carlo error we need an estimator _σ_ ˆ _g_[2][for][the][asymptotic] variance _σ_[2][Non-overlapping batch means are one of several ways to do this.][If we] _g_[.] denote the mean of the _k_ :th batch [ _g_ ( _θ_ ( _k−_ 1) _bn_ +1), ..., _g_ ( _θkbn_ )] with _Y_[¯] _k_ (see Eq. (3.23)), the batch means estimate for _σg_[2][is] 

**==> picture [246 x 27] intentionally omitted <==**

where again _an_ is the number of batches and _bn_ is the batch length. Now we can estimate the Monte Carlo standard error of _g_ ¯ _n_ [97]: 

**==> picture [219 x 25] intentionally omitted <==**

26 

and we can also calculate the (1 _− α_ ) _·_ 100 % confidence interval for the mean. We know that the error of the mean has a _t_ -distribution with _n −_ 1 degrees of freedom (the CLT tells us that asymptotically, the error is normally distributed). So we are looking for values _q_ 1 and _q_ 2 that contain the true value with probability (1 _− α_ ). From probability theory we know that [100] 

**==> picture [353 x 31] intentionally omitted <==**

where 

**==> picture [260 x 31] intentionally omitted <==**

For example the half width of the (1 _− α_ ) _·_ 100 % confidence interval for **E** _g_ is then given by 

**==> picture [248 x 25] intentionally omitted <==**

where _tan−_ 1( _·_ ) denotes the inverse cumulative distribution function of the _t_ -distribution with _an −_ 1 degrees of freedom. 

## **Stopping criteria** 

Let us now examine a few criterion for stopping the simulation. 

**Fixed-length** The standard way to run MCMC is to iterate for _N_ steps, check visually if the run has ”converged” and either stop or run for longer. This is not very accurate, though, and better ways have been proposed. 

**Fixed-width** In the fixed-width criterion the desired level of accuracy is predefined and the simulation is stopped once it is reached. One example of such a stopping rule is given in [97], where the stopping criterion is 

**==> picture [247 x 25] intentionally omitted <==**

where _ε_ is the maximum error level, _I_ is an indicator function, and the role of _n[∗]_ is to prevent a premature stopping due to a bad estimate of _σ_ ˆ _g_ . In practice, this is calculated for each parameter separately and the simulation is terminated when the uncertainties in all of the parameters are under the error limit. 

**Fixed-width relative to standard deviation** Another way to stop the simulation is to base the maximum error level _ε_ on a percentage of the standard deviation of the parameters, instead of a predefined level of accuracy. This allows for some flexibility in the stopping criterion since the method allows for more _absolute_ error in parameters that have inherently more variability while keeping the _relative_ error the same. This is the method we chose to use in publications **II** and **III** . 

The stopping criterion is 

27 

**==> picture [259 x 26] intentionally omitted <==**

where _εSD_ represents now the allowed percentage error in the standard deviation _σθ_ of the actual parameter, for example _εSD_ = 0.10 _· σθ_ . 

**Multivariate fixed-width** It can be shown [99] that stopping based on the effective sample size is equivalent to the fixed-width relative to standard deviation rule. Calculating the multivariate ESS would take the correlations between parameters into account, making the stopping rule even more robust. 

## **3.3 MCMC SAMPLERS** 

In this section, we will describe some commonly used updating mechanisms for the Markov chain. We call the update mechanisms ’samplers’ since they determine how the MCMC code samples the target density. 

A robust sampler is one that can deal with probability densities that are challenging to sample, such as multimodal or strongly non-normal ones. We need a robust sampler so we can be reasonably confident that we are indeed sampling from the full distribution instead of just a local maximum. Unfortunately, the robustness of a sampler also depends on the application, and hence universal recommendations that work in all cases are not possible. 

## **3.3.1 Overview** 

Since the ”second-generation MCMC revolution” starting approximately in the 1990’s [96], a huge number of MCMC samplers have been proposed. These include adaptive Metropolis [48, 50, 101–106], Metropolis-adjusted Langevin [107–109], Hamiltonian Monte Carlo [110–113], Gibbs [114,115], reversible jump MCMC [41,116–120], delayed rejection [121, 122], randomize-then-optimize [123, 124], parallel tempering [49, 51, 125–129], affine invariant ensemble sampling [130–132], elliptical slice sampling [133], stochastic Newton [134, 135], and likelihood-informed subspace [136, 137] algorithms. This list is by no means exhaustive, and in the following we will only describe the samplers that were used in **I** – **III** . 

**Random walk Metropolis and acceptance rate** First let us comment on the RWM sampler, which most of the more advanced samplers are based on. The proposal density in RWM is usually Gaussian, _ϵ ∼N_ (0, **Σ** ), or uniform, _ϵ ∼U_ ([ _−_ _**σ**_ , _**σ**_ ]), where **Σ** denotes the proposal covariance matrix, and _**σ**_ a vector of proposal widths. However, other types of proposals have also been successfully used [138]. In the following we will use the term ”proposal (co)variance” to mean generally the width of the proposal density. The RWM algorithm is very simple to implement, but can be difficult to tune properly, the reason being that no matter what kind of proposal we are using, we have to fix its variance before the simulation. 

If the variance of the proposal is set too large, the proposals _**θ**[′]_ are far away from the current location _**θ** k_ , and likely the value of the density at _π_ ( _**θ**[′]_ ) is much lower than at _π_ ( _**θ** k_ ). Then the acceptance ratio (3.20) is small, the proposal will be rejected often, and the chain will not move. This wastes computation resources and leads to long autocorrelation times. On the other hand, if the proposal variance is set too 

28 

small, virtually all proposals will be accepted but the chain still moves very slowly around the parameter space. Again we have long autocorrelation times. Clearly there must exist better values for the proposal variance between these two extremes, where the proposals are sometimes accepted and sometimes rejected, and the chain moves around the parameter space more efficiently. However, finding the efficiencywise optimal, or even a good, proposal covariance by trial and error when little is known about the target distribution, is problematic to say the least. 

This behaviour of the chain can be monitored with the _acceptance rate_ , which is defined simply as the long-term average of the acceptance ratios (3.20). Again, a general optimal value for the acceptance rate does not exist, but as a rule of thumb as long as the acceptance rate is between 10 and 60 % the extremes of bad sampling are avoided. However, it has been shown [139, 140] that efficiency-wise the optimal acceptance rate for uncorrelated _Gaussian_ target distributions is 0.44 in the one-dimensional case, declining to 0.23 when _n_ _**θ** →_ ∞. In addition, the highest efficiency is achieved when the proposal covariance mimics the covariance of the target distribution, scaled by approximately 2.4[2] / _n_ _**θ**_ . 

## **3.3.2 Adaptive algorithms** 

Even if the size and spatial orientation of the proposal covariance could be tuned by trial and error in low-dimensional cases, in high dimensions it is virtually impossible. Fortunately, the proposal covariance can be adapted automatically as the simulation goes on and we learn more about the target distribution. 

One of the first adaptive algorithms was the _adaptive Metropolis_ (AM) [48, 101], where it was proposed to adapt the size and orientation of the proposal distribution on the fly as the simulation progresses. The basic idea is to approximate the target density with a multivariate Gaussian and use the approximation as the proposal distribution: 

**==> picture [250 x 12] intentionally omitted <==**

where 

**==> picture [282 x 31] intentionally omitted <==**

We need to select a starting proposal covariance **Σ** 0, but usually it is enough to choose something small so that proposals are accepted and a first estimate of the target distribution covariance can be calculated after _k_ 0 iterations. The scaling parameter _sd_ is typically set to _sd_ = 2.4[2] / _n_ _**θ**_ , which is a good choice especially if the target density is close to Gaussian [139]. The parameter _ε_ is introduced to prevent the covariance **Σ** _k_ from becoming a singular matrix, and is selected to be very small compared to the size of the support of the target density. The proposal covariance **Σ** _k_ can be updated iteratively, so that computing it induces practically no extra computational cost. 

It is clear that with adaptive methods the resulting chain is no longer strictly Markovian, since _**θ** n_ now depends on all the previous states. However, it is shown in [48] that under certain conditions the chain is still ergodic and the adaptive algorithm can be used. Later it was realised that the AM algorithm can be viewed as belonging to a more general set of stochastic control algorithms [141] and convergence of more general adaptive algorithms was also proved [102,103]. The main 

29 

**==> picture [279 x 144] intentionally omitted <==**

**Figure 3.2:** A mixture of two Gaussian distributions with variance 1 and means _±_ 10, normalised after tempering. At _T_ = 100 the peaks are widened so much that we have a unimodal distribution. 

requirement for the adaptive algorithms to be ergodic is that the adaptation is ”vanishing”, i.e. that for every successive iteration we adapt less and less. 

The AM algorithm conditions hold also for a case where we do not consider all the past states of the chain, but only an increasing part of the near history. Calculating the covariance from ( _**θ** n_ /2, _**θ** n_ /2+1, ..., _**θ** n_ ) instead of all the samples can be better in some situations. This can be the case for example when the starting location is bad and the first samples would orientate the covariance unfavourably. 

## **3.3.3 Parallel tempering** 

The AM algorithm works very well in unimodal and convex cases, even if there are strong correlations between the parameters. However, it can be slow to converge and travel around the parameter space in more complicated situations. Multimodal distributions are notoriously hard to sample efficiently, because the individual peaks are usually separated by large areas of almost zero probability. Even if the target density is not multi-modal as such, it can include narrow peaks of high probability where the chain is likely to get stuck for long periods of time, especially if using adaptive methods. 

_Parallel tempering_ is one way to make sampling such distributions easier [49,125, 126]. It is based on raising the target density to a power, i.e. tempering, as 

**==> picture [36 x 13] intentionally omitted <==**

where _T_ can be interpreted as the temperature. At high temperatures the possible peaks of the density are flattened out, making it easier for the chain to travel between them. For a simple example with a one-dimensional density, see Fig. 3.2. At _T_ = 1 the target density consists of two peaks separated by a wide zero probability area. This is a case where it would be difficult to construct an efficient sampler, because to sample within the peaks the proposal needs to be narrow but to jump between the peaks it needs to be wide. When the temperature is increased, the peaks start to flatten out. At _T_ = 100 the modes have mixed into one, making the density easier to sample. 

30 

Naturally, tempering changes the target density into something else that we are not primarily interested in. The idea in parallel tempering is to sample in parallel _nT_ Markov chains at temperatures 1 = _T_ 1 _< T_ 2 _< · · · < TnT_ , so we always keep sampling the density we are interested in, but also densities in higher temperatures. Then we construct a mechanism that couples the different temperature chains together, so they can exchange information on their location in the parameter space. Chains in densities with higher temperatures can in effect tell the chains sampling the colder densities where they should move. In practice, this exchange of information is done by swapping the locations of two chains. 

## **Between-chain Metropolis update** 

Swapping the locations must preserve the distributions of the respective tempered chains, and this is achieved by once again using the Metropolis rule (3.20). This gives a general name for parallel tempering and other similar auxiliary variable methods, Metropolis-coupled Markov chain Monte Carlo, abbreviated sometimes as MCMCMC or MC[3] . 

The Metropolis acceptance ratio can be derived as follows in the between-temperature swapping case. First, let us define the inverse temperature _βi ≡_ 1/ _Ti_ , and consider the joint density of two chains, _π_ ( _**θ** i_ , _**θ** j_ ), that are at temperatures _βi_ and _βj_ : 

**==> picture [246 x 15] intentionally omitted <==**

where _**θ** i_ is the current location of the Markov chain that samples from the distribution _π_ ( _**θ** i_ ) _[β][i]_ (respectively _**θ** j_ for _π_ ( _**θ** j_ ) _[β][j]_ ). Proposing to swap the locations is equal to proposing new values ( _**θ**[′] i_[,] _**[ θ]**[′] j_[) = (] _**[θ]**[j]_[,] _**[ θ]**[i]_[)][.][Then we can write the Metropolis ratio:] 

**==> picture [289 x 31] intentionally omitted <==**

and the acceptance probability of the swap is _a_ = min(1, _Aj_ , _i_ ). Often for numerical reasons we want to deal with the logarithms of the proposal densities. In that case the Metropolis ratio simplifies to 

**==> picture [243 x 29] intentionally omitted <==**

In Bayesian inference, we often do not want to temper the whole posterior density but only the likelihood: 

**==> picture [240 x 15] intentionally omitted <==**

Then if we set _TnT_ = ∞, at the highest temperature we are sampling only the prior, which is often easy to sample. In addition, values outside the prior support we have defined as infeasible, so restricting the hottest chain to search in the prior volume is a natural limit for the space. 

The Metropolis ratio for the case (3.37) reduces to 

**==> picture [246 x 29] intentionally omitted <==**

31 

because the prior is cancelled out. In principle, swaps can be proposed between any two chains, but in practice it is enough to propose to swap adjacent chains since the swap acceptance ratio drops quickly with a growing temperature difference. 

## **Temperature ladder** 

An essential factor affecting the efficiency of parallel tempering algorithms is the number and distribution of the temperatures _T_ 1 _< T_ 2 _< · · · < TnT_ (the temperature ladder). Analogously to the MH acceptance rate issue, if the temperatures are too close to each other the distributions are nearly the same and thus almost all swaps are accepted. But there is no advantage to sampling the same distribution, so we want to spread the temperatures out. On the other hand, if the temperature difference is too big, none of the swaps are accepted and we are simulating multiple auxiliary chains for nothing. It turns out that a similar acceptance rate as the withinchain rate (23 % in the asymptotic limit) is optimal for the between-chain swaps as well [142]. Then our goal should be to first make sure the swapping rate between adjacent chains is equal for all pairs, and close to 23 %. A related topic is the maximum temperature we should use, if we do not use the tempered likelihood form (3.37) where it can be set to infinity. The higher _TnT_ is, the higher is the number of temperatures needed which increases the computational cost. However, for the sampling to be efficient _TnT_ must be high enough so that the peaks have flattened out. 

It is not possible to choose a perfectly efficient temperature ladder before starting the simulation because we do not know the type of the target distribution. A good starting point for the temperature ladder is to distribute the temperatures geometrically [49,143]. This provides a nearly constant acceptance rate for swaps in many systems. However, big changes may be still needed before the temperature ladder works optimally, and doing it by trial and error is very time-consuming. One option is to adapt the temperature values automatically during the simulation, where _T_ 1 = 1 and _TnT_ are kept constant and the rest are adapted so that the acceptance rate for between-chain swaps is equal between all temperatures. This maximises the communication efficiency between the chains. For examples on the temperature adaptation, see [51,127]. 

32 

**4 Review of thesis results** 

In this Chapter, we review the main results in publications **I** – **III** . Methods that we used to solve the forward and inverse problems in these publications were discussed in Chapters 2 and 3. We will therefore concentrate here mainly on describing the measurement setups and findings based on the parameter estimates. 

## **4.1 PUBLICATION I: CHARACTERISATION OF RIGID FRAME POROUS MATERIALS FROM IMPEDANCE TUBE MEASUREMENTS** 

In publication **I** , we studied the characterisation of air-saturated porous media using the Bayesian approach, and compared the results to a least squares method. The main contribution of the paper was to provide a robust and easy-to-use characterisation method for rigid frame materials. In particular, we computed parameter uncertainty estimates and examined correlations between the parameters. The measurements were done in a standard transmission impedance tube (see for example [52]). 

## **4.1.1 Measurement setup** 

We selected five materials, three polyurethane foams and two wools, that are commonly used, for example in sound and heat insulation applications in buildings and cars, see Fig. 4.1. Naturally, the proposed characterisation method extends beyond these materials and can be used with any air-saturated media that we can measure in an impedance tube and model as an equivalent fluid. These include glass beads, sandy soils and gravel, or even living plants [5]. The impedance tube where the samples were tested in is shown in Fig. 4.2. The sound source is on the left, the sample in the middle, and there are two microphones on both sides of the sample. The tube is closed off by a semi-anechoic ending. By sending a logarithmic sine sweep, and using the scattering matrix formalism, we measured the waves reflected and transmitted through the tested sample at frequencies 300–5800 Hz. The reflection and transmission coefficients were then converted into the equivalent density _ρ_ ˜[meas] eq and the equivalent bulk modulus _K_[˜] eq[meas] of the material. 

**==> picture [279 x 71] intentionally omitted <==**

**Figure 4.1:** Samples measured in publication **I** : (1) soft polyurethane foam, (2) acoustic foam, (3) melamine foam, (4) felt, (5) glass wool. 

33 

**==> picture [371 x 100] intentionally omitted <==**

**Figure 4.2:** The transmission impedance tube used in the measurements. 

## **4.1.2 Inversion** 

As mentioned earlier, we represented the porous materials using the JCAL model, which gives us directly the density _ρ_ ˜[model] eq and bulk modulus _K_[˜] eq[model] . We write the observation model as 

**==> picture [225 x 12] intentionally omitted <==**

where _**θ**_ = [ _φ_ , _α_ ∞, Λ, Λ _[′]_ , _k_ 0, _k[′]_ 0[]][, and] **[ y]**[ = [][ ˜] _[ρ]_[ meas] eq ( _**ω**_ ), _K_[˜] eq[meas] ( _**ω**_ )] _[T]_ . The cost functional for the least squares solution was formed as 

**==> picture [301 x 45] intentionally omitted <==**

where the weights _W_ 1 = 1/ _ρ_[2] RMS[and] _[ W]_[2][=][ 1/] _[K]_ RMS[2][are added to compensate for the] different amounts of influence the measurements of the density and bulk modulus have on the estimate of _φ_ . Note that the viscous and thermal effects are decoupled when we form the minimization problem this way, and only porosity is found in both expressions. The LS solution is then obtained as 

**==> picture [230 x 17] intentionally omitted <==**

where _D_ is the domain to which we want to restrict the parameter values. In this paper, the only restriction is to bound the values of the unknowns to physically reasonable ones, i.e. _φ ∈_ [0, 1], _α_ ∞ _∈_ [1, 10], and so on. The minimisation was carried out using the Nelder-Mead algorithm [144]. We found that with some materials the algorithm often converged to different minima depending on the initial values. To increase the chances of finding the global minimum we used a multistart approach, where the minimisation was started several times with the initial values drawn randomly around the parameter space. 

Let us now describe the construction of the prior and likelihood densities so that we can compute the Bayesian estimates. To achieve results comparable to those given by the LS solution, we use a uniform prior that provides the same physical constraints as in the LS case. We assume that the measurement is corrupted by white noise, with the covariance 

34 

**==> picture [353 x 217] intentionally omitted <==**

**Figure 4.3:** Measurements of density and bulk modulus, shown as real and imaginary parts, of two of the samples (black continuous lines), and the model prediction corresponding to the MAP estimate plotted on top (dotted lines). 

**==> picture [223 x 24] intentionally omitted <==**

where **Γ** 1 = _σ_ **e**[2] , _ρ[ρ]_ RMS[2] **[I]**[and] **[Γ]**[2][=] _[σ]_ **e**[2] , _K[K]_ RMS[2] **[I]**[.][The][quantities] _[σ]_ **[e]**[,] _[ρ]_[and] _[σ]_ **[e]**[,] _[K]_[denote][the] standard deviations of the measurement error, estimated from repeated measurements, and **I** represents an identity matrix. The posterior density can then be stated as 

**==> picture [297 x 25] intentionally omitted <==**

where **LeLe** _[T]_[=] **[Γ] e** _[−]_[1][.][We used the adaptive Metropolis algorithm to compute statistics] of the posterior. 

## **4.1.3 Results** 

The fit of the JCAL model (with the MAP estimate as the input) to measurements of the density and bulk modulus of two example materials is shown in Fig. 4.3. The largest model discrepancy is observed at the solid frame resonance frequency ( _∼_ 1 kHz for the foam and _∼_ 2 kHz for the wool), where the coupling between the air and the frame is higher and the frame vibrates in response to the acoustic excitation. The effect of this model discrepancy on the inversion is relatively small, however, because the frequency range where the resonance effects appear is narrow and the model errors exhibit symmetry around the reconstructed curves. We observed similar model fits to all measured samples (see publication **I** ). 

Figure 4.4 shows posterior summaries for the acoustic foam sample. Each subplot shows the joint marginal distributions of the estimated parameters, the one 

35 

**==> picture [371 x 368] intentionally omitted <==**

**Figure 4.4:** Marginal posterior densities of the acoustic foam sample. The red curves on the bottom and left side of each plot are the 1D marginal densities, and the contour lines indicate the 50 and 95 % regions of distribution. The dots represent a sample of the MCMC points, and _r_ is the Pearson correlation coefficient. The black cross denotes the MAP-estimate, and the red circle the LS-solution. 

dimensional marginal distributions and the MAP and LS point estimates. The two point estimates coincide very accurately, as expected, and are always found within the 50 % regions of distribution. We can observe a strong positive correlation between porosity _φ_ and the thermal characteristic length Λ _[′]_ . However, both parameters are still resolved well as shown by the narrow support of the posterior distribution. 

The posterior densities of all the foam materials showed only one mode. They were thus easy to sample and we did not encounter identifiability issues. The posterior densities of the wool samples were still mostly unimodal, but especially the thermal parameters (Λ _[′]_ and _k[′]_ 0[)][were][not][as][well][resolved][as][with][the][foams.][One] reason for this is that the wool samples showed more anisotropy, and consequently 

36 

**==> picture [279 x 124] intentionally omitted <==**

**Figure 4.5:** A schematic of the computational model. 

a larger uncertainty in the measurements, which we took into account by a larger noise variance _σ_ **e**[2] , _ρ_[and] _[σ]_ **e**[2] , _K_[.] 

## **4.2 PUBLICATION II: COMPUTATIONAL METHODS FOR ESTIMATING THE MATERIAL PARAMETERS OF POROELASTIC MEDIA** 

In the second publication we examined the estimation of the parameters of a poroelastic plate from simulated ultrasound measurements. The plate was assumed to be submerged in water so that acoustic waves can excite the frame of the material. The motivation for this study was to develop statistical inversion methods that work with the strongly non-linear poroelastic models, design a simple measurement that could be carried out in practice, and assess what kind of information can be extracted from the this kind of measurements. A numerical study is needed so that we can compare the estimates and the true parameter values to for example evaluate possible estimation biases. 

## **4.2.1 The simulation model** 

We considered a measurement setup up shown in Fig. 4.5, where Ω[[][1][]] denotes the poroelastic layer, and Ω[[][0][]] and Ω[[][2][]] are semi-infinite halfspaces of water. The measurement data we wanted to obtain were the acoustic reflection and transmission coefficients **R**[exp] and **T**[exp] , respectively. To simulate the measurements while avoiding the inverse crime [38], we used a finite-element model constructed in COMSOL Multiphysics _[⃝]_[R] software v. 5.3. We truncated the computational domain by the following boundary conditions: a plane wave radiation condition on the left side (Γ1) to create the incident plane wave, an absorbing impedance boundary condition on the right (Γ2), and a periodic Floquet condition on the top and bottom to simulate a geometry extending to infinity in the _x_ 1 direction. We considered frequencies between 100 and 400 kHz, with 5 kHz steps, and added Gaussian noise to the final measurements. The simulation was repeated for angles between 0 _[◦]_ and 45 _[◦]_ , with 5 degree steps. 

37 

**==> picture [371 x 163] intentionally omitted <==**

**Figure 4.6:** An example of the simulated noisy measurement (at normal incidence) and the fit of the plane wave Biot model. 

## **4.2.2 Inversion** 

Our goal was to estimate all parameters included in the Biot model that are related to the poroelastic plate (i.e. we assumed that the parameters of the saturating fluid are known). The real and imaginary parts of the elastic parameters were estimated separately, and we also estimated the angle of the incoming wave. The vector of all unknowns thus reads 

**==> picture [319 x 12] intentionally omitted <==**

We expressed permeability on a logarithmic scale because of the huge range of values it can take. In addition, we estimated the measurement noise level(s) simultaneously with the material parameters. We formed the measurement vector by stacking the reflection and transmission coefficients together as **y** ( _ϕ_ inc) = [ **R**[exp] ( _ϕ_ inc), **T**[exp] ( _ϕ_ inc)][T] in the same vector, and we considered inversion from one angle at a time. The measurement noise was again assumed to be additive, and the noise covariance read 

**==> picture [228 x 27] intentionally omitted <==**

where _σe_[2] _R_[and] _[σ] e_[2] _T_[are][the][noise][variances][in][the][reflection][and][transmission][mea-] surements, respectively. We can now denote the full vector of unknowns by _**θ**_[˜] = [ _**θ**_ , _σeR_ , _σeT_ ]. 

The prior was constructed using a multivariate Gaussian density, _π_ ( _**θ**_[˜] ) _∼N_ ( _**θ**_[˜] _∗_ , **Γ** ˜ _**θ**_ ), whose tails were truncated using an indicator function _B_ ( _**θ**_[˜] ): 

**==> picture [265 x 31] intentionally omitted <==**

The indicator function was used to enforce hard boundaries such as positivity or negativity constraints, as well as the physical constraint _Kb ≤ Ks_ (1 _− φ_ ) [10]. 

38 

**==> picture [297 x 266] intentionally omitted <==**

**Figure 4.7:** The marginal prior and posterior distributions of tortuosity, permeability, porosity, and the real part of the bulk modulus, estimated from measurements at normal incidence. Also shown is are the true values, the CM estimates, and the 95 % credible intervals. 

The final step in the inverse problem was to select a suitable MCMC sampler to calculate posterior statistics. We could not make the AM algorithm, used in publication **I** , work satisfactorily in the present problem, because the sampler had a tendency to get stuck in a local maximum for long periods of time, which could lead to false diagnosis of convergence if we did now know the true parameter values. A solution we found to work very well was to use parallel tempering, especially of the form (3.37) where we could set the highest temperature to infinity. Especially when the PT algorithm was combined with an adapted proposal density and adapted temperature ladder, the sampler was easily able to jump from any starting point within the prior support to sampling close to the true parameter values. 

An example of the simulated noisy measurement is shown in Fig. 4.6. The figure also shows the (noiseless) model prediction that corresponds to the CM estimate, and the posterior predictive distribution. We can observe that the measurement points are all found within the _±_ 3 standard deviations of the posterior predictive distribution, which suggests that the noise levels were estimated correctly. 

## **4.2.3 Results** 

The most interesting measurement to consider is the one at normal incidence, since it is simpler to carry out than measurements at oblique incidences. We found that many parameters can be identified from the normal incidence data, in the sense that 

39 

**==> picture [371 x 365] intentionally omitted <==**

**Figure 4.8:** The joint marginal distributions and the true values of selected parameters, estimated from measurements at normal incidence. 

the posterior variance is much smaller than the prior variance. These parameters include porosity _φ_ , tortuoisity _α_ ∞, viscous characteristic length Λ, and density of the solid _ρs_ . 

The marginal posterior distributions of some of the parameters are shown in Fig. 4.7, which also shows the marginal prior density, point estimates, and the 95 % credible intervals. An interesting observation is that while the marginal distribution of permeability _k_ 0 has a peak at the location of the true value, the distribution is highly skewed towards higher values of permeability. It seems that there is a clear lower bound for _k_ 0, but once past a certain value, changes in permeability do not show in the data any more. Apart from _k_ 0, the marginal posterior densities seem to be centred around the true parameter value, and the CM estimate tends to be very close to the truth. 

The joint marginals posterior distributions reveal more information on the parameters and their identifiability. Figure 4.8 shows the joint distributions of pa- 

40 

**==> picture [335 x 230] intentionally omitted <==**

**Figure 4.9:** Parameter estimates and 95 % credible intervals as a function of the measurement angle _ϕ_ inc. 

rameters that exhibited the most correlation. The strongest correlation is between the real parts of the bulk and the shear moduli, which are almost exactly linearly negatively correlated, and both parameters admit values from zero to way past the true values. However, the true values of the parameters are on the long and narrow support of the posterior which shows that the parameter estimates and their uncertainty bounds still contain the correct value. Another parameter that exhibits strong correlation with the elastic moduli is _α_ ∞. 

The strong correlation between _Kb_ and _N_ is a result of how the elastic moduli affect the wave speeds. The speed of the fast longitudinal wave is controlled by a linear combination of _Kb_ and _N_ (in addition to other factors such as density), whereas the only elastic modulus that controls the speed of the shear wave is _N_ . Therefore we would need both types of waves present to resolve both moduli, which we do not have at normal incidence. 

At oblique angles of measurement, the shear was is generated, and consequently we are able to estimate _Kb_ and _N_ with much better accuracy. This can be clearly seen in Fig. 4.9, which shows some of the parameter estimates, along with the estimate of the 95 % credible interval, as a function of the measurement angle. Unsurprisingly, the estimates of _Kb_ and _N_ get better as the angle increases, but also the estimate of _α_ ∞ improves with a growing angle of incidence. This may be due to the fact that _α_ ∞ is correlated with both elastic moduli at normal incidence, as Fig. 4.8 shows, and can be more accurately estimated as the estimates of the elastic moduli are more accurate. However, the accuracy of the estimates for parameters such as porosity and solid density does not change significantly with the incidence angle. 

41 

## **4.3 PUBLICATION III: ESTIMATING THE MATERIAL PARAMETERS OF POROELASTIC OBJECTS FROM ULTRASOUND MEASUREMENTS IN WATER** 

In publication **III** , we studied the applicability of the inversion method introduced in **II** to real measurements of a porous ceramic plate, a glass bonded silica, type QF-20 (Filtros Ltd., East Rochester, NY). The measurements were carried out in a water tank using focused ultrasound transducers, and in total 216 points on the plate were measured on a 80 _×_ 230 mm regular grid, with 10 mm spacing between the measurement points. There were two main reasons for doing such a comprehensive set of measurements. First, estimating the material parameters independently at two or more locations very close to each other provides a sensibility check for the results. Large sudden jumps in parameter values could indicate a problem with the inversion and/or measurement method. Secondly, the resulting numerous parameter (and uncertainty) estimates can be plotted as a map that shows the potential variability of the parameters as a function of the measurement location. This is one way to quantify the inhomogeneity of the object. 

## **4.3.1 The measurement setup** 

The frequency range of the measurements depends on the validity of the model and practical constraints for producing ultrasound in water. The effects of the Biot waves can only be seen below frequencies where scattering effects start to dominate, which we found for the studied material submerged in water to start at around 400 kHz. To produce low-frequency ultrasound, we used Panametrics V389 (Olympus Scientific Solutions Americas Inc., MA) point-focused transducers whose central frequency was 500 kHz. The usable frequency range of these transducers goes down to 200 kHz. The transducers were immersed in the water tank and connected to a computer-controlled measurement system. The porous plate was placed in the focal zone of the transducers, and the -6 dB beam diameter of a pulse/echo signal at 

**==> picture [261 x 164] intentionally omitted <==**

**Figure 4.10:** A schematic view of the measurement system and the poroelastic plate, a) reflection measurement, b) transmission measurement. The shaded zones indicate the -6 dB size of a pulse/echo signal on the surface of the plate. 

42 

400 kHz at this distance was 10 mm. The emitting transducer was excited by a spike signal, which produced a short ultrasonic pulse in water. The received signals were then recorded on a computer, and 40 pulses were averaged for each measurement to reduce the effect of random noise. 

We then computed the reflection and transmission coefficients of the plate, **R**[exp] and **T**[exp] , respectively, using the spectral ratio technique. First, the reflected and transmitted pulses are recorded using the two configurations shown in Fig. 4.10, and then a reference signal for both configurations is also recorded. For reflection, a single transducer is used in the pulse/echo mode and the reference signal is obtained by pointing the transducer upwards to the water-air interface. In the transmission configuration, two transducers are used and the reference signal is obtained in water. Finally, we take the Fourier transform to represent the measurements in the frequency domain, and use for example the Wiener deconvolution filter [145] to obtain **R**[exp] and **T**[exp] . 

## **4.3.2 Inversion** 

The inversion method used here is similar to the one introduced in publication **II** , but a few modifications were made. In **II** , we modelled the visco-elastic losses in the solid with an imaginary part that was constant with respect to frequency. However, such an approach can be shown to be slightly non-causal [78], which is why we implemented the constant _Q_ model [79] of Kjartansson to represent the losses with a causal model. To differentiate the elastic parameters from publication **II** , we denote their modulus here with a subscript of zero, like _Kb_ ,0, and the associated quality factor by _QKb_ (respectively for _Ks_ and _N_ ). 

In addition to the plate’s physical properties, we considered the measurement noise levels, thickness of the plate, and a distance mismatch term _ε R_ , as nuisance parameters that we are not primarily interested in but nevertheless improve the inversion results. The term _ε R_ is defined as the difference in the length of the signal path between the pulse/echo reflection measurement and the reference measurement, and has an effect on the phase of **R**[exp] . 

The prior was constructed using truncated normal distributions, whose mean values were selected based on information that was available from the manufacturer of the plate and other studies. The prior variance was set to be large so that a wide range of parameter values were possible. In addition to the constraints employed in **II** using the indicator function, we included a constraint 2/3 _N_ 0 _≤ Kb_ ,0 which corresponds to requiring that the Poisson’s ratio of the solid frame is positive. 

Parameter inference at each measurement location was carried out independently of the other points. 

## **4.3.3 Results** 

There is a large number of measurements and inversion results to examine, which is why we will summarise the results by showing only the point estimates and the width of their credible intervals. However, before presenting this summary let us concentrate on a randomly selected measurement location, and plot the model fit and marginal posterior distributions. This gives a more detailed view on the inversion, and lets us compare the findings in publication **II** . 

Figure 4.11 shows the measurement of **R**[exp] and **T**[exp] from one of the measured locations, along with the model prediction that is computed using the CM estimate. 

43 

**==> picture [371 x 153] intentionally omitted <==**

**Figure 4.11:** An example of typical measured reflection and transmission coefficients, and the fit of the Biot model. The shaded areas denote the one, two, and three standard deviations of the posterior predictive distribution. 

The figure also shows the posterior predictive distribution using standard deviations. Perhaps the only clearly visible systematic discrepancy between the model and measurements can be seen at low frequencies of the transmission coefficient. Elsewhere the measurement points are found within plus or minus two standard deviations, and this was a trend observed in the other measurement locations as well. 

Continuing with the same measurement location, the marginal posterior distributions of _α_ ∞, log10( _k_ 0), _φ_ , _Kb_ ,0, _N_ 0, and _ρs_ are shown in Fig. 4.12. As was the case for the estimates of the numerical study, tortuosity, porosity, and solid density are well identified in the sense that their marginal posterior distributions are narrow compared to the prior distributions. Permeability also exhibits a trend similar to that in publication **II** , where it has a definite lower bound, but can admit values up to the highest allowed value of 10 _[−]_[8] m[2] . However, as opposed to the finding of publication **II** , both _Kb_ ,0 and _N_ 0 seem to be well identified even from the normal incidence data. One clear reason for this is the condition 2/3 _N_ 0 _≤ Kb_ ,0 that was added to the prior. Indeed, the estimated values of _Kb_ ,0 _≈_ 13 GPa and _N_ 0 _≈_ 18 GPa are close to this relation, and the estimated Poisson’s ratio of the porous frame is very close to zero. In contrast, at this location the estimate for the bulk modulus of the solid is _Ks_ ,0 _≈_ 22 GPa, and the Poisson’s ratio is about 0.18. 

The effect of the prior on _Kb_ ,0 and _N_ 0 can also be seen in the joint marginal densities, shown in Fig. 4.13, where the line 2/3 _N_ 0 = _Kb_ ,0 is clearly visible. Other correlations can be seen between the solid density and the bulk and elastic moduli, as well as between tortuosity and the solid bulk modulus. However, the observed correlations are lower than in the numerical case. This may be explained by the fact that with the real measurements we have a lot more model error, and therefore the model together with the data behave in a different way. 

Let us now summarise the results in Fig. 4.14, which shows the CM and 95 % CI estimates, for selected parameters, of all 216 measurements. The estimates are plotted according to where the measurement data they are based on was taken at, and hence the images show how the parameter estimates and their uncertainties vary spatially. We can see immediately that overall the parameters show variability 

44 

**==> picture [279 x 252] intentionally omitted <==**

**Figure 4.12:** The marginal prior and posterior distributions of selected parameters. Estimated from an example measurement in the water tank. Also shown is are the CM estimates and the 95 % credible intervals. 

over the scale of the plate, but the small-scale variability from one measurement location to the next is relatively small. Only at a very small point there is a sudden jump in the estimated values (visible especially in the estimates of Λ and _α_ ∞). 

Because the inversion at each point is carried out independently of the other locations, the smooth varying of the parameters must be found in the measurement data. The smoothness in the data may be explained by two factors. The first possibility is that the resolution of the measurements is significantly lower than the spacing of the measured locations, i.e. the effective area seen by the transducers is much larger than the 10 mm pulse/echo beam diameter. If this were the case, however, we would see a low resolution in all parameters whereas now the estimates of _φ_ and _ρs_ show structures much smaller than the ones seen in _α_ ∞ and _Kb_ ,0. We can then conclude that the observed smooth variability in the parameters is a property of the object. 

Finally, Fig. 4.15 shows the spatial variability of the estimated nuisance parameters. None of the nuisance parameters can be seen to vary in the same way as the Biot parameters, which further shows that the variability in the pore parameters comes from the measured plate. Another notable observation is that the nuisance parameters can be identified accurately, as shown by the relatively narrow widths of the 95 % credible intervals. For example, the distance from the pulse/echo transducer to the plate is estimated to vary by up to 3 mm (the distance between the transducer and the water-air interface is constant in the reference measurement, so changes in _ε R_ show directly the changes in distance between the transducer and the plate), but the associated uncertainty interval for the distance estimate is less than 

45 

**==> picture [371 x 364] intentionally omitted <==**

**Figure 4.13:** The joint posterior distributions and the CM estimate of selected parameters, estimated from the water tank measurements. 

0.06 mm. The estimates of _ε R_ also show that the plate is not completely planar. In addition, the thickness of the plate can be seen to vary by almost a millimetre, with an uncertainty of less than 0.15 mm. These nuisance parameters are clearly identified independently, and accounting for them during the inversion thus improves the estimates of the Biot parameters. 

46 

**==> picture [371 x 446] intentionally omitted <==**

**Figure 4.14:** The CM and 95 % CI estimates of selected parameters at every measured location (the pixelated images), and a schematic that shows the plate and the locations inside it that were measured (denoted by the crosses). The parameter estimates were calculated separately for each measurement. Therefore, the colour of the pixels denotes the value of the of the estimated quantity, and the location of the pixels corresponds to the location where the measurement was made. 

47 

**==> picture [371 x 228] intentionally omitted <==**

**Figure 4.15:** The CM and 95 % CI estimates of the nuisance parameters. 

48 

**5 Summary and conclusions** 

In this thesis, we developed Bayesian characterisation methods for poroviscoelastic and rigid frame porous media. The motivation was to improve the reliability and repeatability of the characterisation, by considering measurement and model errors, incorporating prior information, and finally approximating the true posterior probability density of the parameters using sampling methods. In particular, our goal was to provide feasible error estimates for each unknown parameter. We considered materials that were saturated either with air or water, and tested the proposed methods with real measurement data. 

In publication **I** , we proposed a Bayesian method for the characterisation of rigid frame materials, and compared the results to a least squares (LS) estimate, and other characterisation methods. We used a standard transmission impedance tube to measure the materials’ equivalent density and bulk modulus, and the JohnsonChampoux-Allard-Lafarge (JCAL) model [69–71] to connect the measurement data to six physical parameters. The parameter inference in the Bayesian framework was then carried out using an adaptive Markov chain Monte Carlo (MCMC) technique, and a point estimate was reported in the form of the maximum a posteriori (MAP). The results showed that the measurement data carried information on all JCAL parameters, and that the MAP estimates were within a few percent of those found using the reference methods. In addition, the LS estimates were found to be nearly identical to the MAP estimates, but only if the minimisation of the cost functional was done using a multistart approach. Otherwise the LS solution often returned a local minimum. The statistical approach also showed that most parameters are identified independently, but with sometimes certain parameters may exhibit strong correlation with one another. However, the correlations were found to be different for each material, which is why it is informative to summarise the posterior using MCMC each time a new material is measured. 

Publication **II** was a numerical study in which we developed inversion methods for poroviscoelastic media, and designed an experimental setup where the characterisation could be also done in practice. To make the inversion using sampling methods possible, we needed to have a simple measurement geometry which could be modelled with fast numerical methods. For this reason, the measurement setup consisted of a flat slab of porous material submerged in a water tank. Such a setting can be considered as a layered system, and if we assume plane wave propagation, several fast methods are available to solve the equations. The porous medium was modelled using the Biot equations, with the Johnson _et al._ model [69] to account for viscous losses. The forward model was then constructed using a global matrix method, which is both a fast and stable way to solve wave propagation problems in layered media. We simulated the measurement data, which consisted of the acoustic reflection and transmission coefficients of the porous plate, with a finite-element model, and considered several angles of incidence. 

A key contribution was to construct an adaptive parallel tempering MCMC algorithm, and to demonstrate that it is a viable method to compute the parameter estimates in the considered setting. The results showed that many interesting pa- 

49 

rameters, including porosity, can be estimated from just the measurements at normal incidence, and incorporating measurements from oblique angles would not improve the estimates much. These parameters include porosity and permeability. However, if accurate information on the elastic parameters is desired, measurements at oblique angles of incidence are recommended so that the effect of the shear waves can be seen. 

In publication **III** , we implemented the experimental design from publication **II** in a water tank measurement system in the Laboratoire d’Acoustique de l’Université du Mans (LAUM), carried out extensive measurements of a porous ceramic plate, and applied the inversion method introduced in **II** to the measurements. The goal was to evaluate the method with real measurements and to estimate the possible spatial changes in the parameters. The actual measurement system consisted of focused ultrasound transducers connected to a computer-controlled positioning system, which was used to measure the reflection and transmission coefficients at several locations. However, due to the limitations of the system, we were able to make the measurements only at normal incidence. The inversion was carried out independently at each measurement location. In addition to the physical parameters of the plate, we estimated some nuisance parameters related to the measurement setup, such as the measurement noise level. 

The measured reflection and transmission coefficients were found to vary significantly from location to location, suggesting that the plate is inhomogeneous. Nevertheless, the fit of the Biot model to the measurement data was equally good for nearly every measurement, and the measurements were contained within the envelope of the posterior predictive distribution, which indicates that the employed model is a feasible one. However, we found that the residuals between the model and the measurements were not distributed exactly as white noise. This implies that there are features of the measurement system and the measured object that are not accounted for in our forward model, such as possible depth-wise inhomogeneities of the plate, errors resulting from the plane wave approximation, and attenuation due to scattering effects. Modelling errors can obviously introduce bias into the parameter estimates, but quantifying this was not pursued in this thesis. We also found that the observed model residuals were significantly smaller than the variability in the measurements between different locations of the ceramic plate. 

The inversion results for each unknown were plotted as two-dimensional graphs which showed the conditional mean (CM) estimate and the length of the associated 95 % credible interval at each measurement location. The parameter estimates were different depending on the location of the measurement, but at the same time the changes in the values were gradual and smooth. In addition, the parameters did not all vary in the same way, and in particular the pore structure parameters did not vary in the same way as the nuisance parameters, such as the plate thickness, which suggests that the observed variation is real and not an artefact of the model errors. In conclusion, the results indicate that the employed computational model can be used to feasibly estimate the parameters of viscoelastic porous media. 

Although the results of this thesis have shown that the proposed methods are a promising step towards the robust characterisation of porous materials, a lot of future work remains. For instance, throughout the thesis we assumed that we have only plane wave propagation, which can be easily justified for an impedance tube, but is only an approximation in free-field measurements. Modelling the finite, nonplanar, field of the ultrasound transducers would be an obvious improvement for the inversion, and would let us quantify possible biases the plane-wave approxima- 

50 

tion leads to in the parameter estimates. One way to model the true ultrasound field is to use element-based methods such as the finite element or the boundary element methods. This would also enable the characterisation of objects that are of irregular shape. However, modelling complex objects and acoustic fields using elementbased approaches will substantially increase the computational burden, which may quickly render the proposed MCMC method infeasible. There is clearly a need for fast computational methods that can still account for a finite-sized acoustic field. 

One possible approach to model more realistically the fields emitted by ultrasound transducers, without having to resort to full-wave solutions, is to use the superposition of harmonic plane waves. The idea is that the finite incident field is decomposed into infinite plane wave components using the Fourier transform, and then a plane wave solution in the layered media is computed for each component. Finally, to find the reflection and transmission coefficients, the responses of each plane wave component are summed together [88, 146]. The computational requirements of the plane wave decomposition approach is naturally directly proportional to the number of plane waves considered. 

Another possibility in the Bayesian framework is to construct a statistical model for the errors that are induced when we use approximate forward models, and to marginalise over them before the inversion. This is called the Bayesian approximation error (BAE) approach [35,147]. An advantage of using the BAE is that once the statistical model for the approximation errors (the discrepancies of the predictions between an approximative and a more accurate model) have been computed, we can use the fast approximative model in the inversion, while partly recovering from the errors. Applied to characterisation of porous media, we could consider a finite element model as the accurate one, and marginalise over the approximation errors when using a plane wave model. 

Solving the inverse problem using MCMC methods is, however, always going to be relatively slow. If a significantly faster, or even real-time, characterisation method is needed, we have to compute the MAP estimate which can often be obtained with only a few iterations, and use the Laplace approximation to get an estimate of the posterior covariance. 

During the thesis work, we implemented and tested numerous MCMC algorithms for the problem of poroelastic material characterisation, and found that adaptive Metropolis and parallel tempering worked efficiently. However, there are certainly other good algorithms that could work equally well or better, and new MCMC samplers are being developed all the time. While parallel tempering is one of the best ways to deal with multimodal densities, other methods such as Hamiltonian Monte Carlo [112] may be more efficient in different settings, especially if derivatives of the posterior are easily obtained. Additionally, nowadays there are many freely available MCMC software packages which can facilitate easy out-of-the-box sampling [132,148–150]. 

The measurements of the porous ceramic layer carried out during this thesis were done only at normal incidence. This was mostly a limitation of the measurement system in the water tank, which did not allow for accurate measurements of the transducer angle that would be needed for the oblique incidence measurements. Recently, LAUM has acquired a new computer-controlled measurement system which would allow these measurements. An obvious extension would therefore be to test the proposed inversion method with measurements at oblique angles, which would give more information especially on the bulk and shear moduli that were found to be correlated at normal incidence. 

51 

The inversion method should also be tested with control materials whose properties are known. The problem of obtaining such porous materials is that porous materials are inherently heterogeneous, and reliable control materials manufactured using traditional methods are therefore hard to come by. On the other hand, because the pores need to be very small for the setup and frequencies we have considered (on the order of micrometers), 3D printing such structures is only now starting to become possible. 

Another generalisation for the characterisation of porous materials would be to account for the possible macroscopic heterogeneity and anisotropy of the samples. Macroscopically heterogeneous porous materials offer, for example, more possibilities for the design of sound absorbing materials [151,152], and anisotropic materials are found in many porous structures such as fibrous sound and heat insulation materials and sediment structures, as well as acoustic metamaterials [153]. Gradually changing material profiles in one dimension have been estimated in the rigid frame case using the wave splitting and invariant imbedding techniques, with a LS minimisation approach [154]. Another possibility to model macroscopically inhomogeneous layered materials is to use the reversible jump MCMC methods [116], where the number of the layers can be another unknown. Such methods provide estimates with uncertainties for the parameters within the layers, but also include the uncertainty in the model parametrisation [155,156]. An approach for the characterisation of three-dimensional anisotropic materials has been proposed in [157]. 

52 

## **BIBLIOGRAPHY** 

- [1] J. Rouquerol, D. Avnir, C. W. Fairbridge, D. H. Everett, J. M. Haynes, N. Pernicone, J. D. F. Ramsay, K. S. W. Sing, and K. K. Unger, “Recommendations for the characterization of porous solids (Technical Report),” _Pure Appl. Chem._ **66** , 1739–1758 (1994). 

- [2] O. Coussy, _Mechanics and Physics of Porous Solids_ (John Wiley & Sons, Ltd, 2010). 

- [3] P. Bonfiglio and F. Pompoli, “Inversion problems for determining physical parameters of porous materials: Overview and comparison between different methods,” _Acta Acust. United Ac._ **99** , 341–351 (2013). 

- [4] P. Liu and G.-F. Chen, _Porous Materials_ (Elsevier, 2014). 

- [5] K. V. Horoshenkov, “A review of acoustical methods for porous material characterisation,” _Int. J. Acoust. Vib._ **22** , 92–103 (2017). 

- [6] J. Allard and N. Atalla, _Propagation of sound in porous media: modelling sound absorbing materials 2e_ (John Wiley & Sons, 2009). 

- [7] T. Cox and P. d’Antonio, _Acoustic absorbers and diffusers: theory, design and application_ (Crc Press, Boca Raton, 2016). 

- [8] M. A. Biot, “Theory of propagation of elastic waves in a fluid-saturated porous solid. I. Low-frequency range,” _J. Acoust. Soc. Am._ **28** , 168–178 (1956). 

- [9] M. A. Biot, “Theory of propagation of elastic waves in a fluid-saturated porous solid. II. Higher frequency range,” _J. Acoust. Soc. Am._ **28** , 179–191 (1956). 

- [10] M. Biot and D. Willis, “The elastic coefficients of the theory of consolidation,” _J. Appl. Mech._ **15** , 594–601 (1957). 

- [11] M. A. Biot, “Mechanics of deformation and acoustic propagation in porous media,” _J. Appl. Phys._ **33** , 1482–1498 (1962). 

- [12] M. A. Biot, “Generalized Theory of Acoustic Propagation in Porous Dissipative Media,” _J. Acoust. Soc. Am._ **34** , 1254–1264 (1962). 

- [13] T. J. Plona, “Observation of a second bulk compressional wave in a porous medium at ultrasonic frequencies,” _Appl. Phys. Lett._ **36** , 259–261 (1980). 

- [14] O. Kelder and D. M. J. Smeulders, “Observation of the Biot slow wave in water-saturated Nivelsteiner sandstone,” _Geophysics_ **62** , 1794–1796 (1997). 

- [15] Y. Atalla and R. Panneton, “Inverse acoustical characterization of open cell porous media using impedance tube measurements,” _Can. Acoust._ **33** , 11–24 (2005). 

53 

- [16] N. Sebaa, Z. E. A. Fellah, M. Fellah, W. Lauriks, and C. Depollier, “Measuring flow resistivity of porous material via acoustic reflected waves,” _J. Appl. Phys._ **98** , 084901 (2005). 

- [17] N. Sebaa, Z. E. A. Fellah, M. Fellah, E. Ogam, A. Wirgin, F. G. Mitri, C. Depollier, and W. Lauriks, “Ultrasonic characterization of human cancellous bone using the Biot theory: Inverse problem,” _J. Acoust. Soc. Am._ **120** , 1816–1824 (2006). 

- [18] Z. Fellah, F. Mitri, M. Fellah, E. Ogam, and C. Depollier, “Ultrasonic characterization of porous absorbing materials: Inverse problem,” _J. Sound Vib._ **302** , 746–759 (2007). 

- [19] E. Ogam, A. Wirgin, S. Schneider, Z. Fellah, and Y. Xu, “Recovery of elastic parameters of cellular materials by inversion of vibrational data,” _J. Sound Vib._ **313** , 525–543 (2008). 

- [20] E. Ogam, Z. Fellah, N. Sebaa, and J.-P. Groby, “Non-ambiguous recovery of Biot poroelastic parameters of cellular panels using ultrasonic waves,” _J. Sound Vib._ **330** , 1074–1090 (2011). 

- [21] Z. E. A. Fellah, M. Sadouki, M. Fellah, F. G. Mitri, E. Ogam, and C. Depollier, “Simultaneous determination of porosity, tortuosity, viscous and thermal characteristic lengths of rigid porous materials,” _J. Appl. Phys._ **114** , 204902 (2013). 

- [22] M. Sadouki, Z. E. A. Fellah, A. Berbiche, M. Fellah, F. G. Mitri, E. Ogam, and C. Depollier, “Measuring static viscous permeability of porous absorbing materials,” _J. Acoust. Soc. Am._ **135** , 3163–3171 (2014). 

- [23] T. G. Zieli´nski, “Normalized inverse characterization of sound absorbing rigid porous media,” _J. Acoust. Soc. Am._ **137** , 3232–3243 (2015). 

- [24] Y. Liu, “Inverse characterization of the frequency-dependent acoustic and elastic parameters of porous materials by surface-normal impedance method,” _J. Acoust. Soc. Am._ **140** , 2458–2468 (2016). 

- [25] J. Vanhuyse, E. Deckers, S. Jonckheere, B. Pluymers, and W. Desmet, “Global optimisation methods for poroelastic material characterisation using a clamped sample in a Kundt tube setup,” _Mech. Syst. Sig. Process._ **68-69** , 462– 478 (2016). 

- [26] K. Verdiere, R. Panneton, N. Atalla, and S. Elkoun, “Inverse Poroelastic Characterization of Open-Cell Porous Materials Using an Impedance Tube,” in _SAE Technical Paper Series_ (2017). 

- [27] L. Lei, J. Chazot, and N. Dauchez, “Inverse method for elastic properties estimation of a poroelastic material within a multilayered structure,” _Appl. Acoust._ **148** , 133–140 (2019). 

- [28] R. Panneton and X. Olny, “Acoustical determination of the parameters governing viscous dissipation in porous media,” _J. Acoust. Soc. Am._ **119** , 2027–2040 (2006). 

54 

- [29] X. Olny and R. Panneton, “Acoustical determination of the parameters governing thermal dissipation in porous media,” _J. Acoust. Soc. Am._ **123** , 814–824 (2008). 

- [30] O. Doutres, Y. Salissou, N. Atalla, and R. Panneton, “Evaluation of the acoustic and non-acoustic properties of sound absorbing materials using a threemicrophone impedance tube,” _Appl. Acoust._ **71** , 506–509 (2010). 

- [31] J.-P. Groby, E. Ogam, L. D. Ryck, N. Sebaa, and W. Lauriks, “Analytical method for the ultrasonic characterization of homogeneous rigid porous materials from transmitted and reflected coefficients,” _J. Acoust. Soc. Am._ **127** , 764–772 (2010). 

- [32] F. Pompoli, P. Bonfiglio, K. V. Horoshenkov, A. Khan, L. Jaouen, F.-X. Bécot, F. Sgard, F. Asdrubali, F. D’Alessandro, J. Hübelt, N. Atalla, C. K. Amédin, W. Lauriks, and L. Boeckx, “How reproducible is the acoustical characterization of porous media?,” _J. Acoust. Soc. Am._ **141** , 945–955 (2017). 

- [33] P. Bonfiglio, F. Pompoli, K. V. Horoshenkov, M. I. B. S. A. Rahim, L. Jaouen, J. Rodenas, F.-X. Bécot, E. Gourdon, D. Jaeger, V. Kursch, M. Tarello, N. B. Roozen, C. Glorieux, F. Ferrian, P. Leroy, F. B. Vangosa, N. Dauchez, F. Foucart, L. Lei, K. Carillo, O. Doutres, F. Sgard, R. Panneton, K. Verdiere, C. Bertolini, R. Bärn, J.-P. Groby, A. Geslain, N. Poulain, L. Rouleau, A. Guinault, H. Ahmadi, and C. Forge, “How reproducible are methods to measure the dynamic viscoelastic properties of poroelastic media?,” _J. Sound Vib._ **428** , 26–43 (2018). 

- [34] D. Calvetti and E. Somersalo, _An introduction to Bayesian scientific computing: ten lectures on subjective computing_ , Vol. 2, (Springer Science & Business Media, 2007). 

- [35] J. Kaipio and V. Kolehmainen, “Approximate marginalization over modeling errors and uncertainties in inverse problems,” _Bayesian Theory and Applications_ 644–672 (2013). 

- [36] R. Nicholson, N. Petra, and J. P. Kaipio, “Estimation of the Robin coefficient field in a Poisson problem with uncertain conductivity field,” _Inverse Prob._ **34** , 115005 (2018). 

- [37] A. Tarantola, _Inverse problem theory and methods for model parameter estimation_ , Vol. 89, (Society for Industrial and Applied Mathematics, 2005). 

- [38] J. Kaipio and E. Somersalo, _Statistical and Computational Inverse Problems_ , Vol. 160 of _Applied Mathematical Sciences_ (Springer-Verlag GmbH, 2006). 

- [39] A. Gelman, H. S. Stern, J. B. Carlin, D. B. Dunson, A. Vehtari, and D. B. Rubin, _Bayesian Data Analysis_ , 3rd ed. (Chapman and Hall/CRC, 2013), pp. 1-349. 

- [40] J. Dettmer, S. E. Dosso, and C. W. Holland, “Full wave-field reflection coefficient inversion,” _J. Acoust. Soc. Am._ **122** , 3327–3337 (2007). 

- [41] J. Dettmer, S. E. Dosso, and C. W. Holland, “Trans-dimensional geoacoustic inversion,” _J. Acoust. Soc. Am._ **128** , 3393–3405 (2010). 

- [42] C. W. Holland and J. Dettmer, “In situ sediment dispersion estimates in the presence of discrete layers and gradients,” _J. Acoust. Soc. Am._ **133** , 50–61 (2013). 

55 

- [43] C. J. Fackler, N. Xiang, and K. V. Horoshenkov, “Bayesian acoustic analysis of multilayer porous media,” _J. Acoust. Soc. Am._ **144** , 3582–3592 (2018). 

- [44] A. L. Bonomo and M. J. Isakson, “A comparison of three geoacoustic models using Bayesian inversion and selection techniques applied to wave speed and attenuation measurements,” _J. Acoust. Soc. Am._ **143** , 2501–2513 (2018). 

- [45] J.-D. Chazot, E. Zhang, and J. Antoni, “Acoustical and mechanical characterization of poroelastic materials using a Bayesian approach,” _J. Acoust. Soc. Am._ **131** , 4584–4595 (2012). 

- [46] N. Metropolis, A. W. Rosenbluth, M. N. Rosenbluth, A. H. Teller, and E. Teller, “Equation of state calculations by fast computing machines,” _J. Chem. Phys._ **21** , 1087–1092 (1953). 

- [47] W. K. Hastings, “Monte Carlo sampling methods using Markov chains and their applications,” _Biometrika_ **57** , 97–109 (1970). 

- [48] H. Haario, E. Saksman, and J. Tamminen, “An adaptive Metropolis algorithm,” _Bernoulli_ **7** , 223–242 (2001). 

- [49] D. J. Earl and M. W. Deem, “Parallel tempering: Theory, applications, and new perspectives,” _Phys. Chem. Chem. Phys._ **7** , 3910–3916 (2005). 

- [50] C. Andrieu and J. Thoms, “A tutorial on adaptive MCMC,” _Stat. Comput._ **18** , 343–373 (2008). 

- [51] W. Vousden, W. M. Farr, and I. Mandel, “Dynamic temperature selection for parallel tempering in Markov chain Monte Carlo simulations,” _Mon. Not. R. Astron. Soc._ **455** , 1919–1937 (2015). 

- [52] B. H. Song and J. S. Bolton, “A transfer-matrix approach for estimating the characteristic impedance and wave numbers of limp and rigid porous materials,” _J. Acoust. Soc. Am._ **107** , 1131–1152 (2000). 

- [53] O. Coussy, _Poromechanics_ (John Wiley & Sons, 2004). 

- [54] M. O. Saar and M. Manga, “Permeability-porosity relationship in vesicular basalts,” _Geophys. Res. Lett._ **26** , 111–114 (1999). 

- [55] G. Kirchhoff, “Ueber den Einfluss der Wärmeleitung in einem Gase auf die Schallbewegung,” _Annalen der Physik und Chemie_ **210** , 177–193 (1868). 

- [56] C. Zwikker and C. W. Kosten, _Sound absorbing materials_ (Elsevier, 1949). 

- [57] M. R. Stinson, “The propagation of plane sound waves in narrow and wide circular tubes, and generalization to uniform tubes of arbitrary cross-sectional shape,” _J. Acoust. Soc. Am._ **89** , 550–558 (1991). 

- [58] M. Delany and E. Bazley, “Acoustical properties of fibrous absorbent materials,” _Appl. Acoust._ **3** , 105–116 (1970). 

- [59] Y. Miki, “Acoustical properties of porous materials - Modifications of DelanyBazley models.,” _J. Acoust. Soc. Jpn.(E)_ **11** , 19–24 (1990). 

56 

- [60] K. Waters, J. Mobley, and J. Miller, “Causality-imposed (Kramers-Kronig) relationships between attenuation and dispersion,” _IEEE Trans. Ultrason., Ferroelectr., Freq. Control_ **52** , 822–823 (2005). 

- [61] W. Qunli, “Empirical relations between acoustical properties and flow resistivity of porous plastic open-cell foam,” _Appl. Acoust._ **25** , 141–148 (1988). 

- [62] T. Komatsu, “Improvement of the Delany-Bazley and Miki models for fibrous sound-absorbing materials,” _Acoustical science and technology_ **29** , 121–129 (2008). 

- [63] D. Oliva and V. Hongisto, “Sound absorption of porous materials – Accuracy of prediction methods,” _Appl. Acoust._ **74** , 1473–1479 (2013). 

- [64] R. Kirby, “On the modification of Delany and Bazley fomulae,” _Appl. Acoust._ **86** , 47–49 (2014). 

- [65] P. W. Jones and N. J. Kessissoglou, “Simplification of the Delany–Bazley approach for modelling the acoustic properties of a poroelastic foam,” _Appl. Acoust._ **88** , 146–152 (2015). 

- [66] D. K. Wilson, “Relaxation-matched modeling of propagation through porous media, including fractal pore structure,” _J. Acoust. Soc. Am._ **94** , 1136–1145 (1993). 

- [67] K. V. Horoshenkov, J.-P. Groby, and O. Dazel, “Asymptotic limits of some models for sound propagation in porous media and the assignment of the pore characteristic lengths,” _J. Acoust. Soc. Am._ **139** , 2463–2474 (2016). 

- [68] K. V. Horoshenkov, A. Hurrell, and J.-P. Groby, “A three-parameter analytical model for the acoustical properties of porous media,” _J. Acoust. Soc. Am._ **145** , 2512–2517 (2019). 

- [69] D. L. Johnson, J. Koplik, and R. Dashen, “Theory of dynamic permeability and tortuosity in fluid-saturated porous media,” _J. Fluid Mech._ **176** , 379 (1987). 

- [70] Y. Champoux and J.-F. Allard, “Dynamic tortuosity and bulk modulus in air-saturated porous media,” _J. Appl. Phys._ **70** , 1975–1979 (1991). 

- [71] D. Lafarge, P. Lemarinier, J. F. Allard, and V. Tarnow, “Dynamic compressibility of air in porous structures at audible frequencies,” _J. Acoust. Soc. Am._ **102** , 1995–2006 (1997). 

- [72] J. H. Schön, _Physical properties of rocks: Fundamentals and principles of petrophysics_ , Vol. 65, (Elsevier, 2015). 

- [73] T. Bourbié, O. Coussy, and B. Zinszner, _Acoustics of porous media_ (Editions Technip, Paris, 1987). 

- [74] R. Burridge and J. B. Keller, “Poroelasticity equations derived from microstructure,” _J. Acoust. Soc. Am._ **70** , 1140–1146 (1981). 

- [75] N. Atalla, R. Panneton, and P. Debergue, “A mixed displacement-pressure formulation for poroelastic materials,” _J. Acoust. Soc. Am._ **104** , 1444–1452 (1998). 

57 

- [76] O. Dazel, B. Brouard, C. Depollier, and S. Griffiths, “An alternative Biot’s displacement formulation for porous materials,” _J. Acoust. Soc. Am._ **121** , 3509 (2007). 

- [77] J. M. Carcione, _Wave fields in real media: Wave propagation in anisotropic, anelastic, porous and electromagnetic media_ , Vol. 38, (Elsevier, 2007). 

- [78] A. Turgut, “An investigation of causality for Biot models by using KramersKrönig relations,” in _Shear Waves in Marine Sediments_ (Springer, 1991), pp. 21–28. 

- [79] E. Kjartansson, “ConstantQ-wave propagation and attenuation,” _J. Geophys. Res._ **84** , 4737 (1979). 

- [80] F. Ihlenburg, _Finite element analysis of acoustic scattering_ , Vol. 132, (Springer Science & Business Media, 2006). 

- [81] O. Cessenat and B. Despres, “Application of an Ultra Weak Variational Formulation of Elliptic PDEs to the Two-Dimensional Helmholtz Problem,” _SIAM J. Numer. Anal._ **35** , 255–299 (1998). 

- [82] L. C. Wilcox, G. Stadler, C. Burstedde, and O. Ghattas, “A high-order discontinuous Galerkin method for wave propagation through coupled elastic–acoustic media,” _J. Comput. Phys._ **229** , 9373–9396 (2010). 

- [83] M. J. Lowe, “Matrix techniques for modeling ultrasonic waves in multilayered media,” _IEEE Trans. Ultrason., Ferroelectr., Freq. Control_ **42** , 525–542 (1995). 

- [84] O. Dazel, J.-P. Groby, B. Brouard, and C. Potel, “A stable method to model the acoustic response of multilayered structures,” _J. Appl. Phys._ **113** , 083506 (2013). 

- [85] G. Gautier, L. Kelders, J.-P. Groby, O. Dazel, L. De Ryck, and P. Leclaire, “Propagation of acoustic waves in a one-dimensional macroscopically inhomogeneous poroelastic material,” _J. Acoust. Soc. Am._ **130** , 1390–1398 (2011). 

- [86] W. T. Thomson, “Transmission of elastic waves through a stratified solid medium,” _J. Appl. Phys._ **21** , 89–93 (1950). 

- [87] N. A. Haskell, “The dispersion of surface waves on multilayered media,” _Bull. Seismol. Soc. Am._ **43** , 17–34 (1953). 

- [88] T. P. Pialucha, _The reflection coefficient from interface layers in NDT of adhesive joints_ , PhD thesis (University of London, 1992). 

- [89] B. Brouard, D. Lafarge, and J.-F. Allard, “A general method of modelling sound propagation in layered media,” _J. Sound Vib._ **183** , 129–142 (1995). 

- [90] L. Knopoff, “A matrix method for elastic wave problems,” _Bull. Seismol. Soc. Am._ **54** , 431–438 (1964). 

- [91] R. Chin, G. Hedstrom, and L. Thigpen, “Matrix methods in synthetic seismograms,” _Geophys. J. Int._ **77** , 483–502 (1984). 

- [92] H. Schmidt and G. Tango, “Efficient global matrix approach to the computation of synthetic seismograms,” _Geophys. J. Int._ **84** , 331–359 (1986). 

58 

- [93] A. M. Stuart, “Inverse problems: A Bayesian perspective,” _Acta Numer._ **19** , 451–559 (2010). 

- [94] J. L. Melsa and D. L. Cohn, _Decision and estimation theory_ (McGraw-Hill Education, 1978). 

- [95] C. Robert and G. Casella, _Monte Carlo statistical methods_ (Springer Science & Business Media, 1999). 

- [96] S. Brooks, A. Gelman, G. Jones, and X.-L. Meng, _Handbook of Markov chain Monte Carlo_ (CRC press, 2011). 

- [97] J. M. Flegal, M. Haran, and G. L. Jones, “Markov chain Monte Carlo: Can we trust the third significant figure?,” _Stat. Sci._ 250–260 (2008). 

- [98] D. Gamerman and H. F. Lopes, _Markov chain Monte Carlo: stochastic simulation for Bayesian inference_ (Chapman and Hall/CRC, 2006). 

- [99] D. Vats, J. M. Flegal, and G. L. Jones, “Multivariate output analysis for Markov chain Monte Carlo,” _Biometrika_ **106** , 321–337 (2019). 

- [100] A. Mood, F. Graybill, and D. Boes, _Introduction to the Theory of Statistics_ , 3 ed. (McGraw-Hill, 1974). 

- [101] H. Haario, E. Saksman, and J. Tamminen, “Adaptive proposal distribution for random walk Metropolis algorithm,” _Comput. Statist._ **14** , 375–395 (1999). 

- [102] Y. F. Atchadé, J. S. Rosenthal, et al., “On adaptive Markov chain Monte Carlo algorithms,” _Bernoulli_ **11** , 815–828 (2005). 

- [103] C. Andrieu, É. Moulines, et al., “On the ergodicity properties of some adaptive MCMC algorithms,” _Ann. Appl. Probab._ **16** , 1462–1505 (2006). 

- [104] G. O. Roberts and J. S. Rosenthal, “Coupling and Ergodicity of Adaptive Markov Chain Monte Carlo Algorithms,” _J. Appl. Probab._ **44** , 458–475 (2007). 

- [105] G. O. Roberts and J. S. Rosenthal, “Examples of Adaptive MCMC,” _J. Comput. Graph. Statist._ **18** , 349–367 (2009). 

- [106] M. Vihola, “Robust adaptive Metropolis algorithm with coerced acceptance rate,” _Stat. Comput._ **22** , 997–1008 (2011). 

- [107] G. O. Roberts and R. L. Tweedie, “Exponential Convergence of Langevin Distributions and Their Discrete Approximations,” _Bernoulli_ **2** , 341 (1996). 

- [108] G. O. Roberts and J. S. Rosenthal, “Optimal scaling of discrete approximations to Langevin diffusions,” _J. Roy. Stat. Soc. B_ **60** , 255–268 (1998). 

- [109] Y. F. Atchadé, “An Adaptive Version for the Metropolis Adjusted Langevin Algorithm with a Truncated Drift,” _Methodol. Comput. Appl. Probab._ **8** , 235–254 (2006). 

- [110] S. Duane, A. Kennedy, B. J. Pendleton, and D. Roweth, “Hybrid Monte Carlo,” _Phys. Lett. B_ **195** , 216–222 (1987). 

- [111] R. M. Neal, _Bayesian Learning for Neural Networks_ (Springer New York, 1996). 

59 

- [112] M. Girolami and B. Calderhead, “Riemann manifold Langevin and Hamiltonian Monte Carlo methods,” _J. Roy. Stat. Soc. B_ **73** , 123–214 (2011). 

- [113] M. D. Hoffman and A. Gelman, “The No-U-Turn sampler: adaptively setting path lengths in Hamiltonian Monte Carlo.,” _J. Mach. Learn. Res._ **15** , 1593–1623 (2014). 

- [114] S. Geman and D. Geman, “Stochastic Relaxation, Gibbs Distributions, and the Bayesian Restoration of Images,” _IEEE Transactions on Pattern Analysis and Machine Intelligence_ **PAMI-6** , 721–741 (1984). 

- [115] A. E. Gelfand and A. F. M. Smith, “Sampling-Based Approaches to Calculating Marginal Densities,” _J. Amer. Statist. Assoc._ **85** , 398–409 (1990). 

- [116] P. J. Green, “Reversible jump Markov chain Monte Carlo computation and Bayesian model determination,” _Biometrika_ **82** , 711–732 (1995). 

- [117] P. J. Green, “Trans-dimensional Markov chain Monte Carlo,” _Oxford Statistical Science Series_ 179–198 (2003). 

- [118] S. P. Brooks, P. Giudici, and G. O. Roberts, “Efficient construction of reversible jump Markov chain Monte Carlo proposal distributions,” _J. Roy. Stat. Soc. B_ **65** , 3–39 (2003). 

- [119] T. Bodin and M. Sambridge, “Seismic tomography with the reversible jump algorithm,” _Geophys. J. Int._ **178** , 1411–1436 (2009). 

- [120] T. Bodin, M. Sambridge, N. Rawlinson, and P. Arroucau, “Transdimensional tomography with unknown data noise,” _Geophys. J. Int._ **189** , 1536–1556 (2012). 

- [121] A. Mira et al., “On Metropolis-Hastings algorithms with delayed rejection,” _Metron_ **59** , 231–241 (2001). 

- [122] H. Haario, M. Laine, A. Mira, and E. Saksman, “DRAM: efficient adaptive MCMC,” _Stat. Comput._ **16** , 339–354 (2006). 

- [123] J. M. Bardsley, A. Solonen, H. Haario, and M. Laine, “Randomize-ThenOptimize: A Method for Sampling from Posterior Distributions in Nonlinear Inverse Problems,” _SIAM J. Sci. Comput._ **36** , A1895–A1910 (2014). 

- [124] J. M. Bardsley, A. Seppänen, A. Solonen, H. Haario, and J. Kaipio, “Randomize-Then-Optimize for Sampling and Uncertainty Quantification in Electrical Impedance Tomography,” _SIAM/ASA Journal on Uncertainty Quantification_ **3** , 1136–1158 (2015). 

- [125] R. H. Swendsen and J.-S. Wang, “Replica Monte Carlo simulation of spinglasses,” _Phys. Rev. Lett._ **57** , 2607 (1986). 

- [126] C. J. Geyer, “Markov chain Monte Carlo maximum likelihood,” in _Computing Science and Statistics: The 23rd Symposium on the Interface_ (1991), pp. 156–163. 

- [127] B. Miasojedow, E. Moulines, and M. Vihola, “An Adaptive Parallel Tempering Algorithm,” _J. Comput. Graph. Statist._ **22** , 649–664 (2013). 

60 

- [128] T. Araki and K. Ikeda, “Adaptive Markov chain Monte Carlo for auxiliary variable method and its application to parallel tempering,” _Neural Networks_ **43** , 33–40 (2013). 

- [129] M. Sambridge, “A Parallel Tempering algorithm for probabilistic sampling and multimodal optimization,” _Geophys. J. Int._ **196** , 357–374 (2013). 

- [130] J. A. Christen, C. Fox, et al., “A general purpose sampling algorithm for continuous distributions (the t-walk),” _Bayesian Anal._ **5** , 263–281 (2010). 

- [131] J. Goodman, J. Weare, et al., “Ensemble samplers with affine invariance,” _Commun. Appl. Math. Comput. Sci._ **5** , 65–80 (2010). 

- [132] D. Foreman-Mackey, D. W. Hogg, D. Lang, and J. Goodman, “emcee: The MCMC Hammer,” _Publ. Astron. Soc. Pac._ **125** , 306–312 (2013). 

- [133] I. Murray, R. Adams, and D. MacKay, “Elliptical slice sampling,” in _Proceedings of the Thirteenth International Conference on Artificial Intelligence and Statistics_ , Vol. 9, Proceedings of Machine Learning Research (2010), pp. 541–548. 

- [134] J. Martin, L. C. Wilcox, C. Burstedde, and O. Ghattas, “A Stochastic Newton MCMC Method for Large-Scale Statistical Inverse Problems with Application to Seismic Inversion,” _SIAM J. Sci. Comput._ **34** , A1460–A1487 (2012). 

- [135] N. Petra, J. Martin, G. Stadler, and O. Ghattas, “A Computational Framework for Infinite-Dimensional Bayesian Inverse Problems, Part II: Stochastic Newton MCMC with Application to Ice Sheet Flow Inverse Problems,” _SIAM J. Sci. Comput._ **36** , A1525–A1555 (2014). 

- [136] T. Cui, J. Martin, Y. M. Marzouk, A. Solonen, and A. Spantini, “Likelihoodinformed dimension reduction for nonlinear inverse problems,” _Inverse Prob._ **30** , 114015 (2014). 

- [137] P. G. Constantine, C. Kent, and T. Bui-Thanh, “Accelerating Markov Chain Monte Carlo with Active Subspaces,” _SIAM J. Sci. Comput._ **38** , A2779–A2805 (2016). 

- [138] Z. Yang and C. E. Rodriguez, “Searching for efficient Markov chain Monte Carlo proposal kernels,” _Proceedings of the National Academy of Sciences_ **110** , 19307–19312 (2013). 

- [139] A. Gelman, G. O. Roberts, W. R. Gilks, et al., “Efficient Metropolis jumping rules,” _Bayesian statistics_ **5** , 42 (1996). 

- [140] G. O. Roberts, A. Gelman, and W. R. Gilks, “Weak convergence and optimal scaling of random walk Metropolis algorithms,” _Ann. Appl. Probab._ **7** , 110–120 (1997). 

- [141] C. Andrieu and C. P. Robert, _Controlled MCMC for optimal sampling_ (INSEE, 2001). 

- [142] A. Kone and D. A. Kofke, “Selection of temperature intervals for paralleltempering simulations,” _J. Chem. Phys._ **122** , 206101 (2005). 

61 

- [143] D. A. Kofke, “On the acceptance probability of replica-exchange Monte Carlo trials,” _J. Chem. Phys._ **117** , 6911–6914 (2002). 

- [144] J. C. Lagarias, J. A. Reeds, M. H. Wright, and P. E. Wright, “Convergence Properties of the Nelder–Mead Simplex Method in Low Dimensions,” _SIAM J. Optim._ **9** , 112–147 (1998). 

- [145] C. Chen and S. Sin, “On effective spectrum-based ultrasonic deconvolution techniques for hidden flaw characterization,” _J. Acoust. Soc. Am._ **87** , 976–987 (1990). 

- [146] C. J. Vecchio, M. E. Schafer, and P. A. Lewin, “Prediction of ultrasonic field propagation through layered media using the extended angular spectrum method,” _Ultrasound Med. Biol._ **20** , 611–622 (1994). 

- [147] J. Kaipio and E. Somersalo, “Statistical inverse problems: discretization, model reduction and inverse crimes,” _J. Comput. Appl. Math._ **198** , 493–504 (2007). 

- [148] B. Carpenter, A. Gelman, M. D. Hoffman, D. Lee, B. Goodrich, M. Betancourt, M. Brubaker, J. Guo, P. Li, and A. Riddell, “Stan: A Probabilistic Programming Language,” _J. Stat. Softw._ **76** (2017). 

- [149] D. J. Lunn, A. Thomas, N. Best, and D. Spiegelhalter, “WinBUGS - A Bayesian modelling framework: Concepts, structure, and extensibility,” _Stat. Comput._ **10** , 325–337 (2000). 

- [150] J. Salvatier, T. V. Wiecki, and C. Fonnesbeck, “Probabilistic programming in Python using PyMC3,” _PeerJ Comput. Sci._ **2** , e55 (2016). 

- [151] A. Geslain, J. P. Groby, O. Dazel, S. Mahasaranon, K. V. Horoshenkov, and A. Khan, “An application of the Peano series expansion to predict sound propagation in materials with continuous pore stratification,” _J. Acoust. Soc. Am._ **132** , 208–215 (2012). 

- [152] S. Mahasaranon, K. V. Horoshenkov, A. Khan, and H. Benkreira, “The effect of continuous pore stratification on the acoustic absorption in open cell foams,” _J. Appl. Phys._ **111** , 084901 (2012). 

- [153] J. Christensen and F. J. G. de Abajo, “Anisotropic Metamaterials for Full Control of Acoustic Waves,” _Phys. Rev. Lett._ **108** (2012). 

- [154] L. D. Ryck, W. Lauriks, P. Leclaire, J. P. Groby, A. Wirgin, and C. Depollier, “Reconstruction of material properties profiles in one-dimensional macroscopically inhomogeneous rigid frame porous media in the frequency domain,” _J. Acoust. Soc. Am._ **124** , 1591–1606 (2008). 

- [155] S. E. Dosso, J. Dettmer, G. Steininger, and C. W. Holland, “Efficient transdimensional Bayesian inversion for geoacoustic profile estimation,” _Inverse Prob._ **30** , 114018 (2014). 

- [156] R. A. S. Gehrmann, J. Dettmer, K. Schwalenberg, M. Engels, S. E. Dosso, and A. Özmaral, “Trans-dimensional Bayesian inversion of controlled-source electromagnetic data in the German North Sea,” _Geophys. Prospect._ **63** , 1314–1333 (2015). 

62 

- [157] A. Terroir, L. Schwan, T. Cavalieri, V. Romero-García, G. Gabard, and J.-P. Groby, “General method to retrieve all effective acoustic properties of fullyanisotropic fluid materials in three dimensional space,” _J. Appl. Phys._ **125** , 025114 (2019). 

63