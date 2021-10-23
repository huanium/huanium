function movePicoMotor(numMotor,numSteps)
% A = 0, B = 1, C = 2
%     disp(datetime);
    serialObject = connectToPicomotor('COM3');
    pause(0.2);
    moveRelative(serialObject,'a1',numMotor,numSteps);
    pause(0.1);
    fprintf(serialObject,'chl');
    pause(0.1);
    disp([datestr(datetime) ' ' fscanf(serialObject)]);
    pause(0.1);
    fclose(serialObject);
    delete(serialObject);
    
end