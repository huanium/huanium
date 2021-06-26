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

%%% All lengths are in microns.
res_Z = 10; % increases resolution by factor of length_scale
res_X = 30;
x_bound = 400;
z_bound = 50;
x = -x_bound:1/res_X:x_bound;
z = -z_bound:1/res_Z:0;
[X, Z] = meshgrid(x, z);
k = 2*pi/(1.064); % wavelength is 1064 nm.
theta_inc = -5*pi/180; % incidence angle 
theta_ret = -5*pi/180; % retro-reflected angle 
% recall that FWHM = 1.18 * radius @ (1/e^2) intensity
width = 35; % beam width
w = 35/1.18;
A = 1; % field amplitude

% ideally, theta_inc = theta_ret. 
% if not, the z-lattice will be messed up (very sensitive)

% "left" side: incoming beam (incident) + retro reflected (reflected)
left = @(x,z) A*exp(-(sin(theta_inc).*x + cos(theta_inc).*z).^2/w^2).*exp(+1i*k*(cos(theta_inc).*x-sin(theta_inc).*z))...
    + A*exp(-(sin(theta_ret).*x+cos(theta_ret).*z).^2/w^2).*exp(-1i*k*(cos(theta_ret).*x-sin(theta_ret).*z));

% "right" side retro reflected (incoming) + incoming beam (reflected)
right = @(x,z) A*exp(-(sin(pi-theta_inc).*x + cos(pi-theta_inc).*z).^2/w^2).*exp(+1i*k*(cos(pi-theta_inc).*x-sin(pi-theta_inc).*z))...
    + A*exp(-(sin(pi-theta_ret).*x+cos(pi-theta_ret).*z).^2/w^2).*exp(-1i*k*(cos(pi-theta_ret).*x-sin(pi-theta_ret).*z));

pattern = abs(left(X,Z)+right(X,Z)).^2;

h = figure(1);

% top view
subplot(3,1,1)
surf(X,Z,pattern, 'LineStyle', 'none', 'EdgeAlpha', 0 , 'FaceAlpha',1);
view([0,90])
%colormap('gray');
h.Position = [100 100 800 800];
xlabel('X (microns)')
ylabel('Z (microns)')
title({['Gaussian beam width: ' num2str(width) ' microns, Wavelength: ' num2str(1000*2*pi/k) ' nm'],...
    ['Incoming incident angle: ' num2str(-theta_inc*180/pi)...
    ' degs, Retro-reflected incident angle: ' num2str(-theta_ret*180/pi) ' degs']})

% side view
subplot(3,1,2)
surf(X,Z,pattern, 'LineStyle', 'none', 'EdgeAlpha', 0 , 'FaceAlpha',1);
view([270,0])
%colormap('gray');
title('Side view');
xlabel('X (microns)')
ylabel('Z (microns)')
zlabel('Intensity (a.u.)')

% slice at x = 0
subplot(3,1,3)
x0_data = pattern(:,floor(x_bound*res_X));
plot(z,x0_data);
title('Intensity profile across x = 0.')
set ( gca, 'xdir', 'reverse' )
xlabel('Z (microns)')
ylabel('Intensity (a.u.)')




%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ');
% clock ends
%%%%%%%%%%%%%%%%%%%



















