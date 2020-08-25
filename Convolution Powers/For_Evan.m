%% From: Huan Q. Bui
%% To: Evan Randles
%% Date: Aug 20, 2020
%%

if max(size(gcp)) == 0 % parallel pool needed
   parpool('local',2); % create the parallel pool
end

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

% grid of (a,b)
% format:   start:step:end
a = 10:10:1000;
b = 10:10:1000;
[aa,bb] = meshgrid(a,b);

% initialize AbsH
AbsH = zeros(length(aa),length(bb));

% at each point (a,b), compute \int h(a,b,u)
for r = 1:length(aa)
   for c = 1:length(bb)
        AbsH(r,c) = abs(h(aa(1,r), bb(c,1)));
        disp(['Evaluations: ' num2str((r-1)*length(a) + c) ' out of ' num2str(length(a)*length(b))]);
   end
end

% plot 
surfc(aa,bb,AbsH,'LineWidth',0.1,'edgecolor','black', 'FaceAlpha', 0.7);
xlabel('a', 'FontSize',16);
ylabel('b', 'FontSize',16);
title('Amplitude of h', 'FontSize', 16 );
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

function h = h(aa,bb)
% try umin = -1 or umin = -1/2
umin = -1;
umax = -umin;
fun = @(u) abs( ( 6*aa.*u.^2 + 2*bb.*u.^3/sqrt(1-u.^4) ) ./ ((-2*aa.*u.^3 + bb.*sqrt(1 - u.^4) ).^2));
h = integral(fun, umin, umax, 'AbsTol',1e-4, 'RelTol', 1e-4);
end



