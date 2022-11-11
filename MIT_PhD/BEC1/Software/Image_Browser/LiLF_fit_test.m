clear all
close all

rows = 256;
columns = 250;
totalLiLF = zeros(rows, columns);

noiseAmp = 0.0;
N = 5;

hor = 1:1:columns;
vert = 1:1:rows;

% generate some data...
% this step won't be necessary with real images
q = 0.05;
rho = rows/2;

for i = 1:rows
    for j = 1:columns
        totalLiLF(i,j) = 3.*approx_polylog(2, exp(q - ((i - round(columns/2)+50).^2/rho^2 + (j-round(rows/2)).^2/rho^2).*f(exp(q))), N)./approx_polylog(2, exp(q) ,N) + noiseAmp*rand(1,1);
        
        % simulate flat top capped at OD = 5
        if totalLiLF(i,j) >= 3
            totalLiLF(i,j) = min(totalLiLF(i,j), 5) + noiseAmp*rand(1,1);
        end
    end
end

% just an image of the ODT 
figure(1)
image(totalLiLF,'CDataMapping','scaled');
axis image
ax = gca;
colormap(gray(32768));
ax.CLim = [0, 1.3];

% to find the center from horizontal dist:
% find sum of matrix columns (integrate along y)
totalLiLF_columns_summed = sum(totalLiLF, 1);

% now fit something to this to find center in the y-direction:
% now do gaussian fit this data to find the horizontal center:
horizontal_center_find = fit(hor.', totalLiLF_columns_summed.', "gauss1");
coefs = coeffvalues(horizontal_center_find);
horizontal_center = round(coefs(2));
disp(horizontal_center_find)

figure(3)
plot(horizontal_center_find, hor, totalLiLF_columns_summed);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% one horizontal center found, get a veritical cut at that center:
n = 10;
center_vertical_slice = 0;
for i = -n:1:n
    center_vertical_slice = center_vertical_slice + totalLiLF(:, horizontal_center + i)/(2*n+1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% now fit this data with LiLF_fit_func

tf = excludedata(vert.', center_vertical_slice, 'range', [0.001 Inf]);

fitfunc = fittype(@(a,b,c,d,e,x) a + b*approx_polylog(2, exp(c - ((x-e).^2/d.^2)*f(exp(c))), 5)/approx_polylog(2, exp(c), 5), ...
    'independent','x','dependent','z');

% note that StartPoint's order is alphabetical
LiLF_fit = fit(vert.', center_vertical_slice, fitfunc, ...
    'StartPoint', [0.0, 3, q, rho, 100]);

figure(5)
plot(LiLF_fit,vert,center_vertical_slice);
disp(LiLF_fit)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% EXTRA FUNCTIONS %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function f = f(x)
    f = ((1+x)./x).*log(1+x);
end


