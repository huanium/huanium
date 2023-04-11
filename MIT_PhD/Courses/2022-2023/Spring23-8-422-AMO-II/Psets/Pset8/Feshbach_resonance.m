
clear
delta = -4:0.025:8;
dim = 8;
V = zeros(dim);
v = 0.6;
V(1:end,1) = v;
V(1,1:end) = v;
V(1,1) = 0;

energies = figure(1);
for d = delta
    H0 = diag(-1:1:dim-2);
    H0(1,1) = d;
    H = H0 + V;
    e = eig(H);
    hold on 
    plot(d*ones(dim), e, 'o', 'Color', 'red', 'MarkerSize', 2);
    plot(d,d)
end

for i=0:1:dim
    yline(i, '--', 'Color', 'black')
end

xline(0, '--', 'Color','black')
xline(6, '--', 'Color','black')

plot(delta, delta, "--",'Color', 'blue')

ylim([-4, 6])
hold off 

set(gca,'xtick', [0,6]);
xticklabels({'0','\delta_0'})
set(gca,'ytick', 0);

xlabel('Detuning \delta', 'FontSize',13)
ylabel('Two-particle energy', 'FontSize',13)

% annotations:
xm = [0.2 0.24];
ym = [0.3 0.25];
annotation('textarrow',xm,ym,'String','|m>')

% annotations:
xp = [0.5 0.5];
yp = [0.3 0.4];
annotation('textarrow',xp,yp,'String','|\phi>')
      
% annotations:
xk = [0.85 0.85];
yk = [0.65 0.75];
annotation('textarrow',xk,yk,'String','|k>')






    
