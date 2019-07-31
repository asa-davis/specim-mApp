function [R2, RMSE] = compute_errors(Ytrue, yin)
%
% The code was developed by Dr. Seung-Chul Yoon 
% at the U.S. Department of  Agriculture, Agricultural Research Service, Athens, GA, USA.
% This source code is provided by Dr. Yoon for educaitonal and non-commercial purposes only.
% The source code cannot be redistributed without the prior consent by Dr. Yoon.
%

Ypred = yin.Ypred;
idxValid = yin.idxValid;

YtrueValid = Ytrue(idxValid);
YpredValid = yin.Y_pred_valid; 

mdl        = fitlm(YpredValid, YtrueValid, 'linear');
[R2,RMSE]  = rsquare(Ytrue', mdlb.predict(YpredValid'));

fprintf('R-sqaure=%.3f, RMSE=%.3f\n',R2,RMSE);