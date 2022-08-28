function [] = moveRelative(s,driver,motor,stepSize)
%moves motor by stepSize
%variable motor should be entered as a string, e.g. motor m1
%is denoted '1'
    stepSize = num2str(stepSize);
%     fprintf(s,['chl a1 = ',motor]); %set active motor
    
    fprintf(s,strcat('chl a1=',num2str(motor))); %set active motor
% 

    pause(0.2);
    fprintf(s,['rel ',num2str(driver),' ',stepSize,' g']);
end