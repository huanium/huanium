clear;

%% calculate polaron energy and contact
% append the repulsive polaron on top of our paper polaron 1/kna from -1.5
% to 1.5

% fix kn and vary scattering length to generate 1/kna which is closer to
% the real experiment parameter

xlimit = [-1.3,1.3];
kn = 1/(1300*aBohr);
inverKna = linspace(-1.5,2);
a = 1/kn./inverKna;
gbf = 2*pi/mReduced*a;
En = hbar^2*kn.^2/(4*mReduced);

[Ep,Ep_att,Ep_rep,inverseKna_att,inverseKna_rep,c_att,c_rep,kappa] = EpOverEn_analytic_kna(kn,a);

r_att = sqrt(hbar^2./(2*mReduced*real(-Ep_att)*En))/aBohr;

% Feshbach molecule energy normalized by En
fun_E_fbmol_over_En = @(inversekna) -2*inversekna.^2;

% Feshbach molecule contact
fun_c_fbmol = @(inversekna) 8*pi*inversekna;
inverseKna_fbmol = linspace(0,2);
r_fbmol = 1./inverseKna_fbmol/kn/aBohr;

c_fbmol = fun_c_fbmol(inverseKna_fbmol);
E_fbmol_over_En = fun_E_fbmol_over_En(inverseKna_fbmol);

% add repulsive polaron filter
po_rep_filter = inverseKna_rep > 0.3;

figure(1);clf;hold on;box on;
plot(inverseKna_att,Ep_att,'-','linewidth',2);
plot(inverseKna_fbmol,E_fbmol_over_En,'k-','linewidth',2);
plot(inverseKna_rep(po_rep_filter),real(Ep_rep(po_rep_filter)),'r-','linewidth',2);
plot(inverseKna_rep(po_rep_filter),real(Ep_rep(po_rep_filter))+imag(Ep_rep(po_rep_filter)),'r--','linewidth',2);
plot(inverseKna_rep(po_rep_filter),real(Ep_rep(po_rep_filter))-imag(Ep_rep(po_rep_filter)),'r--','linewidth',2);
ylim([-4.1,1.1]);
xlim(xlimit);
xline(0);
yline(0);

xlabel('(k_na)^{-1}','fontsize',15);
ylabel('E/E_n','FontSize',15);
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);



%
f2=figure(2);clf;box on; hold on;
f2.Position = [f2.Position(1) 50 500 600];
subplot(2,1,1);hold on;box on;
plot(inverseKna_att,r_att,'-','linewidth',2);
plot(inverseKna_fbmol,r_fbmol,...
    'k-','linewidth',2);
ylim([0 4e3]);
xlim(xlimit);
ylabel('r (a_0)','FontSize',15);
set(gca, 'FontName', 'Arial','XTickLabel',[])
set(gca,'FontSize', 16);

subplot(2,1,2);hold on;box on;
plot(inverseKna_att,c_att,...
    '-','linewidth',2,'color',[0 0.4470 0.7410]);
plot(inverseKna_fbmol,c_fbmol,'k-','linewidth',2);
plot(inverseKna_rep,real(c_rep),'r-','linewidth',2);
xlim(xlimit);
ylim([0 40]);
xlabel('(k_na)^{-1}','fontsize',15);
ylabel('C/k_n','FontSize',15);
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);






%% simple square well model
V_ = -10;
R_ = 4;
E_mol = 1.2;
[wavefun_mol, potential_mol] = squareWellModel(E_mol,V_,R_);

E_pol = 0.4;
Z_pol = 0.7;
[wavefun_pol, potential_pol] = squareWellModel(E_pol,V_,R_);

amp_factor = 1.5;

f4=figure(4);clf;hold on; box on;
f4.Position = [681   300   400   400];

plot(wavefun_mol.pos,wavefun_mol.amp*amp_factor,'LineWidth',2,'color',[0 0 0]);
plot(wavefun_pol.pos,wavefun_pol.amp*(1-Z_pol)*amp_factor,'LineWidth',2,'color',[0 0.4470 0.7410]);
plot(potential_mol.pos,potential_mol.amp,'-','LineWidth',5,'color',[0 0 0 0.5]);
% plot(wavefun_mol.pos,wavefun_mol.amp,'LineWidth',2,'color',[0 0 0]);
% plot(wavefun_pol.pos,wavefun_pol.amp*(1-Z_pol),'LineWidth',2,'color',[0 0.4470 0.7410]);

legend('molecule','polaron');

ylim([V_*1.1,7]);
xlim([0 10]);

title('square well model');
xlabel('inter-nuclear distance (arb)');
% ylabel('Energy (arb)');

set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 16);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])













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



function [Ep,Ep_att,Ep_rep,inverseKna_att,inverseKna_rep,c_att,c_rep,kappa] = EpOverEn_analytic_kna(kn,a)
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

Ep = -((hbar*(kappa)).^2/(2*mReduced));

inverseKna = [inverseKna,inverseKna,inverseKna];

Ep_att = Ep(real(Ep)<0)/En;
inverseKna_att = inverseKna(real(Ep)<0);

Ep_rep = Ep(real(Ep)>0)/En;
inverseKna_rep = inverseKna(real(Ep)>0);

%% calculate the contact C/kn
c_att = pi^2*Ep_att./((1./Ep_att)-pi/4*inverseKna_att);
c_rep = pi^2*Ep_rep./((1./Ep_rep)-pi/4*inverseKna_rep);

% sort output parameters by energy 
[Ep_att,att_order] = sort(Ep_att);
inverseKna_att = inverseKna_att(att_order);
c_att = c_att(att_order);

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