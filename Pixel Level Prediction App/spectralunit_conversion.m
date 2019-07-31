function Xc = spectralunit_conversion(X, intype, outtype)
% Developed by Dr. Seung-Chul Yoon
% U.S. Department of  Agriculture, Agricultural Research Service
% U.S. National Poultry Research Center
% 950 College Station Rd., Athens, GA, 30605, U.S.A.
% Email: seungchul.yoon@usda.gov
% 07/22/2019

if isequal(intype,outtype)
    Xc = X;
else
    if isequal(intype,'absorbance') && isequal(outtype,'%reflectance')
        Xc = 10.^(-X) * 100;
    elseif isequal(intype,'%reflectance') && isequal(outtype,'absorbance')
        Xc = log10(100./X);
    elseif isequal(intype,'absorbance') && isequal(outtype,'reflectance')
        Xc = 10.^(-X);
    elseif isequal(intype,'reflectance') && isequal(outtype,'absorbance')
        Xc = log10(1./X);     
    end
end