if max(size(gcp)) == 0 % parallel pool needed
   parpool('local',2); % create the parallel pool
end

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

X = -15:0.5:15;
Y = -15:0.5:15;

[II,JJ] = meshgrid(X,Y);
H = zeros(length(II),length(JJ));
for r = 1:length(II)
   for c = 1:length(JJ)
        H(r,c) = Hxy(II(1,r), JJ(c,1) );
   end
end
surfc(II,JJ,H);
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
xmin = -10;
xmax = -xmin;
ymin = xmin;
ymax = xmax;
fun = @(x,y) cos( (-II.*x./(1000^(1/2)) - JJ.*y./(1000^(1/4))) - y.^4/96 + x.*y.^2/96 - x.^2/24);
Hxy = integral2(fun, xmin,xmax, ymin, ymax, 'AbsTol',1e-4, 'RelTol',1e-4);
end

