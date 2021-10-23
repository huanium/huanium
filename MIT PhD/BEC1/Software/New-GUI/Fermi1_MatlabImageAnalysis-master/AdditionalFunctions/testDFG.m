% testDFG, fitFermi1D
f1 = @(s)(1+s)./s.*log(1+s);
fitfun = @(p,x) real(p(1)+p(2)*PolyLog(2.5,exp(p(5)-(x-p(3)).^2./p(4)^2*f1(exp(p(5)))))/PolyLog(2.5,exp(p(5))));
parameterNames = {'Offset 1','Amplitude 2','Center 3','Width 4','q= mu*beta 5'};
xcoor=1:200;
DFGparam=[0,20, 100, 20, .5];
ToverTf=(-6*PolyLog(3,-exp(DFGparam(5))))^(-1/3)

figure(820);clf; 
subplot(2,1,1);
integratedAlongY=fitfun(DFGparam, xcoor);
plot(xcoor, integratedAlongY,'.','MarkerSize',20);
title(num2str(ToverTf,3));
%% test DFG fit
pGuess = [integratedAlongY(1),max(integratedAlongY),200/2,20,1];   % Inital (guess) parameters
lb = [min(integratedAlongY),0,0,0, -10];
ub = [mean(integratedAlongY),1.5*max(integratedAlongY),200,200, 10];
opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
[param,~,resid,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xcoor,integratedAlongY,lb,ub,opts);
ci = nlparci(param,resid,'jacobian',J,'alpha',1-0.68)
hold on;
plot(xcoor, fitfun(param,xcoor),'LineWidth',2);    
disp(param);
legend(num2str((-6*PolyLog(3,-exp(param(5))))^(-1/3),3));
hold on;
subplot(2,1,2);
plot(xcoor,resid);
title(num2str(sum(resid.^2)));
%% test DFG fit on signal with noise
noiseAmp=DFGparam(2)*.2;
integratedAlongYN=integratedAlongY+noiseAmp*rand(1,length(integratedAlongY));
figure(821);clf; 
subplot(2,1,1);
hold on;
plot(xcoor, integratedAlongYN,'.','MarkerSize',20);

pGuess = [integratedAlongYN(1),max(integratedAlongYN),200/2,20,1];   % Inital (guess) parameters
lb = [min(integratedAlongYN),0,0,0, -10];
ub = [mean(integratedAlongYN),1.5*max(integratedAlongYN),200,200, 10];
opts = optimoptions('lsqcurvefit','Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
[param,~,resid,~,~,~,J] = lsqcurvefit(fitfun,pGuess,xcoor,integratedAlongYN,lb,ub,opts);
ci = nlparci(param,resid,'jacobian',J,'alpha',1-0.68)
plot(xcoor, fitfun(param,xcoor),'LineWidth',2);    
disp(param);
legend(num2str((-6*PolyLog(3,-exp(param(5))))^(-1/3)));
subplot(2,1,2);
plot(xcoor,resid);
title(num2str(sum(resid.^2)));