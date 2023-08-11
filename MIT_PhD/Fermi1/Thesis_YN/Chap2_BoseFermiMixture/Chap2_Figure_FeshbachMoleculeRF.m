%%
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

norm_factor = 1.82;
offset_y = 0.06;

atomRF1 = readtable('..\..\202205\220517\run5_BfieldCalibration85p7G\run5_BfieldCalibration85p7G_params.csv');
atomRF1 = filterScanListBadshots(atomRF1);
atomRF1_avg = getAverageValuesWithError_ExcludeSingleShots(atomRF1.rfFreq_kHz,...
    atomRF1.K1_NcntSmall./atomRF1.K2_NcntSmall/norm_factor-offset_y,[]);

FBmolRF1 = readtable('..\..\202205\220517\run6_FBmoleculeScan85p7G_1msSquarePulse\run6_FBmoleculeScan85p7G_1msSquarePulse_params.csv');
FBmolRF1 = filterScanListBadshots(FBmolRF1);
FBmolRF1_avg = getAverageValuesWithError_ExcludeSingleShots(FBmolRF1.rfFreq_kHz,...
    FBmolRF1.K1_NcntSmall./FBmolRF1.K2_NcntSmall/norm_factor-offset_y,[]);

% fit the atomic peak 
fit_data_x = atomRF1_avg.xvalsAveraged;
fit_data_y = atomRF1_avg.yvalsAveraged;
fitfun_1peak = @(p,t) p(1)*exp(-1/2*((t-p(2))/p(3)).^2)+p(4);
fit_names_1peak = {'amp1','center1','sigma1','offset'};

fit_guess_1peak = [ 0.92, 22845, 5, 0.08];
fit_ub    = [ 2, 23e3, 20, 1];
fit_lb    = [ 0, 21e3,  0, 0];

weighted_deviations_K1 = @(p) (fitfun_1peak(p,fit_data_x)-fit_data_y);
optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
[fit_result_1peak,~,~,~,~,~,~]=lsqnonlin(weighted_deviations_K1,fit_guess_1peak,fit_lb,fit_ub,optio);
fit_xval_1peak = linspace(22.819e3,22.861e3);
fit_yval_1peak = fitfun_1peak(fit_result_1peak,fit_xval_1peak);

% fit molecule spectrum
fit_data_x = FBmolRF1_avg.xvalsAveraged;
fit_data_y = FBmolRF1_avg.yvalsAveraged;
fitfun_2peak = @(p,t) p(1)*exp(-1/2*((t-p(2))/p(3)).^2)+...
                      p(4)*exp(-1/2*((t-p(5))/p(6)).^2)+p(7);
fit_names_2peak = {'amp1','center1','sigma1','amp2','center2','sigma2','offset'};

fit_guess_2peak = [ 0.92, 22845, 5, 0.24, 22926,5, 0.08];
fit_ub    = [ 2, 23e3, 20,2, 23e3, 20, 1];
fit_lb    = [ 0, 21e3,  0,0, 21e3,  0, 0];

weighted_deviations_K1 = @(p) (fitfun_2peak(p,fit_data_x)-fit_data_y);
optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
[fit_result_2peak,~,~,~,~,~,~]=lsqnonlin(weighted_deviations_K1,fit_guess_2peak,fit_lb,fit_ub,optio);
fit_xval_2peak = linspace(22.819e3,22.95e3);
fit_yval_2peak = fitfun_2peak(fit_result_2peak,fit_xval_2peak);

offset_x = fit_result_1peak(2);


figure(7);clf;hold on; box on;
errorbar(atomRF1_avg.xvalsAveraged-offset_x,...
         atomRF1_avg.yvalsAveraged,...
         atomRF1_avg.yStdAveraged,...
         '.','MarkerSize',30,'capsize',0,'LineWidth',2);
plot(fit_xval_1peak-offset_x,...
    fit_yval_1peak,...
    '-','LineWidth',3,'color',[0 0.4470 0.7410 0.5]);
errorbar(FBmolRF1_avg.xvalsAveraged-offset_x,...
         FBmolRF1_avg.yvalsAveraged,...
         FBmolRF1_avg.yStdAveraged,...
         'k.','MarkerSize',30,'capsize',0,'LineWidth',2);  
plot(fit_xval_2peak-offset_x,...
    fit_yval_2peak,...
    '-','LineWidth',3,'color',[0 0 0 0.5]);   

xline(0,'linewidth',2,'color',[0 0.4470 0.7410 0.1]);
xline(fit_result_2peak(5)-offset_x,'linewidth',2);

xlim([-40 120]);
ylim([-0 1.3]);
xlabel(['\omega_{rf} (kHz) - ' num2str(offset_x*1e-3,5) ' (MHz)']);     
ylabel('^{40}K atom in m_F=-9/2');
set(gca,'fontsize',16,'fontname','arial');