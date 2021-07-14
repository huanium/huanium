%%% Author: Huan Q. Bui
%%% July 13, 2021
%%% interference of Gaussian beams at substrate surface

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% UPDATES REQUIRED %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Do we worry about phase accumulation as beams move? %%%
%%%%%% Need to add the reflection of the retro beam %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%% Real Gaussian profiles %%%%%%%%%%%%%

global wavelength; % wavelength
global w0; % beam waist
global A0; % electric field amplitude
global zR; % Rayleigh range
global n; % index of refraction of air
global theta; % beam divergence
global focusX; % waist location along X
global focusZ; % waist location along Z
global theta_inc; % incoming beam incidence angle




%%%%% SETTING UP %%%%%
wavelength= 1064e-9; % in meters
w0 = 20e-6; % beam waist in meters
A0 = 20; % arbitrary...
n = 1; % of air
zR = pi*w0^2*n/wavelength;
theta = wavelength/(n*w0); % beam divergence, in rads
theta_inc = -5*pi/180; % 5 degs from horizontal
% focus point defined along path of incoming beam 
focusZ = 0*0.2e-4; % Z-position of focus
focusX = 0*0.5e-4;  % X-position of focus

%%% retro mirror position and angle
global retro_X_intercept
global retro_angle % relative to horizontal

retro_X_intercept = 0.75e-3; % kinda far from incidence spot
retro_misalign = 0*pi/180; % deviation from perfect retroreflection
retro_angle = pi/2 + theta_inc; % gives perfect retro-reflection
retro_angle = retro_angle - retro_misalign;

% input range 
res_Z = 2e-6; % resolution Z
res_X = 1e-5; % resolution X
x_bound = 2000e-6;
z_bound = 200e-6;
x = -x_bound:res_X:x_bound;
z = -z_bound:res_Z:z_bound;
[X, Z] = meshgrid(x, z);

Efield = @E;

% rotate coords, then make E field (incoming)

% incoming beam, start with original w0 and zR
E_inc = Efield(w0, zR, new_X(X-focusX,Z-focusZ,theta_inc),new_Z(X-focusX,Z-focusZ,theta_inc));

% reflection of incoming beam 
[eff_focus_X_refl, eff_focus_Z_refl, theta_inc_refl] = refl_focus();
E_refl = Efield(w0, zR, new_X(X-eff_focus_X_refl,Z-eff_focus_Z_refl,theta_inc_refl),...
    new_Z(X-eff_focus_X_refl,Z-eff_focus_Z_refl,theta_inc_refl));

% retro beam: how to calculate?
% need point of focus:
[eff_focus_X_retro, eff_focus_Z_retro, theta_reflection] = retro_focus();
E_ret = Efield(w0, zR, new_X(X-eff_focus_X_retro,Z-eff_focus_Z_retro,-theta_reflection),...
    new_Z(X-eff_focus_X_retro,Z-eff_focus_Z_retro,-theta_reflection));

% relection of retro beam
% to be continued



pattern = abs(E_inc +E_refl + E_ret).^2;

h = figure(1);
% top view
surf(X,Z,pattern, 'LineStyle', 'none', 'EdgeAlpha', 0 , 'FaceAlpha',1);
ylim([-z_bound z_bound]); % this sets the 'Z' bound...
view([0,90])
%h.Position = [100 100 800 800];
xlabel('X (m)')
ylabel('Z (m)')



%%%%% FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%



% rotation in the X-Z plane to do incidence
function new_X = new_X(X,Z,theta)
    new_X = cos(theta).*X - sin(theta).*Z;
end

function new_Z = new_Z(X,Z,theta)
    new_Z = sin(theta).*X + cos(theta).*Z;
end

% work out where imaged focus point is 
function [eff_focus_X, eff_focus_Z, theta_reflection] = retro_focus()
    global retro_X_intercept
    global retro_angle 
    global theta_inc
    global focusX
    global focusZ
    
    % incident beam center
    % focus_Z = tan(-theta_inc)*(focus_X - x_inter)
    x_inter_incident = focusX - focusZ/tan(-theta_inc);
    z_inter_incident = tan(-theta_inc)*(0-x_inter_incident);
    
    % reflected beam center is given by 
    % z(x) = tan(theta_inc)*(x - x_inter_incident);
    
    % this beam intersects with the mirror, given by 
    % z(x) = tan(retro_angle)*(x - retro_X_intercept);
    
    % so the intersection is given by 
    x_intersection = retro_X_intercept/(1-tan(theta_inc)/tan(retro_angle));
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
function [eff_focus_X_refl, eff_focus_Z_refl, theta_inc_refl] = refl_focus()
    global theta_inc
    global focusX
    global focusZ
    
    % obtained by just flipping the incoming focus point around horz
    eff_focus_X_refl = focusX;
    eff_focus_Z_refl = -focusZ;
    theta_inc_refl = -theta_inc;
    
end

% complex beam parameter function
function beam_parameter_q = q(z)
    % global wavelength
    % global n
    global zR
    % beam_parameter_q = 1/(1/R(z) - 1i*wavelength/(n*pi*w(z)^2));
    beam_parameter_q = z + 1i*zR; % equivalent defn
end

% Electric field function in cylindrical coords
% The Gouy phase is already included in this defn
% see page 8/44 of 
% http://ecee.colorado.edu/~ecen5616/WebMaterial...
% .../24%20Gaussian%20beams%20and%20Lasers.pdf
function E_field = E(w0, zR, x,z)
    % beam propagates mostly in the x direction
    global A0
    global wavelength
    k = 2*pi/wavelength;
    % electric field in 1 transverse dimension only 
    E_field = 1i.*A0.*sqrt(1./(sqrt(pi).*w0)).*(zR./q(sqrt(z.^2+x.^2)))...
        .*exp(-1i.*k.*z.^2./(2.*q(sqrt(z.^2+x.^2)))-1i.*k.*x);
end




