[X,Y] = meshgrid(-pi/1.8:0.1:pi/1.8);
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
Z = X.^2 + Y.^4 + (0)*X.*Y.^2;


zmin = 0; 
zmax = 1.8;
zinc = 0.2;
zlevs = zmin:zinc:zmax;
%contour(X,Y,W.*Z,zlevs,'ShowText','on','LineWidth',0.1);
contour(X,Y,Z,zlevs,'ShowText','on');
zindex = zmin:1:zmax;
hold on
%contour(X,Y,W.*Z,zindex,'LineWidth',3, 'LineColor', 'red', 'ShowText','on');
contour(X,Y,Z,zindex,'LineWidth',3, 'LineColor', 'red', 'ShowText','on');
hold off
%contour(Z,'ShowText','on');


% surfc(X,Y,W.*Z , 'LineWidth',0.1);
% hold on
% contour(X,Y,W.*Z,zindex,'LineWidth',2, 'LineColor', 'red', 'ShowText','on');
% hold off

surfc(X,Y,Z , 'LineWidth',0.1,'facealpha',0.4);
hold on
contour(X,Y,Z,zindex,'LineWidth',2, 'LineColor', 'red', 'ShowText','on');
hold off

xlabel('x', 'Fontsize',16);
ylabel('y', 'Fontsize',16);
colorbar

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


