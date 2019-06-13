%% Testing vectorized normalization
% 6/6/19S

data = 'C:\Users\Asa\Desktop\Wood Science\Data\Laurie_core_test_2019-05-29_21-35-11\capture\'; % insert full path here, including the 'capture' folder

[HS,Dref,Wref,wavelength] = HS_SpecImport(data); % read in raw data

wr_av = mean(Dref(:,:,:)); % calc mean dark reference reflectance
dr_av = mean(Wref); % calc mean white reference reflectance

%Normalizing 
    %Looped
    tic
    for i = 1:size(HS,1)
        for j = 1:640
            sample_norm(i,j,:) = (HS(i,j,:) - dr_av(1,j,:)) ./ (wr_av(1,j,:) - dr_av(1,j,:));
        end
    end
    toc % 117s

    %Vectorized
    sample_norm2 = (HS - dr_av) ./ (wr_av - dr_av);

    
    
%testing that matrix subtraction works as expected
loopmath = (HS - dr_av);
for i = 1:size(HS,1)
    for j = 1:640
        matrixmath(i,j,:)  = HS(i,j,:) - dr_av(1,j,:);
    end
end

%both come out true !
isequal(loopmath, matrixmath)       
isequal(sample_norm, sample_norm2)

%plot the normalized data
%Images appear identical
figure('name','Looped');
imagesc(sample_norm(:,:,[75 150 224]));
colorbar();

figure('name','Vectorized');
imagesc(sample_norm2(:,:,[75 150 224]));
colorbar();