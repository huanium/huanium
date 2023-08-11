%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% 804nm Feshbach molecule STIRAP time evolution 

dir_uplegScan = '..\..\202207\220705\run6_STIRAP_scan_upleg_power_20us_single_trip';
dir_downlegScan = '..\..\202207\220705\run5_STIRAP_scan_downleg_power_20us_single_trip';

uplegScan = load([dir_uplegScan '\analysisContainer.mat']);
downlegScan = load([dir_downlegScan '\analysisContainer.mat']);



f7 = figure(7);clf;
f7.Position = [f7.Position(1) f7.Position(2) 500 800];
xlimit1 = [-0,1.25];
xlimit2 = [-0,80];
ylimit = [-0.1,1];

subplot(2,1,1);hold on; box on;
plot(uplegScan.analysisContainer.BergmannModel.FitXval_us,...
     uplegScan.analysisContainer.BergmannModel.FitYval,...
    'k-','LineWidth',3,'color',[0.8500 0.3250 0.0980 0.5]);
errorbar(uplegScan.analysisContainer.BergmannModel.DataAverage.xvalsAveraged,...
         uplegScan.analysisContainer.BergmannModel.DataAverage.yvalsAveraged,...
         uplegScan.analysisContainer.BergmannModel.DataAverage.yStdAveraged,...
         '.','MarkerSize',30,'CapSize',0,'Color',[0 0 0],'LineWidth',2);

xlim(xlimit1);
ylim(ylimit);
xlabel('laser power P_{upleg} (W)');
ylabel('STIRAP efficiency \eta');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);

subplot(2,1,2);hold on; box on;
plot(downlegScan.analysisContainer.BergmannModel.FitXval_us,...
     downlegScan.analysisContainer.BergmannModel.FitYval,...
    'k-','LineWidth',3,'color',[0.4660 0.6740 0.1880 0.5]);
errorbar(downlegScan.analysisContainer.BergmannModel.DataAverage.xvalsAveraged,...
         downlegScan.analysisContainer.BergmannModel.DataAverage.yvalsAveraged,...
         downlegScan.analysisContainer.BergmannModel.DataAverage.yStdAveraged,...
         '.','MarkerSize',30,'CapSize',0,'Color',[0 0 0],'LineWidth',2);

xlim(xlimit2);
ylim(ylimit);

xlabel('laser power P_{downleg} (\muW)');
ylabel('retunring ^{40}K number');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);




