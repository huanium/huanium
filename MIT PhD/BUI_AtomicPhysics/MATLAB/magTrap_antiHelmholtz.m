% Author: Huan Q. Bui
% Date: August 10, 2021

% SIMULATE Anti-Helmholtz magnetic field

clear

mu0 = 4*pi*10^(-7);
I = 10; % current in each coil, in Amperes
N = 16; % winding number
a = 0.2; % coil radius, in m
b = 0.15; % 1/2 distance between coils, in m
C = 3*mu0*I*a^2*b/(2*(a^2 + b^2)^(5/2)); % constant

x_bound = 1;
y_bound = 1;
z_bound = 1;
spacing = 0.05;

x = -x_bound:spacing:x_bound;
y = -y_bound:spacing:y_bound;
z = -z_bound:spacing:z_bound;

[X,Y,Z] = meshgrid(x,y,z);

% magnetic fields formula
% Bfield = @(x,y,z) [C.*x C.*y -2*C.*z]; 
% Bfield_XZ = @(x,z) [C.*x -2*C.*z];

h = figure(1)

% magnetic field in XZ plane
subplot(3,1,1)
quiver(X,Z,C.*X,-2*C.*Z);
xlabel('X (m)')
ylabel('Z (m)')
title('Field in XZ plane, Y=0')
xlim([-x_bound x_bound])
ylim([-z_bound z_bound])


subplot(3,1,2)
% magnetic field in YZ plane
quiver(Y,Z,C.*Y,-2*C.*Z);
xlabel('Y (m)')
ylabel('Z (m)')
title('Field in YZ plane, X=0')
xlim([-y_bound y_bound])
ylim([-z_bound z_bound])

subplot(3,1,3)
% magnetic field in XY plane
quiver(X,Y,C.*X,C.*Y);
xlabel('X (m)')
ylabel('Y (m)')
title('Field in XY plane, Z=0')
xlim([-x_bound x_bound])
ylim([-y_bound y_bound])


% Magnetic field strengths in 2D
g = figure(2)

subplot(3,1,1)
[X_XZ,Z_XZ] = meshgrid(x,z);
B_strength_XZ = sqrt((C.*X_XZ).^2  + (-2*C.*Z_XZ).^2);
surfc(X_XZ,Z_XZ,B_strength_XZ,'LineStyle' ,'none');
view(2)
xlabel('X (m)')
ylabel('Z (m)')
title('Field strength (T) in XZ, Y=0')

subplot(3,1,2)
[Y_YZ,Z_YZ] = meshgrid(y,z);
B_strength_YZ = sqrt((C.*Y_YZ).^2  + (-2*C.*Z_YZ).^2);
surfc(Y_YZ,Z_YZ,B_strength_YZ,'LineStyle' ,'none');
view(2)
xlabel('Y (m)')
ylabel('Z (m)')
title('Field strength (T) in YZ, X=0')

subplot(3,1,3)
[X_XY,Y_XY] = meshgrid(x,y);
B_strength_XY = sqrt((C.*X_XY).^2  + (-2*C.*Y_XY).^2);
surfc(X_XY,Y_XY,B_strength_XY,'LineStyle' ,'none');
view(2)
xlabel('X (m)')
ylabel('Y (m)')
title('Field strength (T) in XY, Z=0')

% magnetic field strengths in 1D
k = figure(3)
% X=0,Y=0
subplot(3,1,1)
plot(z,abs(-2*C.*z))
xlabel('Z (m)')
ylabel('B (T)')
title('Field strength in Z')
% Y=0,Z=0
subplot(3,1,2)
plot(x, abs(C.*x))
xlabel('X (m)')
ylabel('B (T)')
title('Field strength in X')
% X=0,Z=0
subplot(3,1,3)
plot(y, abs(C.*y))
xlabel('Y (m)')
ylabel('B (T)')
title('Field strength in Y')
