function BEC_fit_2D( img )

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

X = 1:1:x;
Y = 1:1:y;
[XX,YY] = meshgrid(X,Y);

polyLog_approx_terms = 25;
figure(1)
image(OD, 'CDataMapping','scaled')
figure(2)
smoothOD = smoothdata(OD);
image(smoothOD, 'CDataMapping','scaled')

[~, max_index] = max(OD);
x_center_guess = max_index(1);
y_center_guess = max_index(2);


% now fit this data:
fitfunc = fittype("BEC_bimodal_fit_func_2D(a, b, c, d, e, f, N, x, y)", ...
    'independent',{'x','y'},'dependent','z','problem','N');

% note that StartPoint's order is alphabetical
% so StartPoint = [a = therm, b = cond, c = rhoC, d = x_center, e = rhoTh, f = y_center, therm]
BECfit_2D = fit([XX(:), YY(:)], smoothOD(:), fitfunc, ...
    'StartPoint', [1, 1,  50, x_center_guess, 150, y_center_guess], ...
    'Lower', [0,0,0,0,0,0], ...
    'problem', polyLog_approx_terms);

% change marker size for fitted curve:
figure(7)
surf(smoothOD, 'EdgeColor', 'none');
figure(8)
plot(BECfit_2D)
disp(BECfit_2D);


end