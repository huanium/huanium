function BEC_fit( img, rho_thermal_guess, rho_condensate_guess, app )
close all

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

% find sum of matrix rows (integrate along x)
totalOD_rows_summed = sum(OD, 2);
% now do gaussian fit on this to find the vertical center:
ver = 1:1:x;
vertical_center_find = fit(ver.', totalOD_rows_summed,'gauss1');
coefs = coeffvalues(vertical_center_find);
vertical_center = round(coefs(2));

% now plot data at y = center:
center_horizontal_slice = 0;
% add n rows above and n below and divide by (n+n+1)=2n+1
n=6;
for i = -n:1:n
    center_horizontal_slice = center_horizontal_slice + OD(i + vertical_center, :)/(2*n+1);
end

hor = 1:1:y;
hor_plot = hor + app.Xmin_BEC.Value;
% setup to exclude outliers
tf = excludedata(hor, center_horizontal_slice, 'range', [0.001 Inf]);

% center guess
[~, max_index] = max(center_horizontal_slice);
x_center_guess = max_index;
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

% plotting
cla(app.UIAxes_bimodal)
f = zeros(1,7);
BECfit_model = BEC_bimodal_fit_func(coefs_BEC_fit(1), ...
    coefs_BEC_fit(2), ...
    coefs_BEC_fit(3), ...
    coefs_BEC_fit(4), ...
    coefs_BEC_fit(5), ...
    coefs_BEC_fit(6), ...
    polyLog_approx_terms, ...
    hor);
f(6) = plot(app.UIAxes_bimodal, hor_plot, BECfit_model, 'DisplayName', 'Fitted Bimodal','Color','r');
hold(app.UIAxes_bimodal,'on')
f(7) = plot(app.UIAxes_bimodal, hor_plot, center_horizontal_slice, '.', ...
    'MarkerEdgeColor','b','MarkerFaceColor','b', 'DisplayName', 'OD');
f(1) = xline(app.UIAxes_bimodal, coefs_BEC_fit(4) + app.Xmin_BEC.Value,'DisplayName','Center');
f(2) = xline(app.UIAxes_bimodal, coefs_BEC_fit(4)+round(app.BEC_diameter.Value/2)+ app.Xmin_BEC.Value, 'Color','g', 'DisplayName','Guess TF radius');
f(3) = xline(app.UIAxes_bimodal, coefs_BEC_fit(4)-round(app.BEC_diameter.Value/2)+ app.Xmin_BEC.Value, 'Color','g', 'DisplayName','Guess TF radius');

% calculate TF_fit, with scaling factor S = 1.2
TF_fit = coefs_BEC_fit(2)*(max(1-(hor-coefs_BEC_fit(4)).^2/(coefs_BEC_fit(3))^2 ,0)).^(3/2) + coefs_BEC_fit(6);
therm_fit = coefs_BEC_fit(1)*approx_polylog(2,exp(-(hor-coefs_BEC_fit(4)).^2/(2*coefs_BEC_fit(5)^2)),25);

f(4) = plot(app.UIAxes_bimodal, hor_plot, TF_fit, 'DisplayName','TF from fit');
f(5) = plot(app.UIAxes_bimodal, hor_plot, therm_fit, 'DisplayName','Thermal from fit');
l1 = legend(app.UIAxes_bimodal, [f(1) f(2) f(4) f(5) f(6) f(7)]);
l1.FontSize = 6;
l1.ItemTokenSize = [5,10];
t1 = title(app.UIAxes_bimodal, 'Initial bimodal fit');
t1.FontSize = 8;
app.UIAxes_bimodal.XLim = [app.Xmin_BEC.Value  app.Xmax_BEC.Value];
app.UIAxes_bimodal.YLim = [min(BECfit_model)-0.1  max(BECfit_model)+0.1];
hold(app.UIAxes_bimodal,'off')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% (2) subtract BEC contribution from original data:

slice_wo_BEC = center_horizontal_slice - TF_fit;
% detect and plot the bad center region:
xhigh_bad = round(coefs_BEC_fit(4)+coefs_BEC_fit(3));
xlow_bad  = round(coefs_BEC_fit(4)-coefs_BEC_fit(3));

% now fit this with thermal part, exclude the bad center region:
xbad = ~excludedata(hor, slice_wo_BEC, 'domain', [round(xlow_bad)  round(xhigh_bad)]);
x_center = coefs_BEC_fit(4);
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

% plotting
cla(app.UIAxes_thermal)
g = zeros(1,5);
fit_wo_BEC_model = coefs_fit_wo_BEC(1) + ...
                    coefs_fit_wo_BEC(2).*approx_polylog(2, ...
                    exp(-(hor-x_center).^2/(2*coefs_fit_wo_BEC(3)^2)), ...
                    polyLog_approx_terms);

g(4) = plot(app.UIAxes_thermal, hor_plot, fit_wo_BEC_model, 'DisplayName', 'Fitted thrm', 'Color','r' );
hold(app.UIAxes_thermal,'on')
g(5) = plot(app.UIAxes_thermal, hor_plot, slice_wo_BEC, '.', ...
    'MarkerEdgeColor','b','MarkerFaceColor','b', 'DisplayName', 'OD - TF_{fit}');
g(1) = xline(app.UIAxes_thermal, x_center+app.Xmin_BEC.Value, 'DisplayName','Center');
g(2) = xline(app.UIAxes_thermal, xlow_bad+app.Xmin_BEC.Value,'Color','g','DisplayName','r low');
g(3) = xline(app.UIAxes_thermal, xhigh_bad+app.Xmin_BEC.Value,'Color','g','DisplayName','r high');
t2 = title(app.UIAxes_thermal, 'OD-TF_{fit}, fitted with thermal ~[r_{low}, r_{high}]');
t2.FontSize = 8;
l2 = legend(app.UIAxes_thermal, [g(1) g(2) g(3) g(4) g(5)]);
l2.FontSize = 6;
l2.ItemTokenSize = [5 10];
app.UIAxes_thermal.XLim = [app.Xmin_BEC.Value  app.Xmax_BEC.Value];
app.UIAxes_thermal.YLim = [min(fit_wo_BEC_model)-0.1  max(fit_wo_BEC_model)+0.1];
hold(app.UIAxes_thermal,'off')

a1 = coefs_fit_wo_BEC(1);
a2 = coefs_fit_wo_BEC(2);
a3 = coefs_fit_wo_BEC(3);

thermal_fit = a1 + a2.*approx_polylog(2,exp(-(hor-x_center).^2/(2*a3^2)),polyLog_approx_terms);
% now compute OD without thermal part:
center_horizontal_slice_wo_thermal = center_horizontal_slice - thermal_fit;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% (3) now fit the remaining data to a TF profile:

% exclude weird data, for the final time
cutoff = app.OD_cutoff.Value - max(thermal_fit);
bad_final = excludedata(hor, center_horizontal_slice_wo_thermal, 'range', [0.001 cutoff]);

% now look at difference between cutoff and data 
% to determine the correct value for cutoff in x
difference = center_horizontal_slice_wo_thermal - cutoff;
indices = [];
for i=1:length(center_horizontal_slice_wo_thermal)
    if abs(difference(i)) <=  0.2 % if difference within 0.2
        indices(end+1) = i;
    end
end

if length(indices) > 2 % if data is well-behaved
    xlow_bad_index = min(indices);
    xhigh_bad_index = max(indices);
    % Next, pick the max to be conservative. min() works too
    center_cutoff = max(x_center - xlow_bad_index, xhigh_bad_index - x_center);
else
    % just in case data is weird, use old method
    center_cutoff = round((xhigh_bad - xlow_bad)/3.5);
    disp('Weird data!')
end

bad_center = ~excludedata(hor, center_horizontal_slice_wo_thermal, 'domain', [x_center-center_cutoff  x_center+center_cutoff]);
bad_region = bad_final|bad_center;

% now fit this data:
fitfunc_BEC = fittype(@(b1,b2,b3,x) ...
    b1+ b2*(max(1-(x-x_center).^2/b3^2 ,0)).^(3/2), ...
    'independent','x', 'dependent', 'y');

fit_BEC_final = fit(hor.', center_horizontal_slice_wo_thermal.', fitfunc_BEC, ...
    'StartPoint', [0.1, 4, rho_condensate_guess], ...
    'Exclude',bad_region, ...
    'Lower',[0,0,0]);

% print out fit results to verify:
disp(fit_BEC_final)

% extract coeffs
coefs_fit_BEC_final = coeffvalues(fit_BEC_final);
app.BECFitDiameter.Value = round(coefs_fit_BEC_final(3)*2);

% plotting
cla(app.UIAxes_BEC)
fit_BEC_final_model = coefs_fit_BEC_final(1) + ...
                        coefs_fit_BEC_final(2)*(max(1-(hor-x_center).^2/coefs_fit_BEC_final(3)^2 ,0)).^(3/2);

h = zeros(1,7);
h(4) = plot(app.UIAxes_BEC, hor_plot, fit_BEC_final_model, 'DisplayName', 'Final TF fit', 'Color','r' );
hold(app.UIAxes_BEC, 'on')
h(5) = plot(app.UIAxes_BEC, hor_plot, center_horizontal_slice_wo_thermal, '.', ...
    'MarkerEdgeColor','b','MarkerFaceColor','b', 'DisplayName', 'OD - thrm_{fit}');
t3 = title(app.UIAxes_BEC, 'Final Thomas-Fermi fit');
t3.FontSize = 8;
h(1) = xline(app.UIAxes_BEC, x_center + app.Xmin_BEC.Value);
h(2) = xline(app.UIAxes_BEC, x_center+round(app.BECFitDiameter.Value/2) + app.Xmin_BEC.Value, 'Color', 'g', 'DisplayName','TF radius');
h(3) = xline(app.UIAxes_BEC, x_center-round(app.BECFitDiameter.Value/2) + app.Xmin_BEC.Value, 'Color', 'g');
h(6) = xline(app.UIAxes_BEC, x_center + app.Xmin_BEC.Value - center_cutoff, 'DisplayName','x_{low} cutoff');
h(7) = xline(app.UIAxes_BEC, x_center + app.Xmin_BEC.Value + center_cutoff, 'DisplayName','x_{high} cutoff');
h(8) = yline(app.UIAxes_BEC, cutoff, 'DisplayName','final cutoff', 'LineStyle','--');
l3 = legend(app.UIAxes_BEC, [h(2) h(4) h(5) h(6) h(7) h(8)]);
l3.FontSize = 6;
l3.ItemTokenSize = [5 10];
app.UIAxes_BEC.XLim = [app.Xmin_BEC.Value  app.Xmax_BEC.Value];
app.UIAxes_BEC.YLim = [min(fit_BEC_final_model)-0.1  max(fit_BEC_final_model)+0.1];
hold(app.UIAxes_BEC, 'off')

end