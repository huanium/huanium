
lambdas = [820:0.1:900]*1e-9;
omegaK  = [];
omegaNa = [];
for idx = 1:length(lambdas)
    omegaK(idx)  = singleBeamRadialFreq('K',lambdas(idx),110e-6,2);
    omegaNa(idx) = singleBeamRadialFreq('Na',lambdas(idx),110e-6,2);
end

figure(1);clf; hold on;
    plot(lambdas*1e9,omegaK./omegaNa,'LineWidth',2);
    ylabel('\omega_K / \omega_{Na}');
    xlabel('\lambda_{trap} (nm)');
    %legend('^{40}K', '^{23}Na','Location','northwest');
    box on
    set(gca, 'FontName', 'Arial')
    set(gca,'FontSize', 20);