function Xsg = savgolay(X, window_width, polynomial_order, derivative_order)
%
% The code was developed by Dr. Seung-Chul Yoon 
% at the U.S. Department of  Agriculture, Agricultural Research Service, Athens, GA, USA.
% This source code is provided by Dr. Yoon for educaitonal and non-commercial purposes only.
% The source code cannot be redistributed without the prior consent by Dr. Yoon.
%

[b,g]           = sgolay(polynomial_order, window_width);
p               = derivative_order;

dt              = 1;
kernel          = factorial(p)/(-dt)^p * g(:,p+1);
Xsg             = conv2(X,kernel','valid');
% Xsg             = conv2(X,kernel','same');
% offset          = floor(window_width/2);
% Xsg             = Xsg(:,offset+1:end-offset);
