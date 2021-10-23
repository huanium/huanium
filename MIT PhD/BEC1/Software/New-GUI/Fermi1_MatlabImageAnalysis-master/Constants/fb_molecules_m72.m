function [Eb_exp,Eb_thry,xvals,yvals,yError,ResPos_fit,ResDelta_fit] = fb_molecules_m72(B)

%Tiemann Values
ResPos = 110.3;
ResDelta = 17.05;
aBar = 0;

%fitted Values
ResPos = 111.6;
ResDelta = 20.1;
aBar = 0;

%% feshbach molecule binding energy of -7/2 state around 110G resonance



xvals = [105.695
105.2
104.71
106.67
103.761
102.745
101.745];
yvals = -1*[41.55
52.074
64
26.4
105
151
228];
yError = [8.55
    11.15
    6.6
    10.57
    4.72
    4.95
    4.43];


aBF = @(aBG,deltaB,resB,Bfields) aBG*aBohr*(1+deltaB./(Bfields-resB));
eBinding = @(aBG,deltaB,resB,aBar,Bfields) -1*hbar^2./(2*mReduced*(aBF(aBG,deltaB,resB,Bfields)-aBar*aBohr).^2)/PlanckConst/1000;

Bfields = 100:0.01:120;

Eb_thry = eBinding(-710,ResDelta,ResPos,aBar,B);
fitfun = @(p,x) eBinding(-710,p(1),p(2),aBar,x);
pGuess  = [20,110];
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

% output fitted Feshbach resonance location
ResPos_fit = paramFit(2);
ResDelta_fit = paramFit(1);

Eb_exp = eBinding(-710,paramFit(1),paramFit(2),aBar,B);
end