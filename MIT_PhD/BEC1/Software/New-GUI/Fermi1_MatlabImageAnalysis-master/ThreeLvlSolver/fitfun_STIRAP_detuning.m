function [polaronEndState] = fitfun_STIRAP_detuning(p,detunings)
% timestep = 1;
% times = 0:timestep:roundtripTime;

times = [0,20];

uplegRabi = p(1);
downlegRabi = p(2);

onephotonDetuning = p(3);

period = p(4);

Omega_PE_0  = 2*pi*uplegRabi;%2*pi*0.65; %MHz upleg
Omega_ME_0  = 2*pi*downlegRabi;%2*pi*12.65; %MHz downleg

% period      = times(end);

Omega_PE = @(t) Omega_PE_0*1/2*(1+cos(2*pi*1/period*t-pi));
Omega_ME = @(t) Omega_ME_0*1/2*(1+cos(2*pi*1/period*t));

% stateTimeVec = ThreeLvlSolverEngine(Omega_PE,Omega_ME,times);
% 
% polaronStateAmp = abs(stateTimeVec(:,2)).^2;

polaronEndState = [];
molecularState = [];

for idx = 1:length(detunings)
    stateTimeVec = ThreeLvlSolverEngine(Omega_PE,Omega_ME,times,'delta_1Photon',onephotonDetuning,'delta_2Photon',2*pi*detunings(idx));
    polaronEndState(idx) = abs(stateTimeVec(end,2)).^2;
    molecularState(idx) = abs(stateTimeVec(end,3)).^2;
end

figure(881),clf;
%subplot(1,3,1)
hold on
plot(detunings,molecularState,'LineWidth',2)
hold off

box on
% legend('Polaron')
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);

% figure(881),clf;
% subplot(1,3,1)
% hold on
% plot(times,abs(stateTimeVec(:,1)).^2,'LineWidth',2)
% plot(times,abs(stateTimeVec(:,2)).^2,'LineWidth',2)
% plot(times,abs(stateTimeVec(:,3)).^2,'LineWidth',2)
% hold off
% 
% box on
% legend('Excited State','Polaron','Groundstate Molecule')
% set(gca, 'FontName', 'Arial')
% set(gca,'FontSize', 14);
% 
% subplot(1,3,2)
% hold on
% plot(times,Omega_PE(times),'LineWidth',2)
% yyaxis left;
% plot(times,Omega_ME(times),'LineWidth',2)
% hold off
% box on
% legend('\Omega_{PE}','\Omega_{ME}')
% set(gca, 'FontName', 'Arial')
% set(gca,'FontSize', 14);
% ylim([0,100]);
% 
% 
% subplot(1,3,3)
% hold on
% plot(times,1-(abs(stateTimeVec(:,1)).^2+abs(stateTimeVec(:,2)).^2+abs(stateTimeVec(:,3)).^2),'LineWidth',2)
% plot(times,cumsum(abs(stateTimeVec(:,3)).^2.*timestep/2.2),'LineWidth',2)
% hold off
% box on
% legend('losses through escited state')
% set(gca, 'FontName', 'Arial')
% set(gca,'FontSize', 14);
% 
% figure(882);clf;
% 
% plot(times,Omega_PE(times)/2/pi,'LineWidth',2)
% yyaxis left;
% yline(Omega_ME(times)/2/pi,'LineWidth',2)
% hold off
% box on
% legend('\Omega_{PE}','\Omega_{ME}')
% set(gca, 'FontName', 'Arial')
% set(gca,'FontSize', 14);
% ylabel('Rabi rate MHz');
% xlabel('us');

end
