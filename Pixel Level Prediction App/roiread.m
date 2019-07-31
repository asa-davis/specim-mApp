function [roiIM, Colormap] = roiread(name)
%
% The code was developed by Dr. Seung-Chul Yoon 
% at the U.S. Department of  Agriculture, Agricultural Research Service, Athens, GA, USA.
% This source code is provided by Dr. Yoon for educaitonal and non-commercial purposes only.
% The source code cannot be redistributed without the prior consent by Dr. Yoon.
%

% Read the ROI image file
if isfile(name)
    [roiIM , Colormap]  = imread(name);
    if ndims(roiIM) ~= 2
        error(sprintf('The ROI image should be a 2D image.'));
    end
else
    error('Provide a string of the ROI image (tiff, png, etc.');
end