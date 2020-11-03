% x (real(c))
d = 0.005; % step
dx=d; % step
x1=-2;
x2=1;
% y (imag(c))
dy=d; % step
y1=-1.5;
y2=1.5;
x=x1:dx:x2;
y=y1:dy:y2;
[X,Y] = meshgrid(x,y); % for vectorized calculation
c=X+1i*Y;
R=10; % if abs(z)>R then z is considered as infinity
n=100; % maximal number of iterations, 100 is close to infinity
z=zeros(size(c)); % starts from zeros
for nc=1:n
    z=z.^2+c; % vectorized
end
I=abs(z)<R; % logical image
imagesc(x,y,I);
%mesh(X,Y,z);
%set(gca,'YDir','normal');
xlabel('Re(c)');
ylabel('Im(c)');
    