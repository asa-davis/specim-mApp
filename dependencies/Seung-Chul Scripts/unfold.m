function [Xmat, ysz, xsz] = unfold(enviIM, varargin)
% UNFOLD Unfold a 3-D tensor of the ENVI image to a 2-D array/matrix.  
% function [Xmat, ysz, xsz] = unfold(enviIM)
% function [Xmat, ysz, xsz] = unfold(enviIM, [bandStart, bandEnd])
%
% The code was developed by Dr. Seung-Chul Yoon 
% at the U.S. Department of  Agriculture, Agricultural Research Service, Athens, GA, USA.
% This source code is provided by Dr. Yoon for educaitonal and non-commercial purposes only.
% The source code cannot be redistributed without the prior consent by Dr. Yoon.
%

[ysz,xsz,bands] = size(enviIM);
Xvec            = enviIM(:);
Xmatfull        = reshape(Xvec,[xsz*ysz,bands]);
Xmat            = Xmatfull;

if nargin == 2
    bandRange   = varargin{1};
    if isempty(bandRange)
        return;
    else
        b1          = bandRange(1);
        b2          = bandRange(2);
        % cropping out the unwanted wavelengths
        Xmat     = Xmatfull(:,b1:b2);
    end
end


