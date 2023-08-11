%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% 804nm Feshbach molecule STIRAP time evolution 

dir_Kremoval = '..\..\202206\220629\run4_ScanKRemovalParameters';
dir_Naremoval = '..\..\202206\220629\run3_OptimizedNaAtomRemoval_scanRemovalTime';

Kremoval = load([dir_Kremoval '\analysisContainer.mat']);
Naremoval = load([dir_Naremoval '\analysisContainer.mat']);




f6 = figure(6);clf;
f6.Position = [f6.Position(1) f6.Position(2) 500 800];
xlimit = [-1,45];
ylimit = [-0.1,1.2];

subplot(2,1,1);hold on; box on;
plot(Kremoval.analysisContainer.FitXval,...
     Kremoval.analysisContainer.FitYval,...
    'k-','LineWidth',3,'color',[0 0 0 0.3]);
errorbar(Kremoval.analysisContainer.DataAverage.xvalsAveraged,...
         Kremoval.analysisContainer.DataAverage.yvalsAveraged,...
         Kremoval.analysisContainer.DataAverage.yStdAveraged,...
         '.','MarkerSize',30,'CapSize',0,'Color',[0 0 0],'LineWidth',2);

xlim(xlimit);
ylim(ylimit);

ylabel('Normalized ^{40}K number');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);

subplot(2,1,2);hold on; box on;
plot(Naremoval.analysisContainer.FitXval,...
     Naremoval.analysisContainer.FitYval,...
    'k-','LineWidth',3,'color',[0 0 0 0.3]);
errorbar(Naremoval.analysisContainer.DataAverage.xvalsAveraged,...
         Naremoval.analysisContainer.DataAverage.yvalsAveraged,...
         Naremoval.analysisContainer.DataAverage.yStdAveraged,...
         '.','MarkerSize',30,'CapSize',0,'Color',[0 0 0],'LineWidth',2);

xlim(xlimit);
ylim(ylimit);

xlabel('removal time (\mus)');
ylabel('Normalized ^{23}Na number');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);




