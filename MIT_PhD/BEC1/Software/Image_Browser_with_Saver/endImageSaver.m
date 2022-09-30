function endImageSaver(user_entered_name, image_type,measurement_state)

% at this point runImageSaver has already configured MATLAB to work with
% anaconda3. So we can skip that part of the code. Remains to just exit

% write arguments to .txt file
fullpath = mfilename('fullpath');
filename = [fullpath(1:end-13),'image_saver_arguments.txt'];
writelines(user_entered_name, filename, WriteMode="overwrite");
writelines(image_type, filename, WriteMode="append");
writelines(measurement_state, filename, WriteMode="append");

% execute command here
!exit()

end