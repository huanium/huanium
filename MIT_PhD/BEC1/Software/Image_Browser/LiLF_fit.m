function LiLF_fit( img, rho_guess, app )

close all
    
OD=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
% turn nan and inf to 0 so that they don't count
OD(isinf(OD)) = 0.0;
OD(isnan(OD)) = 0.0;
woa=img(:,:,2)-img(:,:,3);
OD(woa<0) = 0.0;
OD(OD<0) = 0.0;

OD_dims = size(OD);
x = OD_dims(1);
y = OD_dims(2);
polyLog_approx_terms = 10;

% find sum of matrix columns (integrate along y)
totalLiLF_columns_summed = sum(OD, 1);

% now fit something to this to find center in the y-direction:
% now do gaussian fit this data to find the horizontal center:
hor = 1:1:y;
vert = 1:1:x;

horizontal_center_find = fit(hor.', totalLiLF_columns_summed.', "gauss1");
coefs = coeffvalues(horizontal_center_find);
horizontal_center = round(coefs(2));
disp(horizontal_center_find)

figure(1)
plot(horizontal_center_find, hor, totalLiLF_columns_summed);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% one horizontal center found, get a veritical cut at that center:
n = 15;
center_vertical_slice = 0;
for i = -n:1:n
    center_vertical_slice = center_vertical_slice + OD(:, horizontal_center + i)/(2*n+1);
end

%figure(2)
%plot(vert, center_vertical_slice)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% fit gaussian over this to get center along y:
vertical_center_find = fit(vert.', center_vertical_slice, "gauss1");
coefs = coeffvalues(vertical_center_find);
vertical_center = round(coefs(2));
disp(vertical_center)

figure(5)
plot(vertical_center_find, vert, center_vertical_slice)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% now fit this data with LiLF_fit_func

% now look at difference between cutoff and data 
% to determine the correct value for cutoff in y
cutoff = app.OD_cutoff_LiLF.Value;
bad_final = excludedata(vert.', center_vertical_slice, 'range', [0.001 cutoff]);
difference = center_vertical_slice - cutoff;
indices = [];
for i=1:length(center_vertical_slice)
    if abs(difference(i)) <=  0.2 % if difference within 0.2
        indices(end+1) = i;
    end
end
if length(indices) > 2 % if data is well-behaved
    ylow_bad_index = min(indices);
    yhigh_bad_index = max(indices);
    % Next, pick the max to be conservative. min() works too
    center_cutoff = max(vertical_center - ylow_bad_index, yhigh_bad_index - vertical_center);
end

bad_center = ~excludedata(vert.', center_vertical_slice, 'domain', [ylow_bad_index  yhigh_bad_index]);
bad_region = bad_final|bad_center;

fitfunc = fittype(@(a,b,c,d,e,x) a + b*approx_polylog(2, exp(c - ((x-e).^2/d.^2)*f(exp(c))), polyLog_approx_terms), ...
    'independent','x','dependent','z');
 
% note that StartPoint's order is alphabetical
LiLF_fit = fit(vert.', center_vertical_slice, fitfunc, ...
    'StartPoint', [0.0, 3, 1, rho_guess, vertical_center], ...
    'Exclude', bad_region);

figure(6)
plot(LiLF_fit,vert, center_vertical_slice);
hold on
xline(yhigh_bad_index)
xline(ylow_bad_index)
yline(cutoff)
hold off
disp(LiLF_fit)

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% EXTRA FUNCTIONS %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function f = f(x)
    f = ((1+x)./x).*log(1+x);
end