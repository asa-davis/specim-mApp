% -- IMPORT MOE DATA AND AVERAGED SPECTRUM FOR 292 SAMPLES
A = readmatrix('DF Data for Hyperspectral Good 5_19_17.csv');
moe = A(2:end,13);
nir = A(:,20:end);

x = nir(2:end,:);
y = moe;
num_samples = length(moe);

%-- PLOT RAW DATA
% figure()
% hold on;
% for i = 1:392
%     plot(x(i,:));
% end
% hold off

%-- SGOLAY DIFFERENTIATION ON ALL DATA
%sgolay messes with first and last 4 wavelengths which must be cropped out
%after. Add filler columns.

[x_filt,dif_filt] = sgolay(2,9);
x_2nd_deriv = zeros(size(x));
stepsize = 2;
for i = 1:num_samples
    x_2nd_deriv(i,:) = conv(x(i,:), factorial(2)/(-stepsize)^2 * dif_filt(:,3), 'same');
end

%first and last 4 wavelengths get very noisy after taking 2nd derivative
%x_2nd_deriv = x_2nd_deriv(:,5:696);

%plot 2nd derivative of x data
figure()
title('second derivative of spectral data');
hold on;
for i = 1:num_samples
    plot(x_2nd_deriv(i,:));
end
hold off

%-- SPLIT DATA 75/25 CALIBRATION/VALIDATION USING DUPLEX ALGORITHM
%use 2nd derivative of x data
num_cal = num_samples * (0.75);
num_test = num_samples - num_cal;

[cal_index, val_index] = duplex(x_2nd_deriv, num_test);

x_cal = x_2nd_deriv(cal_index,:);
y_cal = y(cal_index,:);
x_val = x_2nd_deriv(val_index,:);
y_val = y(val_index,:);

%-- CALIBRATE PLS MODEL AND PLOT INFO
num_components = 10;
disp(['Calibrating PLS model with ',num2str(num_components),' components.'])

[Xloadings,Yloadings,Xscores,Yscores,beta,PctVar,mse,stats] = plsregress(x_cal,y_cal,num_components,'cv',4);

%plot variance explained per component
figure()
plot(1:num_components,cumsum(100*PctVar(2,:)),'-bo');
title('y variance explained per component');
xlabel('Number of PLS components');
ylabel('Percent Variance Explained in Y');

%plot predicted vs observed moe for calibration set
y_cal_pred = [ones(size(x_cal,1),1) x_cal] * beta;

figure()
plot(y_cal,y_cal_pred,'o');
title('prediction vs observed moe in calibration set');
xlabel('observed moe');
ylabel('predicted moe');

%plot predicted vs observed moe for validation set
y_val_pred = [ones(size(x_val,1),1) x_val] * beta;

figure()
plot(y_val,y_val_pred,'o');
title('predicted vs. observed moe in validation set');
xlabel('observed moe');
ylabel('predicted moe');

%plot weight of diff frequencies
figure()
plot(1:size(x_cal,2),stats.W,'-');
title('Weighting of wavelengths for all components');
xlabel('Wavelength');
ylabel('PLS Weight');

%plot MSE for predictor and response data
figure()
[axes,h1,h2] = plotyy(0:num_components,mse(1,:),0:num_components,mse(2,:));
set(h1,'Marker','o')
set(h2,'Marker','o')
legend('MSE Predictors','MSE Response')
xlabel('Number of Components')

%calculate r2 values
TSS = sum((y_cal-mean(y_cal)).^2);
RSS = sum((y_cal-y_cal_pred).^2);
R2_cal = 1 - RSS/TSS

TSS = sum((y_val-mean(y_val)).^2);
RSS = sum((y_val-y_val_pred).^2);
R2_val = 1 - RSS/TSS