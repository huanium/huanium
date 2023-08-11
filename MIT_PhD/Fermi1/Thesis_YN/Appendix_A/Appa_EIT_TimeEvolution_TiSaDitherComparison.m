% plot EIT spectrum
clear;

xlimit = [-40,40];
ylimit = [0,280];

% EIT TimeEvolution with TiSa Dither On
data0 = load('..\..\202207\220706\run2_EIT_time_evolution_TiSaDitherON\analysisContainer.mat');
color0 = [0.8500, 0.3250, 0.0980] ;
norm0 = 367.048;

data1 = load('..\..\202207\220706\run4_EIT_time_evolution_TiSaHoldLock\analysisContainer.mat');
color1 = [0, 0.4470, 0.7410];
norm1 = 331.393;

% plot spectrum 
figure(4);clf;box on;hold on;
errorbar(data1.analysisContainer.DataAverage.xvalsAveraged+1,...
         data1.analysisContainer.DataAverage.yvalsAveraged/norm1,...
         data1.analysisContainer.DataAverage.yStdAveraged/norm1,...
         '.','MarkerSize',30,'CapSize',0,'LineWidth',2,'color',color1);    

errorbar(data0.analysisContainer.DataAverage.xvalsAveraged+1,...
         data0.analysisContainer.DataAverage.yvalsAveraged/norm0,...
         data0.analysisContainer.DataAverage.yStdAveraged/norm0,...
         '.','MarkerSize',30,'CapSize',0,'LineWidth',2,'color',color0);
     
plot(data1.analysisContainer.FitXval+1,...
    data1.analysisContainer.FitYval/norm1,...
    'color',[color1 0.5],'LineWidth',3); 
plot(data0.analysisContainer.FitXval+1,...
    data0.analysisContainer.FitYval/norm0,...
    'color',[color0 0.5],'LineWidth',3);     

xlim([-50,1050]);
ylim([0 1.15]);
xlabel('time (\mus)');
ylabel('normalized ^{40}K number');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);
legend([data1.analysisContainer.machineNotes.TiSaLockMode ' ' data1.analysisContainer.plotText],...
       [data0.analysisContainer.machineNotes.TiSaLockMode ' ' data0.analysisContainer.plotText]);
legend('dither off','dither on');



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


