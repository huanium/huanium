function BEC_fit_1D( img )

OD=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));

% turn nan and inf to 0 so that they don't count
OD(isinf(OD)) = 0.0;
OD(isnan(OD)) = 0.0;
woa=img(:,:,2)-img(:,:,3);
OD(woa<0) = 0.0;
OD(OD<0) = 0.0;

OD_dims = size(OD);
x = OD_dims(1);
y = OD_dims(2);

polyLog_approx_terms = 25;
figure(1)
image(OD, 'CDataMapping','scaled')

figure(2)
OD = smoothdata(OD);
image(OD,'CDataMapping','scaled')

% find sum of matrix rows (integrate along x)
totalOD_rows_summed = sum(OD, 2);
% now do gaussian fit on this to find the vertical center:
ver = 1:1:x;
vertical_center_find = fit(ver.', totalOD_rows_summed,'gauss1');
coefs = coeffvalues(vertical_center_find);
vertical_center = round(coefs(2));
disp('Vertical center at: ');
disp(vertical_center);

% now plot data at y = center:
center_horizontal_slice = OD(vertical_center, :);
hor = 1:1:y;
figure(1)
plot(hor,center_horizontal_slice)
% setup to exclude outliers
tf = excludedata(hor, center_horizontal_slice, 'range', [0.001 Inf]);

% center guess
[~, max_index] = max(OD);
x_center_guess = max_index(1);

% now fit this data:
fitfunc = fittype("BEC_bimodal_fit_func(a, b, c, d, e, N, x)", ...
    'independent','x','dependent','z','problem','N');

% note that StartPoint's order is alphabetical
% so StartPoint = [a = therm, b = cond, c = rhoC, d = x_center, e = rhoTh, therm]
BECfit = fit(hor.', center_horizontal_slice.', fitfunc, ...
    'StartPoint', [1, 1, 60 , x_center_guess, 60], ...
    'Exclude',tf, ...
    'Lower',[0,0,0,0,0],...
    'problem', polyLog_approx_terms);

figure(6)
plot(BECfit, hor, center_horizontal_slice);

disp(BECfit);

% extract coeffs
coefs_BEC_fit = coeffvalues(BECfit);
disp(coefs_BEC_fit);

end