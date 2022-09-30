function runImageSaver(user_entered_name, image_type,measurement_state,app)

% open config file:
fullpath = mfilename('fullpath');
filename = [fullpath(1:end-13),'satyendra\configs\image_saver_config_local.json'];
fid = fopen(filename); % Opening the file
raw = fread(fid,inf); % Reading the contents
str = char(raw'); % Transformation
fclose(fid); % Closing the file
data = jsondecode(str); % Using the jsondecode function to parse JSON from string

% configure MATLAB to support anaconda3
pyExec = data.MATLAB_config;
pyRoot = fileparts(pyExec);
p = getenv('PATH');
p = strsplit(p, ';');
addToPath = {
    pyRoot
    fullfile(pyRoot, 'Library', 'mingw-w64', 'bin')
    fullfile(pyRoot, 'Library', 'usr', 'bin')
    fullfile(pyRoot, 'Library', 'bin')
    fullfile(pyRoot, 'Scripts')
    fullfile(pyRoot, 'bin')
    };
p = [addToPath(:); p(:)];
p = unique(p, 'stable');
p = strjoin(p, ';');
setenv('PATH', p);

% write arguments to the .txt file
argument_directory = data.arg_dir;
writelines(user_entered_name, argument_directory, WriteMode="overwrite");
writelines(image_type, argument_directory, WriteMode="append");
writelines(measurement_state, argument_directory, WriteMode="append");

% execute python script(s) here
!conda activate base
!python -u "C:\Users\huanium\huanium\MIT_PhD\BEC1\Software\Image_Browser\satyendra\scripts\image_saver_script.py"

% the python execution creates my_watchdog object
% now let MATLAB take care of the while loop:
%%%


while true
    if ~strcmp(app.measurement_state,'off') % while STOP is NOT pressed
        !python -u "C:\Users\huanium\huanium\MIT_PhD\BEC1\Software\Image_Browser\satyendra\scripts\image_saved_status.py"
        pause(2)
    else % if STOP button is pressed
        disp('=======================================')
        disp("Trying to save the last images...")
        !python -u "C:\Users\huanium\huanium\MIT_PhD\BEC1\Software\Image_Browser\satyendra\scripts\image_saved_status.py"
        disp("Success!")
        break
    end
end

if strcmp(user_entered_name,'dryrun')
    !python -u "C:\Users\huanium\huanium\MIT_PhD\BEC1\Software\Image_Browser\satyendra\scripts\shutil_task.py"
end
disp('Finally')


end