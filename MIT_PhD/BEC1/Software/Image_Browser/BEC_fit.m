function num = BEC_fit( img, thres )

OD=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
if ~exist('thres','var')
    % third parameter does not exist, so default it to something
    thres = 0;
end
% turn nan and inf to 0 so that they don't count
OD(isinf(OD)) = 0;
OD(isnan(OD)) = 0;
woa=img(:,:,2)-img(:,:,3);
OD(woa<thres)=0;

% now fit 2D Gaussian + 2D PolyLog[2,z] 
fitfunc = fittype( @(therm, cond, rhoTh2, rhoC2, x, y) ...
    therm * (polylog(2, exp(-(x.^2+y.^2)/rhoTh2))) ...
    + cond * (max(1-(x.^2+y.^2)./rhoC2,0)).^(3/2), ...
    'independent', {'x', 'y'}, 'dependent', 'z' );





end