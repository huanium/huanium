%% TiSa Beam waist from trap frequencies, double check
%From 9/17/18 exp 
powers=([2.5 3.5 4.5 ]*1.07/2.5)*0.089+0.003; %Tisa power in chamber in W
trapfreq=[0.609 0.869 1.08]*1000; %measured dipole osci freq in rad/s
%constants
alphaNaCGS=24.11e-24; %in cm^3 from https://arxiv.org/pdf/1001.3888.pdf
%conversion to au---https://www.nature.com/articles/ncomms6725/tables/1
alphaNaAU=alphaNaCGS*6.748e24;
%equation from Rudi Grimm publication https://journals.aps.org/prl/pdf/10.1103/PhysRevLett.120.223001
predictedTrapFreq=@(x, pow) sqrt(16*aBohr^3/c*pow/(x*1e-6)^4*alphaNaAU/mNa);
optio = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt','Display','off','MaxFunctionEvaluations',1000);
param_fit=lsqcurvefit(predictedTrapFreq,50, powers,trapfreq, [],[],optio)

figure(1);clf;hold on;
plot(powers,trapfreq,'.','MarkerSize',20);

hold on;plot([0:.001:max(powers)],predictedTrapFreq(param_fit,[0:.001:max(powers)]));
xlabel('Powers (W)');ylabel('Dipole osc freq (rad/s)');
legend('Measured','fit');
title(strcat('Waist =  ',num2str(param_fit)));

%% Constants
c = 299792458;
alphaAUtocgs = 4.68645*10^-8; 
%(*in MHz/(W/cm^2)*)
alphaAUtouK = alphaAUtocgs*PlanckConst*10^6*10^6/kB;
alphaK = alphaAUtouK*590.935;
alphaNaK = alphaK/0.99;
gammaNa = 2*pi*9.8*10^6;
gammaK = 2*pi*6.035*10^6;
gammaNaK = 2*pi*10*10^6;
lambdaNa = 589*10^-9;
lambdaK = 766.7*10^-9;
lambdaNaK = 870*10^-9;

omegaNa = 2*pi*c/lambdaNa;
omegaK = 2*pi*c/lambdaK;
omegaNaK = 2*pi*c/lambdaNaK;


%% Na
%Beam peak intensity, assuming Gaussian, in W/m^2.  Waist in micron.
I0=@(P,w) 2*P/pi/(w*10^-6)^2;

%Trap depth in microKelvin
UNa=@(P,w)3*pi*c^2/2*gammaNa/(deltaNa*omegaNa^3)*I0(P,w)*10^6/kB;


%% TiSa: find waist size from 3 trap frequency measurements on 9/17/18
lambdatrap = 780*10^-9;
deltaNa = 2*pi*(c/lambdaNa - c/lambdatrap);
% deltaK = 2*pi*(c/lambdaK - c/lambdatrap);
% deltaNaK = 2*pi*(c/lambdaNaK - c/lambdatrap);



%fit function for trap frequency, angular
fitfun2 = @(x,pow)sqrt(2*UNa(pow,x)*10^-6*kB/mNa/(x*10^-6)^2);
optio = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt','Display','off','MaxFunctionEvaluations',1000);
[param_fit]=lsqcurvefit(fitfun2,50, powers,trapfreq, [],[],optio);

figure(2);clf;hold on;
plot(powers,trapfreq,'.','MarkerSize',20);

hold on;plot([0:.001:max(powers)],fitfun2(param_fit,[0:.001:max(powers)]));
xlabel('Powers (W)');ylabel('Dipole osc freq (rad/s)');
title(strcat('Waist =  ',num2str(param_fit)));
legend('Measured','fit');



