% Appendix C: calibrate thermal boson density

%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% polaron data for BEC local density analysis
DimerDecay_1_dir = '..\..\202205\220517\run9_85p7GFBmoleculeLifetime';
DimerDecay_1 = ThermalAnalysis_loader(DimerDecay_1_dir);




%% plot BEC local density analysis
pixel_size = 2.13;
z_um = linspace(0,length(DimerDecay_1.averagedBEC.analysis.localDensityPerPixel.densityCombined),...
    length(DimerDecay_1.averagedBEC.analysis.localDensityPerPixel.densityCombined))*pixel_size;

figure(1);clf;box on; hold on;
plot(z_um, DimerDecay_1.averagedBEC.analysis.localDensityPerPixel.densityCombined,...
    'k','LineWidth',2);
plot(z_um, DimerDecay_1.averagedBEC.analysis.localDensityPerPixel.densityC,...
    'LineWidth',4,'color',[0 0.4470 0.7410 0.3]);
plot(z_um, DimerDecay_1.averagedBEC.analysis.localDensityPerPixel.densityT,...
    'LineWidth',4,'color',[0.8500 0.3250 0.0980 0.3]);

slice_index = 3;
pixel_select_1 = (find(DimerDecay_1.TransferredFractions.selectedPixel(2:end,slice_index) - ...
      DimerDecay_1.TransferredFractions.selectedPixel(1:end-1,slice_index) ~=0));
xline(pixel_select_1(1)*pixel_size,'linewidth',2);
xline(pixel_select_1(2)*pixel_size,'linewidth',2);

slice_index = 1;
pixel_select_1 = (find(DimerDecay_1.TransferredFractions.selectedPixel(2:end,slice_index) - ...
      DimerDecay_1.TransferredFractions.selectedPixel(1:end-1,slice_index) ~=0));
xline(pixel_select_1(1)*pixel_size,'linewidth',2);
xline(pixel_select_1(2)*pixel_size,'linewidth',2);

yticks([round(DimerDecay_1.TransferredFractions.localDensityPerEn_weigthed*1e-18)*1e18]);

xlim([-120 120]+146);
ylim([-2e18 6.5e19]);

xlabel('z \mum');
ylabel('density m^{-3}');

set(gca,'FontSize',16,'FontName','Arial');




%% Demonstrate two component boson density distribution
pixel_size = 2.13;
figure(11);clf;box on;hold on;
%condensate boson density
z_um = pixel_size*linspace(0,length(DimerDecay_1.averagedBEC.analysis.localDensityPerPixel.densityC),...
    length(DimerDecay_1.averagedBEC.analysis.localDensityPerPixel.densityC));
plot(z_um,DimerDecay_1.averagedBEC.analysis.localDensityPerPixel.densityC,...
    'LineWidth',2,'color',[0 0.4470 0.7410]);
%thermal boson density
plot(z_um,DimerDecay_1.averagedBEC.analysis.localDensityPerPixel.densityT,...
    'LineWidth',2,'color',[0.8500 0.3250 0.0980]);
xlabel('z \mum');
ylabel('density m^{-3}');
xlim([-120 120]+146);

set(gca,'FontSize',16,'FontName','Arial');

%zoom into the thermal density distribution
f11=figure(111);clf;box on;hold on;
f11.Position = [f11.Position(1) f11.Position(2) 200 200];
plot(z_um,DimerDecay_1.averagedBEC.analysis.localDensityPerPixel.densityC,...
    'LineWidth',2,'color',[0 0.4470 0.7410]);
plot(z_um,DimerDecay_1.averagedBEC.analysis.localDensityPerPixel.densityT,...
    'LineWidth',2,'color',[0.8500 0.3250 0.0980]);
set(gca,'FontSize',14,'FontName','Arial');

ylim([0 2e18]);











function output = ThermalAnalysis_loader(dir)

load([dir '\thermalAnalysis.mat'],'thermalAnalysis');

output = thermalAnalysis;

end