s = connectToPicomotor('COM8');

%lower acceleration and velocity settings to reduce hysterisis of the 
% piezo controllers
acceleration = 16;
velocity = 8;
setAcceleration(s,'a1','0',acceleration);
setAcceleration(s,'a1','1',acceleration);
%setAcceleration(s,'a1','2',acceleration)
%fprintf(s,'acc a1')
%fscanf(s)
setVelocity(s,'a1','0',velocity);
setVelocity(s,'a1','1',velocity);
%setVelocity(s,'a1','2',velocity)
%fprintf(s,'vel a1')
%fscanf(s)

moveRelative(s,'a1','0',5);
pause(3)
moveRelative(s,'a1','1',-10);
pause(3)
moveRelative(s,'a1','0',-5);

fclose(s);
delete(s)

    

