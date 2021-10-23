function polaronEndState =  fitfun_EIT(p,detunings)

% timestep = 1;
times = [0,50];

uplegRabi = p(1);
downlegRabi = p(2);

downlegDetuning = p(3);

% Omega_PE_0  = 2*pi*0.1; %MHz
% Omega_ME_0  = 2*pi*0.5; %MHz

Omega_PE_0  = 2*pi*uplegRabi; %MHz
Omega_ME_0  = 2*pi*downlegRabi; %MHz

Omega_PE = @(t) Omega_PE_0;
Omega_ME = @(t) Omega_ME_0;

% detunings = -5:0.1:5;
polaronEndState = [];

for idx = 1:length(detunings)
    stateTimeVec = ThreeLvlSolverEngine(Omega_PE,Omega_ME,times,'delta_1Photon',2*pi*detunings(idx),'delta_2Photon',2*pi*downlegDetuning);
    polaronEndState(idx) = abs(stateTimeVec(end,2)).^2;
end

% figure(881),clf;
% %subplot(1,3,1)
% hold on
% plot(detunings,polaronEndState,'LineWidth',2)
% hold off
% 
% box on
% legend('Polaron')
% set(gca, 'FontName', 'Arial')
% set(gca,'FontSize', 14);

end

