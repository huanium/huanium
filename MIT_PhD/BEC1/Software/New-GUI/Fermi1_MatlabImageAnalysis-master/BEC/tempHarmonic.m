function [analysis] = tempHarmonic(params, widths,widthCis,omega,excludeIdx,varargin)
%inputs
%time in milliseconds
%widthpix is pixel width, Gaussian
%omega is frequency IN RADIANS/s!!!!
%exclude is index of points to be excluded from fit.  If include everything, put empty brackets
%Returns: 'analysis' has 3 fields
%1. temperature (nK)
%2. temperatureCI
%3. GaussianWidth (defined as exp(-x/xw^2) ) (micron)

p = inputParser;
p.addParameter('camPix',2.5);
p.parse(varargin{:});
pixel                 = p.Results.camPix;
mask = true(length(params),1);
mask(excludeIdx) = false;

%find nans in data or ci
nanMask = ~isnan(widthCis(:,1));
mask=mask.*nanMask;
nanMask = ~isnan(widthCis(:,2));
mask=mask.*nanMask;
nanMask = ~isnan(widths);
mask=logical(mask.*nanMask);
%Calculates temperature of thermal gas from KT = 1/2
%m(omega^2/(1+omega^2t^2) x^2), or x(t) = sqrt(2KT(1+omega^2t^2)/mw^2)


%Constants

mass=mNa; %23 Na, 40 K

[xData, yData] = prepareCurveData(params/1000, widths'*pixel );
%

lb      = [10]; 
pGuess  = [100];
ub      = [1000];
fitfun = @(p,x) sqrt(p(1)./mass.*kB.*10^3.*2.*(1+omega.^2.*x.^2))./omega;
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
legend('Width(um) vs. time(ms)','Location','Best');
trapfreq=omega/2/pi;
title(['T(nK) = ', num2str(param_fit,3),' [', num2str(tempCi(1),3),' - ', num2str(tempCi(2),3),'] F(Hz) = ', num2str(trapfreq)]);
% Label axes
xlabel time(s)
ylabel width(um)
grid on
ylim([0.8*min(yData(mask)),1.1*max(yData(mask))]);

analysis = struct;
analysis.temperature = param_fit;
analysis.temperatureCI = tempCi;
analysis.GaussianWidth = fitfun(param_fit,0);




