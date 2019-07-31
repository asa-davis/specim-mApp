function Xout = pretreatment(Xmat,method)
%
% The code was developed by Dr. Seung-Chul Yoon 
% at the U.S. Department of  Agriculture, Agricultural Research Service, Athens, GA, USA.
% This source code is provided by Dr. Yoon for educaitonal and non-commercial purposes only.
% The source code cannot be redistributed without the prior consent by Dr. Yoon.
%

% Pre-treatment: 2nd derivative via SAVGOL
if method == 'savgol'
    window_width    = 9;
    mderiv          = 2;
    porder          = 2;
    Xout            = savgolay(Xmat,window_width,porder,mderiv);
else
    error(sprintf('%s is not supported.',method));
end