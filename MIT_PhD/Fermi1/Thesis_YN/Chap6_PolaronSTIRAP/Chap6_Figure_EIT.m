%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% 830nm triplet EIT 
EIT830nm_1 = load('..\..\202209\220914\run8_PolaronEIT_scanUplegFreq_830nmT2_downleg90uW_upleg_200mW\analysisContainer.mat');
EIT830nm_2 = load('..\..\202209\220914\run6_PolaronEIT_scanUplegFreq_830nmT2_downleg191uW_upleg_200mW\analysisContainer.mat');
EIT830nm_3 = load('..\..\202209\220914\run5_PolaronEIT_scanUplegFreq_830nmT2_downleg660uW_upleg_200mW\analysisContainer.mat');
% estimate the triplet rich down-leg coupling kHz per muW
mean([EIT830nm_1.analysisContainer.fitEIT.fit_results(3)/90 ...
    EIT830nm_2.analysisContainer.fitEIT.fit_results(3)/191 ...
    EIT830nm_3.analysisContainer.fitEIT.fit_results(3)/660])*1e3
std([EIT830nm_1.analysisContainer.fitEIT.fit_results(3)/90 ...
    EIT830nm_2.analysisContainer.fitEIT.fit_results(3)/191 ...
    EIT830nm_3.analysisContainer.fitEIT.fit_results(3)/660])*1e3

% 830nm singlet EIT
EIT830nm_singlet_4 = load('..\..\..\2020\202010\201008\run5_EIT AT again\analysisContainer.mat');
EIT830nm_singlet_3 = load('..\..\..\2020\202010\201008\run6_EIT-AT-46dBm\analysisContainer.mat');
EIT830nm_singlet_2 = load('..\..\..\2020\202010\201008\run7_EIT-52dBm\analysisContainer.mat');
EIT830nm_singlet_1 = load('..\..\..\2020\202010\201008\run8_EITm57dBm\analysisContainer.mat');
% estimate the singlet rich down-leg coupling kHz per muW
mean([EIT830nm_singlet_1.analysisContainer.fitEIT.fit_results(3)/0.002e3 ...
    EIT830nm_singlet_2.analysisContainer.fitEIT.fit_results(3)/0.0053e3 ...
    EIT830nm_singlet_3.analysisContainer.fitEIT.fit_results(3)/0.0185e3 ...
    EIT830nm_singlet_4.analysisContainer.fitEIT.fit_results(3)/0.042e3])*1e3
std([EIT830nm_singlet_1.analysisContainer.fitEIT.fit_results(3)/0.002e3 ...
    EIT830nm_singlet_2.analysisContainer.fitEIT.fit_results(3)/0.0053e3 ...
    EIT830nm_singlet_3.analysisContainer.fitEIT.fit_results(3)/0.0185e3 ...
    EIT830nm_singlet_4.analysisContainer.fitEIT.fit_results(3)/0.042e3])*1e3

%% plot 830nm singlet EIT
offset1 = -5;
offset2 = 40;
offset3 = 80;
offset4 = 120;

xlimit = [-35,35];
ylimit = [-20,160];

size_marker = 20;
line_width = 3;
line_color = [0.4660 0.6740 0.1880 0.5];

f2 = figure(2);clf;hold on; box on;
f2.Position = [f2.Position(1) 0 500 800];

plot(EIT830nm_singlet_1.analysisContainer.fitEIT.fit_xval,...
    EIT830nm_singlet_1.analysisContainer.fitEIT.fit_yval+offset1,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(EIT830nm_singlet_1.analysisContainer.fitEIT.DataAverage.xvalsAveraged,...
         EIT830nm_singlet_1.analysisContainer.fitEIT.DataAverage.yvalsAveraged+offset1,...
         EIT830nm_singlet_1.analysisContainer.fitEIT.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',[0 0 0]);    
     
plot(EIT830nm_singlet_2.analysisContainer.fitEIT.fit_xval,...
    EIT830nm_singlet_2.analysisContainer.fitEIT.fit_yval+offset2,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(EIT830nm_singlet_2.analysisContainer.fitEIT.DataAverage.xvalsAveraged,...
         EIT830nm_singlet_2.analysisContainer.fitEIT.DataAverage.yvalsAveraged+offset2,...
         EIT830nm_singlet_2.analysisContainer.fitEIT.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',[0 0 0]);    
     
     
plot(EIT830nm_singlet_3.analysisContainer.fitEIT.fit_xval,...
    EIT830nm_singlet_3.analysisContainer.fitEIT.fit_yval+offset3,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(EIT830nm_singlet_3.analysisContainer.fitEIT.DataAverage.xvalsAveraged,...
         EIT830nm_singlet_3.analysisContainer.fitEIT.DataAverage.yvalsAveraged+offset3,...
         EIT830nm_singlet_3.analysisContainer.fitEIT.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',[0 0 0]);    
      
plot(EIT830nm_singlet_4.analysisContainer.fitEIT.fit_xval,...
    EIT830nm_singlet_4.analysisContainer.fitEIT.fit_yval+offset4,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(EIT830nm_singlet_4.analysisContainer.fitEIT.DataAverage.xvalsAveraged,...
         EIT830nm_singlet_4.analysisContainer.fitEIT.DataAverage.yvalsAveraged+offset4,...
         EIT830nm_singlet_4.analysisContainer.fitEIT.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',[0 0 0]);    
           
    
xlim(xlimit);
ylim(ylimit);

xlabel('\delta_{2photon}/(2\pi) (MHz)');
ylabel('^{40}K atom number (arb)');

set(gca,'fontsize',16,'fontname','arial',...
    'YTick',[]); 

% label downleg dressing power
colororder({'k','k'})
yyaxis right; 
ylim(ylimit);
yticks([offset1+10 offset2+10 offset3+10 offset4+10]);
yticklabels({num2str(EIT830nm_singlet_1.analysisContainer.machineNotes.DownlegPower_mW*1e3),...
    num2str(EIT830nm_singlet_2.analysisContainer.machineNotes.DownlegPower_mW*1e3),...
    num2str(EIT830nm_singlet_3.analysisContainer.machineNotes.DownlegPower_mW*1e3),...
    num2str(EIT830nm_singlet_4.analysisContainer.machineNotes.DownlegPower_mW*1e3)});
ylabel('downleg power (\muW)');


xlimit_zoom = [-1 1];
f22 = figure(22);clf;box on;hold on;
f22.Position = [f22.Position(1) f22.Position(2) 250 400];
subplot(2,1,1);box on;hold on;
plot(EIT830nm_singlet_2.analysisContainer.fitEIT.fit_xval,...
    EIT830nm_singlet_2.analysisContainer.fitEIT.fit_yval,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(EIT830nm_singlet_2.analysisContainer.fitEIT.DataAverage.xvalsAveraged,...
         EIT830nm_singlet_2.analysisContainer.fitEIT.DataAverage.yvalsAveraged,...
         EIT830nm_singlet_2.analysisContainer.fitEIT.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',[0 0 0]); 
xlim(xlimit_zoom);
ylim([-5 20]);
set(gca,'fontsize',16,'fontname','arial',...
    'YTick',[]);  
     
subplot(2,1,2);box on;hold on;
plot(EIT830nm_singlet_1.analysisContainer.fitEIT.fit_xval,...
    EIT830nm_singlet_1.analysisContainer.fitEIT.fit_yval+offset1,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(EIT830nm_singlet_1.analysisContainer.fitEIT.DataAverage.xvalsAveraged,...
         EIT830nm_singlet_1.analysisContainer.fitEIT.DataAverage.yvalsAveraged+offset1,...
         EIT830nm_singlet_1.analysisContainer.fitEIT.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',[0 0 0]);    
          
xlim(xlimit_zoom);
ylim([-5 20]);
set(gca,'fontsize',16,'fontname','arial',...
    'YTick',[]);  

%% plot 830nm triplet EIT 
offset1 = 0;
offset2 = 75;
offset3 = 150;

xlimit = [-35,35];
ylimit = [-20,240];

size_marker = 25;
line_width = 3;
line_color = [0.8500 0.3250 0.0980 0.5];

f3 = figure(3);clf;hold on; box on;
f3.Position = [f3.Position(1) 0 500 700];

plot(EIT830nm_1.analysisContainer.fitEIT.fit_xval,...
    EIT830nm_1.analysisContainer.fitEIT.fit_yval+offset1,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(EIT830nm_1.analysisContainer.fitEIT.DataAverage.xvalsAveraged,...
         EIT830nm_1.analysisContainer.fitEIT.DataAverage.yvalsAveraged+offset1,...
         EIT830nm_1.analysisContainer.fitEIT.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',[0 0 0]);    
     
plot(EIT830nm_2.analysisContainer.fitEIT.fit_xval,...
    EIT830nm_2.analysisContainer.fitEIT.fit_yval+offset2,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(EIT830nm_2.analysisContainer.fitEIT.DataAverage.xvalsAveraged,...
         EIT830nm_2.analysisContainer.fitEIT.DataAverage.yvalsAveraged+offset2,...
         EIT830nm_2.analysisContainer.fitEIT.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',[0 0 0]);  
     
     
plot(EIT830nm_3.analysisContainer.fitEIT.fit_xval,...
    EIT830nm_3.analysisContainer.fitEIT.fit_yval+offset3,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(EIT830nm_3.analysisContainer.fitEIT.DataAverage.xvalsAveraged,...
         EIT830nm_3.analysisContainer.fitEIT.DataAverage.yvalsAveraged+offset3,...
         EIT830nm_3.analysisContainer.fitEIT.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',[0 0 0]);  
     
    
xlim(xlimit);
ylim(ylimit);

xlabel('\delta_{2photon}/(2\pi) (MHz)');
ylabel('^{40}K atom number (arb)');

set(gca,'fontsize',16,'fontname','arial',...
    'YTick',[]); 

% label downleg dressing power
colororder({'k','k'})
yyaxis right; 
ylim(ylimit);
yticks([offset1+25 offset2+25 offset3+50]);
yticklabels({'1','2','3'});
yticklabels({num2str(EIT830nm_1.analysisContainer.machineNotes.DownlegPower_mW*1e3),...
    num2str(EIT830nm_2.analysisContainer.machineNotes.DownlegPower_mW*1e3),...
    num2str(EIT830nm_3.analysisContainer.machineNotes.DownlegPower_mW*1e3)});
ylabel('downleg power (\muW)');




%% plot narrow EIT zoomed in spectrum 
f33 = figure(33);clf;box on;hold on;
f33.Position = [f33.Position(1) f33.Position(2) 250 200];
plot(EIT830nm_1.analysisContainer.fitEIT.fit_xval,...
    EIT830nm_1.analysisContainer.fitEIT.fit_yval+offset1,...
    'k','LineWidth',line_width,'color',line_color);
errorbar(EIT830nm_1.analysisContainer.fitEIT.DataAverage.xvalsAveraged,...
         EIT830nm_1.analysisContainer.fitEIT.DataAverage.yvalsAveraged+offset1,...
         EIT830nm_1.analysisContainer.fitEIT.DataAverage.yStdAveraged,...
         '.','MarkerSize',size_marker,'CapSize',0,'LineWidth',1.5,'color',[0 0 0]);    
     
xlim([-2 2]);
ylim([0 70]);
set(gca,'fontsize',16,'fontname','arial',...
    'YTick',[]);  


%% plot Rabi rate vs power
uplegPower_mW = [EIT830nm_1.analysisContainer.machineNotes.UplegPower_mW 
                 EIT830nm_2.analysisContainer.machineNotes.UplegPower_mW 
                 EIT830nm_3.analysisContainer.machineNotes.UplegPower_mW ];

uplegRabi_MHz = [EIT830nm_1.analysisContainer.fitEIT.fit_results(2)
                 EIT830nm_2.analysisContainer.fitEIT.fit_results(2)
                 EIT830nm_3.analysisContainer.fitEIT.fit_results(2)];    
                       
             
figure(4);clf;
plot(uplegPower_mW,uplegRabi_MHz,'.',...
    'MarkerSize',15);
% xlim([0,1200]);
xlabel('upleg power (mW)');
ylabel('\Omega_{upleg}/2\pi (MHz)');
title('Upleg Rabi rate vs power');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);




downlegPower_mW = [EIT830nm_1.analysisContainer.machineNotes.DownlegPower_mW 
                 EIT830nm_2.analysisContainer.machineNotes.DownlegPower_mW 
                 EIT830nm_3.analysisContainer.machineNotes.DownlegPower_mW ];

downlegRabi_MHz = [EIT830nm_1.analysisContainer.fitEIT.fit_results(2)
                 EIT830nm_2.analysisContainer.fitEIT.fit_results(2)
                 EIT830nm_3.analysisContainer.fitEIT.fit_results(2)];    
                                   
             
figure(5);clf;
plot(downlegPower_mW,downlegRabi_MHz,'k.',...
    'MarkerSize',30);
% xlim([0,5]);
ylim([0,1]);
xlabel('downleg power (mW)');
ylabel('\Omega_{downleg}/2\pi (MHz)');
title('Downleg Rabi rate vs power');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);


