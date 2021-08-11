% Author: Huan Q. Bui
% Date: August 10, 2021

% SIMULATE TOP magnetic trap

clear

mu0 = 4*pi*10^(-7);
I = 1; % current in each coil, in Amperes
N = 16; % winding number
a = 0.2; % coil radius, in m
b = 0.15; % 1/2 distance between coils, in m
C = 3*mu0*I*a^2*b/(2*(a^2 + b^2)^(5/2)); % constant
B = 2*C;

x_bound = 10;
y_bound = 10;
z_bound = 10;
spacing = 0.1;

x = -x_bound:spacing:x_bound;
y = -y_bound:spacing:y_bound;
z = -z_bound:spacing:z_bound;

[X,Y,Z] = meshgrid(x,y,z);

% field strength formula:
% Bstrength = B + (C^2/(4*B))*(x^2 + y^2 + 8z^2);


% Magnetic field strengths in 2D
g = figure(1)

subplot(3,1,1)
[X_XZ,Z_XZ] = meshgrid(x,z);
B_strength_XZ = B + (C^2/(4*B))*(X_XZ.^2 + 8.*Z_XZ.^2);
surfc(X_XZ,Z_XZ,B_strength_XZ,'LineStyle' ,'none');
view(2)
xlabel('X (m)')
ylabel('Z (m)')
title('Field strength (T) in XZ, Y=0')

subplot(3,1,2)
[Y_YZ,Z_YZ] = meshgrid(y,z);
B_strength_YZ = B + (C^2/(4*B))*(Y_YZ.^2 + 8.*Z_YZ.^2);
surfc(Y_YZ,Z_YZ,B_strength_YZ,'LineStyle' ,'none');
view(2)
xlabel('Y (m)')
ylabel('Z (m)')
title('Field strength (T) in YZ, X=0')

subplot(3,1,3)
[X_XY,Y_XY] = meshgrid(x,y);
B_strength_XY = B + (C^2/(4*B))*(X_XY.^2 + Y_XY.^2);
surfc(X_XY,Y_XY,B_strength_XY,'LineStyle' ,'none');
view(2)
xlabel('X (m)')
ylabel('Y (m)')
title('Field strength (T) in XY, Z=0')

% magnetic field strengths in 1D
k = figure(2)
% X=0,Y=0
subplot(3,1,1)
plot(z,B + (C^2/(4*B)).*(8*z.^2))
xlabel('Z (m)')
ylabel('B (T)')
title('Field strength in Z')
% Y=0,Z=0
subplot(3,1,2)
plot(x, B + (C^2/(4*B)).*(x.^2))
xlabel('X (m)')
ylabel('B (T)')
title('Field strength in X')
% X=0,Z=0
subplot(3,1,3)
plot(y, B + (C^2/(4*B)).*(y.^2))
xlabel('Y (m)')
ylabel('B (T)')
title('Field strength in Y')
