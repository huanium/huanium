function [a_m7_interest,a_m9_interest] = FBresonanceLandscape(varargin)
p = inputParser;
p.addParameter('Binterest',80.2); 
p.parse(varargin{:});
Binterest                 =p.Results.Binterest;%outputs the prediction at this field


%% -7/2 resonances
m7Bres1 = 81.61;
m7Bres2 = 90.47;
m7Bres3 = 111.8;

m7Bzx1 = m7Bres1-0.34 ;
m7Bzx2 = m7Bres2-7.93;
m7Bzx3 = m7Bres3-19;

%%%% TIEMANN theory
m7Bres1 = 81.65;
m7Bres2 = 90.40;
m7Bres3 = 110.3;

m7Bzx1 = m7Bres1-0.30 ;
m7Bzx2 = m7Bres2-6.50;
m7Bzx3 = m7Bres3-17.05;

%%%%% End Tiemann theory

m7Bres = [m7Bres1;m7Bres2;m7Bres3];
m7Bzx = [m7Bzx1;m7Bzx2;m7Bzx3];
m7deltaB = m7Bres-m7Bzx;
%BG scattering length for -7/2 at 90G
abgm7=-710;

B = linspace(60,150,1e5);
asc_m7 = fb_fun(m7deltaB,m7Bres,B,abgm7);

a_m7_interest=fb_fun(m7deltaB,m7Bres,Binterest,abgm7);

%figure(1);clf; 
%plot(B,asc_m7,'.');
%ylim([-1e3,1e3]);

%% -9/2 resonances
m9Bres1 = 78.41;
m9Bres2 = 89.1;

m9Bzx1 = m9Bres1-5.2;
m9Bzx2 = m9Bres2-8.8;

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
a_m9_interest=fb_fun(m9deltaB,m9Bres,Binterest,abgm9);

%figure(2);clf;
%plot(B,asc_m9,'.');
%ylim([-1e3,1e3]);

figure(3813);clf;hold on;
plot(B,asc_m7,'-','LineWidth',2);
plot(B,asc_m9,'-','LineWidth',2);
% plot(B,asc_m7.*asc_m9./((asc_m7+asc_m9).^2),'-','LineWidth',2);
ylim([-5000,4000]);
xlim([50,110])
%pbaspect([2 1 1])

xlabel('B(G)');
ylabel('a_{IB} / a_0');

yyaxis right;
plot(B,asc_m7.*asc_m9./((asc_m7+asc_m9).^2).*heaviside(asc_m7).*heaviside(asc_m9)*4,'k--','LineWidth',1.5);
ylim([0,1]);
ylabel('bound-bound wvfunction amp');

legend('-7/2','-9/2','wvfun overlap');

box on
ax = gca;
%ax.XAxisLocation = 'origin';
ax.FontSize = 20;
[fb_fun(m9deltaB,m9Bres,93.2,abgm9),fb_fun(m9deltaB,m9Bres,78.8,abgm9),fb_fun(m9deltaB,m9Bres,79.0,abgm9)]
[fb_fun(m7deltaB,m7Bres,93.2,abgm7),fb_fun(m7deltaB,m7Bres,78.8,abgm7),fb_fun(m7deltaB,m7Bres,79.0,abgm7)]

% figure(2561);clf;
% plot(B,asc_m7.*asc_m9./((asc_m7+asc_m9).^2).*heaviside(asc_m7).*heaviside(asc_m9),'k--','LineWidth',2);
% ylim([0,0.25]);

end

function out = fb_fun(deltaB,Bres,B,abg)
%abg = -800; %background scattering length

out = abg*(1+deltaB(1)./(B-Bres(1)));
for i = 2:size(deltaB,1)
    out = out.*(1+deltaB(i)./(B-Bres(i)));
end

end