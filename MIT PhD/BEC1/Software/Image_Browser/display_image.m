function display_image(app)

% read the fits file
img = fitsread(fullfile(app.ImageFolder.Value,app.FileSelected.Value), 'primary');
frame_type = app.FrameType.Value;


if frame_type == "OD"
    frame = real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
    
    min = app.MinEditField.Value;
    max = app.MaxEditField.Value;
    image(frame,'Parent',app.UIAxes,'CDataMapping','scaled');
    colormap(app.UIAxes,gray(32768));
    app.UIAxes.CLim = [min, max];
    
else
    if frame_type == "FakeOD"
        frame=real(((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
        
        min = app.MinEditField.Value;
        max = app.MaxEditField.Value;
        image(frame,'Parent',app.UIAxes,'CDataMapping','scaled');
        colormap(app.UIAxes,gray(32768));
        app.UIAxes.CLim = [min, max];
        
    else
        if (frame_type == "With atoms")
            frame=img(:,:,1);
            image(frame,'Parent',app.UIAxes,'CDataMapping','direct');
            colormap(app.UIAxes,gray(32768));
        elseif (frame_type == "Without atoms")
            frame=img(:,:,2);
            image(frame,'Parent',app.UIAxes,'CDataMapping','direct');
            colormap(app.UIAxes,gray(32768));
        elseif (frame_type == "Dark")
            frame=img(:,:,3);
            image(frame,'Parent',app.UIAxes,'CDataMapping','direct');
            colormap(app.UIAxes,gray(32768));
        else
            frame=real(-log((img(:,:,1)-img(:,:,3))./(img(:,:,2)-img(:,:,3))));
            min = app.MinEditField.Value;
            max = app.MaxEditField.Value;
            image(frame,'Parent',app.UIAxes,'CDataMapping','scaled');
            colormap(app.UIAxes,gray(32768));
            app.UIAxes.CLim = [min, max];
        end
    end
    
end

% image display settings
set(app.UIAxes,'DataAspectRatioMode','manual','DataAspectRatio',[1 1 1],'YDir','normal') ;
[y_limit, x_limit, frame_number] = size(img);
app.UIAxes.XLim = [0 x_limit];
app.UIAxes.YLim = [0 y_limit];



end