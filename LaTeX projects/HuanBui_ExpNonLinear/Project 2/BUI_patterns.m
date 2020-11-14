% courtesy of 
% https://blogs.mathworks.com/graphics/2015/03/16/how-the-tiger-got-its-stripes/

writerObj = VideoWriter('brusselator');
open(writerObj);


% oscillatory
dU = 6;
B= 11;
dV = 10; % this should be fixed
A= 3; % this should be fixed


%spots
% dV = 10; % should be fixed
% A = 3; % should be fixed
% dU = 5;
% B = (1+A*sqrt(dU/dV))^2*(1+0.01);
%B = 11;


% stripes
% dV = 10; % should be fixed
% A = 3; % should be fixed
% dU = 4.6;
% B = (1+A*sqrt(dU/dV))^2*(1+0.32);


% stripes
% dV = 10; % should be fixed
% A = 3; % should be fixed
% dU = 4.7;
% B = (1+A*sqrt(dU/dV))^2*(1+0.32);



% Size of grid
width = 400;
dt = 0.005;
t=0;
stoptime = 170;
alpha = 0.0;
f = 0.44;

[t, U, V] = initial_conditions(width, A, B);

axes('Position',[0 0 1 1])
axis off
% Add a scaled-color image
figure(1);
hi = image(U);
hi.CDataMapping = 'scaled';
colormap gray

% And a text object to show the current time.
ht = text(5,width-5,'Time = 0');
ht.Color = [.95 .2 .8];
drawnow

tic
n_frames = 1;
loop_count = 100;
filename = 'patterns.gif';
while t<stoptime
    % can add time dependence later
    
    % brusselator
    U = U + (dU*laplacian(U) + A - (B+1).*U + V.*U.^2 + alpha*cos(2*pi*t))*dt; 
    V = V + (dV*laplacian(V) + B.*U - V.*U.^2)*dt;

    % FitzHugh
    % I = 0.1
    % A = ???
    % B = ???
    %U = U + (U - U.^3/3 - V + 0.1)*dt;
    %V = V + (U + A - B.*V)*dt;

    hi.CData = U;
    t = t+dt;
    ht.String = ['Time = ' num2str(t)];
    drawnow
    % generate GIF
%     im = frame2im(getframe(1));
%     [imind, cm] = rgb2ind(im,4);
%     if n_frames == 1
%         imwrite(imind, cm,filename,'gif','LoopCount',Inf, 'DelayTime',0.01);
%     else
%         imwrite(imind, cm,filename,'gif','WriteMode','append', 'DelayTime',0.01);
%     end
    if loop_count > 10
        writeVideo(writerObj,getframe(1));
        loop_count = 0;
    else
        loop_count = loop_count + 1;
    end
    
    n_frames = n_frames+1;
    
    
end
close(writerObj);
delta = toc;
disp([num2str(nframes) ' frames in ' num2str(delta) ' seconds']);



%%%%%%%%% FUNCTIONS %%%%%%%%%%




function [t, U, V] = initial_conditions(n, A, B)
t = 0;
% Initialize A to random numbers between 0 and 1.
% small, random perturbations from equilibrium solutions
U = A + 4*rand(n);
V = B/A + 4*rand(n);
end
  
% circshift ensures periodic boundary condition
function out = laplacian(in)
out = -in ...
    + .20*(circshift(in,[ 1, 0]) + circshift(in,[-1, 0])  ...
    +      circshift(in,[ 0, 1]) + circshift(in,[ 0,-1])) ...
    + .05*(circshift(in,[ 1, 1]) + circshift(in,[-1, 1])  ...
    +      circshift(in,[-1,-1]) + circshift(in,[ 1,-1]));

end

  
  