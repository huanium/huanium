delete(instrfind);

% Find a serial port object.
myExternalCOM = instrfind('Type', 'serial', 'Port', 'COM11', 'Tag', '');
% AOMserialport = serialport('COM12',115200,'TimeOut',100e-3);
AOMserialport = serial('COM12');
set(AOMserialport,'BaudRate',115200);
AOMserialport.TimeOut = 100e-3;
fopen(AOMserialport);

% Create the serial port object if it does not exist
% otherwise use the object that was found.
if isempty(myExternalCOM)
    myExternalCOM = serial('COM11');
else
    fclose(myExternalCOM);
    myExternalCOM = myExternalCOM(1);
end



%% while true loop
% Connect to instrument object, obj1.
myExternalCOM.Baudrate = 57600;
fopen(myExternalCOM);
warning('off','MATLAB:serial:fscanf:unsuccessfulRead')
myExternalCO.Timeout = 1;
lastField = 78.9;%80.3;
lastAOM = 62.03;%400;
lastPulseTime = 50;%0;
while true
    newFieldString = fscanf(myExternalCOM);    
    if ~isempty(newFieldString) 
        tic
        newNum = sscanf(newFieldString,'B%fAOM%fPulseTime%f')
        newFieldNum = newNum(1);
        newAOM = abs(newNum(2));
        pulseTime = abs(newNum(3));
        
        % compare with last field value
        maxExptTime = 3000;
        minAWGTimestep = 0.01;
        AWG_timesteps = [10,200,5,minAWGTimestep,maxExptTime]; %other timesteps are manually hardcoded to match Cicero words, e.g. SG ramp\
        AWG_timesteps2 = [10,200,5,2,8,minAWGTimestep,maxExptTime];
        if ~isempty(newFieldNum) && newFieldNum ~= lastField 
            %programFBSetPointOnAWG_FBFieldDriftCompensated([60,80.3,newFieldNum],AWG_timesteps)
            %programFBSetPointOnAWG_withSuckingInBeforeJump([60.0,80.3,79.2,newFieldNum],AWG_timesteps2)
            programFBSetPointOnAWG_withSuckingInBeforeJump([60.0,80.3,79.0,newFieldNum],AWG_timesteps2)
            lastField = newFieldNum;
        end
        
        if ~isempty(newAOM) && newAOM ~= lastAOM 
            % AOM programming comman here
            setSG4400L_frequency(newAOM, AOMserialport);
            
            % RF sweep
%             setSG4400L_frequency_sweep(newAOM,lastAOM,AOMserialport);
            
            lastAOM = newAOM;
        end
        
        %TTL for switch 
        
        if ~isempty(pulseTime) && pulseTime ~= lastPulseTime
            %programAWGvoltageRamp('USB0::0x05E6::0x3390::1421789::0::INSTR',pulseTime/1000,[5,0*ones(1,500),5]);
           
            lastPulseTime = pulseTime;
            %programDoubleSTIRAP(1,0.00015,10,20,pulseTime,10)
            %programDoubleSTIRAP_darkMiddle(1,0.00015,10,20,pulseTime,10)
        end
        
        
        toc
        
        fprintf(['new field programmed: ' num2str(newFieldNum) ' G; ' 'new AOM ' num2str(newAOM) 'MHz ' ...
                 'Pulse Duration: ' num2str(lastPulseTime) 'ns   ' datestr(datetime(now,'ConvertFrom','datenum')) '\n'])
    else
        fprintf(['last field: ' num2str(lastField) ' G; aBF = ' num2str(FBresonanceLandscapeRefined('Binterest',lastField)) ' aBohr  ' 'last AOM ' num2str(lastAOM) 'MHz ' ...
                'Pulse Duration: ' num2str(lastPulseTime) 'ns   ' datestr(datetime(now,'ConvertFrom','datenum')) '\n' ])
    end
end

%% Disconnect and Clean Up
% Disconnect from instrument object, obj1.
fclose(myExternalCOM);
fclose(AOMserialport);
warning('on','MATLAB:serial:fscanf:unsuccessfulRead')

function [] = setSG4400L_frequency(frequency, AOMserialport)
% set(s,'BaudRate',115200);
% s.TimeOut = 100e-3;

% fprintf(AOMserialport,'FREQ:CW?');
% fscanf(AOMserialport)

fprintf(AOMserialport,['FREQ:CW ', num2str(frequency),'MHZ']);

fprintf(AOMserialport,'POWER 0');%unit in dBm

fprintf(AOMserialport,'*SAVESTATE');

% fprintf(AOMserialport,'*EXTREF?');
% fscanf(AOMserialport);

% fprintf(AOMserialport,'*UNITNAME TiSa_lock');%name the unit 
% fprintf(AOMserialport,'*UNITNAME?');
% fscanf(AOMserialport)

end


function [] = setSG4400L_frequency_sweep(frequency,lastFrequency, AOMserialport)
% set(s,'BaudRate',115200);
% s.TimeOut = 100e-3;

% fprintf(AOMserialport,'FREQ:CW?');
% fscanf(AOMserialport)

% fprintf(AOMserialport,['FREQ:CW ', num2str(frequency),'MHZ']);

fprintf(AOMserialport,'POWER 0');%unit in dBm

% fprintf(AOMserialport,'*SAVESTATE');

%sweep settings
dwell_time_in_ms = 1;
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

end
