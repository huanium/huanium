% %%%% detect oscillations by varying a %%%%
% a = 0:0.05:4;
% n = 1000;
% figure
% for k = 1:length(a)
%     x = logisticmap(a(k), n);
%     plot(x, 'Color', 'r');
%     hold on
% end
% hold off


%%%%% bifurcation diagram %%%%

% a = 0:0.0005:4;
% n = 500;
% iter = 1000;
% figure(1)
% for j = 1:iter 
%     x_end = zeros(length(a),1);
%     for k = 1:length(a)
%         x = logisticmap(a(k), n);
%         x_end(k) = x(end);
%     end
%     plot(a,x_end, '.', 'Color', 'r', 'MarkerSize',1);
%     hold on
% end
% hold off
% set(zoom(figure(1)),'Motion','horizontal');
%a = 3.50:0.00005:3.6;
% a = 3.564:0.000005:3.572;
% n = 500;
% iter = 1000;
% figure(3)
% for j = 1:iter 
%     x_end = zeros(length(a),1);
%     for k = 1:length(a)
%         x = logisticmap(a(k), n);
%         x_end(k) = x(end);
%     end
%     plot(a,x_end, '.', 'Color', 'r', 'MarkerSize',1);
%     hold on
% end
% hold off




%%%%% play with mandelbrot set %%%%%




%%%%% generate mandelbrot image %%%
% x (real(c))
d = 0.001; % step
dx=d; % step
x1=-2;
x2=0.5;
% y (imag(c))
dy=d; % step
y1=-1.5;
y2=1.5;
x=x1:dx:x2;
y=y1:dy:y2;
[X,Y] = meshgrid(x,0.75.*y); % for vectorized calculation
c=X+1i*Y;
R=10; % if abs(z)>R then z is considered as infinity
n=100; % maximal number of iterations, 100 is close to infinity
z=zeros(size(c)); % starts from zeros
for nc=1:n
    z=z.^2+c; % vectorized
end
I=abs(z)>=R; % logical image
figure(1)
imagesc(x,y,I);
colormap gray;
hold on;

%%%%% generate logistic map %%%%%
offset = 3;
a = -2:0.002:1/4;
n = 500;
iter = 1000;
figure(1)
for j = 1:iter 
    x_end = zeros(length(a),1);
    for k = 1:length(a)
        x = logis_mandelbrot(a(k), n);
        x_end(k) = x(end)+offset;
    end
    plot(a,x_end, '.', 'Color', 'r', 'MarkerSize',1);
    hold on
end

%%%%%%% functions %%%%%%%%%%


function x = logisticmap(a,n)
% Initialize an array in which to store results
x = zeros(n,1);
% Choose first entry randomly
x(1) = rand;
% Loop over entries, using the logistic map to assign subsequent entries
for k = 1:n-1
x(k+1) = a*x(k)*(1-x(k));
end
end


function x = logis_mandelbrot(a,n)
% Initialize an array in which to store results
x = zeros(n,1);
% Choose first entry randomly
x(1) = rand;
% Loop over entries, using the logistic map to assign subsequent entries
for k = 1:n-1
x(k+1) = x(k)^2 + a;
end
end


