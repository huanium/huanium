function [Ep,a,B,Ep_att,B_att,Ep_rep,B_rep,a_att,a_rep] = Ep_analytic(B,fbParam,bosonDensity)

ResPos = fbParam(1);
ResDelta = fbParam(2);
aBackgraound = fbParam(3);

aBF = @(aBG,deltaB,resB,Bfields) aBG*aBohr*(1+deltaB./(Bfields-resB));

%% calculate polaron energy 

n = bosonDensity;

a = aBF(aBackgraound,ResDelta,ResPos,B);%in SI unit

kappa1 = (0.26457*(339.29*a.^3*n + sqrt((339.29*a.^3*n+2).^2-4)+2).^(1/3))./a + 0.41997./(a.*(339.29*a.^3*n + sqrt((339.29*a.^3*n+2).^2-4)+2).^(1/3)) + 0.33333./a;
kappa2 = -((0.13228-0.22912*1i)*(339.29*a.^3*n+sqrt((339.29*a.^3*n+2).^2-4)+2).^(1/3))./a - (0.20999 + 0.36371*1i)./(a.*(339.29*a.^3*n+sqrt((339.29*a.^3*n+2).^2-4)+2).^(1/3)) + 0.33333./a;
kappa3 = -((0.13228 + 0.22912*1i)*(339.29*a.^3*n+sqrt((339.29*a.^3*n+2).^2-4)+2).^(1/3))./a - (0.20999-0.36371*1i)./(a.*(339.29*a.^3*n + sqrt((339.29*a.^3*n+2).^2-4)+2).^(1/3)) + 0.33333./a;

kappa = [kappa1,kappa2,kappa3];

% cut off exponentially growing polaron
kappa(imag(kappa.^2)>0) = nan;

% cut off short lived polaron
kappa(abs(real(kappa.^2)) < 0.7*abs(imag(kappa.^2))) = nan;

% cut off attractive polaron with finite lifetime
kappa(real(kappa.^2)>0 & imag(kappa)>0) = nan;

Ep = -((hbar*(kappa)).^2/(2*mReduced)/PlanckConst/1000);

B = [B,B,B];
a = [a,a,a];

Ep_att = Ep(real(Ep)<0);
B_att  = B(real(Ep)<0);
a_att = a(real(Ep)<0);
% a_att = nan;

Ep_rep = Ep(real(Ep)>0);
B_rep  = B(real(Ep)>0);
a_rep = a(real(Ep)>0);
% a_rep = nan;

end