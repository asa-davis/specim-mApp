function [HS,Dref,Wref,wavelength] = HS_SpecImport(PathName)
%Read in Hyperspectral data from SPECIM

%  DEPENDENCIES: -ENVI file reader/writer --> enviread()

% Marja Haagsma - marja_haagsma@hotmail.com
% November 2018

%% Identify files to be read in directory (contains DARKREF, DATA, WHITEREF)
List=dir(PathName);
List(1:2,:)=[];

%Create list for Darkref:
ii=1;   %counter in case there are more than 1 raw data files
iii=1;  %counter in case there are more than 1 raw data files
for i=1:length(List)
    if strncmp(List(i).name,'DARK',4)
        if ~isempty(strfind(List(i).name,'raw'))
        DarkNameRaw=List(i).name;
        elseif ~isempty(strfind(List(i).name,'hdr'))
        DarkNameHeader=List(i).name;
        end
    elseif strncmp(List(i).name,'WHITE',5)
        if ~isempty(strfind(List(i).name,'raw'))
        WhiteNameRaw=List(i).name;
        elseif ~isempty(strfind(List(i).name,'hdr'))
        WhiteNameHeader=List(i).name;
        end
    else
        if ~isempty(strfind(List(i).name,'raw'))
        FileNameRaw=List(i).name;
        ii=ii+1;
        elseif ~isempty(strfind(List(i).name,'hdr'))
        FileNameHeader=List(i).name;
        iii=iii+1;
        end
    end
end


[HS,info]=enviread([PathName,FileNameRaw],[PathName,FileNameHeader]);
[Dref,Dinfo]=enviread([PathName,DarkNameRaw],[PathName,DarkNameHeader]);
[Wref,Winfo]=enviread([PathName,WhiteNameRaw],[PathName,WhiteNameHeader]);

wv=info.Wavelength;
wv=wv(2:end-1);
wavelength=strsplit(wv,',');
wavelength=str2double(wavelength);
end

