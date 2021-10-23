%%%%%%%%%%%%%% BEC analysis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
includePoints=1:length( measNA.parameters);
%Constants

amu=1.6605402e-27; 
mass=23*amu; %23 Na, 40 K
pixelY=2.48; %micron on ycam
pixelZ=2.5; 
kB=1.38064852e-23;
h=6.62607004e-34;
hbar=h/(2*pi);
aBohr=5.2917721067e-11; %Bohr radius in meter
a_s=52*aBohr; %Sodium F=1 scattering length, away from FB resonance
%Trap parameters
fy=41;
fx=13;
fz=47; %Trap frequencies in Hz, measured 3/7/18
omegabar=2*pi*(fx*fy*fz)^(1/3);
%%
%%%%%%%%%%%%%% Temperature %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculates temperature of thermal gas expanding from harmonic potential in
%TOF
% KT = 1/2 m(omega^2/(1+omega^2t^2) x^2), or x(t) = sqrt(2KT(1+omega^2t^2)/m omega^2)

%Uses the Varenna notes definition of width, where the cloud is fitted to
%Exp(-x^2/xw^2), NO FACTOR OF TWO IN THE DEFINITION!!!

%Inputs

params= measNa.parameters; %Time in milliseconds
xwidths= measNa.analysis.fitBimodal.xparam(:,5);
%pixel width, Gaussian
omega= fz*2*pi; %z-trap frequency for Na

[xData, yData] = prepareCurveData(params/1000, xwidths*pixelY );

% Set up fittype and options.
ft = fittype( 'sqrt(a*2*(1+omega^2*x^2))/omega', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [10^7 omega];
opts.Lower=[0 omega];
opts.Upper=[10^9 omega];
%opts.Exclude=[8 ];
% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
c=coeffvalues(fitresult);
ci=confint(fitresult,.68); %returns 68% confidence interval
temp=c(1)*mass/kB/10^3;
dtemp=abs(ci(1,1)-c(1))*mass/kB/10^3;

% Plot fit with data.
figure(99);
plot( fitresult, xData, yData );
legend('Width(um) vs. time(ms)', 'TOF', 'Location', 'NorthEast' );
title(strcat('T(nK) = ', num2str(temp),' +/-', num2str(dtemp),', F(Hz) = ', num2str(omega/2/pi)));
% Label axes
xlabel time(s)
ylabel width(um)
grid on
%%
%%%%%%%%%%%%%% Chemical potential, TF radius, and peak condensate density %%%
%Chemical potential calculated from BEC half length, xparam (z width if
%using ycam images)
tof = 0; %in situ
tof = 2.18e-6;% s, time for Na image in zcam
% omega=2*pi*fy; %lab y direction trap freq
% %tof = params/1000; %varying TOF in seconds
% 
% halfwidthsy=measNA.analysis.fitBimodalExcludeCenter.yparam(:,4).*measNA.analysis.fitBimodalExcludeCenter.yparam(:,5);
% halfwidthsy=halfwidthsy'*pixelZ*10^-6; %TF radius in meters

omega=2*pi*fx; %lab y direction trap freq
%tof = params/1000; %varying TOF in seconds

halfwidthsx=measNA.analysis.fitBimodalExcludeCenter.xparam(:,4).*measNA.analysis.fitBimodalExcludeCenter.xparam(:,5);
halfwidthsx=halfwidthsx'*pixelZ*10^-6; %TF radius in meters
%mu in kHz
chemicalPotential=1/2*mass*omega^2./(1+omega^2*tof.^2).*(halfwidthsx.^2)/h;

ncPeak=h*chemicalPotential*mass/(4*pi*hbar^2*a_s); %peak condensate density in T-F
Nc = (2*chemicalPotential*h).^2.5/(15*hbar^2*sqrt(mass)*omegabar^3*a_s);
mu=mean(chemicalPotential)
ncPeakavg=mean(ncPeak)
Ncavg=mean(Nc)

figure(100);
subplot(1,2,1);
plot(measNA.parameters,ncPeak,'o','MarkerFaceColor','b');ylabel('peak density m^-3');
ylim([0 .3*10^20]);
subplot(1,2,2);
plot(measNA.parameters,Nc,'o','MarkerFaceColor','b');ylabel('Nc');
ylim([0 10^7]);
%save('BECparamsY','mu','ncPeakavg','Ncavg');
%%
%%%%%%%%%%%%%% Condensate fraction and T/Tc %%%%%%%%%%%%%%%%%%%
%%Determination of condensate fraction of all the shots in measurement obj
%%by summing the 1D profile of the condensate: gaussian thermal wings

figure(101);
hold on;
nc1Dint=zeros(1,length(params)); %integrated condensate number, arb scale
nt1Dint=nc1Dint; %integrated thermal number, arbitrary scale
dx=0.05; %pixel interval for integration summing
for i = 1:length(params)
    subplot(floor(length(params)/2),2,i)
    %offset from zero
    %off=meas.analysis.fitBimodal.xparam(params(i),3);
    %Condensate fit parameters 1=amplitude, 4=width ratio,
    cpar=measNa.analysis.fitBimodalExcludeCenter.xparam(params(i), [1 4]);
    %Thermal fit parameters, 2= amplitude ratio, 5=width
    tpar=measNa.analysis.fitBimodalExcludeCenter.xparam(params(i),[2 5]);
    widthBEC=cpar(2)*tpar(2); %in pixel, TF radius
    ampTherm=tpar(1);
    xc=-widthBEC:dx:widthBEC;
    xt=-10*tpar(2):dx:10*tpar(2);
    nc1D=cpar(1)*(1-xc.^2/widthBEC^2).*heaviside((1-xc.^2/widthBEC^2));
    nt1D=ampTherm*exp(-xt.^2/tpar(2)^2);
    plot(xc,nc1D,'b',xt,nt1D,'r');

    nc1Dint(i)=sum(nc1D)*dx;
    nt1Dint(i)=sum(nt1D)*dx;
    title(strcat(num2str(i),'- Nc/N = ', num2str(nc1Dint(i)/(nc1Dint(i)+nt1Dint(i)))));
    xlim([-50,50]);
end
legend('condensate','thermal');
%Condensate fraction
nc1Dint=nc1Dint(includePoints);
nt1Dint=nt1Dint(includePoints);

cfraction=(nc1Dint./(nc1Dint+nt1Dint));
%cerr=std(nc1Dint./(nc1Dint+nt1Dint))
%T/Tc
ToverTc=(1-cfraction).^(1/3);
%Ntotal=Nc(includePoints)./cfraction;
