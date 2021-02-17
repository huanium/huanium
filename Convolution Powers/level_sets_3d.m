%%% DRAW S
f= @(x,y,z) x.^2 + x.*y.^2 + y.^4 + z.^4;
minx = -2; maxx = 2;
miny = -2; maxy = 2;
minz = -2; maxz = 2;
N = 100;
xv = linspace(minx, maxx, N);
yv = linspace(miny, maxy, N);
zv = linspace(minz, maxz, N);
[X, Y, Z] = meshgrid(xv, yv, zv);
D = f(X, Y, Z);
%cla
p1 = patch(isosurface(X, Y, Z, D, 1));
set(p1, 'FaceColor','b', 'FaceAlpha',.1, 'EdgeAlpha',.0)
xlabel('X');
ylabel('Y');
zlabel('Z');
view(3)
%axis vis3d
%colormap winter
camlight
hold on 

%%% DRAW Contours
minx = -2; maxx = 2;
miny = -2; maxy = 2;
minz = -2; maxz = 2;
N = 20;
xv = linspace(minx, maxx, N);
yv = linspace(miny, maxy, N);
zv = linspace(minz, maxz, N);
[X, Y, Z] = meshgrid(xv, yv, zv);
D = f(X, Y, Z);
p3 = patch(isosurface(X, Y, Z, D, 1));
set(p3, 'FaceAlpha',.0, 'EdgeAlpha',.15)




%%% DRAW F
minx = -0.5; maxx = 0.5;
miny = -0.5; maxy = 0.5;
minz = 0; maxz = 2;
N = 300;
xv = linspace(minx, maxx, N);
yv = linspace(miny, maxy, N);
zv = linspace(minz, maxz, N);
[X, Y, Z] = meshgrid(xv, yv, zv);
D = f(X, Y, Z);
p2 = patch(isosurface(X, Y, Z, D, 1));
set(p2,'FaceColor','b', 'FaceAlpha',1, 'EdgeAlpha',.0);

%%% DRAW smaller Fs
for t = 0.000:0.00001:0.0002
    x = p2.XData;
    y = p2.YData;
    z = p2.ZData;
    x = x(1:end, 1:2000:end);
    y = y(1:end, 1:2000:end);
    z = z(1:end, 1:2000:end);
    x = t^(1/2).*x;
    y = t^(1/4).*y;
    z = t^(1/4).*z;
    surf(x,y,z, 'Marker', '.', 'MarkerEdgeColor','r', 'MarkerSize',0.25, 'FaceAlpha', 0, 'EdgeAlpha', 0);
    %set(p2, 'Marker','.' , 'FaceColor','r', 'FaceAlpha',.0, 'EdgeAlpha',.0);
end
for t = 0.000:0.0004:0.05
    x = p2.XData;
    y = p2.YData;
    z = p2.ZData;
    x = x(1:end, 1:1000:end);
    y = y(1:end, 1:1000:end);
    z = z(1:end, 1:1000:end);
    x = t^(1/2).*x;
    y = t^(1/4).*y;
    z = t^(1/4).*z;
    surf(x,y,z, 'Marker', '.', 'MarkerEdgeColor','r', 'MarkerSize',0.25, 'FaceAlpha', 0, 'EdgeAlpha', 0);
    %set(p2, 'Marker','.' , 'FaceColor','r', 'FaceAlpha',.0, 'EdgeAlpha',.0);
end
for t = 0.001:0.0025:0.95
    x = p2.XData;
    y = p2.YData;
    z = p2.ZData;
    x = x(1:end, 1:100:end);
    y = y(1:end, 1:100:end);
    z = z(1:end, 1:100:end);
    x = t^(1/2).*x;
    y = t^(1/4).*y;
    z = t^(1/4).*z;
    surf(x,y,z, 'Marker', '.', 'MarkerEdgeColor','r', 'MarkerSize',0.5, 'FaceAlpha', 0, 'EdgeAlpha', 0);
    %set(p2, 'Marker','.' , 'FaceColor','r', 'FaceAlpha',.0, 'EdgeAlpha',.0);
end














%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% draw first line
N = 1000 ;
t = linspace(0,1,N) ;
x = 0.5.*t.^(1/2);
y = 0.5.*t.^(1/4) ;
z = 0.8612.*t.^(1/4);
plot3(x,y,z, '-', 'Color','k', 'LineWidth',1.5)

% draw second line
N = 1000 ;
t = linspace(0,1,N) ;
x = -0.5.*t.^(1/2);
y = 0.5.*t.^(1/4) ;
z = 0.9494.*t.^(1/4);
plot3(x,y,z, '-', 'Color','k', 'LineWidth',1.5)

% draw third line
N = 1000 ;
t = linspace(0,1,N) ;
x = -0.5.*t.^(1/2);
y = -0.5.*t.^(1/4) ;
z = 0.9494.*t.^(1/4);
plot3(x,y,z, '-', 'Color','k', 'LineWidth',1.5)

% draw fourth line
N = 1000 ;
t = linspace(0,1,N) ;
x = 0.5.*t.^(1/2);
y = -0.5.*t.^(1/4) ;
z = 0.8659.*t.^(1/4);
plot3(x,y,z, '-', 'Color','k', 'LineWidth',1.5)


%%% annotate
text(-0.5,-0.25, 1.5,'$$F$$','FontSize',22, 'Interpreter','latex')
text(-1.25,0, 0.5, '$$S$$','FontSize',22, 'Interpreter','latex')
text(-0.4,-0.8, 0.9, '$$\tilde{F} $$','FontSize',22, 'Interpreter','latex')
text(-.05,-.05, -0.05, '$$ O $$','FontSize',22, 'Interpreter','latex')

A = [-1.5,1,-1];
point1 = [0.5,0,0]+A;
point2 = [0,0.5,0]+A;
point3 = [0 0 0.5]+A;
origin = [0,0,0]+A;
plot3([origin(1) point1(1)],[origin(2) point1(2)],[origin(3) point1(3)],'LineWidth',2, 'Color','k');
plot3([origin(1) point2(1)],[origin(2) point2(2)],[origin(3) point2(3)],'LineWidth',2, 'Color','k');
plot3([origin(1) point3(1)],[origin(2) point3(2)],[origin(3) point3(3)],'LineWidth',2, 'Color','k');
text(-0.95, 1, -1 ,'$$x$$','FontSize',16, 'Interpreter','latex')
text(-1.5,1, -0.4, '$$z$$','FontSize',16, 'Interpreter','latex')
text(-1.5,1.66, -1, '$$y $$','FontSize',16, 'Interpreter','latex')
% box on
ax = gca
ax.Visible = 'off'
