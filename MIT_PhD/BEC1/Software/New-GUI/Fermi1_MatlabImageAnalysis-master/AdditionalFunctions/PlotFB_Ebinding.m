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


figure(881),clf;
errorbar(xvals,yvals,yError,'.','MarkerSize',22,'LineWidth',1.5,'CapSize',0)

aBF = @(aBG,deltaB,resB,Bfields) aBG*aBohr*(1+deltaB./(Bfields-resB));
eBinding = @(aBG,deltaB,resB,aBar,Bfields) -1*hbar^2./(2*mReduced*(aBF(aBG,deltaB,resB,Bfields)-aBar*aBohr).^2)/PlanckConst/1000;

hold on
Bfields = 100:0.01:120;
ResPos = 111.8;
ResDelta = 19;
test = eBinding(-710,ResDelta,ResPos,52,Bfields);
plot(Bfields,test,'--','LineWidth',2);
hold off
xlim([100,110])
ylim([-400,0])
% 
fitfun = @(p,x) eBinding(-710,p(1),p(2),52,x);
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


hold on
test = eBinding(-710,paramFit(1),paramFit(2),52,Bfields);
plot(Bfields,test,'LineWidth',2);
hold off

xlabel('Magnetic field (Gauss)')
ylabel('Binding energy (kHz)')
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 12);

legend('measured',['Old FB res = ' num2str(ResPos,4) 'G; deltaB = ' num2str(ResDelta,3) 'G'],['Fitted FB res = ' num2str(paramFit(2),4) 'G; deltaB = ' num2str(paramFit(1),3) 'G'],'location','best')