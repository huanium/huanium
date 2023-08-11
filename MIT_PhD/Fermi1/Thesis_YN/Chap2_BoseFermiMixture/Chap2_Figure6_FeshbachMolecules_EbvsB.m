%%
clear;
cd(fileparts(matlab.desktop.editor.getActiveFilename));

FBmolm92 = readtable('FeshbachMolecule_m92.csv');
Eb92 = (FBmolm92.f_atom_MHz-FBmolm92.f_mol_MHz)*1e3;
B92 = nan(size(Eb92));
for idx = 1:length(B92)
    B92(idx) = B_fieldFromBreitRabiFrequency(85,FBmolm92.f_atom_MHz(idx),-7/2,-9/2);
end

FBmolm72 = readtable('FeshbachMolecule_m72.csv');
Eb72 = -(FBmolm72.f_atom_MHz-FBmolm72.f_mol_MHz)*1e3;
B72 = nan(size(Eb72));
for idx = 1:length(B72)
    B72(idx) = B_fieldFromBreitRabiFrequency(105,FBmolm72.f_atom_MHz(idx),-7/2,-9/2);
end

fun_B2a = @(p,B) p(1)*(1+p(2)./(B-p(3)));
fun_B2a_names = {'abg (a_0)','\Delata_B (G)','B_0 (G)'};

fun_a2E = @(a_,a) -hbar^2./(2*mReduced*((a-a_)*aBohr).^2)/PlanckConst;
fun_a2E_names = {'a_ (a_0)'};

fun_B2E = @(p,B) fun_a2E(p(4),fun_B2a(p(1:3),B))/2/pi*1e-3;
fun_B2E_names = {'abg (a_0)','\Delata_B (G)','B_0 (G)','a_ (a_0)','output (kHz)'};

% fit mF=-9/2 data
fit_guess_92 = [-690 9.55 89.8 50];
fit_ub_92    = [-0   15   89.8   50];
fit_lb_92    = [-800 0    89.8   50];

weighted_deviations_K1 = @(p) (fun_B2E(p,B92)-Eb92);
optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
[fit_result_92,~,~,~,~,~,~]=lsqnonlin(weighted_deviations_K1,fit_guess_92,fit_lb_92,fit_ub_92,optio);

fit_xval92 = linspace(84,fit_guess_92(3));
fit_yval92 = fun_B2E(fit_result_92,fit_xval92);

% fit mF=-7/2 data
fit_guess_72 = [-690 17.05 110.3 50];
fit_ub_72    = [-0   35   110.3   50];
fit_lb_72    = [-800 0    110.3   50];

weighted_deviations_K1 = @(p) (fun_B2E(p,B72)-Eb72);
optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
[fit_result_72,~,~,~,~,~,~]=lsqnonlin(weighted_deviations_K1,fit_guess_72,fit_lb_72,fit_ub_72,optio);

fit_xval72 = linspace(101,fit_guess_72(3));
fit_yval72 = fun_B2E(fit_result_72,fit_xval72);


f6=figure(6);clf;
f6.Position = [f6.Position(1) f6.Position(2) 500 600];
subplot(2,1,1);hold on;box on;
plot(B92,Eb92,...
    '.','MarkerSize',30,'color',[0.8500 0.3250 0.0980]);
plot(fit_xval92,fit_yval92,...
    '-','linewidth',3,'color',[0.8500 0.3250 0.0980 0.5]);

xlim([84 87.5]);
ylim([-300 0]);

% xlabel('Magnetic field B (G)');
ylabel('E_b/h (kHz)');
set(gca,'FontSize',16,'FontName','arial');

subplot(2,1,2);hold on;box on;
plot(B72,Eb72,...
    'k.','MarkerSize',30,'color',[0 0.4470 0.7410]);
plot(fit_xval72,fit_yval72,...
    '-','linewidth',3,'color',[0 0.4470 0.7410 0.5]);

xlim([101.5 107]);
ylim([-300 0]);

xlabel('Magnetic field B (G)');
ylabel('E_b/h (kHz)');
set(gca,'FontSize',16,'FontName','arial');


