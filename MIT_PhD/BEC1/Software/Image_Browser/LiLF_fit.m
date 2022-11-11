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

% figure(1)
% plot(horizontal_center_find, hor, totalLiLF_columns_summed);

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

% figure(5)
% plot(vertical_center_find, vert, center_vertical_slice)


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

% thomas-fermi fit:
fitfunc = fittype(@(a,b,c,d,x) a + b.*max(1-((x-d).^2)/c.^2,0).^(3/2), ...
    'independent','x','dependent','z');

% note that StartPoint's order is alphabetical
LiLF_fit = fit(vert.', center_vertical_slice, fitfunc, ...
    'StartPoint', [0.0, cutoff, rho_guess, vertical_center],'Exclude', bad_region);

LiLF_coefs = coeffvalues(LiLF_fit);

LiLF_fit_model = LiLF_coefs(1) + LiLF_coefs(2).*max(1-((vert-LiLF_coefs(4)).^2)/LiLF_coefs(3).^2,0).^(3/2);

vert_plot = app.Ymax_LiLF.Value - vert;

cla(app.UIAxes_LiLF)
h4 = plot(app.UIAxes_LiLF, vert_plot, LiLF_fit_model, 'DisplayName', 'TF fit', 'Color','r' );
hold(app.UIAxes_LiLF, 'on')
h5 = plot(app.UIAxes_LiLF, vert_plot, center_vertical_slice, '.', ...
    'MarkerEdgeColor','b','MarkerFaceColor','b', 'DisplayName', 'OD');
h1=xline(app.UIAxes_LiLF, app.Ymax_LiLF.Value- yhigh_bad_index, 'DisplayName','y_{high} cutoff');
h2=xline(app.UIAxes_LiLF, app.Ymax_LiLF.Value- ylow_bad_index,'DisplayName','y_{low} cutoff');
h3=yline(app.UIAxes_LiLF, cutoff,'DisplayName','cutoff');
l = legend(app.UIAxes_LiLF, [h1 h2 h3 h4 h5]);
l.FontSize = 6;
l.ItemTokenSize = [5 10];
% app.UIAxes_BEC.XLim = [app.Ymin_LiLF.Value  app.Ymax_LiLF.Value];
app.UIAxes_BEC.YLim = [min(LiLF_fit_model)-0.1  max(LiLF_fit_model)+0.1];
hold(app.UIAxes_LiLF, 'off')

disp(LiLF_fit)

app.TF_diam.Value = round(LiLF_coefs(3)*2);
app.Th_F_Li_count.Value = (app.PixelSize.Value/app.CrossSection.Value)*(pi/3)*(LiLF_coefs(3)^2)*LiLF_coefs(2);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% EXTRA FUNCTIONS %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function f = f(x)
    f = ((1+x)./x).*log(1+x);
end