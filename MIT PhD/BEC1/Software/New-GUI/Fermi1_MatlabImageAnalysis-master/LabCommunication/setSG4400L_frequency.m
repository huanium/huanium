function [] = setSG4400L_frequency(frequency, AOMserialport)
% set(s,'BaudRate',115200);
% s.TimeOut = 100e-3;

% fprintf(AOMserialport,'FREQ:CW?');
% fscanf(AOMserialport)

fprintf(AOMserialport,['FREQ:CW ', num2str(frequency),'MHZ']);

% fprintf(AOMserialport,'POWER -10');%unit in dBm

% fprintf(AOMserialport,'*SAVESTATE');

% fprintf(AOMserialport,'*EXTREF?');
% fscanf(AOMserialport);




% fprintf(AOMserialport,'*UNITNAME TiSa_lock');%name the unit 
% fprintf(AOMserialport,'*UNITNAME?');
% fscanf(AOMserialport)

% fclose(AOMserialport)

end