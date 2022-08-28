function [] = setSG4400L_frequency_sweep
% 200804 need more understnading 
AOMserialport = serial('COM12');
set(AOMserialport,'BaudRate',115200);
AOMserialport.TimeOut = 100e-3;
fopen(AOMserialport);

frequency = 400;
lastFrequency = 300;

% set(s,'BaudRate',115200);
% s.TimeOut = 100e-3;

% fprintf(AOMserialport,'FREQ:CW?');
% fscanf(AOMserialport)

% fprintf(AOMserialport,['FREQ:CW ', num2str(frequency),'MHZ']);

fprintf(AOMserialport,'POWER 0');%unit in dBm

% fprintf(AOMserialport,'*SAVESTATE');

%sweep settings
dwell_time_in_ms = 10;
% freq_start_in_MHz = 100;
% freq_stop_in_MHz = 120;
sweep_points = 1000;
% continuous_sweep = false;​
fprintf(AOMserialport,'SWE:MODE SCAN');
fprintf(AOMserialport,['FREQ:START ', num2str(lastFrequency)]);
fprintf(AOMserialport,['FREQ:STOP ', num2str(frequency)]);
fprintf(AOMserialport,['SWE:POINTS ', num2str(sweep_points)]);
fprintf(AOMserialport,['SWE:DWELL ', num2str(dwell_time_in_ms)]);
fprintf(AOMserialport,sprintf('INIT:CONT %d', false));
fprintf(AOMserialport,'LIST:DIR UP'); %start from freq_start
trig_step = false;
if trig_step == false
    fprintf(AOMserialport,'INIT:IMM');
end

fclose(AOMserialport);

end