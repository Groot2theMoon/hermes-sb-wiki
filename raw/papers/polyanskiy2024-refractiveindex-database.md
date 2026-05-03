---
title: "Refractiveindex.info Database of Optical Constants"
journal: "Scientific Data, Volume 11, Article 94 (2024) — DOI: 10.1038/s41597-023-02898-2"
authors: ["Mikhail N. Polyanskiy"]
year: 2024
source: paper
ingested: 2026-05-03
sha256: 98fe292eadc777c738214c66b12392186995aed8c68c09b5dd51595f46164ccc
conversion: pymupdf4llm
---

www.nature.com/scientificdata 

**==> picture [72 x 14] intentionally omitted <==**

## **oPEN Refractiveindex.info database of optical constants** 

## **Data DEscRiPtoR** 

## **Mikhail N. Polyanskiy** 

**We introduce the** _**refractiveindex.info**_ **database, a comprehensive open-source repository containing optical constants for a wide array of materials, and describe in detail the underlying dataset. this collection, derived from a meticulous compilation of data sourced from peer-reviewed publications, manufacturers’ datasheets, and authoritative texts, aims to advance research in optics and photonics. the data is stored using a YaML-based format, ensuring integrity, consistency, and ease of access. Each record is accompanied by detailed metadata, facilitating a comprehensive understanding and efficient utilization of the data. In this descriptor, we outline the data curation protocols and the file format used for data records, and briefly demonstrate how the data can be organized in a user-friendly fashion akin to the books in a traditional library.** 

## **Background & summary** 

The complex index of refraction _n_ � = _n_ + _ik_ is essential for understanding the optical properties of materials due to its close relation with the relative permittivity _εr_ ( _εr_ = _n_ �2 in the case of non-magnetic materials[1] ). In this context, _n_ is the phase velocity ratio of light in a vacuum to that in the material, representing refraction. The extinction coefficient _k_ measures absorption. The absorption coefficient _α_ can be expressed as _α_ = 4 _πk_ / _λ_ , with _λ_ representing the light’s wavelength. 

Accurately determining both _n_ and _k_ , and their chromatic dispersion, is crucial in science, engineering, and 3D artistic rendering. The intricate design of optical instruments, particularly those minimizing aberrations, depends heavily on understanding the _n_ ( _λ_ ) function of transparent optical materials[2] . Cross-disciplinary efforts to characterize optical material properties have resulted in a wealth of datasets and analytical formulas, enhancing our grasp and utilization of optical constants. 

Initiatives to amalgamate scattered information on optical constants resulted in seminal works like Palik’s comprehensive compilation[3] , offering structured and uniformly formatted data. Though monumental, the rapid advancement of technology and research methodologies signposted the need for a more dynamic, easily accessible repository of _n_ and _k_ values. This need intensified with the emergence of high-peak-power lasers, highlighting the critical role of the nonlinear refractive index, _n_ 2, in decoding material behavior under intense light. _n_ 2 characterizes the refractive index’s variation with the optical field intensity _I_ , expressed as _n_ = _n_ 0 + _n_ 2 _I_ , where _n_ 0 is the refractive index at zero intensity. 

The _refractiveindex.info_ database emerged in response, offering a systematically organized, dynamic repository of optical constants. Since its inception in 2008, continuous enhancements have established it as a reliable resource, with the YAML-based file format ensuring data integrity and ease of access. The integration of the _n_ 2 database in 2023 reaffirms our dedication to addressing modern challenges in optics and photonics. 

The subsequent sections delve into the methods employed for collecting the data included in _refractiveindex. info_ , detailing the file format used for storing data records and our approach to verifying dataset integrity. We then highlight the application aspects of this dataset, illustrated with an example of an interactive data browser, and conclude with a statement on data availability. 

## **Methods** 

**Data source clarification.** It is pivotal to underscore that our work does not generate original experimental data. Instead, we create a comprehensive data repository, systematizing and cataloging existing optical constants published by others. This approach ensures a diverse and rich collection of verified data is readily accessible for various applications in a standardized format. As a result, this section does not describe experimental procedures but focuses on the methodologies employed in data collection and formatting. 

Brookhaven National Laboratory, Accelerator Test Facility, Upton, NY, 11973, USA. e-mail: polyanskiy@bnl.gov 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

1 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

**Data collection.** Data on the optical properties of materials is aggregated from a variety of publicly accessible and credible sources, ensuring a wide range of optical constants is represented. The systematic collection process involves categorizing the data based on the type of material, its properties, and the source of information. The entire process is mostly manual due to the large variety of data sources and presentation methods. Below, we detail the steps typically undertaken to identify sources, extract data, and convert it into a unified format used in the data records. 

1. Identification of data sources 

   - (a)  Existing data collections: The initial sources for literature containing data on optical constants were published collections, such as those included in the Handbook of Optics[4] . The publications referenced therein constituted our initial list of data sources. 

   - (b)  Cross-references from the initial list of data sources: In the next iteration, we scan for references to other publications in the sources identified in the previous step (usually, scientific papers reporting new measurements describe previous works on similar topics). 

   - (c)  Search engines: We perform a broader search for publications on optical properties of materials using tools like Google Scholar to find newer references and those that may have been missed in earlier steps. 

   - (d)  Glass makers’ catalogs: We checked the websites of glass manufacturers for catalogs of glasses they produce. These catalogs are often available in Zemax AGF format, suitable for automatic data extraction. 

   - (e)  User input: At the present maturity level of the project, most new data sources are recommended by users. Researchers often provide us with data in a format ready-to-include in the _refractiveindex.info_ dataset as soon as the data are first published. 

2. Data extraction 

   - (a)  Dispersion formula: When the linear refractive index as a function of wavelength is given as a dispersion formula, the coefficients are manually transferred to the data record. Adjustments are made if necessary to fit the formula to one of the standard forms documented in the following section. 

   - (b)  Tabulated numerical data: In cases where optical constants are presented in tabulated numerical form, the data are transferred to the data record with minimal changes required by the used format (e.g., using micrometer as the unit of wavelength and expressing internal absorption by extinction coefficient _k_ ). This process is simplified if data is in a standard table format (e.g., CSV or Microsoft Excel) in supplementary materials or directly provided by authors. For older publications, typically available as bitmap-based PDF files, text recognition options in PDF reading software prove helpful. 

   - (c)  Models: If a reference presents a model for calculating optical constants, a Python script is developed to generate a tabulated data record compatible with the required format. This script is then made publicly available to _refractiveindex.info_ users on GitHub. 

   - (d)  Graphical-only data: Occasionally, authors choose to include only graphical data in publications without numerical data. In such cases, we first attempt to contact the authors for the original data. If this is not feasible (in the case of older publications) or if there is no response, semi-automatic digitization of the plots is sometimes performed (e.g., using Engauge Digitizer software); however, this is considered a last resort due to its time-consuming and less accurate nature and is typically used only when no alternative data is available. 

   - (e)  Glass catalogs: Glass makers’ catalogs in AGF format are automatically converted into _refractiveindex. info_ data records using a dedicated Python script. 

**Data formatting and updates.** All collected data are converted into a standardized format stored in human-readable YAML files, as detailed in the following section. This approach ensures consistency and facilitates easy access and manipulation by both users and computer programs. 

Errors in converting original data to standardized data records occasionally occur and are typically reported by users. All efforts are made to implement necessary corrections promptly via regular updates of the dataset. 

## **Data Records** 

The dataset is available at _Figshare_[5] . 

**YAML-based file format for data records.** The data records employ YAML-based file format (https:// yaml.org), ensuring the data is both easily readable and maintainable. Each YAML file encompasses data related to a specific material, evaluated under defined conditions and reported in a particular publication, with a primary focus on the refractive index and extinction coefficient. 

As an illustrative example, consider a data record for SiO2 in which the refractive index _n_ is expressed through a dispersion formula. The associated YAML file is located at `data-nk/main/SiO2/Malitson.yml` and is organized as follows: 

`REFERENCES: “1) I. H. Malitson, J. Opt. Soc. Am. 55, 1205-1209 (1965)... COMMENTS: “Fused silica, 20` ° `C”` 

```
DATA:
```

`– type: formula 1 wavelength_range: 0.21 6.7` coefficients: 0 0.6961663 0.0684043 0.4079426... 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

2 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

```
SPECS:
```

`n_is_absolute: false wavelength_is_vacuum: false temperature: 20` ° `C` 

Every YAML data file primarily consists of two mandatory fields: REFERENCES and DATA. REFERENCES cite the source of the data, while DATA provides the values of the optical constants. There are also two optional fields, COMMENTS and SPECS, offering additional context and structured information respectively. 

_DATA._ In the case of a data record for linear optical constants, the DATA field can be specified as a dispersion formula, identified by a formula number, or as tabulated data sets of _n_ ( _λ_ ) and/or _k_ ( _λ_ ). For dispersion formulas, the ‘wavelength_range’ entry indicates the applicable wavelength range for the data, always expressed in micrometers. Each dispersion formula in the database is numerically identified and described as follows: 

**==> picture [383 x 389] intentionally omitted <==**

In another example, found at `data-nk/main/Si/Aspnes.yml` , _n_ ( _λ_ ) and _k_ ( _λ_ ) for Silicon (Si) are provided in tabulated numerical form: 

`DATA: - type: tabulated nk data: | 0.2066 1.010 2.909` 0.2101 1.083 2.982 `...` 

Here, the first column corresponds to the wavelength in micrometers, while the others represent the unitless refractive index _n_ and extinction coefficient _k_ . Alternatively, _n_ and _k_ can be outlined separately in two two-column entries. A data entry might also combine a dispersion formula for _n_ with numerical data for _k_ , as illustrated in the SCHOTT N-BK7 glass dataset at `data-nk/glass/schott/N-BK7.yml` : 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

3 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

`DATA: - type: formula 2` wavelength_range: 0.3 2.5 coefficients: 0 1.03961212 0.00600069867 0.231792344... `- type: tabulated k data: |` 0.300 2.8607E-06 0.310 1.3679E-06 0.320 6.6608E-07 `...` 

In _n_ 2 datasets, the data are always presented numerically. An example can be found at `data-n2/main/ SiO2/Flom.yml` . _n_ 2 is expressed in m[2] /W: 

`DATA: - type: tabulated n2 data: | 0.772 2.07e-20` 1.030 2.23e-20 1.550 2.42e-20 `SPECS: n2_method: Z-scan` pulse_duration: 280e-15 140e-15 97e-15 

It is noteworthy that for _n_ 2, information on the measurement method and pulse duration is essential for comparing data from different sources. This information is specified in the optional SPECS field. 

_COMMENTS and SPECS._ The COMMENTS field can incorporate additional information to provide context to the data, while the SPECS field presents structured data in key-value pairs, giving machine-interpretable insights into specific measurement conditions or additional properties. 

In the initial example, the SPECS entries clarify that the refractive index is not absolute and is measured relative to air, that the wavelength is gauged under atmospheric conditions rather than in vacuum, and that the data is applicable at a temperature of 20 °C. In the preceding example concerning _n_ 2, the SPECS delineate the use of the Z-scan measurement method, specifying pulse durations of 280 fs, 140 fs, and 97 fs for the corresponding data points. Furthermore, the SPECS section is adaptable to encapsulate an enhanced depth of information regarding the material, as illustrated in the forthcoming example for SCHOTT N-BK7 glass: 

```
SPECS:
```

`... thermal_dispersion: - type: “Schott formula”` coefficients: 1.86e-06 1.31e-08 −1.37e-11 4.34e-07 6.27e-10 0.17 nd: 1.5168 Vd: 64.17 glass_code: 517642.251 `glass_status: standard ... acid_resistance: 1.0` alkali_resistance: 2.3 phosphate_resistance: 2.3 

Inclusion of additional information on optical glasses makes the data records suitable for use in optical design software. 

**Notes on data records.** Adhering strictly to the syntactical rules of YAML is paramount. This adherence includes the mandatory use of spaces for indentation (tabs are prohibited) and the application of UTF-8 encoding without BOM, ensuring consistency and readability across diverse data records. While not a stringent requirement, a uniform format for similar entries, particularly references, is encouraged to optimize the user experience and enhance data interpretability. 

Unless explicitly defined, non-prefixed SI units (e.g., watts, meters, seconds) are the default to ensure unambiguous and standardized data representation and interpretation. For instance, _n_ 2 is expressed in units of m[2] /W. However, an exception exists for the wavelength, which is always specified in micrometers to comply with a general practice accepted in optical design and, in particular, to allow the direct use of published dispersion formulas that traditionally assume wavelength expressed in micrometers. 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

4 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

## **technical Validation** 

Since the described dataset[5] represents an extensive array of data compiled by the work of thousands of researchers over more than a century, we cannot verify the accuracy of every individual record. Instead, we rely on the peer-review process employed by publishers of scientific and technical journals, and on the experience and reputation of optical material manufacturers publishing their material properties. However, we make every effort to ensure the correctness of the data extraction and conversion process, as well as the consistency of the information included in the dataset. In particular, the following steps are typically involved in the process of adding a new data record. 

1. Verification and documentation of data attribution: We trace the origin of the data to the first publication where it appeared and include the corresponding information in the data record file, ensuring users can validate the origins of the data. If the original data were re-analyzed, or a combination of data from multiple sources was used in a later publication (for example, to produce a dispersion formula valid in an extended wavelength range), this fact is also documented in the REFERENCES field of the data record file. 

2. Verification of accuracy of data extraction: Several tests are used to ensure the absence of errors in the conversion process: 

   - (a) Manual number-by-number comparison: This test is routinely performed when the data is represented by a relatively small amount of numerical values, e.g., coefficients of a dispersion formula. 

   - (b) Plot comparison: We use Python scripts that automatically read YAML data record files and plot the included optical constants as a function of wavelength. Comparing these plots with those included in the original publications is a robust tool for spotting inconsistencies. 

   - (c) Looking for data abnormalities: A deviation of a data point from the general trend in the data record is usually an indication of a data extraction error. All such abnormalities are manually compared against the original data, and necessary corrections are made. 

   - (d) Cross-entry comparison: Plotting data entries for the same material from different sources on the same plot may help reveal a systematic error in a particular data record if a corresponding curve deviates from a general trend. An example of a Python-based user interface allowing for easy data comparison is given in the following section. 

3. Testing of data file adherence to the YAML standard: This is typically performed by verifying the as-expected operation of several scripts used to access the data and relying on standardized YAML processing libraries. Error or warning messages generated by these scripts indicate a problem in the data record file that must be identified and corrected. 

4. User feedback: This is our strongest defense line in assuring the integrity of the data records. The users report errors via the GitHub page of the _refractiveindex.info_ project or by directly contacting the maintainer. Each report is analyzed, and necessary corrections are promptly implemented. 

## **Usage Notes** 

The described dataset[5] is a collection of human-readable YAML files, meticulously organized for user convenience. While these files can be directly individually accessed for specific optical constants of materials, organizing them in a logically-structured way and employing computer programs for data retrieval and analysis unleashes the dataset’s comprehensive utility. The YAML format, a standardized data serialization language, ensures that the data files are easily parsable with libraries such as PyYAML for Python and libyaml for C/C++. 

The _refractiveindex.info_ database is build upon the dataset described in the previous sections and include additions aimed at simplifying the access and navigation through the data. The main addition is a descriptor defining a hierarchical structure akin to a library. In this setup, each data record is akin to a "page," housed within a "book," and all such books are systematically arranged on different "shelves." This logical structure is defined and maintained through YAML-based catalog files, that categorize each data record following the ‘library’ analogy and indicate the relative path of the corresponding data records. 

The library is defined by two catalog files: `catalog-nk.yml` for linear optical properties and `catalog-n2.yml` for nonlinear properties. Below is an excerpt from the catalog-n2.yml file, exemplifying the integration of HTML typesetting and showcasing optional entries like ‘DIVIDER’ and ‘info’. The ‘DIVIDER’ is employed to separate distinct groups of books or pages clearly, while ‘info’ links to an HTML file furnishing extra details about a particular shelf, book, or page. 

`- SHELF: main name: “MAIN - simple inorganic materials” content: - DIVIDER: “Al - Aluminates, Aluminium garnets”` - BOOK: BeAl2O4 name: “BeAl2O4 (Beryllium aluminate, chrysoberyl)” info: “main/BeAl2O4.html” `content: - PAGE: Adair` name: “Adair 1989” data: “main/BeAl2O4/Adair.yml” `...` 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

5 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

**==> picture [457 x 254] intentionally omitted <==**

**Fig. 1** The `n2explorer.py` script’s graphical user interface facilitates visual navigation through the _n_ 2 data. The `nkexplorer.py` script provides a similar interface for exploring linear optical constants. 

- BOOK: MgAl2O4 name: “MgAl2O4 (Magnesium aluminate, spinel)” info: “main/MgAl2O4.html” `content: - PAGE: Flom name: “Flom et al. 2015”` data: “main/MgAl2O4/Flom.yml” `- PAGE: Adair` name: “Adair et al. 1989” data: “main/MgAl2O4/Adair.yml” `...` 

In this schema: 

- ‘SHELF’ represents a specific category or collection of materials. 

- ‘BOOK’ denotes a particular material. 

- ‘PAGE’ entries detail individual data records associated with a material. 

- ‘DIVIDER’ assists in visually and logically separating related materials or data records, enhancing the navigation experience. 

The ‘info’ entry specifies paths to additional HTML-based information, enabling users to access in-depth insights. Each ‘PAGE’ entry is linked with a ‘data’ field, pointing to the exact location of the data record’s YAML file within the dataset. The ‘name’ entry provides a “long” name for a shelf, book, or page in HTML typesetting. Paths to the data files for the linear ( _nk_ ) and nonlinear ( _n_ 2) subsets of the database, as well as to the HTML files with additional information ( _info_ ), are relative to the `data-nk, data-n2` , and `info` directories, respectively, all located in the database’s root directory. 

It’s important to note that users can create alternative ‘catalog’ files tailored to their specific needs. For instance, a customized catalog can contain only a subset of the dataset that is relevant for a particular application or study. 

To aid users in navigating the data, two Python scripts, `nkexplorer.py` and `n2explorer.py` , are housed in the `tools` folder in the root directory of the _refractiveindex.info_ database. These utilities, boasting a QT-based graphical interface, facilitate the location and comparison of data from a variety of sources. Figure 1 displays the `n2explorer.py` interface, illustrating the visual comparison of _n2_ data for SiO2 sourced from multiple publications. 

Furthermore, users have the option to access the database through the RefractiveIndex.INFO website (https://refractiveindex.info). This online platform facilitates the browsing of data records and computations of various optical properties linked with _n_ and _k_ constants, such as Abbe numbers, reflectance, and Brewster’s angle. 

6 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

A variety of third-party scripts and web applications that harness the _refractiveindex.info_ dataset can be found, notably on GitHub. These tools offer users alternative avenues to efficiently access and employ the data. 

## **code availability** 

The dataset described here, which represents the core of the _refractiveindex.info_ database, is available at _Figshare_[5] . It presently (as of December 2023) contains 3135 data records on 605 materials in the part of the dataset corresponding to linear optical properties ( _nk_ ), and 193 records on 89 materials in the part corresponding to nonlinear optical properties ( _n_ 2). 

The code that underpins the _refractiveindex.info_ database is made accessible under the Creative Commons Zero (CC0) license (https://creativecommons.org/publicdomain/zero/1.0). This license facilitates the unrestricted use, distribution, and modification of the code, making it widely accessible for various applications. The entire codebase, including detailed documentation, is publicly available on the _refractiveindex.info-database_ GitHub project (https://github.com/polyanskiy/refractiveindex.info-database). This repository is regularly updated, ensuring it evolves to meet the ongoing needs of both the scientific and engineering sectors. For additional utility, users can explore the _refractiveindex.info-scripts_ project on GitHub (https://github.com/polyanskiy/refractiveindex.info-scripts), which offers scripts for deriving optical constants from established models and tools for converting Zemax glass catalogs to the dataset’s YAML format. 

It is essential to note that the data encapsulated within the _refractiveindex.info_ dataset is meticulously curated from publicly available sources. This includes peer-reviewed journals, authoritative books, and manufacturer datasheets, ensuring that the dataset is not only expansive but also anchored in reliability and veracity. Each data record within the dataset explicitly cites the source, offering users a pathway to delve deeper into the original data and its context. All journal papers from which data are presently used in the _refractiveindex.info_ dataset, excluding . those without a DOI identifier, are included in the following reference list[6][–][471] 

By integrating a comprehensive data collection, adopting a standard-based data file format, ensuring ongoing updates, and maintaining open access, the _refractiveindex.info_ emerges as an essential tool for researchers, engineers, and students delving into the complex world of optical constants and material properties. 

Received: 9 October 2023; Accepted: 27 December 2023; Published: xx xx xxxx 

## **References** 

1. Born, M. & Wolf, E. _Principles of optics_ (Cambridge University Press, Cambridge, 1999). 

2. Smith, W. J. _Modern Optical Engineering_ (McGraw-Hill, New York, 2007). 

3. Palik, E. D. (ed.) _Handbook of Optical Constants of Solids_ (Academic Press, San Diego, 1998). 

4. Bass, M. _et al_ . (eds). _Handbook of Optics, Volume IV: Optical Properties of Materials, Nonlinear Optics, Quantum Optics_ . (McGrawHill, New York, 2009). 

5. Polyanskiy, M. N. _refractiveindex.info_ data set. _Figshare_ , https://doi.org/10.6084/m9.figshare.c.6868000.v1 (2024). 

6. Adachi, S. Optical dispersion relations for GaP, GaAs, GaSb, InP, InAs, InSb, Al _x_ Ga1- _x_ As, and In1- _x_ Ga _x_ As _y_ P1- _y_ . _Journal of Applied Physics_ **66** , 6030–6040, https://doi.org/10.1063/1.343580 (1989). 

7. Adachi, S. Optical dispersion relations for AlSb from E=0 to 6.0 eV. _Journal of Applied Physics_ **67** , 6427–6431, https://doi. org/10.1063/1.345115 (1990). 

8. Adachi, S. & Taguchi, T. Optical properties of ZnSe. _Physical Review B_ **43** , 9569–9577, https://doi.org/10.1103/physrevb.43.9569 (1991). 

9. Adachi, S., Kimura, T. & Suzuki, N. Optical properties of CdTe: Experiment and modeling. _Journal of Applied Physics_ **74** , 3435–3441, https://doi.org/10.1063/1.354543 (1993). 

10. Adair, R., Chase, L. L. & Payne, S. A. Nonlinear refractive-index measurements of glasses using three-wave frequency mixing. _Journal of the Optical Society of America B_ **4** , 875, https://doi.org/10.1364/josab.4.000875 (1987). 

11. Adair, R., Chase, L. L. & Payne, S. A. Nonlinear refractive index of optical crystals. _Physical Review B_ **39** , 3337–3350, https://doi. org/10.1103/physrevb.39.3337 (1989). 

12. Afsar, M. N. & Hasted, J. B. Measurements of the optical constants of liquid H2O and D2O between 6 and 450 cm[−][1] . _Journal of the Optical Society of America_ **67** , 902, https://doi.org/10.1364/josa.67.000902 (1977). 

13. Aftenieva, O. _et al_ . Lasing by template-assisted self-assembled quantum dots. _Advanced Optical Materials_ **11** , https://doi. org/10.1002/adom.202202226 (2023). 

14. Aftenieva, O. _et al_ . Directional amplified photoluminescence through large-area perovskite-based metasurfaces. _ACS Nano_ **17** , 2399–2410, https://doi.org/10.1021/acsnano.2c09482 (2023). 

15. Aguilar, O., de Castro, S., Godoy, M. P. F. & Rebello Sousa Dias, M. Optoelectronic characterization of Zn1- _x_ Cd _x_ O thin films as an alternative to photonic crystals in organic solar cells. _Optical Materials Express_ **9** , 3638, https://doi.org/10.1364/ome.9.003638 (2019). 

16. Harasaki, A. & Kato, K. New data on the nonlinear optical constant, phase-matching, and optical damage of AgGaS2. _Japanese Journal of Applied Physics_ **36** , 700, https://doi.org/10.1143/jjap.36.700 (1997). 

17. Al-Kuhaili, M. Optical properties of hafnium oxide thin films and their application in energy-efficient windows. _Optical Materials_ **27** , 383–387, https://doi.org/10.1016/j.optmat.2004.04.014 (2004). 

18. Althoff, R. & Hertz, J. Measurement of the optical constants of Na and K in the range of wavelength from 2.5 to 10 μ. _Infrared Physics_ **7** , 11–16, https://doi.org/10.1016/0020-0891(67)90025-5 (1967). 

19. Amotchkina, T., Trubetskov, M., Hahner, D. & Pervak, V. Characterization of e-beam evaporated Ge, YbF3, ZnS, and LaF3 thin films for laser-oriented coatings. _Applied Optics_ **59** , A40, https://doi.org/10.1364/ao.59.000a40 (2019). 

20. Arakawa, E. T., Williams, M. W. & Inagaki, T. Optical properties of arc-evaporated carbon films between 0.6 and 3.8 eV. _Journal of Applied Physics_ **48** , 3176–3177, https://doi.org/10.1063/1.324057 (1977). 

21. Arakawa, E. T., Williams, M. W., Ashley, J. C. & Painter, L. R. The optical properties of kapton: Measurement and applications. _Journal of Applied Physics_ **52** , 3579–3582, https://doi.org/10.1063/1.329140 (1981). 

22. Arndt, D. P. _et al_ . Multiple determination of the optical constants of thin-film coating materials. _Applied Optics_ **23** , 3571, https:// doi.org/10.1364/ao.23.003571 (1984). 

23. Arosa, Y. & de la Fuente, R. Refractive index spectroscopy and material dispersion in fused silica glass. _Optics Letters_ **45** , 4268, https://doi.org/10.1364/ol.395510 (2020). 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

7 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

24. Aspnes, D. E. & Studna, A. A. Dielectric functions and optical parameters of Si, Ge, GaP, GaAs, GaSb, InP, InAs, and InSb from 1.5 to 6.0 eV. _Physical Review B_ **27** , 985–1009, https://doi.org/10.1103/physrevb.27.985 (1983). 

25. Aspnes, D. E., Kelso, S. M., Logan, R. A. & Bhat, R. Optical properties of Al _x_ Ga1- _x_ As. _Journal of Applied Physics_ **60** , 754–767, https:// doi.org/10.1063/1.337426 (1986). 

26. Bååk, T. Silicon oxynitride; a material for GRIN optics. _Applied Optics_ **21** , 1069, https://doi.org/10.1364/ao.21.001069 (1982). 

27. Börzsönyi, A., Heiner, Z., Kalashnikov, M. P., Kovács, A. P. & Osvay, K. Dispersion measurement of inert gases and gas mixtures at 800 nm. _Applied Optics_ **47** , 4856, https://doi.org/10.1364/ao.47.004856 (2008). 

28. Babar, S. & Weaver, J. H. Optical constants of cu, ag, and au revisited. _Applied Optics_ **54** , 477, https://doi.org/10.1364/ao.54.000477 (2015). 

29. Ball, J. M. _et al_ . Optical properties and limiting photocurrent of thin-film perovskite solar cells. _Energy & Environmental Science_ **8** , 602–609, https://doi.org/10.1039/c4ee03224a (2015). 

30. Barker, A. S. & Ilegems, M. Infrared lattice vibrations and free-electron dispersion in GaN. _Physical Review B_ **7** , 743–750, https:// doi.org/10.1103/physrevb.7.743 (1973). 

31. Barnes, N. P. & Piltch, M. S. Temperature-dependent Sellmeier coefficients and nonlinear optics average power limit for germanium. _Journal of the Optical Society of America_ **69** , 178, https://doi.org/10.1364/josa.69.000178 (1979). 

32. Barnes, N. P. & Gettemy, D. J. Temperature variation of the refractive indices of yttrium lithium fluoride. _Journal of the Optical Society of America_ **70** , 1244, https://doi.org/10.1364/josa.70.001244 (1980). 

33. Bassarab, V. V., Shalygin, V. A., Shakhmin, A. A., Sokolov, V. S. & Kropotov, G. I. Spectroscopy of a borosilicate crown glass in the wavelength range of 0.2 μm–15 cm. _Journal of Optics_ **25** , 065401, https://doi.org/10.1088/2040-8986/accaf9 (2023). 

34. Beadie, G., Brindza, M., Flynn, R. A., Rosenberg, A. & Shirk, J. S. Refractive index measurements of poly(methyl methacrylate) (PMMA) from 0.4—1.6 μm. _Applied Optics_ **54** , F139, https://doi.org/10.1364/ao.54.00f139 (2015). 

35. Beaini, R., Baloukas, B., Loquai, S., Klemberg-Sapieha, J. & Martinu, L. Thermochromic VO2-based smart radiator devices with ultralow refractive index cavities for increased performance. _Solar Energy Materials and Solar Cells_ **205** , 110260, https://doi. org/10.1016/j.solmat.2019.110260 (2020). 

36. Beal, A. R. & Hughes, H. P. Kramers-Kronig analysis of the reflectivity spectra of 2H-MoS2, 2H-MoSe2 and 2H-MoTe2. _Journal of Physics C: Solid State Physics_ **12** , 881–890, https://doi.org/10.1088/0022-3719/12/5/017 (1979). 

37. Beliaev, L. Y., Shkondin, E., Lavrinenko, A. V. & Takayama, O. Thickness-dependent optical properties of aluminum nitride films for mid-infrared wavelengths. _Journal of Vacuum Science & Technology A: Vacuum, Surfaces, and Films_ **39** , https://doi. org/10.1116/6.0000884 (2021). 

38. Beliaev, L. Y., Shkondin, E., Lavrinenko, A. V. & Takayama, O. Optical, structural and composition properties of silicon nitride films deposited by reactive radio-frequency sputtering, low pressure and plasma-enhanced chemical vapor deposition. _Thin Solid Films_ **763** , 139568, https://doi.org/10.1016/j.tsf.2022.139568 (2022). 

39. Beliaev, L. Y., Shkondin, E., Lavrinenko, A. V. & Takayama, O. Erratum: “Thickness-dependent optical properties of aluminum nitride films for mid-infrared wavelengths” [J. Vac. Sci. Technol. A 39, 043408 (2021)]. _Journal of Vacuum Science & Technology A_ **40** , https://doi.org/10.1116/6.0001574 (2022). 

40. Beliaev, L. Y., Shkondin, E., Lavrinenko, A. V. & Takayama, O. Optical properties of plasmonic titanium nitride thin films from ultraviolet to mid-infrared wavelengths deposited by pulsed-DC sputtering, thermal and plasma-enhanced atomic layer deposition. _Optical Materials_ **143** , 114237, https://doi.org/10.1016/j.optmat.2023.114237 (2023). 

41. Belosludtsev, A. _et al_ . Correlation between stoichiometry and properties of scandium oxide films prepared by reactive magnetron sputtering. _Applied Surface Science_ **427** , 312–318, https://doi.org/10.1016/j.apsusc.2017.08.068 (2018). 

42. Bertie, J. E., Lan, Z., Jones, R. N. & Apelblat, Y. Infrared intensities of liquids XVIII: Accurate optical constants and molar absorption coefficients between 6500 and 800 cm[−][1] of dichloromethane at 25 °C, from spectra recorded in several laboratories. _Applied Spectroscopy_ **49** , 840–851, https://doi.org/10.1366/0003702953964435 (1995). 

43. Bhar, G. C. Refractive index interpolation in phase-matching. _Applied Optics_ **15** , 305, https://doi.org/10.1364/ao.15.0305_1 (1976). 

44. Bhar, G. C. & Ghosh, G. Temperature-dependent Sellmeier coefficients and coherence lengths for some chalcopyrite crystals. _Journal of the Optical Society of America_ **69** , 730, https://doi.org/10.1364/josa.69.000730 (1979). 

45. Bideau-Mehu, A., Guern, Y., Abjean, R. & Johannin-Gilles, A. Interferometric determination of the refractive index of carbon dioxide in the ultraviolet region. _Optics Communications_ **9** , 432–434, https://doi.org/10.1016/0030-4018(73)90289-7 (1973). 

46. Bideau-Mehu, A., Guern, Y., Abjean, R. & Johannin-Gilles, A. Measurement of refractive indices of neon, argon, krypton and xenon in the 253.7—140.4 nm wavelength range. dispersion relations and estimated oscillator strengths of the resonance lines. _Journal of Quantitative Spectroscopy and Radiative Transfer_ **25** , 395–402, https://doi.org/10.1016/0022-4073(81)90057-1 (1981). 

47. Bieniewski, T. M. & Czyzak, S. J. Refractive indexes of single hexagonal ZnS and CdS crystals. _Journal of the Optical Society of America_ **53** , 496, https://doi.org/10.1364/josa.53.000496 (1963). 

48. Birkhoff, R. D., Painter, L. R. & Heller, J. M. Optical and dielectric functions of liquid glycerol from gas photoionization measurements. _The Journal of Chemical Physics_ **69** , 4185–4188, https://doi.org/10.1063/1.437098 (1978). 

49. Bliss, E. S., Speck, D. R. & Simmons, W. W. Direct interferometric measurements of the nonlinear refractive index coefficient n2 in laser materials. _Applied Physics Letters_ **25** , 728–730, https://doi.org/10.1063/1.1655378 (1974). 

50. Boidin, R., Halenkovič, T., Nazabal, V., Beneš, L. & Němec, P. Pulsed laser deposited alumina thin films. _Ceramics International_ **42** , 1177–1182, https://doi.org/10.1016/j.ceramint.2015.09.048 (2016). 

51. Bond, W. L. Measurement of the refractive indices of several crystals. _Journal of Applied Physics_ **36** , 1674–1677, https://doi. org/10.1063/1.1703106 (1965). 

52. Bond, W. L., Boyd, G. D. & Carter, H. L. Refractive indices of HgS (cinnabar) between 0.62 and 11 μ. _Journal of Applied Physics_ **38** , 4090–4091, https://doi.org/10.1063/1.1709079 (1967). 

53. Boyd, G. D., Buehler, E. & Storz, F. G. Linear and nonlinear optical properties of ZnGeP2 and CdSe. _Applied Physics Letters_ **18** , 301–304, https://doi.org/10.1063/1.1653673 (1971). 

54. Boyd, G., Kasper, H. & McFee, J. Linear and nonlinear optical properties of AgGaS2, CuGaS2, and CuInS2, and theory of the wedge technique for the measurement of nonlinear coefficients. _IEEE Journal of Quantum Electronics_ **7** , 563–573, https://doi.org/10.1109/ jqe.1971.1076588 (1971). 

55. Boyd, G., Buehler, E., Storz, F. & Wernick, J. Linear and nonlinear optical properties of ternary A[II] B[IV] C2V chalcopyrite semiconductors. _IEEE Journal of Quantum Electronics_ **8** , 419–426, https://doi.org/10.1109/jqe.1972.1076982 (1972). 

56. Boyd, G., Kasper, H., McFee, J. & Storz, F. Linear and nonlinear optical properties of some ternary selenides. _IEEE Journal of Quantum Electronics_ **8** , 900–908, https://doi.org/10.1109/jqe.1972.1076900 (1972). 

57. Brannon, J. H., Lankard, J. R., Baise, A. I., Burns, F. & Kaufman, J. Excimer laser etching of polyimide. _Journal of Applied Physics_ **58** , 2036–2043, https://doi.org/10.1063/1.336012 (1985). 

58. Brasse, Y. _et al_ . Magnetic and electric resonances in particle-to-film-coupled functional nanostructures. _ACS Applied Materials & Interfaces_ **10** , 3133–3141, https://doi.org/10.1021/acsami.7b16941 (2018). 

59. Bright, T., Watjen, J., Zhang, Z., Muratore, C. & Voevodin, A. Optical properties of HfO2 thin films deposited by magnetron sputtering: From the visible to the far-infrared. _Thin Solid Films_ **520** , 6793–6802, https://doi.org/10.1016/j.tsf.2012.07.037 (2012). 

60. Bright, T. J. _et al_ . Infrared optical properties of amorphous and nanocrystalline Ta2O5 thin films. _Journal of Applied Physics_ **114** , https://doi.org/10.1063/1.4819325 (2013). 

8 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

61. Brimhall, N. _et al_ . Measured optical constants of copper from 10 nm to 35 nm. _Optics Express_ **17** , 23873, https://doi.org/10.1364/ oe.17.023873 (2009). 

62. Bristow, A. D., Rotenberg, N. & van Driel, H. M. Two-photon absorption and kerr coefficients of silicon for 850–2200nm. _Applied Physics Letters_ **90** , https://doi.org/10.1063/1.2737359 (2007). 

63. Bucciarelli, A. _et al_ . A comparative study of the refractive index of silk protein thin films towards biomaterial based optical devices. _Optical Materials_ **78** , 407–414, https://doi.org/10.1016/j.optmat.2018.02.058 (2018). 

64. Burnett, J. H., Kaplan, S. G., Stover, E. & Phenis, A. Refractive index measurements of Ge. In LeVan, P. D., Sood, A. K., Wijewarnasuriya, P. & D’Souza, A. I. (eds.) _Infrared Sensors, Devices, and Applications VI_ , https://doi.org/10.1117/12.2237978 (SPIE, 2016). 

65. Caldwell, R. S. & Fan, H. Y. Optical properties of tellurium and selenium. _Physical Review_ **114** , 664–675, https://doi.org/10.1103/ physrev.114.664 (1959). 

66. Callcott, T. A. & Arakawa, E. T. Ultraviolet optical properties of Li. _Journal of the Optical Society of America_ **64** , 839, https://doi. org/10.1364/josa.64.000839 (1974). 

67. Carvajal, J. J. _et al_ . Structural and optical properties of RbTiOPO4:Nb crystals. _Journal of Physics: Condensed Matter_ **19** , 116214, https://doi.org/10.1088/0953-8984/19/11/116214 (2007). 

68. Chandler-Horowitz, D. & Amirtharaj, P. M. High-accuracy, midinfrared (450 cm[−][1] ≤ ω ≤ 4000 cm[−][1] ) refractive index values of silicon. _Journal of Applied Physics_ **97** , https://doi.org/10.1063/1.1923612 (2005). 

69. Chemnitz, M. _et al_ . Hybrid soliton dynamics in liquid-core fibres. _Nature Communications_ **8** , https://doi.org/10.1038/s41467-01700033-5 (2017). 

70. Chen, L. & Lynch, D. W. The optical properties of AuAl2 and PtAl2. _physica status solidi (b)_ **148** , 387–394, https://doi.org/10.1002/ pssb.2221480136 (1988). 

71. Chen, C. _et al_ . New nonlinear-optical crystal: LiB3O5. _Journal of the Optical Society of America B_ **6** , 616, https://doi.org/10.1364/ josab.6.000616 (1989). 

72. Chen, C.-W. _et al_ . Optical properties of organometal halide perovskite thin films and general device structure design rules for perovskite single and tandem solar cells. _Journal of Materials Chemistry A_ **3** , 9152–9159, https://doi.org/10.1039/c4ta05237d (2015). 

73. Cheng, F. _et al_ . Epitaxial growth of atomically smooth aluminum on silicon and its intrinsic optical properties. _ACS Nano_ **10** , 9852–9860, https://doi.org/10.1021/acsnano.6b05556 (2016). 

74. Chengchao, W., Xingcan, L., Jianyu, T. & Linhua, L. Experimental measurement of optical constant of biodiesel by double optical pathlength transmission method. _Laser & Optoelectronics Progress_ **52** , 051206, https://doi.org/10.3788/lop52.051206 (2015). 

75. Choy, M. M. & Byer, R. L. Accurate second-order susceptibility measurements of visible and infrared nonlinear crystals. _Physical Review B_ **14** , 1693–1706, https://doi.org/10.1103/physrevb.14.1693 (1976). 

76. Ciddor, P. E. Refractive index of air: new equations for the visible and near infrared. _Applied Optics_ **35** , 1566, https://doi. org/10.1364/ao.35.001566 (1996). 

77. Ciesielski, A., Skowronski, L., Trzcinski, M. & Szoplik, T. Controlling the optical parameters of self-assembled silver films with wetting layers and annealing. _Applied Surface Science_ **421** , 349–356, https://doi.org/10.1016/j.apsusc.2017.01.039 (2017). 

78. Ciesielski, A., Skowronski, L., Pacuski, W. & Szoplik, T. Permittivity of ge, te and se thin films in the 200–1500 nm spectral range. predicting the segregation effects in silver. _Materials Science in Semiconductor Processing_ **81** , 64–67, https://doi.org/10.1016/j. mssp.2018.03.003 (2018). 

79. Ciesielski, A. _et al_ . Evidence of germanium segregation in gold thin films. _Surface Science_ **674** , 73–78, https://doi.org/10.1016/j. susc.2018.03.020 (2018). 

80. Connolly, J., diBenedetto, B. & Donadio, R. Specifications of raytran material. In Fischer, R. E. (ed.) _Contemporary Optical Systems_ 

   - _and Components Specifications_ , https://doi.org/10.1117/12.957359 (SPIE, 1979). 

81. Coulter, J. K., Hass, G. & Ramsey, J. B. Optical constants and reflectance and transmittance of evaporated rhodium films in the visible. _Journal of the Optical Society of America_ **63** , 1149, https://doi.org/10.1364/josa.63.001149 (1973). 

82. Cunningham, P. D. _et al_ . Broadband terahertz characterization of the refractive index and absorption of some important polymeric and organic electro-optic materials. _Journal of Applied Physics_ **109** , 043505–043505–5, https://doi.org/10.1063/1.3549120 (2011). 

83. Cuthbertson, C. & Cuthbertson, M. On the refraction and dispersion of neon. _Proceedings of the Royal Society of London. Series A, Containing Papers of a Mathematical and Physical Character_ **83** , 149–151, https://doi.org/10.1098/rspa.1910.0001 (1910). 

84. Cuthbertson, C. & Cuthbertson, M. The refraction and dispersion of argon, and redeterminations of the dispersion of helium, neon, krypton, and xenon. _Proceedings of the Royal Society of London. Series A, Containing Papers of a Mathematical and Physical Character_ **84** , 13–15, https://doi.org/10.1098/rspa.1910.0052 (1910). 

85. Cuthbertson, C. & Cuthbertson, M. On the refraction and dispersion of the halogens, halogen acids, ozone, steam, oxides of nitrogen and ammonia. _Philosophical Transactions of the Royal Society of London. Series A, Containing Papers of a Mathematical or Physical Character_ **213** , 1–26, https://doi.org/10.1098/rsta.1914.0001 (1914). 

86. Cuthbertson, C. & Cuthbertson, M. The refraction and dispersion of neon and helium. _Proceedings of the Royal Society of London. Series A, Containing Papers of a Mathematical and Physical Character_ **135** , 40–47, https://doi.org/10.1098/rspa.1932.0019 (1932). 

87. Daimon, M. & Masumura, A. High-accuracy measurements of the refractive index and its temperature coefficient of calcium fluoride in a wide wavelength range from 138 to 2326 nm. _Applied Optics_ **41** , 5275, https://doi.org/10.1364/ao.41.005275 (2002). 

88. Daimon, M. & Masumura, A. Measurement of the refractive index of distilled water from the near-infrared region to the ultraviolet region. _Applied Optics_ **46** , 3811, https://doi.org/10.1364/ao.46.003811 (2007). 

89. Dalzell, W. H. & Sarofim, A. F. Optical constants of soot and their application to heat-flux calculations. _Journal of Heat Transfer_ **91** , 100–104, https://doi.org/10.1115/1.3580063 (1969). 

90. Das, S., Bhar, G. C., Gangopadhyay, S. & Ghosh, C. Linear and nonlinear optical properties of ZnGeP2 crystal for infrared laser device applications: revisited. _Applied Optics_ **42** , 4335, https://doi.org/10.1364/ao.42.004335 (2003). 

91. David, M. _et al_ . Structure and mid-infrared optical properties of spin-coated polyethylene films developed for integrated photonics applications. _Optical Materials Express_ **12** , 2168, https://doi.org/10.1364/ome.458667 (2022). 

92. DeBell, A. G. _et al_ . Cryogenic refractive indices and temperature coefficients of cadmium telluride from 6 μm to 22 μm. _Applied Optics_ **18** , 3114, https://doi.org/10.1364/ao.18.003114 (1979). 

93. DeSalvo, R., Said, A., Hagan, D., Van Stryland, E. & Sheik-Bahae, M. Infrared to ultraviolet measurements of two-photon absorption and n2 in wide bandgap solids. _IEEE Journal of Quantum Electronics_ **32** , 1324–1333, https://doi.org/10.1109/3.511545 (1996). 

94. DeVore, J. R. Refractive indices of rutile and sphalerite. _Journal of the Optical Society of America_ **41** , 416, https://doi.org/10.1364/ josa.41.000416 (1951). 

95. Debenham, M. Refractive indices of zinc sulfide in the 0.405–13-μm wavelength range. _Applied Optics_ **23** , 2238, https://doi. org/10.1364/ao.23.002238 (1984). 

96. Djurišić, A. B. & Li, E. H. Optical properties of graphite. _Journal of Applied Physics_ **85** , 7404–7410, https://doi.org/10.1063/1.369370 (1999). 

97. Djurišić, A., Li, E., Rakić, D. & Majewski, M. Modeling the optical properties of AlSb, GaSb, and InSb. _Applied Physics A: Materials Science & Processing_ **70** , 29–32, https://doi.org/10.1007/s003390050006 (2000). 

98. Dodge, M. J. Refractive properties of magnesium fluoride. _Applied Optics_ **23** , 1980, https://doi.org/10.1364/ao.23.001980 (1984). 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

9 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

99. Dore, P. _et al_ . Infrared properties of chemical-vapor deposition polycrystalline diamond windows. _Applied Optics_ **37** , 5731, https:// doi.org/10.1364/ao.37.005731 (1998). 

100. Edwards, D. F. & Ochoa, E. Infrared refractive index of silicon. _Applied Optics_ **19** , 4130, https://doi.org/10.1364/ao.19.004130 (1980). 

101. Eimerl, D., Davis, L., Velsko, S., Graham, E. K. & Zalkin, A. Optical, mechanical, and thermal properties of barium borate. _Journal of Applied Physics_ **62** , 1968–1983, https://doi.org/10.1063/1.339536 (1987). 

102. El-Kashef, H. The necessary requirements imposed on polar dielectric laser dye solvents. _Physica B: Condensed Matter_ **279** , 295–301, https://doi.org/10.1016/s0921-4526(99)00856-x (2000). 

103. Ensley, T. R. & Bambha, N. K. Ultrafast nonlinear refraction measurements of infrared transmitting materials in the mid-wave infrared. _Optics Express_ **27** , 37940, https://doi.org/10.1364/oe.380702 (2019). 

104. Ermolaev, G. A., Yakubovsky, D. I., Stebunov, Y. V., Arsenin, A. V. & Volkov, V. S. Spectral ellipsometry of monolayer transition metal dichalcogenides: Analysis of excitonic peaks in dispersion. _Journal of Vacuum Science & Technology B, Nanotechnology and Microelectronics: Materials, Processing, Measurement, and Phenomena_ **38** , https://doi.org/10.1116/1.5122683 (2019). 

105. Ermolaev, G. A. _et al_ . Broadband optical properties of monolayer and bulk MoS2. _npj 2D Materials and Applications_ **4** , https://doi. org/10.1038/s41699-020-0155-x (2020). 

106. Ermolaev, G. A. _et al_ . Express determination of thickness and dielectric function of single-walled carbon nanotube films. _Applied Physics Letters_ **116** , https://doi.org/10.1063/5.0012933 (2020). 

107. Ermolaev, G. A. _et al_ . Broadband optical properties of atomically thin PtS2 and PtSe2. _Nanomaterials_ **11** , 3269, https://doi. org/10.3390/nano11123269 (2021). 

108. Ermolaev, G. A. _et al_ . Broadband optical constants and nonlinear properties of SnS2 and SnSe2. _Nanomaterials_ **12** , 141, https://doi. org/10.3390/nano12010141 (2021). 

109. Ermolaev, G. A. _et al_ . Giant optical anisotropy in transition metal dichalcogenides for next-generation photonics. _Nature Communications_ **12** , https://doi.org/10.1038/s41467-021-21139-x (2021). 

110. Ermolaev, G. A. _et al_ . Spectroscopic ellipsometry of large area monolayer WS2 and WSe2 films. In _AIP Conference Proceedings_ , https://doi.org/10.1063/5.0054947 (AIP Publishing, 2021). 

111. Ermolaev, G. _et al_ . Topological phase singularities in atomically thin high-refractive-index materials. _Nature Communications_ **13** , https://doi.org/10.1038/s41467-022-29716-4 (2022). 

112. Ermolaev, G. _et al_ . Giant and tunable excitonic optical anisotropy in single-crystal halide perovskites. _Nano Letters_ **23** , 2570–2577, https://doi.org/10.1021/acs.nanolett.2c04792 (2023). 

113. Ermolaev, G. A. _et al_ . Anisotropic optical properties of monolayer aligned single-walled carbon nanotubes. _physica status solidi (RRL) – Rapid Research Letters_ 2300199, https://doi.org/10.1002/pssr.202300199 (2023). 

114. Ermolov, A., Mak, K. F., Frosz, M. H., Travers, J. C. & Russell, P. S. J. Supercontinuum generation in the vacuum ultraviolet through dispersive-wave and soliton-plasma interaction in a noble-gas-filled hollow-core photonic crystal fiber. _Physical Review A_ **92** , https://doi.org/10.1103/physreva.92.033821 (2015). 

115. Ewbank, M. D. _et al_ . The temperature dependence of optical and mechanical properties of Tl3AsSe3. _Journal of Applied Physics_ **51** , 3848–3852, https://doi.org/10.1063/1.328128 (1980). 

116. Fang, S., Liu, H., Huang, L. & Ye, N. Growth and optical properties of nonlinear LuAl3(BO3)4 crystals. _Optics Express_ **21** , 16415, https://doi.org/10.1364/oe.21.016415 (2013). 

117. Fang, M. _et al_ . Layer-dependent dielectric permittivity of topological insulator Bi2Se3 thin films. _Applied Surface Science_ **509** , 144822, https://doi.org/10.1016/j.apsusc.2019.144822 (2020). 

118. Feldman, A. & Horowitz, D. Refractive index of cuprous chloride*. _Journal of the Optical Society of America_ **59** , 1406, https://doi. org/10.1364/josa.59.001406 (1969). 

119. Fern, R. E. & Onton, A. Refractive index of AlAs. _Journal of Applied Physics_ **42** , 3499–3500, https://doi.org/10.1063/1.1660760 (1971). 

120. Fernández-Perea, M. _et al_ . Determination of optical constants of scandium films in the 20–1000 eV range. _Journal of the Optical Society of America A_ **23** , 2880, https://doi.org/10.1364/josaa.23.002880 (2006). 

121. Fernández-Perea, M. _et al_ . Optical constants of electron-beam evaporated boron films in the 6.8–900 eV photon energy range. _Journal of the Optical Society of America A_ **24** , 3800, https://doi.org/10.1364/josaa.24.003800 (2007). 

122. Fernández-Perea, M. _et al_ . Optical constants of Yb films in the 23–1700 eV range. _Journal of the Optical Society of America A_ **24** , 3691, https://doi.org/10.1364/josaa.24.003691 (2007). 

123. Fernández-Perea, M. _et al_ . Transmittance and optical constants of Pr films in the 4–1600ev spectral range. _Journal of Applied Physics_ **103** , https://doi.org/10.1063/1.2939269 (2008). 

124. Fernández-Perea, M. _et al_ . Transmittance and optical constants of Eu films from 8.3 to 1400 eV. _Journal of Applied Physics_ **104** , https://doi.org/10.1063/1.2982391 (2008). 

125. Fernández-Perea, M. _et al_ . Transmittance and optical constants of Ce films in the 6–1200ev spectral range. _Journal of Applied Physics_ **103** , https://doi.org/10.1063/1.2901137 (2008). 

126. Fernández-Perea, M. _et al_ . Optical constants of evaporation-deposited silicon monoxide films in the 7.1–800 eV photon energy range. _Journal of Applied Physics_ **105** , https://doi.org/10.1063/1.3123768 (2009). 

127. Fernández-Perea, M. _et al_ . Transmittance and optical constants of Ho films in the 3–1340 eV spectral range. _Journal of Applied Physics_ **109** , https://doi.org/10.1063/1.3556451 (2011). 

128. Ferrera, M., Magnozzi, M., Bisio, F. & Canepa, M. Temperature-dependent permittivity of silver and implications for thermoplasmonics. _Physical Review Materials_ **3** , https://doi.org/10.1103/physrevmaterials.3.105201 (2019). 

129. Ferrini, R., Patrini, M. & Franchi, S. Optical functions from 0.02 to 6 eV of Al _x_ Ga1- _x_ Sb/GaSb epitaxial layers. _Journal of Applied Physics_ **84** , 4517–4524, https://doi.org/10.1063/1.368677 (1998). 

130. Fischer, M. P. _et al_ . Coherent field transients below 15 THz from phase-matched difference frequency generation in 4H-SiC. _Optics Letters_ **42** , 2687, https://doi.org/10.1364/ol.42.002687 (2017). 

131. Fleming, J. W. Dispersion in GeO2-SiO2 glasses. _Applied Optics_ **23** , 4486, https://doi.org/10.1364/ao.23.004486 (1984). 

132. Flom, S. R., Beadie, G., Bayya, S. S., Shaw, B. & Auxier, J. M. Ultrafast z-scan measurements of nonlinear optical constants of window materials at 772, 1030, and 1550 nm. _Applied Optics_ **54** , F123, https://doi.org/10.1364/ao.54.00f123 (2015). 

133. Franta, D., Nečas, D. & Ohlídal, I. Universal dispersion model for characterization of optical thin films over a wide spectral range: application to hafnia. _Applied Optics_ **54** , 9108, https://doi.org/10.1364/ao.54.009108 (2015). 

134. French, R. H. _et al_ . Optical properties of materials for concentrator photovoltaic systems. In _2009 34th IEEE Photovoltaic Specialists Conference (PVSC)_ , https://doi.org/10.1109/pvsc.2009.5411657 (IEEE, 2009). 

135. Frisenda, R. _et al_ . Characterization of highly crystalline lead iodide nanosheets prepared by room-temperature solution processing. _Nanotechnology_ **28** , 455703, https://doi.org/10.1088/1361-6528/aa8e5c (2017). 

136. Fujii, Y. & Sakudo, T. Dielectric and optical properties of KTaO3. _Journal of the Physical Society of Japan_ **41** , 888–893, https://doi. org/10.1143/jpsj.41.888 (1976). 

137. Gan, F. Optical properties of fluoride glasses: a review. _Journal of Non-Crystalline Solids_ **184** , 9–20, https://doi.org/10.1016/00223093(94)00592-3 (1995). 

138. Gant, P. _et al_ . Optical contrast and refractive index of natural van der waals heterostructure nanosheets of franckeite. _Beilstein Journal of Nanotechnology_ **8** , 2357–2362, https://doi.org/10.3762/bjnano.8.235 (2017). 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

10 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

139. Gao, L., Lemarchand, F. & Lequime, M. Comparison of different dispersion models for single layer optical thin film index determination. _Thin Solid Films_ **520** , 501–509, https://doi.org/10.1016/j.tsf.2011.07.028 (2011). 

140. Gao, L., Lemarchand, F. & Lequime, M. Exploitation of multiple incidences spectrometric measurements for thin film reverse engineering. _Optics Express_ **20** , 15734, https://doi.org/10.1364/oe.20.015734 (2012). 

141. Gao, L., Lemarchand, F. & Lequime, M. Refractive index determination of SiO2 layer in the UV/Vis/NIR range: spectrophotometric reverse engineering on single and bi-layer designs. _Journal of the European Optical Society: Rapid Publications_ **8** , https://doi. org/10.2971/jeos.2013.13010 (2013). 

142. García-Cortés, S. _et al_ . Transmittance and optical constants of Lu films in the 3–1800 eV spectral range. _Journal of Applied Physics_ **108** , https://doi.org/10.1063/1.3481062 (2010). 

143. Geints, Y. E. _et al_ . Kerr-driven nonlinear refractive index of air at 800 and 400 nm measured through femtosecond laser pulse filamentation. _Applied Physics Letters_ **99** , https://doi.org/10.1063/1.3657774 (2011). 

144. Ghosal, S., Ebert, J. L. & Self, S. A. The infrared refractive indices of CHBr3, CCl4 and CS2. _Infrared Physics_ **34** , 621–628, https://doi. org/10.1016/0020-0891(93)90120-v (1993). 

145. Ghosh, G. Dispersion-equation coefficients for the refractive index and birefringence of calcite and quartz crystals. _Optics Communications_ **163** , 95–102, https://doi.org/10.1016/s0030-4018(99)00091-7 (1999). 

146. Giannios, P. _et al_ . Complex refractive index of normal and malignant human colorectal tissue in the visible and near-infrared. _Journal of Biophotonics_ **10** , 303–310, https://doi.org/10.1002/jbio.201600001 (2016). 

147. Giannios, P. _et al_ . Visible to near-infrared refractive properties of freshly-excised human-liver tissues: marking hepatic malignancies. _Scientific Reports_ **6** , https://doi.org/10.1038/srep27910 (2016). 

148. Gomez, M. S., Guerra, J. M. & Vilches, F. Weighted nonlinear regression analysis of a Sellmeier expansion: comparison of several nonlinear fits of CdS dispersion. _Applied Optics_ **24** , 1147, https://doi.org/10.1364/ao.24.001147 (1985). 

149. Grace, E., Butcher, A., Monroe, J. & Nikkel, J. A. Index of refraction, Rayleigh scattering length, and Sellmeier coefficients in solid and liquid argon and xenon. _Nuclear Instruments and Methods in Physics Research Section A: Accelerators, Spectrometers, Detectors and Associated Equipment_ **867** , 204–208, https://doi.org/10.1016/j.nima.2017.06.031 (2017). 

150. Green, M. A. & Keevers, M. J. Optical properties of intrinsic silicon at 300 K. _Progress in Photovoltaics: Research and Applications_ **3** , 189–192, https://doi.org/10.1002/pip.4670030303 (1995). 

151. Green, M. A. Self-consistent optical parameters of intrinsic silicon at 300 K including temperature coefficients. _Solar Energy Materials and Solar Cells_ **92** , 1305–1310, https://doi.org/10.1016/j.solmat.2008.06.009 (2008). 

152. Griesmann, U. & Burnett, J. H. Refractivity of nitrogen gas in the vacuum ultraviolet. _Optics Letters_ **24** , 1699, https://doi. org/10.1364/ol.24.001699 (1999). 

153. Grudinin, D. V. _et al_ . Hexagonal boron nitride nanophotonics: a record-breaking material for the ultraviolet and visible spectral ranges. _Materials Horizons_ **10** , 2427–2435, https://doi.org/10.1039/d3mh00215b (2023). 

154. Gu, H. _et al_ . Layer-dependent dielectric and optical properties of centimeter-scale 2D WSe2: evolution from a single layer to few layers. _Nanoscale_ **11** , 22762–22771, https://doi.org/10.1039/c9nr04270a (2019). 

155. Guo, Z. _et al_ . Complete dielectric tensor and giant optical anisotropy in quasi-one-dimensional ZrTe5. _ACS Materials Letters_ **3** , 525–534, https://doi.org/10.1021/acsmaterialslett.1c00026 (2021). 

156. Guo, Z., Gu, H., Fang, M., Ye, L. & Liu, S. Giant in-plane optical and electronic anisotropy of tellurene: a quantitative exploration. _Nanoscale_ **14** , 12238–12246, https://doi.org/10.1039/d2nr03226k (2022). 

157. Guo, Z., Gu, H., Yu, Y., Wei, Z. & Liu, S. Broadband and incident-angle-modulation near-infrared polarizers based on optically anisotropic SnSe. _Nanomaterials_ **13** , 134, https://doi.org/10.3390/nano13010134 (2022). 

158. Gupta, V. _et al_ . Mechanotunable surface lattice resonances in the visible optical range by soft lithography templates and directed self-assembly. _ACS Applied Materials & Interfaces_ **11** , 28189–28196, https://doi.org/10.1021/acsami.9b08871 (2019). 

159. Gupta, V. _et al_ . Advanced colloidal sensors enabled by an out-of-plane lattice resonance. _Advanced Photonics Research_ **3** , https:// doi.org/10.1002/adpr.202200152 (2022). 

160. Hagemann, H.-J., Gudat, W. & Kunz, C. Optical constants from the far infrared to the x-ray region: Mg, Al, Cu, Ag, Au, Bi, C, and Al2O3. _Journal of the Optical Society of America_ **65** , 742, https://doi.org/10.1364/josa.65.000742 (1975). 

161. Hale, G. M. & Querry, M. R. Optical constants of water in the 200-nm to 200-μm wavelength region. _Applied Optics_ **12** , 555, https:// doi.org/10.1364/ao.12.000555 (1973). 

162. Hanson, F. & Dick, D. Blue parametric generation from temperature-tuned LiB3O5. _Optics Letters_ **16** , 205, https://doi.org/10.1364/ ol.16.000205 (1991). 

163. Hartnett, T., Bernstein, S., Maguire, E. & Tustison, R. Optical properties of ALON (aluminum oxynitride). _Infrared Physics & Technology_ **39** , 203–211, https://doi.org/10.1016/s1350-4495(98)00007-3 (1998). 

164. Hass, G. & Salzberg, C. D. Optical properties of silicon monoxide in the wavelength region from 0.24 to 14.0 microns. _Journal of the Optical Society of America_ **44** , 181, https://doi.org/10.1364/josa.44.000181 (1954). 

165. Hass, G., Jacobus, G. F. & Hunter, W. R. Optical properties of evaporated iridium in the vacuum ultraviolet from 500 Å to 2000 Å. _Journal of the Optical Society of America_ **57** , 758, https://doi.org/10.1364/josa.57.000758 (1967). 

166. Heitmann, W. & Ritter, E. Production and properties of vacuum evaporated films of thorium fluoride. _Applied Optics_ **7** , 307, https:// doi.org/10.1364/ao.7.000307 (1968). 

167. Herguedas, N. & Carretero, E. Optical properties in mid-infrared range of silicon oxide thin films with different stoichiometries. _Nanomaterials_ **13** , 2749, https://doi.org/10.3390/nano13202749 (2023). 

168. Horcholle, B. _et al_ . Growth and study of Tb[3][+] doped Nb2O5 thin films by radiofrequency magnetron sputtering: Photoluminescence properties. _Applied Surface Science_ **597** , 153711, https://doi.org/10.1016/j.apsusc.2022.153711 (2022). 

169. Hrabovský, J., Kučera, M., Paloušová, L., Bi, L. & Veis, M. Optical characterization of Y3Al5O12 and Lu3Al5O12 single crystals. _Optical Materials Express_ **11** , 1218, https://doi.org/10.1364/ome.417670 (2021). 

170. Hsu, C. _et al_ . Thickness-dependent refractive index of 1L, 2L, and 3L MoS2, MoSe2, WS2, and WSe2. _Advanced Optical Materials_ **7** , https://doi.org/10.1002/adom.201900239 (2019). 

171. Hulme, K. F., Jones, O., Davies, P. H. & Hobden, M. V. Synthetic proustite (Ag3AsS3): A new crystal for optical mixing. _Applied Physics Letters_ **10** , 133–135, https://doi.org/10.1063/1.1754880 (1967). 

172. Hurlbut, W. C., Lee, Y.-S., Vodopyanov, K. L., Kuo, P. S. & Fejer, M. M. Multiphoton absorption and nonlinear refraction of GaAs in the mid-infrared. _Optics Letters_ **32** , 668, https://doi.org/10.1364/ol.32.000668 (2007). 

173. Iezzi, B. _et al_ . Electrohydrodynamic jet printing of 1D photonic crystals: Part II–optical design and reflectance characteristics. _Advanced Materials Technologies_ **5** , https://doi.org/10.1002/admt.202000431 (2020). 

174. Inagaki, T., Hamm, R. N., Arakawa, E. T. & Painter, L. R. Optical and dielectric properties of DNA in the extreme ultraviolet. _The Journal of Chemical Physics_ **61** , 4246–4250, https://doi.org/10.1063/1.1681724 (1974). 

175. Inagaki, T., Arakawa, E. T., Birkhoff, R. D. & Williams, M. W. Optical properties of liquid Na between 0.6 and 3.8 eV. _Physical Review B_ **13** , 5610–5612, https://doi.org/10.1103/physrevb.13.5610 (1976). 

176. Inagaki, T., Emerson, L. C., Arakawa, E. T. & Williams, M. W. Optical properties of solid Na and Li between 0.6 and 3.8 eV. _Physical Review B_ **13** , 2305–2313, https://doi.org/10.1103/physrevb.13.2305 (1976). 

177. Inagaki, T., Arakawa, E. T. & Williams, M. W. Optical properties of liquid mercury. _Physical Review B_ **23** , 5246–5262, https://doi. org/10.1103/physrevb.23.5246 (1981). 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

11 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

178. Ishteev, A. _et al_ . Investigation of structural and optical properties of MAPbBr3 monocrystals under fast electron irradiation. _Journal of Materials Chemistry C_ **10** , 5821–5828, https://doi.org/10.1039/d2tc00128d (2022). 

179. Islam, K. M. _et al_ . In-plane and out-of-plane optical properties of monolayer, few-layer, and thin-film MoS2 from 190 to 1700 nm and their application in photonic device design. _Advanced Photonics Research_ **2** , https://doi.org/10.1002/adpr.202000180 (2021). 

180. Ives, H. E. & Briggs, H. B. The optical constants of potassium. _Journal of the Optical Society of America_ **26** , 238, https://doi. org/10.1364/josa.26.000238 (1936). 

181. Ives, H. E. & Briggs, H. B. Optical constants of rubidium and cesium. _Journal of the Optical Society of America_ **27** , 395, https://doi. org/10.1364/josa.27.000395 (1937). 

182. Ives, H. E. & Briggs, H. B. The optical constants of sodium. _Journal of the Optical Society of America_ **27** , 181, https://doi.org/10.1364/ josa.27.000181 (1937). 

183. Jansonas, G., Budriūnas, R., Vengris, M. & Varanavičius, A. Interferometric measurements of nonlinear refractive index in the infrared spectral range. _Optics Express_ **30** , 30507, https://doi.org/10.1364/oe.458850 (2022). 

184. Jöbsis, H. J. _et al_ . Recombination and localization: Unfolding the pathways behind conductivity losses in Cs2AgBiBr6 thin films. _Applied Physics Letters_ **119** , https://doi.org/10.1063/5.0061899 (2021). 

185. Jellison, G. Optical functions of silicon determined by two-channel polarization modulation ellipsometry. _Optical Materials_ **1** , 41–47, https://doi.org/10.1016/0925-3467(92)90015-f (1992). 

186. Jellison, G. Optical functions of GaAs, GaP, and Ge determined by two-channel polarization modulation ellipsometry. _Optical Materials_ **1** , 151–160, https://doi.org/10.1016/0925-3467(92)90022-f (1992). 

187. Jellison, G., Haynes, T. & Burke, H. Optical functions of silicon-germanium alloys determined using spectroscopic ellipsometry. _Optical Materials_ **2** , 105–117, https://doi.org/10.1016/0925-3467(93)90035-y (1993). 

188. Jellison, G. E. _et al_ . Refractive index of sodium iodide. _Journal of Applied Physics_ **111** , https://doi.org/10.1063/1.3689746 (2012). 189. Jiang, Y., Pillai, S. & Green, M. A. Realistic silver optical constants for plasmonics. _Scientific Reports_ **6** , https://doi.org/10.1038/ srep30605 (2016). 

190. Johnson, P. B. & Christy, R. W. Optical constants of the noble metals. _Physical Review B_ **6** , 4370–4379, https://doi.org/10.1103/ physrevb.6.4370 (1972). 

191. Johnson, P. & Christy, R. Optical constants of transition metals: Ti, V, Cr, Mn, Fe, Co, Ni, and Pd. _Physical Review B_ **9** , 5056–5070, https://doi.org/10.1103/physrevb.9.5056 (1974). 

192. Joseph, S., Sarkar, S. & Joseph, J. Grating-coupled surface plasmon-polariton sensing at a flat metal–analyte interface in a hybridconfiguration. _ACS Applied Materials & Interfaces_ **12** , 46519–46529, https://doi.org/10.1021/acsami.0c12525 (2020). 

193. Joseph, S., Sarkar, S., Khan, S. & Joseph, J. Exploring the optical bound state in the continuum in a dielectric grating coupled plasmonic hybrid system. _Advanced Optical Materials_ **9** , https://doi.org/10.1002/adom.202001895 (2021). 

194. Jung, G.-H., Yoo, S. & Park, Q.-H. Measuring the optical permittivity of two-dimensional materials without a priori knowledge of electronic transitions. _Nanophotonics_ **8** , 263–270, https://doi.org/10.1515/nanoph-2018-0120 (2018). 

195. Křen, P. Comment on “Precision refractive index measurements of air, N2, O2, Ar, and CO2 with a frequency comb”. _Applied Optics_ **50** , 6484, https://doi.org/10.1364/ao.50.006484 (2011). 

196. König, T. A. F. _et al_ . Electrically tunable plasmonic behavior of nanocube–polymer nanomaterials induced by a redox-active electrochromic polymer. _ACS Nano_ **8** , 6182–6192, https://doi.org/10.1021/nn501601e (2014). 

197. Kabaciński, P., Kardaś, T. M., Stepanenko, Y. & Radzewicz, C. Nonlinear refractive index measurement by SPM-induced phase regression. _Optics Express_ **27** , 11018, https://doi.org/10.1364/oe.27.011018 (2019). 

198. Kabelka, V. I., Piskarskas, A. S., Stabinis, A. Y. & Sher, R. L. Group matching of interacting light pulses in nonlinear crystals. _Soviet Journal of Quantum Electronics_ **5** , 255–256, https://doi.org/10.1070/qe1975v005n02abeh010943 (1975). 

199. Kachare, A. H., Spitzer, W. G. & Fredrickson, J. E. Refractive index of ion-implanted GaAs. _Journal of Applied Physics_ **47** , 4209–4212, https://doi.org/10.1063/1.323292 (1976). 

200. Kaiser, W., Spitzer, W. G., Kaiser, R. H. & Howarth, L. E. Infrared properties of CaF2, SrF2, and BaF2. _Physical Review_ **127** , 1950–1954, https://doi.org/10.1103/physrev.127.1950 (1962). 

201. Kaminskii, A. A. _et al_ . Mechanical and optical properties of Lu2O3 host-ceramics for Ln[3][+] lasants. _Laser Physics Letters_ **5** , 300–303, https://doi.org/10.1002/lapl.200710128 (2007). 

202. Kato, K. High-power difference-frequency generation at 4.4–5.7 μm in LiIO3. _IEEE Journal of Quantum Electronics_ **21** , 119–120, https://doi.org/10.1109/jqe.1985.1072617 (1985). 

203. Kato, K. & Takaoka, E. Sellmeier and thermo-optic dispersion formulas for KTP. _Applied Optics_ **41** , 5040, https://doi.org/10.1364/ ao.41.005040 (2002). 

204. Kato, K. & Umemura, N. Sellmeier equations for GaS and GaSe and their applications to the nonlinear optics in GaS _x_ Se1- _x_ . _Optics Letters_ **36** , 746, https://doi.org/10.1364/ol.36.000746 (2011). 

205. Kato, K., Tanno, F. & Umemura, N. Sellmeier and thermo-optic dispersion formulas for GaSe (revisited). _Applied Optics_ **52** , 2325, https://doi.org/10.1364/ao.52.002325 (2013). 

206. Kato, K., Petrov, V. & Umemura, N. Phase-matching properties of yellow color HgGa2S4 for shg and sfg in the 0.944–10.5910 μm range. _Applied Optics_ **55** , 3145, https://doi.org/10.1364/ao.55.003145 (2016). 

207. Kato, K., Umemura, N. & Petrov, V. Sellmeier and thermo-optic dispersion formulas for CdGa2S4 and their application to the nonlinear optics of Hg1- _x_ Cd _x_ Ga2S4. _Optics Communications_ **386** , 49–52, https://doi.org/10.1016/j.optcom.2016.10.054 (2017). 

208. Kato, K. _et al_ . Phase-matching properties of LiGaS2 in the 1.025–10.5910 μm spectral range. _Optics Letters_ **42** , 4363, https://doi. org/10.1364/ol.42.004363 (2017). 

209. Kato, K., Miyata, K., Badikov, V. V. & Petrov, V. Phase-matching properties of BaGa2GeSe6 for three-wave interactions in the 0.778–10.5910 μm spectral range. _Applied Optics_ **57** , 7440, https://doi.org/10.1364/ao.57.007440 (2018). 

210. Kato, K., Badikov, V. V., Miyata, K. & Petrov, V. Refined Sellmeier equations for BaGa4S7. _Applied Optics_ **60** , 6600, https://doi. org/10.1364/ao.430424 (2021). 

211. Kato, K., Miyata, K. & Petrov, V. Refined Sellmeier equations for AgGaSe2 up to 18 μm. _Applied Optics_ **60** , 805, https://doi. org/10.1364/ao.401828 (2021). 

212. Kato, K., Banerjee, S. & Umemura, N. Phase-matching properties of AgGa0.86In0.14S2 for three-wave interactions in the 0.615–10.5910 μm spectral range. _Optical Materials Express_ **11** , 2800, https://doi.org/10.1364/ome.428688 (2021). 

213. Kawashima, T., Yoshikawa, H., Adachi, S., Fuke, S. & Ohtsuka, K. Optical properties of hexagonal GaN. _Journal of Applied Physics_ **82** , 3528–3535, https://doi.org/10.1063/1.365671 (1997). 

214. Kawka, P. A. & Buckius, R. O. Optical properties of polyimide films in the infrared. _International Journal of Thermophysics_ **22** , 517–534, https://doi.org/10.1023/a:1010797620483 (2001). 

215. Kedenburg, S., Vieweg, M., Gissibl, T. & Giessen, H. Linear refractive index and absorption measurements of nonlinear optical liquids in the visible and near-infrared spectral region. _Optical Materials Express_ **2** , 1588, https://doi.org/10.1364/ome.2.001588 (2012). 

216. Kerl, K. & Varchmin, H. Refractive index dispersion (RID) of some liquids in the UV/VIS between 20 °C and 60 °C. _Journal of Molecular Structure_ **349** , 257–260, https://doi.org/10.1016/0022-2860(95)08758-n (1995). 

217. Kerremans, R. _et al_ . The optical constants of solution-processed semiconductors—new challenges with perovskites and nonfullerene acceptors. _Advanced Optical Materials_ **8** , https://doi.org/10.1002/adom.202000319 (2020). 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

12 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

218. Kim, Y. D. _et al_ . Optical properties of zinc-blende CdSe and Zn _x_ Cd1- _x_ Se films grown on GaAs. _Physical Review B_ **49** , 7262–7270, https://doi.org/10.1103/physrevb.49.7262 (1994). 

219. Kischkat, J. _et al_ . Mid-infrared optical properties of thin films of aluminum oxide, titanium dioxide, silicon dioxide, aluminum nitride, and silicon nitride. _Applied Optics_ **51** , 6789, https://doi.org/10.1364/ao.51.006789 (2012). 

220. Kitamura, R., Pilon, L. & Jonasz, M. Optical constants of silica glass from extreme ultraviolet to far infrared at near room temperature. _Applied Optics_ **46** , 8118, https://doi.org/10.1364/ao.46.008118 (2007). 

221. Kiyoshi Kato, K. K. & Hiromichi Shirahata, H. S. Nonlinear ir generation in AgGaS2. _Japanese Journal of Applied Physics_ **35** , 4645, https://doi.org/10.1143/jjap.35.4645 (1996). 

222. Klein, C. A. Room-temperature dispersion equations for cubic zinc sulfide. _Applied Optics_ **25** , 1873, https://doi.org/10.1364/ ao.25.001873 (1986). 

223. Kofman, V., He, J., Loes ten Kate, I. & Linnartz, H. The refractive index of amorphous and crystalline water ice in the UV–vis. _The Astrophysical Journal_ **875** , 131, https://doi.org/10.3847/1538-4357/ab0d89 (2019). 

224. Kozma, I. Z., Krok, P. & Riedle, E. Direct measurement of the group-velocity mismatch and derivation of the refractive-index dispersion for a variety of solvents in the ultraviolet. _Journal of the Optical Society of America B_ **22** , 1479, https://doi.org/10.1364/ josab.22.001479 (2005). 

225. Krauter, P. _et al_ . Optical phantoms with adjustable subdiffusive scattering parameters. _Journal of Biomedical Optics_ **20** , 105008, https://doi.org/10.1117/1.jbo.20.10.105008 (2015). 

226. Kulikova, D. P. _et al_ . Optical properties of tungsten trioxide, palladium, and platinum thin films for functional nanostructures engineering. _Optics Express_ **28** , 32049, https://doi.org/10.1364/oe.405403 (2020). 

227. Kumar, A. _et al_ . Linear and nonlinear optical properties of BiFeO3. _Applied Physics Letters_ **92** , https://doi.org/10.1063/1.2901168 (2008). 

228. Laiho, R. & Lakkisto, M. Investigation of the refractive indices of LaF3, CeF3, PrF3 and NdF3. _Philosophical Magazine B_ **48** , 203–207, https://doi.org/10.1080/13642818308226470 (1983). 

229. Lajaunie, L., Boucher, F., Dessapt, R. & Moreau, P. Strong anisotropic influence of local-field effects on the dielectric response of _α_ -MoO3. _Physical Review B_ **88** , https://doi.org/10.1103/physrevb.88.115141 (2013). 

230. Lane, D. W. The optical properties and laser irradiation of some common glasses. _Journal of Physics D: Applied Physics_ **23** , 1727–1734, https://doi.org/10.1088/0022-3727/23/12/037 (1990). 

231. Larruquert, J. I., Méndez, J. A. & Aznárez, J. A. Far-ultraviolet reflectance measurements and optical constants of unoxidized aluminum films. _Applied Optics_ **34** , 4892, https://doi.org/10.1364/ao.34.004892 (1995). 

232. Larruquert, J. I., Méndez, J. A. & Aznárez, J. A. Optical constants of aluminum films in the extreme ultraviolet interval of 82–77 nm. _Applied Optics_ **35** , 5692, https://doi.org/10.1364/ao.35.005692 (1996). 

233. Larruquert, J. I., Aznárez, J. A., Méndez, J. A. & Calvo-Angós, J. Optical properties of ytterbium films in the far and the extreme ultraviolet. _Applied Optics_ **42** , 4566, https://doi.org/10.1364/ao.42.004566 (2003). 

234. Larruquert, J. I. _et al_ . Optical properties of scandium films in the far and the extreme ultraviolet. _Applied Optics_ **43** , 3271, https:// doi.org/10.1364/ao.43.003271 (2004). 

235. Larruquert, J. I. _et al_ . Transmittance and optical constants of erbium films in the 325–1580 eV spectral range. _Applied Optics_ **50** , 2211, https://doi.org/10.1364/ao.50.002211 (2011). 

236. Larruquert, J. I. _et al_ . Self-consistent optical constants of SiC thin films. _Journal of the Optical Society of America A_ **28** , 2340, https:// doi.org/10.1364/josaa.28.002340 (2011). 

237. Larruquert, J. I. _et al_ . Self-consistent optical constants of sputter-deposited B4C thin films. _Journal of the Optical Society of America A_ **29** , 117, https://doi.org/10.1364/josaa.29.000117 (2011). 

238. Larruquert, J. I., Rodríguez-de Marcos, L. V., Méndez, J. A., Martin, P. J. & Bendavid, A. High reflectance ta-C coatings in the extreme ultraviolet. _Optics Express_ **21** , 27537, https://doi.org/10.1364/oe.21.027537 (2013). 

239. Larsén, T. Beitrag zur dispersion der edelgase. _Zeitschrift für Physik_ **88** , 389–394, https://doi.org/10.1007/bf01343498 (1934). 

240. Le, T. N., Pelouard, J.-L., Charra, F. & Vassant, S. Determination of the far-infrared dielectric function of a thin InGaAs layer using a detuned Salisbury screen. _Optical Materials Express_ **12** , 2711, https://doi.org/10.1364/ome.455445 (2022). 

241. Lee, S., Jeong, T., Jung, S. & Yee, K. Refractive index dispersion of hexagonal boron nitride in the visible and near-infrared. _physica status solidi (b)_ **256** , https://doi.org/10.1002/pssb.201800417 (2018). 

242. Leguy, A. M. A. _et al_ . Reversible hydration of CH3NH3PbI3 in films, single crystals, and solar cells. _Chemistry of Materials_ **27** , 3397–3407, https://doi.org/10.1021/acs.chemmater.5b00660 (2015). 

243. Leite, T. R., Zschiedrich, L., Kizilkaya, O. & McPeak, K. M. Resonant plasmonic–biomolecular chiral interactions in the farultraviolet: Enantiomeric discrimination of sub-10 nm amino acid films. _Nano Letters_ **22** , 7343–7350, https://doi.org/10.1021/acs. nanolett.2c01724 (2022). 

244. Leonard, P. Refractive indices, verdet constants, and polarizabilities of the inert gases. _Atomic Data and Nuclear Data Tables_ **14** , 21–37, https://doi.org/10.1016/s0092-640x(74)80028-8 (1974). 

245. Li, H. H. Refractive index of alkali halides and its wavelength and temperature derivatives. _Journal of Physical and Chemical Reference Data_ **5** , 329–528, https://doi.org/10.1063/1.555536 (1976). 

246. Li, H. H. Refractive index of alkaline earth halides and its wavelength and temperature derivatives. _Journal of Physical and Chemical Reference Data_ **9** , 161–290, https://doi.org/10.1063/1.555616 (1980). 

247. Li, H. H. Refractive index of silicon and germanium and its wavelength and temperature derivatives. _Journal of Physical and Chemical Reference Data_ **9** , 561–658, https://doi.org/10.1063/1.555624 (1980). 

248. Li, H. H. Refractive index of ZnS, ZnSe, and ZnTe and its wavelength and temperature derivatives. _Journal of Physical and Chemical Reference Data_ **13** , 103–150, https://doi.org/10.1063/1.555705 (1984). 

249. Li, J., Wen, C.-H., Gauza, S., Lu, R. & Wu, S.-T. Refractive indices of liquid crystals for display applications. _Journal of Display Technology_ **1** , 51–61, https://doi.org/10.1109/jdt.2005.853357 (2005). 

250. Lin, M., Sverdlov, B., Strite, S., Morkoç, H. & Drakin, A. Refractive indices of wurtzite and zincblende GaN. _Electronics Letters_ **29** , 1759, https://doi.org/10.1049/el:19931172 (1993). 

251. Lin, Q. _et al_ . Dispersion of silicon nonlinearities in the near infrared region. _Applied Physics Letters_ **91** , https://doi. org/10.1063/1.2750523 (2007). 

252. Lisitsa, M. P., Gudymenko, L. F., Malinko, V. N. & Terekhova, S. F. Dispersion of the refractive indices and birefringence of CdS _x_ Se1- _x_[ single crystals. ] _[physica status solidi (b)]_ **[31]**[, 389–399, ][https://doi.org/10.1002/pssb.19690310146][ (1969).] 

253. Logothetidis, S., Petalas, J., Cardona, M. & Moustakas, T. D. Optical properties and temperature dependence of the interband transitions of cubic and hexagonal GaN. _Physical Review B_ **50** , 18017–18029, https://doi.org/10.1103/physrevb.50.18017 (1994). 

254. Loiko, P. & Major, A. Dispersive properties of alexandrite and beryllium hexaaluminate crystals. _Optical Materials Express_ **6** , 2177, https://doi.org/10.1364/ome.6.002177 (2016). 

255. Loiko, P. _et al_ . Sellmeier equations, group velocity dispersion, and thermo-optic dispersion formulas for CaLnAlO4 (Ln = Y, Gd) laser host crystals. _Optics Letters_ **42** , 2275, https://doi.org/10.1364/ol.42.002275 (2017). 

256. Lomheim, T. S. & DeShazer, L. G. Optical-absorption intensities of trivalent neodymium in the uniaxial crystal yttrium orthovanadate. _Journal of Applied Physics_ **49** , 5517–5522, https://doi.org/10.1063/1.324471 (1978). 

257. Loria, S. Über die dispersion des lichtes in gasförmigen kohlenwasserstoffen. _Annalen der Physik_ **334** , 605–622, https://doi. org/10.1002/andp.19093340809 (1909). 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

13 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

258. Lorimor, O. G. & Spitzer, W. G. Infrared refractive index and absorption of InAs and CdTe. _Journal of Applied Physics_ **36** , 1841–1844, https://doi.org/10.1063/1.1714362 (1965). 

259. Luke, K., Okawachi, Y., Lamont, M. R. E., Gaeta, A. L. & Lipson, M. Broadband mid-infrared frequency comb generation in a Si3N4 microresonator. _Optics Letters_ **40** , 4823, https://doi.org/10.1364/ol.40.004823 (2015). 

260. Magnozzi, M., Ferrera, M., Mattera, L., Canepa, M. & Bisio, F. Plasmonics of au nanoparticles in a hot thermodynamic bath. _Nanoscale_ **11** , 1140–1146, https://doi.org/10.1039/c8nr09038f (2019). 

261. Malitson, I. H. Refraction and dispersion of synthetic sapphire. _Journal of the Optical Society of America_ **52** , 1377, https://doi. org/10.1364/josa.52.001377 (1962). 

262. Malitson, I. H. A redetermination of some optical properties of calcium fluoride. _Applied Optics_ **2** , 1103, https://doi.org/10.1364/ ao.2.001103 (1963). 

263. Malitson, I. H. Refractive properties of barium fluoride. _Journal of the Optical Society of America_ **54** , 628, https://doi.org/10.1364/ josa.54.000628 (1964). 

264. Malitson, I. H. Interspecimen comparison of the refractive index of fused silica. _Journal of the Optical Society of America_ **55** , 1205, https://doi.org/10.1364/josa.55.001205 (1965). 

265. Mansfield, C. R. & Peck, E. R. Dispersion of helium. _Journal of the Optical Society of America_ **59** , 199, https://doi.org/10.1364/ josa.59.000199 (1969). 

266. Marcos, L. R.-d. _et al_ . Optical constants of SrF2 thin films in the 25–780-eV spectral range. _Journal of Applied Physics_ **113** , https:// doi.org/10.1063/1.4800099 (2013). 

267. Marcos, L. R.-d _et al_ . Transmittance and optical constants of Ca films in the 4–1000 eV spectral range. _Applied Optics_ **54** , 1910, https://doi.org/10.1364/ao.54.001910 (2015). 

268. Marple, D. T. F. Refractive index of ZnSe, ZnTe, and CdTe. _Journal of Applied Physics_ **35** , 539–542, https://doi.org/10.1063/1.1713411 (1964). 

269. Martonchik, J. V. & Orton, G. S. Optical constants of liquid and solid methane. _Applied Optics_ **33** , 8306, https://doi.org/10.1364/ ao.33.008306 (1994). 

270. Mathar, R. J. Refractive index of humid air in the infrared: model fits. _Journal of Optics A: Pure and Applied Optics_ **9** , 470–476, https://doi.org/10.1088/1464-4258/9/5/008 (2007). 

271. Mathewson, A. G. & Myers, H. P. Absolute values of the optical constants of some pure metals. _Physica Scripta_ **4** , 291–292, https:// doi.org/10.1088/0031-8949/4/6/009 (1971). 

272. Mavrona, E. _et al_ . Refractive index measurement of IP-S and IP-Dip photoresists at THz frequencies and validation via 3D photonic metamaterials made by direct laser writing. _Optical Materials Express_ **13** , 3355, https://doi.org/10.1364/ome.500287 (2023). 

273. McPeak, K. M. _et al_ . Plasmonic films can easily be better: Rules and recipes. _ACS Photonics_ **2** , 326–333, https://doi.org/10.1021/ ph5004237 (2015). 

274. Medenbach, O., Dettmar, D., Shannon, R. D., Fischer, R. X. & Yen, W. M. Refractive index and optical dispersion of rare earth oxides using a small-prism technique. _Journal of Optics A: Pure and Applied Optics_ **3** , 174–177, https://doi.org/10.1088/14644258/3/3/303 (2001). 

275. Meretska, M. L. _et al_ . Measurements of the magneto-optical properties of thin-film EuS at room temperature in the visible spectrum. _Applied Physics Letters_ **120** , https://doi.org/10.1063/5.0090533 (2022). 

276. Milam, D., Weber, M. J. & Glass, A. J. Nonlinear refractive index of fluoride crystals. _Applied Physics Letters_ **31** , 822–825, https:// doi.org/10.1063/1.89561 (1977). 

277. Milam, D. Review and assessment of measured values of the nonlinear refractive-index coefficient of fused silica. _Applied Optics_ **37** , 546, https://doi.org/10.1364/ao.37.000546 (1998). 

278. Miller, S. _et al_ . Polarization-dependent nonlinear refractive index of BiB3O6. _Optical Materials_ **30** , 1469–1472, https://doi. org/10.1016/j.optmat.2007.11.015 (2008). 

279. Moerland, R. J. & Hoogenboom, J. P. Subnanometer-accuracy optical distance ruler based on fluorescence quenching by transparent conductors. _Optica_ **3** , 112, https://doi.org/10.1364/optica.3.000112 (2016). 

280. Monin, J. & Boutry, G. A. Optical and photoelectric properties of alkali metals. _Physical Review B_ **9** , 1309–1327, https://doi. org/10.1103/physrevb.9.1309 (1974). 

281. Moutzouris, K., Hloupis, G., Stavrakas, I., Triantis, D. & Chou, M.-H. Temperature-dependent visible to near-infrared optical properties of 8 mol% Mg-doped lithium tantalate. _Optical Materials Express_ **1** , 458, https://doi.org/10.1364/ome.1.000458 (2011). 

282. Moutzouris, K., Stavrakas, I., Triantis, D. & Enculescu, M. Temperature-dependent refractive index of potassium acid phthalate (KAP) in the visible and near-infrared. _Optical Materials_ **33** , 812–816, https://doi.org/10.1016/j.optmat.2010.12.021 (2011). 

283. Moutzouris, K. _et al_ . Refractive, dispersive and thermo-optic properties of twelve organic solvents in the visible and near-infrared. _Applied Physics B_ **116** , 617–622, https://doi.org/10.1007/s00340-013-5744-3 (2013). 

284. Munkhbat, B., Wróbel, P., Antosiewicz, T. J. & Shegai, T. O. Optical constants of several multilayer transition metal dichalcogenides measured by spectroscopic ellipsometry in the 300–1700 nm range: High index, anisotropy, and hyperbolicity. _ACS Photonics_ **9** , 2398–2407, https://doi.org/10.1021/acsphotonics.2c00433 (2022). 

285. Myers, T. L. _et al_ . Accurate measurement of the optical constants n and k for a series of 57 inorganic and organic liquids for optical modeling and detection. _Applied Spectroscopy_ **72** , 535–550, https://doi.org/10.1177/0003702817742848 (2017). 

286. Nibbering, E. T. J., Grillon, G., Franco, M. A., Prade, B. S. & Mysyrowicz, A. Determination of the inertial contribution to the nonlinear refractive index of air, N2, and O2 by use of unfocused high-intensity femtosecond laser pulses. _Journal of the Optical Society of America B_ **14** , 650, https://doi.org/10.1364/josab.14.000650 (1997). 

287. Nigara, Y. Measurement of the optical constants of yttrium oxide. _Japanese Journal of Applied Physics_ **7** , 404, https://doi. org/10.1143/jjap.7.404 (1968). 

288. Ninomiya, S. & Adachi, S. Optical properties of wurtzite CdS. _Journal of Applied Physics_ **78** , 1183–1190, https://doi. org/10.1063/1.360355 (1995). 

289. Ninomiya, S. & Adachi, S. Optical properties of cubic and hexagonal CdSe. _Journal of Applied Physics_ **78** , 4681–4689, https://doi. org/10.1063/1.359815 (1995). 

290. Nunley, T. N. _et al_ . Optical constants of germanium and thermally grown germanium dioxide from 0.5 to 6.6 eV via a multisample ellipsometry investigation. _Journal of Vacuum Science & Technology B, Nanotechnology and Microelectronics: Materials, Processing, Measurement, and Phenomena_ **34** , https://doi.org/10.1116/1.4963075 (2016). 

291. Nyakuchena, M., Juntunen, C., Shea, P. & Sung, Y. Refractive index dispersion measurement in the short-wave infrared range using synthetic phase microscopy. _Physical Chemistry Chemical Physics_ **25** , 23141–23149, https://doi.org/10.1039/d3cp03158f (2023). 

292. Oguntoye, I. O. _et al_ . Continuously tunable optical modulation using vanadium dioxide huygens metasurfaces. _ACS Applied Materials & Interfaces_ **15** , 41141–41150, https://doi.org/10.1021/acsami.3c08493 (2023). 

293. Old, J. G., Gentili, K. L. & Peck, E. R. Dispersion of carbon dioxide. _Journal of the Optical Society of America_ **61** , 89, https://doi. org/10.1364/josa.61.000089 (1971). 

294. Olmon, R. L. _et al_ . Optical dielectric function of gold. _Physical Review B_ **86** , https://doi.org/10.1103/physrevb.86.235147 (2012). 

295. Ordal, M. A., Bell, R. J., Alexander, R. W., Long, L. L. & Querry, M. R. Optical properties of fourteen metals in the infrared and far infrared: Al, Co, Cu, Au, Fe, Pb, Mo, Ni, Pd, Pt, Ag, Ti, V, and W. _Applied Optics_ **24** , 4493, https://doi.org/10.1364/ao.24.004493 (1985). 

296. Ordal, M. A., Bell, R. J., Alexander, R. W., Long, L. L. & Querry, M. R. Optical properties of Au, Ni, and Pb at submillimeter wavelengths. _Applied Optics_ **26** , 744, https://doi.org/10.1364/ao.26.000744 (1987). 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

14 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

297. Ordal, M. A., Bell, R. J., Alexander, R. W., Newquist, L. A. & Querry, M. R. Optical properties of Al, Fe, Ti, Ta, W, and Mo at submillimeter wavelengths. _Applied Optics_ **27** , 1203, https://doi.org/10.1364/ao.27.001203 (1988). 

298. Otanicar, T. P., Phelan, P. E. & Golden, J. S. Optical properties of liquids for direct absorption solar thermal energy systems. _Solar Energy_ **83** , 969–977, https://doi.org/10.1016/j.solener.2008.12.009 (2009). 

299. Owyoung, A. Ellipse rotation studies in laser host materials. _IEEE Journal of Quantum Electronics_ **9** , 1064–1069, https://doi. org/10.1109/jqe.1973.1077417 (1973). 

300. Ozaki, S. & Adachi, S. Spectroscopic ellipsometry and thermoreflectance of GaAs. _Journal of Applied Physics_ **78** , 3380–3386, https://doi.org/10.1063/1.359966 (1995). 

301. Palm, K. J., Murray, J. B., Narayan, T. C. & Munday, J. N. Dynamic optical properties of metal hydrides. _ACS Photonics_ **5** , 4677–4686, https://doi.org/10.1021/acsphotonics.8b01243 (2018). 

302. Panah, M. E. A. _et al_ . Highly doped inp as a low loss plasmonic material for mid-IR region. _Optics Express_ **24** , 29077, https://doi. org/10.1364/oe.24.029077 (2016). 

303. Papatryfonos, K. _et al_ . Refractive indices of mbe-grown Al _x_ Ga(1- _x_ )As ternary alloys in the transparent wavelength region. _AIP Advances_ **11** , https://doi.org/10.1063/5.0039631 (2021). 

304. Parsons, D. F. & Coleman, P. D. Far infrared optical constants of gallium phosphide. _Applied Optics_ **10** , 1683, https://doi. org/10.1364/ao.10.1683_1 (1971). 

305. Pastrňák, J. & Roskovcová, L. Refraction index measurements on AlN single crystals. _physica status solidi (b)_ **14** , https://doi. org/10.1002/pssb.19660140127 (1966). 

306. Patwardhan, G. N., Ginsberg, J. S., Chen, C. Y., Jadidi, M. M. & Gaeta, A. L. Nonlinear refractive index of solids in mid-infrared. _Optics Letters_ **46** , 1824, https://doi.org/10.1364/ol.421469 (2021). 

307. Peck, E. R. & Fisher, D. J. Dispersion of argon. _Journal of the Optical Society of America_ **54** , 1362, https://doi.org/10.1364/ josa.54.001362 (1964). 

308. Peck, E. R. & Khanna, B. N. Dispersion of nitrogen. _Journal of the Optical Society of America_ **56** , 1059, https://doi.org/10.1364/ josa.56.001059 (1966). 

309. Peck, E. R. & Reeder, K. Dispersion of air. _Journal of the Optical Society of America_ **62** , 958, https://doi.org/10.1364/josa.62.000958 (1972). 

310. Peck, E. R. & Huang, S. Refractivity and dispersion of hydrogen in the visible and near infrared. _Journal of the Optical Society of America_ **67** , 1550, https://doi.org/10.1364/josa.67.001550 (1977). 

311. Pennington, D. M., Henesian, M. A. & Hellwarth, R. W. Nonlinear index of air at 1.053 μm. _Physical Review A_ **39** , 3003–3009, https://doi.org/10.1103/physreva.39.3003 (1989). 

312. Perner, L. W. _et al_ . Simultaneous measurement of mid-infrared refractive indices in thin-film heterostructures: Methodology and results for GaAs/AlGaAs. _Physical Review Research_ **5** , https://doi.org/10.1103/physrevresearch.5.033048 (2023). 

313. Perotto, G. _et al_ . The optical properties of regenerated silk fibroin films obtained from different sources. _Applied Physics Letters_ **111** , https://doi.org/10.1063/1.4998950 (2017). 

314. Pestryakov, E. V. _et al_ . Physical properties of BeAl6O10 single crystals. _Journal of Applied Physics_ **82** , 3661–3666, https://doi. org/10.1063/1.365728 (1997). 

315. Peter, F. Über brechungsindizes und absorptionskonstanten des diamanten zwischen 644 und 226 mμ. _Zeitschrift für Physik_ **15** , 358–368, https://doi.org/10.1007/bf01330487 (1923). 

316. Pettit, G. D. & Turner, W. J. Refractive index of InP. _Journal of Applied Physics_ **36** , 2081–2081, https://doi.org/10.1063/1.1714410 (1965). 

317. Pflüger, J., Fink, J., Weber, W., Bohnen, K. P. & Crecelius, G. Dielectric properties of TiC _x_ , TiN _x_ , VC _x_ , and VN _x_ from 1.5 to 40 eV determined by electron-energy-loss spectroscopy. _Physical Review B_ **30** , 1155–1163, https://doi.org/10.1103/physrevb.30.1155 (1984). 

318. Philipp, H. R. Optical properties of silicon nitride. _Journal of The Electrochemical Society_ **120** , 295, https://doi. org/10.1149/1.2403440 (1973). 

319. Philipp, H. R., Cole, H. S., Liu, Y. S. & Sitnik, T. A. Optical absorption of some polymers in the region 240–170 nm. _Applied Physics Letters_ **48** , 192–194, https://doi.org/10.1063/1.96940 (1986). 

320. Phillip, H. R. & Taft, E. A. Kramers-Kronig analysis of reflectance data for diamond. _Physical Review_ **136** , A1445–A1448, https:// doi.org/10.1103/physrev.136.a1445 (1964). 

321. Phillips, L. J. _et al_ . Dispersion relation data for methylammonium lead triiodide perovskite deposited on a (100) silicon wafer using a two-step vapour-phase reaction process. _Data in Brief_ **5** , 926–928, https://doi.org/10.1016/j.dib.2015.10.026 (2015). 

322. Pierce, D. T. & Spicer, W. E. Electronic structure of amorphous Si from photoemission and optical studies. _Physical Review B_ **5** , 3017–3029, https://doi.org/10.1103/physrevb.5.3017 (1972). 

323. Pigeon, J. J., Tochitsky, S. Y., Welch, E. C. & Joshi, C. Measurements of the nonlinear refractive index of air, N2, and O2 at 10 μm using four-wave mixing. _Optics Letters_ **41** , 3924, https://doi.org/10.1364/ol.41.003924 (2016). 

324. Pigeon, J. J., Matteo, D. A., Tochitsky, S. Y., Ben-Zvi, I. & Joshi, C. Measurements of the nonlinear refractive index of AgGaSe2, GaSe, and ZnSe at 10 μm. _Journal of the Optical Society of America B_ **37** , 2076, https://doi.org/10.1364/josab.395844 (2020). 

325. Polyanskiy, M. N. _et al_ . Single-shot measurement of the nonlinear refractive index of air at 9.2 μm with a picosecond terawatt CO2 laser. _Optics Letters_ **46** , 2067, https://doi.org/10.1364/ol.423800 (2021). 

326. Polyanskiy, M. N. _et al_ . Post-compression of long-wave infrared 2 picosecond sub-terawatt pulses in bulk materials. _Optics Express_ **29** , 31714, https://doi.org/10.1364/oe.434238 (2021). 

327. Radhakrishnan, T. The dispersion, briefringence and optical activity of quartz. _Proceedings of the Indian Academy of Sciences - Section A_ **25** , https://doi.org/10.1007/bf03171408 (1947). 

328. Radhakrishnan, T. Further studies on the temperature variation of the refractive index of crystals. _Proceedings of the Indian Academy of Sciences - Section A_ **33** , https://doi.org/10.1007/bf03172255 (1951). 

329. Rakić, A. D. Algorithm for the determination of intrinsic optical constants of metal films: application to aluminum. _Applied Optics_ **34** , 4755, https://doi.org/10.1364/ao.34.004755 (1995). 

330. Rakić, A. D. & Majewski, M. L. Modeling the optical dielectric function of GaAs and AlAs: Extension of Adachi’s model. _Journal of Applied Physics_ **80** , 5909–5914, https://doi.org/10.1063/1.363586 (1996). 

331. Rakić, A. D., Djurišić, A. B., Elazar, J. M. & Majewski, M. L. Optical properties of metallic films for vertical-cavity optoelectronic devices. _Applied Optics_ **37** , 5271, https://doi.org/10.1364/ao.37.005271 (1998). 

332. Rasigni, M. & Rasigni, G. Optical constants of lithium deposits as determined from the Kramers-Kronig analysis. _Journal of the Optical Society of America_ **67** , 54, https://doi.org/10.1364/josa.67.000054 (1977). 

333. Ratzsch, S., Kley, E.-B., Tünnermann, A. & Szeghalmi, A. Influence of the oxygen plasma parameters on the atomic layer deposition of titanium dioxide. _Nanotechnology_ **26** , 024003, https://doi.org/10.1088/0957-4484/26/2/024003 (2014). 

334. Rheims, J., Köser, J. & Wriedt, T. Refractive-index measurements in the near-IR using an Abbe refractometer. _Measurement Science and Technology_ **8** , 601–605, https://doi.org/10.1088/0957-0233/8/6/003 (1997). 

335. Rioux, D. _et al_ . An analytic model for the dielectric function of Au, Ag, and their alloys. _Advanced Optical Materials_ **2** , 176–182, https://doi.org/10.1002/adom.201300457 (2013). 

336. Rodney, W. S. Optical properties of cesium iodide. _Journal of the Optical Society of America_ **45** , 987, https://doi.org/10.1364/ josa.45.000987 (1955). 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

15 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

337. Rodney, W. S. & Malitson, I. H. Refraction and dispersion of thallium bromide iodide. _Journal of the Optical Society of America_ **46** , 956, https://doi.org/10.1364/josa.46.000956 (1956). 

338. Rodney, W. S., Malitson, I. H. & King, T. A. Refractive index of arsenic trisulfide. _Journal of the Optical Society of America_ **48** , 633, https://doi.org/10.1364/josa.48.000633 (1958). 

339. Rodríguez-de Marcos, L. _et al_ . Transmittance and optical constants of Sr films in the 6–1220 eV spectral range. _Journal of Applied Physics_ **111** , https://doi.org/10.1063/1.4729487 (2012). 

340. Rodríguez-de Marcos, L. V., Larruquert, J. I., Méndez, J. A. & Aznárez, J. A. Self-consistent optical constants of SiO2 and Ta2O5 films. _Optical Materials Express_ **6** , 3622, https://doi.org/10.1364/ome.6.003622 (2016). 

341. Rodríguez-de Marcos, L. V., Larruquert, J. I., Méndez, J. A. & Aznárez, J. A. Self-consistent optical constants of MgF2, LaF3, and CeF3 films. _Optical Materials Express_ **7** , 989, https://doi.org/10.1364/ome.7.000989 (2017). 

342. Rollefson, R. & Havens, R. Index of refraction of methane in the infra-red and the dipole moment of the CH bond. _Physical Review_ **57** , 710–717, https://doi.org/10.1103/physrev.57.710 (1940). 

343. Rosenblatt, G., Simkhovich, B., Bartal, G. & Orenstein, M. Nonmodal plasmonics: Controlling the forced optical response of nanostructures. _Physical Review X_ **10** , https://doi.org/10.1103/physrevx.10.011071 (2020). 

344. Rosker, M., Cheng, K. & Tang, C. Practical urea optical parametric oscillator for tunable generation throughout the visible and near-infrared. _IEEE Journal of Quantum Electronics_ **21** , 1600–1606, https://doi.org/10.1109/jqe.1985.1072557 (1985). 

345. Rowe, D. J., Smith, D. & Wilkinson, J. S. Complex refractive index spectra of whole blood and aqueous solutions of anticoagulants, analgesics and buffers in the mid-infrared. _Scientific Reports_ **7** , https://doi.org/10.1038/s41598-017-07842-0 (2017). 

346. Rowe, P. M., Fergoda, M. & Neshyba, S. Temperature-dependent optical properties of liquid water from 240 to 298 K. _Journal of Geophysical Research: Atmospheres_ **125** , https://doi.org/10.1029/2020jd032624 (2020). 

347. Rubin, M. Optical properties of soda lime silica glasses. _Solar Energy Materials_ **12** , 275–288, https://doi.org/10.1016/01651633(85)90052-8 (1985). 

348. Sahin, S., Nahar, N. K. & Sertel, K. Dielectric properties of low-loss polymers for mmw and THz applications. _Journal of Infrared, Millimeter, and Terahertz Waves_ **40** , 557–573, https://doi.org/10.1007/s10762-019-00584-2 (2019). 

349. Salzberg, C. D. & Villa, J. J. Infrared refractive indexes of silicon germanium and modified selenium glass. _Journal of the Optical Society of America_ **47** , 244, https://doi.org/10.1364/josa.47.000244 (1957). 

350. Sani, E. & Dell’Oro, A. Optical constants of ethylene glycol over an extremely wide spectral range. _Optical Materials_ **37** , 36–41, https://doi.org/10.1016/j.optmat.2014.04.035 (2014). 

351. Sani, E. & Dell’Oro, A. Corrigendum to “Optical constants of ethylene glycol over an extremely wide spectral range [opt. mater. 37 (2014) 36–41]. _Optical Materials_ **48** , 281, https://doi.org/10.1016/j.optmat.2015.06.039 (2015). 

352. Sani, E. & Dell’Oro, A. Spectral optical constants of ethanol and isopropanol from ultraviolet to far infrared. _Optical Materials_ **60** , 137–141, https://doi.org/10.1016/j.optmat.2016.06.041 (2016). 

353. Sarkar, S. _et al_ . Hybridized guided-mode resonances via colloidal plasmonic self-assembled grating. _ACS Applied Materials & Interfaces_ **11** , 13752–13760, https://doi.org/10.1021/acsami.8b20535 (2019). 

354. Sarkar, S. _et al_ . Enhanced figure of merit via hybridized guided-mode resonances in 2 _d_ -metallic photonic crystal slabs. _Advanced Optical Materials_ **10** , https://doi.org/10.1002/adom.202200954 (2022). 

355. Sasaki, T., Mori, Y. & Yoshimura, M. Progress in the growth of a CsLiB6O10 crystal and its application to ultraviolet light generation. _Optical Materials_ **23** , 343–351, https://doi.org/10.1016/s0925-3467(02)00316-6 (2003). 

356. Sato, K. & Adachi, S. Optical properties of ZnTe. _Journal of Applied Physics_ **73** , 926–931, https://doi.org/10.1063/1.353305 (1993). 

357. Schinke, C., Hinken, D., Schmidt, J., Bothe, K. & Brendel, R. Modeling the spectral luminescence emission of silicon solar cells and wafers. _IEEE Journal of Photovoltaics_ **3** , 1038–1052, https://doi.org/10.1109/jphotov.2013.2263985 (2013). 

358. Schinke, C. _et al_ . Uncertainty analysis for the coefficient of band-to-band absorption of crystalline silicon. _AIP Advances_ **5** , https:// doi.org/10.1063/1.4923379 (2015). 

359. Schmitt, P. _et al_ . Optical, structural, and functional properties of highly reflective and stable iridium mirror coatings for infrared applications. _Optical Materials Express_ **12** , 545, https://doi.org/10.1364/ome.447306 (2022). 

360. Schnabel, V., Spolenak, R., Doebeli, M. & Galinski, H. Structural color sensors with thermal memory: Measuring functional properties of Ti-based nitrides by eye. _Advanced Optical Materials_ **6** , https://doi.org/10.1002/adom.201800656 (2018). 

361. Schneider, F., Draheim, J., Kamberger, R. & Wallrabe, U. Process and material properties of polydimethylsiloxane (PDMS) for optical MEMS. _Sensors and Actuators A: Physical_ **151** , 95–99, https://doi.org/10.1016/j.sna.2009.01.026 (2009). 

362. Schnepf, M. J. _et al_ . Nanorattles with tailored electric field enhancement. _Nanoscale_ **9** , 9376–9385, https://doi.org/10.1039/ c7nr02952g (2017). 

363. Schröter, H. Über die brechungsindizes einiger schwermetallhalogenide im sichtbaren und die berechnung von interpolationsformeln für den dispersionsverlauf. _Zeitschrift für Physik_ **67** , 24–36, https://doi.org/10.1007/bf01391040 (1931). 

364. Schubert, M. _et al_ . Optical constants of Ga _x_ In1- _x_ P lattice matched to GaAs. _Journal of Applied Physics_ **77** , 3416–3419, https://doi. org/10.1063/1.358632 (1995). 

365. Seçkin, S., Singh, P., Jaiswal, A. & König, T. A. F. Super-radiant sers enhancement by plasmonic particle gratings. _ACS Applied Materials & Interfaces_ **15** , 43124–43134, https://doi.org/10.1021/acsami.3c07532 (2023). 

366. Selivanov, A., Denisov, I., Kuleshov, N. & Yumashev, K. Nonlinear refractive properties of Yb[3][+] -doped KY(WO4)2 and YVO4 laser crystals. _Applied Physics B_ **83** , 61–65, https://doi.org/10.1007/s00340-005-2098-5 (2006). 

367. Shaffer, P. T. B. Refractive index, dispersion, and birefringence of silicon carbide polytypes. _Applied Optics_ **10** , 1034, https://doi. org/10.1364/ao.10.001034 (1971). 

368. Shaw, M., Hooker, C. & Wilson, D. Measurement of the nonlinear refractive index of air and other gases at 248 nm. _Optics Communications_ **103** , 153–160, https://doi.org/10.1016/0030-4018(93)90657-q (1993). 

369. Sheik-Bahae, M., Hutchings, D., Hagan, D. & Van Stryland, E. Dispersion of bound electron nonlinear refraction in solids. _IEEE Journal of Quantum Electronics_ **27** , 1296–1309, https://doi.org/10.1109/3.89946 (1991). 

370. Shimoji, Y., Fay, A. T., Chang, R. S. F. & Djeu, N. Direct measurement of the nonlinear refractive index of air. _Journal of the Optical Society of America B_ **6** , 1994, https://doi.org/10.1364/josab.6.001994 (1989). 

371. Shkondin, E., Repän, T., Takayama, O. & Lavrinenko, A. V. High aspect ratio titanium nitride trench structures as plasmonic biosensor. _Optical Materials Express_ **7** , 4171, https://doi.org/10.1364/ome.7.004171 (2017). 

372. Shkondin, E. _et al_ . Large-scale high aspect ratio Al-doped ZnO nanopillars arrays as anisotropic metamaterials. _Optical Materials Express_ **7** , 1606, https://doi.org/10.1364/ome.7.001606 (2017). 

373. Shunji Ozaki, S. O. & Sadao Adachi, S. A. Optical constants of cubic ZnS. _Japanese Journal of Applied Physics_ **32** , 5008, https://doi. org/10.1143/jjap.32.5008 (1993). 

374. Siefke, T. _et al_ . Materials pushing the application limits of wire grid polarizers further into the deep ultraviolet spectral range. _Advanced Optical Materials_ **4** , 1780–1786, https://doi.org/10.1002/adom.201600250 (2016). 

375. Šik, J., Hora, J. & Humlíček, J. Optical functions of silicon at high temperatures. _Journal of Applied Physics_ **84** , 6291–6298, https:// doi.org/10.1063/1.368951 (1998). 

376. Simon, M. _et al_ . Refractive indices of photorefractive bismuth titanate, barium-calcium titanate, bismuth germanium oxide, and lead germanate. _physica status solidi (a)_ **159** , 559–562, 10.1002/1521-396x(199702)159:2<559::aid-pssa559>3.0.co;2-0 (1997). 

377. Singh, S., Potopowicz, J. R., Van Uitert, L. G. & Wemple, S. H. Nonlinear optical properties of hexagonal silicon carbide. _Applied Physics Letters_ **19** , 53–56, https://doi.org/10.1063/1.1653819 (1971). 

16 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

378. Singh, S., Remeika, J. P. & Potopowicz, J. R. Nonlinear optical properties of ferroelectric lead titanate. _Applied Physics Letters_ **20** , 135–137, https://doi.org/10.1063/1.1654078 (1972). 

379. Sinnock, A. C. & Smith, B. L. Refractive indices of the condensed inert gases. _Physical Review_ **181** , 1297–1307, https://doi. org/10.1103/physrev.181.1297 (1969). 

380. Skauli, T. _et al_ . Improved dispersion relations for gaas and applications to nonlinear optics. _Journal of Applied Physics_ **94** , 6447–6455, https://doi.org/10.1063/1.1621740 (2003). 

381. Smith, N. V. Optical constants of sodium and potassium from 0.5 to 4.0 eV by split-beam ellipsometry. _Physical Review_ **183** , 634–644, https://doi.org/10.1103/physrev.183.634 (1969). 

382. Smith, N. V. Optical constants of rubidium and cesium from 0.5 to 4.0 eV. _Physical Review B_ **2** , 2840–2848, https://doi.org/10.1103/ physrevb.2.2840 (1970). 

383. Smith, D. R. & Loewenstein, E. V. Optical constants of far infrared materials 3: plastics. _Applied Optics_ **14** , 1335, https://doi. org/10.1364/ao.14.001335 (1975). 

384. Smith, P. L., Huber, M. C. E. & Parkinson, W. H. Refractivities of H2, He, O2, CO, and Kr for 168 ≤ λ ≤ 288 nm. _Physical Review A_ **13** , 1422–1434, https://doi.org/10.1103/physreva.13.1422 (1976). 

385. Smith, F. W. Optical constants of a hydrogenated amorphous carbon film. _Journal of Applied Physics_ **55** , 764–771, https://doi. org/10.1063/1.333135 (1984). 

386. Sneep, M. & Ubachs, W. Direct measurement of the Rayleigh scattering cross section in various gases. _Journal of Quantitative Spectroscopy and Radiative Transfer_ **92** , 293–310, https://doi.org/10.1016/j.jqsrt.2004.07.025 (2005). 

387. Song, B. _et al_ . Layer-dependent dielectric function of wafer-scale 2D MoS2. _Advanced Optical Materials_ **7** , https://doi.org/10.1002/ adom.201801250 (2018). 

388. Song, B. _et al_ . Broadband optical properties of graphene and hopg investigated by spectroscopic Mueller matrix ellipsometry. _Applied Surface Science_ **439** , 1079–1087, https://doi.org/10.1016/j.apsusc.2018.01.051 (2018). 

389. Song, B. _et al_ . Determination of dielectric functions and exciton oscillator strength of two-dimensional hybrid perovskites. _ACS Materials Letters_ **3** , 148–159, https://doi.org/10.1021/acsmaterialslett.0c00505 (2020). 

390. Song, B. _et al_ . Giant gate-tunability of complex refractive index in semiconducting carbon nanotubes. _ACS Photonics_ **7** , 2896–2905, https://doi.org/10.1021/acsphotonics.0c01220 (2020). 

391. Stahrenberg, K. _et al_ . Optical properties of copper and silver in the energy range 2.5–9.0 eV. _Physical Review B_ **64** , https://doi. org/10.1103/physrevb.64.115111 (2001). 

392. Stefaniuk, T. _et al_ . Optical, electronic, and structural properties of ScAlMgO4. _Physical Review B_ **107** , https://doi.org/10.1103/ physrevb.107.085205 (2023). 

393. Stelling, C. _et al_ . Plasmonic nanomeshes: their ambivalent role as transparent electrodes in organic solar cells. _Scientific Reports_ **7** , https://doi.org/10.1038/srep42530 (2017). 

394. Stephens, R. & Malitson, I. Index of refraction of magnesium oxide. _Journal of Research of the National Bureau of Standards_ **49** , 249, https://doi.org/10.6028/jres.049.025 (1952). 

395. Supansomboon, S., Maaroof, A. & Cortie, M. B. “purple glory”: The optical properties and technology of AuAl2 coatings. _Gold Bulletin_ **41** , 296–304, https://doi.org/10.1007/bf03214887 (2008). 

396. Sutherland, J. C. & Arakawa, E. T. Optical properties of potassium for photons of energy 396 to 969 eV. _Journal of the Optical Society of America_ **58** , 1080, https://doi.org/10.1364/josa.58.001080 (1968). 

397. Suzuki, N., Sawai, K. & Adachi, S. Optical properties of PbSe. _Journal of Applied Physics_ **77** , 1249–1255, https://doi. org/10.1063/1.358926 (1995). 

398. Svechnikov, M. _et al_ . Optical constants of sputtered beryllium thin films determined from photoabsorption measurements in the spectral range 20.4–250 eV. _Journal of Synchrotron Radiation_ **27** , 75–82, https://doi.org/10.1107/s1600577519014188 (2020). 

399. Sytchkova, A., Belosludtsev, A., Volosevičienė, L., Juškėnas, R. & Simniškis, R. Optical, structural and electrical properties of sputtered ultrathin chromium films. _Optical Materials_ **121** , 111530, https://doi.org/10.1016/j.optmat.2021.111530 (2021). 

400. Takaoka, E. & Kato, K. Thermo-optic dispersion formula for AgGaS2. _Applied Optics_ **38** , 4577, https://doi.org/10.1364/ao.38.004577 (1999). 

401. Tamošauskas, G., Beresnevičius, G., Gadonas, D. & Dubietis, A. Transmittance and phase matching of BBO crystal in the 3–5 µm range and its application for the characterization of mid-infrared laser pulses. _Optical Materials Express_ **8** , 1410, https://doi. org/10.1364/ome.8.001410 (2018). 

402. Tan, C. Determination of refractive index of silica glass for infrared wavelengths by IR spectroscopy. _Journal of Non-Crystalline Solids_ **223** , 158–163, https://doi.org/10.1016/s0022-3093(97)00438-9 (1998). 

403. Tatian, B. Fitting refractive-index data with the Sellmeier dispersion formula. _Applied Optics_ **23** , 4477, https://doi.org/10.1364/ ao.23.004477 (1984). 

404. Taylor, A. _et al_ . Comparative determination of atomic boron and carrier concentration in highly boron doped nano-crystalline diamond. _Diamond and Related Materials_ **135** , 109837, https://doi.org/10.1016/j.diamond.2023.109837 (2023). 

405. Tikuišis, K. K. _et al_ . Optical and magneto-optical properties of permalloy thin films in 0.7–6.4 eV photon energy range. _Materials & Design_ **114** , 31–39, https://doi.org/10.1016/j.matdes.2016.10.036 (2017). 

406. Tikuišis, K. K. _et al_ . Dielectric function of epitaxial quasi-freestanding monolayer graphene on Si-face 6H-SiC in a broad spectral range. _Physical Review Materials_ **7** , https://doi.org/10.1103/physrevmaterials.7.044201 (2023). 

407. Tilton, L. W., Plyler, E. K. & Stephens, R. E. Refractive index of silver chloride for visible and infra-red radiant energy. _Journal of the Optical Society of America_ **40** , 540, https://doi.org/10.1364/josa.40.000540 (1950). 

408. Tkachenko, V. _et al_ . Nematic liquid crystal optical dispersion in the visible-near infrared range. _Molecular Crystals and Liquid Crystals_ **454** , 263/[665]–271/[673], https://doi.org/10.1080/15421400600655816 (2006). 

409. Treharne, R. E. _et al_ . Optical design and fabrication of fully sputtered CdTe/CdS solar cells. _Journal of Physics: Conference Series_ **286** , 012038, https://doi.org/10.1088/1742-6596/286/1/012038 (2011). 

410. Tsuda, S., Yamaguchi, S., Kanamori, Y. & Yugami, H. Spectral and angular shaping of infrared radiation in a polymer resonator with molecular vibrational modes. _Optics Express_ **26** , 6899, https://doi.org/10.1364/oe.26.006899 (2018). 

411. Uchida, N. Optical properties of single-crystal paratellurite (TeO2). _Physical Review B_ **4** , 3736–3745, https://doi.org/10.1103/ physrevb.4.3736 (1971). 

412. Umegaki, S., Tanaka, S.-I., Uchiyama, T. & Yabumoto, S. Refractive indices of lithium iodate between 0.4 and 2.2 μ. _Optics Communications_ **3** , 244–245, https://doi.org/10.1016/0030-4018(71)90013-7 (1971). 

413. Valentine, J. _et al_ . Three-dimensional optical metamaterial with a negative refractive index. _Nature_ **455** , 376–379, https://doi. org/10.1038/nature07247 (2008). 

414. Vidal-Dasilva, M. _et al_ . Transmittance and optical constants of Tm films in the 2.75–1600 eV spectral range. _Journal of Applied Physics_ **105** , https://doi.org/10.1063/1.3129507 (2009). 

415. Vidal-Dasilva, M., Aquila, A. L., Gullikson, E. M., Salmassi, F. & Larruquert, J. I. Optical constants of magnetron-sputtered magnesium films in the 25–1300 eV energy range. _Journal of Applied Physics_ **108** , https://doi.org/10.1063/1.3481457 (2010). 

416. Vogt, M. R. _et al_ . Measurement of the optical constants of soda-lime glasses in dependence of iron content and modeling of ironrelated power losses in crystalline si solar cell modules. _IEEE Journal of Photovoltaics_ **6** , 111–118, https://doi.org/10.1109/ jphotov.2015.2498043 (2016). 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

17 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

417. Vogt, M. R. _et al_ . Optical constants of UV transparent EVA and the impact on the PV module output power under realistic irradiation. _Energy Procedia_ **92** , 523–530, https://doi.org/10.1016/j.egypro.2016.07.136 (2016). 

418. Vos, M. F. J., Macco, B., Thissen, N. F. W., Bol, A. A. & Kessels, W. M. M. E. Atomic layer deposition of molybdenum oxide from (N _[t]_ Bu)2(NMe2)2Mo and O2 plasma. _Journal of Vacuum Science & Technology A: Vacuum, Surfaces, and Films_ **34** , https://doi. org/10.1116/1.4930161 (2015). 

419. Vukovic, D., Woolsey, G. A. & Scelsi, G. B. Refractivities of SF6 and SOF2 at wavelengths of 632.99 and 1300 nm. _Journal of Physics D: Applied Physics_ **29** , 634–637, https://doi.org/10.1088/0022-3727/29/3/023 (1996). 

420. Vuye, G. _et al_ . Temperature dependence of the dielectric function of silicon using in situ spectroscopic ellipsometry. _Thin Solid Films_ **233** , 166–170, https://doi.org/10.1016/0040-6090(93)90082-z (1993). 

421. Wahlstrand, J. K., Cheng, Y.-H. & Milchberg, H. M. Absolute measurement of the transient optical nonlinearity in N2, O2, N2O, and Ar. _Physical Review A_ **85** , https://doi.org/10.1103/physreva.85.043820 (2012). 

422. Walling, J., Peterson, O., Jenssen, H., Morris, R. & O’Dell, E. Tunable alexandrite lasers. _IEEE Journal of Quantum Electronics_ **16** , 1302–1315, https://doi.org/10.1109/jqe.1980.1070430 (1980). 

423. Wang, S. _et al_ . 4H-SiC: a new nonlinear material for midinfrared lasers. _Laser & Photonics Reviews_ **7** , 831–838, https://doi. org/10.1002/lpor.201300068 (2013). 

424. Wang, Y. _et al_ . Measurement of absorption spectrum of deuterium oxide (D2O) and its application to signal enhancement in multiphoton microscopy at the 1700-nm window. _Applied Physics Letters_ **108** , https://doi.org/10.1063/1.4939970 (2016). 

425. Wang, K. _et al_ . Order-of-magnitude multiphoton signal enhancement based on characterization of absorption spectra of immersion oils at the 1700-nm window. _Optics Express_ **25** , 5909, https://doi.org/10.1364/oe.25.005909 (2017). 

426. Wang, C. C., Tan, J. Y., Jing, C. Y. & Liu, L. H. Temperature-dependent optical constants of liquid isopropanol, n-butanol, and n-decane. _Applied Optics_ **57** , 3003, https://doi.org/10.1364/ao.57.003003 (2018). 

427. Warren, S. G. Optical constants of ice from the ultraviolet to the microwave. _Applied Optics_ **23** , 1206, https://doi.org/10.1364/ ao.23.001206 (1984). 

428. Warren, S. G. & Brandt, R. E. Optical constants of ice from the ultraviolet to the microwave: A revised compilation. _Journal of Geophysical Research: Atmospheres_ **113** , https://doi.org/10.1029/2007jd009744 (2008). 

429. Weaver, J. H., Lynch, D. W. & Olson, C. G. Optical properties of niobium from 0.1 to 36.4 eV. _Physical Review B_ **7** , 4311–4318, https://doi.org/10.1103/physrevb.7.4311 (1973). 

430. Weaver, J. H., Olson, C. G. & Lynch, D. W. Optical properties of crystalline tungsten. _Physical Review B_ **12** , 1293–1297, https://doi. org/10.1103/physrevb.12.1293 (1975). 

431. Weaver, J. H., Olson, C. G. & Lynch, D. W. Optical investigation of the electronic structure of bulk Rh and Ir. _Physical Review B_ **15** , 4115–4118, https://doi.org/10.1103/physrevb.15.4115 (1977). 

432. Weber, J. W., Calado, V. E. & van de Sanden, M. C. M. Optical constants of graphene measured by spectroscopic ellipsometry. _Applied Physics Letters_ **97** , https://doi.org/10.1063/1.3475393 (2010). 

433. Weiting, F. & Yixun, Y. Temperature effects on the refractive index of lead telluride and zinc selenide. _Infrared Physics_ **30** , 371–373, https://doi.org/10.1016/0020-0891(90)90055-z (1990). 

434. Werner, W. S. M., Glantschnig, K. & Ambrosch-Draxl, C. Optical constants and inelastic electron-scattering data for 17 elemental metals. _Journal of Physical and Chemical Reference Data_ **38** , 1013–1092, https://doi.org/10.1063/1.3243762 (2009). 

435. Werner, K. _et al_ . Ultrafast mid-infrared high harmonic and supercontinuum generation with n2 characterization in zinc selenide. _Optics Express_ **27** , 2867, https://doi.org/10.1364/oe.27.002867 (2019). 

436. Wettling, W. & Windscheif, J. Elastic constants and refractive index of boron phosphide. _Solid State Communications_ **50** , 33–34, https://doi.org/10.1016/0038-1098(84)90053-x (1984). 

437. Whang, U. S., Arakawa, E. T. & Callcott, T. A. Optical properties of Cs for photons of energy 36–96 eV. _Journal of the Optical Society of America_ **61** , 740, https://doi.org/10.1364/josa.61.000740 (1971). 

438. Whang, U. S., Arakawa, E. T. & Callcott, T. A. Optical properties of K between 4 and 10.7 eV and comparison with Na, Rb, and Cs. _Physical Review B_ **6** , 2109–2118, https://doi.org/10.1103/physrevb.6.2109 (1972). 

439. Whang, U. S., Arakawa, E. T. & Callcott, T. A. Optical properties of Rb between 3.3 and 10.5 eV. _Physical Review B_ **5** , 2118–2124, https://doi.org/10.1103/physrevb.5.2118 (1972). 

440. White, W. T., Smith, W. L. & Milam, D. Direct measurement of the nonlinear refractive-index coefficient _γ_ at 355 nm in fused silica and in BK-10 glass. _Optics Letters_ **9** , 10, https://doi.org/10.1364/ol.9.000010 (1984). 

441. Williams, P. A. _et al_ . Optical, thermo-optic, electro-optic, and photoelastic properties of bismuth germanate (Bi4Ge3O12). _Applied Optics_ **35** , 3562, https://doi.org/10.1364/ao.35.003562 (1996). 

442. Windt, D. L. _et al_ . Optical constants for thin films of Ti, Zr, Nb, Mo, Ru, Rh, Pd, Ag, Hf, Ta, W, Re, Ir, Os, Pt, and Au from 24 Å to 1216 Å. _Applied Optics_ **27** , 246, https://doi.org/10.1364/ao.27.000246 (1988). 

443. Wood, D. L. & Nassau, K. Refractive index of cubic zirconia stabilized with yttria. _Applied Optics_ **21** , 2978, https://doi.org/10.1364/ ao.21.002978 (1982). 

444. Wood, D. L., Nassau, K., Kometani, T. Y. & Nash, D. L. Optical properties of cubic hafnia stabilized with yttria. _Applied Optics_ **29** , 604, https://doi.org/10.1364/ao.29.000604 (1990). 

445. Woods, B. W., Payne, S. A., Marion, J. E., Hughes, R. S. & Davis, L. E. Thermomechanical and thermo-optical properties of the LiCaAlF6:Cr[3][+] laser material. _Journal of the Optical Society of America B_ **8** , 970, https://doi.org/10.1364/josab.8.000970 (1991). 

446. Wu, S.-T. Refractive index dispersions of liquid crystals. _Optical Engineering_ **32** , 1775, https://doi.org/10.1117/12.143988 (1993). 

447. Wu, Y. _et al_ . Intrinsic optical properties and enhanced plasmonic response of epitaxial silver. _Advanced Materials_ **26** , 6106–6110, https://doi.org/10.1002/adma.201401474 (2014). 

448. Yakubovsky, D. I., Arsenin, A. V., Stebunov, Y. V., Fedyanin, D. Y. & Volkov, V. S. Optical constants and structural properties of thin gold films. _Optics Express_ **25** , 25574, https://doi.org/10.1364/oe.25.025574 (2017). 

449. Yakubovsky, D. I. _et al_ . Ultrathin and ultrasmooth gold films on monolayer MoS2. _Advanced Materials Interfaces_ **6** , https://doi. org/10.1002/admi.201900196 (2019). 

450. Yamaguchi, S. & Hanyu, T. Optical properties of potassium. _Journal of the Physical Society of Japan_ **31** , 1431–1441, https://doi. org/10.1143/jpsj.31.1431 (1971). 

451. Yamaguchi, S. & Hanyu, T. The optical properties of Rb. _Journal of the Physical Society of Japan_ **35** , 1371–1377, https://doi. org/10.1143/jpsj.35.1371 (1973). 

452. Yang, H. U. _et al_ . Optical dielectric function of silver. _Physical Review B_ **91** , https://doi.org/10.1103/physrevb.91.235137 (2015). 

453. Yao, C., Shen, W., Hu, X. & Hu, C. Optical properties of large-size and damage-free polished Lu2O3 single crystal covering the ultraviolet-visible-and near-infrared (UV–VIS–NIR) spectral region. _Journal of Alloys and Compounds_ **897** , 162726, https://doi. org/10.1016/j.jallcom.2021.162726 (2022). 

454. Yim, C. _et al_ . Investigation of the optical properties of MoS2 thin films using spectroscopic ellipsometry. _Applied Physics Letters_ **104** , 103114, https://doi.org/10.1063/1.4868108 (2014). 

455. Zahedpour, S., Wahlstrand, J. K. & Milchberg, H. M. Measurement of the nonlinear refractive index of air constituents at midinfrared wavelengths. _Optics Letters_ **40** , 5794, https://doi.org/10.1364/ol.40.005794 (2015). 

456. Zelmon, D. E., Small, D. L. & Jundt, D. Infrared corrected Sellmeier coefficients for congruently grown lithium niobate and 5 mol% magnesium oxide-doped lithium niobate. _Journal of the Optical Society of America B_ **14** , 3319, https://doi.org/10.1364/ josab.14.003319 (1997). 

18 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

www.nature.com/scientificdata 

www.nature.com/scientificdata/ 

457. Zelmon, D. E., Small, D. L. & Page, R. Refractive-index measurements of undoped yttrium aluminum garnet from 04 to 50 μm. _Applied Optics_ **37** , 4933, https://doi.org/10.1364/ao.37.004933 (1998). 

458. Zelmon, D. E., Hanning, E. A. & Schunemann, P. G. Refractive-index measurements and Sellmeier coefficients for zinc germanium phosphide from 2 to 9 μm with implications for phase matching in optical frequency-conversion devices. _Journal of the Optical Society of America B_ **18** , 1307, https://doi.org/10.1364/josab.18.001307 (2001). 

459. Zelmon, D. E., Bayya, S. S., Sanghera, J. S. & Aggarwal, I. D. Dispersion of barium gallogermanate glass. _Applied Optics_ **41** , 1366, https://doi.org/10.1364/ao.41.001366 (2002). 

460. Zemel, J. N., Jensen, J. D. & Schoolar, R. B. Electrical and optical properties of epitaxial films of PbS, PbSe, PbTe, and SnTe. _Physical Review_ **140** , A330–A342, https://doi.org/10.1103/physrev.140.a330 (1965). 

461. Zernike, F. Refractive indices of ammonium dihydrogen phosphate and potassium dihydrogen phosphate between 2000 Å and 15 μ. _Journal of the Optical Society of America_ **54** , 1215, https://doi.org/10.1364/josa.54.001215 (1964). 

462. Zhang, Z. M., Lefever-Button, G. & Powell, F. R. Infrared refractive index and extinction coefficient of polyimide films. _International Journal of Thermophysics_ **19** , 905–916, https://doi.org/10.1023/a:1022655309574 (1998). 

463. Zhang, D., Kong, Y. & Zhang, J.-Y. Optical parametric properties of 532-nm-pumped beta-barium-borate near the infrared absorption edge. _Optics Communications_ **184** , 485–491, https://doi.org/10.1016/s0030-4018(00)00968-8 (2000). 

464. Zhang, J., Lu, Z. H. & Wang, L. J. Precision refractive index measurements of air, N2, O2, Ar, and CO2 with a frequency comb. _Applied Optics_ **47** , 3143, https://doi.org/10.1364/ao.47.003143 (2008). 

465. Zhang, H. _et al_ . Measuring the refractive index of highly crystalline monolayer MoS2 with high confidence. _Scientific Reports_ **5** , https://doi.org/10.1038/srep08440 (2015). 

466. Zhang, X., Qiu, J., Li, X., Zhao, J. & Liu, L. Complex refractive indices measurements of polymers in visible and near-infrared bands. _Applied Optics_ **59** , 2337, https://doi.org/10.1364/ao.383831 (2020). 

467. Zhang, X., Qiu, J., Zhao, J., Li, X. & Liu, L. Complex refractive indices measurements of polymers in infrared bands. _Journal of Quantitative Spectroscopy and Radiative Transfer_ **252** , 107063, https://doi.org/10.1016/j.jqsrt.2020.107063 (2020). 

468. Zhang, X. _et al_ . Optimizing the design of the vapor-deposited CsPbCl3-based optoelectronic devices via simulations and experiments. _Advanced Functional Materials_ 2310945, https://doi.org/10.1002/adfm.202310945 (2023). 

469. Zheng, Q., Wang, X. & Thompson, D. Temperature-dependent optical properties of monocrystalline CaF2, BaF2, and MgF2. _Optical Materials Express_ **13** , 2380, https://doi.org/10.1364/ome.496246 (2023). 

470. Zhukovsky, S. V. _et al_ . Experimental demonstration of effective medium approximation breakdown in deeply subwavelength alldielectric multilayers. _Physical Review Letters_ **115** , https://doi.org/10.1103/physrevlett.115.177402 (2015). 

471. Zollner, S., Lin, C., Schönherr, E., Böhringer, A. & Cardona, M. The dielectric function of AlSb from 1.4 to 5.8 eV determined by spectroscopic ellipsometry. _Journal of Applied Physics_ **66** , 383–387, https://doi.org/10.1063/1.343888 (1989). 

## **acknowledgements** 

The development of the _n_ 2 segment of the _refractiveindex.info_ database was facilitated by grants from the US Department of Energy Accelerator Stewardship Program. Originally a part of the Office of High Energy Physics (HEP), this program is now under the purview of the Accelerator Research & Development and Production (ARDAP) office. The author extends heartfelt appreciation to the multitude of contributors from the scientific and engineering realms. Their contributions, spanning data submissions, error reporting, and invaluable insights, have been instrumental in the refinement and expansion of the database. The collective engagement of this dedicated community has been pivotal in elevating the database to its current stature of utility and comprehensiveness. 

## **author contributions** 

M.N.P. conceptualized, created, and has maintained the _refractiveindex.info_ database throughout the years, ensuring its continuous update and improvement to meet the evolving needs of the optics and photonics community. The compilation, verification, and organization of the data, as well as the development and maintenance of the associated tools included with the database, were all carried out by M.N.P. The invaluable feedback and data contributions from the user community have played a crucial role in enhancing the comprehensiveness and accuracy of the database. 

## **competing interests** 

The author declares no competing interests. However, for complete transparency, it is noted that the author is the owner of the RefractiveIndex.INFO website, which utilizes the _refractiveindex.info_ database to provide optical constants. The website generates modest revenue from advertisements, which primarily covers maintenance expenses including web hosting, domain registration, and email services. 

## **additional information** 

**Correspondence** and requests for materials should be addressed to M.N.P. 

**Reprints and permissions information** is available at www.nature.com/reprints. 

**Publisher’s note** Springer Nature remains neutral with regard to jurisdictional claims in published maps and institutional affiliations. 

**Open Access** This article is licensed under a Creative Commons Attribution 4.0 International License, which permits use, sharing, adaptation, distribution and reproduction in any medium or format, as long as you give appropriate credit to the original author(s) and the source, provide a link to the Creative Commons licence, and indicate if changes were made. The images or other third party material in this article are included in the article’s Creative Commons licence, unless indicated otherwise in a credit line to the material. If material is not included in the article’s Creative Commons licence and your intended use is not permitted by statutory regulation or exceeds the permitted use, you will need to obtain permission directly from the copyright holder. To view a copy of this licence, visit http://creativecommons.org/licenses/by/4.0/. 

© The Author(s) 2024 

Scientific **Data** | _(2024) 11:94_ | https://doi.org/10.1038/s41597-023-02898-2 

19 

