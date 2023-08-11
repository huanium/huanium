%% STIRAP time evolution with dressed atom picture: 3x3 matrix
clear;
% change gammaE to see splitting change
gammaE = 2*pi*10e6;
stepSize = 4e2;

t_SingleTrip = 30;
uplegShape = 1;0.1;

w_CE_beta = 0;
w_FE = 30;
w_EG = 30;

w_FE2_beta = 0;
w_GE2_beta = 3;

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
    propagator_STIRAP_TimeEvolution_DressedAtom_3by3(w_FE_arb,w_EG,t_STIRAP,...
                'deltaFE',deltaFE,'deltaGE',deltaGE,'deltaE2',deltaE2,...
                'gammaE',gammaE,'gammaC',gammaC,...
                'w_CE_beta',w_CE_beta,'w_FE2_beta',w_FE2_beta,'w_GE2_beta',w_GE2_beta,...
                'plotOn',true);

            
%% 3x3 matrix critical damping
clear;
gammaE = 2*pi*1e6*10;
w_amp = 2*pi*1e6*linspace(0,10);
plotOn = false;

t_SingleTrip = 30;

w_CE_beta = 0;
w_FE2_beta = 0;
w_GE2_beta = 0;

deltaFE = 2*pi*0e6;
deltaGE = deltaFE;
deltaE2 = 2*pi*-118.9e6;

t_SingleTrip = 1e-6*t_SingleTrip;
t_STIRAP = linspace(0,4*t_SingleTrip,1e2);


gammaC = 2*pi*0;

population_total = nan(size(w_amp));
splitting_real = nan(size(w_amp));
splitting_imag1 = nan(size(w_amp));
splitting_imag2 = nan(size(w_amp));
splitting_abs = nan(size(w_amp));
time_index_quarter = round(length(t_STIRAP)/4);
time_index_half = round(length(t_STIRAP)/4*1.5);

for idx = 1:length(w_amp)
    
w_FE_arb = w_amp(idx)*((sin(t_STIRAP*pi/t_SingleTrip+pi/2)+1)/2);
w_FE_arb(1:length(t_STIRAP)/4)=0;
w_FE_arb(length(t_STIRAP)*3/4:end)=0;
w_EG = w_amp(idx)*(sin(t_STIRAP*pi/t_SingleTrip+pi/2*3)+1)/2;


[population_P,population_E,population_G,eigenE_sorted,eigenstates] =...
    propagator_STIRAP_TimeEvolution_DressedAtom_3by3(w_FE_arb,w_EG,t_STIRAP,...
                'deltaFE',deltaFE,'deltaGE',deltaGE,'deltaE2',deltaE2,...
                'gammaE',gammaE,'gammaC',gammaC,...
                'w_CE_beta',w_CE_beta,'w_FE2_beta',w_FE2_beta,'w_GE2_beta',w_GE2_beta,...
                'plotOn',plotOn);
population_total(idx) = population_P(end);
splitting_real_temp = real([eigenstates.eigenE1(time_index_quarter),eigenstates.eigenE2(time_index_quarter),eigenstates.eigenE3(time_index_quarter)]);
splitting_real(idx) = max((splitting_real_temp))-min((splitting_real_temp));

splitting_abs_temp = sort(abs(([eigenstates.eigenE1(time_index_half),...
                                     eigenstates.eigenE2(time_index_half),...
                                     eigenstates.eigenE3(time_index_half)])));
splitting_abs(idx) = splitting_abs_temp(2)-splitting_abs_temp(1);

splitting_imag_temp = sort(abs(imag(([eigenstates.eigenE1(time_index_quarter),...
                                     eigenstates.eigenE2(time_index_quarter),...
                                     eigenstates.eigenE3(time_index_quarter)]))));
splitting_imag1(idx) = splitting_imag_temp(2)-splitting_imag_temp(1);
splitting_imag2(idx) = splitting_imag_temp(3)-splitting_imag_temp(1);
end                              

%
figure(6);clf;hold on;box on;
plot(w_amp/gammaE,splitting_real./w_amp,'LineWidth',2);
plot(w_amp/gammaE,splitting_imag1./w_amp,'LineWidth',2);
% plot(w_amp/gammaE,splitting_imag2./w_amp,'LineWidth',2);
xlabel('\Omega/\gamma_e');
ylabel('\Delta/\Omega');

xlim([0 1]);
ylim([0 1]);

xline(0.5,'linewidth',2);

set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 12);

% figure(7);clf;hold on;box on;
% adiabatic_factor = 100;
% plot(gammaE/w_EG_amp,splitting_abs*t_SingleTrip/adiabatic_factor,'LineWidth',2);
% plot(gammaE/w_EG_amp,1-population_total,'k','LineWidth',2);
% 
% ylim([0,1]);
% title('Dressed state gap magnitude at t_{crossing}');
% xlabel('\gamma_e/\Omega');
% 
% legend(['|E_{gap}|*t_{STIRAP}/' num2str(adiabatic_factor)],'population loss',...
%     'Location','east');
% 
% set(gca, 'FontName', 'Arial')
% set(gca,'FontSize', 12);


%%
clear;
% change gammaE to see splitting change
gammaE = 2*pi*10e6;
stepSize = 1e3;

t_SingleTrip = 30;
uplegShape = 1;0.1;

w_CE_beta = 0;
w_FE = 3;
w_EG = 3;

w_FE2_beta = 0;
w_GE2_beta = 3;

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
    propagator_STIRAP_TimeEvolution_DressedAtom_3by3(w_FE_arb,w_EG,t_STIRAP,...
                'deltaFE',deltaFE,'deltaGE',deltaGE,'deltaE2',deltaE2,...
                'gammaE',gammaE,'gammaC',gammaC,...
                'w_CE_beta',w_CE_beta,'w_FE2_beta',w_FE2_beta,'w_GE2_beta',w_GE2_beta,...
                'plotOn',true);

%% plot zoomed out version             
figure(6);
subplot(4,1,2:4);
ylim([-0.05 0.6]);

%% plot zoomed in version
figure(6);
subplot(4,1,2:4);
ylim([-0.01 0.1]);



%% 3x3 Adiabaticity: Critically damped Non-Hermitian Hamiltonian

clear;
gammaE = 2*pi*10e6;
stepSize = 100;

adiabatic_coef = linspace(0,40,stepSize);
t_SingleTrip = 30e-6;
% w_coupling = 2*pi*1e6*logspace(-0.8,2,stepSize);
w_coupling = sqrt(pi^2*gammaE*adiabatic_coef/t_SingleTrip);%adiabatic_coef/t_SingleTrip*1e6;

uplegShape = 1;

w_CE_beta = 0;
w_FE = 3;
w_EG = 3;

w_FE2_beta = 0;
w_GE2_beta = 0;

deltaFE = 2*pi*0e6;
deltaGE = deltaFE;
deltaE2 = 2*pi*-118.9e6;


w_FE_amp = 2*pi*1e6*w_FE;
w_EG_amp = 2*pi*1e6*w_EG;
t_STIRAP = linspace(0,4*t_SingleTrip,5e3);


w_FE_arb = w_FE_amp*((sin(t_STIRAP*pi/t_SingleTrip+pi/2)+1)/2).^uplegShape;
w_FE_arb(1:length(t_STIRAP)/4)=0;
w_FE_arb(length(t_STIRAP)*3/4:end)=0;

w_EG = w_EG_amp*(sin(t_STIRAP*pi/t_SingleTrip+pi/2*3)+1)/2;

gammaC = 2*pi*0;

population_to_E = nan(size(w_coupling));
population_to_G = nan(size(w_coupling));
splitting_real = nan(size(w_coupling));
splitting_abs = nan(size(w_coupling));
time_index_quarter = round(length(t_STIRAP)/4);
time_index_half = round(length(t_STIRAP)/4*1.5);
midpoint_index = round(length(t_STIRAP)/2);

for idx = 1:length(w_coupling)
    w_FE_arb = w_coupling(idx)*((sin(t_STIRAP*pi/t_SingleTrip+pi/2)+1)/2).^uplegShape;
    w_FE_arb(1:length(t_STIRAP)/4)=0;
    w_FE_arb(length(t_STIRAP)*3/4:end)=0;
    
    w_EG = w_coupling(idx)*(sin(t_STIRAP*pi/t_SingleTrip+pi/2*3)+1)/2;
    
    [population_P,population_E,population_G,eigenE_sorted,eigenstates] =...
        propagator_STIRAP_TimeEvolution_DressedAtom_3by3(w_FE_arb,w_EG,t_STIRAP,...
        'deltaFE',deltaFE,'deltaGE',deltaGE,'deltaE2',deltaE2,...
        'gammaE',gammaE,'gammaC',gammaC,...
        'w_CE_beta',w_CE_beta,'w_FE2_beta',w_FE2_beta,'w_GE2_beta',w_GE2_beta,...
        'plotOn',false);
    % 
    population_to_E(idx) = 1-population_P(end)-population_G(end);
    population_to_G(idx) = population_G(midpoint_index);
    splitting_real_temp = real([eigenstates.eigenE1(time_index_quarter),eigenstates.eigenE2(time_index_quarter),eigenstates.eigenE3(time_index_quarter)]);
    splitting_real(idx) = max((splitting_real_temp))-min((splitting_real_temp));
    
    splitting_abs_temp = sort(abs(([eigenstates.eigenE1(time_index_half),...
        eigenstates.eigenE2(time_index_half),...
        eigenstates.eigenE3(time_index_half)])));
    
    splitting_abs(idx) = splitting_abs_temp(2)-splitting_abs_temp(1);
end                              

%%
f9=figure(9);clf;box on;hold on;
f9.Position = [f9.Position(1) f9.Position(2) 560 200];
plot(adiabatic_coef*pi^2/4,population_to_G,...
    '-','color',[0 0 0 0.4],'LineWidth',4);
plot(adiabatic_coef*pi^2/4,exp(-1./adiabatic_coef/0.5/0.8),...
    'k--','LineWidth',2);

legend('numerical','e^{-\pi^2\gamma_e/\Omega^2\tau_*}');

% xlim([10^3.08,1e6]);
ylim([-0.05,1.1]);

xlabel('\Omega^2\tau/(\pi^2\gamma_e)');
xlabel('|\Delta_B|\tau_{STIRAP}');
ylabel('\eta_{STIRAP}');

set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 12);







%% 4x4 maxtrix STIRAP dressed state picture with continuum 
clear;
% change gammaE to see splitting change
gammaE = 2*pi*10e6;
stepSize = 4e2;

E_polaron = -2*pi*16e3;

t_SingleTrip = 30;
uplegShape = 1;0.1;

w_CE_beta = 1;
w_FE = 1;
w_EG = 1;

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




%% scan single photon detuning 4x4 maxtrix STIRAP dressed state picture with continuum 
clear;
% change gammaE to see splitting change
gammaE = 2*pi*10e6;
stepSize = 1e2;

t_SingleTrip = 30;
uplegShape = 1;0.1;

w_CE_beta =1;

w_FE = 1;
w_EG = 1;

E_polaron = -2*pi*16e3;

w_FE2_beta = 0;
w_GE2_beta = 0;


deltaFE = 2*pi*1e6*[linspace(-190,0,stepSize) 0 linspace(0,190,stepSize)];
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

DarkState1 = nan(size(deltaFE));
DarkState2 = nan(size(deltaFE));
BrightState1 = nan(size(deltaFE));

for idx = 1:length(deltaFE)
    [population_P,population_E,population_G,eigenE_sorted,eigenstates] =...
        propagator_STIRAP_TimeEvolution_DressedAtom_4by4(w_FE_arb,w_EG,t_STIRAP,...
                    'deltaFE',deltaFE(idx),'deltaGE',deltaGE(idx),'deltaE2',deltaE2,...
                    'gammaE',gammaE,'gammaC',gammaC,...
                    'w_CE_beta',w_CE_beta,'w_FE2_beta',w_FE2_beta,'w_GE2_beta',w_GE2_beta,...
                    'E_polaron',E_polaron,...
                    'plotOn',false);
    
    eigenE_mid = [eigenstates.eigenE1(round(length(t_STIRAP)*3/8)) ...
                  eigenstates.eigenE2(round(length(t_STIRAP)*3/8)) ...
                  eigenstates.eigenE3(round(length(t_STIRAP)*3/8)) ...
                  eigenstates.eigenE4(round(length(t_STIRAP)*3/8))];
              
    [~,min_index] = sort(abs(imag(eigenE_mid)));
    
    DarkState1(idx) = eigenE_mid(min_index(1));
    DarkState2(idx) = eigenE_mid(min_index(2));
    BrightState1(idx) = eigenE_mid(min_index(3));
end

color_P = [0 0.4470 0.7410];
color_G = [0.4660 0.6740 0.1880];
color_E = [1 0 0];
color_C = [0.4940 0.1840 0.5560];
color_PC = [0.9290 0.6940 0.1250];
color_total = [0 0 0];

plotText = ['\Omega_C/\Omega_P=' num2str(round(w_CE_beta*10)/10) ...
            ' \Gamma_E/2\pi=' num2str(gammaE/2/pi*1e-6,2) 'MHz'...
            ' \Omega_{PE}/2\pi=' num2str(w_FE_amp/2/pi*1e-6) 'MHz' ...
            ' \Omega_{EG}/2\pi=' num2str(w_EG_amp/2/pi*1e-6) 'MHz'];


figure(13);clf;hold on; box on;
% plot(deltaFE/2/pi*1e-6,abs(DarkState1)*t_SingleTrip,'LineWidth',2,'Color',color_P);
plot(deltaFE/gammaE,abs(DarkState2)/(2*1e6*w_FE),'LineWidth',2,'Color',color_C);
plot(deltaFE/gammaE,abs(BrightState1)/(2*1e6*w_FE),'LineWidth',2,'Color',color_E);
yline(-E_polaron/(2*1e6*w_FE),'linewidth',2);
ylim([-0.005,0.12]);
legend('\Delta_D','\Delta_B','E_i','Location','best');
% text(-199,19,plotText);
ylabel('|E|/\Omega')
xlabel('\delta_{1photon}/\gamma_e')
% title(['Dressed states absolute eigenvalues t=t_{STIRAP}/2 \Omega_C/\Omega_P=' num2str(round(w_CE_beta*10)/10) ]);

set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);

