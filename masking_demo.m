data = 'C:\Users\Asa\Desktop\Wood Science\Data\Laurie_core_test_2019-05-29_21-35-11\capture\';
maskimg = 'C:\Users\Asa\Desktop\Wood Science\Data\Laurie_core_test_2019-05-29_21-35-11\Laurie_core_test_2019-05-29_21-35-11.png';

%getting hyperspectral data
[HS,Dref,Wref,wavelength] = HS_SpecImport(data); % read in raw data

wr_av = mean(Dref(:,:,:)); % calc mean dark reference reflectance
dr_av = mean(Wref); % calc mean white reference reflectance

sample_norm = (HS - dr_av) ./ (wr_av - dr_av);

%creating mask
I = imread(maskimg);
I = rgb2gray(I);

mask = zeros(size(I));
mask(25:end-25,25:end-25) = 1;

mask = activecontour(I,mask,300);
mask = ~mask;
figure
imshow(mask)

%plot the normalized data
figure('name','Looped');
imagesc(sample_norm(:,:,[75 150 224]));

%apply mask
sample_norm = sample_norm .* mask;
figure()
imagesc(sample_norm(:,:,[75 150 224]));