function [Eb_exp,Eb_thry,xvals,yvals,yError,Eb_kna_exp,Eb_kna_thry,ResPos_fit,ResDelta_fit] = fb_molecule_m92(B,kna_inverse)
%% feshbach molecular binding energy for -9/2 around 89.1G resonance

kna = 1./kna_inverse;

xvals = [85.6,86.6,84.5,87.2];
yvals = -1*[80,45,164,24];
yError = [5,5,5,5];




aBF = @(aBG,deltaB,resB,Bfields) aBG*aBohr*(1+deltaB./(Bfields-resB));
eBinding = @(aBG,deltaB,resB,aBar,Bfields) -1*hbar^2./(2*mReduced*(aBF(aBG,deltaB,resB,Bfields)-aBar*aBohr).^2)/PlanckConst/1000;

ResPos = 89.1;
ResDelta = 8.8;
aBackground = -710;
aBar = 0;

Bfields = 80:0.01:95;
Eb_thry = eBinding(aBackground,ResDelta,ResPos,52,B);

fitfun = @(p,x) eBinding(-710,p(1),p(2),aBar,x);

pGuess  = [10,89];
lb      = [0,0];
ub      = [inf,inf];
weighted_deviations = @(p) (fitfun(p,xvals)-yvals)./yError;
optio = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective','Display','off','MaxFunctionEvaluations',100);
[paramFit,~,resid,~,~,~,J]=lsqnonlin(weighted_deviations,pGuess,lb,ub,optio);
try
    ciFit = nlparci(paramFit,resid,'jacobian',J);
catch
    ciFit = [NaN;NaN];
end

Eb_exp = eBinding(-710,paramFit(1),paramFit(2),52,B);



% kna to B field
kna2B = ResDelta./(kna/(aBackground/1300)-1)+ResPos;
Eb_kna_thry = eBinding(aBackground,ResDelta,ResPos,52,kna2B);
Eb_kna_exp = eBinding(aBackground,paramFit(1),paramFit(2),52,kna2B);

% output Feshbach resonance position and width
ResPos_fit = paramFit(2);
ResDelta_fit = paramFit(1);

% a_fit = aBF(aBackgraound,paramFit(1),paramFit(2),B);

end