data = 'C:\Users\Asa\Desktop\Wood Science\Data\Laurie_core_test_2019-05-29_21-35-11\capture\';
%getting hyperspectral data
[HS,Dref,Wref,wavelength] = HS_SpecImport(data); % read in raw data

wr_av = mean(Dref(:,:,:)); % calc mean dark reference reflectance
dr_av = mean(Wref); % calc mean white reference reflectance

sample_norm = (HS - dr_av) ./ (wr_av - dr_av);
sample_avg = mean(sample_norm, 3);

[rows cols numspec] = size(sample_norm);

%average spectrum for entire image
spectrum = 1:numspec;
for i = 1:numspec
    sample_list = reshape(sample_norm(:,:,i),[1,rows*cols]);
    spectrum(i) = mean(sample_list);
end

%image split into 4 sections, and average taken for each
spectrum_split = zeros(4,224);
inc = 640/4;
for i = 1:224
    for j = 1:4
        if(j == 1)
            sample_list = reshape(sample_norm(:,1:inc,i),[1,rows*inc]);
        else
            sample_list = reshape(sample_norm(:,((j-1)*inc)+1:j*inc,i),[1,rows*inc]);
        end        
        spectrum_split(j,i) = mean(sample_list);
    end
end

%plot our data and visually divide image
figure();
imagesc(sample_avg);
for j = 1:3
    l = line([j*inc, j*inc],[0,rows]);
    l.LineWidth = 1;
    l.Color = 'red';
end

%plot average spectra for each section
figure()
plot(spectrum_split(1,:));
hold on;
plot(spectrum_split(2,:));
plot(spectrum_split(3,:));
plot(spectrum_split(4,:));
axis auto;
legend('Section 1', 'Section 2', 'Section 3', 'Section 4');