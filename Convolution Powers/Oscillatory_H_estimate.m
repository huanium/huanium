%%% Author: Huan Q. Bui
%%% Colby College '21
%%% Date: Aug 07, 2020


% if max(size(gcp)) == 0 % parallel pool needed
%    parpool('local',2); % create the parallel pool
% end

%%%%%%%%%%%%%%%%%%%
% clock starts
tic 
% clock starts
%%%%%%%%%%%%%%%%%%%

X = -75:1:75;
Y = -75:1:75;

% integrate over [-bd,bd]x[-bd,bd]
bd  = 12;
% define \tau for renormalized integral
tau = 130;
% dilation factor
t = 4000;
%dimension
d=2;
% trace of E
muE = 1/2+1/4;


[II,JJ] = meshgrid(X,Y);
H = zeros(length(II),length(JJ));
R = length(II);
C = length(JJ);
for r = 1:R
   parfor c = 1:C
        H(r,c) = Hxy(II(1,r), JJ(c,1), bd, tau ,t , d, muE );
        disp(['Calculated: ' num2str((r-1)*C + c) ' out of ' num2str(R*C)]);
        % for parfor computing
        %disp(['Calculated rows: ' num2str(r) ' out of ' num2str(length(II))])
   end
end
% add contour underneath
%h = surfc(II,JJ,H);


h = surf(II,JJ,H);
set(h, 'LineWidth',0.1,'edgecolor','black', 'EdgeAlpha', 0.15 , 'FaceAlpha',1);
xlabel('x', 'FontSize',14);
ylabel('y', 'FontSize',14);
% title('Re(H)', 'FontSize', 16 );
% colorbar;

% Evan's configs
%axis([-50 50 -50 50])
%axis([-50 50 -50 50 -0.008 0.008])
axis([-75 75 -75 75 -0.007 0.007])
view(44,12)


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

function Hxy = Hxy(II,JJ, bd, tau ,t , d, muE )

% note: the following definitions of "fun" are equivalent under change of vars
% we're only interested in the real part, so just do Cos() for this example
% since we only have iQ, ie things in the exp is purely imaginary
fun = @(x,y) cos( (-II.*x.*(t^(-1/2)) - JJ.*y.*(t^(-1/4))) - x.^2/24 + x.*y.^2./96 - y.^4/96);
%fun = @(x,y) (abs(x.^2/24 - x.*y.^2./96 + y.^4/96) < tau).*...%
%   cos( (-II.*x.*(t^(-1/2)) - JJ.*y.*(t^(-1/4))) - x.^2/24 + x.*y.^2./96 - y.^4/96); %...
%        + 1i*sin( (-II.*x.*(t^(-1/2)) - JJ.*y.*(t^(-1/4))) - x.^2/24 + x.*y.^2./96 - y.^4/96);

% no need to call real() here 
Hxy = (t^(-muE)/(2*pi)^d)*integral2(fun,-bd,bd,-bd,bd, 'AbsTol',1e-4, 'RelTol',1e-4);

end



%%%%%% Mathematica code for finding \tau:

%FindMaximum[{x^2/24 - x*y^2/96 + y^4/96, {x, y} \[Element] 
%   Rectangle[{-11, -11}, {11, 11}]}, {x, y}]
