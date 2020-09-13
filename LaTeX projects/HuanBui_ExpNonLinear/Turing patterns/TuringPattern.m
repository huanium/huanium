clear all; clc; close all;
% Initialization %
r = 15;
K = 40;
lamda = 0.006;
m = 14.5;
a1 = 14;
mu = 0.0019;
d = 6;
theta = 11.1;
d1 = 100;
d2 = 0.001;
d3 = 1;
delta1 = d2/d1;
delta2 = d3/d1;
a = 0;
b = 100;
h = 0.1;
T = 500;
delt = 1/384;
% User inputs of initial data
U0 = input('Enter initial data function U0(X,Y)   ','s');
V0 = input('Enter initial data function V0(X,Y)   ','s');
W0 = input('Enter initial data function W0(X,Y)   ','s');

% Calculate and assign constants
nu=delt/(h^2); 
J=round((b-a)/h);
dimJ=J+1;
n = (dimJ)^2;                   
N=round(T/delt);
% Initialization
u=zeros(n,1); v=zeros(n,1); w=zeros(n,1); F=zeros(n,1); G=zeros(n,1); H=zeros(n,1);
y1=zeros(n,1); y2=zeros(n,1); y3=zeros(n,1); U_grid=zeros(dimJ,dimJ);
V_grid=zeros(dimJ,dimJ); W_grid=zeros(dimJ,dimJ); B=sparse(n,n); L=sparse(n,n); 
% Assign initial data
indexI=1:dimJ;
x=(indexI-1)*h+a;
[X,Y]=meshgrid(x,x);
   
U0 = eval(U0).*ones(dimJ,dimJ); V0 = eval(V0).*ones(dimJ,dimJ); W0 = eval(W0).*ones(dimJ,dimJ);

U0=U0'; V0=V0'; W0=W0'; u=U0(:); v=V0(:); w=W0(:);

L(1,1)=3; L(1,2)=-3/2; L(J+1,J+1)=6; L(J+1,J)=-3;
L=L+sparse(2:J,3:J+1,-1,n,n);
L=L+sparse(2:J,2:J,4,n,n);
L=L+sparse(2:J,1:J-1,-1,n,n);
L(1,J+2)=-3/2; L(J+1,2*J+2)=-3;
L=L+sparse(2:J,J+3:2*J+1,-2,n,n);
L(n-J,n-J)=6; L(n-J,n-J+1)=-3; 
L(n,n)=3; L(n,n-1)=-3/2;
L=L+sparse(n-J+1:n-1,n-J+2:n,-1,n,n);
L=L+sparse(n-J+1:n-1,n-J+1:n-1,4,n,n);
L=L+sparse(n-J+1:n-1,n-J:n-2,-1,n,n);
L(n-J,n-(2*J+1))=-3; L(n,n-dimJ)=-3/2;
L=L+sparse(n-J+1:n-1,n-2*J:n-(J+2),-2,n,n);
L=L+sparse(J+2:n-dimJ,2*J+3:n,-1,n,n);
L=L+sparse(J+2:n-dimJ,1:n-2*dimJ,-1,n,n);
L=L+sparse(J+2:n-dimJ,J+2:n-dimJ,4,n,n);
L=L+sparse(J+2:n-(J+2),J+3:n-dimJ,-1,n,n);
L=L+sparse(J+2:dimJ:n-(2*J+1),J+3:dimJ:n-2*J,-1,n,n); 
L=L+sparse(2*J+2:dimJ:n-2*dimJ,2*J+3:dimJ:n-(2*J+1),1,n,n);
L=L+sparse(J+3:n-dimJ,J+2:n-(J+2),-1,n,n);
L=L+sparse(2*J+2:dimJ:n-dimJ,2*J+1:dimJ:n-(J+2),-1,n,n);
L=L+sparse(2*J+3:dimJ:n-(2*J+1),2*J+2:dimJ:n-2*dimJ,1,n,n);

B1=sparse(1:n,1:n,1,n,n)+nu*L;
B2=sparse(1:n,1:n,1,n,n)+delta1*nu*L;
B3=sparse(1:n,1:n,1,n,n)+delta2*nu*L;

for nt=1:N
    nt
    F = r*u.*(1-(u+v)/K)-lamda*u.*v;
    G = lamda*u.*v-(m*v.*w)./(a1+v)-mu*v;
    H = (theta*v.*w)./(a1+v)-d*w;
%     F = r*(1-(u+v)/K)-lamda*v;
%     G = lamda*u-(m*w)./(a1+v)-mu;
%     H = (theta*v)./(a1+v)-d;
    y1 = u + delt*F;
    y2 = v + delt*G;
    y3 = w + delt*H;
    % Solve for u, v and w using GMRES
    [u,flagu,relresu,iteru]=gmres(B1,y1,[],1e-6,[],[],[],u);
    if flagu~=0 flagu,relresu,iteru,error('GMRES did not converge'),end
    [v,flagv,relresv,iterv]=gmres(B2,y2,[],1e-6,[],[],[],v);
    if flagv~=0 flagv,relresv,iterv,error('GMRES did not converge'),end
    [w,flagw,relresw,iterw]=gmres(B3,y3,[],1e-6,[],[],[],w);
    if flagw~=0 flagw,relresw,iterw,error('GMRES did not converge'),end
end

% save('day1.mat','u','v','w','nt');

W_grid=reshape(w,dimJ,dimJ); V_grid=reshape(v,dimJ,dimJ); U_grid=reshape(u,dimJ,dimJ);
W_grid=W_grid'; V_grid=V_grid'; U_grid=U_grid';
% Plot solutions u and v
figure; pcolor(X,Y,U_grid);shading flat;colorbar;axis square xy;title('u')
figure; pcolor(X,Y,V_grid);shading flat;colorbar;axis square xy;title('v')
figure; pcolor(X,Y,W_grid);shading flat;colorbar;axis square xy;title('w')