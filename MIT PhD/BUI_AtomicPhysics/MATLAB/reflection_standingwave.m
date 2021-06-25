% author: Huan Q. Bui
% Jun 25, 2021
% Decaying standing wave due to 
%   (retro) reflection of "gaussian" beams


clear
close all

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%


%%% All lengths are in microns.

res_Z = 10; % increases resolution by factor of length_scale
res_X = 10;
x_bound = 400;
z_bound = 50;
x = -x_bound:1/res_X:x_bound;
z = -z_bound:1/res_Z:0;
[X, Z] = meshgrid(x, z);
k = 2*pi/(1.064); % set wavenumber to be 1.
theta = -10*pi/180; % incidence angle 
% recall that FWHM = 1.18 * radius @ (1/e^2) intensity
w = 35/1.18; % beam width
A = 1; % field amplitude

% "left" side
left = @(x,z) A*exp(-(sin(theta).*x + cos(theta).*z).^2/w^2).*exp(+1i*k*(cos(theta).*x-sin(theta).*z))...
    + A*exp(-(sin(theta).*x+cos(theta).*z).^2/w^2).*exp(-1i*k*(cos(theta).*x-sin(theta).*z));

% "right" side
right = @(x,z) A*exp(-(sin(pi-theta).*x + cos(pi-theta).*z).^2/w^2).*exp(+1i*k*(cos(pi-theta).*x-sin(pi-theta).*z))...
    + A*exp(-(sin(pi-theta).*x+cos(pi-theta).*z).^2/w^2).*exp(-1i*k*(cos(pi-theta).*x-sin(pi-theta).*z));


pattern = abs(left(X,Z)+right(X,Z)).^2;

h = figure(1);
subplot(2,1,1)
surf(X,Z,pattern, 'LineStyle', 'none', 'EdgeAlpha', 0 , 'FaceAlpha',1);
view([0,90])
%colormap('gray');
h.Position = [100 100 800 500];
xlabel('X (microns)')
ylabel('Z (microns)')
subplot(2,1,2)
surf(X,Z,pattern, 'LineStyle', 'none', 'EdgeAlpha', 0 , 'FaceAlpha',1);
view([270,0])
%colormap('gray');
xlabel('X (microns)')
ylabel('Z (microns)')
zlabel('Intensity (a.u.)')



% res = 10;
% g = figure(2);
% [xq,zq] = meshgrid(-x_bound:1/res:x_bound, -z_bound:1/res:0);
% pattern_interpolated = griddata(x,z,pattern,xq,zq);
% surf(xq,zq,pattern_interpolated, 'LineWidth',0.05,'edgecolor','black', 'EdgeAlpha', 0.05 , 'FaceAlpha',1);
% view([0,90])
% g.Position = [100 100 800 200];
% xlabel('X')
% ylabel('Z')


%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ');
% clock ends
%%%%%%%%%%%%%%%%%%%



















