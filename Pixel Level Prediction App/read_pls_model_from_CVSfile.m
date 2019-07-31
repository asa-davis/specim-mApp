function [RegressionCoef,Wavelength] = read_pls_model_from_CVSfile(modelPath,PLS_Model_Filename)
%
% The code was developed by Dr. Seung-Chul Yoon 
% at the U.S. Department of  Agriculture, Agricultural Research Service, Athens, GA, USA.
% This source code is provided by Dr. Yoon for educaitonal and non-commercial purposes only.
% The source code cannot be redistributed without the prior consent by Dr. Yoon.
%

% Read the PLS regression coefficients from a CSV file (PLS_Model_Filename) with PLS loadings. 

D       = csvread(fullfile(modelPath,PLS_Model_Filename)); % read a file with the PLS regression coefficients

% Change how to read, as needed.
Wavelength      = D(2:end,1);
RegressionCoef  = D(1:end,2:end);