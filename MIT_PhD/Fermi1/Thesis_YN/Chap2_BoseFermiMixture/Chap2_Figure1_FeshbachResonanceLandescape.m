clear; 


%%%% TIEMANN theory

m7Bres1 = 81.65;
m7Bres2 = 90.40;
m7Bres3 = 110.3;

m7Bzx1 = m7Bres1-0.30 ;
m7Bzx2 = m7Bres2-6.50;
m7Bzx3 = m7Bres3-17.05;

%%%% fitted updated
m7Bres3 = 112.1964;
m7Bzx3_exp = m7Bres3-17.3932;

%%%%% End Tiemann theory

m7Bres = [m7Bres1;m7Bres2;m7Bres3];
m7Bzx = [m7Bzx1;m7Bzx2;m7Bzx3_exp];
m7deltaB = m7Bres-m7Bzx;
abgm7=-710;
B = linspace(60,150,1e5);
asc_m7 = fb_fun(m7deltaB,m7Bres,B,abgm7);


%%%%% Tiemann theory
m9Bres1 = 78.35;
m9Bres2 = 89.80;

m9Bzx1 = m9Bres1-5.80;
m9Bzx2 = m9Bres2-9.55;

%%%%%% end Tiemann theory
m9Bres = [m9Bres1;m9Bres2];
m9Bzx = [m9Bzx1;m9Bzx2];
m9deltaB = m9Bres-m9Bzx;
abgm9=-730; %BG scattering of -9/2 according to ABM model, at 90G
asc_m9 = fb_fun(m9deltaB,m9Bres,B,abgm9);



f1=figure(1);clf;hold on;box on;
f1.Position = [f1.Position(1) f1.Position(2) 900 500];
plot(B,asc_m7,'-','LineWidth',2);
plot(B,asc_m9,'-','LineWidth',2);
ylim([-5000,5000]);
xlim([60,140])
xlabel('B (G)');
ylabel('a (a_0)');
legend('-7/2','-9/2');
ax = gca;
ax.FontSize = 16;

% -7/2 resonances from experiments
% m7Bres1_exp = 81.61;
% m7Bres2_exp = 90.47;
% m7Bres3_exp = 111.8;
% 
% m7Bzx1_exp = m7Bres1_exp-0.34 ;
% m7Bzx2_exp = m7Bres2_exp-7.93;
% m7Bzx3_exp = m7Bres3_exp-19;

% -9/2 resonances
% m9Bres1_exp = 78.41;
% m9Bres2_exp = 89.1;
% 
% m9Bzx1_exp = m9Bres1_exp-5.2;
% m9Bzx2_exp = m9Bres2_exp-8.8;

function out = fb_fun(deltaB,Bres,B,abg)

out = abg*(1+deltaB(1)./(B-Bres(1)));
for i = 2:size(deltaB,1)
    out = out.*(1+deltaB(i)./(B-Bres(i)));
end

end