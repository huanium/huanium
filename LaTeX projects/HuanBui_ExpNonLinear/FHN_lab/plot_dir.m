function [h1, h2] = plot_dir (vX, vY)

rMag = 5;
% Length of vector
lenTime = length(vX);
% Indices of tails of arrows
vSelect0 = 40:30:(lenTime-1);
% Indices of tails of arrows
vSelect1 = vSelect0 + 1;
% X coordinates of tails of arrows
vXQ0 = vX(vSelect0, 1);
% Y coordinates of tails of arrows
vYQ0 = vY(vSelect0, 1);
% X coordinates of heads of arrows
vXQ1 = vX(vSelect1, 1);
% Y coordinates of heads of arrows
vYQ1 = vY(vSelect1, 1);
% vector difference between heads & tails
vPx = (vXQ1 - vXQ0) * rMag;
vPy = (vYQ1 - vYQ0) * rMag;
% make plot 
h1 = plot (vX, vY); hold on;
% add arrows 
h2 = quiver (vXQ0, vYQ0, vPx, vPy, 0, 'black'); grid off; hold off