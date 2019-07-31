function [IMpred, yout] = predict_image(enviImageFilename, modelCoffs, params)

%modified to remove roi functionality to simplify for app dev
%
% The code was developed by Dr. Seung-Chul Yoon 
% at the U.S. Department of  Agriculture, Agricultural Research Service, Athens, GA, USA.
% This source code is provided by Dr. Yoon for educaitonal and non-commercial purposes only.
% The source code cannot be redistributed without the prior consent by Dr. Yoon.
%

bandRange    = params.wavebandRange;
MinMaxValues = params.MinMaxValues;

% Read the ENVI file
[filepath,basename,~]   = fileparts(enviImageFilename);
enviheaderFilename      = strcat(fullfile(filepath,basename),'.hdr');

[enviIM, enviInfo]      = enviread(enviImageFilename,enviheaderFilename);
if params.bConvertToAbsorbance == true
    enviIM                  = spectralunit_conversion(enviIM, '%reflectance', 'absorbance');
end

% Unfold the 3-D ENVI array to a 2-D matrix
[Xmat, ysz, xsz]        = unfold(enviIM, bandRange); % bandRage = [bandStart, bandEnd]

% Pre-treatment
Xmat_sg                 = pretreatment(Xmat,'savgol');

% Y-prediction
[Ypred, Ypred_valid, avg_Y_valid, idxValid, idxInvalid] = predict_y(Xmat_sg,modelCoffs,MinMaxValues);
yout.Ypred          = Ypred;
yout.Ypred_valid    = Ypred_valid;
yout.avg_Y_valid    = avg_Y_valid;
yout.idxValid       = idxValid;
yout.idxInvalid     = idxInvalid;

% Create a prediction image
[IMpred] = create_prediction_image(Ypred, xsz, ysz);


