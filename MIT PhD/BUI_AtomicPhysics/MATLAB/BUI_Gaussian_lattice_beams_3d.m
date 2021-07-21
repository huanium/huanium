%%% Author: Huan Q. Bui
%%% July 20, 2021
%%% interference of Gaussian beams at substrate surface


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

global wavelength; % wavelength
global n; % index of refraction of air
global focusX; 
global focusZ_X; 
global focusZ_Y; 
global focusY;


%%%%% SETTING UP %%%%%
wavelength= 1064e-9; % in meters
w0_z = 40e-6; % beam waist (in X) in meters
w0_y = 135e-6; % beam waist (in Y) in meters
w0_x = 135e-6; % beam waist (in Y) in meters
n = 1; % of air
zR_z = pi*w0_z^2*n/wavelength; % Rayleigh range X
zR_y = pi*w0_y^2*n/wavelength; % Rayleigh range Y
zR_x = pi*w0_x^2*n/wavelength; % Rayleigh range Y
%theta_Z = wavelength/(n*w0_z); % beam divergence in X, in rads
%theta_Y = wavelength/(n*w0_y); % beam divergence in X, in rads
theta_inc_X = -10.8*pi/180; % 10.8 degs from horizontal
theta_inc_Y = -10.8*pi/180; % 10.8 degs from horizontal

% focus point defined along path of incoming beam 
focusZ_X = 3e-3; % Z-position of focus of X beam (3mm above surface)
focusZ_Y = 3e-3; % Z-position of focus of Y beam (3mm above surface)
% set X-position of focus so that the reflection occurs at the origin
focusX = cot(-theta_inc_X)*focusZ_X;  % X-position of focus of X
focusY = cot(-theta_inc_Y)*focusZ_Y;  % Y-position of focus of Y


% input range 
res_X = 4e-6; % resolution X
res_Y = 4e-6;
res_Z = 1.5e-8; % resolution Z
x_bound = 400e-6;
y_bound = 400e-6;
z_bound = 15e-6;
x = -x_bound:res_X:x_bound;
y = -y_bound:res_Y:y_bound;
z = -z_bound:res_Z:0;
%z = -13.5e-6:res_Z:-12e-6;
%z = -13e-6:res_Z:-12.5e-6; % THIS IS THE LAYER WHERE THE ATOMS ARE
[X, Y, Z] = meshgrid(x,y,z);

% X beam stuff
E_inc_X = E_3d_X(w0_z, w0_y ,zR_z, zR_y,...
    new_X(X-focusX, Z-focusZ_X, theta_inc_X),...
    Y, new_Z(X-focusX, Z-focusZ_X, theta_inc_X));

[eff_focus_X_refl, eff_focus_Z_refl, theta_inc_refl_X] = refl_focus(theta_inc_X, focusX , focusZ_X);

E_refl_X = E_3d_X(w0_z, w0_y, zR_z, zR_y,...
   new_X(X-eff_focus_X_refl,Z-eff_focus_Z_refl,theta_inc_refl_X),...
   Y, new_Z(X-eff_focus_X_refl,Z-eff_focus_Z_refl,theta_inc_refl_X));

% retro beam: with focusing lens + perfect alignment: E_ret = E_refl
E_ret_X = E_refl_X;
% relection of retro beam: with focusing lens + perfect alignment
E_ret_refl_X = E_inc_X;


% Y beam stuff
E_inc_Y = E_3d_Y(w0_z, w0_y ,zR_z, zR_y, ...
    X, new_X(Y-focusY, Z-focusZ_Y, theta_inc_Y), ...
    new_Z(Y-focusY, Z-focusZ_Y, theta_inc_Y));

[eff_focus_Y_refl, eff_focus_Z_refl, theta_inc_refl_Y] = refl_focus(theta_inc_Y, focusY, focusZ_Y);

E_refl_Y = E_3d_Y(w0_z, w0_y, zR_z, zR_y,...
    X, new_X(Y-eff_focus_Y_refl, Z-eff_focus_Z_refl, theta_inc_refl_Y), ...
    new_Z(Y-eff_focus_Y_refl, Z-eff_focus_Z_refl, theta_inc_refl_Y));

% retro beam: with focusing lens + perfect alignment: E_ret = E_refl
E_ret_Y = E_refl_Y;
% relection of retro beam: with focusing lens + perfect alignment
E_ret_refl_Y = E_inc_Y;


%pattern = abs(E_inc_X - E_refl_X - E_ret_X + E_ret_refl_X...
%   + E_inc_Y - E_refl_Y - E_ret_Y + E_ret_refl_Y).^2;

pattern = abs(E_inc_X - E_refl_X...
   + E_inc_Y - E_refl_Y).^2;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% PLOTTING %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h = figure(1);
h.Position = [200 -10 800 800];
% top view of surface plot to look at XZ plane
xslice = [0];   
yslice = [0];
zslice = [];
s = slice(X,Y,Z,pattern,xslice,yslice,zslice);
set(s, 'LineStyle', 'none')
xlabel('X (m)')
ylabel('Y (m)')
zlabel('Z (m)')
zlim([-z_bound 0]);
% colormap('gray');
title('Lattice')

% pattern(:,:,floor(end/2))

%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ');
% clock ends
%%%%%%%%%%%%%%%%%%%













%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% rotation in the X-Z and Y-Z plane to do incidence
function new_X = new_X(X,Z,theta)
    new_X = cos(theta).*X - sin(theta).*Z;
end

function new_Z = new_Z(X,Z,theta)
    new_Z = sin(theta).*X + cos(theta).*Z;
end



% effective focus point for reflection of incoming beam 
function [eff_focus_XY_refl, eff_focus_Z_refl, theta_inc_refl] = refl_focus(theta_inc, focusXY , focusZ)
    % obtained by just flipping the incoming focus point around horz
    eff_focus_XY_refl = focusXY;
    eff_focus_Z_refl = -focusZ;
    theta_inc_refl = -theta_inc; 
end

% complex beam parameter function
function beam_parameter_q = q(z, zR)
    % beam_parameter_q = 1/(1/R(z) - 1i*wavelength/(n*pi*w(z)^2));
    beam_parameter_q = z + 1i*zR; % equivalent defn
end

% Electric field function in cylindrical coords
% The Gouy phase is already included in this defn
% see page 8/44 of 
% http://ecee.colorado.edu/~ecen5616/WebMaterial...
% .../24%20Gaussian%20beams%20and%20Lasers.pdf
function E_field = E_3d_X(w0_z, w0_y, zR_z, zR_y, x,y,z)
    % beam propagates mostly in the x direction, so "z" in defns become "x"
    global wavelength
    k = 2*pi/wavelength;
    % electric field in 1 transverse dimension only 
    E_field = sqrt(1./(sqrt(pi).*w0_z)).*sqrt(1./(sqrt(pi).*w0_y)).*...
        (zR_z./q(abs(x),zR_z)).*(zR_y./q(abs(x),zR_y)).*...
        exp(-1i.*k.*z.^2./(2.*q(abs(x),zR_z))-1i.*k.*x).*...
        exp(-1i.*k.*y.^2./(2.*q(abs(x),zR_y))-1i.*k.*x);
end

function E_field = E_3d_Y(w0_z, w0_x, zR_z, zR_x, x,y,z)
    % beam propagates mostly in the x direction, so "z" in defns become "x"
    global wavelength
    k = 2*pi/wavelength;
    % electric field in 1 transverse dimension only 
    E_field = sqrt(1./(sqrt(pi).*w0_z)).*sqrt(1./(sqrt(pi).*w0_x)).*...
        (zR_z./q(abs(y),zR_z)).*(zR_x./q(abs(y),zR_x)).*...
        exp(-1i.*k.*z.^2./(2.*q(abs(y),zR_z))-1i.*k.*y).*...
        exp(-1i.*k.*x.^2./(2.*q(abs(y),zR_x))-1i.*k.*y);
end




