%% Author: Huan Q. Bui
%% Colby College '21
%% Date: Aug 09, 2020
%%

function [SigHatX,SigHatY] = SigHat(Z)
xmin = -10;
xmax = -xmin;
ymin = xmin;
ymax = xmax;
E = [1/2 0 ; 0 1/4];
trE = 1/2 + 1/4;
% Use Corollary 3.2, to reduce integration effort
% Formula:
% SigmaHat(z) = \int_S e^{-i z \cdot \eta } \sigma_P(d\eta)
%             = \int_{\R^d} \mu_P \chi_{(0,1)} (P(x)) e^{-i(z \cdot P(x)^{-E} x )}\,dx. 
% Here P(x,y) = x^2 + y^4
indicator1 = @(x,y) x.^2 + y.^4 > 0; % P(x,y) greater than zero
indicator2 = @(x,y) x.^2 + y.^4 < 1; % P(x,y) less than one
funX = @(x,y) indicator1(x,y).*indicator2(x,y).*exp(-1i*(Z.*x.*(x.^2 + y.^4).^(-E(1,1))));
funY = @(x,y) indicator1(x,y).*indicator2(x,y).*exp(-1i*(Z.*y.*(x.^2 + y.^4).^(-E(2,2))));
SigHatX = trE*integral2(funX, xmin, xmax, ymin, ymax, 'AbsTol',1e-3, 'RelTol', 1e-3);
SigHatY = trE*integral2(funY, xmin, xmax, ymin, ymax, 'AbsTol',1e-3, 'RelTol', 1e-3);
end