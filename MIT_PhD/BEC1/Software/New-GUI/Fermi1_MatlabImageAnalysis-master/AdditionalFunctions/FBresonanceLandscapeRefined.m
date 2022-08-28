function aInterest= FBresonanceLandscapeRefined(varargin)
p = inputParser;
p.addParameter('Binterest',80.2); %if empty, second sine has no decay
p.parse(varargin{:});
Binterest                 =p.Results.Binterest;%outputs the prediction at this field

Bstart=60;
Bend=100;
abgm9=-730; %BG scattering of -9/2 according to ABM model, at 90G

B = linspace(Bstart,Bend,1e4);

% -9/2 resonances
m9Bres1 = 78.35;
m9Bres2 = 89.80;

m9Bzx1 = m9Bres1-5.8;
m9Bzx2 = m9Bres2-9.55;

% m9Bres1 = 78.41;
% m9Bres2 = 89.1;
% 
% m9Bzx1 = m9Bres1-5.2;
% m9Bzx2 = m9Bres2-8.8;


%%%%% Tiemann theory

% m9Bres1 = 78.35;
% m9Bres2 = 89.80;
% 
% m9Bzx1 = m9Bres1-5.80;
% m9Bzx2 = m9Bres2-9.55;
%%%%%% end Tiemann theory

m9Bres = [m9Bres1;m9Bres2];
m9Bzx = [m9Bzx1;m9Bzx2];
m9deltaB = m9Bres-m9Bzx;


asc_m9 = fb_fun(m9deltaB,m9Bres,B,abgm9);

%figure(2);clf;
%plot(B,asc_m9,'.');
%ylim([-1e3,1e3]);

figure(3813);clf;hold on;
% plot(B,asc_m7,'-','LineWidth',2);
plot(B,asc_m9,'-','LineWidth',2);
ylim([-4000,4000]);
xlim([Bstart,Bend])
%pbaspect([2 1 1])

xlabel('B(G)');
ylabel('a_{IB} / a_0');


box on
ax = gca;
%ax.XAxisLocation = 'origin';
ax.FontSize = 14;
aInterest=fb_fun(m9deltaB,m9Bres,Binterest,abgm9);
% [fb_fun(m7deltaB,m7Bres,93.2,abgm7),fb_fun(m7deltaB,m7Bres,78.8,abgm7),fb_fun(m7deltaB,m7Bres,79.0,abgm7)]

end

function out = fb_fun(deltaB,Bres,B,abg)
%abg = -800; %background scattering length

out = abg*(1+deltaB(1)./(B-Bres(1)));
for i = 2:size(deltaB,1)
    out = out.*(1+deltaB(i)./(B-Bres(i)));
end

end