%% predict_image.m
% Classifluor: classify fluorophores / taxa using an exported Classification Learner SVM model.
% Emmanuel Edem Adade & Colin Henneberry (Valm Lab)
% February 25, 2026

%%
% Inputs:
%   - multipage TIFF (H x W x C) where each page is a channel
%   - binary mask TIFF (H x W) foreground pixels > 0
%   - trained model .mat containing a struct with field predictFcn (exported from Classification Learner)
%
% Outputs:
%   - one TIFF per class channel written to outputs/predictions/

clear; clc;

%% --------- USER SETTINGS ----------
% Repo-root relative paths are recommended
repoRoot = fileparts(fileparts(mfilename('fullpath')));

imgPath   = fullfile(repoRoot, "data", "test",   "Acav_test_M2.tif");
maskPath  = fullfile(repoRoot, "data", "test_masks", "Acav_test_M2_BW.tif");
modelPath = fullfile(repoRoot, "outputs", "trainedModel.mat");  % or models/trainedModel202602.mat

outDir    = fullfile(repoRoot, "outputs", "predictions");
% ----------------------------------------------------------

if ~exist(outDir, "dir"), mkdir(outDir); end

assert(isfile(imgPath),   "Missing image TIFF: %s", imgPath);
assert(isfile(maskPath),  "Missing mask TIFF: %s", maskPath);
assert(isfile(modelPath), "Missing model MAT: %s", modelPath);

%% Load model
S = load(modelPath);

% Accept a few common saved names; prefer "trainedModel" (recommended)
if isfield(S, "trainedModel")
    trainedModel = S.trainedModel;
elseif isfield(S, "trainedModel")
    trainedModel = S.trainedModel202602;
else
    error("Model file must contain 'trainedModel' (recommended) or 'trainedModel202602'.");
end

assert(isfield(trainedModel, "predictFcn"), "Loaded model struct is missing predictFcn.");
assert(isfield(trainedModel, "ClassificationSVM"), "Loaded model struct is missing ClassificationSVM.");

%% Read image + mask
img = readMultipageTiff(imgPath);   % H x W x C
BW  = imread(maskPath);             % H x W (or H x W x 3)

% Robust mask handling
if ndims(BW) == 3
    BW = BW(:,:,1);
end
BW = BW > 0;

% Dimensions
numChannels = size(img, 3);
sz = [size(img,1), size(img,2)];

% Optional sanity check: enforce expected channel count if your model requires it
if isfield(trainedModel, "RequiredVariables")
    expected = numel(trainedModel.RequiredVariables);
    assert(numChannels == expected, "Channel mismatch: image has %d channels but model expects %d.", numChannels, expected);
end

%% Get foreground pixel list
ind = find(BW);
[row, col] = ind2sub(sz, ind);
fSz = numel(row);

% Preallocate
fore = zeros(fSz, numChannels, 'like', img);
imax = zeros(fSz, 1);

% Extract spectra + intensity (max per pixel)
for n = 1:fSz
    fore(n,:) = img(row(n), col(n), :);
    imax(n) = double(max(fore(n,:)));
end

%% Prepare table for model (Var1..VarN)
T = array2table(double(fore), "VariableNames", compose("Var%d", 1:numChannels));

%% Predict classes
class = trainedModel.predictFcn(T);  % usually categorical

% Get class names from model
classNames = trainedModel.ClassificationSVM.ClassNames;
classCellArray = cellstr(classNames);
classArray = cellstr(class);

% Map predicted labels -> index (1..K)
[~, classIdx] = ismember(classArray, classCellArray);
assert(all(classIdx > 0), "Some predicted labels not found in model ClassNames.");

K = numel(classCellArray);

%% Build unmixed stack (one plane per class)
imgUnmix = uint8(zeros(sz(1), sz(2), K));  % uint16 for safer intensity range

for k = 1:fSz
    imgUnmix(row(k), col(k), classIdx(k)) = uint16(imax(k));
end

%% Write outputs (one TIFF per class)
[~, baseName, ~] = fileparts(imgPath);

% Optional: provide short labels for filenames.
% If you leave this empty, it will write using the model class names.
shortLabels = strings(1,K);

% Example mapping (edit to match your class order if you want)
% shortLabels = ["Aa","Av1","Av9","Pmys","Cm","Pm","Pn","Pp","Ps","Sm"];

for m = 1:K
    if strlength(shortLabels(m)) > 0
        tag = shortLabels(m);
    else
        % safe filename tag from class name
        tag = regexprep(string(classCellArray{m}), "[^A-Za-z0-9_-]", "");
    end

    outName = sprintf("%s_c%02d_%s.tif", baseName, m, tag);
    outPath = fullfile(outDir, outName);
    imwrite(imgUnmix(:,:,m), outPath);
end

%% Print summary
counts = accumarray(classIdx, 1, [K,1]);
[sortedCounts, order] = sort(counts, "descend");

fprintf("\nPrediction summary for %s\n", baseName);
for i = 1:K
    if sortedCounts(i) == 0, continue; end
    fprintf("  %-10s  %8d  (%.2f%%)\n", classCellArray{order(i)}, sortedCounts(i), 100*sortedCounts(i)/sum(counts));
end
fprintf("\nWrote %d class images to:\n  %s\n", K, outDir);