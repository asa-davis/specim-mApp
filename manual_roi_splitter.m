clear;

%MAKE SURE TO SELECT SAMPLES IN ORDER FROM FIRST TO LAST (TYPICALLY BIGGEST
%TO SMALLEST)

%INPUT FILE INFO
%---------------
tree_code = 'L_6_4';
file_name = 'L_6_4_1-8(all)_2019-07-19_18-34-16';
start_index = 1;
finish_index = 8;
%----------------

%build file paths
data = [tree_code, '\', file_name, '\capture\'];
preview_img_file = [tree_code, '\', file_name, '\', file_name, '.png'];

%getting hyperspectral data
[HS,Dref,Wref,wavelength] = HS_SpecImport(data); % read in raw data

wr_av = mean(Dref); % calc mean dark reference reflectance
dr_av = mean(Wref); % calc mean white reference reflectance
sample_norm = (HS - dr_av) ./ (wr_av - dr_av); % normalize reflectance values

%getting preview image for mask
mask_img = imread(preview_img_file);

%cut off noisy edges
width_range = 24:600;

sample_norm = sample_norm(:,width_range,:);
mask_img = mask_img(:,width_range,:);

%convert mask_img to double so masks can be applied
mask_img = im2double(mask_img);

%create roi for each sample
for i = start_index:finish_index
    %create mask from polygon
    figure;
    imshow(mask_img);
    
    shape = drawpolygon;
    mask = createMask(shape);
    
    %create smallest bounding image size from polygon
    shape_y_coords = shape.Position(:,2);
    shape_x_coords = shape.Position(:,1);
    
    height_upper_bound = size(mask_img, 1);
    width_upper_bound = size(mask_img, 2);
    
    minheight = int16(min(shape_y_coords));
    maxheight = int16(max(shape_y_coords));
    
    minwidth = int16(min(shape_x_coords));
    maxwidth = int16(max(shape_x_coords));
    
    if(minheight < 1) 
        minheight = 1;
    elseif(minwidth < 1)
        minwidth = 1;
    elseif(maxheight > height_upper_bound)
        maxheight = height_upper_bound;
    elseif(maxwidth > width_upper_bound)
        maxwidth = width_upper_bound;
    end
    
    %apply to hyp data and masking img, and display masked sample
    masked_sample = mask .* sample_norm;
    masked_sample = masked_sample(minheight:maxheight, minwidth:maxwidth, :);
    imagesc(masked_sample(:,:,[1 100 200]));
    
    mask_img = ~mask .* mask_img;   
    
    %save sample
    filename = [tree_code,'\',tree_code,'_',num2str(i),'_norm_reflectance.hyp'];
    hdrfilename = [tree_code,'\',tree_code,'_',num2str(i),'_norm_reflectance.hdr'];
    info = enviinfo(masked_sample);
    enviwrite(masked_sample,info,filename,hdrfilename);
end