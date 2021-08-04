%%% Gross-Pitaevskii Equation Solver
%%% Author: Huan Q. Bui


%%% Physical constants
global hbar;
global mNa;
global rBohr;
global DIM;
global N;
global a_s; 
global g;
global eps;
global grid_range;
global dx;
global dy;

hbar = 1.0545718e-34;
mNa = 3.817540787e-26;
rBohr = 5.29e-11;
DIM = 100;
N = 1e3;
a_s = 100*rBohr;
g = N*4*pi*(hbar^2)*(a_s/mNa);
eps = 0;
grid_range = 15e-6;


%%% REAL SPACE GRID %%%
x = linspace(-grid_range, grid_range, DIM);
y = linspace(-grid_range, grid_range, DIM);
[X,Y] = meshgrid(x,y);
dx = x(2) - x(1);
dy = y(2) - y(1);
Lx = max(x) - min(x);
Ly = max(y) - min(y);
dV = dx*dy;
R_squared = X.^2 + Y.^2;
R = sqrt(R_squared);
phi = atan2(Y,X);

%%% MOMENTUM SPACE GRID %%%
kx = 2*pi*fftfreq(length(x),dx);
ky = 2*pi*fftfreq(length(y),dy);
dkx = kx(2) - kx(1);
dky = ky(2) - ky(1);
Lkx = max(kx) - min(kx);
Lky = max(ky) - min(ky);
dVk = dkx*dky;
[kX, kY] = meshgrid(kx, ky);
k_squared = kx.^2 + ky.^2;
k_squared_cutoff = k_squared;

%%% Interactions and atoms




%%% Preparation functions
function Psi = init_Psi()
    global DIM
    Psi = (1+0i)*zeros(DIM,DIM);
    
end

function f=fftfreq(npts,dt)
    fmin = -1/(2*dt);
    df = 1/(npts*dt);
    f0 = -fmin;

    f = mod(linspace(0, 2*f0-df, npts)+f0,  2*f0)  - f0;
end