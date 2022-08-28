function endImageSaver(user_entered_name, image_type,measurement_state)

% configure MATLAB to support anaconda3
% this part is machine-dependent
pyExec = 'C:\Users\huanium\anaconda3\';
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

% write arguments to .txt file
fullpath = mfilename('fullpath');
filename = [fullpath(1:end-13),'image_saver_arguments.txt'];
writelines(user_entered_name, filename, WriteMode="overwrite");
writelines(image_type, filename, WriteMode="append");
writelines(measurement_state, filename, WriteMode="append");

% execute command here
!exit()

end