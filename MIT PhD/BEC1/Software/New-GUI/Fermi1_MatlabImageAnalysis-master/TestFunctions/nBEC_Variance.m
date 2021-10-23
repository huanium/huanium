%inputs
dxTF=xTFstd*BEC_X.TF/xTFmean*1e-6; 
xTF0=BEC_X.TF*1e-6; %meters
yTF0=BEC_X.TF*1e-6*BEC_X.Omegas(1)/BEC_X.Omegas(2);
zTF0=BEC_Z.TF*1e-6;
x0=0;
%constants
a_s=52*aBohr;
omegaX=BEC_X.Omegas(1);
omega=(12.6*41*101)^(1/3)*2*pi;

syms x y z xTF yTF zTF
f_BEC= 15/(8*pi*xTF*yTF*zTF)*(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2).*heaviside(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2);
Nc= mNa^2*omegaX^5*xTF^5/(15*hbar^2*omega^3*a_s);

nC=Nc*f_BEC;
nCerr=diff(nC,xTF)*dxTF;

xVals=linspace(0,3*xTF0,100);
nCerrVals=zeros(size(xVals));
nCVals=zeros(size(xVals));
for idx=1:length(xVals)
    nCerrVals(idx)=double(subs(nCerr,[x y z xTF yTF zTF],[xVals(idx) 0 0 xTF0 yTF0 zTF0]));
    nCVals(idx)=double(subs(nC,[x y z xTF yTF zTF],[xVals(idx) 0 0 xTF0 yTF0 zTF0]));
end

figure(999);clf;
errorbar(xVals,nCVals,nCerrVals,'MarkerSize',20,'CapSize',0);
%% bootstrap
load('BEC_variance.mat');load('BEC_XZ.mat');
xTF0=BEC_X.TF*1e-6; %meters
yTF0=BEC_X.TF*1e-6*BEC_X.Omegas(1)/BEC_X.Omegas(2);
zTF0=BEC_Z.TF*1e-6;
x0=0;
%constants
a_s=52*aBohr;
omegaX=BEC_X.Omegas(1);
omega=(12.6*41*101)^(1/3)*2*pi;

x=linspace(0,xTF0*1.1,100);y=0;z=0;
numBootstrap=1000;
CI=.68;

lowIdx=round(numBootstrap*length(xTFpix)*(.5-CI/2));
highIdx=round(numBootstrap*length(xTFpix)*(.5+CI/2));
valsci_low=zeros(1,length(x));
valsci_high=valsci_low;
vals=zeros(1,length(x));
close('all');
for idx=1:length(x)
f_BEC= @(xTF) 15./(8*pi.*xTF*yTF0*zTF0).*(1-x(idx).^2./xTF.^2-y.^2/yTF0^2-z.^2/zTF0^2).*heaviside(1-x(idx).^2./xTF.^2-y.^2/yTF0^2-z.^2/zTF0^2);
Nc= @(xTF) mNa^2*omegaX^5*xTF.^5/(15*hbar^2*omega^3*a_s);
nC= @(xTF)10^-6* Nc(xTF).*f_BEC(xTF); %in cm^-3

bootstat=bootstrp(numBootstrap,nC,xTFpix*BEC_X.TF/xTFmean*2.5e-6);

%For each bootstrap, find the 68% confidence interval
bootsorted=sort(bootstat(:));
vals(idx)=median(bootsorted);
valsci_low(idx)=bootsorted(lowIdx);
valsci_high(idx)=bootsorted(highIdx);
end
% display(vals);
% display(valsci_low);
% display(valsci_high);
figure(998);clf; hold on;shg
errorbar(x,vals, vals-valsci_low,valsci_high-vals,'.','MarkerSize',20,'CapSize',0);
plot([BEC_X.TF*1e-6 BEC_X.TF*1e-6 ],[0 max(vals)],'r-');
legend('bootstrapped mean and variance from z-camera image','ycam xTF');
ylabel('density cm^{-3}');xlabel('micron');
%% carsten's code
%constants
% a_s=52*aBohr;
% omegaX=BEC_X.Omegas(1);
% omega=(12.6*41*101)^(1/3)*2*pi;
% xTF0=BEC_X.TF*1e-6; %meters
% yTF0=BEC_X.TF*1e-6*BEC_X.Omegas(1)/BEC_X.Omegas(2);
% zTF0=BEC_Z.TF*1e-6;
% 
% 
% x=linspace(0,xTF0*3,10);y=0;z=0;
% x=xTF0*1.01;
% funVals=zeros(size(x));
% funCI=zeros(2,length(x));
% close('all');
% for idx=1
%     f_BEC= @(xTF) 15./(8*pi.*xTF*yTF0*zTF0).*(1-x(idx).^2./xTF.^2-y.^2/yTF0^2-z.^2/zTF0^2).*heaviside(1-x(idx).^2./xTF.^2-y.^2/yTF0^2-z.^2/zTF0^2);
%     Nc= @(xTF) mNa^2*omegaX^5*xTF.^5/(15*hbar^2*omega^3*a_s);
%     nC= @(xTF)10^-6* Nc(xTF).*f_BEC(xTF); %in cm^-3
% 
%     %[funVal, funCI]=propagateErrorWithMC(nC,xTFpix*BEC_X.TF/xTFmean*2.5e-6);
%     A=generateMCparameters('bootstrapMean',xTFpix*BEC_X.TF/xTFmean*2.5e-6,'numSamples',100000,'plot',true);
%     [funVals(idx),funCI(:,idx),funSamples]=propagateErrorWithMC(nC,A,'plot',false);
% 
% end
% figure(999);clf;
% errorbar(x,funVals,-(funCI(1,:)-funVals),funCI(2,:)-funVals);
% %%
% figure;hist(xTFpix)
%%
% idx=4;
% f_BECTemp= @(xTF) 15./(8*pi.*xTF*yTF*zTF*1e-12).*(1-(idx*analysisBoxInMuMeter/2*1e-6).^2./xTF.^2).*heaviside(1-(idx*analysisBoxInMuMeter/2*1e-6).^2./xTF.^2);
% NcTemp= @(xTF) mNa^2*omegaX^5*xTF.^5/(15*hbar^2*omegabar^3*a_s);
% nC= @(xTF)10^-6* NcTemp(xTF).*f_BECTemp(xTF); %in cm^-3
% % bootstat=bootstrp(numBootstrap,nC,xTFpixZcam*2.5e-6*xTF/xTFmeanInMicron);
% % 
% %         %For each bootstrap, find the 68% confidence interval
% % bootsorted=sort(bootstat(:));
% % vals(idx+1)=median(bootsorted);
% % stdCci_low(idx+1)=vals(idx+1)-bootsorted(lowIdx)
% % stdCci_high(idx+1)=bootsorted(highIdx)-vals(idx+1)
% test=nC(xTFpixZcam*2.5e-6*xTF/xTFmeanInMicron);
% median(test)
% mean(test)
% stdtest=median(test)
% hist(test)
%%
    for idx=0:numBoxes-1
        display(idx)
        f_BECTemp= @(xTF) 15./(8*pi.*xTF*yTF*zTF*1e-12).*(1-(idx*analysisBoxInMuMeter/2*1e-6).^2./xTF.^2).*heaviside(1-(idx*analysisBoxInMuMeter/2*1e-6).^2./xTF.^2);
        NcTemp= @(xTF) mNa^2*omegaX^5*xTF.^5/(15*hbar^2*omegabar^3*a_s);
        nC= @(xTF)10^-6* NcTemp(xTF).*f_BECTemp(xTF); %in cm^-3
        distribution=sort(nC(xTFpixZcam*2.5e-6*xTF/xTFmeanInMicron));
        %For each bootstrap, find the 68% confidence interval
        vals(idx+1)=median(distribution);
        stdCci_low(idx+1)=vals(idx+1)-distribution(lowIdx);
        stdCci_high(idx+1)=distribution(highIdx)-vals(idx+1);
        
        if(densityC(min(numBoxes,idx+2))>0)
            g_BEC=@(x,y,z) (1e12*Nc.*f_BEC(x,y,z)-densityC(idx+1)).^2.*f_BEC(x,y,z);
            VarianceCInt(idx+1)=integral3(g_BEC, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,0,ylim,0,ylim,'RelTol',1e-4,'AbsTol',1e-13)/integral3(f_BEC, idx*analysisBoxInMuMeter/2,(idx+1)*analysisBoxInMuMeter/2,0,ylim,0,ylim,'RelTol',1e-4,'AbsTol',1e-13);
        elseif(densityC(idx+1)==0)
            %h_Therm inputs in meter, output in cm^-6*f_Therm
            h_Therm=@(x,y,z) (g_Therm(x,y,z)/lambdaDB^6/10^12-densityT(idx+1)^2).*f_Therm(x,y,z);
            VarianceT(idx+1) =  integral3(h_Therm,idx*analysisBoxInMuMeter/2e6,(idx+1)*analysisBoxInMuMeter/2e6,0,ylim/10^6,0,ylim/10^6,'RelTol',1e-4,'AbsTol',1e-13)/integral3(f_Therm,idx*analysisBoxInMuMeter/2e6,(idx+1)*analysisBoxInMuMeter/2e6,0,ylim/10^6,0,ylim/10^6,'RelTol',1e-4,'AbsTol',1e-13);
        end

    end
    %%
%%
scaleZtoY=xTF/xTFmeanInMicron;
xTFm=xTFpixZcam*2.5e-6*scaleZtoY;
yTFm=yTF/1e6*xTFpixZcam/mean(xTFpixZcam);
zTFm=zTF/1e6*xTFpixZcam/mean(xTFpixZcam);

xvals=linspace(0,2*xTF*1e-6,100);
syms x y z
nC=@(x) 0;
figure(4);clf;
subplot(1,2,1);title('All nC from distribution of z-cam in situ xTF sizes');
hold on;
for idx=1:length(xTFm)
    ftemp=@(x,y,z)15./(8*pi.*xTFm(idx)*yTFm(idx)*zTFm(idx)).*(1-x.^2/xTFm(idx).^2-y.^2/yTFm(idx)^2-z.^2/zTFm(idx)^2).*heaviside(1-x.^2/xTFm(idx).^2-y.^2/yTFm(idx)^2-z.^2/zTFm(idx)^2);
    NcTemp=  mNa^2*omegaX^5*xTFm(idx).^5/(15*hbar^2*omegabar^3*a_s);
    nC=@(x)nC(x)+ftemp(x,0,0)*NcTemp;
    plot(xvals,double(ftemp(xvals,0,0)*NcTemp));
end
nC=@(x)nC(x)/length(xTFm);
subplot(1,2,2);plot(xvals,double(nC(xvals)));
title('averaged nC');
ylabel('3D density'); xlabel('x meters (y=z=0)');
%%
    for idx=1:numBoxes
        if(VarCHigh(idx)>0)
            localToverTc(idx)=localToverTcfun([densityC(idx) densityT(idx)]);
            localToverTcCi(idx,1)=localToverTcfun([densityC(idx)+sqrt(VarCLow(idx)) densityT(idx)]);
            localToverTcCi(idx,2)=localToverTcfun([densityC(idx)-sqrt(VarCHigh(idx)) densityT(idx)]);
        else
            localToverTc(idx) = localToverTcfunThermal(temp,(densityT(idx))*10^6);
            localToverTcCi(idx,1)=localToverTcfunThermal(temp, (densityT(idx)-sqrt(VarianceT(idx)))*10^6);
            localToverTcCi(idx,2)=localToverTcfunThermal(temp, (densityT(idx)+sqrt(VarianceT(idx)))*10^6);        
        end
    end
%%
figure(555);
    subplot(1,3,2);hold on;
    xlabel(['Density box number (' num2str(analysisBoxInPixel) ' pix/box)']);
    ylabel('local T/T_C');
    title(['T/T_C per box for ' num2str(Nc,2) ' BEC atoms and ' num2str(NThermalBosons,2) ' thermal atoms']);
    errorbar(1:numBoxes,  localToverTc,localToverTc-localToverTcCi(:,1),localToverTcCi(:,2)-localToverTc,'.','MarkerSize',20);
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot([1,numBoxes],[ToverTcGlobal, ToverTcGlobal],'LineWidth',2);
    plot([ceil(BEC_X.TF/2.48/analysisBoxInPixel*2) ceil(BEC_X.TF/2.48/analysisBoxInPixel*2)] ,[0 1]);
    legend('local T/T_C',strcat('Global T/T_C = ',num2str(ToverTcGlobal,2)),'BEC edge' ,'Location', 'Best');

    xticks(1:numBoxes)
    hold off;
    densityPerBox = densityC+densityT;
    
    subplot(1,3,3);hold on;
    plot(localToverTcfunThermal(temp,densityPerBox*10^6), densityC./densityPerBox,'bo','MarkerFaceColor','b');
    plot(0:.1:max(localToverTc),heaviside(1-[0:.1:max(localToverTc)].^1.5).*(1-[0:.1:max(localToverTc)].^1.5),'r');
    title('Condensate fraction vs T/Tc');
    legend('nc/n from data vs T/Tc (localToverTcfunThermal)','1-(T/Tc)^{1.5}');
    xlabel('T/Tc');ylabel('n_c/n');
    %%
        subplot(1,3,3);hold off;
    errorbar(localToverTcfunThermal(temp,densityPerBox*10^6), densityC./densityPerBox,sqrt(VarCLow)./densityPerBox,sqrt(VarCHigh)./densityPerBox,'bo','MarkerFaceColor','b');
    hold on;
    plot(0:.1:max(localToverTc),heaviside(1-[0:.1:max(localToverTc)].^1.5).*(1-[0:.1:max(localToverTc)].^1.5),'r');
    title('Condensate fraction vs T/Tc');
    legend('nc/n from data vs T/Tc (localToverTcfunThermal)','1-(T/Tc)^{1.5}');
    xlabel('T/Tc');ylabel('n_c/n');