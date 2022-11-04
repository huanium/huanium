clear all
close all

tic

rows = 256;
columns = 256;
totalBEC = zeros(rows, columns);

noiseAmp = 0.1;
polyLog_approx_terms = 25;

% generate some data...
% this step won't be necessary with real images
for i = 1:rows
    for j = 1:columns
        r = i-round(rows/2);
        c = j-round(columns/2);
        %totalBEC(i,j) = 0.3*(polylog(2, exp(-(r^2+c^2)/(rows/2)^2))) + (max(1-(r^2+c^2)/(rows/3)^2,0)).^(3/2) + noiseAmp*rand(1,1);
        %totalBEC(i,j) = 0.3*exp(-(r^2+c^2)/(rows/2)^2) + (max(1-(r^2+c^2)/(rows/3)^2,0)).^(3/2) + noiseAmp*rand(1,1);
        totalBEC(i,j) = 0.3*approx_polylog(2,exp(-(r^2+c^2)/(rows/2)^2),polyLog_approx_terms) + (max(1-(r^2+c^2)/(rows/3)^2,0)).^(3/2) + noiseAmp*rand(1,1);

    end
end

image(totalBEC,'CDataMapping','scaled');

%%%%%%%%%%%%%%%%%%%%%%%%%

x = 1:1:columns;
y = 1:1:rows;
[X,Y] = meshgrid(x,y);

% setup to exclude outliers
tf = excludedata(X(:), totalBEC(:), 'range', [0.001 Inf]);

% now fit this data:
fitfunc = fittype("BEC_bimodal_fit_func_2D(a, b, c, d, e, f, N, x, y)", ...
    'independent',{'x','y'},'dependent','z','problem','N');

% note that StartPoint's order is alphabetical
% so StartPoint = [a = therm, b = cond, c = rhoC, d = x_center, e = rhoTh, f = y_center, therm]
BECfit_2D = fit([X(:), Y(:)], totalBEC(:), fitfunc, ...
    'StartPoint', [0.2, 1.1,  rows/3, rows/2, rows/2, rows/2], ...
    'Exclude',tf, ...
    'problem', polyLog_approx_terms);

figure(6)
h = plot(BECfit_2D, [X(:) Y(:)], totalBEC(:));
% change marker size for fitted curve:
h(2).MarkerSize = 5;
disp(BECfit_2D);



toc



