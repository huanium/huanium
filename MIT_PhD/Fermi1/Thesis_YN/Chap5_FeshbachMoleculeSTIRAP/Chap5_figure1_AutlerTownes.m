%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

dir1 = '..\..\202206\220602\run4_AutlerTownesDownlegFreqScan_upleg1W_downleg57mW_100us';
FBmol_AT = analysisContainer_loader(dir1);


%% plot Autler Townes spectrum
figure(1);clf;hold on; box on;
errorbar(FBmol_AT.DataXval,...
    FBmol_AT.DataYval,...
    FBmol_AT.DataYvalStd,...
    'k.','MarkerSize',30,'capsize',0,'linewidth',2);
plot(FBmol_AT.FitXval,...
    FBmol_AT.FitYval,...
    'linewidth',4,'color',[0 0 0 0.5]);
yticks([0:4e4:12e4]);
xlim([-0.12 0.12]+805.69);
ylim([-1e4,12e4]);

xlabel('\omega_2/2\pi-528THz (GHz)');
ylabel('^{40}K atom number');

set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);
% title(scanListFile.name,'Interpreter','none','fontsize',10);


function output = analysisContainer_loader(dir)

load([dir '\analysisContainer.mat'],'analysisContainer');

output = analysisContainer;

end