clear all
close all

rows = 256;
columns = 256;
totalBEC = zeros(rows, columns);

noiseAmp = 0.2;
polyLog_approx_terms = 25;

% generate some data...
% this step won't be necessary with real images

rho_therm = rows/5;
rho_cond = rows/5;

for i = 1:rows
    for j = 1:columns
        r = i-round(rows/2);
        c = j-round(columns/2);
        totalBEC(i,j) = 1*approx_polylog(2,exp(-(r^2+c^2)/(2*rho_therm^2)),polyLog_approx_terms) + 6*(max(1-(r^2+c^2)/rho_cond^2,0)).^(3/2) + noiseAmp*rand(1,1);
        
        % simulate flat top capped at OD = 5
        if totalBEC(i,j) >= 3
            totalBEC(i,j) = min(totalBEC(i,j), 5) + 1*rand(1,1);
        end
    end
end

% just an image of the BEC
figure(1)
image(totalBEC,'CDataMapping','scaled');
axis image
ax = gca;
colormap(gray(32768));
ax.CLim = [0, 1.3];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% find sum of matrix rows (integrate along x)
totalBEC_rows_summed = sum(totalBEC, 2);

% now do gaussian fit on this to find the vertical center:
y = 1:1:rows;
vertical_center_find = fit(y.', totalBEC_rows_summed,'gauss1');
coefs = coeffvalues(vertical_center_find);
vertical_center = round(coefs(2));

% now plot data at y = center:
center_horizontal_slice = totalBEC(vertical_center, :);

x = 1:1:columns;
% setup to exclude outliers
tf = excludedata(x, center_horizontal_slice, 'range', [0.001 Inf]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% step 1: fit a bimodal to this:

% now fit this data:
fitfunc = fittype("BEC_bimodal_fit_func(a, b, c, d, e, f, N, x)", ...
    'independent','x','dependent','z','problem','N');

% note that StartPoint's order is alphabetical
% so StartPoint = [a = therm, b = cond, c = rhoC, d = x_center, e = rhoTh, f = bckgnd]
BECfit = fit(x.', center_horizontal_slice.', fitfunc, ...
    'StartPoint', [0.2, 1.1,  rho_cond, rows/2, rho_therm, 0.1], ...
    'Exclude',tf, ...
    'problem', polyLog_approx_terms);

coefs_BEC_fit = coeffvalues(BECfit);
% display results
% disp(BECfit);

% figure 2 of fitting results
figure(2)
plot(BECfit, x, center_horizontal_slice);
hold on
xline(coefs_BEC_fit(4))
e1=xline(coefs_BEC_fit(4) + coefs_BEC_fit(3), 'DisplayName','initial TF radius');
xline(coefs_BEC_fit(4) - coefs_BEC_fit(3));
% cond
TF_fit = coefs_BEC_fit(2)*(max(1-(x-coefs_BEC_fit(4)).^2/coefs_BEC_fit(3)^2,0)).^(3/2);
e2 = plot(x,TF_fit,'DisplayName','initial TF fit');
legend([e1 e2])
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% step 2: subtract TF_fit from OD and fit thermal to new data:
slice_wo_BEC = center_horizontal_slice - TF_fit;

% detect and plot the bad center region:
S = 1.0;
xhigh_bad = round(coefs_BEC_fit(4)+S*coefs_BEC_fit(3));
xlow_bad = round(coefs_BEC_fit(4)-S*coefs_BEC_fit(3));
% now fit this with thermal part, exclude the bad center region:
xbad = ~excludedata(x, slice_wo_BEC, 'domain', [round(xlow_bad)  round(xhigh_bad)]);
x_center = coefs_BEC_fit(4);
fitfunc_wo_BEC = fittype(@(c1,c2,c3,x) ...
    c1 + c2.*approx_polylog(2,exp(-(x-x_center).^2/(2*c3^2)),polyLog_approx_terms), ...
    'independent','x', 'dependent', 'y');

% note that StartPoint's order is alphabetical
fit_wo_BEC = fit(x.', slice_wo_BEC.', fitfunc_wo_BEC, ...
    'StartPoint', [0.1, 1, rho_therm], ...
    'Exclude',xbad, ...
    'Lower',[0,0,0]);

% extract coeffs
coefs_fit_wo_BEC = coeffvalues(fit_wo_BEC);
title('Initial bimodal fit')

% plotting
figure(3)
plot(fit_wo_BEC, x, slice_wo_BEC);
hold on
xline(x_center);
f = xline(xlow_bad, 'DisplayName','initial TF radius');
xline(xhigh_bad);
legend(f)
hold off

a1 = coefs_fit_wo_BEC(1);
a2 = coefs_fit_wo_BEC(2);
a3 = coefs_fit_wo_BEC(3);

thermal_fit = a1 + a2.*approx_polylog(2,exp(-(x-x_center).^2/(2*a3^2)),polyLog_approx_terms);
% now compute OD without thermal part:
center_horizontal_slice_wo_thermal = center_horizontal_slice - thermal_fit;
title('Thermal wings fit')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% step (3)

% exclude weird data, for the final time
cutoff = 5 - max(thermal_fit);
bad_final = excludedata(x, center_horizontal_slice_wo_thermal, 'range', [0.001 cutoff]);

% now look at difference between cutoff and data:
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
    center_cutoff = max(x_center - xlow_bad_index, xhigh_bad_index - x_center);
else
    % just in case data is weird, use old method
    center_cutoff = round((xhigh_bad - xlow_bad)/3.5);
    disp('Weird data!')
end
disp('Center cutoff: ')
disp(center_cutoff)

bad_center = ~excludedata(x, center_horizontal_slice_wo_thermal, 'domain', [x_center-center_cutoff  x_center+center_cutoff]);
bad_region = bad_final | bad_center;

% now fit this data:
fitfunc_BEC = fittype(@(b1,b2,b3,x) ...
    b1+ b2*(max(1-(x-x_center).^2/b3^2 ,0)).^(3/2), ...
    'independent','x', 'dependent', 'y');

% note that StartPoint's order is alphabetical
% b1: background
% b2: condensate factor
% b3: center_location
% b4: rho_cond_guess
fit_BEC_final = fit(x.', center_horizontal_slice_wo_thermal.', fitfunc_BEC, ...
    'StartPoint', [0.1, 4, rho_cond], ...
    'Exclude',bad_region, ...
    'Lower',[0,0,0]);


% extract coeffs
coefs_fit_BEC_final = coeffvalues(fit_BEC_final);

% plotting
figure(4)
plot(fit_BEC_final, x, center_horizontal_slice_wo_thermal);
hold on
xline(x_center);
g1 = xline(x_center+round(coefs_fit_BEC_final(3)), 'DisplayName','TF radius');
xline(x_center-round(coefs_fit_BEC_final(3)));
g2 = xline(x_center-center_cutoff, 'DisplayName','x_{low} cutoff', 'Color', 'g');
g3 = xline(x_center+center_cutoff, 'DisplayName','x_{high} cutoff', 'Color', 'g');
g4= yline(cutoff, 'DisplayName','cutoff', 'LineStyle','--');
legend([g1 g2 g3 g4]);
title('Final TF fit')
hold off


% BEC with indicators for rho_condensate
figure(5)
image(totalBEC,'CDataMapping','scaled');
axis image
ax = gca;
colormap(gray(32768));
ax.CLim = [0, 1.3];
hold on
h = zeros(1,4);
h(1) = xline(x_center);
h(2) = xline(x_center + round(coefs_fit_BEC_final(3)), 'Color', 'g', 'DisplayName','Fitted TF radius');
h(3) = xline(x_center - round(coefs_fit_BEC_final(3)), 'Color', 'g');
h(4) = xline(x_center + rho_cond, 'Color', 'r', 'DisplayName','True TF radius');
h(5) = xline(x_center - rho_cond, 'Color', 'r');
legend([h(2) h(4)])
hold off

% display fitted TF radius vs. true TF radius:
disp('True TF radius:')
disp(rho_cond)
disp('Fitted TF radius:')
disp(coefs_fit_BEC_final(3))


