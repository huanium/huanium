function [param_fit, tempCi] = chemicalPotentialBECTOF(params, widths,widthCis,omega,excludeIdx)

mask = true(length(params),1);
mask(excludeIdx) = false;

%Constants
kB=1.38064852e-23;
amu=1.6605402e-27; 
PlanckConst = 6.62607004e-34;
mass=23*amu; %23 Na, 40 K
pixel=2.48; 

[xData, yData] = prepareCurveData(params/1000, widths'*pixel );
%

lb      = [0.1]; 
pGuess  = [2];
ub      = [100];
fitfun = @(p,x) 10^6*sqrt(p(1).*10^3./mass.*PlanckConst.*2.*(1+omega.^2.*(x).^2))./omega;
weighted_deviations = @(p) (fitfun(p,xData(mask))-yData(mask))./((widthCis(mask,2)-widthCis(mask,1))./2);
% figure(123)
% clf;
% plot(xData,yData,'.','MarkerSize',20);
% hold on
% plot(0:0.001:0.02,fitfun(pGuess,0:0.001:0.02));
% hold off
optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
[param_fit,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);

if(isempty(resid))
    tempCi = NaN(1,2);
else
    tempCi = nlparci(param_fit,resid,'jacobian',J);
end

uniqX = unique(xData());
xvals = uniqX(1):(uniqX(2)-uniqX(1))/100:uniqX(end);
plot(xvals, fitfun(param_fit,xvals),'LineWidth',2);
hold on;
errorbar(xData(mask),yData(mask),yData(mask)-widthCis(mask,1)*pixel,widthCis(mask,1)*pixel-yData(mask),'.','MarkerSize',20);
errorbar(xData(~mask),yData(~mask),yData(~mask)-widthCis(~mask,1)*pixel,widthCis(~mask,1)*pixel-yData(~mask),'.','MarkerSize',20);
hold off
legend('Width(\mum) vs. time(ms)');
trapfreq=omega/2/pi;
title(['\mu(kHz) = ', num2str(param_fit),' [', num2str(tempCi(1)),' - ', num2str(tempCi(2)),'] F(Hz) = ', num2str(trapfreq)]);
% Label axes
xlabel time(s)
ylabel width(\mum)
grid on



