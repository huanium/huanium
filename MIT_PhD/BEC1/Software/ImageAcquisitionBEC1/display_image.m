function display_image(app)

% make axis toolbar visible:
app.UIAxes.Toolbar.Visible = 'off';
app.UIAxes.Toolbar.HandleVisibility = 'on';

% read the fits file
img = fitsread(fullfile(app.Browse.Value,app.FileSelected), 'primary');
frame_type = app.FrameType.Value;

min = app.MinEditField.Value;
max = app.MaxEditField.Value;

X = app.UIAxes.XLim;
Y = app.UIAxes.YLim;

app.XMIN = X(1);
app.XMAX = X(2);
app.YMIN = Y(1);
app.YMAX = Y(2);

scale = single(round(app.BrightnessSlider.Value));
app.BrightnessSlider.Value = double(scale);

if frame_type == "OD"
    frame = real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
    
    image(frame,'Parent',app.UIAxes,'CDataMapping','scaled');
    colormap(app.UIAxes,gray(32768));
    app.UIAxes.CLim = [min, max];
    
else
    if frame_type == "FakeOD"
        frame=real(((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
        
        image(frame,'Parent',app.UIAxes,'CDataMapping','scaled');
        colormap(app.UIAxes,gray(32768));
        app.UIAxes.CLim = [min, max];
        
    else
        if (frame_type == "With atoms")
            frame=img(:,:,1);
            image(frame,'Parent',app.UIAxes,'CDataMapping','direct');            
            colormap(app.UIAxes,gray(2^scale));
        elseif (frame_type == "Without atoms")
            frame=img(:,:,2);
            image(frame,'Parent',app.UIAxes,'CDataMapping','direct');
            colormap(app.UIAxes,gray(2^scale));
        elseif (frame_type == "Dark")
            frame=img(:,:,3);
            image(frame,'Parent',app.UIAxes,'CDataMapping','direct');
            colormap(app.UIAxes,gray(2^scale));
        else
            frame=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
            image(frame,'Parent',app.UIAxes,'CDataMapping','scaled');
            colormap(app.UIAxes,gray(32768));
            app.UIAxes.CLim = [min, max];
        end
    end
    
end

% image display settings
set(app.UIAxes,'DataAspectRatioMode','manual','DataAspectRatio',[1 1 1],'YDir','normal') ;


% now set limits according to the current limits

% if current image size is same as before, then keep zoom perspective
[y_limit, x_limit, frame_number] = size(img);

if (app.oldSizeX == x_limit) && (app.oldSizeY == y_limit)
    app.UIAxes.XLim = [app.XMIN app.XMAX];
    app.UIAxes.YLim = [app.YMIN app.YMAX];
else % else reset zoom
    app.UIAxes.XLim = [0 x_limit];
    app.UIAxes.YLim = [0 y_limit];
end

% check if show mark is on
if app.ShowCheckBox.Value == 1
    % if show mark is ticked, then 
    if not(isempty(app.x_mark_data))
    % if there is mark data, then add mark to image
        hold(app.UIAxes, 'on'); % Don't blow away the image.
        app.mark_plot = plot(app.x_mark_data, app.y_mark_data, 'LineWidth', 2,'Color','green','Parent', app.UIAxes);
    end
end


% set limit to compare to next image
app.oldSizeX = x_limit;
app.oldSizeY = y_limit;
