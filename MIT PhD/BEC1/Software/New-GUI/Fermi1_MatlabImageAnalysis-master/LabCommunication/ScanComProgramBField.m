% Find a serial port object.
myExternalCOM = instrfind('Type', 'serial', 'Port', 'COM11', 'Tag', '');

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
lastField = 80.3;
while true    
    newFieldString = fscanf(myExternalCOM);
    if ~isempty(newFieldString) 
        tic
        newFieldNum = str2num(newFieldString);
        % compare with last field value
        if ~isempty(newFieldNum) && newFieldNum ~= lastField 
            programFBSetPointOnAWG_FBFieldDriftCompensated([60,80.3,newFieldNum],[10,200,5,0.01,20000])
            lastField = newFieldNum;
        end
        toc
        
        fprintf(['new field programmed: ' newFieldString ' G; ' datestr(datetime(now,'ConvertFrom','datenum')) '\n'])
    else
        fprintf(['last field: ' num2str(lastField) ' G; aBF = ' num2str(FBresonanceLandscapeRefined('Binterest',lastField)) ' aBohr  ' datestr(datetime(now,'ConvertFrom','datenum')) '\n' ])
    end
end

%% Disconnect and Clean Up
% Disconnect from instrument object, obj1.
fclose(myExternalCOM);
warning('on','MATLAB:serial:fscanf:unsuccessfulRead')
