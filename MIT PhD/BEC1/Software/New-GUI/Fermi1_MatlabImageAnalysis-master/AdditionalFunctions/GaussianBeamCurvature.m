lambda = 1.064e-6;
omega0 = 100e-6;
n = 1.4496;
distance = 1e-3*(12.7+8*n+5);

zR = @(omega) pi*omega^2/lambda;
waist = @(z,omega) omega.*sqrt(1+(z./zR(omega)).^2); 
CurvatureRadius = @(z,omega) z.*(1+(zR(omega)./z).^2); 

zVals = 0.01:0.000001:0.06;
figure(337),clf;
subplot(3,1,1);
hold on
plot(zVals*1e3,CurvatureRadius(zVals,omega0),'LineWidth',2)
plot(zVals*1e3,CurvatureRadius(zVals,2*omega0),'LineWidth',2)
plot(1e3*[distance,distance],ylim,'k')
legend(['waist 100um radius @lens = ' num2str(CurvatureRadius(distance,omega0),2)],...
       ['waist 200um radius @lens = ' num2str(CurvatureRadius(distance,2*omega0),2)])
xlabel('distance (mm)')
ylabel('radius (m)')
box on
set(gca, 'FontName', 'Arial')
    set(gca,'FontSize', 14);

   


subplot(3,1,2);
hold on
plot(zVals*1e3,1e3*waist(zVals,omega0),'LineWidth',2)
plot(zVals*1e3,1e3*waist(zVals,2*omega0),'LineWidth',2)
plot(xlim,sqrt(2)*[omega0,omega0]*1e3,'k')
xlabel('distance (mm)')
ylabel('waist (\mum)')
box on
set(gca, 'FontName', 'Arial')
    set(gca,'FontSize', 14);
    
    
subplot(3,1,3);
hold on
%plot(zVals*1e3,(waist(zVals,omega0)./omega0(1)).^2,'LineWidth',2)
plot(zVals*1e3,(waist(zVals,2*omega0)./(2*omega0(1))).^2,'LineWidth',2)
plot(2*1e3*[distance,distance],ylim,'k')
xlabel('distance (mm)')
ylabel('overlap (% with original waist)')
set(gca, 'FontName', 'Arial')
    set(gca,'FontSize', 14);


figure(338),clf;

rVals = 1e-6*[-50:50];

lattice = 50*532e-3;

amplitude = @(r,omega0) exp((-2*r.^2)/(omega0)^2);
hold on
plot(rVals*1e6,amplitude(rVals,omega0),'LineWidth',2)
plot(rVals*1e6,amplitude(rVals,2*omega0),'LineWidth',2)
plot([-lattice,-lattice],ylim,'k')
plot([lattice,lattice],ylim,'k')
legend(['waist 100um'],...
       ['waist 200um'])
box on
xlabel('radial distance (\mum)')
ylabel('rel intensity')
set(gca, 'FontName', 'Arial')
    set(gca,'FontSize', 14);