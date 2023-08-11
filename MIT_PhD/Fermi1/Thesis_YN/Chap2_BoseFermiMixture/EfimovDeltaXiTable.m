clear
n = 0; % n-th Efimov state 
s0 = 0.285; % Efimov parameter for NaK


r_vdw = 250*aBohr; % van der Waals range for NaK
lambda = exp(pi/s0); %scaling factor
a_0 = -r_vdw*lambda^n; % first Efimov state scattering
k_inf = -1/a_0; % first Efimov k-vector at unitarity
E_vdw = hbar^2/(2*mReduced*r_vdw^2); % van der Waals energy

inv_a_neg = linspace(1/a_0,0);
inv_a_pos = linspace(0,-1/a_0);
inv_a_mol = linspace(0,1)/r_vdw;

E_Efimov_neg = -hbar^2*(k_inf^2-inv_a_neg.^2)/2/mReduced;
E_Efimov_pos = -hbar^2*(k_inf^2-inv_a_pos.^2)/2/mReduced + ...
               -hbar^2*inv_a_pos.^2/(2*mReduced);
E_mol = -hbar^2*inv_a_mol.^2/(2*mReduced);

figure(1);clf;box on;hold on;
plot(r_vdw*inv_a_neg,E_Efimov_neg/E_vdw,...
    'LineWidth',2,'color',[0.4940 0.1840 0.5560]);
plot(r_vdw*inv_a_pos,E_Efimov_pos/E_vdw,...
    'LineWidth',2,'color',[0.4940 0.1840 0.5560]);
plot(r_vdw*inv_a_mol,E_mol/E_vdw,...
    'LineWidth',2,'color',[0 0 0]);

xlim([-1 1]);
ylim([-2,0.2])

xlabel('r_{vdW}/a');
ylabel('E/E_{vdW}');
set(gca,'fontsize',16);




%% 
% Numerically solve the Efimov energy spectrum based on 
% the papper doi: ﻿10.1088/1361-6633/aa50e8

xi = linspace(-pi,-pi/4);
h  = k_inf;
inv_a = h*cos(xi);
k     = h*sin(xi);
En = -hbar^2*k.^2/(2*mReduced);
E_fbmol = -hbar^2*inv_a.^2/(2*mReduced);

eqn_LHS = abs(En);
eqn_RHS = hbar^2*inv_a.^2/(2*mReduced) +...
    hbar^2*k.^2/(2*mReduced)/lambda^(2*n).*exp(-Delta(xi)/s0);

figure(2);clf;hold on;box on;
positive_filter = inv_a>0;
plot(inv_a*r_vdw,-eqn_RHS,...
    'linewidth',2,'color',[0.4940 0.1840 0.5560]);
plot(inv_a(positive_filter)*r_vdw,E_fbmol(positive_filter),...
    'linewidth',2,'color',[0 0 0])
% plot(inv_a*r_vdw,eqn_LHS);
% xlim([-0.4 0.1])
% ylim([-2e-28 0]);

figure(3);clf;hold on; box on;
plot(inv_a*r_vdw,exp(-Delta(xi)/s0),...
    '-','LineWidth',2,'color',[0 0 0 0.3]);
xlabel('r_{vdW}/a');
ylabel('e^{\Delta(\xi)/s_0}');
set(gca,'FontSize',20,'FontName','Arial');

negative_a_filter = inv_a<0;
fun_expDelta = exp(-Delta(xi)/s0);
fun_expDelta(negative_a_filter) = 1;

plot(inv_a*r_vdw,fun_expDelta,...
    '-','LineWidth',4,'color',[0 0 0]);

xlim([-1 1])


E_Efi_neg = -hbar^2*(k_inf^2-inv_a.^2)/2/mReduced;
E_Efi_pos = -hbar^2*(k_inf^2-inv_a.^2)/2/mReduced.*fun_expDelta + ...
    -hbar^2*inv_a.^2/(2*mReduced);

inv_a_Efi = [inv_a(~positive_filter) inv_a(positive_filter)];
E_Efi = [E_Efi_neg(~positive_filter) E_Efi_pos(positive_filter)];

figure(4);clf;box on;hold on;

plot(inv_a_Efi*r_vdw,E_Efi/E_vdw,...
    'linewidth',2,'color',[0.4940 0.1840 0.5560]);
plot(inv_a(positive_filter)*r_vdw,E_fbmol(positive_filter)/E_vdw,...
    'linewidth',2,'color',[0 0 0])



function output = Delta(xi)
    
    
    output = nan(size(xi));
    
    case1_filter = xi <= -5*pi/8;
    case2_filter = xi >  -5*pi/8 & xi<=-3*pi/8;
    case3_filter = xi >  -3*pi/8;

    z = xi(case1_filter) + pi;
    y = xi(case2_filter) + pi/2;
    x = sqrt(-xi(case3_filter)-pi/4);

    output(case1_filter) = -0.825-0.05*z-0.77*z.^2+1.26*z.^3-0.37*z.^4;
    output(case2_filter) = 2.11*y + 1.96*y.^2 + 1.38*y.^3;
    output(case3_filter) = 6.027 - 9.64*x + 3.14*x.^2;

end
