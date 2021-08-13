% Author: Huan Q. Bui
% August 12, 2021

% Simulates the (approximate) magnetic field in 
% the Ioffe-Pritchard trap, to 3rd order


% We have 4 sets of coils:
% BI: Big Ioffe coils
% SI: Small Ioffe coils
% PI: Pinch coils
% CO: Compensation coils


% LIST OF ALL CONSTRAINTS
% 1.   a_BI = \sqrt{4/3}*d_BI
% 2.   a_SI = \sqrt{4/3}*d_SI
% 3.   a_PI = \sqrt{4/3}*d_PI (not required to the produce the field, but 
%                              recommended to improve performance)
% 4.   a_CO = 2*d_CO
% (*)  I_BI*G_BI = I_SI*G_SI --> NOT a geometrical constraint. 
% This constraint ^ is set by fixing the current ratio to the G-ratio. 

% after applying all constraints, we are left with
% 4x3 - 4 = 8 DOFs
% 4 DOFs are geometrical
% 4 DOFs are currents --> these change, but geometrical factors are fixed

% FOR CONVENIENCE, 4 dofs ARE:
% 1. delta
% 2. J_SI
% 3. J_PI
% 4. N

% physical constants
mu0 = 0.4*pi;
gamma = 32.1308947; %gamma = g_f * mu_f * mu_B / m_Rb87 @ CGS; 

% winding number, fixed 
N = 16; 

% coil radii
a_BI = 5.2;
a_SI = 3.463999;
a_PI = 2.5;
a_CO = 5;

% coil displacement
d_BI = a_BI/sqrt(4/3); % constraint (1)
d_SI = a_SI/sqrt(4/3); % constraint (2)
d_PI = a_PI/sqrt(4/3); % constraint (3)
d_CO = a_CO/2;         % constraint (4)

% compute geometrical factors:

% BI coils
F_BI = a_BI^2/((a_BI^2+d_BI^2)^(3/2));
G_BI = 3*d_BI*a_BI^2/(2*(a_BI^2+d_BI^2)^(5/2));
H_BI = 3*a_BI^2*(4*d_BI^2-a_BI^2)/((a_BI^2+d_BI^2)^(7/2));
I_BI = (5*a_BI^2*d_BI*(4*d_BI^2-3*a_BI^2))/(2*(a_BI^2 + d_BI^2)^(9/2));

% SI coils
F_SI = a_SI^2/((a_SI^2+d_SI^2)^(3/2));
G_SI = 3*d_SI*a_SI^2/(2*(a_SI^2+d_SI^2)^(5/2));
H_SI = 3*a_SI^2*(4*d_SI^2-a_SI^2)/((a_SI^2+d_SI^2)^(7/2));
I_SI = (5*a_SI^2*d_SI*(4*d_SI^2-3*a_SI^2))/(2*(a_SI^2 + d_SI^2)^(9/2));

% PI coils
F_PI = a_PI^2/((a_PI^2+d_PI^2)^(3/2));
G_PI = 3*d_PI*a_PI^2/(2*(a_PI^2+d_PI^2)^(5/2));
H_PI = 3*a_PI^2*(4*d_PI^2-a_PI^2)/((a_PI^2+d_PI^2)^(7/2));
I_PI = (5*a_PI^2*d_PI*(4*d_PI^2-3*a_PI^2))/(2*(a_PI^2 + d_PI^2)^(9/2));

% CO coils
F_CO = a_CO^2/((a_CO^2+d_CO^2)^(3/2));
G_CO = 3*d_CO*a_CO^2/(2*(a_CO^2+d_CO^2)^(5/2));
H_CO = 3*a_CO^2*(4*d_CO^2-a_CO^2)/((a_CO^2+d_CO^2)^(7/2));
I_CO = (5*a_CO^2*d_CO*(4*d_CO^2-3*a_CO^2))/(2*(a_CO^2 + d_CO^2)^(9/2));

% setting delta first makes things easier:
delta = 5; % Gauss

% first sim
J_SI = N*50; % Amperes
J_PI = N*12; % Amperes

% % second sim
% delta = 0.5;
% J_SI = N*20;
% J_BI = N*35.5;
% J_PI = N*5.4;

% calculate these to fit parameters
J_CO = (F_PI/F_CO)*J_PI - delta/(mu0*F_CO); % Amperes
J_BI = J_SI*G_SI/G_BI; % constraint (*)



% input params for BFullField
beta   = mu0*J_PI*H_PI - mu0*J_CO*H_CO;
alpha  = 3*mu0*J_BI*G_BI; % = 3*mu_0*J_SI*G_SI
% delta  = N*mu0*J_PI*F_PI - mu0*J_CO*F_CO; % already defined

% finally, compute trap parameters:
Omega_Z   =  sqrt(gamma*mu0*J_PI*H_PI);
Omega_Rho =  sqrt(gamma*mu0*( 9*J_BI^2*G_BI^2/(J_PI*F_PI-J_CO*F_CO) - J_PI*H_PI/2 )); 
aspect_ratio = Omega_Rho/Omega_Z;


%%%%%%% DISPLAY STUFF %%%%%%

disp('-----------------------')
% trap parameters
disp(['Omega_Z: ' num2str(Omega_Z) ' rad/s']);
disp(['Omega_Rho: ' num2str(Omega_Rho) ' rad/s']);
disp(['Aspect Ratio: ' num2str(aspect_ratio)]);

disp('-----------------------')
% delta, beta, alpha
disp(['delta: ' num2str(delta) ' G']);
disp(['alpha: ' num2str(alpha) ' G/cm']);
disp(['beta: ' num2str(beta) ' G/cm^2']);

disp('-----------------------')
% output currents
disp(['J_BI: ' num2str(J_BI/N) ' A']);
disp(['J_SI: ' num2str(J_SI/N) ' A']);
disp(['J_CO: ' num2str(J_CO/N) ' A']);
disp(['J_PI: ' num2str(J_PI/N) ' A']);

disp('-----------------------')
% output radii
disp(['a_BI: ' num2str(a_BI) ' cm']);
disp(['a_SI: ' num2str(a_SI) ' cm']);
disp(['a_CO: ' num2str(a_CO) ' cm']);
disp(['a_PI: ' num2str(a_PI) ' cm']);

disp('-----------------------')
% output displacements
disp(['d_BI: ' num2str(d_BI) ' cm']);
disp(['d_SI: ' num2str(d_SI) ' cm']);
disp(['d_CO: ' num2str(d_CO) ' cm']);
disp(['d_PI: ' num2str(d_PI) ' cm']);

disp('-----------------------')


%%% FIRST SIM: PLOTTING STUFF in single axis %%%
res = 0.05;
x_bound = 2;
y_bound = 2;
z_bound = 2;
x = -x_bound:res:x_bound;
y = -y_bound:res:y_bound;
z = -z_bound:res:z_bound;
[X,Y,Z] = meshgrid(x,y,z);

[B_x, B_y, B_z] = B(delta, alpha, beta, X, Y, Z);


f1 = figure(1);
subplot(3,1,1)
Bxx = B_x(floor(end/2)+1,:,floor(end/2)+1);
plot(x, abs(squeeze(Bxx)));
xlabel('X (cm)')
ylabel('|Bx| in Gauss')
title('Field strength in X with Y=Z=0')

subplot(3,1,2)
Byy = B_y(:,floor(end/2)+1,floor(end/2)+1);
plot(y, abs(squeeze(Byy)));
xlabel('Y (cm)')
ylabel('|By| in Gauss')
title('Field strength in Y with X=Z=0')

subplot(3,1,3)
Bzz = B_z(floor(end/2)+1,floor(end/2)+1,:);
plot(z, abs(squeeze(Bzz)));
xlabel('Z')
ylabel('|Bz| in Gauss')
title('Field strength in Z with X=Y=0')



%%% SECOND SIM: PLOTTING STUFF in Planes %%%
f2 = figure(2);
BTotal = sqrt(B_x.^2 + B_y.^2 + B_z.^2);
subplot(3,1,1)
B_YZ = BTotal(floor(end/2)+1,:,:);
surf(y,z,abs(squeeze(B_YZ)), 'LineStyle', 'none');
view(2)
xlabel('Z (cm)')
ylabel('X (cm)')
title('|B| through x, in YZ plane')

subplot(3,1,2)
B_XZ = BTotal(:,floor(end/2)+1,:);
surf(x,z,abs(squeeze(B_XZ)), 'LineStyle', 'none');
view(2)
xlabel('Z (cm)')
ylabel('Y (cm)')
title('|B| through y, in XZ plane')

subplot(3,1,3)
B_XY = BTotal(:,:,floor(end/2)+1);
surf(x,y,abs(squeeze(B_XY)), 'LineStyle', 'none');
view(2)
xlabel('X (cm)')
ylabel('Y (cm)')
title('|B| through z, in XY plane')




%%% Compute approximate field %%% 

function [BX, BY, BZ] = B(delta, alpha, beta, X, Y, Z)
    BX =  alpha.*X -(1/2).*beta.*X.*Z;
    BY = -alpha.*Y -(1/2).*beta.*Y.*Z;
    BZ = delta + (1/2).*beta.*(Z.^2 -X.^2./2 -Y.^2./2);
end


