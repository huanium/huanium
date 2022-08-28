function [s] =  connectToPicomotor(COM_port)
%check under Devices which COM port the picomotor is under
    s = serial(COM_port);
    set(s,'BaudRate',19200,'Terminator','CR','timeout',.5)
    fopen(s)
%     fprintf(s,'def')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%enable to verify that picomotor is connected. Should return firmware
%version 1.6.0
    %fprintf(s,'ver')
    %fscanf(s)
end