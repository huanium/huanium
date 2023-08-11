%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% 830nm triplet EIT 
EIT830nm_1 = load('..\..\202209\220914\run8_PolaronEIT_scanUplegFreq_830nmT2_downleg90uW_upleg_200mW\analysisContainer.mat');
EIT830nm_2 = load('..\..\202209\220914\run6_PolaronEIT_scanUplegFreq_830nmT2_downleg191uW_upleg_200mW\analysisContainer.mat');
EIT830nm_3 = load('..\..\202209\220914\run5_PolaronEIT_scanUplegFreq_830nmT2_downleg660uW_upleg_200mW\analysisContainer.mat');

% 804nm balanced manifold EIT
% EIT_804nm_1 = load('..\..\202206\220615\run7_ScanTransition9UplegOnly_500mW_100us\analysisContainer.mat');
EIT804nm_1 = load('..\..\202206\220615\run8_ScanDownlegFreqATspectrumTransition9_upleg50mWDownleg3p6mW\analysisContainer.mat');
EIT804nm_2 = load('..\..\202206\220615\run9_ScanDownlegATspec_T9_up50mW_Down_1mW\analysisContainer.mat');
EIT804nm_3 = load('..\..\202206\220615\run10_ScanUplegATspec_Trans9_upleg50mW_Downleg_1mW_downlegULEAOMrecenter\analysisContainer.mat');
EIT804nm_4 = load('..\..\202207\220706\run1_EIT_two_photon_resonance_scan_upleg\analysisContainer.mat');

% 830nm singlet EIT
EIT830nm_singlet_4 = load('..\..\..\2020\202010\201008\run5_EIT AT again\analysisContainer.mat');
EIT830nm_singlet_3 = load('..\..\..\2020\202010\201008\run6_EIT-AT-46dBm\analysisContainer.mat');
EIT830nm_singlet_2 = load('..\..\..\2020\202010\201008\run7_EIT-52dBm\analysisContainer.mat');
EIT830nm_singlet_1 = load('..\..\..\2020\202010\201008\run8_EITm57dBm\analysisContainer.mat');

%%
triplet = struct;
triplet.downlegPower_uW = [EIT830nm_1.analysisContainer.machineNotes.DownlegPower_mW ...
    EIT830nm_2.analysisContainer.machineNotes.DownlegPower_mW ...
    EIT830nm_3.analysisContainer.machineNotes.DownlegPower_mW ]*1e3;

triplet.downlegCoupling_MHz = [EIT830nm_1.analysisContainer.fitEIT.fit_results(3) ...
    EIT830nm_2.analysisContainer.fitEIT.fit_results(3) ...
    EIT830nm_3.analysisContainer.fitEIT.fit_results(3)];


balanced = struct;
balanced.downlegPower_uW = [EIT804nm_1.analysisContainer.machineNotes.DownlegPower_mW ...
    EIT804nm_2.analysisContainer.machineNotes.DownlegPower_mW ...
    EIT804nm_3.analysisContainer.machineNotes.DownlegPower_mW ...
    EIT804nm_4.analysisContainer.machineNotes.DownlegPower_mW]*1e3;

balanced.downlegCoupling_MHz = [EIT804nm_1.analysisContainer.FitParameter(3) ...
    EIT804nm_2.analysisContainer.FitParameter(3) ...
    EIT804nm_3.analysisContainer.FitParameter(3) ...
    EIT804nm_4.analysisContainer.FitParameter(3)];


singlet = struct;
singlet.downlegPower_uW = [EIT830nm_singlet_1.analysisContainer.machineNotes.DownlegPower_mW ...
    EIT830nm_singlet_2.analysisContainer.machineNotes.DownlegPower_mW ...
    EIT830nm_singlet_3.analysisContainer.machineNotes.DownlegPower_mW ...
    EIT830nm_singlet_4.analysisContainer.machineNotes.DownlegPower_mW]*1e3;

singlet.downlegCoupling_MHz = [EIT830nm_singlet_1.analysisContainer.fitEIT.fit_results(3) ...
    EIT830nm_singlet_2.analysisContainer.fitEIT.fit_results(3) ...
    EIT830nm_singlet_3.analysisContainer.fitEIT.fit_results(3) ...
    EIT830nm_singlet_4.analysisContainer.fitEIT.fit_results(3)];

xlimit = [-1e2 1.2e3];
ylimit = [0 20];

figure(31);clf;box on; hold on;
plot(triplet.downlegPower_uW,...
    triplet.downlegCoupling_MHz,...
    '.-','markersize',30,'linewidth',4,'color',[0.8500 0.3250 0.0980 0.3]);
plot(balanced.downlegPower_uW,...
    balanced.downlegCoupling_MHz,...
    '.-','markersize',30,'linewidth',4,'color',[0 0.4470 0.7410 0.3]);
plot(singlet.downlegPower_uW,...
    singlet.downlegCoupling_MHz,...
    '.-','markersize',30,'linewidth',4,'color',[0.4660 0.6740 0.1880 0.3]);

xlabel('downleg power (\muW)');
ylabel('\Omega_2/2\pi (MHz)');
xlim(xlimit);
ylim(ylimit);

set(gca,'fontsize',16,'fontname','arial');

triplet.CouplingPerSqrtuW = mean(triplet.downlegCoupling_MHz./(triplet.downlegPower_uW.^0.5));
triplet.CouplingPerSqrtuW_std = std(triplet.downlegCoupling_MHz./(triplet.downlegPower_uW.^0.5));

balanced.CouplingPerSqrtuW = mean(balanced.downlegCoupling_MHz./(balanced.downlegPower_uW.^0.5));
balanced.CouplingPerSqrtuW_std = std(balanced.downlegCoupling_MHz./(balanced.downlegPower_uW.^0.5));

singlet.CouplingPerSqrtuW = mean(singlet.downlegCoupling_MHz./(singlet.downlegPower_uW.^0.5));
singlet.CouplingPerSqrtuW_std = std(singlet.downlegCoupling_MHz./(singlet.downlegPower_uW.^0.5));

% get relative upleg coupling rate from PA paper
uplegCoupling = [62.9281 27.0067 1.2431]/62.9281;

figure(32);clf;hold on;box on;
% colororder({'k','k'});
index = [1 2 3];
plot(index,...
    [triplet.CouplingPerSqrtuW balanced.CouplingPerSqrtuW singlet.CouplingPerSqrtuW]/singlet.CouplingPerSqrtuW,...
    '.-','markersize',30,'color',[0.4660 0.6740 0.1880 0.2],'linewidth',3);
plot(index,...
    uplegCoupling,...
    '.-','markersize',30,'color',[0.8500 0.3250 0.0980 0.2],'linewidth',3);
legend('$\Omega_2/\sqrt{I_{downleg}}$','$\Omega_1/\sqrt{I_{upleg}}$','interpreter','latex')

ylabel('relative \Omega_{1,2}');

set(gca,'XTick',index,'XTickLabel',{'triplet','balanced','singlet'},...
    'fontsize',16,'fontname','arial');


ylim([-0.1 1.5]);
xlim([0.5 3.5]);





