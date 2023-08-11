%% calculate polaron energy and contact
clear;
% append the repulsive polaron on top of our paper polaron 1/kna from -1.5
% to 1.5

% fix kn and vary scattering length to generate 1/kna which is closer to
% the real experiment parameter

xlimit = [-0.3,0.3];
r_vdw = 53*aBohr;
kn = 1/r_vdw;
En = hbar^2*kn^2/(2*mReduced);
inverKna = linspace(-1.5,2);
a = 1/kn./inverKna;



[Ep,Ep_att,Ep_rep,inverseKna_att,inverseKna_rep,c_att,c_rep] = EpOverEn_analytic_kna(kn,a);


% Feshbach molecule energy normalized by En
fun_E_fbmol_over_En = @(inversekna) -2*inversekna.^2;

r_vdwovera_fbmol = linspace(0,2);
a_fbmol = r_vdw./r_vdwovera_fbmol;
fun_E_fbmol = @(a) -hbar^2./(2*mReduced*a.^2);



figure(2);clf;box on; hold on;
plot(r_vdwovera_fbmol,fun_E_fbmol(a_fbmol)/En,...
    'color',[0 0 0],'linewidth',2);

xlim([-2 2])
% Feshbach molecule contact
fun_c_fbmol = @(inversekna) 8*pi*inversekna;
inverseKna_fbmol = linspace(0,2);

c_fbmol = fun_c_fbmol(inverseKna_fbmol);
E_fbmol_over_En = fun_E_fbmol_over_En(inverseKna_fbmol);


% Efimov energy
% a_0 = -200*aBohr; 
a_0 = -r_vdw;
a_plus = 250*aBohr;
kappa_inf = -1/a_0;

E_Efimov_neg = @(a) -hbar^2*(kappa_inf^2-(1./a).^2)/2/mReduced;

r_vdwovera_Efimov_neg = linspace(-1,0);
a_Efimov_neg = r_vdw./r_vdwovera_Efimov_neg;

E_Efimov_pos = @(a) E_Efimov_neg(a)+ ...
                    fun_E_fbmol(a);

r_vdwovera_Efimov_pos = linspace(0,2);
a_Efimov_pos = r_vdw./r_vdwovera_Efimov_pos;

scaling_factor = exp(pi/0.285);

figure(2);hold on;
plot(r_vdwovera_Efimov_neg,E_Efimov_neg(a_Efimov_neg)/En,...
    'color',[0.4940 0.1840 0.5560],'linewidth',2);
plot(r_vdwovera_Efimov_pos,E_Efimov_pos(a_Efimov_pos)/En,...
    'color',[0.4940 0.1840 0.5560],'linewidth',2);
plot(r_vdw/a_0,0,...
    '.','color',[0.4940 0.1840 0.5560],'markersize',20);
plot(r_vdw/a_0/scaling_factor,0,...
    '.','color',[0.4940 0.1840 0.5560],'markersize',20);
plot(0,E_Efimov_neg(1e9),...
    '.','color',[0.4940 0.1840 0.5560],'markersize',20);
plot(0,E_Efimov_neg(1e9)/scaling_factor^2,...
    '.','color',[0.4940 0.1840 0.5560],'markersize',20);

xlim([-1.2 1.2]);
xline(r_vdw/a_plus,'linewidth',2);

xlabel('r_{vdW}/a');
ylabel('E/E_{vdW}');
set(gca,'fontsize',16,'fontname','arial');




















function E_Efimov = fun_E_Efimov(a,n)
r_vdw = 53*aBohr;
a_0 = -r_vdw;
s0 = 0.285;
scaling_factor = exp(pi/s0);
kappa_inf = -1/a_0;
kappa_n = kappa_inf/scaling_factor^n;

a_neg = a(a<=0);
a_pos = a(a>0);

E_neg = -hbar^2*(kappa_n^2-(1./a_neg).^2)/2/mReduced;
E_pos = -hbar^2*(kappa_n^2-(1./a_pos).^2)/2/mReduced+ ...
         hbar^2./(2*mReduced*a_pos.^2);
     
E_Efimov = [E_neg E_pos];

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