%% Author: Huan Q. Bui
%% Colby College '21
%% Date: Aug 08, 2020
%%

if max(size(gcp)) == 0 % parallel pool needed
   parpool('local',2); % create the parallel pool
end

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

Z = 10:100:100000;
AbsSigmaHatX = zeros(length(Z),1);
AbsSigmaHatY = zeros(length(Z),1);

alpha0 = 1/4; 
beta0  = 1/4;

EstimateX = 1./((abs(Z.^(1))).^(alpha0));
EstimateY = 1./((abs(Z.^(1))).^(beta0 ));

for r = 1:length(Z)
    [Sx,Sy] = SigHat(Z(r));
    AbsSigmaHatX(r) = abs(Sx);
    AbsSigmaHatY(r) = abs(Sy);
    disp(['Evaluations: ' num2str(r) ' out of ' num2str(length(Z))]);
end

% plotting
tiledlayout(1,2)
nexttile
plot(Z,AbsSigmaHatX);
xlabel('X', 'FontSize',16);
ylabel('Amplitude of SigmaHat along X axis', 'FontSize', 16 );
hold on
plot(Z,EstimateX);
title(['versus 1/|X|^{' num2str(alpha0) '}'], 'FontSize', 16)
hold off
nexttile
plot(Z,AbsSigmaHatY);
xlabel('Y', 'FontSize',16);
ylabel('Amplitude of SigmaHat along Y axis', 'FontSize', 16 );
hold on
plot(Z,EstimateY);
title(['versus 1/|Y|^{' num2str(beta0) '}'], 'FontSize', 16)
hold off

filename = 'C:\Users\buiqu\Documents\GitHub\huanium\Convolution Powers\FT_Sigma_Estimate_1D_ver4.mat';
save(filename)


%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ');
% clock ends
%%%%%%%%%%%%%%%%%%%



% -- Integration --

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
SigHatX = trE*integral2(funX, xmin, xmax, ymin, ymax, 'AbsTol',1e-4, 'RelTol', 1e-4);
SigHatY = trE*integral2(funY, xmin, xmax, ymin, ymax, 'AbsTol',1e-4, 'RelTol', 1e-4);
end




