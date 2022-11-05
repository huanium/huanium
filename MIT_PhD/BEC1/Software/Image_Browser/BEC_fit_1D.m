function BEC_fit_1D( img, rho_thermal_guess, rho_condensate_guess, app )

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

polyLog_approx_terms = 5;
% figure(1)
% image(OD, 'CDataMapping','scaled')

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
center_horizontal_slice = 0;
% center_horizontal_slice = OD(vertical_center, :);
% add n rows above and n below and divide by (n+n+1)=2n+1
n=10;
for i = -n:1:n
    center_horizontal_slice = center_horizontal_slice + OD(i + vertical_center, :)/(2*n+1);
end



hor = 1:1:y;
% figure(1)
% plot(hor,center_horizontal_slice)
% setup to exclude outliers
tf = excludedata(hor, center_horizontal_slice, 'range', [0.001 Inf]);

% center guess
[~, max_index] = max(OD);
x_center_guess = max_index(1);
background_guess = 0.1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% (1) determine region occupied by bimodal dist. 
%%%% obtain initial Thomas-Fermi params

% now fit this data:
fitfunc = fittype("BEC_bimodal_fit_func(a, b, c, d, e, f, N, x)", ...
    'independent','x','dependent','z','problem','N');

% note that StartPoint's order is alphabetical
% so StartPoint = [a = therm, b = cond, c = rhoC, d = x_center, e = rhoTh]
BECfit = fit(hor.', center_horizontal_slice.', fitfunc, ...
    'StartPoint', [1, 1, rho_condensate_guess , x_center_guess, rho_thermal_guess, background_guess], ...
    'Exclude',tf, ...
    'Lower',[0,0,0,0,0,0],...
    'problem', polyLog_approx_terms);

% extract coeffs
coefs_BEC_fit = coeffvalues(BECfit);
disp('1st Thermal factor: ')
disp(coefs_BEC_fit(1))
disp('1st Condensate factor')
disp(coefs_BEC_fit(2))
disp('1st rho condensate: ')
disp(coefs_BEC_fit(3))
disp('1st Center location: ')
disp(coefs_BEC_fit(4) + app.Xmin_BEC.Value)
disp('1st rho thermal: ')
disp(coefs_BEC_fit(5))
disp('1st background: ')
disp(coefs_BEC_fit(6))

% plotting
figure(6)
plot(BECfit, hor, center_horizontal_slice);
hold on
xline(coefs_BEC_fit(4));
xline(coefs_BEC_fit(4)+round(app.BEC_diameter.Value/2));
xline(coefs_BEC_fit(4)-round(app.BEC_diameter.Value/2));
% calculate TF_fit, with scaling factor S = 1.2
TF_fit = coefs_BEC_fit(2)*(max(1-(hor-coefs_BEC_fit(4)).^2/(coefs_BEC_fit(3))^2 ,0)).^(3/2) + coefs_BEC_fit(6);
therm_fit = coefs_BEC_fit(1)*approx_polylog(2,exp(-(hor-coefs_BEC_fit(4)).^2/(2*coefs_BEC_fit(5)^2)),25);
plot(hor, TF_fit)
plot(hor, therm_fit)
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% (2) subtract BEC contribution from original data:

figure(7)
slice_wo_BEC = center_horizontal_slice - TF_fit;
plot(hor, slice_wo_BEC)
% detect and plot the bad center region:

S = 1.0;
xhigh_bad = round(coefs_BEC_fit(4)+S*coefs_BEC_fit(3));
xlow_bad = round(coefs_BEC_fit(4)-S*coefs_BEC_fit(3));
hold on
xline(xhigh_bad);
xline(xlow_bad);
hold off
% now fit this with thermal part, exclude the bad center region:
xbad = ~excludedata(hor, slice_wo_BEC, 'domain', [round(xlow_bad)  round(xhigh_bad)]);
%slice_wo_BEC(xlow_bad:xhigh_bad) = 0;
% now fit this data:
% a = background
% b = therm factor
% x_center = coefs_BEC_fit(4)
x_center = coefs_BEC_fit(4);
% c = rho_therm
fitfunc_wo_BEC = fittype(@(c1,c2,c3,x) ...
    c1 + c2.*approx_polylog(2,exp(-(x-x_center).^2/(2*c3^2)),polyLog_approx_terms), ...
    'independent','x', 'dependent', 'y');

% note that StartPoint's order is alphabetical
fit_wo_BEC = fit(hor.', slice_wo_BEC.', fitfunc_wo_BEC, ...
    'StartPoint', [0.1, 1, rho_thermal_guess], ...
    'Exclude',xbad, ...
    'Lower',[0,0,0]);


% extract coeffs
coefs_fit_wo_BEC = coeffvalues(fit_wo_BEC);
disp('2nd background term: ')
disp(coefs_fit_wo_BEC(1))
disp('2nd Thermal factor')
disp(coefs_fit_wo_BEC(2))
disp('2nd thermal stdev: ')
disp(coefs_fit_wo_BEC(3))

% plotting
figure(8)
plot(fit_wo_BEC, hor, slice_wo_BEC);
hold on
xline(x_center);
xline(xlow_bad);
xline(xhigh_bad);
hold off

a1 = coefs_fit_wo_BEC(1);
a2 = coefs_fit_wo_BEC(2);
a3 = coefs_fit_wo_BEC(3);

thermal_fit = a1 + a2.*approx_polylog(2,exp(-(hor-x_center).^2/(2*a3^2)),polyLog_approx_terms);
% now compute OD without thermal part:
center_horizontal_slice_wo_thermal = center_horizontal_slice - thermal_fit;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% (3) now fit the remaining data to a TF profile:

% exclude weird data, for the final time
cutoff = Inf;
bad_final = excludedata(hor, center_horizontal_slice_wo_thermal, 'range', [0.001 cutoff]);
center_cutoff = round((xhigh_bad - xlow_bad)/3.5);
bad_center = ~excludedata(hor, center_horizontal_slice_wo_thermal, 'domain', [x_center-center_cutoff  x_center+center_cutoff]);
bad_region = bad_final|bad_center;

% now fit this data:
fitfunc_BEC = fittype(@(b1,b2,b3,x) ...
    b1+ b2*(max(1-(x-x_center).^2/b3^2 ,0)).^(3/2), ...
    'independent','x', 'dependent', 'y');

% note that StartPoint's order is alphabetical
% b1: background
% b2: condensate factor
% b3: center_location
% b4: rho_cond_guess
fit_BEC_final = fit(hor.', center_horizontal_slice_wo_thermal.', fitfunc_BEC, ...
    'StartPoint', [0.1, 4, rho_condensate_guess], ...
    'Exclude',bad_region, ...
    'Lower',[0,0,0]);


% extract coeffs
coefs_fit_BEC_final = coeffvalues(fit_BEC_final);
disp('3rd background term: ')
disp(coefs_fit_BEC_final(1))
disp('3rd condensate factor')
disp(coefs_fit_BEC_final(2))
disp('3rd condensate half width (TF radius): ')
disp(coefs_fit_BEC_final(3))

app.BECFitDiameter.Value = round(coefs_fit_BEC_final(3)*2);

% plotting
figure(9)
plot(fit_BEC_final, hor, center_horizontal_slice_wo_thermal);
hold on
xline(x_center);
xline(x_center+round(app.BECFitDiameter.Value/2));
xline(x_center-round(app.BECFitDiameter.Value/2));
hold off


end