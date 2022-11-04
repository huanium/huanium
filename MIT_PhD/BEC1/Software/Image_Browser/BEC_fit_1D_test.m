clear all
close all

rows = 64;
columns = 64;
totalBEC = zeros(rows, columns);

noiseAmp = 0.05;
polyLog_approx_terms = 25;

% generate some data...
% this step won't be necessary with real images
for i = 1:rows
    for j = 1:columns
        r = i-round(rows/2);
        c = j-round(columns/2);
        %totalBEC(i,j) = 0.3*(polylog(2, exp(-(r^2+c^2)/(rows/2)^2))) + (max(1-(r^2+c^2)/(rows/3)^2,0)).^(3/2) + noiseAmp*rand(1,1);
        %totalBEC(i,j) = 0.3*exp(-(r^2+c^2)/(rows/2)^2) + (max(1-(r^2+c^2)/(rows/3)^2,0)).^(3/2) + noiseAmp*rand(1,1);
        totalBEC(i,j) = 0.3*approx_polylog(2,exp(-(r^2+c^2)/(rows/2)^2),polyLog_approx_terms) + (max(1-(r^2+c^2)/(rows/3)^2,0)).^(3/2) + noiseAmp*rand(1,1) + 0.2;

    end
end

image(totalBEC,'CDataMapping','scaled');

%%%%%%%%%%%%%%%%%%%%%%%%%
% find sum of matrix rows (integrate along x)
totalBEC_rows_summed = sum(totalBEC, 2);

% now do gaussian fit on this to find the vertical center:
y = 1:1:rows;
vertical_center_find = fit(y.', totalBEC_rows_summed,'gauss1');
coefs = coeffvalues(vertical_center_find);
vertical_center = round(coefs(2));
disp('Vertical center at: ');
disp(vertical_center);

% now plot data at y = center:
center_horizontal_slice = totalBEC(vertical_center, :);

x = 1:1:columns;
% setup to exclude outliers
tf = excludedata(x, center_horizontal_slice, 'range', [0.001 Inf]);

% now fit this data:
fitfunc = fittype("BEC_bimodal_fit_func(a, b, c, d, e, f, N, x)", ...
    'independent','x','dependent','z','problem','N');

% note that StartPoint's order is alphabetical
% so StartPoint = [a = therm, b = cond, c = rhoC, d = x_center, e = rhoTh, f = bckgnd]
BECfit = fit(x.', center_horizontal_slice.', fitfunc, ...
    'StartPoint', [0.2, 1.1,  rows/3, rows/2, rows/2, 0.1], ...
    'Exclude',tf, ...
    'problem', polyLog_approx_terms);

figure(6)
plot(BECfit, x, center_horizontal_slice);

coefs = coeffvalues(BECfit);

% display results
disp(BECfit);
disp(coefs);

disp('Thermal factor: ')
disp(coefs(1))
disp('Condensate factor')
disp(coefs(2))
disp('rho condensate: ')
disp(coefs(3))
disp('Center location: ')
disp(coefs(4))
disp('rho thermal: ')
disp(coefs(5))
disp('background: ')
disp(coefs(6))




