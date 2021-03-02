clear all 
close all

%%%%  DRAW S
x = -5:0.01:5;
y = -5:0.01:5;
zmin = 0; 
zmax = 1;
zinc = 1;
zlevs = zmin:zinc:zmax;
[X,Y] = meshgrid(x,y);
Z = X.^2 + (3/2).*X.*Y.^2 + Y.^4;
hold on
contour(X,Y,Z, zlevs,'Color','blue')
xlabel('X')
ylabel('Y')



%%%%  DRAW smaller Fs
for t = 0.00001:0.0001:0.02
    x = 0.25*t^(1/2):0.0005:0.75*t^(1/2);
    y = 0.5*t^(1/4):0.0005:1*t^(1/4);
    zmin = 0;
    zmax = t;
    zinc = t/2;
    zlevs = zmin:zinc:zmax;
    [X,Y] = meshgrid(x,y);
    Z = X.^2 + (3/2).*X.*Y.^2 + Y.^4;
    contour(X,Y,Z, zlevs, 'Color',[0.6,0.8,1], 'LineWidth',2)
end
for t = 0.0005:0.005:1
    x = 0.25*t^(1/2):0.005:0.75*t^(1/2);
    y = 0.5*t^(1/4):0.005:1*t^(1/4);
    zmin = 0;
    zmax = t;
    zinc = t/2;
    zlevs = zmin:zinc:zmax;
    [X,Y] = meshgrid(x,y);
    Z = X.^2 + (3/2).*X.*Y.^2 + Y.^4;
    contour(X,Y,Z, zlevs, 'Color',[0.6,0.8,1]', 'LineWidth',2)
end

%%%%  DRAW F
x = 0.25:0.01:0.75;
y = 0.5:0.01:1;
zmin = 0; 
zmax = 1;
zinc = 1;
zlevs = zmin:zinc:zmax;
[X,Y] = meshgrid(x,y);
Z = X.^2 + (3/2).*X.*Y.^2 + Y.^4;
contour(X,Y,Z, zlevs,'Color','blue', 'LineWidth',3)
xlabel('X')
ylabel('Y')


% draw first line
N = 1000 ;
t = linspace(0,1,N) ;
x=0.25.*t.^(1/2);
y=0.893685.*t.^(1/4) ;
plot(x,y,  '-', 'Color','k', 'LineWidth',2)

% draw second line
N = 1000 ;
t = linspace(0,1,N) ;
x=0.75.*t.^(1/2);
y=0.55294.*t.^(1/4) ;
plot(x,y,  '-', 'Color','k', 'LineWidth',2)








%%% annotate
text(0.5,0.85,'$$F$$','FontSize',22, 'Interpreter','latex')
text(-1.25,0,'$$S$$','FontSize',22, 'Interpreter','latex')
text(0.2,0.5,'$$\tilde{F}$$','FontSize',22, 'Interpreter','latex')
text(-.05,-0.15,'$$ O$$','FontSize',22, 'Interpreter','latex')

A = [-1.8,-1.5];
point1 = [0.5,0]+A;
point2 = [0,0.5]+A;
origin = [0,0]+A;
plot([origin(1) point1(1)],[origin(2) point1(2)],'LineWidth',2, 'Color','k');
plot([origin(1) point2(1)],[origin(2) point2(2)],'LineWidth',2, 'Color','k');
text(-0.95-0.5+0.2, 1-1-1.5 ,'$$x$$','FontSize',16, 'Interpreter','latex')
text(-1.5-0.5+0.2,1.66-1-1.5, '$$y $$','FontSize',16, 'Interpreter','latex')
% box on
ax = gca
ax.Visible = 'off'

hold off
