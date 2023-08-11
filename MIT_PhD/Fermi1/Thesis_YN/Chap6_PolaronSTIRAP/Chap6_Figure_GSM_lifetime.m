%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% Ground state molecule lifetime inside a BEC
GSM_tau = load('..\..\202208\220831\run9_PolaronSTIRAP_GroundStateMoleculeLifetime\BECanalysis.mat');


%% create STIRAP Rabi rate curves
t1 = linspace(0,30);
t2 = linspace(30,60);
t3 = linspace(60,90);
downleg1 = 0.5*sin(2*pi/30/2*t1+pi/2)+0.5;
downleg2 = zeros(size(t2));
downleg3 = 0.5*sin(2*pi/30/2*(t1+30)+pi/2)+0.5;
upleg1 = 0.5*sin(2*pi/30/2*t1-pi/2)+0.5;
upleg2 = zeros(size(t2));
upleg3 = 0.5*sin(2*pi/30/2*(t1+30)-pi/2)+0.5;

t = [t1 t2 t3];
downleg = [downleg1 downleg2 downleg3];
upleg = [upleg1 upleg2 upleg3];

figure(2);clf;hold on;box on;
plot(t,downleg,...
    'linewidth',2,'color',[0.4660 0.6740 0.1880]);
plot(t,upleg,...
    'linewidth',2,'color',[0.8500 0.3250 0.0980]);

ylabel('\Omega_{1,2} (arb)');

ylim([-0.1 1.1]);
xlim([0 90]);
set(gca,'fontsize',12,'fontname','arial',...
    'XTickLabel',[],'YTickLabel',[]);

%%

beta_GSM = 1/7e13/(GSM_tau.BECanalysis.fitExponential.fit_results(2)*1e-6)

figure(1);clf;box on; hold on;
errorbar(GSM_tau.BECanalysis.fitExponential.fit_data.data_xval,...
    GSM_tau.BECanalysis.fitExponential.fit_data.data_yval(3,:),...
    GSM_tau.BECanalysis.fitExponential.fit_data.data_yval_errorNeg(3,:),...
    GSM_tau.BECanalysis.fitExponential.fit_data.data_yval_errorPos(3,:),...
    'k.','MarkerSize',30,'CapSize',0,'LineWidth',2);
plot(GSM_tau.BECanalysis.fitExponential.fit_xval,...
    GSM_tau.BECanalysis.fitExponential.fit_yval,...
    'LineWidth',2,'color',[0 0 0 0.2]);

ylim([0 1.15]);
xlim([-10 210]);
xlabel('time (\mus)');
ylabel('normalized ^{40}K number');
set(gca,'fontsize',16,'fontname','arial');

f11=figure(11);clf;box on; hold on;
f11.Position = [f11.Position(1) f11.Position(2) 300 200];
errorbar(GSM_tau.BECanalysis.fitExponential.fit_data.data_xval,...
    GSM_tau.BECanalysis.fitExponential.fit_data.data_yval(3,:),...
    GSM_tau.BECanalysis.fitExponential.fit_data.data_yval_errorNeg(3,:),...
    GSM_tau.BECanalysis.fitExponential.fit_data.data_yval_errorPos(3,:),...
    'k.','MarkerSize',20,'CapSize',0,'LineWidth',2);
plot(GSM_tau.BECanalysis.fitExponential.fit_xval,...
    GSM_tau.BECanalysis.fitExponential.fit_yval,...
    'LineWidth',2,'color',[0 0 0 0.2]);


ylim([0 1.15]);
xlim([-10 2.5e3]);
set(gca,'fontsize',16,'fontname','arial');