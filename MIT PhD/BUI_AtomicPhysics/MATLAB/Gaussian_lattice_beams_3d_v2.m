%%% Huan Q. Bui
%%% July 22, 2021
%%% interference of Gaussian beams at substrate surface 3D (v2)

%%% Assuming perfect retro reflection

%%% lattice spacing 541 nm
%%% 1000 atoms per image --> 30 by 30 
%%% size is 30*541 nm x 30*541 nm ~ 15 um x 15 um
%%% on camera: 1 atom ~ 3 pixels. Atom cloud is like 100 x 100 pixels
%%% so we have 30 atoms across --> 15 microns in size
%%% atom cloud is roughly the size of waist which is 40 um (~order of mag.)

clear
close all

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%



%%%%% Real Gaussian profiles %%%%%%%%%%%%%
%%%%% Here we have X- and Y- beams %%%%%%%

global wavelength; % wavelength
global n; % index of refraction. Assume n=1.
global res_X; % resolution in X
global res_Y; % resolution in Y
global res_Z; % resolution in Z



%%%%% SETTING UP %%%%%
wavelength= 1064e-9; % in meters
w0_vert = 40e-6; % "horz" beam waist 
w0_horz = 135e-6; % "vert" beam waist
n = 1;
zR_vert = pi*w0_vert^2*n/wavelength; % Rayleigh range Y
zR_horz = pi*w0_horz^2*n/wavelength; % Rayleigh range X
theta_inc_X = -10.8*pi/180; % 10.8 degs from horizontal
theta_inc_Y = -10.8*pi/180; % 10.8 degs from horizontal
X_beam_knob = 1;
Y_beam_knob = 1;

% focus point defined along path of incoming beam 
focusX_vert = 3e-3; % mm
focusY_vert = 0e-3; % mm


% input range 
% % for large lattice view
% res_X = 4e-6; % resolution X
% res_Y = 4e-6; % resolution Y
% res_Z = 2e-7; % resolution Z
% x_bound = 200e-6;
% y_bound = 200e-6;
% z_bound = 30e-6;
% z = -z_bound:res_Z:0;


% for layer view
res_X = 1e-7; % resolution X
res_Y = 1e-7; % resolution Y
res_Z = 1e-8; % resolution Z
x_bound = 15e-6;
y_bound = 15e-6;
z_low = -12.6e-6;
z_high = -11.5e-6;
z = z_low:res_Z:z_high;
% z = -13e-6:res_Z:-12.5e-6; % THIS IS THE LAYER WHERE THE ATOMS ARE

%%% Now set up
x = -x_bound:res_X:x_bound;
y = -y_bound:res_Y:y_bound;

[X, Y, Z] = meshgrid(x,y,z);


Ev = @(w0_vert, w0_horz, zR_vert, zR_horz, focus_vert, x,y,z, theta)...
    E_vert(w0_vert, w0_horz, zR_vert, zR_horz, focus_vert, x,y,z, theta);

Eh = @(w0_vert, w0_horz, zR_vert, zR_horz, focus_vert, x,y,z, theta)...
    E_horz(w0_vert, w0_horz, zR_vert, zR_horz, focus_vert, x,y,z, theta);

% X beam stuff
EX_vert_inc  = Ev(w0_vert, w0_horz, zR_vert, zR_horz, focusX_vert, Z,Y,X, theta_inc_X);
EX_vert_refl = Ev(w0_vert, w0_horz, zR_vert, zR_horz, focusX_vert, Z,Y,X, -theta_inc_X);

EX_horz_inc  = Eh(w0_vert, w0_horz, zR_vert, zR_horz, focusX_vert, Z,Y,X, theta_inc_X);
EX_horz_refl = Eh(w0_vert, w0_horz, zR_vert, zR_horz, focusX_vert, Z,Y,X, -theta_inc_X);

% Y beam stuff
EY_vert_inc  = Ev(w0_vert, w0_horz, zR_vert, zR_horz, focusY_vert, Z,X,Y, theta_inc_Y);
EY_vert_refl = Ev(w0_vert, w0_horz, zR_vert, zR_horz, focusY_vert, Z,X,Y, -theta_inc_Y);

EY_horz_inc  = Eh(w0_vert, w0_horz, zR_vert, zR_horz, focusY_vert, Z,X,Y, theta_inc_Y);
EY_horz_refl = Eh(w0_vert, w0_horz, zR_vert, zR_horz, focusY_vert, Z,X,Y, -theta_inc_Y);

% intensity in the vertical direction
Int_X_vert = abs(EX_vert_inc - EX_vert_refl).^2;
Int_Y_vert = abs(EY_vert_inc - EY_vert_refl).^2;

% intensity in the horizontal direction
Int_X_horz = abs(EX_horz_inc + EX_horz_refl).^2;
Int_Y_horz = abs(EY_horz_inc + EY_horz_refl).^2;


total_Intensity = Int_X_vert + 0*Int_X_horz + Int_Y_vert + 0*Int_Y_horz;
% total_Intensity = abs(EY_vert_inc).^2 + abs(EY_horz_inc).^2;

figure(1);
%h.Position = [200 -10 800 800];
xslice = [0];   
yslice = [0];
zslice = [];
s = slice(X,Y,Z,total_Intensity,xslice,yslice,zslice);
set(s, 'LineStyle', 'none')
xlabel('X (m)')
ylabel('Y (m)')
zlabel('Z (m)')
xlim([-x_bound x_bound])
ylim([-y_bound y_bound])
% zlim([-z_bound 0]);
% colormap('gray');
title('Intensity slices')


% max stuff
[maxInt, max_Z_index] = max(total_Intensity, [], 3);
[x_surf, y_surf] = meshgrid(x,y);

figure(2);
% contour of max Intensity
surfc(x_surf, y_surf, maxInt, 'LineStyle', 'none');
xlabel('X (m)')
ylabel('Y (m)')
zlabel('Max intensity (a.u.)')
xlim([-x_bound x_bound])
ylim([-y_bound y_bound])
title('Maximum lattice intensity over atom layer @ dimple')
%view(2)


figure(3)
% contour of gradient of potential
contourf(x_surf,y_surf,gradient(maxInt), 10 , 'LineStyle','none')
hold on
% impose contour of max intensity 
contour(x_surf,y_surf,maxInt./max(maxInt(:)),'Color','black','LineWidth',1)
hold off
xlabel('X (m)')
ylabel('Y (m)')
xlim([-x_bound x_bound])
ylim([-y_bound y_bound])
title('Contour of MaxInt + ContourF of grad(Intensity) @ dimple')
colorbar
axis equal

figure(4);
surf(x_surf, y_surf, z(max_Z_index), 'LineStyle', 'none');
xlabel('X (m)')
ylabel('Y (m)')
xlim([-x_bound x_bound])
ylim([-y_bound y_bound])
zlabel('Z of max intensity (m)')
title('Z-location of max intensity over atom layer @ dimple')
%view(2)
colorbar

%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ');
% clock ends
%%%%%%%%%%%%%%%%%%%








%%%%%%%%%% FUNCTIONS %%%%%%%%%%%%%%%%%%%

function E_horz = E_horz(w0_vert, w0_horz, zR_vert, zR_horz, focus_vert, x,y,z, theta)
    % horizontal component of E field
    x0 = x*cos(theta) + z*sin(theta) - 0;
    z0 = -x*sin(theta) + z*cos(theta) - focus_vert;
    E_horz = -sin(theta)*E(w0_vert, w0_horz, zR_vert, zR_horz, x0,y,z0);
end

function E_vert = E_vert(w0_vert, w0_horz, zR_vert, zR_horz, focus_vert, x,y,z, theta)
    % horizontal component of E field
    x0 = x*cos(theta) + z*sin(theta) - 0;
    z0 = -x*sin(theta) + z*cos(theta) - focus_vert;
    E_vert = cos(theta)*E(w0_vert, w0_horz, zR_vert, zR_horz, x0,y,z0);
end


% Electric field function in cylindrical coords
% The Gouy phase is already included in this defn
% see page 8/44 of 
% http://ecee.colorado.edu/~ecen5616/WebMaterial...
% .../24%20Gaussian%20beams%20and%20Lasers.pdf
function E_field = E(w0_vert, w0_horz, zR_vert, zR_horz, x,y,z)
    % beam propagates mostly in the z direction
    global wavelength
    k = 2*pi/wavelength;
    % electric field in 1 transverse dimension only 
    E_field = sqrt(1./(sqrt(pi).*w0_vert)).*sqrt(1./(sqrt(pi).*w0_horz)).*...
        (zR_vert./q(z,zR_vert)).*(zR_horz./q(z,zR_vert)).*...
        exp(-1i.*k.*x.^2./(2.*q(z,zR_vert))-1i.*k.*z).*...
        exp(-1i.*k.*y.^2./(2.*q(z,zR_horz))-1i.*k.*z);
end

% complex beam parameter function
function beam_parameter_q = q(z, zR)
    % beam_parameter_q = 1/(1/R(z) - 1i*wavelength/(n*pi*w(z)^2));
    beam_parameter_q = z + 1i*zR; % equivalent defn
end


