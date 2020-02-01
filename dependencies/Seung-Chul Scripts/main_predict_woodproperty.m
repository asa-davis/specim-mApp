%
% The code was developed by Dr. Seung-Chul Yoon 
% at the U.S. Department of  Agriculture, Agricultural Research Service, Athens, GA, USA.
% This source code is provided by Dr. Yoon for educaitonal and non-commercial purposes only.
% The source code cannot be redistributed without the prior consent by Dr. Yoon.
%

%% Main program 
% function main_predict_woodproperty('MOE',bConvertToAbsorbance)

%%
clear;
clc;
woodprop = 'SG';
addpath('..\envi\');

%% set directories
inputFolderPath     = 'dataset\';
roiImagePath        = 'dataset\';
modelPath           = 'models\';
outputFolderPath    = 'result\';

%%
bConvertToAbsorbance = true;
envinames           = {'OR111_r32f.hyp'}; % Percent Refleance Images
roinames            = {[]}; % Provide an empty array if no ROI image is used.

%%
% bConvertToAbsorbance = false;
% envinames           = {'CA002_a32f.hyp'}; % Absorbance Image
% roinames            = {'ROI_CA002.tif'};

%% Set parameters
params                = set_parameters(woodprop, bConvertToAbsorbance);

%% Read PLS model
[plsmodel,wavelength] = read_pls_model_from_CVSfile(modelPath,params.PLS_Model_Filename);

%testing which coefficients to use
original_model = plsmodel;

%% Predict images 
Ypred_avgs = [];

for i=1:length(envinames)
    enviname             = fullfile(inputFolderPath, envinames{i});

    [IM, yout] = predict_image(enviname, plsmodel, params);

    figure();
    ax = axes();

    visualize(ax, IM, params.cmaplim, params.numColors);
    Ypred_avgs           = [Ypred_avgs, yout.avg_Y_valid];
    pause(1);
end

%% Compute the prediction performance against the reference values (spectrometer measurements).
% Ytrue_avgs      = readDependentVariable_from_TXTfile(modelPath, woodprop, params);
% compute_errors(Ytrue_avgs, Ypred_avgs);
