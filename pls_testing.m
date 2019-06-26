A = readmatrix('DF Data for Hyperspectral Good 5_19_17.csv');
moe = A(2:end,13);
nir = A(:,20:end);

x = nir(2:end,:);
y = moe;

x_filt = sgolayfilt(x,2,9);

figure()
hold on;
for i = 1:10
    plot(x_filt(i,:));
end
hold off

figure
[Xloadings,Yloadings,Xscores,Yscores,betaPLS10,PLSPctVar] = plsregress(x,y,10);
plot(1:10,cumsum(100*PLSPctVar(2,:)),'-bo')

