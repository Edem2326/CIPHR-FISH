%% build_training_set.m
% Emmanuel Edem Adade & Colin Henneberry (Valm Lab)
% February 25, 2026

%%
% Reproducible foreground spectra extraction + training set builder
% Works on any machine if folder structure + filenames match README.

%Clear MATLAB's memory
clear; clc;

%% --- Locate repository root ---
thisFile = mfilename('fullpath');
scriptsDir = fileparts(thisFile);
repoRoot = fileparts(scriptsDir);

rawDir    = fullfile(repoRoot, "data", "reference");
maskDir   = fullfile(repoRoot, "data", "ref_masks");
outPerDir = fullfile(repoRoot, "outputs", "per_taxon");
outTrain  = fullfile(repoRoot, "outputs", "Trainingdataset.csv");

assert(exist(rawDir,"dir")==7,  "Missing folder: %s", rawDir);
assert(exist(maskDir,"dir")==7, "Missing folder: %s", maskDir);

if ~exist(outPerDir,"dir"), mkdir(outPerDir); end
if ~exist(fileparts(outTrain),"dir"), mkdir(fileparts(outTrain)); end

%% --- Taxa configuration (ONLY place you edit filenames/labels) ---
% name: used for output file naming
% label: stored in the "id" column of the combined training table
% img: multipage TIFF inside data/raw
% mask: binary mask TIFF inside data/masks
taxa = [
    struct("name","Acav","label","AcavT","img","Acav_train_M2_data.tif","mask","Acav_train_M2_mask.tif")
    struct("name","AverBC1","label","Aver1T","img","AverBC1_train_M2_data.tif","mask","AverBC1_train_M2_mask.tif")
    struct("name","AverBC9","label","Aver9T","img","AverBC9_train_M2_data.tif","mask","AverBC9_train_M2_mask.tif")
    struct("name","Cmas","label","cmasT","img","Cmas_train_M2_data.tif","mask","Cmas_train_M2_mask.tif")
    struct("name","Psed","label","psedT","img","Psed_train_M2_data.tif","mask","Psed_train_M2_mask.tif")
    struct("name","Pmos","label","pmosT","img","Pmos_train_M2_data.tif","mask","Pmos_train_M2_mask.tif")
    struct("name","Pmys","label","PmysT","img","Pmys_train_M2_data.tif","mask","Pmys_train_M2_mask.tif")
    struct("name","Pnit","label","pnitT","img","Pnit_train_M2_data.tif","mask","Pnit_train_M2_mask.tif")
    struct("name","Ppel","label","ppelT","img","Ppel_train_M2_data.tif","mask","Ppel_train_M2_mask.tif")
    struct("name","Smal","label","smalT","img","Smal_train_M2_data.tif","mask","Smal_train_M2_mask.tif")
];

%% --- Run extraction + build training set ---
trainingTables = cell(numel(taxa),1);
expectedChannels = [];

for i = 1:numel(taxa)
    imgPath  = fullfile(rawDir,  taxa(i).img);
    maskPath = fullfile(maskDir, taxa(i).mask);

    assert(isfile(imgPath),  "Missing image: %s", imgPath);
    assert(isfile(maskPath), "Missing mask:  %s", maskPath);

    img = readMultipageTiff(imgPath);   % H x W x C
    mask = imread(maskPath);            % H x W (or H x W x 3)
    mask = sanitizeMask(mask);

    nCh = size(img,3);
    if isempty(expectedChannels)
        expectedChannels = nCh;
    else
        assert(nCh == expectedChannels, ...
            "Channel mismatch for %s: expected %d, got %d", taxa(i).name, expectedChannels, nCh);
    end

    spectra = extractForegroundSpectra(img, mask);  % NxC

    outCsv = fullfile(outPerDir, taxa(i).name + "_foreground.csv");
    writematrix(spectra, outCsv);

   varNames = compose("Var%d", 1:nCh);   % <-- use Var, not v
T = array2table(double(spectra), "VariableNames", varNames);

% Make id categorical for classification
T.id = categorical(repmat(string(taxa(i).label), height(T), 1));
    trainingTables{i} = T;

    fprintf("Done: %-7s | foreground pixels: %d | channels: %d\n", taxa(i).name, size(spectra,1), nCh);
end

Trainin260225 = vertcat(trainingTables{:});
writetable(Trainin260225, outTrain);

fprintf("\nSaved: %s\n", outTrain);

%% -------- local helper functions --------
function mask = sanitizeMask(mask)
    if ndims(mask) == 3
        mask = mask(:,:,1);
    end
    if ~islogical(mask)
        mask = mask > 0;
    end
end

function spectra = extractForegroundSpectra(img, mask)
    assert(size(img,1)==size(mask,1) && size(img,2)==size(mask,2), ...
        "Mask size must match image size (H,W).");

    [H,W,C] = size(img);
    idx = find(mask);
    [r,c] = ind2sub([H,W], idx);

    n = numel(r);
    spectra = zeros(n, C, 'like', img);

    for k = 1:n
        spectra(k,:) = img(r(k), c(k), :);
    end
end