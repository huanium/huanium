xvals = [85.6,86.6,84.5,87.2];
yvals = -1*[80,45,164,24];
yError = [5,5,5,5];


figure(881),clf;
errorbar(xvals,yvals,yError,'.','MarkerSize',22,'LineWidth',1.5,'CapSize',0)

aBF = @(aBG,deltaB,resB,Bfields) aBG*aBohr*(1+deltaB./(Bfields-resB));
eBinding = @(aBG,deltaB,resB,aBar,Bfields) -1*hbar^2./(2*mReduced*(aBF(aBG,deltaB,resB,Bfields)-aBar*aBohr).^2)/PlanckConst/1000;

hold on
Bfields = 80:0.01:95;
ResPos = 89.1;
ResDelta = 8.8;
test = eBinding(-710,ResDelta,ResPos,52,Bfields);
plot(Bfields,test,'--','LineWidth',2);
hold off
xlim([80,95])
ylim([-300,0])
% 
fitfun = @(p,x) eBinding(-710,p(1),p(2),52,x);
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


hold on
test = eBinding(-710,paramFit(1),paramFit(2),52,Bfields);
plot(Bfields,test,'LineWidth',2);
hold off

xlabel('Magnetic field (Gauss)')
ylabel('Binding energy (kHz)')
set(gca, 'FontName', 'Arial')
set(gca,'FontSize', 12);

legend('measured',['Old FB res = ' num2str(ResPos,4) 'G; deltaB = ' num2str(ResDelta,3) 'G'],['Fitted FB res = ' num2str(paramFit(2),4) 'G; deltaB = ' num2str(paramFit(1),3) 'G'],'location','best')