%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% 804nm Feshbach molecule STIRAP time evolution 

dir_timeScan = '..\..\202207\220706\run4_EIT_time_evolution_TiSaHoldLock';

EITtimeScan = load([dir_timeScan '\analysisContainer.mat']);
norm_factor = 331.393;


f9 = figure(9);clf;
f9.Position = [f9.Position(1) f9.Position(2) 500 400];
xlimit = [0,1e3];
ylimit = [-0,1.1];

hold on; box on;
plot(EITtimeScan.analysisContainer.FitXval,...
     EITtimeScan.analysisContainer.FitYval/norm_factor,...
    '-','LineWidth',4,'color',[0 0 0 0.5]);
errorbar(EITtimeScan.analysisContainer.DataAverage.xvalsAveraged,...
         EITtimeScan.analysisContainer.DataAverage.yvalsAveraged/norm_factor,...
         EITtimeScan.analysisContainer.DataAverage.yStdAveraged/norm_factor,...
         '.','MarkerSize',30,'CapSize',0,'Color',[0 0 0],'LineWidth',2);

xlim(xlimit);
ylim(ylimit);
xlabel('time (\mus)');
ylabel('dark state population');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);





