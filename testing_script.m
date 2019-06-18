data = 'C:\Users\Asa\Desktop\Wood Science\Data\Laurie_core_test_2019-05-29_21-35-11\capture\';
%getting hyperspectral data
[HS,Dref,Wref,wavelength] = HS_SpecImport(data); % read in raw data

wr_av = mean(Dref(:,:,:)); % calc mean dark reference reflectance
dr_av = mean(Wref); % calc mean white reference reflectance

sample_norm = (HS - dr_av) ./ (wr_av - dr_av);
sample_avg = mean(sample_norm, 3);

spectrum = 1:224;
for i = 1:224
    sample_list = reshape(sample_norm(:,:,i),[1,258*640]);
    spectrum(i) = mean(sample_list);
end

%plot the normalized data
figure();
imagesc(sample_avg);
figure()
plot(spectrum);