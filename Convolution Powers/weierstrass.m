clear
close all

[X,Y] = meshgrid(-pi/1.8:0.05:pi/1.8);
a = 0.5;
b = 3;
N = 50;
c1(1:N+1) = a.^(0:N);
c2(1:N+1) = b.^(0:N);
W = zeros(length(X),length(X));
for r = 1:length(X)
   for c = 1:length(Y)
        W(r,c) = sum(c1 .* cos(c2*atan(Y(c,1)/X(1,r)))) + 3;
   end
end
%Z = sqrt(X.^2+Y.^2);
Z = X.^2 + Y.^4 + (3/2).*X.*Y.^2;


zmin = 0; 
zmax = 1.8;
zinc = 0.2;
zlevs = zmin:zinc:zmax;
%contour(X,Y,W.*Z,zlevs,'ShowText','on','LineWidth',0.1);
%contour(X,Y,Z,zlevs,'ShowText','on');
zindex = zmin:1:zmax;
%hold on
%contour(X,Y,W.*Z,zindex,'LineWidth',3, 'LineColor', 'red', 'ShowText','on');
%contour(X,Y,Z,zindex,'LineWidth',3, 'LineColor', 'blue', 'ShowText','on');
%hold off
%contour(Z,'ShowText','on');

%figure
%surfc(X,Y,W.*Z , 'LineWidth',0.1);
%hold on
%contour(X,Y,W.*Z,zindex,'LineWidth',2, 'LineColor', 'red', 'ShowText','off');
%hold off

figure
surfc(X,Y,Z , 'LineWidth',0.1,'facealpha',0.4);
colormap winter;
hold on
contour(X,Y,Z,zindex,'LineWidth',2, 'LineColor', 'blue', 'ShowText','on');
xlabel('x', 'Fontsize',16);
ylabel('y', 'Fontsize',16);
hold off

figure 
[C,h]= contourf(X,Y,-1.*Z ,[0 -1],'LineWidth',2, 'LineColor', 'blue', 'ShowText','off');
map = [ 0.6 0.8 1 
        0.6 0.8 1 
        0.6 0.8 1
        0.6 0.8 1
        0.6 0.8 1
        0.6 0.8 1];
colormap(map);
%alphamap('vup')
hold on
% A = [-1.5,-1.3];
% point1 = [0.5,0]+A;
% point2 = [0,0.5]+A;
% origin = [0,0]+A;
% plot([origin(1) point1(1)],[origin(2) point1(2)],'LineWidth',2, 'Color','k');
% plot([origin(1) point2(1)],[origin(2) point2(2)],'LineWidth',2, 'Color','k');
% text(-1+0.05,-1.3,'$$x$$','FontSize',16, 'Interpreter','latex')
% text(-1.5, -0.8+0.1, '$$y$$','FontSize',16, 'Interpreter','latex')
% %text(0.5,0.85,'$$F$$','FontSize',22, 'Interpreter','latex')
text(-1.4, 0,'$$S_2$$','FontSize',20, 'Interpreter','latex')
% %text(0.2,0.5,'$$\tilde{F}$$','FontSize',22, 'Interpreter','latex')
text(-.05,0,'$$B_2$$','FontSize',20, 'Interpreter','latex')
box off
ax = gca
ax.Visible = 'off'
axis equal

hold off
xlabel('x', 'Fontsize',16);
ylabel('y', 'Fontsize',16);

% function weierstrass(a,b,kmax)	
% if nargin~=3
% 	if nargin<2
% 		a = 0.5;
% 		b = 3;
% 	end
% 	kmax = 20;
% end
% 	

% x = linspace(0,1,1000);
% 
% plot(x,w(x,c1,c2),'b-','LineWidth',1);
% title('Weierstrass''s non-differentiable function','Fontsize',18);
% xlabel(['a=' num2str(a), ', b=' num2str(b)],'Fontsize',16);
% ylabel('w(x) = sum_{k=0}^\infty [a^k cos(2 \pi b^k x)]','Fontsize',16);
% set(gca,'FontSize',14);
% grid on;
% 
% 	
% %--------------------------------
% function y = w(x,c1,c2)
% 
% index = 1;
% y = zeros(length(x),1);
% for k = x
% 	y(index) = sum(c1 .* cos(c2*k));
% 	index = index + 1;
% end


