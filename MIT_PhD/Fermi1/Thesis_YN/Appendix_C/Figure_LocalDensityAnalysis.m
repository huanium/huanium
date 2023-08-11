% Figure2: generate PA data 

%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% polaron data for BEC local density analysis
PolaronDecay_1_dir = '..\..\202209\220902\run1_PolaronLifetime_78p56G';
PolaronDecay_1 = BECanalysis_loader(PolaronDecay_1_dir);
PolaronDecay_1.color = [0 0 0];



%% plot BEC local density analysis
pixel_size = 2.13;
z_um = linspace(0,length(PolaronDecay_1.averagedBEC.analysis.localDensityPerPixel.densityCombined),...
    length(PolaronDecay_1.averagedBEC.analysis.localDensityPerPixel.densityCombined))*pixel_size*...
    PolaronDecay_1.averagedBEC.settings.pixelAveraging; %times 2 for pixel averaging

figure(1);clf;box on; hold on;
plot(z_um, PolaronDecay_1.averagedBEC.analysis.localDensityPerPixel.densityCombined,...
    'k','LineWidth',2);
plot(z_um, PolaronDecay_1.averagedBEC.analysis.localDensityPerPixel.densityC,...
    'LineWidth',4,'color',[0 0.4470 0.7410 0.3]);
plot(z_um, PolaronDecay_1.averagedBEC.analysis.localDensityPerPixel.densityT,...
    'LineWidth',4,'color',[0.8500 0.3250 0.0980 0.3]);

slice_index = 3;
pixel_select_1 = (find(PolaronDecay_1.TransferredFractions.selectedPixel(2:end,slice_index) - ...
      PolaronDecay_1.TransferredFractions.selectedPixel(1:end-1,slice_index) ~=0))*2;
xline(pixel_select_1(1)*pixel_size,'linewidth',2);
xline(pixel_select_1(2)*pixel_size,'linewidth',2);

slice_index = 1;
pixel_select_1 = (find(PolaronDecay_1.TransferredFractions.selectedPixel(2:end,slice_index) - ...
      PolaronDecay_1.TransferredFractions.selectedPixel(1:end-1,slice_index) ~=0))*2;
xline(pixel_select_1(1)*pixel_size,'linewidth',2);
xline(pixel_select_1(2)*pixel_size,'linewidth',2);

yticks([round(PolaronDecay_1.TransferredFractions.localDensityPerEn_weigthed*1e-18)*1e18]);

xlim([-120 120]*2+146*2);
ylim([-2e18 6.5e19]);

xlabel('z \mum');
ylabel('density m^{-3}');

set(gca,'FontSize',16,'FontName','Arial');

figure(12);clf;box on; hold on;

plot((1:1:250)*pixel_size,...
    PolaronDecay_1.averagedBEC.lineDensities.Yintegrated,...
    '.','MarkerSize',5,'color',[1 1 1]*0.5);
plot(PolaronDecay_1.averagedBEC.analysis.fitBimodalExcludeCenter.xpix*pixel_size,...
    PolaronDecay_1.averagedBEC.analysis.fitBimodalExcludeCenter.nx,...
    'k.','MarkerSize',5);

% ylim([0 0.35]);



%% Demonstrate two component boson density distribution
pixel_size = 2.13;
figure(11);clf;box on;hold on;
%condensate boson density
% z_um = pixel_size*linspace(0,length(PolaronDecay_1.averagedBEC.analysis.localDensityPerPixel.densityC),...
%     length(PolaronDecay_1.averagedBEC.analysis.localDensityPerPixel.densityC));
plot(z_um,PolaronDecay_1.averagedBEC.analysis.localDensityPerPixel.densityC,...
    'LineWidth',2,'color',[0 0.4470 0.7410]);
%thermal boson density
plot(z_um,PolaronDecay_1.averagedBEC.analysis.localDensityPerPixel.densityT,...
    'LineWidth',2,'color',[0.8500 0.3250 0.0980]);
xlabel('z \mum');
ylabel('density m^{-3}');
xlim([-120 120]*2+146*2);

set(gca,'FontSize',16,'FontName','Arial');

%zoom into the thermal density distribution
f11=figure(111);clf;box on;hold on;
f11.Position = [f11.Position(1) f11.Position(2) 200 200];
plot(z_um,PolaronDecay_1.averagedBEC.analysis.localDensityPerPixel.densityC,...
    'LineWidth',2,'color',[0 0.4470 0.7410]);
plot(z_um,PolaronDecay_1.averagedBEC.analysis.localDensityPerPixel.densityT,...
    'LineWidth',2,'color',[0.8500 0.3250 0.0980]);
set(gca,'FontSize',14,'FontName','Arial');

ylim([0 2e18]);











function output = BECanalysis_loader(dir)

load([dir '\BECanalysis.mat'],'BECanalysis');

output = BECanalysis;

end