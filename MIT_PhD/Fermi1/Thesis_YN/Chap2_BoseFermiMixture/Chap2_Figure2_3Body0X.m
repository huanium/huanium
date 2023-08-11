clear; 
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% load 3 body loss data
data = load('..\..\..\2021\202104\210421\run7_threebody_zero_crossing_scan_highODT\analysisContainer.mat');
data_20s = load('..\..\..\2021\202104\210421\run8_20sHoldthreebodyzerocrossing\analysisContainer.mat');

% load 2 body thermalization rate
data_2bodyTherm = load('..\..\..\2018\06June\060418\ZeroCrossings\done\run2\values.mat');


% fit the Na and K counts with Gaussian
fitfun = @(p,t) p(1)*exp(-1/2*((t-p(2))/p(3)).^2)+p(4);
fit_names = {'amp1','center1','sigma1','offset'};
fit_guess = [ 1, 80.3, 0.3, 1];
fit_ub    = [ 2, 82.0, 10,  2];
fit_lb    = [ 0, 79.0,  0,    0];
weighted_deviations_K1 = @(p) (fitfun(p,data_2bodyTherm.values.xvals)-data_2bodyTherm.values.yvals);
optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
[fit_result_2body,~,~,~,~,~,~]=lsqnonlin(weighted_deviations_K1,fit_guess,fit_lb,fit_ub,optio);
fit_xval = linspace(79.8, 84);
fit_yval_2body = fitfun(fit_result_2body,fit_xval);

fit_guess = [ 43e3, 80.3, 0.3, 0];
fit_ub    = [ 50e3, 82.0, 10,  20e3];
fit_lb    = [ 0,    79.0,  0,  0];
weighted_deviations_K1 = @(p) (fitfun(p,data_20s.analysisContainer.DataAveraged.xvalsAveraged)-data_20s.analysisContainer.DataAveraged.yvalsAveraged);
optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
[fit_result_3body,~,~,~,~,~,~]=lsqnonlin(weighted_deviations_K1,fit_guess,fit_lb,fit_ub,optio);
fit_yval_3body = fitfun(fit_result_3body,fit_xval);

xlimit = [79.8 83];
f21 = figure(21);clf;box on;hold on;
f21.Position = [f21.Position(1) 100 500 600];
subplot(2,1,1);hold on;box on;
errorbar(data_2bodyTherm.values.xvals,...
         2-data_2bodyTherm.values.yvals,...
         (data_2bodyTherm.values.y_ci(1,:)-data_2bodyTherm.values.y_ci(2,:))/5,...
         '.','MarkerSize',25,'CapSize',0,'Color',[0 0 0],'LineWidth',2); 
plot(fit_xval,2-fit_yval_2body,...
    '-','color',[0 0 0 0.5],'linewidth',2);
xline(fit_result_2body(2),'linewidth',3);
xlim(xlimit);
ylim([0 2]);
ylabel('\sigma_{2body} (arb)');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 13,'XTickLabel',[]);
subplot(2,1,2);hold on; box on;
errorbar(data_20s.analysisContainer.DataAveraged.xvalsAveraged,...
         data_20s.analysisContainer.DataAveraged.yvalsAveraged,...
         data_20s.analysisContainer.DataAveraged.yStdAveraged/2,...
         '.','MarkerSize',25,'CapSize',0,'Color',[0 0 0],'LineWidth',2);     
plot(fit_xval,fit_yval_3body,...
    '-','color',[0 0 0 0.5],'linewidth',2);
xlim(xlimit);
xline(fit_result_3body(2),'linewidth',3);
xlabel('Magnetic field (G)');
ylabel('^{40}K atom number');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 13);

%%
% plot vs scattering length
figure(22);clf;box on;hold on;
errorbar(data.analysisContainer.DataAveraged.xvalsAveraged_asc,...
         data.analysisContainer.DataAveraged.yvalsAveraged,...
         data.analysisContainer.DataAveraged.yStdAveraged,...
         '.','MarkerSize',25,'CapSize',0,'Color',[0 0 0],'LineWidth',2);     
plot(data.analysisContainer.FitXval_asc,...
    data.analysisContainer.FitYval,...
    'color',[0 0 0 0.5],'LineWidth',4);
xlim([-1800 1800]);
ylim([-1e4 12e4]);
xlabel('a (a_0)');
ylabel('^{40}K atom number');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);

%plot a^4 fit  
% plot(data.analysisContainer.Fit_a4.FitXval_pos,...
%     data.analysisContainer.Fit_a4.FitYval_pos,...
%     '-','color',[0 0.4470 0.7410 0.5],'LineWidth',3);
% 
% plot(data.analysisContainer.Fit_a4.FitXval_neg,...
%     data.analysisContainer.Fit_a4.FitYval_neg,...
%     '-','color',[0 0.4470 0.7410 0.5],'LineWidth',3);

% add B field to the upper x axis
xtick_B = [78.8 79.5 80.3 81 85];
[~,xtick_asc] = FBresonanceLandscape('Binterest',xtick_B,...
                               'plotting',false);

figure(23);clf;box on;hold on;
errorbar(data.analysisContainer.DataAveraged.xvalsAveraged_asc,...
         data.analysisContainer.DataAveraged.yvalsAveraged,...
         data.analysisContainer.DataAveraged.yStdAveraged,...
         '.','MarkerSize',20,'CapSize',0,'Color',[0 0 0],'LineWidth',2);     
plot(data.analysisContainer.FitXval_asc,...
    data.analysisContainer.FitYval,...
    'color',[0 0 0 0.5],'LineWidth',4);

xlim([-1800 1800]);
ylim([-1e4 12e4]);

xlabel('B (G)');
ylabel('^{40}K atom number');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);

set(gca,'XTick',xtick_asc,...
    'XTickLabel',xtick_B,...
    'XTickLabelRotation', 45);

% plot 20s scan zoomed in 
f24 = figure(24);clf;box on;hold on;
f24.Position = [f24.Position(1) f24.Position(2) 400 300];
errorbar(data_20s.analysisContainer.DataAveraged.xvalsAveraged_asc,...
         data_20s.analysisContainer.DataAveraged.yvalsAveraged,...
         data_20s.analysisContainer.DataAveraged.yStdAveraged,...
         '.','MarkerSize',25,'CapSize',0,'Color',[0 0 0],'LineWidth',2);     
plot(data_20s.analysisContainer.FitXval_asc,...
    data_20s.analysisContainer.FitYval,...
    'color',[0 0 0 0.5],'LineWidth',4);
xlim([-1000 1000]);
ylim([-1e4 12e4]);
% xlabel('a (a_0)');
% ylabel('^{40}K atom number');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);

%% plot vs B field
figure(21);clf;box on;hold on;
errorbar(data.analysisContainer.DataAveraged.xvalsAveraged,...
         data.analysisContainer.DataAveraged.yvalsAveraged,...
         data.analysisContainer.DataAveraged.yStdAveraged,...
         '.','MarkerSize',30,'CapSize',0,'Color',[0 0 0],'LineWidth',2);     
plot(data.analysisContainer.FitXval_Bfield,...
    data.analysisContainer.FitYval,...
    'color',[0 0 0 0.5],'LineWidth',4);
xlim([77 84.5]);
ylim([-1e4 12e4]);
xlabel('B (G)');
ylabel('^{40}K atom number');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);




% plot vs inverse scattering length
figure(24);clf;box on;hold on;
errorbar(1./data.analysisContainer.DataAveraged.xvalsAveraged_asc,...
         data.analysisContainer.DataAveraged.yvalsAveraged,...
         data.analysisContainer.DataAveraged.yStdAveraged,...
         '.','MarkerSize',25,'CapSize',0,'Color',[0 0 0],'LineWidth',2);     
% plot(1./data.analysisContainer.FitXval_asc,...
%     data.analysisContainer.FitYval,...
%     'color',[0 0 0 0.5],'LineWidth',4);
xlim([-0.03 0.03]);
ylim([-1e4 12e4]);
xlabel('a^{-1} (a_0^{-1})');
ylabel('^{40}K atom number');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);