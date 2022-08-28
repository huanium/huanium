timestep = 0.01;
times = 0:timestep:40;

Omega_PE_max = 0.85/3;

Omega_PE_0  = 2*pi*Omega_PE_max; %MHz
Omega_ME_0  = 2*pi*2; %MHz

period      = times(end);

Omega_PE = @(t) Omega_PE_0*(1/2*(1+cos(2*pi*1/period*t-pi))).^(1/2);
Omega_ME = @(t) Omega_ME_0*(1/2*(1+cos(2*pi*1/period*t))).^(1/2);

stateTimeVec = ThreeLvlSolverEngine(Omega_PE,Omega_ME,times,...
                                    'delta_1Photon',2*pi*0,'lightShift1PhotonPerMhzPE',0,...
                                    'delta_2Photon',-2*pi*0.0,'lightShift2PhotonPerMhzPE',-0.0/Omega_PE_max,...
                                    'gammaM',2*pi*0.0133,...
                                    'gammaE',2*pi*12,...
                                    'plotDetuning',true);
%
figure(881),clf;
subplot(1,3,1)
hold on
plot(times,abs(stateTimeVec(:,1)).^2,'LineWidth',2)
plot(times,abs(stateTimeVec(:,2)).^2,'LineWidth',2)
plot(times,abs(stateTimeVec(:,3)).^2,'LineWidth',2)
hold off

box on
legend('Excited State','Polaron','Groundstate Molecule')
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);

subplot(1,3,2)
hold on
plot(times,Omega_PE(times),'LineWidth',2)
plot(times,Omega_ME(times),'LineWidth',2)
hold off
box on
legend('\Omega_{PE}','\Omega_{ME}')
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);


subplot(1,3,3)
hold on
plot(times,1-(abs(stateTimeVec(:,1)).^2+abs(stateTimeVec(:,2)).^2+abs(stateTimeVec(:,3)).^2),'LineWidth',2)
%plot(times,cumsum(abs(stateTimeVec(:,3)).^2.*timestep/2.2),'LineWidth',2)
hold off
box on
legend('losses through excited state')
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 14);

