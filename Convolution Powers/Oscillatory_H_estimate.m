%% Author: Huan Q. Bui
%% Colby College '21
%% Date: Aug 07, 2020
%%

if max(size(gcp)) == 0 % parallel pool needed
   parpool('local',2); % create the parallel pool
end

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

X = -10:1:10;
Y = -10:1:10;

[II,JJ] = meshgrid(X,Y);
H = zeros(length(II),length(JJ));
for r = 1:length(II)
   for c = 1:length(JJ)
        H(r,c) = Hxy(II(1,r), JJ(c,1) );
   end
end
surfc(II,JJ,H);
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
fun = @(x,y) cos( (-II.*x./(1000^(1/2)) - JJ.*y./(1000^(1/4))) - y.^4/96 + x.*y.^2/96 - x.^2/24);
Hxy = integral2(fun, xmin,xmax, ymin, ymax, 'AbsTol',1e-4, 'RelTol',1e-4);
end

