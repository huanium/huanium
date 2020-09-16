% This function simulates solves a nonlinear reaction-diffusion model
% with two variables, each of which is a function of both time and
% position. Turing patterns emerge under appropriate conditions.
%
% Inputs: a and b are model parameters 
%    and nt is the number of time steps
% Outputs: u and v are chemical concentrations, 
%    with each row referring to a particular time and
%    each column referring to a particular position.
%       x and t, respectively, are position and time lists.


a = 1;
b = 4;

[u,v,x,t] = Turing(a,b,4e3);

plot(t,u(:,40),'.');



% a = 0:0.01:3; 
% Du = 1; 
% Dv = 5;
% plot(a, (1 + a.^2), a, (1 + a*sqrt(Du/Dv)).^2); 
% axis([0,3,0,5]);
% hold on
% plot(x,u(end,:),'.');
% plot(x,u(500,:));
% plot(x,u(100,:));
% plot(x,u(50,:));





function [u,v,x,t] = Turing(a,b,nt)

% Let's assume the diffusion constant in the first equation equals 1
% and choose the diffusion constant in the second equation to be:
d = 5;

% Now assume our spatial domain has length L
% and subdivide it into nx steps
L = 2*pi*10;
nx = 400; dx = L/nx;
x = 0:dx:nx*dx;

% Next, we need to choose a time step and how long to run the code
dt = 5*(dx^2);
t = 0:dt:nt*dt;

% Set up results arrays, adding a phantom node on either side
u = zeros(nt+1,nx+3);
v = zeros(nt+1,nx+3);

% The initial condition will be the steady state, plus some noise
u(1,2:nx+2) = a + rand(1,nx+1)*a/100;
v(1,2:nx+2) = b/a + rand(1,nx+1)*b/a/100;

% Enforce boundary conditions
u(1,1) = u(1,2); u(1,nx+3) = u(1,nx+2);
v(1,1) = v(1,2); v(1,nx+3) = v(1,nx+2);

% Create matrix that defines step k in terms of step k+1
ru = dt/(dx^2);
Lu = toeplitz([1+2*ru, -ru, zeros(1,nx-1)]);
Lu(1,1) = 1+ru; Lu(nx+1,nx+1) = 1+ru;
rv = d*dt/(dx^2);
Lv = toeplitz([1+2*rv, -rv, zeros(1,nx-1)]);
Lv(1,1) = 1+rv; Lv(nx+1,nx+1) = 1+rv;

% Now loop
for j = 1:nt
    
    f = a - (b + 1)*u(j,2:nx+2) + (u(j,2:nx+2).^2).*v(j,2:nx+2);
    g = b*u(j,2:nx+2) - (u(j,2:nx+2).^2).*v(j,2:nx+2);
    
    rhs_u = (u(j,2:nx+2) + dt*f)';
    rhs_v = (v(j,2:nx+2) + dt*g)';

    u(j+1,2:nx+2) = linsolve(Lu,rhs_u)';
    v(j+1,2:nx+2) = linsolve(Lv,rhs_v)';

    u(j+1,1) = u(j+1,2);
    u(j+1,nx+3) = u(j+1,nx+2);
    v(j+1,1) = v(j+1,2);
    v(j+1,nx+3) = v(j+1,nx+2);
    
end

% Drop phantom nodes
u = u(:,2:nx+2);
v = v(:,2:nx+2);

end