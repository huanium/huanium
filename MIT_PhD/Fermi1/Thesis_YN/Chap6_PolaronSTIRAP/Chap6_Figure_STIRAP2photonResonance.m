% Figure5: generate STIRAP two photon scan data with absorption images
% 804nm T3 polaron STIRAP time evolution
clear;

Polaron804nmT3_1 = struct;
Polaron804nmT3_1.dir_BECanlysis = '..\..\202208\220825\run9_PolaronSTIRAP_TwoPhotonResonance_T3\BECanalysis.mat';
Polaron804nmT3_1.dir_Bootanalysis = '..\..\202208\220825\run9_PolaronSTIRAP_TwoPhotonResonance_T3\BECanalysis.mat';
Polaron804nmT3_1.BECanalysis = [];
Polaron804nmT3_1.BootAnalysis = [];
Polaron804nmT3_1 = load_data(Polaron804nmT3_1,Polaron804nmT3_1.dir_BECanlysis);

% plot STIRAP two photon spectrum absolute atom number

% create STIRAP Rabi rate curves
t1 = linspace(0,30);
t3 = linspace(30,60);
downleg1 = 0.5*sin(2*pi/30/2*t1+pi/2)+0.5;
downleg3 = 0.5*sin(2*pi/30/2*(t1+30)+pi/2)+0.5;
upleg1 = 0.5*sin(2*pi/30/2*t1-pi/2)+0.5;
upleg3 = 0.5*sin(2*pi/30/2*(t1+30)-pi/2)+0.5;

t = [t1 t3];
downleg = [downleg1 downleg3]*3;
upleg = [upleg1 upleg3]*0.6;


f_AOM = 59.34;
AOM_pass = 2;
ncnt2atomnumer = 157*3;
f33331 = figure(33331);clf;
f33331.Position = [681 100 600 600];
subplot(4,1,1);box on;hold on;
plot(t,downleg,...
    'linewidth',2,'color',[0.4660 0.6740 0.1880]);
plot(t,upleg,...
    'linewidth',2,'color',[0.8500 0.3250 0.0980]);
ylim([-0.1 3.1]);
xlim([0 60]);
xlabel('time (\mus)');
set(gca,'fontsize',16,'fontname','arial');
ylabel('\Omega_{1,2}/2\pi (MHz)','FontSize',12);

subplot(4,1,2:4);box on;hold on;
plot(Polaron804nmT3_1.BECanalysis.STIRAP_2photonCalc_absNum.fit_x,...
    Polaron804nmT3_1.BECanalysis.STIRAP_2photonCalc_absNum.fit_y,...
    'LineWidth',1.5,'color',[0 0 0]);
slice_index = 3;
errorbar((Polaron804nmT3_1.BECanalysis.counts.xvals-f_AOM)*AOM_pass*1e3,...
         Polaron804nmT3_1.BECanalysis.counts.median(slice_index,:)*ncnt2atomnumer,...
         Polaron804nmT3_1.BECanalysis.counts.errorNeg(slice_index,:)*ncnt2atomnumer,...
         Polaron804nmT3_1.BECanalysis.counts.errorPos(slice_index,:)*ncnt2atomnumer,...
        'k.','MarkerSize',30,'LineWidth',2,'CapSize',0);  

xlim([-550,550]);
ylim([-2e2 3e3]);
% legend('calculation','data');
ylabel('^{40}K atom number');
xlabel('\delta_{2photon}/(2\pi) (kHz)');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);
% title('STIRAP two photon spectrum')

%% plot STIRAP two photon spectrum nomalized atom number

figure(3333);clf;box on;hold on;
plot(Polaron804nmT3_1.BECanalysis.STIRAP_2photonCalc_relative.fit_x,...
    Polaron804nmT3_1.BECanalysis.STIRAP_2photonCalc_relative.fit_y,...
    'LineWidth',1.5,'color',[0 0 0]);
% slice_index = 3;
errorbar(Polaron804nmT3_1.BECanalysis.STIRAP_2photonCalc_relative.data_x,...
         Polaron804nmT3_1.BECanalysis.STIRAP_2photonCalc_relative.data_y,...
         Polaron804nmT3_1.BECanalysis.STIRAP_2photonCalc_relative.data_y_errorNeg,...
         Polaron804nmT3_1.BECanalysis.STIRAP_2photonCalc_relative.data_y_errorPos,...
        'k.','MarkerSize',30,'LineWidth',2,'CapSize',0);  

xlim([-550,550]);
ylim([0 1]);
% legend('calculation','data');
ylabel('polaron number');
xlabel('\delta_{2photon}/(2\pi) (kHz)');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);
title('STIRAP two photon spectrum')




%% Auxilary functions

function output = load_data(input,dir_BECanlysis)
load(dir_BECanlysis,'BECanalysis');
% load(dir_Bootanalysis,'BootAnalysis');

input.BECanalysis = BECanalysis;
% input.Bootanalysis = BootAnalysis;

output = input; 


end

function output = load_analysisContainer(input,dir)
load(dir,'analysisContainer');
% load(dir_Bootanalysis,'BootAnalysis');

input.analysisContainer = analysisContainer;
% input.Bootanalysis = BootAnalysis;

output = input; 


end



function [populationFC,population_G] = fitfun_STIRAP_timeEvolution(gammaG,w_CE_beta,w_FE,w_EG,t_SingleTrip,arb_factor,t)

% gammaG = 2*pi*(1/100e-6);
gammaE = 2*pi*10e6;
gammaC = 2*pi*150;
gammaP = 2*pi*47;

w_FE2_beta = 1/4;

deltaFE = 2*pi*0e6;
deltaE2 = 2*pi*-118.9e6;

% stepSize = 1e2;
w_FE_amp = 2*pi*1e6*w_FE;
w_EG_amp = 2*pi*1e6*w_EG;
t_SingleTrip = 1e-6*t_SingleTrip;
t_STIRAP = 1e-6*t;


w_FE_arb = w_FE_amp*((sin(t_STIRAP*pi/t_SingleTrip-pi/2)+1)/2).^arb_factor;

w_EG = w_EG_amp*(sin(t_STIRAP*pi/t_SingleTrip+pi/2)+1)/2;




% [population_F,population_C,population_E,population_E2,population_G] =...
%     propagator_STIRAP_TimeEvolution_PulseShape_continuumShift(w_FE_arb,w_EG,t_STIRAP,...
%                 'deltaFE',deltaFE,'deltaE2',deltaE2,'gammaE',gammaE,'w_CE_beta',w_CE_beta,...
%                 'w_FE2_beta',1,'plotOn',false,'w_FE2_beta',w_FE2_beta);

[population_F,population_C,~,~,population_G] =...
    propagator_STIRAP_TimeEvolution_PulseShape_continuumShift(w_FE_arb,w_EG,t_STIRAP,...
                'deltaFE',deltaFE,'deltaE2',deltaE2,...
                'gammaE',gammaE,...
                'gammaC',gammaC,...
                'gammaF',gammaP,...
                'gammaG',gammaG,...
                'w_CE_beta',w_CE_beta,'w_FE2_beta',w_FE2_beta,'w_FE2_beta',w_FE2_beta,...
                'plotOn',false);

populationFC = population_F+population_C;



end




