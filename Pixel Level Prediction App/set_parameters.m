function params = set_parameters(WoodPropertyToPredict, bConvertToAbsorbance)
%
% The code was developed by Dr. Seung-Chul Yoon 
% at the U.S. Department of  Agriculture, Agricultural Research Service, Athens, GA, USA.
% This source code is provided by Dr. Yoon for educaitonal and non-commercial purposes only.
% The source code cannot be redistributed without the prior consent by Dr. Yoon.
%

GroundTruthFileName         = 'DF data with SG MOE MOR predicted from 2nd derivative 10_16_18.txt';

if      isequal(WoodPropertyToPredict, 'MOE')
    GroundthTruthColNum     = 17;
    %PLS_Model_Filename      =  'Hyperspectral MOE PLS coefficients_10_16_18_numeric.csv'; % no text headers
    %numLatentVariableToKeep = 5;
    wavebandRange           = []; % []=all bands
    MinMaxValues            = [0,30];
    numColors               = 64; 
    cmaplim                 = [0,20];
elseif  isequal(WoodPropertyToPredict, 'MOR')
    GroundthTruthColNum     = 14;     
    %PLS_Model_Filename      = 'Hyperspectral MOR PLS coefficients_10_16_18_numeric.csv'; % no text headers
    %numLatentVariableToKeep = 6;
    wavebandRange           = []; % []=all bands
    MinMaxValues            = [0,100];
    numColors               = 64; 
    cmaplim                 = [0, 100];
elseif  isequal(WoodPropertyToPredict, 'SG')
    GroundthTruthColNum     = 23;
    %PLS_Model_Filename      = 'Hyperspectral SG Lumber PLS coefficients_10_16_18_numeric.csv'; % no text headers
    %numLatentVariableToKeep = 7;
    wavebandRange           = []; % []=all bands
    MinMaxValues            = [0,1];
    numColors               = 64; 
    cmaplim                 = [0.25, 0.75];
else
    error(sprintf('%s is not supported'));
end

%params.PLS_Model_Filename       = PLS_Model_Filename;
params.GroundTruthFileName      = GroundTruthFileName;
params.GroundthTruthColNum      = GroundthTruthColNum;
%params.numLatentVariableToKeep  = numLatentVariableToKeep;
params.wavebandRange            = wavebandRange;
params.MinMaxValues             = MinMaxValues;
params.numColors                = numColors;
params.cmaplim                  = cmaplim;
params.bConvertToAbsorbance     = bConvertToAbsorbance;
