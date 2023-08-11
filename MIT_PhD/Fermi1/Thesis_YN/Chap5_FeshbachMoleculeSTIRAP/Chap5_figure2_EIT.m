%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% EIT with upleg power 50mW
data0 = load('..\..\202206\220615\run7_ScanTransition9UplegOnly_500mW_100us\analysisContainer.mat');
color0 = [0 0 0];%[0.6350, 0.0780, 0.1840];

data1 = load('..\..\202206\220615\run8_ScanDownlegFreqATspectrumTransition9_upleg50mWDownleg3p6mW\analysisContainer.mat');
color1 = [0 0 0];%[0.4660, 0.6740, 0.1880];

data2 = load('..\..\202206\220615\run9_ScanDownlegATspec_T9_up50mW_Down_1mW\analysisContainer.mat');
color2 = [0 0 0];%[0.8500, 0.3250, 0.0980];

data3 = load('..\..\202206\220615\run10_ScanUplegATspec_Trans9_upleg50mW_Downleg_1mW_downlegULEAOMrecenter\analysisContainer.mat');
color3 = [0 0 0];%[0, 0.4470, 0.7410];

data4 = load('..\..\202207\220706\run1_EIT_two_photon_resonance_scan_upleg\analysisContainer.mat');
color4 = [0 0 0];

%% plot EIT spectrum in 2D water fall  
% offset5 = 0;
offset4 = 0;
offset3 = 300;
% offset2 = 600;
offset1 = 600;

xlimit = [-45,45];
ylimit = [-10,900];

size_marker = 25;
line_width = 3;
line_color = [0 0 0 0.5];

f2 = figure(2);clf;hold on; box on;
f2.Position = [f2.Position(1) f2.Position(2) 550 600];
plot(data1.analysisContainer.FitXval,...
    data1.analysisContainer.FitYval+offset1,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(data1.analysisContainer.DataAverage.xvalsAveraged,...
         data1.analysisContainer.DataAverage.yvalsAveraged+offset1,...
         data1.analysisContainer.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',color1);    

% plot(data2.analysisContainer.FitXval,...
%     data2.analysisContainer.FitYval+offset2,...
%     'k','LineWidth',line_width,'color',line_color);
% errorbar(data2.analysisContainer.DataAverage.xvalsAveraged,...
%          data2.analysisContainer.DataAverage.yvalsAveraged+offset2,...
%          data2.analysisContainer.DataAverage.yStdAveraged,...
%          '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',color2);   

plot(data3.analysisContainer.FitXval,...
    data3.analysisContainer.FitYval+offset3,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(data3.analysisContainer.DataAverage.xvalsAveraged,...
         data3.analysisContainer.DataAverage.yvalsAveraged+offset3,...
         data3.analysisContainer.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',color3);   

plot(data4.analysisContainer.FitXval,...
    data4.analysisContainer.FitYval+offset4,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(data4.analysisContainer.DataAverage.xvalsAveraged,...
         data4.analysisContainer.DataAverage.yvalsAveraged+offset4,...
         data4.analysisContainer.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',color0);
     
% plot(data0.analysisContainer.FitXval,...
%     data0.analysisContainer.FitYval+offset5,...
%     'k','LineWidth',line_width,'color',line_color);
% errorbar(data0.analysisContainer.DataAverage.xvalsAveraged,...
%          data0.analysisContainer.DataAverage.yvalsAveraged+offset5,...
%          data0.analysisContainer.DataAverage.yStdAveraged,...
%          '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',color0);
    
xlim(xlimit);
ylim(ylimit);

xlabel('\delta_{2photon}/(2\pi) (MHz)');
ylabel('^{40}K atom number (arb)');

set(gca,'fontsize',16,'fontname','arial',...
    'YTick',[]); 


colororder({'k','k'})
yyaxis right; 
ylim(ylimit);
yticks([offset4 offset3 offset1]+100);
yticklabels({num2str(data4.analysisContainer.machineNotes.DownlegPower_mW*1e3),...
    num2str(data3.analysisContainer.machineNotes.DownlegPower_mW*1e3),...
    num2str(data1.analysisContainer.machineNotes.DownlegPower_mW*1e3)}');
ylabel('downleg power (\muW)');



% plot narrow EIT zoomed in spectrum 
f22 = figure(22);clf;box on;hold on;
f22.Position = [f22.Position(1) f22.Position(2) 250 200];
plot(data4.analysisContainer.FitXval,...
    data4.analysisContainer.FitYval,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(data4.analysisContainer.DataAverage.xvalsAveraged,...
         data4.analysisContainer.DataAverage.yvalsAveraged,...
         data4.analysisContainer.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',color0);
xlim([-2 2]);
ylim([0 400]);
set(gca,'fontsize',16,'fontname','arial',...
    'YTick',[]);  


%% plot Rabi rate vs power
uplegPower_mW = [data0.analysisContainer.machineNotes.UplegPower_mW 
                 data00.analysisContainer.machineNotes.UplegPower_mW 
                 data1.analysisContainer.machineNotes.UplegPower_mW 
                 data2.analysisContainer.machineNotes.UplegPower_mW 
                 data3.analysisContainer.machineNotes.UplegPower_mW 
                 data4.analysisContainer.machineNotes.UplegPower_mW 
                 data5.analysisContainer.machineNotes.UplegPower_mW];

uplegRabi_MHz = [data0.analysisContainer.FitParameter(2)
                 data00.analysisContainer.FitParameter(2) 
                 data1.analysisContainer.FitParameter(2)
                 data2.analysisContainer.FitParameter(2)
                 data3.analysisContainer.FitParameter(2)
                 data4.analysisContainer.FitParameter(2)
                 data5.analysisContainer.FitParameter(2)];    
             
uplegRabiCi_MHz = [data0.analysisContainer.FitParameter_ci(2)
                 data00.analysisContainer.FitParameter_ci(2) 
                 data1.analysisContainer.FitParameter_ci(2)
                 data2.analysisContainer.FitParameter_ci(2)
                 data3.analysisContainer.FitParameter_ci(2)
                 data4.analysisContainer.FitParameter_ci(2)
                 data5.analysisContainer.FitParameter_ci(2)];                 
             
figure(4);clf;
errorbar(uplegPower_mW,uplegRabi_MHz,uplegRabiCi_MHz,'.',...
    'MarkerSize',15,'CapSize',0);
xlim([0,1200]);
xlabel('upleg power (mW)');
ylabel('\Omega_{upleg}/2\pi (MHz)');
title('Upleg Rabi rate vs power');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);




downlegPower_mW = [data1.analysisContainer.machineNotes.DownlegPower_mW 
                 data2.analysisContainer.machineNotes.DownlegPower_mW 
                 data3.analysisContainer.machineNotes.DownlegPower_mW 
                 data4.analysisContainer.machineNotes.DownlegPower_mW 
                 data5.analysisContainer.machineNotes.DownlegPower_mW];

downlegRabi_MHz = [data1.analysisContainer.FitParameter(3)
                 data2.analysisContainer.FitParameter(3)
                 data3.analysisContainer.FitParameter(3)
                 data4.analysisContainer.FitParameter(3)
                 data5.analysisContainer.FitParameter(3)];    

downlegRabiCi_MHz = [data1.analysisContainer.FitParameter_ci(3)
                 data2.analysisContainer.FitParameter_ci(3)
                 data3.analysisContainer.FitParameter_ci(3)
                 data4.analysisContainer.FitParameter_ci(3)
                 data5.analysisContainer.FitParameter_ci(3)];                
             
figure(5);clf;
errorbar(downlegPower_mW,downlegRabi_MHz,downlegRabiCi_MHz,'.',...
    'MarkerSize',15,'CapSize',0);
xlim([0,5]);
xlabel('downleg power (mW)');
ylabel('\Omega_{downleg}/2\pi (MHz)');
title('Downleg Rabi rate vs power');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);


