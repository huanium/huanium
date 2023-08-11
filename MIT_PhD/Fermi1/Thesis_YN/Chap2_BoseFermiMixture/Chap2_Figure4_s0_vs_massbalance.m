% calculate s0 vs mass balance
clear;
mratio= logspace(-1,1); % = mF/mB
phi = asin(1./(1+mratio));
s0 = nan(size(phi));

mratio_NaK = mK/mNa;
phi_NaK = asin(1./(1+mratio_NaK));

syms s
eqn = s*cosh(pi*s/2)*sin(2*phi_NaK) == 2*sinh(phi_NaK*s);
s0_NaK = vpasolve(eqn,s,[1e-9 2]);
s0_NaK = double(s0_NaK);

for idx = 1:length(phi)
    syms s
    eqn = s*cosh(pi*s/2)*sin(2*phi(idx)) == 2*sinh(phi(idx)*s);
    s0(idx) = vpasolve(eqn,s,[1e-9 2]);
end

figure(4);clf;box on;
loglog(mratio,exp(pi./s0),...
    'LineWidth',3,'Color',[0 0 0 0.5]);
hold on;
loglog(mratio_NaK,exp(pi/s0_NaK),...
    '.','markersize',30,'Color',[0 0 0]);
xline(mratio_NaK,'--','linewidth',2);
yline(exp(pi/s0_NaK),'--','linewidth',2);

xlabel('m_f/m_b');
ylabel('\lambda');
set(gca,'FontSize',16,'FontName','arial');