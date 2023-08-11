% Figure4: compare the STIRAP time evolution between polaron STIRAP and
% Feshbach molecule route

%% 804nm T3 polaron STIRAP time evolution
clear;

Polaron830nmT3_1 = struct;
Polaron830nmT3_1.dir_BECanlysis = '..\..\202209\220927\run7__PolaronSTIRAP830nmT3_TimeEvolution_30usSingleTrip_0usGSMoltime\BECanalysis.mat';
Polaron830nmT3_1.dir_Bootanalysis = '..\..\202209\220927\run7__PolaronSTIRAP830nmT3_TimeEvolution_30usSingleTrip_0usGSMoltime\BECanalysis.mat';
Polaron830nmT3_1.BECanalysis = [];
Polaron830nmT3_1.BootAnalysis = [];
Polaron830nmT3_1 = load_data(Polaron830nmT3_1,Polaron830nmT3_1.dir_BECanlysis);
Polaron830nmT3_1.t_STIRAP = 30;

['830 T3 STIRAP \delta_{1photon}=' num2str((Polaron830nmT3_1.BECanalysis.machineNotes.ScanList.uplegAOM_MHz(1)-165)*2) ' MHz']

Polaron804nmT3_2 = struct;
Polaron804nmT3_2.dir_BECanlysis = '..\..\202210\221011\run6_PolaronSTIRAP_804nmT3_TimeEvolution_UplegShape0p1\BECanalysis.mat';
Polaron804nmT3_2.dir_Bootanalysis = '..\..\202210\221011\run6_PolaronSTIRAP_804nmT3_TimeEvolution_UplegShape0p1\BootAnalysis.mat';
Polaron804nmT3_2.BECanalysis = [];
Polaron804nmT3_2.BootAnalysis = [];
Polaron804nmT3_2 = load_data(Polaron804nmT3_2,Polaron804nmT3_2.dir_BECanlysis);
Polaron804nmT3_2.t_STIRAP = 30;



% plot polaron STIRAP with absolute atom number and time us
ncnt2atomnumer = 157*3;

gammaG = 2*pi*(1/1000e-6);
w_CE_beta = 1.3;
w_FE = 0.6;
w_EG = 3;
t_SingleTrip = 30;
uplegShape = 1;

offset = 0.2;
amp = 1-offset;

t_STIRAP = linspace(0,60);
[populationFC, populationG,population_F,population_C] = fitfun_STIRAP_timeEvolution(gammaG,w_CE_beta,w_FE,w_EG,t_SingleTrip,uplegShape,t_STIRAP);
populationFC = populationFC*amp+offset;
populationF = population_F*amp+offset;
populationG = populationG*amp;
populationC = population_C*amp;

% create STIRAP Rabi rate curves
t1 = linspace(0,30);
t3 = linspace(30,60);
downleg1 = 0.5*sin(2*pi/30/2*t1+pi/2)+0.5;
downleg3 = 0.5*sin(2*pi/30/2*(t1+30)+pi/2)+0.5;
upleg1 = 0.5*sin(2*pi/30/2*t1-pi/2)+0.5;
upleg3 = 0.5*sin(2*pi/30/2*(t1+30)-pi/2)+0.5;

t = [t1 t3];
downleg = [downleg1 downleg3]*3/10;
upleg = [upleg1 upleg3]*0.6/10;
%
f44 = figure(44);clf;
f44.Position = [681 100 600 600];
subplot(4,1,1);box on;hold on;
plot(t,downleg,...
    'linewidth',2,'color',[0.4660 0.6740 0.1880]);
plot(t,upleg,...
    'linewidth',2,'color',[0.8500 0.3250 0.0980]);
ylim([-0.05 0.4]);
xlim([-1 61]);
set(gca,'fontsize',14,'fontname','arial',...
    'XTickLabel',[]);
ylabel('\Omega_{1,2}/\gamma_e','FontSize',12);

subplot(4,1,2:4);box on;hold on;
slice_index = 3;
color_grayScale(2,:) = [1 1 1]*0;
% legendLabel(2) = {sprintf('T/T_C=%0.1f',...
%     Polaron830nmT3_1.BECanalysis.TransferredFractions.localToverTcPerEn_weigthed(slice_index))};

plot(t_STIRAP,...
    populationFC*ncnt2atomnumer*Polaron830nmT3_1.BECanalysis.counts.median(slice_index,1),...
    '-','LineWidth',3,'color',[0 0 0 0.5]);
plot(t_STIRAP,...
    populationC*ncnt2atomnumer*Polaron830nmT3_1.BECanalysis.counts.median(slice_index,1),...
    '-','LineWidth',3,'color',[0.4940 0.1840 0.5560 0.75]);
plot(t_STIRAP,...
    populationF*ncnt2atomnumer*Polaron830nmT3_1.BECanalysis.counts.median(slice_index,1),...
    '-','LineWidth',3,'color',[0 0.4470 0.7410 0.5]);
plot(t_STIRAP,...
    populationG*ncnt2atomnumer*Polaron830nmT3_1.BECanalysis.counts.median(slice_index,1),...
    '-','LineWidth',3,'color',[0.4660 0.6740 0.1880 0.75]);

errorbar(Polaron830nmT3_1.BECanalysis.transfer.xvals,...
    Polaron830nmT3_1.BECanalysis.counts.median(slice_index,:)*ncnt2atomnumer,...
    Polaron830nmT3_1.BECanalysis.counts.errorNeg(slice_index,:)*ncnt2atomnumer,...
    Polaron830nmT3_1.BECanalysis.counts.errorNeg(slice_index,:)*ncnt2atomnumer,...
    '.','MarkerSize',30,'LineWidth',2,'CapSize',0,...
    'Color',[0 0 0]);


xlim([-1,61]);
ylim([-100,4e3]);
ylabel('^{40}K number');
xlabel('time (\mus)');
% title('Polaron STIRAP time evolution triplet rich transition');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);



%% 4x4 maxtrix STIRAP dressed state picture with continuum 

gammaE = 2*pi*10e6;
stepSize = 4e1;

E_polaron = -2*pi*16e3;

t_SingleTrip = 30;
uplegShape = 1;


w_FE2_beta = 0;
w_GE2_beta = 0;

deltaFE = 2*pi*0e6;
deltaGE = deltaFE;
deltaE2 = 2*pi*-118.9e6;


w_FE_amp = 2*pi*1e6*w_FE;
w_EG_amp = 2*pi*1e6*w_EG;
t_SingleTrip = 1e-6*t_SingleTrip;
t_STIRAP = linspace(0,4*t_SingleTrip,stepSize);


w_FE_arb = w_FE_amp*((sin(t_STIRAP*pi/t_SingleTrip+pi/2)+1)/2).^uplegShape;
w_FE_arb(1:length(t_STIRAP)/4)=0;
w_FE_arb(length(t_STIRAP)*3/4:end)=0;

w_EG = w_EG_amp*(sin(t_STIRAP*pi/t_SingleTrip+pi/2*3)+1)/2;

gammaC = 2*pi*0;

[population_P,population_E,population_G,eigenE_sorted,eigenstates] =...
    propagator_STIRAP_TimeEvolution_DressedAtom_4by4(w_FE_arb,w_EG,t_STIRAP,...
                'deltaFE',deltaFE,'deltaGE',deltaGE,'deltaE2',deltaE2,...
                'gammaE',gammaE,'gammaC',gammaC,...
                'w_CE_beta',w_CE_beta,'w_FE2_beta',w_FE2_beta,'w_GE2_beta',w_GE2_beta,...
                'E_polaron',E_polaron,...
                'plotOn',true);
figure(77);            
subplot(4,1,1);ylim([-0.02 0.35]);

%% 804 STIRAP calculation packaged fit function normalized atom number
% data with upleg shape = 0.1
gammaG = 2*pi*(1/1000e-6);
w_CE_beta = 1.2;
w_FE = 0.6;
w_EG = 3;
t_SingleTrip = 30;
uplegShape = 0.5;

offset = 0.275;
amp = 1-offset;

t_STIRAP = linspace(0,60);
[populationFC, populationG] = fitfun_STIRAP_timeEvolution(gammaG,w_CE_beta,w_FE,w_EG,t_SingleTrip,uplegShape,t_STIRAP);
populationFC = populationFC*amp+offset;
populationG = populationG*amp+offset;

[populationFC2, populationG2] = fitfun_STIRAP_timeEvolution(gammaG,w_CE_beta,w_FE*0.4,w_EG,t_SingleTrip,uplegShape,t_STIRAP);
populationFC2 = populationFC2*amp+offset;
populationG2 = populationG2*amp+offset;

[populationFC3, populationG3] = fitfun_STIRAP_timeEvolution(gammaG,w_CE_beta,w_FE*0.2,w_EG,t_SingleTrip,uplegShape,t_STIRAP);
populationFC3 = populationFC3*amp+offset;
populationG3 = populationG3*amp+offset;



% color_grayScale = nan(Polaron804nmT3_2.BECanalysis.TransferredFractions.numAveragedSpectra,3);
legendLabel = {};

figure(222);clf;box on;hold on;
slice_index = 1;
color_grayScale(1,:) = [1 1 1]*0.7;
legendLabel(1) = {sprintf('T/T_C=%0.2f',...
    Polaron830nmT3_1.BECanalysis.TransferredFractions.localToverTcPerEn_weigthed(slice_index))};

errorbar(Polaron830nmT3_1.BECanalysis.transfer.xvals/Polaron830nmT3_1.t_STIRAP,...
    Polaron830nmT3_1.BECanalysis.transfer.median(slice_index,:),...
    Polaron830nmT3_1.BECanalysis.transfer.errorNeg(slice_index,:),...
    Polaron830nmT3_1.BECanalysis.transfer.errorNeg(slice_index,:),...
    'k.','MarkerSize',30,'LineWidth',2,'CapSize',0,...
    'Color',color_grayScale(1,:));

slice_index = 3;
color_grayScale(2,:) = [1 1 1]*0;
legendLabel(2) = {sprintf('T/T_C=%0.2f',...
    Polaron830nmT3_1.BECanalysis.TransferredFractions.localToverTcPerEn_weigthed(slice_index))};

errorbar(Polaron830nmT3_1.BECanalysis.transfer.xvals/Polaron830nmT3_1.t_STIRAP,...
    Polaron830nmT3_1.BECanalysis.transfer.median(slice_index,:),...
    Polaron830nmT3_1.BECanalysis.transfer.errorNeg(slice_index,:),...
    Polaron830nmT3_1.BECanalysis.transfer.errorNeg(slice_index,:),...
    'k.','MarkerSize',30,'LineWidth',2,'CapSize',0,...
    'Color',color_grayScale(2,:));


plot(t_STIRAP/Polaron830nmT3_1.t_STIRAP,populationFC,'-','LineWidth',2,'color',color_grayScale(2,:));

legend(legendLabel,'Location','best');


xlim([-0.1,2.1]);
ylim([0,1.2]);
ylabel('polaron number');
xlabel('time');
title('Polaron STIRAP time evolution');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);


            
            
            %% 804nm Feshbach molecule STIRAP time evolution normalized atom number

FBmol804nmT9_1 = struct;
FBmol804nmT9_1.dir = '..\..\202206\220628\run9_STIRAP_TimeEvolution_20usSingleTripTime_TiSaHoldLock\analysisContainer.mat';
FBmol804nmT9_1 = load_analysisContainer(FBmol804nmT9_1,FBmol804nmT9_1.dir);
FBmol804nmT9_1.t_STIRAP = 20;

RF_efficiency = 0.2;

figure(224);clf;hold on; box on;

errorbar(FBmol804nmT9_1.analysisContainer.DataAverage.xvalsAveraged/FBmol804nmT9_1.t_STIRAP,...
    FBmol804nmT9_1.analysisContainer.DataAverage.yvalsAveraged*RF_efficiency,...
    FBmol804nmT9_1.analysisContainer.DataAverage.yStdAveraged*RF_efficiency,...
    'k.','MarkerSize',30,'LineWidth',2,'CapSize',0,...
    'Color',[0 0 0]);
plot(FBmol804nmT9_1.analysisContainer.FitXval*1e6/FBmol804nmT9_1.t_STIRAP,...
    FBmol804nmT9_1.analysisContainer.FitYval*RF_efficiency,...
    'k-','LineWidth',1.5)

xlim([-0.2,2.1]);
ylim([-0.04,0.3]);
ylabel('fermion number');
xlabel('time');
title('Feshbach molecule STIRAP time evolution insert');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);

figure(223);clf;hold on; box on;

errorbar(FBmol804nmT9_1.analysisContainer.DataAverage.xvalsAveraged/FBmol804nmT9_1.t_STIRAP,...
    FBmol804nmT9_1.analysisContainer.DataAverage.yvalsAveraged*RF_efficiency,...
    FBmol804nmT9_1.analysisContainer.DataAverage.yStdAveraged*RF_efficiency,...
    'k.','MarkerSize',30,'LineWidth',2,'CapSize',0,...
    'Color',[0 0 0]);
plot(FBmol804nmT9_1.analysisContainer.FitXval*1e6/FBmol804nmT9_1.t_STIRAP,...
    FBmol804nmT9_1.analysisContainer.FitYval*RF_efficiency,...
    'k-','LineWidth',1.5)

xlim([-0.2,2.1]);
ylim([0,1.2]);
ylabel('fermion number');
xlabel('time');
title('Feshbach molecule STIRAP time evolution');
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);


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

function output = load_analysisContainer_atomNumber(input,dir)
load(dir,'analysisContainer_atomNumber');
% load(dir_Bootanalysis,'BootAnalysis');

input.analysisContainer = analysisContainer_atomNumber;
% input.Bootanalysis = BootAnalysis;

output = input; 


end

function [populationFC,population_G,population_F,population_C] = fitfun_STIRAP_timeEvolution(gammaG,w_CE_beta,w_FE,w_EG,t_SingleTrip,arb_factor,t)

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




