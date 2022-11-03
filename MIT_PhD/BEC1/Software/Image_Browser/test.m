clear all
close all
tic

[X,Y] = meshgrid(-2:0.05:2, -2:0.05:2);
noiseAmp = 0.05;
% bose-enhanced gaussian data for thermal cloud
bose_enhanced_Gaussian = 0.3*(polylog(2, exp(-(X.^2+Y.^2))));
% thomas-fermi for condensate
thomas_fermi = (max(1-X.^2-Y.^2,0)).^(3/2);

lx = size(X);
ly = size(Y);
Noise = noiseAmp.*abs(rand(lx(1),ly(1)));

totalBEC = bose_enhanced_Gaussian + thomas_fermi + Noise;

% now downsample... set half the points of totalBEC to NaN:
[r,c] = size(totalBEC);
for i = 1:r
    for j = 1:c
        if rand(1,1) <= 1/2
            totalBEC(i,j) = 0;
        end
    end
end

tf = excludedata(X(:), totalBEC(:), 'range', [0.001 Inf]);

figure(1)
surf(X,Y,totalBEC,'FaceAlpha',1);

% testing fit function:
fitfunc = fittype( @(therm, cond, rhoTh2, rhoC2, x, y) ...
    therm * (polylog(2, exp(-(x.^2+y.^2)/rhoTh2))) + cond * (max(1-(x.^2+y.^2)./rhoC2,0)).^(3/2), ...
    'independent', {'x', 'y'}, 'dependent', 'z' );

BECfit = fit([X(:),Y(:)], totalBEC(:), fitfunc, ...
    'StartPoint', [0.1,1,1.2,1.1], ...
    'Exclude',tf);

figure(2)
plot(BECfit, [X(:) Y(:)], totalBEC(:))

figure(3)
plot(BECfit);

disp(BECfit);

toc


