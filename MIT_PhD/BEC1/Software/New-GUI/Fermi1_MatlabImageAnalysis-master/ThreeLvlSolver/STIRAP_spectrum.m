timestep = 0.01;
times = 0:timestep:40;

detunings = -0.2:0.005:0.2;
polaronEndState = [];

Omega_PE_0  = 2*pi*1.6; %MHz
Omega_ME_0  = 2*pi*2.7; %MHz

period      = times(end);

Omega_PE = @(t) Omega_PE_0*(1/2*(1+cos(2*pi*1/period*t-pi))).^(1/2);
Omega_ME = @(t) Omega_ME_0*(1/2*(1+cos(2*pi*1/period*t))).^(1/2);



for idx = 1:length(detunings)

    stateTimeVec = ThreeLvlSolverEngine(Omega_PE,Omega_ME,times,...
                                        'delta_1Photon',-2*pi*0,'lightShift1PhotonPerMhzPE',0,...
                                        'delta_2Photon',2*pi*detunings(idx),'lightShift2PhotonPerMhzPE',-0.0,...
                                        'gammaM',2*pi*0.013,...
                                        'plotDetuning',false);
    polaronEndState(idx) = abs(stateTimeVec(end,2)).^2;
end

figure(881),clf;
%subplot(1,3,1)
hold on
plot(detunings,polaronEndState,'LineWidth',2)
hold off
xlabel('2 photon detuning (MHz)')
ylabel('Polaron end fraction')

box on
%legend('Polaron')
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);

%%
64.17-64.225