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
global w0; % beam waist
global A0; % electric field amplitude
global zR; % Rayleigh range
global n; % index of refraction of air
global theta; % beam divergence
global focusX; % waist location along X
global focusZ; % waist location along Z
global theta_inc; % incoming beam incidence angle
%%% retro mirror position and angle
global retro_X_intercept
global retro_angle % relative to horizontal



%%%%% SETTING UP %%%%%
wavelength= 1064e-9; % in meters
w0 = 40e-6; % beam waist in meters
A0 = 1; % arbitrary...
n = 1; % of air
zR = pi*w0^2*n/wavelength;
theta = wavelength/(n*w0); % beam divergence, in rads
theta_inc = -10.8*pi/180; % 5 degs from horizontal

% focus point defined along path of incoming beam 
focusZ = 5e-3; % Z-position of focus (5mm above surface)
% set X-position of focus so that the reflection occurs at the origin
focusX = cot(-theta_inc)*focusZ;  % X-position of focus

% retro mirror parameters
retro_X_intercept = 0.75e-3; % kinda far from incidence spot
retro_misalign = 0*pi/180; % deviation from perfect retroreflection
retro_angle = pi/2 + theta_inc; % gives perfect retro-reflection
retro_angle = retro_angle - retro_misalign;

% input range 
res_Z = 1e-9; % resolution Z
res_X = 2e-6; % resolution X
x_bound = 400e-6;
z_bound = 10e-5;
x = -x_bound:res_X:x_bound;
z = -z_bound:res_Z:0;
%z = -13e-6:res_Z:-12.5e-6; % THIS IS THE LAYER WHERE THE ATOMS ARE
[X, Z] = meshgrid(x, z);

Efield = @E;
% rotate coords, then make E field (incoming)
% incoming beam, start with original w0 and zR
E_inc = Efield(w0, zR, new_X(X-focusX,Z-focusZ,theta_inc),new_Z(X-focusX,Z-focusZ,theta_inc));

% reflection of incoming beam 
[eff_focus_X_refl, eff_focus_Z_refl, theta_inc_refl] = refl_focus();
E_refl = Efield(w0, zR, new_X(X-eff_focus_X_refl,Z-eff_focus_Z_refl,theta_inc_refl),...
    new_Z(X-eff_focus_X_refl,Z-eff_focus_Z_refl,theta_inc_refl));

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
subplot(4,1,1)
surf(X,Z,pattern, 'LineStyle', 'none', 'EdgeAlpha', 0 , 'FaceAlpha',1);
colormap('gray');
ylim([-z_bound 0]); % this sets the 'Z' bound...
view([0,90])
xlabel('X (m)')
ylabel('Z (m)')
title({['Gaussian beam waist: ' num2str(w0) ' m, Wavelength: ' num2str(wavelength) ' m'],...
    ['Incidence: ' num2str(-theta_inc*180/pi)...
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
subplot(4,1,2)
surf(X,Z,pattern, 'LineStyle', 'none', 'EdgeAlpha', 0 , 'FaceAlpha',1);
colormap('gray');
%z = -13e-6:res_Z:-12.5e-6; % THIS IS THE LAYER WHERE THE ATOMS ARE
ylim([-14e-6 -11.5e-6]); % this sets the 'Z' bound...
view([0,90])
xlabel('X (m)')
ylabel('Z (m)')
title('Zoom in to atom layer near surface, z~13e-6 m (~3rd layer)')

% slice at x = 0
subplot(4,1,3)
x0_data = pattern(:,floor(x_bound/res_X));
plot(z,x0_data);
xlim([-z_bound 0])
title('Intensity profile across x = 0.')
set ( gca, 'xdir', 'reverse' )
xlabel('Z (m)')
ylabel('Intensity (a.u.)')

subplot(4,1,4)
% slice at x = 0 near atom layer
% pick center x=0 and look at z data there
x_interest0 = 0;
x0_data = pattern(:,floor((x_bound+x_interest0)/res_X));
[m0, i0] = max(x0_data);
disp(['Max intensity at x = ' num2str(x_interest0) 'm = ' num2str(m0)]);
% z-position of max intensity
disp(['z = ' num2str(i0) 'm']);
disp('-----')
plot(z,x0_data);
xlim([-14e-6 -11.5e-6])

hold on
% pick x=?, and look at intensity data there
x_interest1 = 0 - 2e-4; 
x1_data = pattern(:,floor((x_bound+x_interest1)/res_X));
[m1, i1] = max(x1_data);
disp(['Max intensity at x = ' num2str(x_interest1) 'm = ' num2str(m1)]);
% z-position of max intensity
disp(['z = ' num2str(i1) 'm']);
disp('-----')
plot(z,x1_data);
xlim([-14e-6 -11.5e-6])
hold on
% pick x=?, and look at intensity data there
x_interest2 = 0 + 2e-4; 
x2_data = pattern(:,floor((x_bound+x_interest2)/res_X));
[m2, i2] = max(x2_data);
disp(['Max intensity at x = ' num2str(x_interest2) 'm = ' num2str(m2)]);
% z-position of max intensity
disp(['z = ' num2str(i2) 'm']);
disp('-----')
plot(z,x2_data);
xlim([-14e-6 -11.5e-6])
hold off

title('Intensity profile across near atom layer.')
set ( gca, 'xdir', 'reverse' )
xlabel('Z (m)')
ylabel('Intensity (a.u.)')
legend('x=0m' , ['x=' num2str(x_interest1) 'm'], ['x=' num2str(x_interest2) 'm'])





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




