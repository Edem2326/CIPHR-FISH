# Cross-Hybridization-Inference-for-Phylogenetic-Resolution-CIPHR---FISH


This repository contians the codes, scripts, reference datasets, and example images for implementing CIPHR-FISH analysis workflows and reproduce figures inthe manuscript.
Additionally, the raw sequences generated for this study can be found in the NCBI Short Read Archive under [BioProject no. ID](link).


### To cite this work
Adade, EE, Wang, R., Henebery, CM.,Lemus, AA., Stevick, R.J., Pérez-Pascual, D.,Audrain, B., Orsino, A., Farnsworth, D., Ghigo, J-M., Valm, AM. (2026) Cross Hybridization Inference for Phylogenetic Resolution (CIPHR)- FISH enables microbiome imaging with strain level taxonomic resolution ......

### Overview
*CIPHR-FISH is a multiplex fluorescence in situ hybridization (FISH)* framework designed to enhance phylogenetic resolution in spatial microbial imaging. Rather than treating probe cross-hybridization and spectral overlap as noise, CIPHR-FISH leverages structured signal patterns across multiplex probe panels to improve discrimination among closely related bacterial taxa.

### Conceptual rationale
Multiplex FISH approaches often face limitations due to:
1. Spectral overlap between fluorophores
2. Cross-hybridization of 16S FSH probes due to high 16S sequqnce homology especialy among closely relted taxa
3. Limited strain-level resolution

CIPHR-FISH transforms these constraints into informative signal features. By modeling cross-hybridization structure across probes, the framework improves strain-resolved spatial mapping of microbial communities in situ.

### Repository content
1. Codes/ -Analysis scripts and pieplines
2. Reference -images/ - Example imaging datasets
3. test data/ -minimal dataset for workflow

### STEP by STEP
Setup Instructions:

Download the code: Place all the code files in a named folder, *Eg. "Training" or "Test" or "Reference"*

Download the data: Download the dataset and place it in a folder named data inside the corresponding folder.

Description:

#### Image Preprocessing in *FIJI is just ImageJ (v1.54p)*
1. Concatenate all the channels into 1 file (82 channels, depending on your imaging dataset)
2. Save the new image
3. To the training data set (50 x 50 pixels) and test dataset, apply a median filter or radius 2.0 to suppress noise
4. Make an MIP of the image and threshold to produce a banary mask.

#### Training and model generation in *MATLAB*
5. Use these functions to read your image files and extract your foreground pixels
[readMultipageTiff.m](/readMultipageTiff.m) - a function for reading multiple tiff files in the data set
[TrainingDataset.m](/TrainingDataset.m) - a function for extracting and saving all your training data set and compiling it not a single table/matrix for training the SVM model

6. Save the output table (predictors and 10 unques classes) as a ['filename'.csv](/'filename'.csv) to the corresponding folder or workspace.
7. Down the Classifiication learner from the Machine Learning and Deep Learning Toolkit for MATLAB App
8. Upload the data and,train your SVM model generated from your reference dataset. Used the Bayesian Opimization over 30 iteration with 5 corss validation.
[trainclassifier.m](/trainclassifier.m) - A function for generating the model
9. Export your training model as a [trainedmodel.mat](/trainedmodel.mat)

10. Load up this model to the workspace and apply it to classify the test images.
[classify.m](/classify.m) - for classiyfing the test image
11. Image outputs 10 independent channels (each representing one microbial taxa)

### Contributors
[Emmanuel Edem Adade](/Edem2326) – Conceptualization, algorithm development, experimental design, Image implemetation
[Colin M Henebery](/cmhen) – Algorithm development
Alex Valm – Supervision and strategic guidance

### Acknowledgments
This work was funded by National Institute of Health (NIH) grant R01DE030927 to AMV. The Zeiss LSM 980 multispectral confocal microscope at the University at Albany was funded by the Office of the Director, NIH, under Award Number S10OD028600. D.P.P was funded by the program ‘‘Integrative Biology of Emerging Infectious Diseases’’ (grant ANR-10-LABX-62-IBEID). 

We thank members of the [Ruogu Wang](/WANGRUOGU) and Alex A Lemus for discussions and technical assistance.

### Licensing
This repository is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0). Commercial use requires explicit written permission from the authors.
