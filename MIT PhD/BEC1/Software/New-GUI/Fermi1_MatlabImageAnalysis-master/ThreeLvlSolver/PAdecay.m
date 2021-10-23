timestep = 0.01;
times = 0:timestep:50;

Omega_PE_0  = 2*pi*0.2; %MHz
Omega_ME_0  = 2*pi*0; %MHz

Omega_PE = @(t) Omega_PE_0;
Omega_ME = @(t) Omega_ME_0;

polaronEndState = [];


stateTimeVec = ThreeLvlSolverEngine(Omega_PE,Omega_ME,times);
polaronEndState = abs(stateTimeVec(:,2)).^2;

%
figure(882),clf;
%subplot(1,3,1)
hold on
plot(times,polaronEndState,'LineWidth',2)
hold off

box on
legend('Polaron')
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);


