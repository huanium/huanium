%Compare the difference in En from two methods
%1. First average density, then take ^(2/3) or
%2. First take ^(2/3) then average

%use typical BEC measurements, TF radii in um
xTF=66;
yTF=11;
zTF=8;
Nc=5e5;
prefactorEn=hbar^2/2/mNa*(6*pi^2)^(2/3);

f_BEC=@(x,y,z) 15/(8*pi*xTF*yTF*zTF)*(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2).*heaviside(1-x.^2/xTF^2-y.^2/yTF^2-z.^2/zTF^2);
integrand_BEC=@(x,y,z) Nc^(2/3)*f_BEC(x,y,z).^(5/3); %obtaining n^(2/3)*n
g_BEC=@(x,y,z) Nc*f_BEC(x,y,z).^2; %obtaining n*n


limit=linspace(0,10,100);
EnC=zeros(1,length(limit)-1);
densityC=EnC;
EnCPkDensity=EnC;

for idx=2:length(limit)
    test1=integral3(f_BEC,limit(idx-1),limit(idx),limit(idx-1),limit(idx),limit(idx-1),limit(idx));
    test2=integral3(integrand_BEC,limit(idx-1),limit(idx),limit(idx-1),limit(idx),limit(idx-1),limit(idx));
    EnC(idx-1)=prefactorEn*1e12*test2/test1; %convert to m^-2
    
    densityC(idx-1)=1e18*integral3(g_BEC,limit(idx-1),limit(idx),limit(idx-1),limit(idx),limit(idx-1),limit(idx))/integral3(f_BEC,limit(idx-1),limit(idx),limit(idx-1),limit(idx),limit(idx-1),limit(idx));
    densityC(isnan(densityC))=0;
    EnC(isnan(EnC))=0;

    EnCPkDensity(idx-1)=prefactorEn*(densityC(idx-1))^(2/3);
end

figure(3);
clf;
subplot(2,1,1); hold on;
plot(limit(2:end),EnC/PlanckConst/1000,'.','MarkerSize',30)
plot(limit(2:end),EnCPkDensity/PlanckConst/1000,'.','MarkerSize',20);
xlim([0 max(limit)]);
ylabel('En (kHz)');xlabel('Integration limit (um)');
legend('Raised (2/3) power first, then averaged','Density averaged first');
title('Comparison of two numerical methods');
subplot(2,1,2);
plot(limit(2:end),EnCPkDensity./EnC,'o');
ylabel('Ratio of methods');
xlim([0 max(limit)]);
ylim([.97 1.03]);
%% test of the thermal portion
%%%%%%%%%%%%%%%%%%
omegaX=13*2*pi;omegaY=78*2*pi;omegaZ=110*2*pi;
beta=1/kB/130e-9;
intLimit=sqrt(kB*130e-9*2./mNa./omegaZ^2)*300; %integration limits in meter for calculating thermal number
chemicalPotential=0.82e3*PlanckConst;
f_Therm=@(x,y,z) real(PolyLog(1.5,exp(-beta*abs(chemicalPotential-1/2*mNa*(omegaX^2*x.^2+omegaY^2*y.^2+omegaZ^2*z.^2)))));
%Normalization of f_Therm so that f_Therm/normBose has integral across 3-space =1
fprintf('calculating number of thermal Bosons \n')
normBose=8*integral3(f_Therm,0,omegaZ/omegaX*intLimit,0,omegaZ/omegaY*intLimit,0,intLimit);

%%
tic
prefactorEn=hbar^2/2/mNa*(6*pi^2)^(2/3);
Ntherm=2e5;
pdf_Therm=@(x,y,z) f_Therm(x,y,z)/normBose;
integrand_Therm=@(x,y,z) Ntherm^(2/3)*pdf_Therm(x,y,z).^(5/3); %obtaining n^(2/3)*n
g_Therm=@(x,y,z) Ntherm*pdf_Therm(x,y,z).^2; %obtaining n*n

limit=linspace(0,10,10)/1e6; %in meters
EnT=zeros(1,length(limit)-1);
densityT=EnT;
EnTPkDensity=EnT;

for idx=2:length(limit)
    display(idx)
    test1=integral3(pdf_Therm,limit(idx-1),limit(idx),limit(idx-1),limit(idx),limit(idx-1),limit(idx));
    test2=integral3(integrand_Therm,limit(idx-1),limit(idx),limit(idx-1),limit(idx),limit(idx-1),limit(idx));
    EnT(idx-1)=prefactorEn*test2/test1; %convert to m^-2
    
    densityT(idx-1)=integral3(g_Therm,limit(idx-1),limit(idx),limit(idx-1),limit(idx),limit(idx-1),limit(idx))/integral3(pdf_Therm,limit(idx-1),limit(idx),limit(idx-1),limit(idx),limit(idx-1),limit(idx));

    EnTPkDensity(idx-1)=prefactorEn*(densityT(idx-1))^(2/3);
end

figure(3);
clf;
subplot(2,1,1); hold on;
plot(limit(2:end),EnT/PlanckConst/1000,'.','MarkerSize',30)
plot(limit(2:end),EnTPkDensity/PlanckConst/1000,'.','MarkerSize',20);
xlim([0 max(limit)]);
ylabel('En (kHz)');xlabel('Integration limit (m)');
legend('Raised (2/3) power first, then averaged','Density averaged first');
title('Comparison of two numerical methods:Thermals');
subplot(2,1,2);
plot(limit(2:end),EnTPkDensity./EnT,'o');
ylabel('Ratio of methods');
xlim([0 max(limit)]);
ylim([.99 1.01]);

toc