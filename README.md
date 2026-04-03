# Cross Hybridization Inference for Phylogenetic Resolution (CIPHR)-FISH


This repository contains the codes and link to reference and test images for implementing CIPHR-FISH analysis workflows and reproduce figures in the manuscript.


#### *(MATLAB version R2021b Update 6 (9.11.0.2207237), 64 bits (maci64), February 23, 2023)*


### To cite this work
Adade, EE, Wang, R., Henneberry, CM., Lemus, AA., Stevick, R.J., Pérez-Pascual, D., Audrain, B., Orsino, A., Farnsworth, D., Ghigo, J-M., Valm, AM. (2026) Cross Hybridization Inference for Phylogenetic Resolution (CIPHR)- FISH enables microbiome imaging with strain level taxonomic resolution ......

### Overview
*CIPHR-FISH is a multiplex fluorescence in situ hybridization (FISH)* framework designed to enhance phylogenetic resolution in spatial microbial imaging. Rather than treating probe cross-hybridization and spectral overlap as noise, CIPHR-FISH leverages structured signal patterns across multiplex probe panels to improve discrimination among closely related bacterial taxa.

-------------------------------------------------------------
#### STEP by STEP

- Create a root directory and name it.
- Create a subdirectory in the root directory and name it "codes."
- Download the MATLAB code .mfiles and and save all the code files in the "codes" directory: (`build_training_set.m`,`readMultiPageTIff.m`,`run_train_model.m`, `predict_image.m`, `trainClassifier.m`).
  
- Download and save all example image files from Zenodo: [CIPHR-FISH Validation Dataset]([https://doi.org/10.5281/zenodo.18791620](https://zenodo.org/uploads/18791620?token=eyJhbGciOiJIUzUxMiIsImlhdCI6MTc3NTAwNDU2OCwiZXhwIjoxNzc3NTkzNTk5fQ.eyJpZCI6IjNlMmI2YmYzLTMzYWYtNGQzNi1hYjFjLThhNDFmMzZkYTEyYSIsImRhdGEiOnt9LCJyYW5kb20iOiI3NTA1YjgxZjk5MGQwMTFlYzAwZjI5Y2ZjZDI5ZGU2ZiJ9.0GPO8Ap54H6HPLV0EoT6MoX68cBLGy0OuxD7bUhVgzoIDLhcmT9BBb4yvcFwqZxL5y7NgggzUdJbM_iYCGKoJg).
  
- Create a subfolder in the root directory and name it "data."

- Create 4 subfolders in the "data" directory and name them "reference," "ref_masks," "test," and "test_masks."
- Move all image files that contain "train_M2_data" in their names into the folder named, "reference."
- Move all image files that contain "train_M2_mask" in their names into the foler named, "ref_masks."
- Move all image files that contain "test_M2_data" in their names into the folder named, "test."
- Move all image files that contain "test_M2_mask" in their names into the folder named, "test_masks."

<img width="482" height="458" alt="file system" src="https://github.com/user-attachments/assets/dc3828b9-630e-43aa-94c4-76d200fc85e0" />



- In MATLAB, download Classification learner app from the machine learning and deep learning toolkit for MATLAB App.
-------------------------------------------------------------

#### Training and model generation in *MATLAB*

#### A. Training data extraction
1. Use this function to read your image files:
   
[readMultipageTiff.m](/readMultipageTiff.m) - a function for reading multi-channel tiff stacks into MATLAB.

2. Open the .m file named "[build_training_set.m](/build_training_set.m)

3. Run the code to read all reference images and image masks and extract the foreground pixels. The code will generate an output directory named "output" and the data will be saved in a table for model training, named "Trainingdataset.csv" with 82 predictors and 10 unique classes.

#### B. Model generation
4. Open the .m file named "run_train_model" to train the SVM model with Bayesian optimization over 30 iterations with 5-fold cross validation.

5. The model will be exported and saved in your output directory as a `trainedModel.mat` file.
-----------------------------------------------------------------------

#### CIPHR Classification in *MATLAB*
6. Open the .m file:
   
[predict_image.m](/predict_image.m) - for classifying the test image

7. This code will classify one example labeled data image set, "Acav." To classify other image data sets with the saved model, edit the code.

8. The output will be a set of 10 tiff images with pixel values greater than zero for that class and intensity assigned as a function of the original image. Prediction summary will be displayed in the MATLAB Command Window.

----------------------------------------------------------------------
### Contributors
- [Emmanuel Edem Adade](https://github.com/Edem2326) – Conceptualization, writing code, algorithm development, experimental design & Image implementation.
- [Colin M Henneberry](https://github.com/cmhen) – Conceptualization, writing code & algorithm development
- Alex Valm – Conceptualization & Supervision. 

---------------------------------------------------------------------------
### Licensing
This repository is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0). Commercial use requires explicit written permission from the authors.
