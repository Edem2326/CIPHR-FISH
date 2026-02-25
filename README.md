# Cross-Hybridization-Inference-for-Phylogenetic-Resolution-CIPHR---FISH
Cross Hybridization Inference for Phylogenetic Resolution (CIPHR)- FISH

# Overview
CIPHR-FISH is a multiplex fluorescence in situ hybridization (FISH) framework designed to enhance phylogenetic resolution in spatial microbial imaging. Rather than treating probe cross-hybridization and spectral overlap as noise, CIPHR-FISH leverages structured signal patterns across multiplex probe panels to improve discrimination among closely related bacterial taxa.

This repository provides code, reference datasets, and example images for implementing CIPHR-FISH analysis workflows.

# Conceptual rationale
Multiplex FISH approaches often face limitations due to:
1. Spectral overlap between fluorophores
2. Cross-hybridization of 16S FSH probes due to high 16S sequqnce homology especialy among closely relted taxa
3. Limited strain-level resolution

CIPHR-FISH transforms these constraints into informative signal features. By modeling cross-hybridization structure across probes, the framework improves strain-resolved spatial mapping of microbial communities in situ.

# Repository content
1. Codes/ -Analysis scripts and pieplines
2. Reference -images/ - Example imaging datasets
3. test data/ -minimal dataset for workflow

# Application
CIPHR-FISH has been applied to:

1. Defined microbial communities in gnotobiotic zebrafish and artificial microbial communities
2. Strain-resolved spatial mapping in host-associated microbiota in zebrafish model in vivo

The framework is adaptable to other multiplex FISH systems and microbial imaging contexts.

# Citation

# Contributors
Emmanuel Edem Adade – Conceptualization, algorithm development, experimental design, Image implemetation
Colin M Henebery – Algorithm development
Alex Valm – Supervision and strategic guidance

# Acknowledgments
This work was funded by National Institute of Health (NIH) grant R01DE030927 to AMV. The Zeiss LSM 980 multispectral confocal microscope at the University at Albany was funded by the Office of the Director, NIH, under Award Number S10OD028600. D.P.P was funded by the program ‘‘Integrative Biology of Emerging Infectious Diseases’’ (grant ANR-10-LABX-62-IBEID). 

We thank members of the Ruogu Wang and Alex A Lemus for discussions and technical assistance.

# Licensing
This repository is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0). Commercial use requires explicit written permission from the authors.
