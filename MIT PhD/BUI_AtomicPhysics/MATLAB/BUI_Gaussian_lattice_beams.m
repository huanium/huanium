%%% Author: Huan Q. Bui
%%% July 13, 2021
%%% interference of Gaussian beams at substrate surface

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% UPDATES REQUIRED %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Do we worry about phase accumulation as beams move? %%%
%%%%%% Need to add the reflection of the retro beam %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% July 15, 2021: 
%%% There is a focusing lens near the retro so that the
%%% focus of the retro beam should be close to focus of the reflection of the 
%%% incoming beam.
%%% This means the focus of the retro beam is in front of the mirror now.
%%% For simplicity, we'll just set this focus to be the focus of the
%%% incomng beam (as guaranteed by fiber coupling). The angle of the retro
%%% beam, for simplicity, will be set as the angle of the reflection of the
%%% incoming beam

%%% basically this means that, with perfect retro alignment, the retro beam
%%% is exactly the reflected beam. So the question becomes what happens
%%% when the retro is not well-aligned? For this we'll need to know what
%%% and where the focusing lens is.

%%% Need to compute the intensity gradient of the layer with the atoms




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
global focusX; % waist location along X
global focusZ; % waist location along Z
global focusY;
%%% retro mirror position and angle
global retro_X_intercept
global retro_angle % relative to horizontal



%%%%% SETTING UP %%%%%
wavelength= 1064e-9; % in meters
w0_x = 40e-6; % beam waist (in X) in meters
w0_y = 140e-6; % beam waist (in Y) in meters
n = 1; % of air
zR_x = pi*w0_x^2*n/wavelength; % Rayleigh range X
zR_y = pi*w0_y^2*n/wavelength; % Rayleigh range Y
theta_X = wavelength/(n*w0_x); % beam divergence in X, in rads
theta_Y = wavelength/(n*w0_y); % beam divergence in X, in rads
theta_inc_X = -10.8*pi/180; % 10.8 degs from horizontal

% focus point defined along path of incoming beam 
focusZ = 3e-3; % Z-position of focus (5mm above surface)
% set X-position of focus so that the reflection occurs at the origin
focusX = cot(-theta_inc_X)*focusZ;  % X-position of focus
focusY = 0;

% retro mirror parameters
retro_X_intercept = 0.75e-3; % kinda far from incidence spot
retro_misalign = 0*pi/180; % deviation from perfect retroreflection
retro_angle = pi/2 + theta_inc_X; % gives perfect retro-reflection
retro_angle = retro_angle - retro_misalign;

% input range 
res_Z = 5e-9; % resolution Z
res_X = 1e-7; % resolution X
res_Y = 1e-7;
x_bound = 200e-6;
y_bound = 200e-6;
z_bound = 2e-5;
x = -x_bound:res_X:x_bound;
z = -z_bound:res_Z:0;
y = -y_bound:res_Y:y_bound;
%z = -13e-6:res_Z:-12.5e-6; % THIS IS THE LAYER WHERE THE ATOMS ARE
[X, Z] = meshgrid(x, z);

Efield = @E;
% rotate coords, then make E field (incoming)
% incoming beam, start with original w0 and zR
E_inc = Efield(w0_x, zR_x, new_X(X-focusX,Z-focusZ,theta_inc_X),...
    new_Z(X-focusX,Z-focusZ,theta_inc_X));

% reflection of incoming beam 
[eff_focus_X_refl, eff_focus_Z_refl, theta_inc_refl] = refl_focus(theta_inc_X);
E_refl = Efield(w0_x, zR_x, new_X(X-eff_focus_X_refl,Z-eff_focus_Z_refl,...
    theta_inc_refl),new_Z(X-eff_focus_X_refl,Z-eff_focus_Z_refl,theta_inc_refl));

% retro beam: without focusing lens on retroreflection
% [eff_focus_X_retro, eff_focus_Z_retro, theta_reflection] = retro_focus();
% E_ret = Efield(w0, zR, new_X(X-eff_focus_X_retro,Z-eff_focus_Z_retro,-theta_reflection),...
%     new_Z(X-eff_focus_X_retro,Z-eff_focus_Z_retro,-theta_reflection));

% retro beam: with focusing lens + perfect alignment: E_ret = E_refl
E_ret = E_refl;
    
% relection of retro beam: with focusing lens + perfect alignment
% E_ret_refl = E_inc
E_ret_refl = E_inc;

% E must be 0 at surface, so phases of reflections are reversed
pattern = abs(E_inc - E_refl - E_ret + E_ret_refl).^2;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% PLOTTING %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h = figure(1);
h.Position = [200 -10 800 800];
% top view of surface plot to look at XZ plane
subplot(3,1,1)
surf(X,Z,pattern, 'LineStyle', 'none', 'EdgeAlpha', 0 , 'FaceAlpha',1);
colormap('gray');
ylim([-z_bound 0]); % this sets the 'Z' bound...
view([0,90])
xlabel('X (m)')
ylabel('Z (m)')
title({['Gaussian beam waist: ' num2str(w0_x) ' m, Wavelength: ' num2str(wavelength) ' m'],...
    ['Incidence: ' num2str(-theta_inc_X*180/pi)...
    ' degs, Focus: X = ' num2str(round(focusX,3)) ' m, Z = ' num2str(focusZ) ' m']});

% % side view
% subplot(3,1,2)
% surf(X,Z,pattern, 'LineStyle', 'none', 'EdgeAlpha', 0 , 'FaceAlpha',1);
% view([270,0])
% colormap('gray');
% title('Side view');
% xlabel('X (m)')
% ylabel('Z (m)')
% zlabel('Intensity (a.u.)')

% zoom in close to atom layer near surface
subplot(3,1,2)
surf(X,Z,pattern, 'LineStyle', 'none', 'EdgeAlpha', 0 , 'FaceAlpha',1);
colormap('gray');
%z = -13e-6:res_Z:-12.5e-6; % THIS IS THE LAYER WHERE THE ATOMS ARE
ylim([-14e-6 -11.5e-6]); % this sets the 'Z' bound...
view([0,90])
xlabel('X (m)')
ylabel('Z (m)')
title('Zoom in to atom layer near surface, z~13e-6 m (~3rd layer)')

% % slice at x = 0
% subplot(4,1,3)
% x0_data = pattern(:,floor(x_bound/res_X + 1));
% plot(z,x0_data);
% xlim([-z_bound 0])
% title('Intensity profile across x = 0.')
% set ( gca, 'xdir', 'reverse' )
% xlabel('Z (m)')
% ylabel('Intensity (a.u.)')


% Z position of max intensity across X
subplot(3,1,3)
z_interest = -14e-6:res_Z:-11.5e-6;
[max_longX, indexZ] = max(pattern(floor((z_bound+z_interest)/res_Z+1),:));
plot(x,z_interest(indexZ));
xlabel('X (m)')
ylabel('Z_{max} (m)')
title('Z position of max intensity across X')





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


% rotation in the X-Z plane to do incidence
function new_X = new_X(X,Z,theta)
    new_X = cos(theta).*X - sin(theta).*Z;
end

function new_Z = new_Z(X,Z,theta)
    new_Z = sin(theta).*X + cos(theta).*Z;
end

% work out where imaged focus point is 
function [eff_focus_X, eff_focus_Z, theta_reflection] = retro_focus(theta_inc_X)
    global retro_X_intercept
    global retro_angle 
    global focusX
    global focusZ
    
    % incident beam center
    % focus_Z = tan(-theta_inc_X)*(focus_X - x_inter)
    x_inter_incident = focusX - focusZ/tan(-theta_inc_X);
    z_inter_incident = tan(-theta_inc_X)*(0-x_inter_incident);
    
    % reflected beam center is given by 
    % z(x) = tan(theta_inc_X)*(x - x_inter_incident);
    
    % this beam intersects with the mirror, given by 
    % z(x) = tan(retro_angle)*(x - retro_X_intercept);
    
    % so the intersection is given by 
    x_intersection = retro_X_intercept/(1-tan(theta_inc_X)/tan(retro_angle));
    z_intersection = tan(retro_angle)*(x_intersection - retro_X_intercept);
    
    % to find the location of the imaged focus point, we have to find the
    % image of the focus point of the incident beam due to the mirror
    % this is just flipping the focus point along the horizon:
    
    focusX_prime = focusX;
    focusZ_prime = -focusZ;
    
    % now we reflect the point above through the line defined by the mirror
    m = tan(retro_angle);
    c = (x_intersection*0-retro_X_intercept*z_intersection)/(x_intersection-retro_X_intercept);
    d = (focusX_prime + (focusZ_prime - c)*m)/(1 + m^2);
    eff_focus_X = 2*d - focusX_prime;
    eff_focus_Z = 2*d*m - focusZ_prime + 2*c;
    theta_reflection = atan((eff_focus_Z-z_intersection)/(eff_focus_X-x_intersection));
end


% effective focus point for reflection of incoming beam 
function [eff_focus_X_refl, eff_focus_Z_refl, theta_inc_refl] = refl_focus(theta_inc_X)
    global focusX
    global focusZ
    
    % obtained by just flipping the incoming focus point around horz
    eff_focus_X_refl = focusX;
    eff_focus_Z_refl = -focusZ;
    theta_inc_refl = -theta_inc_X;
    
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
function E_field = E(w0, zR, x, z)
    % beam propagates mostly in the x direction, so "z" in defns become "x"
    global wavelength
    k = 2*pi/wavelength;
    % electric field in 1 transverse dimension only 
    E_field = 1i.*sqrt(1./(sqrt(pi).*w0)).*(zR./q(abs(x),zR))...
        .*exp(-1i.*k.*z.^2./(2.*q(abs(x),zR))-1i.*k.*x);
end


function E_3d = E_field_3d(w0_x,w0_y, zR_x, zR_y, x,y,z)
    % beam propagates mostly in the x direction
    global wavelength
    k = 2*pi/wavelength;
    % electric field in 1 transverse dimension only 
    E_field_x = E_field(w0_x, zR_x, x, z);
    E_field_y = E_field(w0_y, zR_y, y, z);
    
    E_3d = E_field_x*E_field_y;
end




