function [] = setVelocity(s,driver,motor,velocity)
%allowed velocity between minimum possible velocity (default 8) - 2e3 Hz
    velocity = num2str(velocity);
    fprintf(s,['vel ',driver,' ',motor,' ',velocity]);
end