%                  2D Simulation of the Brusselator
%clear
% Parameters
%A=0.4;%3;   %2.0;
%B=1.4;%10;  %5.2;
%D1=1e-6;
%D2=1e-6;
% Numerical Parameters
%n=101;
%m=101;
%dt=0.02;
tmax=8;
% Plotting Parameters
tplot=0.02;

% SET UP initial values
%x=linspace(0,1,n);
%y=linspace(0,1,m);
%[X,Y]=meshgrid(x,y);
%U=(2.5+2*(cos(2*pi*X)+sin(2*pi*Y)))';
%V=(3-1.5*(cos(2*pi*X)+sin(2*pi*Y)))';
%U=(A+0.1*(cos(5*pi*X)+sin(5*pi*Y)))';%(2.5+2*(cos(2*pi*X)+sin(4*pi*Y)))';
%V=(B/A+0.1*(cos(5*pi*X)+sin(5*pi*Y)))';%3-1.5*(cos(2*pi*X)+sin(4*pi*Y)))';
imghandle=imagesc(U);
%u=U(:);
%v=V(:);

% Get timestepping function handles
[getMatrices, stepper]=fastspirals(m,n);
[RHSu,RHSv,Lu,Lv,Uu,Uv,Pu,Pv]=getMatrices(dt,D1,D2);

t=0;
nsteps=0;
tp=tplot;
while t<tmax
   [u,v]=stepper(u,v,dt,A,B,RHSu,RHSv,Lu,Lv,Uu,Uv,Pu,Pv);
   t=t+dt;
   
   if t>tp
     U=reshape(u,m,n);
     set(imghandle,'CData',U);
     drawnow;
     tp=tp+tplot;
   end
end
disp('Simulation Ended')
