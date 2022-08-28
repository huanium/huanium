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

% execute python script(s) here
!conda activate base
!python "C:\Users\huanium\huanium\MIT PhD\BEC1\Software\Image_Browser\satyendra\scripts\image_saver_script.py"