function img = fitsreadRL( filename )
%FITSREADRL Summary of this function goes here
%   Detailed explanation goes here
movefile(filename,'temp.fits');
img=fitsread('temp.fits');
delete('temp.fits');
end

