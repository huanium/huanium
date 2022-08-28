delete(instrfind);
s = serial('COM3');
set(s,'BaudRate',19200);
% s.Terminator = 'CR/LF';
% s.FlowControl = 'software';
s.Timeout = 1;
fopen(s);
disp('s on');
%% 
fprintf(s,'INTERLOCK?');
out = fscanf(s)

%% 
fclose(s);

%%
fprintf(s,'OPMODE?');
out = fscanf(s)

%% turn off sprout
fprintf(s,'OPMODE=on');
fprintf(s,'OPMODE?');
out = fscanf(s)

%% turn on sprout and set power
setpower = 8;
fprintf(s,'OPMODE=on');
fprintf(s,'OPMODE?');
out = fscanf(s)
fprintf(s,['power SET= ' num2str(setpower)]);
fprintf(s,'power SET?');
out = fscanf(s) 


array =[] ;
idx = 1;
while idx <20 
    fprintf(s,'power?');
    newString = fscanf(s);
    newPower = sscanf(newString,'POWER=%f');
    array = [array;newPower];
    figure(1);clf;
    plot(array)
    if newPower > setpower-0.1 && newPower < setpower+0.1
        idx = idx + 1;
    else
        idx = idx;
    end
    idx
end

%%
fprintf(s,'power?');
newString = fscanf(s)
newPower = sscanf(newString,'POWER=%f')

%%
fprintf(s,'WARNING?');
out = fscanf(s)



%%
fprintf(s,'power SET?');
out = fscanf(s) 

%%
fprintf(s,'power SET= 9.5');
fprintf(s,'power SET?');
out = fscanf(s)                                          

%%
fprintf(s,'RUN HOURS?');
out = fscanf(s)

