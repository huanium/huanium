%%% Author: Huan Q. Bui
%%% Colby College '21
%%% Date: Aug 07, 2020


if max(size(gcp)) == 0 % parallel pool needed
   parpool('local',2); % create the parallel pool
end

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

X = -70:1:70;
Y = -70:1:70;

[II,JJ] = meshgrid(X,Y);
H = zeros(length(II),length(JJ));
for r = 1:length(II)
   for c = 1:length(JJ)
        H(r,c) = Hxy(II(1,r), JJ(c,1) );
        disp(['Calculated: ' num2str((r-1)*c + c) ' out of ' num2str(length(II)*length(JJ))]);
   end
end
% add contour underneath
%h = surfc(II,JJ,H);
h = surf(II,JJ,H);
set(h, 'edgealpha',0.2, 'facealpha',0.75)
xlabel('X', 'FontSize',16);
ylabel('Y', 'FontSize',16);
title('Re(H)', 'FontSize', 16 );
colorbar;

%%%%%%%%%%%%%%%%%%%
% clock ends
Duration = seconds(round(toc));
Duration.Format = 'hh:mm:ss';
disp(['Time taken : ' char(Duration)]);
disp(['Time in sec: ' num2str(toc)]);
disp(' ');
% clock ends
%%%%%%%%%%%%%%%%%%%



% -- Integration --

function Hxy = Hxy(II,JJ)
xmin = -11;
xmax = -xmin;
ymin = xmin;
ymax = xmax;
t = 1000;
d=2;
muE = 1/2+1/4;
% note: the following definitions of "fun" are equivalent under change of vars
fun = @(x,y) cos( (-II.*x./(t^(1/2)) - JJ.*y./(t^(1/4))) - y.^4/96 + x.*y.^2/96 - x.^2/24);
%fun = @(x,y) cos( -II.*x - JJ.*y - t*y.^4/96 + t*x.*y.^2/96 - t*x.^2/24);
Hxy = (t^(-muE)/(2*pi)^d)*integral2(fun, xmin,xmax, ymin, ymax, 'AbsTol',1e-4, 'RelTol',1e-4);
end

