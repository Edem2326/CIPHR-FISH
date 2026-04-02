# Cross Hybridization Inference for Phylogenetic Resolution (CIPHR)-FISH


This repository contains the codes and link to reference and test images for implementing CIPHR-FISH analysis workflows and reproduce figures in the manuscript.


#### *(MATLAB version R2021b Update 6 (9.11.0.2207237), 64 bits (maci64), February 23, 2023)*


### To cite this work
Adade, EE, Wang, R., Henneberry, CM., Lemus, AA., Stevick, R.J., Pérez-Pascual, D., Audrain, B., Orsino, A., Farnsworth, D., Ghigo, J-M., Valm, AM. (2026) Cross Hybridization Inference for Phylogenetic Resolution (CIPHR)- FISH enables microbiome imaging with strain level taxonomic resolution ......

### Overview
*CIPHR-FISH is a multiplex fluorescence in situ hybridization (FISH)* framework designed to enhance phylogenetic resolution in spatial microbial imaging. Rather than treating probe cross-hybridization and spectral overlap as noise, CIPHR-FISH leverages structured signal patterns across multiplex probe panels to improve discrimination among closely related bacterial taxa.

-------------------------------------------------------------
#### STEP by STEP

- Download all attached MATLAB codes: Save all the code files in a named folder, (E.g. `build_training_set.m`,`readMultiPageTIff.m`,`run_train_model.m`, `predict_image.m`).
  
- Download and save all images in a folder named data inside the corresponding folder [CIPHR-FISH Validation Dataset]([https://doi.org/10.5281/zenodo.18791620](https://zenodo.org/uploads/18791620?token=eyJhbGciOiJIUzUxMiIsImlhdCI6MTc3NTAwNDU2OCwiZXhwIjoxNzc3NTkzNTk5fQ.eyJpZCI6IjNlMmI2YmYzLTMzYWYtNGQzNi1hYjFjLThhNDFmMzZkYTEyYSIsImRhdGEiOnt9LCJyYW5kb20iOiI3NTA1YjgxZjk5MGQwMTFlYzAwZjI5Y2ZjZDI5ZGU2ZiJ9.0GPO8Ap54H6HPLV0EoT6MoX68cBLGy0OuxD7bUhVgzoIDLhcmT9BBb4yvcFwqZxL5y7NgggzUdJbM_iYCGKoJg). Name each folder appropriately (E.g. reference, ref_mask, test, test_masks) 
  
- *Save in the same folder/directory (locally).*

- In MATLAB, download Classification learner app from the Machine Learning and Deep Learning Toolkit for MATLAB App.
-------------------------------------------------------------

#### Training and model generation in *MATLAB*

#### A. Training data extraction
1. Use this function to read your image files.
   
[readMultipageTiff.m](/readMultipageTiff.m) - a function for reading multiple tiff files in the data set

2. Load/Read reference images as multiTifffiles (E.g. Acav_train_M2_new, Aver1_train_M2_new,....).
   
3. Load/Read the reference binary/mask images (E.g. Acav_train_M2_new_BW, Aver1_train_M2_new_BW,....).

4. Use this code to extract the foreground pixels intensity information. 

[build_training_set.m](/build_training_set.m) - a function for extracting and saving all your training data set and compiling it not a single table/matrix for model training.
   
5. Extract and store the pixel information into a table and add the labels (E.g. AcavT, Aver1T...).
 
6. The output table (82 predictors and 10 unique classes) will be exported and saved into a separate output folder in the directory as a .csv file.

#### B. Model generation
7. Upload the training dataset (reference) into your MATLAB workspace.
   
8. In the app menu, select the classification learner app.
 
9. Upload the training dataset into the classification learner app.
 
10. Train your SVM model generated from your reference dataset. Used the Bayesian Optimization over 30 iterations with 5 cross validation or use this classifier. You can perform this manually or us can employ this code:
    
[run_train_model.m](/run_train_model.m) - A function for generating the model

11. The model will be exported and saved in your output directory your training model as a `trainedModel.mat` file.
-----------------------------------------------------------------------

#### CIPHR Classification in *MATLAB*
12. Upload the saved model to the workspace and apply it to classify the test images.
    
13. Use this code for classification of test images.

[predict_image.m](/predict_image.m) - for classifying the test image

14. Image outputs will correspond to 10 independent images (each representing one microbial taxa).

----------------------------------------------------------------------
### Contributors
- [Emmanuel Edem Adade](https://github.com/Edem2326) – Conceptualization, writing code, algorithm development, experimental design & Image implementation.
- [Colin M Henneberry](https://github.com/cmhen) – Conceptualization, writing code & algorithm development
- Alex Valm – Conceptualization & Supervision. 

---------------------------------------------------------------------------
### Licensing
This repository is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0). Commercial use requires explicit written permission from the authors.
