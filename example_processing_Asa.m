%% Example code for Asa
% 5/30/19S
% Importing, normalizing and plotting HS data from the Specim FX17e

data = 'C:\Users\Asa\Desktop\Wood Science\Data\Laurie_core_test_2019-05-29_21-35-11\capture\'; % insert full path here, including the 'capture' folder

[HS,Dref,Wref,wavelength] = HS_SpecImport(data); % read in raw data

wr_av = mean(Dref(:,:,:)); % calc mean dark reference reflectance
dr_av = mean(Wref); % calc mean white reference reflectance

% apply normalization to raw data using white and dark reference values
% each 'sensor' (pixel, or row of pixels) is normalized using the white and
% dark reflectance values for that sensor.
% Illumination across the white reference bar is not even, so raw data will
% vary in reflectance across the 'width' of the image. Compare raw and
% normalized reflectance images and you'll see what I mean.
tic
for i = 1:size(HS,1)
    for j = 1:640
        sample_norm(i,j,:) = (HS(i,j,:) - dr_av(1,j,:)) ./ (wr_av(1,j,:) - dr_av(1,j,:));
    end
end
toc % 117s

% plot the normalized data
% this example code is plotting a subset of x,y coordinates and the 200th
% wavelength from the hypercube (x,y,z).
figure()
imagesc(sample_norm(1:258,1:640,[10 150 220]));
axis image; colorbar()


