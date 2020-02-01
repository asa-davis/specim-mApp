function Ytrue = readDependentVariable_from_TXTfile(modelPath, woodprop, params)
%
% The code was developed by Dr. Seung-Chul Yoon 
% at the U.S. Department of  Agriculture, Agricultural Research Service, Athens, GA, USA.
% This source code is provided by Dr. Yoon for educaitonal and non-commercial purposes only.
% The source code cannot be redistributed without the prior consent by Dr. Yoon.
%

% Read the values of the Dependent Variable (y-vector of ground-truth MOE, MOR and SG values) from a text file

fidtxt  = fopen(fullfile(modelPath,params.GroundTruthFileName));
strf    = repmat('%s ',[1,30]);
txtdata = textscan(fidtxt,strcat(strf,' %*[^\n]'),'Delimiter','\t','Headerlines',1);
fclose(fidtxt);

Ytrue           = [];
for i=1:length(txtdata{params.GroundthTruthColNum})
    Ytrue(i) = str2double(txtdata{params.GroundthTruthColNum}(i));           % Ground-truth SG15, MOE, MOR
end