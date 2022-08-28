function [analysis] = tempFromBoseFit(Na_run,excludeIdx)
%Returns: 'analysis' has 3 fields
%1. temperature (nK)
%2. temperatureCI

maskManual = true(length(Na_run.parameters),1);
maskManual(excludeIdx) = false;

%X-Lab-Axis
tempX =Na_run.analysis.fitIntegratedBoseMaskedX.param(:,1);
tempXErr=range(squeeze(Na_run.analysis.fitIntegratedBoseMaskedX.ci(:,1,:)),2);
tempXGauss =Na_run.analysis.fitIntegratedBoseMaskedX.GaussTemp(:);

%find nans in data or ci
nanMaskX = ~isnan(tempX);
maskX=maskManual.*nanMaskX;
nanMaskX = ~isnan(tempXErr);
maskX=logical(maskX.*nanMaskX);


%Z-Lab-Axis
tempZ =Na_run.analysis.fitIntegratedBoseMaskedZ.param(:,1);
tempZErr=range(squeeze(Na_run.analysis.fitIntegratedBoseMaskedZ.ci(:,1,:)),2);
tempZGauss =Na_run.analysis.fitIntegratedBoseMaskedZ.GaussTemp(:);

%find nans in data or ci
nanMaskZ = ~isnan(tempZ);
maskZ=maskManual.*nanMaskZ;
nanMaskZ = ~isnan(tempZErr);
maskZ=logical(maskZ.*nanMaskZ);

meanTemp=(sum(tempX(maskX)./tempXErr(maskX))+sum(tempZ(maskZ)./tempZErr(maskZ)))./(sum(1./tempXErr(maskX))+sum(1./tempZErr(maskZ)));
meanStd = std([tempX(maskX);tempZ(maskZ)])./sqrt(length([tempX(maskX);tempZ(maskZ)]));

meanTempGauss=mean([tempXGauss(maskX);tempZGauss(maskX)]);
meanStdGauss = std([tempXGauss(maskX);tempZGauss(maskZ)])./sqrt(length([tempXGauss(maskX);tempZGauss(maskZ)]));

figure(799);clf;
hold on;
errorbar(1:length(Na_run.parameters(maskX)),1e9*tempX(maskX),1e9*tempXErr(maskX),'.','MarkerSize',20,'CapSize',0);
errorbar(1:length(Na_run.parameters(maskZ)),1e9*tempZ(maskZ),1e9*tempZErr(maskZ),'.','MarkerSize',20,'CapSize',0);

plot([1,length(Na_run.parameters(maskX))],[meanTemp,meanTemp]*1e9,'k-','LineWidth',2);
plot([1,length(Na_run.parameters(maskX))],[meanTemp-meanStd,meanTemp-meanStd]*1e9,'k--','LineWidth',1);
plot([1,length(Na_run.parameters(maskX))],[meanTemp+meanStd,meanTemp+meanStd]*1e9,'k--','LineWidth',1);
hold off;
title({['Weighted Temperature (Bose)  = ',num2str(meanTemp*10^9,3), ' nK'],...
       ['Averaged Temperature (Gauss) = ',num2str(meanTempGauss*10^9,3), ' nK']});
xlabel('Image index');
ylabel('Temperature (nK)');

legend('X axis (lab)','Z axis (lab)');
set(gca,'FontSize', 12);

analysis = struct;
analysis.temperature = meanTemp;
analysis.temperatureCI = [meanTemp-meanStd,meanTemp+meanStd];
analysis.meanTempGauss = meanTempGauss;
analysis.meanTempGaussCI = [meanTempGauss-meanStdGauss,meanTempGauss+meanStdGauss];
analysis.GaussianWidth = 0;




