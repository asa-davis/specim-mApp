function [IM] = create_prediction_image(Y, xsz, ysz)
%modified to remove roi functionality to simplify for app dev
%
% The code was developed by Dr. Seung-Chul Yoon 
% at the U.S. Department of  Agriculture, Agricultural Research Service, Athens, GA, USA.
% This source code is provided by Dr. Yoon for educaitonal and non-commerc ial purposes only.
% The source code cannot be redistributed without the prior consent by Dr. Yoon.
%

% Create a prediction image
IM   = reshape(Y,[ysz,xsz]);

% Mask out from the out-of-range value indices and the ROI mask
IM_masked             = IM;
