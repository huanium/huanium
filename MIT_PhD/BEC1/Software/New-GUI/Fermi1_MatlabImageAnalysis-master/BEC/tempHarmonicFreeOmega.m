function [param_fit, tempCi] = tempHarmonicFreeOmega(params, widths,widthCis,excludeIdx)

mask = true(length(params),1);
mask(excludeIdx) = false;
%Calculates temperature of thermal gas from KT = 1/2
%m(omega^2/(1+omega^2t^2) x^2), or x(t) = sqrt(2KT(1+omega^2t^2)/mw^2)

%time in milliseconds
%widthpix is pixel width, Gaussian
%omega is frequency IN RADIANS/s!!!!
%exclude is index of points to be excluded from fit.  If include everything, put empty brackets

%Constants
kB=1.38064852e-23;
amu=1.6605402e-27; 
mass=23*amu; %23 Na, 40 K
pixel=2.48; 

[xData, yData] = prepareCurveData(params/1000, widths'*pixel );
%

lb      = [10,1]; 
pGuess  = [100,100];
ub      = [1000,1000];
fitfun = @(p,x) sqrt(p(1).*10^3./mass.*kB.*2.*(1+(2*pi*p(2)).^2.*x.^2))./(2*pi*p(2));
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
legend('Width(um) vs. time(ms)');
trapfreq=param_fit(2);
title(['T(nK) = ', num2str(param_fit(1)),' [', num2str(tempCi(1,1)),' - ', num2str(tempCi(1,2)),'] F(Hz) = ', num2str(trapfreq),' [', num2str(tempCi(2,1)),' - ', num2str(tempCi(2,2)),']' ]);
% Label axes
xlabel time(s)
ylabel width(um)
grid on



