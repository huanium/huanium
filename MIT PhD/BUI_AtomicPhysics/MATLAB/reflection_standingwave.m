% author: Huan Q. Bui
% Jun 25, 2021
% Decaying standing wave (optical lattice) due to 
%   interference of counter-propagating gaussian beams


clear
close all

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

% %%% All lengths are in microns.
% res_Z = 10; % increases resolution by factor of length_scale
% res_X = 30;
% x_bound = 400;
% z_bound = 50;
% x = -x_bound:1/res_X:x_bound;
% z = -z_bound:1/res_Z:0;
% [X, Z] = meshgrid(x, z);
% k = 2*pi/(1.064); % wavelength is 1064 nm.
% theta_inc = -5*pi/180; % incidence angle 
% theta_ret = -5*pi/180; % retro-reflected angle 
% % recall that FWHM = 1.18 * radius @ (1/e^2) intensity
% width = 35; % beam width
% w = 35/1.18;
% A = 1; % field amplitude

% % ideally, theta_inc = theta_ret. 
% % if not, the z-lattice will be messed up (very sensitive)
% % "left" side: incoming beam (incident) + retro reflected (reflected)
% left = @(x,z) A*exp(-(sin(theta_inc).*x + cos(theta_inc).*z).^2/w^2).*exp(+1i*k*(cos(theta_inc).*x-sin(theta_inc).*z))...
%     + A*exp(-(sin(theta_ret).*x+cos(theta_ret).*z).^2/w^2).*exp(-1i*k*(cos(theta_ret).*x-sin(theta_ret).*z));
% 
% % "right" side retro reflected (incoming) + incoming beam (reflected)
% right = @(x,z) A*exp(-(sin(pi-theta_inc).*x + cos(pi-theta_inc).*z).^2/w^2).*exp(+1i*k*(cos(pi-theta_inc).*x-sin(pi-theta_inc).*z))...
%     + A*exp(-(sin(pi-theta_ret).*x+cos(pi-theta_ret).*z).^2/w^2).*exp(-1i*k*(cos(pi-theta_ret).*x-sin(pi-theta_ret).*z));
% 
% pattern = abs(left(X,Z)+right(X,Z)).^2;
% 
% h = figure(1);
% 
% % top view
% subplot(3,1,1)
% surf(X,Z,pattern, 'LineStyle', 'none', 'EdgeAlpha', 0 , 'FaceAlpha',1);
% view([0,90])
% %colormap('gray');
% h.Position = [100 100 800 800];
% xlabel('X (microns)')
% ylabel('Z (microns)')
% title({['Gaussian beam width: ' num2str(width) ' microns, Wavelength: ' num2str(1000*2*pi/k) ' nm'],...
%     ['Incoming incident angle: ' num2str(-theta_inc*180/pi)...
%     ' degs, Retro-reflected incident angle: ' num2str(-theta_ret*180/pi) ' degs']})
% 
% % side view
% subplot(3,1,2)
% surf(X,Z,pattern, 'LineStyle', 'none', 'EdgeAlpha', 0 , 'FaceAlpha',1);
% view([270,0])
% %colormap('gray');
% title('Side view');
% xlabel('X (microns)')
% ylabel('Z (microns)')
% zlabel('Intensity (a.u.)')

% % slice at x = 0
% subplot(3,1,3)
% x0_data = pattern(:,floor(x_bound*res_X));
% plot(z,x0_data);
% title('Intensity profile across x = 0.')
% set ( gca, 'xdir', 'reverse' )
% xlabel('Z (microns)')
% ylabel('Intensity (a.u.)')












%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ');
% clock ends
%%%%%%%%%%%%%%%%%%%












%%%%% Real Gaussian profiles %%%%%%%%%%%%%

global wavelength; % wavelength
global w0; % beam waist
global A0; % electric field amplitude
global zR; % Rayleigh range
global n; % index of refraction of air
global theta; % beam divergence
global z_focus; % z-position of waist





%%%%% SETTING UP %%%%%
wavelength= 1064e-9; % in meters
w0 = 10e-6; % beam waist in meters
A0 = 20; % arbitrary...
n = 1; % of air
zR = pi*w0^2*n/wavelength;
theta = wavelength/(n*w0); % beam divergence, in rads
theta_inc = (90-5)*pi/180; % 5 degs from horizontal
z_focus = 200e-6; 

% input range 
res_Z = 5e-7; % resolution Z
res_X = 5e-7; % resolution X
x_bound = 400e-6;
z_bound = 40e-6;
x = -x_bound:res_X:x_bound;
z = -z_bound:res_Z:z_bound;
[X, Z] = meshgrid(x, z);

Efield = @E;

% rotate coords, then make E field (incoming)
% incoming beam, start with original w0 and zR
E_inc = Efield(w0, zR, new_X(X,Z,theta_inc),new_Z(X,Z,theta_inc));
% flip E_inc up-down --> to get reflection at horizon
E_inc_Refl = flipud(E_inc); 

% retro beam: how to calculate?
E_ret = Efield(w0, zR, new_X(X,Z,-theta_inc),new_Z(X,Z,-theta_inc));;
% calculate the reflection of retro beam
E_ret_Refl = flipud(E_ret);

pattern = abs(E_inc + 0*E_inc_Refl + E_ret + 0*E_ret_Refl).^2;

h = figure(1);
% top view
surf(X,Z,pattern, 'LineStyle', 'none', 'EdgeAlpha', 0 , 'FaceAlpha',1);
%ylim([-z_bound 0]); % this sets the 'Z' bound...
view([0,90])
%h.Position = [100 100 800 800];
xlabel('X (m)')
ylabel('Z (m)')
%title({['Gaussian beam width: ' num2str(width) ' microns, Wavelength: ' num2str(1000*2*pi/k) ' nm'],...
%    ['Incoming incident angle: ' num2str(-theta_inc*180/pi)...
%    ' degs, Retro-reflected incident angle: ' num2str(-theta_ret*180/pi) ' degs']})





%%%%% FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%



% rotation in the X-Z plane to do incidence
function new_X = new_X(X,Z,theta)
    new_X = cos(theta).*X - sin(theta).*Z;
end

function new_Z = new_Z(X,Z,theta)
    new_Z = sin(theta).*X + cos(theta).*Z;
end


% complex beam parameter function
function beam_parameter_q = q(z)
    % global wavelength
    % global n
    global z_focus
    global zR
    % beam_parameter_q = 1/(1/R(z) - 1i*wavelength/(n*pi*w(z)^2));
    beam_parameter_q = (z-z_focus) + 1i*zR; % equivalent defn
end

% Electric field function in cylindrical coords
% The Gouy phase is already included in this defn
% see page 8/44 of 
% http://ecee.colorado.edu/~ecen5616/WebMaterial...
% .../24%20Gaussian%20beams%20and%20Lasers.pdf
function E_field = E(w0, zR, x,z)
    global A0
    global wavelength
    k = 2*pi/wavelength;
    % electric field in 1 transverse dimension only 
    E_field = 1i.*A0.*sqrt(1./(sqrt(pi).*w0)).*(zR./q(z))...
        .*exp(-1i.*k.*x.^2./(2.*q(z))-1i.*k.*z);
end




















