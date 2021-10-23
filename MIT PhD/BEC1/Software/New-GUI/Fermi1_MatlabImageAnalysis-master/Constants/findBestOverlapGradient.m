%%Run this function to see spatial overlap in 1064 trap for Na,K

z=linspace(-100e-6,100e-6,10000);
omegaNa=103*2*pi; %rad/s
% omegaNa=0;
omegaK=omegaNa*sqrt(1/767/(1/767-1/1064)/(1/589/(1/589-1/1064)));
omegaK=omegaNa*1.21; %ac polarizability from mathematica
% omegaNa=0;
Bgrad=-8.14; %Gauss/cm for levitating Na
Bgrad=-12.0; %Gauss/cm for minimizing separation

UtrapNa=1/2*mNa*omegaNa^2*z.^2;
UtrapK=1/2*mK*omegaK^2*z.^2;

potInKHzNa=(gravityPotential('Na',z)+UtrapNa+BgradPotential('Na',Bgrad,z))/PlanckConst/1e3;
potInKHzK=(gravityPotential('K',z)+UtrapK+BgradPotential('K92',Bgrad,z))/PlanckConst/1e3;


figure(1);clf; hold on;

plot(z*1e6,potInKHzNa,z*1e6,potInKHzK);
ylabel('U(z), kHz');xlabel('z, \mu m');

[~,zMinNa]=min(potInKHzNa);
[~,zMinK]=min(potInKHzK);
legend(num2str(z(zMinNa)*1e6),num2str(z(zMinK)*1e6));
title(strcat('Delta z (\mu m) = ', num2str(z(zMinNa)*1e6-z(zMinK)*1e6,3), ' for dB/dZ (G/cm) = ', num2str(Bgrad)));


%% correct gaussian potential

z=linspace(-150e-6,150e-6,5000);
omegaNa=103*2*pi; %rad/s
omegaK=omegaNa*sqrt(1/767/(1/767-1/1064)/(1/589/(1/589-1/1064)));
% omegaNa=0;
Bgrad=-8.14; %Gauss/cm for levitating Na
Bgrad=-11.9; %Gauss/cm for minimizing separation
Bgrad = +5;

posVec = [z;z;z];
UNa = singleBeamPotential('Na',1064e-9,110e-6,2.0,posVec);
UK = singleBeamPotential('K',1064e-9,110e-6,2.0,posVec);

potInKHzNa=(gravityPotential('Na',z)+UNa+BgradPotential('Na',Bgrad,z))/kB*1e6;
potInKHzK=(gravityPotential('K',z)+UK+BgradPotential('K92',Bgrad,z))/kB*1e6;

zMask = -50e-6<z & z<50e-6;
centerZ = z(zMask);
[~,zMinNa]=min(potInKHzNa(zMask));
[~,zMinK]=min(potInKHzK(zMask));

centerZ(zMinNa)-centerZ(zMinK)

figure(1);clf; hold on;
    plot(z*1e6,potInKHzK,'LineWidth',2);
    plot(z*1e6,potInKHzNa,'LineWidth',2);
    plot([centerZ(zMinNa)*1e6,centerZ(zMinNa)*1e6],[-20,20],'k--','LineWidth',2);
    plot([centerZ(zMinK)*1e6,centerZ(zMinK)*1e6],[-20,20],'k--','LineWidth',2);
    ylabel('potential depth (\muK)');
    xlabel('position (\mum)');
    legend('^{40}K', '^{23}Na','Location','northwest');
    box on
    set(gca, 'FontName', 'Arial')
    set(gca,'FontSize', 16);
    ylim([-9,4])

title(strcat('\Deltaz = ', num2str(z(zMinNa)*1e6-z(zMinK)*1e6,3), '\mum @ dB/dZ = ', num2str(-Bgrad), 'G/cm'));
print('-depsc', '-tiff', '-r300', '-painters', ['GravityNotComp'  '.eps'])