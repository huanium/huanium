clear
n = 4; % n-th Efimov state 
s0 = 10; % Efimov parameter for NaK

figure(1);clf;
for idx = 0:20
    EfimovEnergy(idx,s0)
end


function EfimovEnergy(n,s0)
r_vdw = 53*aBohr; % van der Waals range for NaK
lambda = exp(pi/s0); %scaling factor
a_0 = -60*aBohr*lambda^n; % first Efimov state scattering
k_inf = -1/a_0; % first Efimov k-vector at unitarity
E_vdw = hbar^2/(2*mReduced*r_vdw^2); % van der Waals energy

inv_a_neg = linspace(1/a_0,0);
inv_a_pos = linspace(0,-1/a_0);
inv_a_mol = linspace(0,1.2)/r_vdw;

E_Efimov_neg = -hbar^2*(k_inf^2-inv_a_neg.^2)/2/mReduced;
E_Efimov_pos = -hbar^2*(k_inf^2-inv_a_pos.^2)/2/mReduced + ...
               -hbar^2*inv_a_pos.^2/(2*mReduced);
E_mol = -hbar^2*inv_a_mol.^2/(2*mReduced);

figure(1);box on;hold on;
xline(0,'LineWidth',0.5);
yline(0,'LineWidth',0.5);

plot(r_vdw*inv_a_neg,E_Efimov_neg/E_vdw,...
    'LineWidth',2,'color',[0.4940 0.1840 0.5560]);
plot(r_vdw*inv_a_pos,E_Efimov_pos/E_vdw,...
    'LineWidth',2,'color',[0.4940 0.1840 0.5560]);
plot(r_vdw*inv_a_mol,E_mol/E_vdw,...
    'LineWidth',2,'color',[0 0 0]);


xlim([-1.2 1.2]);
ylim([-1.5,0.1]);

xlabel('r_{vdW}/a');
ylabel('E/E_{vdW}');
set(gca,'fontsize',16);

end
