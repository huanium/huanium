function [] = setAcceleration(s,driver,motor,accel)
%allowed accel between 16 - 2e4 steps/sec^2
    accel = num2str(accel);
    fprintf(s,['acc ',driver,' ',motor,' ',accel]);
end
