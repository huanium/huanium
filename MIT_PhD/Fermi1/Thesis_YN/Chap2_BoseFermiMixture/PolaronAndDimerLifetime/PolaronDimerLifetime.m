%% load data
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

% polaron lifetime data
Polaron_1_dir = '..\..\..\202209\220902\run1_PolaronLifetime_78p56G';
Polaron_1 = BECanalysis_loader(Polaron_1_dir);

Polaron_2_dir = '..\..\..\202208\220812\run6_IntermediateBfield_78p75G';
Polaron_2 = BECanalysis_v3_loader(Polaron_2_dir);

Polaron_3_dir = '..\..\..\202208\220812\run4_IntermediateBfield_78p9G';
Polaron_3 = BECanalysis_v3_loader(Polaron_3_dir);

% Polaron_4_dir = '..\..\..\202208\220812\run5_IntermediateBfield_79p27G';
% Polaron_4 = BECanalysis_v3_loader(Polaron_4_dir);

% Feshbach molecule lifetime data
FBmol_1_dir = '..\..\..\202205\220517\run9_85p7GFBmoleculeLifetime';
FBmol_1 = thermalAnalysis_loader(FBmol_1_dir);

% FBmol_2_dir = '..\..\..\202205\220518\run5_FBmoleculeLifeTime_84p17G';
% FBmol_2 = thermalAnalysis_loader(FBmol_2_dir);

% group polaron data
PolaronLoss = struct;
PolaronLoss.data = struct;
PolaronLoss.data.inversekna = [Polaron_1.fit_VR.inversekna(3)' ...
    Polaron_2.fit_VR.inversekna ...
    Polaron_3.fit_VR.inversekna ];

PolaronLoss.data.a_scatter = [Polaron_1.fit_VR.a_scatter(3)' ...
    Polaron_2.fit_VR.a_scatter ...
    Polaron_3.fit_VR.a_scatter];

PolaronLoss.data.beta = [Polaron_1.fit_VR.beta(3)' ...
    Polaron_2.fit_VR.beta ...
    Polaron_3.fit_VR.beta ];



PolaronLoss.data.kn = [Polaron_1.fit_VR.kn(3)' ...
    Polaron_2.fit_VR.kn ...
    Polaron_3.fit_VR.kn ];

PolaronLoss.data.nB = PolaronLoss.data.kn.^3/(6*pi^2);

PolaronLoss.data.L3 = PolaronLoss.data.beta./(PolaronLoss.data.nB*1e-6);

% fit the polaron loss rate to nB^2*a^4
L3 = struct;
L3.a_scatter_discrete = [-8e4 PolaronLoss.data.a_scatter -5e2];
L3.kn_discrete = [1.44e7 PolaronLoss.data.kn 1e7];

% L3.kn_interp = logspace(log10(min(L3.kn_discrete)),log10(max(L3.kn_discrete)));
L3.kn_interp = linspace((min(L3.kn_discrete)),(max(L3.kn_discrete)),1e5);
L3.a_scatter_interp = interp1(L3.kn_discrete,L3.a_scatter_discrete,L3.kn_interp,'linear');

L3.nB_interp = L3.kn_interp.^3/(6*pi^2);
L3.nB_discrete = L3.kn_discrete.^3/(6*pi^2);

L3.inversekna_interp = 1./L3.kn_interp./L3.a_scatter_interp/aBohr;
L3.inversekna_discrete = 1./L3.kn_discrete./L3.a_scatter_discrete/aBohr;


% figure(12);clf;
% plot(L3.nB_interp,L3.a_scatter_interp);

fitfun_L3beta_unitary_limited = @(p,nB,a) p(1)*nB.^2.*min([nB.^(-1/3);abs(a)]).^(p(2))*(hbar/mReduced)^4.*nB + p(3);
fitfun_L3beta = @(p,nB,a) p(1)*nB.^2.*abs(a).^(p(2))*(hbar/mReduced)^4.*nB + p(3);
L3.fitfun_L3beta = fitfun_L3beta;

% fit_guess = [7e-10 4 5e-13]; % a^4 parameter guess
fit_guess = [14e-24 2 1e-13]; 


% fit_ub = [1e-3 2.5];
% fit_lb = [1e-6 1.5];
% 
% weighted_deviations = @(p) (fitfun_beta(p,PolaronLoss.data.nB,PolaronLoss.data.a_scatter*aBohr)-PolaronLoss.data.beta);
% optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','final-detailed','MaxFunctionEvaluations',1e5);
% [fit_result,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,fit_guess,fit_lb,fit_ub,optio);
%     try
%         ciFitGauss = nlparci(fit_result,resid,'jacobian',J);
%     catch
%         ciFitGauss = [NaN;NaN];
%     end

L3.beta_interp = fitfun_L3beta(fit_guess,...
                               L3.nB_interp,...
                               L3.a_scatter_interp*aBohr);
L3.beta_interp_unitary_limited = fitfun_L3beta_unitary_limited(fit_guess,...
                               L3.nB_interp,...
                               L3.a_scatter_interp*aBohr);                         
PolaronLoss.L3 = L3;


% calculate polaron loss theory curves
PolaronLoss.data.singleChevy = EpOverEn_analytic_kna_struct(PolaronLoss.data.kn,...
    PolaronLoss.data.a_scatter*aBohr);

% group Feshbach molecule data
FBmolLoss = struct;
FBmolLoss.data = struct;
FBmolLoss.data.a_scatter = [FBmol_1.fit_VR.a_scatter];
FBmolLoss.data.inversekna = [FBmol_1.fit_VR.inversekna];
FBmolLoss.data.beta = [FBmol_1.fit_VR.beta];
FBmolLoss.data.kn = [FBmol_1.fit_VR.kn];          


% calculate Feshbach molecule loss rate
beta_vr = @(p,x) p(1)./(x+p(2)); %define beta function
beta_amp = 0.78e-16/aBohr;%5e-18/aBohr;
beta_offset = 50;%0;

FBmolLoss.theory.beta_fun = beta_vr;
FBmolLoss.theory.beta_amp = beta_amp;
FBmolLoss.theory.beta_offset = beta_offset;

FBmolLoss.theory.inversekna = linspace(1e-4,3);
FBmolLoss.theory.kn = mean(FBmolLoss.data.kn);
FBmolLoss.theory.a_scatter = 1./FBmolLoss.theory.inversekna/FBmolLoss.theory.kn/aBohr; % unit a0

% dimer loss rate
FBmolLoss.theory.beta = beta_vr([beta_amp beta_offset],FBmolLoss.theory.a_scatter); % unit beta: cm^3/s


    
%  plot loss rate vs 1/kna data
xlimit = [-3 3];
ylimit = [1e-13 1e-8];

width_line = 4;

figure(1);clf;box on;
semilogy(PolaronLoss.data.inversekna,...
    PolaronLoss.data.beta,...
    '.','MarkerSize',30,'color',[0 0.4470 0.7410]);
hold on;
semilogy(L3.inversekna_interp,...
    L3.beta_interp,...
    '-','linewidth',width_line,'color',[0 0.4470 0.7410 0.5]);
hold on;
semilogy(FBmolLoss.data.inversekna,...
    FBmolLoss.data.beta,...
    'k.','MarkerSize',30);
semilogy(FBmolLoss.theory.inversekna,...
    FBmolLoss.theory.beta,...
    '-','linewidth',width_line,'color',[0 0 0 0.5]);

yticks(logspace(-13,-8,6));

xlabel('(k_na)^{-1}');
ylabel('\beta_{vr} (cm^3/s)');
ylim([-1e-10 5e-10]);
ylim(ylimit);
xlim(xlimit);
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);


figure(2);clf;box on;
loglog(PolaronLoss.data.a_scatter,...
    PolaronLoss.data.L3,...
    '.','MarkerSize',30,'color',[0 0.4470 0.7410]);

xlabel('a (a_0)');
ylabel('L_3 (cm^6/s)');
% ylim([-1e-10 5e-10]);
ylim([1e-27 1e-22]);
xlim([-1e4 -50]);
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);


% interpolate kn to connect polaron with molecule loss curve
PolaronLoss.theory = struct;
PolaronLoss.theory.kn_discrete = [FBmolLoss.data.kn PolaronLoss.data.kn];
PolaronLoss.theory.a_scatter_discrete = [FBmolLoss.data.a_scatter PolaronLoss.data.a_scatter];

PolaronLoss.theory.inversekna_discrete = 1./PolaronLoss.theory.kn_discrete./PolaronLoss.theory.a_scatter_discrete/aBohr;

PolaronLoss.theory.inversekna_interp = linspace(-3,3,100);
PolaronLoss.theory.kn_interp = interp1(PolaronLoss.theory.inversekna_discrete,...
                                       PolaronLoss.theory.kn_discrete,...
                                       PolaronLoss.theory.inversekna_interp);
PolaronLoss.theory.a_scatter_interp = interp1(PolaronLoss.theory.inversekna_discrete,...
                                       PolaronLoss.theory.a_scatter_discrete,...
                                       PolaronLoss.theory.inversekna_interp);                                   



PolaronLoss.theory.singleChevy = EpOverEn_analytic_kna_struct(PolaronLoss.theory.kn_interp,...
                                                 PolaronLoss.theory.a_scatter_interp*aBohr);
PolaronLoss.theory.singleChevy.a_effective = 1./PolaronLoss.theory.singleChevy.kappa_att;

% polaron loss rate: with 1-z quasiparticle residue factored in
beta_po = beta_vr([beta_amp 0],...
    PolaronLoss.theory.singleChevy.a_effective/aBohr)...
    .*(1-PolaronLoss.theory.singleChevy.z_att.^1); 

% save data 
save('PolaronLoss','PolaronLoss');
save('FBmolLoss','FBmolLoss');




%% Auxilary functions

inverkna = linspace(-5,5);
kn = Polaron_1.fit_VR.kn(3);
a = 1./(inverkna*kn);
EpOverEn_analytic_kna_struct(kn,a);


function output = EpOverEn_analytic_kna_struct(kn,a)
% kn, a are in SI units

output = struct;

% calculate polaron energy 
n = kn.^3/(6*pi^2);
inverseKna = 1./a./kn;
En = hbar^2*kn.^2/(4*mReduced);

kappa1 = (0.26457*(339.29*a.^3.*n + sqrt((339.29*a.^3.*n+2).^2-4)+2).^(1/3))./a + 0.41997./(a.*(339.29*a.^3.*n + sqrt((339.29*a.^3.*n+2).^2-4)+2).^(1/3)) + 0.33333./a;
kappa2 = -((0.13228-0.22912*1i)*(339.29*a.^3.*n+sqrt((339.29*a.^3.*n+2).^2-4)+2).^(1/3))./a - (0.20999 + 0.36371*1i)./(a.*(339.29*a.^3.*n+sqrt((339.29*a.^3.*n+2).^2-4)+2).^(1/3)) + 0.33333./a;
kappa3 = -((0.13228 + 0.22912*1i)*(339.29*a.^3.*n+sqrt((339.29*a.^3.*n+2).^2-4)+2).^(1/3))./a - (0.20999-0.36371*1i)./(a.*(339.29*a.^3.*n + sqrt((339.29*a.^3.*n+2).^2-4)+2).^(1/3)) + 0.33333./a;

% use kappa1 and kappa 2 solution for attractive polaron
kappa1(inverseKna<=0) = 0;
kappa2(inverseKna>0)  = 0;
kappa = kappa1+kappa2;

%plot and check the solution

% figure(20);clf;hold on;box on;
% plot(inverseKna,-((hbar*(kappa1)).^2/(2*mReduced))./En,'.','MarkerSize',10);
% plot(inverseKna,-((hbar*(kappa2)).^2/(2*mReduced))./En,'.','MarkerSize',10);
% plot(inverseKna,-((hbar*(kappa3)).^2/(2*mReduced))./En,'.','MarkerSize',30);
% plot(inverseKna,-((hbar*(kappa)).^2/(2*mReduced))./En,'linewidth',3);


% calculate polaron energy
Ep = -((hbar*(kappa)).^2/(2*mReduced));
% calculate quasi-particle residue
z_QPR = 1./(1+kappa.^3./(8*pi.*n));


% inverseKna = [inverseKna,inverseKna,inverseKna];

% extract attractive polaron branch
Ep_att = real(Ep()./En());
% inverseKna_att = inverseKna(real(Ep)<0);
inverseKna_att = inverseKna;
% kappa_att = real(kappa(real(Ep)<0));
kappa_att = real(kappa);
% z_att = real(z_QPR(real(Ep)<0));
z_att = real(z_QPR);

% extract repulsive polaron branch
% Ep_rep = Ep(real(Ep)>0)/En;
% inverseKna_rep = inverseKna(real(Ep)>0);

%calculate the contact C/kn
c_att = pi^2*Ep_att./((1./Ep_att)-pi/4*inverseKna_att);
% c_rep = pi^2*Ep_rep./((1./Ep_rep)-pi/4*inverseKna_rep);

% sort output parameters by energy 
[Ep_att,att_order] = sort(Ep_att);
inverseKna_att = inverseKna_att(att_order);
c_att = c_att(att_order);
z_att = z_att(att_order);
kappa_att = kappa_att(att_order);

output.Ep_att = Ep_att;
output.kappa_att = kappa_att;
output.inverseKna_att = inverseKna_att;
output.c_att = c_att;
output.z_att = z_att;


end

function [Ep,Ep_att,Ep_rep,inverseKna_att,inverseKna_rep,c_att,c_rep,kappa_att,z_att] = EpOverEn_analytic_kna(kn,a)
% kn, a are in SI units

%% calculate polaron energy 
n = kn.^3/(6*pi^2);
inverseKna = 1./a./kn;
En = hbar^2*kn.^2/(4*mReduced);

kappa1 = (0.26457*(339.29*a.^3*n + sqrt((339.29*a.^3*n+2).^2-4)+2).^(1/3))./a + 0.41997./(a.*(339.29*a.^3*n + sqrt((339.29*a.^3*n+2).^2-4)+2).^(1/3)) + 0.33333./a;
kappa2 = -((0.13228-0.22912*1i)*(339.29*a.^3*n+sqrt((339.29*a.^3*n+2).^2-4)+2).^(1/3))./a - (0.20999 + 0.36371*1i)./(a.*(339.29*a.^3*n+sqrt((339.29*a.^3*n+2).^2-4)+2).^(1/3)) + 0.33333./a;
kappa3 = -((0.13228 + 0.22912*1i)*(339.29*a.^3*n+sqrt((339.29*a.^3*n+2).^2-4)+2).^(1/3))./a - (0.20999-0.36371*1i)./(a.*(339.29*a.^3*n + sqrt((339.29*a.^3*n+2).^2-4)+2).^(1/3)) + 0.33333./a;

kappa = [kappa1,kappa2,kappa3];

% cut off exponentially growing polaron
kappa(imag(kappa.^2)>0) = nan;

% cut off short lived polaron
kappa(abs(real(kappa.^2)) < 0.6*abs(imag(kappa.^2))) = nan;

% cut off attractive polaron with finite lifetime
kappa(real(kappa.^2)>0 & imag(kappa)>0) = nan;

% calculate polaron energy
Ep = -((hbar*(kappa)).^2/(2*mReduced));
% calculate quasi-particle residue
z_QPR = 1./(1+kappa.^3/(8*pi*n));


inverseKna = [inverseKna,inverseKna,inverseKna];

% extract attractive polaron branch
Ep_att = real(Ep(real(Ep)<0)/En);
inverseKna_att = inverseKna(real(Ep)<0);
kappa_att = real(kappa(real(Ep)<0));
z_att = real(z_QPR(real(Ep)<0));

% extract repulsive polaron branch
Ep_rep = Ep(real(Ep)>0)/En;
inverseKna_rep = inverseKna(real(Ep)>0);

%calculate the contact C/kn
c_att = pi^2*Ep_att./((1./Ep_att)-pi/4*inverseKna_att);
c_rep = pi^2*Ep_rep./((1./Ep_rep)-pi/4*inverseKna_rep);

% sort output parameters by energy 
[Ep_att,att_order] = sort(Ep_att);
inverseKna_att = inverseKna_att(att_order);
c_att = c_att(att_order);
z_att = z_att(att_order);
kappa_att = kappa_att(att_order);

end

function out = aB(deltaB,Bres,B,abg)
out = abg*(1+deltaB(1)./(B-Bres(1)));
for i = 2:size(deltaB,1)
    out = out.*(1+deltaB(i)./(B-Bres(i)));
end

end

function out = d_inverse_a_d_B(deltaB,Bres,B,abg)
out = deltaB/abg*1./(B-Bres+deltaB).^2;

end

function output = BECanalysis_loader(dir)

load([dir '\BECanalysis.mat'],'BECanalysis');

output = BECanalysis;

end

function output = BECanalysis_v3_loader(dir)
% load single slice BEC data
load([dir '\BECanalysis_v3.mat'],'BECanalysis');

output = BECanalysis;

end

function [wavefun, potential] = squareWellModel(E_,V_,R_)

phi = atan( (E_/(E_-V_))^0.5 * tan( (E_-V_)^0.5*R_ ) )-...
    (E_)^0.5*R_;

amp = sin(sqrt(E_-V_)*R_)/sin(sqrt(E_)*R_+phi);

x1 = linspace(0,R_);
x2 = linspace(R_,4*R_);

psi1 = sin(sqrt(E_-V_)*x1);
psi2 = sin(sqrt(E_)*x2+phi)*amp;
% psi2(find(psi2<0,1):end)=nan;

wavefun.amp = [psi1 psi2];
wavefun.pos = [x1 x2];

potential = struct;
potential.pos = [0 x1 x2];
potential.amp = [1e5 ones(size(x1))*V_ zeros(size(x2))];

% syms n;
% eqn = n*3.1416-phi==0;
% n_r_mol = solve(eqn,n);
% 
% r_mol = (pi-phi)/sqrt(E_)

end

function output = thermalAnalysis_loader(dir)

load([dir '\thermalAnalysis.mat'],'thermalAnalysis');

output = thermalAnalysis;

end