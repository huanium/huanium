%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% STIRAP two photon resonance scan
FB_T9 = load('..\..\202207\220705\run1_STIRAP_two_photon_resonance_scan\analysisContainer.mat');
color0 = [0 0 0];%[0.6350, 0.0780, 0.1840];


%% plot STIRAP two photon resonance scan

xlimit = [-0.3,0.3]*1e3;
ylimit = [-1e4,6e4];

ncnt2atomnumber = 480;
size_marker = 30;
line_width = 3;
line_color = [0 0 0 0.5];

f3 = figure(3);clf;hold on; box on;
f3.Position = [f3.Position(1) f3.Position(2) 500 400];
plot((FB_T9.analysisContainer.FitXval-FB_T9.analysisContainer.TwoPhotonResonance)*2*1e3,...
    FB_T9.analysisContainer.FitYval*ncnt2atomnumber-1e4,...
    'k','LineWidth',line_width,'color',line_color);
errorbar((FB_T9.analysisContainer.DataXval-FB_T9.analysisContainer.TwoPhotonResonance)*2*1e3,...
         FB_T9.analysisContainer.DataYval*ncnt2atomnumber-1e4,...
         FB_T9.analysisContainer.DataYvalStd*ncnt2atomnumber,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',2,'color',[0 0 0]);    

xlim(xlimit);
ylim(ylimit);

xlabel('\delta_{2photon}/(2\pi) (kHz)');
ylabel('^{40}K atom number');

set(gca,'fontsize',16,'fontname','arial'); 

