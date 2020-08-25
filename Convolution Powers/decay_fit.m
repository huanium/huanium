%% Author: Huan Q. Bui
%% Colby College '21
%% Date: Aug 08, 2020
%%


ver1 = load('C:\Users\buiqu\Documents\GitHub\huanium\Convolution Powers\Conv_Power_MATLAB\FT_Sigma_Estimate_1D_ver3.mat'); 
%ver2 = load('C:\Users\buiqu\Documents\GitHub\huanium\Convolution Powers\FT_Sigma_Estimate_1D_ver2.mat');

% this is for concatenating data if needed
%AbsSigmaHatX = [ver1.AbsSigmaHatX; ver2.AbsSigmaHatX];
%AbsSigmaHatY = [ver1.AbsSigmaHatY; ver2.AbsSigmaHatY];

AbsSigmaHatX = ver1.AbsSigmaHatX;
AbsSigmaHatY = ver1.AbsSigmaHatY;
Z            = ver1.Z;

alpha0 = 1/4; 
beta0  = 1/4;

EstimateX = 2.7./((abs(Z.^(1))).^(alpha0));
EstimateY = 1.5./((abs(Z.^(1))).^(beta0 ));

tiledlayout(1,2)
nexttile
plot(Z,AbsSigmaHatX);
xlabel('X', 'FontSize',16);
ylabel('Amplitude of SigmaHat along X axis', 'FontSize', 16 );
hold on
plot(Z,EstimateX, 'LineWidth', 2);
title(['versus 1/|X|^{' num2str(alpha0) '}'], 'FontSize', 16)
hold off
nexttile
plot(Z,AbsSigmaHatY);
xlabel('Y', 'FontSize',16);
ylabel('Amplitude of SigmaHat along Y axis', 'FontSize', 16 );
hold on
plot(Z,EstimateY, 'LineWidth', 2);
title(['versus 1/|Y|^{' num2str(beta0) '}'], 'FontSize', 16)
hold off






% % Some data - replace it with yours (its from an earlier project)
% x = [177600,961200, 2504000, 4997000, 8884000]';
% y = [6.754, 24.416, 58.622, 107.980, 154.507]';
% % Define Start points, fit-function and fit curve
% x0 = [1 1 1 1]; 
% fitfun = fittype( @(a,b,c,d,x) d*atan(b*(x+a))+c );
% [fitted_curve,gof] = fit(x,y,fitfun,'StartPoint',x0)
% % Save the coeffiecient values for a,b,c and d in a vector
% coeffvals = coeffvalues(fitted_curve);
% % Plot results
% scatter(x, y, 'r+')
% hold on
% plot(x,fitted_curve(x))
% hold off