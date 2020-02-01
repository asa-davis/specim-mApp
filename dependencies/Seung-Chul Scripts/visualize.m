function visualize(ax, IM, cmaplim, numColors)
%
% The code was developed by Dr. Seung-Chul Yoon 
% at the U.S. Department of  Agriculture, Agricultural Research Service, Athens, GA, USA.
% This source code is provided by Dr. Yoon for educaitonal and non-commercial purposes only.
% The source code cannot be redistributed without the prior consent by Dr. Yoon.
%

nIM             = IM;
nIM(IM <= cmaplim(1))       = cmaplim(1);
nIM(IM >= cmaplim(2))       = cmaplim(2);

scale           = cmaplim(2)-cmaplim(1);
scaledM         = (nIM-cmaplim(1))/scale;
indIM           = round(scaledM * numColors);
maxind          = max(indIM(:));
cJetMap         = colormap(ax,jet(numColors));
cmap            = cJetMap(1:maxind,:);

axis(ax,'equal');

imagesc(ax,real(nIM),cmaplim); 
colormap(ax,jet(numColors)); 
caxis(ax,cmaplim); 
cb3 = colorbar(ax,'EastOutside');

    
