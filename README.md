# Cross Hybridization Inference for Phylogenetic Resolution (CIPHR)-FISH


This repository contains the codes and link to reference and test images for implementing CIPHR-FISH analysis workflows and reproduce figures in the manuscript.


#### MATLAB version R2021b Update 6 (9.11.0.2207237), 64 bits (maci64), February 23, 2023


### To cite this work
Adade, EE, Wang, R., Henneberry, CM., Lemus, AA., Stevick, R.J., Pérez-Pascual, D., Audrain, B., Orsino, A., Farnsworth, D., Ghigo, J-M., Valm, AM. (2026) Cross Hybridization Inference for Phylogenetic Resolution (CIPHR)- FISH enables microbiome imaging with strain level taxonomic resolution ......

### Overview
*CIPHR-FISH is a multiplex fluorescence in situ hybridization (FISH)* framework designed to enhance phylogenetic resolution in spatial microbial imaging. Rather than treating probe cross-hybridization and spectral overlap as noise, CIPHR-FISH leverages structured signal patterns across multiplex probe panels to improve discrimination among closely related bacterial taxa.

-------------------------------------------------------------
# STEP by STEP

- Download the MATLAB scripts: Place all the code files in a named folder, (E.g. `build_training_set.m`,`readMultiPageTIff.m`,`run_train_model.m`, `predict_image.m`)
  
- Download the data: Download the dataset and place it in a folder named data inside the corresponding folder [CIPHR-FISH Validation Dataset](https://doi.org/10.5281/zenodo.18791620). 

- *Save in the same folder/directory (locally) to implement the test dataset.*
-------------------------------------------------------------

#### Training and model generation in *MATLAB*

#### STEP by STEP

# Training data extraction
1. Use these functions to read your image files and extract your foreground pixels
   
[readMultipageTiff.m](/readMultipageTiff.m) - a function for reading multiple tiff files in the data set

2. Load/Read reference images as multiTifffiles (E.g. Acav_train_M2_new, Aver1_train_M2_new,....)
3. Load/Read the reference binary/mask images (E.g. Acav_train_M2_new_BW, Aver1_train_M2_new_BW,....)

4.Use this code to extract the foreground pixel information into an array and add the label 

[build_training_set.m](/build_training_set.m) - a function for extracting and saving all your training data set and compiling it not a single table/matrix for model training.
   
5. Extract and store the pixel information into a table and add the labels (E.g. AcavT, Aver1T...)
6. The output table (predictors and 10 unique classes) is exported and saved into a separate output folder in the directory as a .csv file.


# Model generation
9. Upload the training dataset (reference) into your workspace.
10. Download Classification learner from the Machine Learning and Deep Learning Toolkit for MATLAB App.
11. Upload the training dataset into the classification learner app.
12. Train your SVM model generated from your reference dataset. Used the Bayesian Optimization over 30 iterations with 5 cross validation or use this classifier. You can perform this manually or us can employ this code:
    
[run_train_model.m](/run_train_model.m) - A function for generating the model

13. The model will be exported and saved in your output directory your training model as a `trainedModel.mat` file.
-----------------------------------------------------------------------

#### CIPHR Classification in *MATLAB*
14. Upload the saved model to the workspace and apply it to classify the test images.
    
15. Use this code for classification of test images.

[predict_image.m](/predict_image.m) - for classifying the test image

16. Image outputs 10 independent channels (each representing one microbial taxa)

### Image postprocessing and color assignments in *FIJI*
17. Images are stacked together in FIJI and opened in Image5D plugin for coloring and quantification

----------------------------------------------------------------------
### Contributors
- [Emmanuel Edem Adade](https://github.com/Edem2326) – Conceptualization, writing code, algorithm development, experimental design & Image implementation
- [Colin M Henneberry](https://github.com/cmhen) – Conceptualization, writing code & algorithm development
- Alex Valm – Conceptualization & Supervision 


We thank [Ruogu Wang](https://github.com/WANGRUOGU) and Alex A Lemus for discussions and technical assistance.

### Licensing
This repository is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0). Commercial use requires explicit written permission from the authors.
