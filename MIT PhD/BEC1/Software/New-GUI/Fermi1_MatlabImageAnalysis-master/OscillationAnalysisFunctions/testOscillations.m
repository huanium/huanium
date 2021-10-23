%% phenomenological fit from PRL -Critical Velocity and Dissipation of an Ultracold Bose-Fermi Counterflow
fitfun=@(p,x) (p(1)+p(2)*exp(-x./p(3))).*(p(4)*cos(p(5)*x+p(6))+p(7)*cos(p(8)*x+p(9)));
%envelope 1, envelope 2, tau, amp1, f1, phi1, amp2, f2, phi2
t=0:.01:100;
env1=1;
env2=1;
tau=10;
f1=.78;
f2=1.25;
p=[env1 env2 tau 10 f1 0 1 f2 0];
plot(t,fitfun(p,t))

%% phenomenological fit- growing sine
parameterNames = {'Amp1','DampTau1','FreqKHz1','Phase1','Amp2','DampTau2',...
        'FreqKHz2','Phase2','growTau2'};
fitfun=@(p,x) p(1).*exp(-x./p(2)).*cos(p(3)*x+p(4))+p(5).*exp(-x./p(6)).*cos(p(7)*x+p(8)).*(1-exp(-x/p(9)))
a1=0;
a2=10;
dampTau1=10;
dampTau2=300;
growTau2=10;
phi1=1.5;
phi2=2;
p=[a1 dampTau1 1.25 phi1 a2 dampTau2 0.78 phi2 growTau2];
plot(t,fitfun(p,t))