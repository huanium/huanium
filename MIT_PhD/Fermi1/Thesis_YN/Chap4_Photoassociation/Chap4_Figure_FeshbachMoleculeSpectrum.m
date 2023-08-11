clear; 
cd(fileparts(matlab.desktop.editor.getActiveFilename));

color_H = [0 0.4470 0.7410];
% color_V = [0.8500 0.3250 0.0980];
color_V = color_H;
size_marker = 12;
line_wdith = 1.5;
SpectrumRange = [-0.45 0.45];
SpectrumCenter = 554.175;
ylimit = [0 2];
offset_fitcurve = 2.2;

FBmol_LP_H = load('..\..\202205\220520\run2_85p7G_80kHz_PA_spectrum_50us_55mW_horizontal_polarization/analysisContainer.mat');
FBmol_LP_V = load('..\..\202205\220521\run0_85p7G_80kHz_PA_spectrum_50us_55mW_vertical_polarization/analysisContainer.mat');
FBmol_LP_D = load('..\..\202205\220520\run0_85p7G_80kHz_PA_spectrum_50us_55mW_diagonal_polarization/analysisContainer.mat');

f1=figure(11);clf;
f1.Position = [f1.Position(1)   100   600   900];

subplot(3,1,1);hold on;box on;
errorbar(FBmol_LP_D.analysisContainer.DataAverage.xvalsAveraged,...
         FBmol_LP_D.analysisContainer.DataAverage.yvalsAveraged,...
         FBmol_LP_D.analysisContainer.DataAverage.yStdAveraged,...
         '.','markersize',size_marker,'linewidth',line_wdith,'capsize',0,'color',[0 0 0]);
plot(FBmol_LP_D.analysisContainer.DataAverage.xvalsAveraged,...
         FBmol_LP_D.analysisContainer.DataAverage.yvalsAveraged,...         
         '-','linewidth',1,'color',[0 0 0 0.6]);     
plot(FBmol_LP_D.analysisContainer.FitXval,...
     offset_fitcurve-FBmol_LP_D.analysisContainer.FitYval,...         
    '-','LineWidth',2,'color',[color_H 1]);     

xlim(SpectrumCenter+SpectrumRange);
ylim(ylimit);

% xlabel('\omega_1/2\pi-372THz (GHz)');
ylabel('normalized molecule number');
set(gca,'FontSize',12);
set(gca,'FontName','arial');
yticks1 = [0 0.5 1];
yticks(yticks1);

subplot(3,1,2);hold on;box on;
errorbar(FBmol_LP_H.analysisContainer.DataAverage.xvalsAveraged,...
         FBmol_LP_H.analysisContainer.DataAverage.yvalsAveraged,...
         FBmol_LP_H.analysisContainer.DataAverage.yStdAveraged,...
         '.','markersize',size_marker,'linewidth',line_wdith,'capsize',0,'color',[0 0 0]);
plot(FBmol_LP_H.analysisContainer.DataAverage.xvalsAveraged,...
         FBmol_LP_H.analysisContainer.DataAverage.yvalsAveraged,...         
         '-','linewidth',1,'color',[0 0 0 0.6]);     
plot(FBmol_LP_H.analysisContainer.FitXval,...
     offset_fitcurve-FBmol_LP_H.analysisContainer.FitYval,...         
    '-','LineWidth',2,'color',[color_H 1]);     

xlim(SpectrumCenter+SpectrumRange);
ylim(ylimit);

% xlabel('\omega_1/2\pi-372THz (GHz)');
ylabel('normalized molecule number');
set(gca,'FontSize',12);
set(gca,'FontName','arial');
yticks1 = [0 0.5 1];
yticks(yticks1);

% f2=figure(12);clf;hold on;box on;
% f2.Position = [f2.Position(1)   f2.Position(2)   600   300];
subplot(3,1,3);hold on; box on;
errorbar(FBmol_LP_V.analysisContainer.DataAverage.xvalsAveraged,...
         FBmol_LP_V.analysisContainer.DataAverage.yvalsAveraged,...
         FBmol_LP_V.analysisContainer.DataAverage.yStdAveraged,...
         '.','markersize',size_marker,'linewidth',line_wdith,'capsize',0,'color',[0 0 0]);
plot(FBmol_LP_V.analysisContainer.DataAverage.xvalsAveraged,...
         FBmol_LP_V.analysisContainer.DataAverage.yvalsAveraged,...         
         '-','linewidth',1,'color',[0 0 0 0.6]);     
plot(FBmol_LP_V.analysisContainer.FitXval,...
     offset_fitcurve-FBmol_LP_V.analysisContainer.FitYval,...         
    '-','LineWidth',2,'color',[color_V 1]);     

xlim(SpectrumCenter+SpectrumRange);
ylim(ylimit);

xlabel('\omega_1/2\pi-372THz (GHz)');
ylabel('normalized molecule number');
set(gca,'FontSize',12);
set(gca,'FontName','arial');
yticks1 = [0 0.5 1];
yticks(yticks1);
