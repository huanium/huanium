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

I = -40:1:40;
J = -40:1:40;

[II,JJ] = meshgrid(I,J);
AbsSigmaHat = zeros(length(II),length(JJ));
for r = 1:length(II)
   for c = 1:length(JJ)
        AbsSigmaHat(r,c) = abs(SigHat(II(1,r), JJ(c,1)));
        Estimate(r,c) = Est(II(1,r), JJ(c,1));
   end
end
surfc(II,JJ,AbsSigmaHat,'LineWidth',0.1,'edgecolor','black', 'FaceAlpha', 0.7);
hold on
surfc(II,JJ,Estimate,'LineWidth',0.1,'edgecolor','black', 'FaceColor','red');
hold off
xlabel('X', 'FontSize',16);
ylabel('Y', 'FontSize',16);
title('Amplitude of SigmaHat', 'FontSize', 16 );
colorbar;

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

function SigHat = SigHat(II,JJ)
xmin = -9;
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
% E = diag(1/2,1/4)
%, 'Method', 'iterated'
indicator1 = @(x,y) x.^2 + y.^4 > 0; % P(xi) greater than zero
indicator2 = @(x,y) x.^2 + y.^4 < 1; % P(xi) less than one
fun = @(x,y) indicator1(x,y).*indicator2(x,y).*exp(-1i*(II.*x.*(x.^2 + y.^4).^(-E(1,1)) +    JJ.*y.*(x.^2 + y.^4).^(-E(2,2))));
SigHat = trE*integral2(fun, xmin, xmax, ymin, ymax, 'AbsTol',1e-3, 'RelTol', 1e-3);
end

function Estimate = Est(II,JJ)
Estimate = 1/((abs(II.^2 + JJ.^(2)))^((1/4)/2));
end



