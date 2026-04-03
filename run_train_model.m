%% run_train_model.m
% Emmanuel Edem Adade & Colin Henneberry (Valm Lab)
% February 25, 2026

%%
% Train the exported Classification Learner model (You can use the classification learner directly and export the model) 
% on the combined CSV and save a .mat model file for reuse.

clear; clc;

repoRoot = fileparts(fileparts(mfilename('fullpath')));
dataCsv  = fullfile(repoRoot, "outputs", "Trainingdataset.csv");
outModel = fullfile(repoRoot, "outputs", "trainedModel.mat");

assert(isfile(dataCsv), "Missing training CSV: %s", dataCsv);

T = readtable(dataCsv);

% Ensure id is categorical (safe)
if ~iscategorical(T.id)
    T.id = categorical(string(T.id));
end

% Train (this calls your exported function)
[trainedModel, validationAccuracy] = trainClassifier(T);

fprintf("5-fold CV accuracy: %.4f\n", validationAccuracy);

save(outModel, "trainedModel", "validationAccuracy");
fprintf("Saved model to: %s\n", outModel);