%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% 804nm Feshbach molecule STIRAP time evolution 

dir_timeScan = '..\..\202207\220701\run17_Scan_STIRAP_trip_time';

timeScan = load([dir_timeScan '\analysisContainer.mat']);



f8 = figure(8);clf;
f8.Position = [f8.Position(1) f8.Position(2) 500 400];
xlimit = [0,100];
ylimit = [-0,1];

hold on; box on;
plot(timeScan.analysisContainer.FitXval_us,...
     timeScan.analysisContainer.FitYval,...
    '-','LineWidth',4,'color',[0 0 0 0.5]);
plot(timeScan.analysisContainer.FitXval_us,...
     timeScan.analysisContainer.FitYval_adiabaticity,...
    '--','LineWidth',4,'color',[0 0.4470 0.7410 0.3]);
plot(timeScan.analysisContainer.FitXval_us,...
     timeScan.analysisContainer.FitYval_decoherence,...
    '--','LineWidth',4,'color',[0.8500 0.3250 0.0980 0.5]);
errorbar(timeScan.analysisContainer.DataAverage.xvalsAveraged,...
         timeScan.analysisContainer.DataAverage.yvalsAveraged,...
         timeScan.analysisContainer.DataAverage.yStdAveraged,...
         '.','MarkerSize',30,'CapSize',0,'Color',[0 0 0],'LineWidth',2);

xlim(xlimit);
ylim(ylimit);
xlabel('STIRAP pulse time (\mus)');
ylabel('STIRAP efficiency \eta');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);





