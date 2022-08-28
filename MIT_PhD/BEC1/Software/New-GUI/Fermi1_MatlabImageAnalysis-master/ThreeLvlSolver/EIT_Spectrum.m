timestep = 1;
times = 0:timestep:50;

Omega_PE_0  = 2*pi*1; %MHz
Omega_ME_0  = 2*pi*3*5; %MHz

Omega_PE = @(t) Omega_PE_0;
Omega_ME = @(t) Omega_ME_0;

detunings = -10:0.01:10;
polaronEndState = [];

for idx = 1:length(detunings)
    stateTimeVec = ThreeLvlSolverEngine(Omega_PE,Omega_ME,times,'delta_2Photon',2*pi*detunings(idx),'delta_1Photon',2*pi*0);
    polaronEndState(idx) = abs(stateTimeVec(end,2)).^2;
end
%
figure(881),clf;
%subplot(1,3,1)
hold on
plot(detunings,polaronEndState,'LineWidth',2)
hold off

box on
%legend('Polaron')
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);


