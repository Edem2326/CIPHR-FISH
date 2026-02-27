# Cross Hybridization Inference for Phylogenetic Resolution (CIPHR)-FISH


This repository contians the codes, scripts and example reference and test images for implementing CIPHR-FISH analysis workflows and reproduce figures in the manuscript.

### To cite this work
Adade, EE, Wang, R., Henneberry, CM.,Lemus, AA., Stevick, R.J., Pérez-Pascual, D.,Audrain, B., Orsino, A., Farnsworth, D., Ghigo, J-M., Valm, AM. (2026) Cross Hybridization Inference for Phylogenetic Resolution (CIPHR)- FISH enables microbiome imaging with strain level taxonomic resolution ......

### Overview
*CIPHR-FISH is a multiplex fluorescence in situ hybridization (FISH)* framework designed to enhance phylogenetic resolution in spatial microbial imaging. Rather than treating probe cross-hybridization and spectral overlap as noise, CIPHR-FISH leverages structured signal patterns across multiplex probe panels to improve discrimination among closely related bacterial taxa.

-------------------------------------------------------------
# STEP by STEP

- Download the MATLAB scripts: Place all the code files in a named folder, (Eg. `build_training_set.m`,`readMultiPageTIff.m`,`run_train_model.m`, `predict_image.m`) 

- Download the data: Download the dataset and place it in a folder named data inside the corresponding folder [CIPHR-FISH Validation Dataset](https://doi.org/10.5281/zenodo.18791620). 

- *Save in the same folder/directory (locally) to implement the testdata.*
-------------------------------------------------------------
#### Image Preprocessing in *FIJI is just ImageJ (v1.54p)*
1. Concatenate all the channels into 1 file (82 channels, depending on your imaging dataset)
2. Save the new image
3. To the training data set (50 x 50 pixels) and test dataset (300 x 300 pixels), apply a median filter or radius 2.0 to suppress noise
4. Make an MIP of the image and threshold to produce a banary mask.

- Sample dataset here: [CIPHR-FISH Validation Dataset](https://doi.org/10.5281/zenodo.18791620)
------------------------------------------------------------------
#### Training and model generation in *MATLAB*
5. Use these functions to read your image files and extract your foreground pixels
   
[readMultipageTiff.m](/readMultipageTiff.m) - a function for reading multiple tiff files in the data set

[build_training_set.m](/build_training_set.m) - a function for extracting and saving all your training data set and compiling it not a single table/matrix for model training.

6. The output table (predictors and 10 unques classes)is exported into a seperate output folder in the directory.
7. Down the Classifiication learner from the Machine Learning and Deep Learning Toolkit for MATLAB App
8. Upload the data and,train your SVM model generated from your reference dataset. Used the Bayesian Opimization over 30 iteration with 5 corss validation or use this classifier here:
[run_train_model.m](/run_train_model.m) - A function for generating the model
9. The model will be exported in your output directory your training model as a `trainedModel.mat` file.
-----------------------------------------------------------------------
#### CIPHR Classification in *MATLAB*
10. Load up this model to the workspace and apply it to classify the test images.

[predict_image.m](/predict_image.m) - for classiyfing the test image

11. Image outputs 10 independent channels (each representing one microbial taxa)

### Image postprocessing and color assigments in *FIJI*
12. Images are stacked together in FIJI and opened in Image5D plugin for coloring and quantification

----------------------------------------------------------------------
### Contributors
- [Emmanuel Edem Adade](https://github.com/Edem2326) – Conceptualization, writing code, algorithm development, experimental design & Image implemetation
- [Colin M Henneberry](https://github.com/cmhen) – Conceptualization, writing code & algorithm development
- Alex Valm – Conceptualization & Supervision 

### Acknowledgments
This work was funded by National Institute of Health (NIH) grant R01DE030927 to AMV. D.P.P was funded by the program ‘‘Integrative Biology of Emerging Infectious Diseases’’ (grant ANR-10-LABX-62-IBEID). 

We thank [Ruogu Wang](https://github.com/WANGRUOGU) and Alex A Lemus for discussions and technical assistance.

### Licensing
This repository is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0). Commercial use requires explicit written permission from the authors.
