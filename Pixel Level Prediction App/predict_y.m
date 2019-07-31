function [Ypred, Ypred_valid, avg_Ypred_valid, idxValid, idxInvalid] =  predict_y(X,Coeff,minmax)
%
% The code was developed by Dr. Seung-Chul Yoon 
% at the U.S. Department of  Agriculture, Agricultural Research Service, Athens, GA, USA.
% This source code is provided by Dr. Yoon for educaitonal and non-commercial purposes only.
% The source code cannot be redistributed without the prior consent by Dr. Yoon.
%

% prediction
X_intercept     = [ones(size(X,1),1),X];
Ypred           = X_intercept*Coeff;

if isempty(minmax)
    Ypred_valid = Ypred;
    avg_Ypred   = mean(Ypred);
    idxValid    = 1:length(Ypred);
    idxInvalid  = [];
else
    minval      = minmax(1);
    maxval      = minmax(2);
    idxValid    = find(Ypred >= minval & Ypred <= maxval);
    idxInvalid  = find(Ypred < minval | Ypred > maxval);
    
    Ypred_valid = Ypred(idxValid);
    avg_Ypred_valid   = mean(Ypred_valid);
end