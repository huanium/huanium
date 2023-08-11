clear;
[T0,rho_medium0,rho_molecule0] = sphere(50);

approach.FBmol.property.description = 'Feshbach molecule+STIRAP';
approach.FBmol.property.T = log10(100e-9);
approach.FBmol.property.rho_medium = 0;
approach.FBmol.property.rho_molecule = log10(1e12);
approach.FBmol.T = T0+approach.FBmol.property.T; 
approach.FBmol.rho_medium = rho_medium0+approach.FBmol.property.rho_medium; 
approach.FBmol.rho_molecule = rho_molecule0+approach.FBmol.property.rho_molecule; 
approach.FBmol.color = [0 0 0];

approach.Polaron.property.description = 'Bose polaron+STIRAP';
approach.Polaron.property.T = log10(100e-9);
approach.Polaron.property.rho_medium = log10(7e13);
approach.Polaron.property.rho_molecule = log10(1e10);
approach.Polaron.T = T0+approach.Polaron.property.T; 
approach.Polaron.rho_medium = rho_medium0+approach.Polaron.property.rho_medium; 
approach.Polaron.rho_molecule = rho_molecule0+approach.Polaron.property.rho_molecule; 
approach.Polaron.color = [0, 0.4470, 0.7410];

approach.buffergas.property.description = 'Buffer gas cooling/helium droplet';
approach.buffergas.property.T = log10(1);
approach.buffergas.property.rho_medium = log10(1e15);
approach.buffergas.property.rho_molecule = log10(1e9);
approach.buffergas.T = T0*1.2+approach.buffergas.property.T; 
approach.buffergas.rho_medium = rho_medium0+approach.buffergas.property.rho_medium; 
approach.buffergas.rho_molecule = rho_molecule0+approach.buffergas.property.rho_molecule; 
approach.buffergas.color = [0.4660, 0.6740, 0.1880];

approach.directLaser.property.description = 'Direct laser cooling';
approach.directLaser.property.T = log10(0.1e-3);
approach.directLaser.property.rho_medium = 0;
approach.directLaser.property.rho_molecule = log10(1e9);
approach.directLaser.T = T0*2.5+approach.directLaser.property.T; 
approach.directLaser.rho_medium = rho_medium0+approach.directLaser.property.rho_medium; 
approach.directLaser.rho_molecule = rho_molecule0+approach.directLaser.property.rho_molecule; 
approach.directLaser.color = [0.4940, 0.1840, 0.5560];

f1 = figure(1);clf;hold on;
f1.Position = [0 100 800 800];

sc1=surf(approach.FBmol.T,...
    approach.FBmol.rho_medium*0.1,...
   approach.FBmol.rho_molecule);
sc2=surfc(approach.Polaron.T,...
    approach.Polaron.rho_medium,...
   approach.Polaron.rho_molecule);
sc3=surfc(approach.buffergas.T,...
    approach.buffergas.rho_medium,...
   approach.buffergas.rho_molecule);
sc4=surf(approach.directLaser.T,...
    approach.directLaser.rho_medium*0.1,...
   approach.directLaser.rho_molecule);

z_offset_text = -1.4;
x_offset_text = -1;
text(approach.FBmol.property.T-1,...
    approach.FBmol.property.rho_medium+0.5,...
    approach.FBmol.property.rho_molecule+z_offset_text,...
    approach.FBmol.property.description,...
    'color',approach.FBmol.color,'fontsize',12);
text(approach.Polaron.property.T-1,...
    approach.Polaron.property.rho_medium+0.5,...
    approach.Polaron.property.rho_molecule+z_offset_text,...
    approach.Polaron.property.description,'color',approach.Polaron.color,'fontsize',12);
text(approach.buffergas.property.T-1,...
    approach.buffergas.property.rho_medium+0.5,...
    approach.buffergas.property.rho_molecule+z_offset_text,...
    approach.buffergas.property.description,'color',approach.buffergas.color,'fontsize',12);
text(approach.directLaser.property.T-1,...
    approach.directLaser.property.rho_medium,...
    approach.directLaser.property.rho_molecule+z_offset_text,...
    approach.directLaser.property.description,'color',approach.directLaser.color,'fontsize',12);


shading interp; 
% colormap gray;
light; lighting gouraud;
axis equal; grid on;
view(20,10)

xlim([-8 2]);
ylim([-1 18]);
zlim([5 13]);

xlabel('log_{10}(T (K))');
ylabel('log_{10}(\rho_{bath} (cm^{-3}))','Rotation',30,'Position',[-5 -12 0]);
zlabel('log_{10}(\rho_{molecule} (cm^{-3}))');

set(gca,'YDir','reverse',...
    'Fontsize',16,'fontname','arial');

% set(sc1(2),'Fill','on','FaceColor',approach.FBmol.color,'edgecolor','none');
set(sc2(2),'Fill','on','FaceColor',[approach.Polaron.color],'edgecolor','none');
set(sc3(2),'Fill','on','FaceColor',approach.buffergas.color,'edgecolor','none');
% set(sc4(2),'Fill','on','FaceColor',approach.directLaser.color,'edgecolor','none');

alpha_face = 0.8;
set(sc1(1),'FaceColor',approach.FBmol.color,'FaceAlpha',0.5);
set(sc2(1),'FaceColor',approach.Polaron.color,'FaceAlpha',alpha_face);
set(sc3(1),'FaceColor',approach.buffergas.color,'FaceAlpha',alpha_face);
set(sc4(1),'FaceColor',approach.directLaser.color,'FaceAlpha',alpha_face);


