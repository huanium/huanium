function num = AtomNumber( img,pixelsize,sigma, Nsat,thres )
%ATOMCOUNTING Summary of this function goes here
%   Detailed explanation goes here
OD=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
IC=(img(:,:,2)-img(:,:,1))/Nsat;
if ~exist('thres','var')
    % third parameter does not exist, so default it to something
    thres = 0;
end

% turn nan and inf to 0 so that they don't count
OD(isinf(OD)) = 0;
OD(isnan(OD)) = 0;

IC(isinf(IC)) = 0;
IC(isnan(IC)) = 0;

% count
num=(OD+IC)*pixelsize/sigma;
woa=img(:,:,2)-img(:,:,3);
num(woa<thres)=0;
% num(num>50)=0;

disp(OD)
disp(size(OD))

end

